Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3E2C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRR-0001zl-1W; Thu, 23 Jul 2026 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRD-0001xA-8X
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRB-000422-PS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso1858355e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790103; x=1785394903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rLEpY3rExq9KlY5Yf9lSIXR1ELXuT09C+vQqFK/LjRo=;
 b=EvyU3KPFxifpgCqpkxG/pcFABrVoiejuTXdWNv9M9becR/ks8dUTD9QJXC6i0tFBm6
 RTx8qmm9p75UokOtZIbmvHORE9gJQJqiQV9lPZMroUFTNDMlwFMb85Nx8gIybN4gtT2n
 6Cg8EFaOTuWRS70e4q/5vfuEHOQeXK9jVz6jActISkmiM1v0QR5hAATVKjsSQIQKenNC
 vxAuTylkAlx8/GKKhVhhAlEg47nx748PKcWj+3bSpPTWGJtalhRYEok3wKz9kdyRZj97
 MVRC+lk3gmmR+vEBqQAsEkMON2IEDUDCQO/SPzmfOCep9bEl1jeL3STs0VHKGymQ7Ter
 K8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790103; x=1785394903;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rLEpY3rExq9KlY5Yf9lSIXR1ELXuT09C+vQqFK/LjRo=;
 b=o4SDPtZtcBzcehT1t3Mf79IrkfsBzPundApMnknOO+FTu96aFsYWlNZ5MQ2VYHtvIk
 JBJ/fDXliKpm9JwtpjY0yvlhVFSCaUGM9iSEySKMISq5heR0FlTF5MJ5WSd5aYI4QhtJ
 Hbgw+WEzz/IHLBPhfdz9AO5Jd29IWZQnte17cIbDCUQgGJfb3fXye6/sicsMuQuHuUKL
 hXBzFeXttJVS5p3rqg0A3j5dfXMX26sXqw31DwBK2XUi3SrIPBLmDgE+YpsnAVR2x1Rm
 EpVodaCTR3IWOe64lnRb3Ob6UHfUXUEKRZa7gaVxfcDrllzth+NiSS8+XDH4fKqY0vyp
 qmxA==
X-Gm-Message-State: AOJu0YxzWtzkyNAwaLKGkB7Rg8QBKegxGazQxvt1iriYCnUjOmjtrSkC
 eyW3WtqBQSef1G4sbfEOhzeQrU2oCnsUYeksVABM2Hj+AnbKk4ZKayuztmyijA==
X-Gm-Gg: AR+sD13qOZDLhq9SQdNmhG5pVjxc0u5hT58skMj/+3r4E0lBWI5AjeI0J2+YOixekrl
 pSjaqCIOpUxT1UZFlO/8bO3E8tCF1gOv9Ey1cygIo6XoB84Ow7VmbMSun4EzSKCBHD0HvjkaJRY
 uPlf3LzdrdmdT/H5IoNBohm9WHRH4Aht7PdyR6EP4cvPABA2exDe7f6NR7KEeP2yTVJkg1kkGnr
 pqdSc/b1eC95Eo1WaBt+vywVf4doe5ZsMwclsSBolpvxNHpRyREKxuCaaE5vw6eT2gBv9tyv2Eq
 o/4fIZilKieaVJFC0VOgfMnZeWFek81fUgG66g1c7cpOg58u9Llz48Fb2zIQ9URz9GtZ/ZTbWo5
 7TIa+Cql44Vgp7Hohw74GlydbRqiv+IPQpZc8j+w4mBRGol9XDd7Znbx9hTsdxfHr1+SnS+pyI/
 Mu+5v7vBiT6MI/qnT4dWBJsO5nPhHem1OAHxmbBinrVzY7WA4i/YpFFgEQVt15nyzjrff1SW3/U
 BgDKif/4fuCHu6pwFSEXU1OaN5ORrxRypMO
X-Received: by 2002:a7b:c382:0:b0:495:71f8:7325 with SMTP id
 5b1f17b1804b1-49573d0a454mr13670635e9.32.1784790103218; 
 Thu, 23 Jul 2026 00:01:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/9] FlexCAN fixes for-11.1
Date: Thu, 23 Jul 2026 09:00:50 +0200
Message-ID: <20260723070059.6332-1-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series attempts to fix the Coveriy issues pointed out by Peter in the
FlexCAN emulation [1]. In addition, it fixes some reset masks to preserve
register contents across resets as intended. It also fixes some register
offsets due to a union being inadvertantly too large; this would affect
migration if addressed after the release. Last but not least it eliminates an
unneeded union.

Testing done:
* `make check`
* Run `cangen` and `candump` on the host and guest in both directions

[1] https://lore.kernel.org/qemu-devel/CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7Eqg1CzyKTfaA@mail.gmail.com/

Bernhard Beschow (9):
  hw/net/can/flexcan: Use mbs[] array for FIFO pop
  hw/net/flexcan: Drop unused RX FIFO register overlay
  hw/net/can/flexcan: Fix out-of-bounds access in flexcan_mx_rx()
  hw/net/can/flexcan: Fix mailbox index calculation in
    flexcan_mem_write()
  hw/net/can/flexcan: Fix mailbox index calculation in
    flexcan_mem_read()
  hw/net/can/flexcan: Fix mailbox reset mask initialization
  hw/net/flexcan: Drop oversized 'mb[]' mailbox view
  hw/net/can/flexcan: Fix RXIMR reset mask
  hw/net/can/flexcan: Remove RX SMB raw view

 include/hw/net/flexcan.h | 22 +++----------------
 hw/net/can/flexcan.c     | 47 ++++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.55.0


