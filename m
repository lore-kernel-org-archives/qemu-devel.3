Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9CCC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F3J-0000a8-Li; Tue, 22 Apr 2025 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F36-0008EZ-0v
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F34-0005I2-1r
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so48016455e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333792; x=1745938592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZGQgvHwQWyT1UXG05e/L40v1r7rbpXm4CP7YDA65nc=;
 b=IGIH7LQtc+HVAqEBnbPS9VOyPF17gKel2VLFAZwhjnsroT5EQq4+COzuq42bc1EjYv
 40DmQf3FkIAxIot5BIfTcmBnfOeeHxt7LWeNzRavMQ5hNXCRmg145flnPv4b2ofLBkij
 ipk4LayLN8HiEGEQWv9M4rWlh4ua0CpEGbFQPrNi8+cl/5val2x2EZI2abR8lOVHy7UE
 BzaoAmEgqp+Ba5wnKOGLqSAfwdq/VpscFxaqMnrLDXCoLh8X3IRgVRYmI7+kJvMChLRF
 VFNfFftp45rOqRuQ41SXUvhU6t4//Pzh6pLNBEAO9RrctpMGApoA5YXVj3P6ycAvNsaH
 lrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333792; x=1745938592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZGQgvHwQWyT1UXG05e/L40v1r7rbpXm4CP7YDA65nc=;
 b=idhfmSY3hOUJnx0K0mi6ZVLFVgrI8XtGPhmyGxk/mAJAy/5T8VL6/dSgC2HOXYtSQj
 zujKRfoXtdg+7U3gVGA6Hl17OKWeuSZyXPaPped6UkrfybPTZoNor1qOPCdS5Lp/PTwm
 nQrzXJieIVOJ6q7CvlViyLwb5MqUKtLGXSOC5MGnVz5beSUWn4cVSA6Q0kSPRrZ58w2p
 jCeyd/iSmCJtwEjLb5CFX2lXYB2wgMafIEkA9sGkO8uGz5sNPkCJtN0HtG0I0tm4cNTe
 fEHMjuMR8XJUNR91N2BiRqXGoL+4x8cIjdOUDod7K4KmFo+3ndhkK5Otow0KWKtIS57n
 C0fw==
X-Gm-Message-State: AOJu0YwoA8Am3ISZGJRgeF2I02ahPJ6pPKL+tjPy1soLIGxkCKoiswuZ
 uiEdybgS8lOiMIEZ2nXWht5Ci4hDpTKjunpc+w/UKSqtNW+pfh6bSOre6klgtiohbfkEGyETWZS
 y
X-Gm-Gg: ASbGnctysRJnXuLMuMzGxJuenXtIqQFXQoTNYjyY9sMLv2xPPMfkokBGAxeMwi5N5A7
 EgJMqaYvNCwo1Ro8wa2Zhsp28jLKij6n20uKguwqB2BDuX+wIThPqqCYNd64KJsh74cSbs6ecYq
 3wNeGv78wQzRabQ7xpFWspFe1RZNv4A65ImHI0zZG/j04hW20KJJfinww/c1buqU8Z7b53TcAfK
 FyvT4/IqQC9rQD1SqPKdHcVRwHDavC7+q59ym/tZmK2FnBgfLxJF4ZJIbx/hVGGQAzIQHKxyKtt
 ba8jM502rLlPUItxldKSmeZkraadFxSVvjmJZQDHkDAss/PPuvMGnfhFDdjEuNXhfcgRW1P5Mc0
 bd8m2gB6SZ4VsWhY=
X-Google-Smtp-Source: AGHT+IHlKhq7bTV/w/YkvEK+/CC8LEH+1P+r2wRxaxdVIz2qU2NX/p4+eMr8El0rldtuRRVviGG5hw==
X-Received: by 2002:a05:600c:4e4c:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-4406ab99615mr151313955e9.12.1745333791869; 
 Tue, 22 Apr 2025 07:56:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5ace47sm175128875e9.15.2025.04.22.07.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 19/19] hw/arm/virt: Get default CPU type at runtime
Date: Tue, 22 Apr 2025 16:55:01 +0200
Message-ID: <20250422145502.70770-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
This removes the last use of CONFIG_TCG in hw/arm/.
---
 hw/arm/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4e11272a3ac..df8dda812cc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3131,6 +3131,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static const char *virt_get_default_cpu_type(const MachineState *ms)
+{
+    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
+                         : ARM_CPU_TYPE_NAME("max");
+}
+
 static GSList *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GSList *vct = NULL;
@@ -3188,11 +3194,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
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


