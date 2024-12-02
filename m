Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FD2D7831E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6PN-0003td-Sf; Mon, 02 Dec 2024 08:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GV-0002Hr-4U
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003SN-DG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a45f05feso53403075e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145286; x=1733750086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te7O3NG5V4E3qWDfy7w3qXeqH4l7GoDjlHVXASIpOuQ=;
 b=poWayr43yRPT4x/xZ3vjV421rAX1L3T7Xf+ivcTu5dyzbGSH3dbVRqJSwfFlNKa/V1
 Zc/POjCe0UwaVseJVRkxeNRCAqkNyutD+CoEkVgbeXy6HUIgLF6biu4cvYKTHxQcvOE1
 /KBWXHK3/RYWEGC9OrxgL9O7aLE+Nq/MaCKpdweDg/iqmVOtrN1XmeftVuBDDdR2AfmJ
 +rM/sXyeGNAdMdSTCPQzVslpDdk3lzP3JxTLrxf3878Z7b+sffIEmTSsPJMGrRGWDCTg
 +/EGO0fSglkl8xGTo9NA/s9AyivdSPSYZWDvmgZATuFVDzITuzAXjp/AU4M3Rt4UCzYj
 brzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145286; x=1733750086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=te7O3NG5V4E3qWDfy7w3qXeqH4l7GoDjlHVXASIpOuQ=;
 b=Um1dc0pOHkcIu2o2d/nBU27a6Vw0GC5yd8G88HCSqAV+tEjjFnOwKhbBfkUoleR99t
 sZr+eqriFC2BPzwhFp7/Lea0tN/lAyA3Xny3c4REpIIjo96KCEcw6+ma+N7CnUAN9rDy
 t46PDfMPq85pccQTLpoBGheCjSTd4V2O/G83InSNYCBMKvJfoOCJE9KnVFAFtynMELo/
 DAhDB+VwxYFhbA7OqUmEtPyGZjK90tU1D4nxp0W+sOkJf/YLbefOLZ7lTnZHM0clOO4S
 ycfcboepZpasym7VUrPxGGBh87YLVW9XBg7VA4bsbr3G6+QzEedCDA2NgEvoxPqbLdV8
 s8iA==
X-Gm-Message-State: AOJu0Yx7lVfIxuCFzIZFeG/ZAPORumptBBah/Mp+RZsdVPIGQfK09F1p
 p5J6Fbd88aKCyP+CWD7eUJW+itTw7tYWKfMgMyVEShK5xib+79ZfJsS1AIiTIuedOti9zFrxD7x
 v
X-Gm-Gg: ASbGncsrg1uwFWvNmcXpfN7DtiVw880s7oC4OUnTXHn+XodsLh8q606wpOwvF5L4YTD
 /e6q0XRI5G099WNfUqUFAIMWIMTedTxESt6lcp1Q6CkPSkkXtT2+j1uKx3bGjkdCW0F/6D+3EQF
 EdIdcVBJO+RAjOdu0k8zSaVm9GUyCKIt7/dcz1XLJMXGBQ78v4DEZXmT7O9tYBsNp/UtJc0j7JD
 GDqZ4Vh5/GoRtuoXe2jDNmwZXgaZwVchFCmQMFovEWzRd7mg0MgUwM=
X-Google-Smtp-Source: AGHT+IEf4KTr6rXhAChzMFWXIj3WaT/CW+XO0OVRZDhylwrcuGoh4UWwf4XfaI2ZSMeNI4wXvw5KjA==
X-Received: by 2002:a05:600c:5021:b0:434:9fac:b157 with SMTP id
 5b1f17b1804b1-434a9dc37aamr253794695e9.13.1733145286002; 
 Mon, 02 Dec 2024 05:14:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 40/54] target/arm: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:33 +0000
Message-Id: <20241202131347.498124-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Set the default NaN pattern explicitly for the arm target.
This includes setting it for the old linux-user nwfpe emulation.
For nwfpe, our default doesn't match the real kernel, but we
avoid making a behaviour change in this commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/nwfpe/fpa11.c | 5 +++++
 target/arm/cpu.c             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 8356beb52c6..0f1afbd91df 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -69,6 +69,11 @@ void resetFPA11(void)
    * this late date.
    */
   set_float_2nan_prop_rule(float_2nan_prop_s_ab, &fpa11->fp_status);
+  /*
+   * Use the same default NaN value as Arm VFP. This doesn't match
+   * the Linux kernel's nwfpe emulation, which uses an all-1s value.
+   */
+  set_float_default_nan_pattern(0b01000000, &fpa11->fp_status);
 }
 
 void SetRoundingMode(const unsigned int opcode)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c81f6df3fca..4f7e18eb8e6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -179,6 +179,7 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *    the pseudocode function the arguments are in the order c, a, b.
  *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
  *    and the input NaN if it is signalling
+ *  * Default NaN has sign bit clear, msb frac bit set
  */
 static void arm_set_default_fp_behaviours(float_status *s)
 {
@@ -186,6 +187,7 @@ static void arm_set_default_fp_behaviours(float_status *s)
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
+    set_float_default_nan_pattern(0b01000000, s);
 }
 
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
-- 
2.34.1


