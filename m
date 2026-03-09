Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C502F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvO-0005w9-55; Mon, 09 Mar 2026 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvM-0005fr-8t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvJ-0008Jf-MX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485392de558so7187695e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071615; x=1773676415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ySdlk6vD91unfdXN8wBQdy41UnoNXGeY5USugHCizuQ=;
 b=QK0m7d+Fp58fc/qj18qjOSAAvgxpkkow1bfrCnwr2au84razdCQeaVeRw/dZTamhov
 YhYV/dL0S01qrZm2b4UBAaPzi0ZqYRTfFJ1AamYm+LzSeFZ1ZeiEWgtS2o1WQOq7Ze2v
 Z/uOin0xcBXdWPZyavUYrRGlFIbh/lHtu1nVNNRiaebvfs621SUbkgpGEujOdzmH/SFD
 PbSOS9HzIO8y88Qbg81elIUvjWM4m5FAaVWINtjziVuEuMFkj34hIS9kMhpgg/cqMLEd
 chOsbOhPs6PRUfyKx+lQv3+hVwGOjMUxs49FGqI0ihPxlDsQ0wqRQ6dyJVxXdEKzRodL
 gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071615; x=1773676415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ySdlk6vD91unfdXN8wBQdy41UnoNXGeY5USugHCizuQ=;
 b=rXFD8lmS3xd+z4wK40mZn0ftW+hBLTJf9RhhKFbeffAExjCvJuTzCH3QPOAMl1TKKn
 LX3mJefvnf+onQYgKnxmfS6UMgB7nORqTQPHuK9e2zeyBSHMXXPV7BeLlRUoi6GdcfG/
 J4CrI6xhawoSzEE80fQUScpaOm542jazUhLq/B0szE9AJSVNcEUZjTdrh24kd7uTB2R/
 YuHttJWbjDk56YrEP9tLzRzPPcMoxtt1D78SpQHAWqgc534UhByrOHIrduH3MzFCruaP
 zgnJ+wyEk3euZ9EXwI32CBbf0+OFpxFyEVAqLDCVg0zGEzexyzCMwZB8FiWH28EOSw0x
 YnIg==
X-Gm-Message-State: AOJu0YxSbZKkp+Aflt6NKKRqQb6vtZd0PI/cLGy2vyFh6jFSbogliofK
 om4vojYuPmFub7EyilPPPh+n3yMhOyuAdQLSHigHbuGl6Hqy0xLapofQzWd5mAywE+7tTx4JnPt
 bbWbuPbU=
X-Gm-Gg: ATEYQzyCFoI4T72+3uQjY7JUM4EbRfEyQsMQxWomh27P2dwjWzMiWVlnP44A91Edg2/
 mredSUg1C9rH1EADyw72QsngE+EH1/JWfcnXJuW1WkP6cVR/nquW75ZSNtIAJri0ZCA2OlpKsGR
 eS/NSR+Z+e/zpkPy0KSeqSIV+8x4iOkOB7GZlfC2/nkTwCYdIGQw0RB0Fg5gGlvL3tn550E6fRm
 P+5N5WyQtcHNPnPIz411ciCV6TyIzjChnjKKzNHQ/aSf7JEzLyHUPTMxOptuc5m3rsNssY7BwRB
 g/ojrSPj8humN97K9UxS9JxBBcnVJdjeZ4WfLEAXKtPktRwhO7Tlwvw4JsP31GFj4rtnvsKMreC
 rPMpHhs7wlu+n2jv7EU5v2C3IxEEgYHLIhnwQwZ7qcv4SkwjAYK/r6HT2Vlns0/HkyxSO8zHLpA
 0uVBK7fNYnUb0dWAOxpKmDTlMK3ibFBcttUt1/leOGiFCy7d8pnopC4JQW3QL0tAl0qBvAKiuv
X-Received: by 2002:a05:600c:4e8a:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-4853f41e355mr36307965e9.1.1773071615443; 
 Mon, 09 Mar 2026 08:53:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm30401602f8f.32.2026.03.09.08.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/49] hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and
 pc-i440fx-4.0 machines
Date: Mon,  9 Mar 2026 16:51:41 +0100
Message-ID: <20260309155219.62400-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307154202.86309-2-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 11 -----------
 hw/i386/pc_q35.c  | 25 -------------------------
 2 files changed, 36 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2b94c472446..4d71e0d51a2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -644,17 +644,6 @@ static void pc_i440fx_machine_4_1_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(4, 1);
 
-static void pc_i440fx_machine_4_0_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_i440fx_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
-    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
-}
-
-DEFINE_I440FX_MACHINE(4, 0);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 52b8064b4d2..cb23322f5a4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -575,28 +575,3 @@ static void pc_q35_machine_4_1_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(4, 1);
-
-static void pc_q35_machine_4_0_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_q35_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
-    /*
-     * This is the default machine for the 4.0-stable branch. It is basically
-     * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
-     * 4.0 compat props.
-     */
-    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
-}
-
-DEFINE_Q35_MACHINE_BUGFIX(4, 0, 1);
-
-static void pc_q35_machine_4_0_options(MachineClass *m)
-{
-    pc_q35_machine_4_0_1_options(m);
-    m->default_kernel_irqchip_split = true;
-    /* Compat props are applied by the 4.0.1 machine */
-}
-
-DEFINE_Q35_MACHINE(4, 0);
-- 
2.53.0


