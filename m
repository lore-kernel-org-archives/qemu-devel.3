Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B442C369CA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pYG-0003xA-KU; Fri, 18 Apr 2025 13:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXW-0002nA-UD
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXV-000090-00
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1421988f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997407; x=1745602207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLlTlwFK7dyLEOdkaOnpCuG5I1s9eWFIuaNy+YiBC94=;
 b=nH8uJ5O8H0FkGQK9dMhq7m4TaIMWRERpxoQHWVIIDehYoQZKf/S+dboEt4EbLaVJ+C
 VEtQFisBm5ku6+B+710FnYwXRFo2xIxOzrWR1TR4KeOYXHHrAbz5OCRLnBsrM6TKrTY7
 rAGCRC3hcOFLiHE7NfEplIKiDQlca0reKFa3KvfxDxkVzfHbs1s9jXGh9RHQouJqqgmT
 nJ003m3ahi1yOr/NQ3o6iD0hqIWlbuGfEZ9rBQq0DtzhNHuP0j08ZruPALBwVKwmBBBe
 MsyKP4/V0yXd9lOkan7mZpnY/Qzubyf/HkEDS52hZ7RqL457y8pJ5Z05I2VMN91PZIbp
 dAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997407; x=1745602207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLlTlwFK7dyLEOdkaOnpCuG5I1s9eWFIuaNy+YiBC94=;
 b=Aj/PE660gypVDV0ehFBAuG1egV5dp/3Mq4qmW7mfM5QJHXP0EgULo9EuDeEwSrrXZu
 Krwl+acBwHeElDqu2+zhBohe+VIXjiyh1xv8PQ9NRzRccmPM1Q6BBl3WjKje03T3I25t
 YKatCJVPKH/kJBAJ4/iHJ1Qtl0oPeS0X5LtlDZ1wCpE2uymt05tsNIcUtApAyIO1Qgaz
 SaSZtihaZUQEehZaLig0zKBoRqZQgk9UH2uw26MVXxcrQ/0AYNtynydinFflfMjZE3Om
 oFjy+8u4ZhSYVIKdQvl0jfbETKuhGFV0xK4neRoYzSpEdgqJ/xuG300Uco78h0yTbI5s
 kv3w==
X-Gm-Message-State: AOJu0Yz6wLDwQi3PIPKMjEp0pf9qHTCl1VJ+/7zHs0wbubb3flKsva8H
 XbB0lZx11wf6CENuZK+dHstVYrdr1175MzR+as0upNSSnM+pdMfazpCurFu9V3I/0FTcUDsIMiI
 k
X-Gm-Gg: ASbGnctlJYpjNaoRC+X3Uh4D2Q4qVSrINxcG1ukyOB9CJk5ejoDQlzRlHgQmyW69AnU
 E883VmBH3ABYVCyoFQ2To5XHTl4nd4eLNVe7fB0ywNMrhb7Cx+8BMEunSmdbAmbx5huqcg+EWwS
 XKpO0syRDfQ8aR+k10Cx1x84/iLFXshnhUq9FSc/aKwQKjC4NKZCgBnmEeEmuDzV4oV2lYRwh49
 Ir7SejDKHsXf7twZGyLFubNpKacmnyaZ0JPyKeTWGcJQspYtK9JJynzBSWG3dtJOPPwlz//qZJL
 I6fbgPVc+gRtC8aVjSQS0fiMB8zWS8lu3kZb2xxmSWLgCy+nwyC6Xn0GvzZ3zZUPiSJE1RML9Bw
 VJ20DmiXihwrnyS8=
X-Google-Smtp-Source: AGHT+IHte/Pl3MHRvWgKC2vfpRiNOQVFdRy/pTeHWXFLHgcbeVHrcz5oDfS7G5gc7vWYyBhrTze1Hg==
X-Received: by 2002:a5d:64a9:0:b0:390:f0ff:2c10 with SMTP id
 ffacd0b85a97d-39ef909193dmr3633095f8f.19.1744997407046; 
 Fri, 18 Apr 2025 10:30:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433429sm3341407f8f.37.2025.04.18.10.30.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:30:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 12/14] hw/arm/virt: Register valid CPU types dynamically
Date: Fri, 18 Apr 2025 19:29:06 +0200
Message-ID: <20250418172908.25147-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a3c9ffe29eb..48a0c3588ce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3134,32 +3134,30 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    static const char * const valid_cpu_types[] = {
+
 #ifdef CONFIG_TCG
-        ARM_CPU_TYPE_NAME("cortex-a7"),
-        ARM_CPU_TYPE_NAME("cortex-a15"),
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a7"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a15"));
 #ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        ARM_CPU_TYPE_NAME("cortex-a55"),
-        ARM_CPU_TYPE_NAME("cortex-a72"),
-        ARM_CPU_TYPE_NAME("cortex-a76"),
-        ARM_CPU_TYPE_NAME("cortex-a710"),
-        ARM_CPU_TYPE_NAME("a64fx"),
-        ARM_CPU_TYPE_NAME("neoverse-n1"),
-        ARM_CPU_TYPE_NAME("neoverse-v1"),
-        ARM_CPU_TYPE_NAME("neoverse-n2"),
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a35"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a55"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a72"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a76"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a710"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("a64fx"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n1"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-v1"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n2"));
 #endif /* TARGET_AARCH64 */
 #endif /* CONFIG_TCG */
 #ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a53"),
-        ARM_CPU_TYPE_NAME("cortex-a57"),
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a53"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a57"));
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-        ARM_CPU_TYPE_NAME("host"),
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
 #endif /* CONFIG_KVM || CONFIG_HVF */
 #endif /* TARGET_AARCH64 */
-        ARM_CPU_TYPE_NAME("max"),
-        NULL
-    };
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("max"));
 
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
@@ -3187,7 +3185,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
 #endif
-    mc->valid_cpu_types = valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-- 
2.47.1


