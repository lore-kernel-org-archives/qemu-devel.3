Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E886C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5tu-00029e-Df; Tue, 12 Mar 2024 13:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tk-00024m-Kb; Tue, 12 Mar 2024 13:26:45 -0400
Received: from wfout4-smtp.messagingengine.com ([64.147.123.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tZ-0005NT-L3; Tue, 12 Mar 2024 13:26:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id 97B2D1C000A3;
 Tue, 12 Mar 2024 13:26:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 12 Mar 2024 13:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1710264389; x=
 1710350789; bh=bpZlDmHeeYMkGRSBKslj+yLQcGqHxFo5l8rTXgouWhU=; b=V
 JZCYAzOlGhPjzsdq5CXt611VrC4LTuW+QBaY9TJ3NvEy+yYRPLPViiJeyix+eLOf
 Tkb8A1CZ5wqHO75kL1gI5jP0/XyvYwYQBcyonv+8qxIpQbRlzEKzn/BPQLbbYD9e
 TMEqhyZbgtQ2F/jM6bDZa6hkctaFKCJUcDqinXHg+rVfS56G4l2adlG1HPfpvsDw
 j6EvbPg0sTnXSC4B1+4yPGHIuR4G5LDIPKflgzCd/6WEi2y0ebko1m7W4YjCHqFN
 /1QuI3MaG6zeV7mhdH1rkNyl63Fkehra38AkRFgm9537WVIJpVPITOCWpvtidaQo
 J7G1UnsrnqAU/cSyS32oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1710264389; x=1710350789; bh=bpZlDmHeeYMkG
 RSBKslj+yLQcGqHxFo5l8rTXgouWhU=; b=EbXaWt2xmaDPmIVc9Y7L3rL5IkjRs
 3BOuKKYoInQnwPuNYS7s71YN1gucsPozSDKAJtQaw7VMWNSmRkvbGM67n3dxAPSC
 R9zWqBpJVtiQOgvqcF6hajxnveQSoQ/AEULb25d1NtY/uA81t3tcRoIBLOEB6uST
 WzT/sRQUwbvWOdWT5cWeFSPr46VMMpt96OKGKG0AXFrpssotJuNTQOxmLRLqMpO6
 /FzdvFu/ztBexd2ya+lZmGbsb5Wgi2LByTHZ+Wn21FfPbaIrsgfRrBY6IA02Rsbk
 G4caxXZZeOkjjHA037MpksDjB9B2RXa+ATCuTQe0+9uxa0zAs2r/7gSiQ==
X-ME-Sender: <xms:Q5DwZcAzUQ-Ut81kPidQ7GOZ01uyZBJxpMGz8VbC9ZidYh1WHTpZQA>
 <xme:Q5DwZeikB_ebBmT7H_umbYEdPx9w2jKc6XLNumgbI_vLUx35DD2PTYJRi6GLerLfm
 tzOTTWbmhN_tIw1OeM>
X-ME-Received: <xmr:Q5DwZfn-qTn3wfx2nlejH2RNjHZDRM7YDXdim08F2XX9M_y-cQdi7XKebrk27DTHCDYmP9QRKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpefhgeetffffteegfeevueeiieeujefhvdekleejvefhffdugedtveejieejtddt
 geenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Q5DwZSyy5IhMZVCvLGOEQyzPUD4ZOQQ0XcIQjsuaXH7VwKcP8CpN3Q>
 <xmx:Q5DwZRQpR2Z47Ga-u8nnLIBH6UI71x5RX1HbIwp8D71MCxPifC0eOw>
 <xmx:Q5DwZdYRizKDIGpixRDnSF_xA6jr-ev97OsEH21emeNZ92tfUM23Sg>
 <xmx:Q5DwZaRtIu_SZCJ8slZ74uv2N6nm657KyGuCF14SpD5JWT4gUS8CzQ>
 <xmx:RZDwZQIfldGEre95dkqQuq634dukmkiDdIJuPxPtjWLBy-4lYP1_4y-HK4Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL v2 0/6] hw/nvme updates 
Date: Tue, 12 Mar 2024 18:26:23 +0100
Message-ID: <20240312172622.58652-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=k.jensen@samsung.com;
 h=from:subject; bh=fn5ANUNjtNZoh6tLNkVn0SGYiji31WPRhC75juru88E=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD77zqjyRyTCj1ufCd/9rWtoFHCMjH4QZ
 s1IZB6Uu02cC4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA+AAoJEE3hrzFt
 Tw3pZosH/3BOpRLx0LqhoIDoqdNQBJC1gHM9eDFbBX7IVIhsfQJXmD09jxkhkzEWTV8NfA0k5yj
 /YcoXApPW2VKn6fNN8ChPRaWyorb9uhpBjDDG36bTZFCS2N37powg7nwZPL0QZqnAFe75DSXPYb
 FFUD3GA0gfinGCt5kH/pZry5nUhu7+DNDcAJsb/p5Ke01Qn37IATSvf1BVpPXsCD7C1ZMGGy83c
 q6KyF9Qk71LIH/Vd7pgLDDGKG4zuI26JboNibMJbwpF2fSjm6c/Km9+bMkTpdMtspmnBKPxwuCd
 poWXu+BOxZBHNiHPOHlxBWqfJfgG9x6pmTOvozu1wqQjUjc5mO7zkKhQ
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.147; envelope-from=its@irrelevant.dk;
 helo=wfout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

Sorry about the compilation error in v1. Did a full CI run for v2.

  https://gitlab.com/birkelund/qemu/-/pipelines/1210559370



The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:

  Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to fa905f65c5549703279f68c253914799b10ada47:

  hw/nvme: add machine compatibility parameter to enable msix exclusive bar (2024-03-12 16:05:53 +0100)

----------------------------------------------------------------
hw/nvme updates
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXwj+wACgkQTeGvMW1P
DelOsAf+Jg51zf3vtWpe4MS/WtULjSr5GtnXMJ5hkHS0WdKOiLW3P+pUZXbsohmh
faVlYeCWptF1CFGfxBf4Trc7XzJy8J6W1YJEofs/07hIAnazo9pwk5shoVu4oiex
HVsBg7/9y7DuiEEg1MRvVvW895cP60WmG1AqU63SYwrVgxZ51ZH0XNuyRhQeYC/6
OSXJ3FDYu2iJQ58uEzGEwv8vhskIpEFTdz0J6gQVxIdzFBbuk87VgZo6pqwgfMBm
/65K85TgFBT4SASc7a2iSUv+iAqSCA6Jdy0VWxCYCikiv5nuPCMCrlbvqcVp+i2B
GKtgfFXhtgepxx6jmYd03EkRjCrxUA==
=W3gg
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (4):
  hw/nvme: fix invalid check on mcl
  MAINTAINERS: add Jesper as reviewer on hw/nvme
  hw/nvme: generalize the mbar size helper
  hw/nvme: add machine compatibility parameter to enable msix exclusive
    bar

Minwoo Im (1):
  hw/nvme: separate 'serial' property for VFs

Roque Arcudia Hernandez (1):
  hw/nvme: Add NVMe NGUID property

 MAINTAINERS                  |   1 +
 docs/system/devices/nvme.rst |   7 ++
 hw/core/machine.c            |   1 +
 hw/nvme/ctrl.c               |  99 +++++++++++++------
 hw/nvme/meson.build          |   2 +-
 hw/nvme/nguid.c              | 187 +++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                 |   2 +
 hw/nvme/nvme.h               |  27 +++--
 8 files changed, 291 insertions(+), 35 deletions(-)
 create mode 100644 hw/nvme/nguid.c

-- 
2.44.0


