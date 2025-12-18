Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE2D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMHN-0001RB-Fa; Thu, 18 Dec 2025 17:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHM-0001Qy-EH
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHK-0006s6-Rx
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so9827865e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096121; x=1766700921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=rhvunxi4EkSYP423bvqUq5e2/TDRJl4zQzxul8bT+wqB+LC8joZbBdSYRI+EQeW1iA
 R1wjmEysaEtFAaPj9mDvEzcVLhzyq5mj1FxzluM3SDgnbIa5LArUC/HYVuhgR7C5JzBc
 9ySUNk/xuaWnxkva28LmYQ8P/jyKot4DKVa9UegUs7U2YkNRGida/T++Ug6qcTu829lV
 pBR1KMhikkZ7Tjx8IOrn15RjZvHA16Y4i3twdWg+Jaac81j15wSSsOjVoAO9wrOsKLeP
 5FPoeXhkqwyKWjpe2EHyrCjKoT26bID1E2wBn4tUpfcKjr39I22hhRWp9DOggzO3gSnn
 YlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096121; x=1766700921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=lUagjykw14Lg4tCOc5pPdZQNCilbgFPf+ZqBfA9/B9awHWliXn1xHvh47sKJaISS/E
 eLjHzhyFCtl/NBdo9q7OJRPTTJqCEB56f0einT0iEBA+DQDHkW6ytkEugin1Ad/iVh5p
 SnZv6La5N1Qv5Iwoj48PBD7U8LaaetnnmdPRz238ZyF5pqqgDRAoqXZv9W5935U051Rn
 pI54chLOtXeof3s+UElyjvfbRns6nm44VOs6hWw4qpiqiybza3/v9ujePg/U0194oOTB
 RRwpBeB89gYnlT8v3x8IHoA2L7ll97/LIo6IYAngAY94OESJWWqwX+OP5p1DE2+YuHLp
 eaHA==
X-Gm-Message-State: AOJu0Ywk/1qOrdjEiQC0ux3EEuW88Ej69EZv4X3UNVs0/OzW/r3yihaw
 Whg+G6Ux/f3WY8UN/YsoDBiz/4yQwQBV5Wyx5EI0gmg4DeiG3jS8Gm2bO1glJKi8xhRcPypjxar
 JlTmqMNo=
X-Gm-Gg: AY/fxX4QtKn7ej+7jiyY/SHNZkYOYV1lh5wDa80mCHsTZKkkeryYadOzQHjZUIR6G/s
 dSI+gFYvuCsHXMm4U5Lxkt9NzIERUbx4G+e+SR1dcnpK8+w42YwbuR+C+1MmeRizjCvjis1pTml
 ENzkmmB8CZX08/CYLLqCapigWm7NLMzycvdSyxTGc+IQATI14nO/Q8En7TbjenkzUM6Txx5mkB3
 Xd2ZrwZVHIroE1LeGlSKuPEK3nvQp9gmT2k3KEokGLqtD0T3FAGZae5FYt5lomPNLMjgpgnENDU
 TFqzQ5no8gXpd69qU17AzNKQnfjf2BYUPKLLcSqz5Y6LXROE6bsbbcnR+k6k13cDnlrNawsdIaR
 YSUY52mndHx+2E0fz8Cw0kn+vOg1oq0euOm+CtLivTOTFSKUWTYPk6r9/VVMglyc8AqJX/EOTzA
 4D6/SXjOZmWSD1RPOBSVFJCSHYflej5mt/EtEKWXlMbDkevQYF9EUbk30dGz8C
X-Google-Smtp-Source: AGHT+IF9r9wD37pALXoumTayaA1cnvyoFGw6iwe2sn2PSmDwMdr2E937layqGaCXcUUWMMvTyvR1QQ==
X-Received: by 2002:a05:600c:310e:b0:479:2a3c:f31a with SMTP id
 5b1f17b1804b1-47d1956eb70mr6361075e9.1.1766096117529; 
 Thu, 18 Dec 2025 14:15:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm63332855e9.3.2025.12.18.14.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
Date: Thu, 18 Dec 2025 23:14:53 +0100
Message-ID: <20251218221457.73341-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
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

Rather than ldtul_p() which uses the underlying 'unsigned
long' size, use the ldn() variant, passing the access size
as argument (evaluating TARGET_LONG_BITS / 8).

No need to use #ifdef'ry to check for TARGET_ABI32, since
it is 64-bit:

  $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
  configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
  configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
  configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64

Directly expand to the big-endian variant (with the '_be' suffix)
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 134617fb232..d265681f6d2 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-#if defined(TARGET_ABI32)
-    uint32_t tmp;
-
-    tmp = ldl_p(mem_buf);
-#else
-    target_ulong tmp;
-
-    tmp = ldtul_p(mem_buf);
-#endif
+    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
 
     if (n < 8) {
         /* g0..g7 */
@@ -170,7 +162,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #else
     else if (n < 64) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_be_p(mem_buf);
         if (n & 1) {
             env->fpr[(n - 32) / 2].l.lower = tmp;
         } else {
-- 
2.52.0


