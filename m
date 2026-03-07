Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5828CF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnF-0001zQ-1s; Sat, 07 Mar 2026 10:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnD-0001qn-7u
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnB-0002Yr-Fv
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48370174e18so62462085e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898131; x=1773502931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7Kk6MjDuDA1LkvACL+1FQnoFQPtC5qLEf0h4BItBFs=;
 b=gcXpG42bM4goxxjn1EMEWBbtHHt+RtYbJxNNvYvEeDG1oZfir7TC9olqujORTZWMvg
 Hdo5RzG2Fv33oqMLC53HVJViFxDkqh4hP5VaKeigAwuG7NmFHM0QdOQy+or8bloC18/b
 Q0ubw3BZlLsjEgpYUsk1A4KJbj9dK8xX4VgihwPAw/OmXf5P2zfol7/EB+VZBmUzLXUH
 VrRZricGMmTSpED906pBSCaL/iGMK28fPnFaCusiYoenip0X3BqzLwx1W0jeCRhDhltj
 3wLCUhcg15RGAjuG+ya8cQRUiw05j07YwygaTMjwKSUkeoReYMg/zO2bGr7j46Dj5ksS
 fiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898131; x=1773502931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7Kk6MjDuDA1LkvACL+1FQnoFQPtC5qLEf0h4BItBFs=;
 b=r/YWlqsnIMVQ7KMEnMxl74pnZJeshkfUFRm8kmGoOj4OpODVN3NQWTNnKLpfcw0GJw
 wWMGIzutomMemgyE+Pfqi7MAsn1tkRrYH951c7g9DoP1DXhb17YRL+d/Y9E37bYYwbeC
 tVUc1a2zZAkOfkI+HazgDHdx8/Fxb2w83Qqaf5q2jVzetHS94M3kM8QLdtKEZ25fWzXc
 yEGwAe/lpjF6qzW0UyELVv8nC79MpImAEXarVUKibIIXcFAhKPZxPkw/SgTp8flVvZpJ
 ICXC2is2ok1jOSc8ZvReQK8jPiNVxAkGAMZlyWWgVxqdlYNdgoQZqkKjO7bPDoTCJApv
 G0eg==
X-Gm-Message-State: AOJu0YxN0Q7S3uZrVJcnBP/T7AwhSJCZXMZkcMG1emo6rO7iQROaf+IG
 85rGQaLc7RoJEEHDR/00o1eud1NbW6UzfwewNyqMf3UGOmHSLzqFsByynfLsG1LPAhdLOEOjJcC
 FIByLeLs=
X-Gm-Gg: ATEYQzxi0pF/Ci34x8TrL04lDighGVlNNmyyShYnlXE7vwfQtHm7ACObpHsnTQFtUet
 K8yYv8olm2LAWfkYtkyGhuiT63yryrwQHBqdQ+PgdxiMRW8o4OSUMebFjh4ZygqnBcoyGwElscC
 1lLMQ2bY2b8pKAv/qapCZ87eouWdRxJ9k9FV/9OkYvJToNmGmU8FPi+glamJw7hVIZmto2NqbEy
 mEXjQQQAd4WYG5WD0R8EW+xVaQOGMhI5kGW9FRQuo0U0bXHYxTaamKcYgCXc342vrVu4DSMHO3l
 oj02S/KNLG/0kHbZlPYmMhgsxNcsaiD+H5/19DVKGnOZL3I5juDQb4F3MBkNQTCwaTHVIu/UX0D
 O/jdLvyUTyRYxTCPyUpdcvTmOKQIDQ3UGCueRbktoXqFv01Eo4fSc9QBZ+FpFg8WKxQm9MRI5FK
 ub7LwoNzXUZdqvTw2V8Jr6AxZ7lL4773AT3jAGppC/vIhJS0yZOtEvCaCC/HnbZwhkNtBI4I6X
X-Received: by 2002:a05:600c:3b04:b0:483:71f7:2796 with SMTP id
 5b1f17b1804b1-48526923e1amr96087595e9.10.1772898131129; 
 Sat, 07 Mar 2026 07:42:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm11429826f8f.6.2026.03.07.07.42.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/6] hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and
 pc-i440fx-4.0 machines
Date: Sat,  7 Mar 2026 16:41:57 +0100
Message-ID: <20260307154202.86309-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 hw/i386/pc_piix.c | 11 -----------
 hw/i386/pc_q35.c  | 25 -------------------------
 2 files changed, 36 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 13981fb3aba..f087579694c 100644
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
2.52.0


