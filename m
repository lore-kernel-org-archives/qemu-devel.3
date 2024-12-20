Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9DCE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEM-00062S-10; Thu, 19 Dec 2024 20:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEJ-0005wW-Q3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:03 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEI-0004Bm-8h
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:03 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so1259604b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659700; x=1735264500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZX0TgFMJ8uN9pbvITB6VLJTDE458zw/ldNK20g8Glo=;
 b=IZX8v8RFeA5UutkRoc+B8Y5zUjS7uyy/vTybv9N+U/jzIdD52qG0XzODm/22MvPmlU
 gWQJkUhEQOnJoEHmXj4OKQ2zmC26sMS9mETeqIs4mOaUK+iy/KGGQMvV8BLgoK/ybybu
 VUh/PIMUbKSvMtgA1gmmIX1VN1SBumoL3wE6Wb2q0WxqO/uvVXzEmkNcNW4r7IT4ooWp
 YMkAb2tGtjnXptLTiJ8+HE0tE6qrRloN6C7MVVVoNfUyNcpGRhX+4v0+gCGCJxlAIU+o
 ZErT5h8Jl7Xx/txX6haru5MzCEm49KDJktbHTOg09kweef/1YcyvJ5NHggbMWNN0DUtS
 uMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659700; x=1735264500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZX0TgFMJ8uN9pbvITB6VLJTDE458zw/ldNK20g8Glo=;
 b=EkhQNQ31y/GhNl/E4jKKUVn01Eor+tadCv9MtkwqVzt/jOeIWd36qqiq8SC71TGYkf
 FLVYuPgmOWuNuimIDHZJ45tfEaHi2IjKobJdnYvtlEjhlGaVtNvSgNUO61IjlfqM0+z0
 01iDkTNRRW887CHtIMjVJ2EcVjQkLY1CCQ5q/xmeMTX6EdobkNw71Um2xvABHVrbtd/3
 V8OIbadSDL/22lCSLkwAQ/kVTJoTwhFARrway6bwkyLW5107jOAfnNLQcHdcdF/93c2i
 5X8F08LqcMX9hYfxahsPE5RUuepSZCJtm3t6sjVela4P8VEgCC4JMX+cogoZBO+QPXVx
 2qww==
X-Gm-Message-State: AOJu0YzU4TLqi8vaYLaUg7xlCtvEu718EUGkbF+0FOLqo050Xk3dLE0K
 GOx8sEIPk0JDYlp594aEDMoxJui/uiT+YD3g1J5qZIf7x2fQMYsP/V/JO39s
X-Gm-Gg: ASbGncsA+wgkIrzo/V/Vo0Q7douoZWdkmEygseD4zj8xD2kTbZVjqIWat7sYM6CbRLA
 IQC5fNSaKWeyx1brkT79pV9cbGxwYPWmtEjZA4l4pWJYnjL1L+HtkKiWSUJpG928jlmdAg6dOES
 Tej/X6TxgKqfizc0qsEoLfK71NZEtUt0hcrKRGqNFN433IxOjdMGhhEKDuUYu1vDnE4pVzDGIlb
 HUhSb1hyQAszKI4xlQjrJX6dPcFadn7LCPsrBNCiJBnh/HognqLXYEkFbFBf/v+9MGhwTmWs7+5
 9AwfoNB0GmKJb9TtmTYzCO6A2RXfJ0MlUQPssFhyAb+a/CGcqhwgzbVF89LY/Sk=
X-Google-Smtp-Source: AGHT+IHCxWWVP3s6/NNLM5jO7dj6FtfJmTJKjAqxIZIx/EHqBVoTgr6a6X6zj2/iIfj4xUByw4tOaQ==
X-Received: by 2002:a05:6a00:a908:b0:72a:bcc2:eefb with SMTP id
 d2e1a72fcca58-72abdd502bcmr1490311b3a.2.1734659700489; 
 Thu, 19 Dec 2024 17:55:00 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:54:59 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/39] hw/intc/riscv_aplic: Fix APLIC in_clrip and clripnum
 write emulation
Date: Fri, 20 Dec 2024 11:54:02 +1000
Message-ID: <20241220015441.317236-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

In the section "4.7 Precise effects on interrupt-pending bits"
of the RISC-V AIA specification defines that:

"If the source mode is Level1 or Level0 and the interrupt domain
is configured in MSI delivery mode (domaincfg.DM = 1):
The pending bit is cleared whenever the rectified input value is
low, when the interrupt is forwarded by MSI, or by a relevant
write to an in_clrip register or to clripnum."

Update the riscv_aplic_set_pending() to match the spec.

Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation for APLIC MSI-mode")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241029085349.30412-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 353eec8136..3edab64b97 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -248,9 +248,12 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
 
     if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
         (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
-        if (!aplic->msimode || (aplic->msimode && !pending)) {
+        if (!aplic->msimode) {
             return;
         }
+        if (aplic->msimode && !pending) {
+            goto noskip_write_pending;
+        }
         if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
             (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
             return;
@@ -261,6 +264,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
         }
     }
 
+noskip_write_pending:
     riscv_aplic_set_pending_raw(aplic, irq, pending);
 }
 
-- 
2.47.1


