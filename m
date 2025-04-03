Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E76C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVw-000303-Lg; Thu, 03 Apr 2025 20:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVf-0001t3-Fq
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVc-0003H0-Ta
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3965c995151so884733f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724926; x=1744329726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JPE8N1C/1YRw9QGlDnar3nFanH+VdzHui8+FDaSjco=;
 b=pqp1tsCC0JaQ+k8q3BVbVlMnxNFGXU1cysDC9g+T6GVpR0iHlm+MTzCod5dQCKSDsE
 6M66R2xoH77cQVWbyj81SmIVfalDRdhzcLzX4WUnDEQUspogZdi9OR27L7pqFa7qoAQE
 BRpj1g0EeFRqKeDBIcmAHUU3pdZXvfNNnQT7ELHEt0uMhhV3Xdr7Hj4GuzKQ5bFAqxdO
 13IHbfhN6gwqmec8GmJ37R2wUxmue/x6IaI0PuWhCY/I6KirEP6V2CSjgN0Rjpd6T/ft
 Ih1vHStHlnXwcqvanjqAcYxR0SrCXSY5db/nV6KPk3uYU8anqpYuHQHLsyG383eF+xoE
 AooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724926; x=1744329726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JPE8N1C/1YRw9QGlDnar3nFanH+VdzHui8+FDaSjco=;
 b=xKmD0+H9n/IvD5AIzUXAZUXUHvIzNjlZvYvJin3Xbf7Dvp49FpggLhlvBJ+1aLYFVR
 5rlno8oSqMpGBAhtVC4p2EnSk+OuLwYvY88VMnkWJyiGVbL4xzva0m/zyQdclKrEr72p
 M4ncJI14t3ggu1qSCRRSMKrVS2sxMacHd2HKnbtPV9pSnO6CGYPrDf8hjAuiCVZH0wSW
 Vxxsw6hCpXqeaGLG12NjAGT5OnieVWRJcjVFv05uhxY1wZCKPV0NpLCHuWmj/sjUg8Vm
 YugQjgdwPOsaxZ92zcTGTKztBGmgpisQ8MOBg/lBhaGeSVqHJP6pPu3m/4iLBrPoSs1P
 KgSA==
X-Gm-Message-State: AOJu0YxpXpbDnQclSa33YpVkp3OhTTmXg11xWE4Znc/ad9Y13zGmysGM
 c6uskA9g5D/TUlGibnupT4dOvvvcKJvMsE0kUdkNud9XnG71iNksrnaKTlKhPvuQ6jpirmSQnCr
 M
X-Gm-Gg: ASbGncuDgGqPNUHy7RZVXNHwvOTtCQqHsz3u6vUg6kGZNKuHAq9ieqV/4IpnxPOIksR
 DFwpLNemsUZX6jhtuELxhNexxK62zsi0hyT45Zo7uGDw+/9a1uyMfDfC6HVpi8SiuZZHG5dG6EY
 pHvyFcEWS9Noo4n8ZpgdbkSs2YuypsjuTCk3yUm7JOX8Q7xgtEtnal6a67sC63p4eUG8l4cJF+d
 lRtjJqvNzRvoOpp0qB+hobGptKuc0vlf2Mt9a4JzMEwP2MTpduDcheS40xmlZDiSiFUEqbV9c39
 7QMvDXETRuv/WBzCifaGHWrLf4wgKL7btH5Wj4pWhwGW0bl0PJ//lqdq6TNZCHyfTH2FvABR8vo
 RYhIYcB7NR6szNRbwulU=
X-Google-Smtp-Source: AGHT+IFDcm0xzNjdJGbNoJ5l8ven9KXgrcc83c46FvGWab26JcE7g9YvC5kpLBEzImSiXIn0rydhfA==
X-Received: by 2002:a05:6000:188f:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-39cba941587mr902042f8f.51.1743724925945; 
 Thu, 03 Apr 2025 17:02:05 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a732asm3011012f8f.30.2025.04.03.17.02.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 34/39] hw/arm/virt: Register valid CPU types
 dynamically
Date: Fri,  4 Apr 2025 01:58:16 +0200
Message-ID: <20250403235821.9909-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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
index fe2dec9500f..e241e71e1c3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3129,32 +3129,30 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
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
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a35"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a55"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a72"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a76"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a710"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("a64fx"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n1"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-v1"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n2"));
 #endif /* TARGET_AARCH64 */
 #endif /* CONFIG_TCG */
 #ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a53"),
-        ARM_CPU_TYPE_NAME("cortex-a57"),
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a53"));
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a57"));
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-        ARM_CPU_TYPE_NAME("host"),
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
 #endif /* CONFIG_KVM || CONFIG_HVF */
 #endif /* TARGET_AARCH64 */
-        ARM_CPU_TYPE_NAME("max"),
-        NULL
-    };
+    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("max"));
 
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
@@ -3182,7 +3180,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
 #endif
-    mc->valid_cpu_types = valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-- 
2.47.1


