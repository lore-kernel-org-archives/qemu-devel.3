Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4209BC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84yF-0008C5-KO; Thu, 24 Apr 2025 18:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84yE-00085U-Cl
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:23:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84yC-00017m-Lk
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:23:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so795679f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533379; x=1746138179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWC7ZUuhMJjjntdzJpmYnoIJKuGi0kxenHJ2eaOicnY=;
 b=fZi/TxeApOHecixa5JPQAWJmYPVErpzkTcuPN+wu4Pw2PIP3JHSyvMLI+7iCsIPDNT
 T6sJZQnvvqsvINN8+M8JdrW6BxwdRNYkqmuA1YZtQtTFzmWpPEYAtaXLR41XkugKwQHU
 iUzymzJsWpHOidNiT9uwv1m2LPJvZsbG3gbmr6IOzFeBiW3+hCYdYFQIQQ1FUAr4QH8E
 A/FyWi7T9Zdni3XJupz5rbYEIoNhD00JCBdLzug1ICcB9ej9ZIgxc7d6UIlXH04U24nK
 TVqcaqsxqj4xZP2DOVgvoqX9DJQRGriLJFy1oTaKKq3DUZdkMx35nqtpB4jRG+cGY3kJ
 nZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533379; x=1746138179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWC7ZUuhMJjjntdzJpmYnoIJKuGi0kxenHJ2eaOicnY=;
 b=bGbw6Q5MGFVSr+5va0sfR00qoDMRSIxYvrjvtjfZmD0szZRmAIVv0wYn/c06HEG77/
 W0kDKGWd284if/fIv45BoWrkG4ySB5T17/LA5nj6YpWvDaCSBCQ90XcKGq8Da+Xphu3F
 4XjQzaMzVoN4xm8Zht2nqvJhjyoCN1aCXZTrcC5QQqtGuHvzf8P3Rz++4FbE5vxEmwAM
 RCS1+Ggn2UzgeQfkDlhaoXWysZmWO9DOvOHBFOsl0IlPBMJrHiBMjyayoRbTC2KTnMQf
 oSpvlcVlP+IN4uy0VyyyE4PsjdgOcsDuw5Ke4Rrprab3wdnWG22YUwFvye9/dguVeg0a
 S8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnkADF9ZwoGx0CBJstMjZxiHIyCYaUtOMjCBOpwG2Jejjn3W076nz+L8vnx4G7i64q6psMoeAa5mAD@nongnu.org
X-Gm-Message-State: AOJu0YxrmzqMZF93x50qROpghvku5nH6dU3/KvVEdbdQc7f07JiW0gJe
 av61QniMqjycX+5PeYb4hfFxnYgSDISB6RSQE1rThxTlA+5fSYV35V8AYdV5qBA=
X-Gm-Gg: ASbGncsLIBnEywOi/T1CYRn/awJdjLJqVNVKp1YzaW2dvwC0nnHwykhcKjmen73qZMK
 Jz2mOm7WGp3w7Tg3weLaM32z8RJDsfF7BkqrTKleZtVaEqe95jFxcXnhJDwYZF9ujDBQA8T/HpG
 fgSyezaSLAXNZ7OYJtWt8v4cv//HcmRpyEabByCSDVuFDTS/R28voqwHKtWoO10+atohj6xOjeP
 8IXjkihWETWxarWiOaLr/7wF5obxgLAMGJiw4bWWnylpAg2/rYPO37cNgbVCX71gtkCcaErwIl3
 8j3zl23DcMyDxpnrNQe0I5j5u79O4yMDDoTQQAqqEN1PyI7y2OgE71fJ61ke2gx064t8FaWuZSO
 67YndodAex1N+dMY=
X-Google-Smtp-Source: AGHT+IGeFB8JAIjFP6RryB7dOMilJYq94c3FNs1OB30CFf6I295IInGHZi18IZaprXm2M/V+OdoNFw==
X-Received: by 2002:a05:6000:4011:b0:39c:dfa:e1bb with SMTP id
 ffacd0b85a97d-3a06cfa8319mr3247397f8f.42.1745533379197; 
 Thu, 24 Apr 2025 15:22:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cc74sm531999f8f.11.2025.04.24.15.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 21/21] hw/arm/virt: Get default CPU type at runtime
Date: Fri, 25 Apr 2025 00:21:12 +0200
Message-ID: <20250424222112.36194-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Prefer MachineClass::get_default_cpu_type() over
MachineClass::default_cpu_type to get CPU type,
evaluating TCG availability at runtime calling
tcg_enabled().

It's worth noting that this is a behavior change:

- Previously only

  ./configure --disable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'max' and

  ./configure --enable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'cortex-a15'.

- Afterward, -accel kvm will always default to 'max'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 566afa4c978..b59cc90bd36 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3127,6 +3127,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static const char *virt_get_default_cpu_type(const MachineState *ms)
+{
+    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
+                         : ARM_CPU_TYPE_NAME("max");
+}
+
 static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
@@ -3184,11 +3190,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-#ifdef CONFIG_TCG
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-#else
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
-#endif
+    mc->get_default_cpu_type = virt_get_default_cpu_type;
     mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-- 
2.47.1


