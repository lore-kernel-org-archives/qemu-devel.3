Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482D2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLL-0007Kj-OB; Thu, 02 Jul 2026 14:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLJ-0007Gi-8z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLD-0005Sk-Ia
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so16022435e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017649; x=1783622449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oea98Ziejf8hBE7TBbLPRIKwweFKnm9eW7/kpytfMh0=;
 b=cQ6PKHdmhX4WIZOQqHGOTb/MZOHr6nbj9pvPM+QSM4Qm6cKoyFukitE0VoNwY6KcDw
 sgJozfzd1YhlvvaB0iOsiOT5tn5ARI3Djg1o81wUuQMi6CBKiookqzSYVryTHXCnpxz7
 CaXBC/027OCV9+/gAAaVLnnDXHS32I1071LfiXRlmCIy70wIPp3xdq9VfY0Mp7mPN+rt
 ldnBkPgfYk75VNi/y+M1+DPfGmQy1GHcTpdmbU2oPAoUxAZsQJu2AyNTc8+LkmQVUND0
 KtViopgmcaX+ZJLnIncYapyEcD5XVvYEtXUOTNExb+2Zk4VaOA0Ukpx8Ub7PPfgQUYfa
 FXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017649; x=1783622449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oea98Ziejf8hBE7TBbLPRIKwweFKnm9eW7/kpytfMh0=;
 b=LUaboOcEKsvSzVJMvnoFqnOwdQX2rdn0YfyfkxCPjkJruYRiRtzDzpxfd+9LHAim3m
 8L9GucTDpMmzS6E074liNFF0oTa61bzGg0pFCA8gVvPwvhOCFhRdQArYM/CU/c8NYp2/
 cVNv4xHZaZwIZRpvvHMQlTq5tdidzVdqscQ8QLmiPSkrxwm2SFhynDRdyw6Rfve3zE1s
 LbP65yLHJ1L346+hBYfB8vWZuwCRevXpMCB4OivfL2sF+Fq0s72cu1JEs5hf0FXrxJ06
 V4FkEInw1Kqz080Tze5yH1SIAeukI3elMwuMWGfzCvSonzkDUiurxlDxmagBScER7VX/
 s5ew==
X-Gm-Message-State: AOJu0YyxyqNubSk0GG7mM52ZEBg5l11iHLIGv/SXLnYXiPWyB68h4jxT
 pbOGo/+xaNZzjUa6upDvZNfyXhC1Qe+SKCEvRzKTaFQGg6RewywWNocbnjBgpg==
X-Gm-Gg: AfdE7cmK7Q83S6dAekUNWTYSiYDloZvnm0t2l5e/2Ba/LOZdsPJGiSDqjDLYAdeqkb5
 Dvc1uMqLVynj/BfmdzcLZmzzJnqBDLd3SBmTFoePUVIUN285gBxwMcr3DfkGaiPUILk7NVgR+vl
 M4G/uoUbG9PDlDXxPgF+Delq4CB3xe8AifToLY+tB5ZDdQHL80AN2FSL4YHbffXw/zV5E/YOnGU
 WrC5RFPtOSx25AXzWs0irrYijLzHOuytMSBI1LkpAIbGDGF78Sviyf60j9FK4ocH4QUhHnHM9XS
 hef1e8cl3Po9tTqC3n/c4vxrFATRaxW5j3Wk9CjUS44cgHHdJRdzD0yYGXXCxNeWrwoTPPFzr3r
 SRnvhlLzlmfOa1p+bSVxpLG57o5///dXcN54wWx/xjARvQzRvepkmaXUa3ouTRRWnCGtGvN0/l8
 XtXgmUw/cctEphxFGziKNyhJ23u0h3mY0TB99rD9HZ2970uCrwfK1HAShvzXANfXkw8KlT71Uqc
 myqZNG8/siV1atkCJiVz81xTMDlGTD1TjpN
X-Received: by 2002:a05:600c:8b88:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-493caa2bfe9mr6838155e9.17.1783017648955; 
 Thu, 02 Jul 2026 11:40:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
Date: Thu,  2 Jul 2026 20:40:33 +0200
Message-ID: <20260702184038.178196-1-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that FlexCAN emulation has landed in master, let's add it to imx8mp-evk as
well. While the real i.MX8M Plus supports CAN FD which isn't emulated yet, the
non-FD mode works well under Linux: It is possible to use `cangen` and `candump`
either way on the host and on the guest, as described in
docs/system/devices/can.rst.

This series consists of five patches where the first four are preparations.
The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK board. The
first preparation addresses the review comment from [1], and could be applied
independently.

It would be nice if this series could make it into 11.1.

Testing done:
* Start imx8mp-evk and run `cangen can0` there. Observe on the host that
`candump vcan0` prints the traffic.
* `make check`

v2:
Thanks for the very helpful and super quick review, Phil! Here we go:
* Add patch "hw/net/can/flexcan: Wire clock control module via link property"
* Have separate MemoryRegionOps for 32 and 64 bit

[1] https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com/
---
base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799

Bernhard Beschow (5):
  hw/net/can/flexcan: Wire clock control module via link property
  hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
  hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
  hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
  hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

 docs/system/arm/imx8m.rst   |  1 +
 include/hw/arm/fsl-imx8mp.h |  8 ++++
 include/hw/net/flexcan.h    |  4 +-
 hw/arm/fsl-imx6.c           |  5 ++-
 hw/arm/fsl-imx8mp.c         | 38 ++++++++++++++++
 hw/arm/imx8mp-evk.c         | 64 ++++++++++++++++++++++-----
 hw/misc/imx8mp_ccm.c        |  3 ++
 hw/net/can/flexcan.c        | 88 ++++++++++++++++++++++++++++++-------
 hw/arm/Kconfig              |  1 +
 9 files changed, 182 insertions(+), 30 deletions(-)

-- 
2.55.0


