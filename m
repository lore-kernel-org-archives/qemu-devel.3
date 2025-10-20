Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451DCCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyAV-000059-Cf; Mon, 20 Oct 2025 18:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAS-0008VX-SX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAR-0006r4-7z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso36144655e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998549; x=1761603349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBTAuW6Tw5l0ezLshjv9+xZpGsbr06m2Rp6ie1NmAYA=;
 b=cVW5jaWLLjWKq3piN0FxuvX5DEjjWZDrMdu4CS31/wDduNJ+jldil+Pdy5fM4LmSue
 xGSRRxXiXh55j+Ynh2EpZJq3fXML3n12uaAwpkLYHWxdKy3huvCPHQJxHa2Kl+HwdqRN
 vhIDfajqZgAQKqDpnrfSEUkzg3rnhpoTsci6m60Fo4to9fyZjxD/UNn0QUDIkotB2Onx
 hlm2zqqaeEe8Gfdi/jVEnJJjAlWbiFzaOOwtvK8aMdUITDdzTtWT24QGHok6HbL8XWYo
 Nwg13nJRxw7tVD2mL4Hcc1cRtXhV7kCQ+WKKCFgsP9B1zgJQiSygkoYd0rsxXUojNzg/
 AAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998549; x=1761603349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBTAuW6Tw5l0ezLshjv9+xZpGsbr06m2Rp6ie1NmAYA=;
 b=Il+wjMlEEarxlMsKDPGhY9GIaOBAJjX8f50/MFw8pbCmINj8blAjiX/lGzppGRALy+
 nVWsIzRKEbHtU5hJYIQ47Qvp/F20kiTNLfdaEZR5af3oDQxphon2Xd6altIOF8smHjSC
 rZaYNyBw19vAkeMBx23tkA/+5LgIg6xgP62sznkdTuHep54TP72Die0Xoq4kMN6eIhl9
 VKQ0ub6P08ZSH/xQduHyudTQprSn7BNIEDj869DNzdT+fSrx+aA09UTqTovhRsc5sJuw
 JEVht9B3kv2pKkXFsde/dktrx7Gx0Biw80biq5jQgqF4Yvu+WJ+v6NxXcuwaEH/9SNo+
 ITZQ==
X-Gm-Message-State: AOJu0YxajohYHtddsbj885QPXbeEKjpoqKQRkZzK8c6RhMp52WLkhczG
 ZT6Fs2Xs9oNRkK0i/1ELIwPlaM9xDKEKUZl2DC/aGEnlJMdS3NY1cHoPnTzX171+4QWpUjSwtk0
 qFcGkp4Q=
X-Gm-Gg: ASbGncvMB3czaINMCxZPeyeI11bPPdqYcVMxm2OpKu5tbxzb6z1J86c0Hz1qnnKLFKz
 /5xVyFc2wkCKbdMaUrAxKJeATC4YvyEjiAtFAh3F4VhSlzJ2fnb79NLfMiUFsgjo7dYGGHHObbw
 leW4NY8ppXwr7tQrMKIW/+CCUqDMfXWGjf+h0VBMbV0AivNgagONmD5tZvHP7hv8hwUEB0mOnEJ
 wn6DCHHvSWBZU6/C01vtNkwmTN3Gy3l3rImgwejLf3rnxgnq3HnCUHaOOhJgZHn+Pqg+ihAVsqc
 RcJzsHot70RqMCTFngcswTFPC0YilmNt6oKf+iRv2Z76eqAoLc3Yg7Ccp3WJASOc3kbTtfT1SD7
 E7+qylZ6nU8qJVzk223uakdKybzjIKXTp1GHW76WMu/Lo2tvnup2ORu+ZYyXYIqLUl1XVmie3la
 yEDrgy9bxuMSIkMWFvByl6ND2yOyg9xST/bHe/NZUk9rubOnPauXaMEKNIdpmWPsdTiN78ab4=
X-Google-Smtp-Source: AGHT+IGxLMFDWIw7332XrRXO/a5kNnrvLGw6NCNmWReWLdnMm6H/hRQA3eVFw8xsr13Q0sgF+eH39w==
X-Received: by 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47117907234mr114451835e9.19.1760998549072; 
 Mon, 20 Oct 2025 15:15:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471556e17afsm160050605e9.17.2025.10.20.15.15.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhang Chen <zhangckid@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 23/30] hw/arm/virt: Get default CPU type at runtime
Date: Tue, 21 Oct 2025 00:15:01 +0200
Message-ID: <20251020221508.67413-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/arm/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dda8edb2745..d07cfe16512 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3257,6 +3257,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
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
@@ -3312,11 +3318,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
2.51.0


