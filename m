Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B17C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSRs-0006do-TQ; Mon, 28 Jul 2025 14:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPE-0004oB-Po
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPC-0002nM-8S
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:16:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74924255af4so4082559b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726615; x=1754331415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgBv65Z2rjw8eC4JsFEOBVOQJ/V7KcAOuWdy7wLNyvM=;
 b=nYT50mggk9qP71iO+Hj1tbbT0k17sTLsggKmWKIrf/BC0a4tIhDC0F+JcXpFCe8eca
 4UdolKhJy0SMchR2wieRIK0wJ6lMzprvAJrRA9O/6vmXlh+vWL7SYWBCuTn/VL1dOJMx
 zX21xWY+bxxw9Jxy0fuQmLcV4RGs4a67ZoBnSb3eFMXot2D4n3lkUHBiEn3cV6IM7rq/
 1zoRlsZ3JjaQcxTX9asDkI/c2a4SoeK+NEECK7dxPetw6q/1f8WB7L47dixrKe/sthQ/
 NLfUxjBlSymggKbn/8uVSpjh1OEeCFciltX+ObeFKfaOoco44MiugSN46wPbz0n5XpQW
 f0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726615; x=1754331415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgBv65Z2rjw8eC4JsFEOBVOQJ/V7KcAOuWdy7wLNyvM=;
 b=pFJyPceTQIzgESPMtsUpjPtLLSOoy3X3zgY0IkNpeuZlzlP2SrkCrPX+aiOHneZzzn
 tQ4uY2IyQxIHnHnXExbghHI3aCr8+YWmdXZcOsmv/nzzRZksLLUp4ASx8m5rHI0ydDcA
 ERs0gDMSSnaPzn9eEDZnbpQg07fo7TAr/c7Q8xz+ZdgZn9n2ZQkU5nJS1tAmx8QdkASR
 5HIBaxfRJB79eM+/f3dr5j6APRMZNaV80CZH7sW9gX+0PWNFefyJckfmStYyNE+RJtXo
 urDiqStBnxcKh+GHwSRHKxBLMYC85zDxPhUCjARbO7J1UZKFxMG2TUFF9fx74pMUf0DN
 CpWQ==
X-Gm-Message-State: AOJu0YzS61YX3k/Fr31Ny9WA6N47/9aBS3RGzqUN84gQ1b1o8HXwv7KH
 Ag8xita+FZkoUa5opRt9wXi68/FElZRrtAXtwqAsBW2uhF8bsFgsOGUStYm5eOHzQxQpYlIfEWH
 wdU76
X-Gm-Gg: ASbGncuB73ADPwteRA24RbPk9trkcb/tHSZ9q5KMZd0YIZ4tOGlsMcYaRl9xbIc5ab1
 C1/v8iyV3Nx3on1uili0kctFHXnBNdsO6OWE52OGxRK0j0clkWZGACDP/ZHU8mMkdzbJvMVjW8k
 jsQ2Oq7H8A1FsopQB+ti3pTtSNfcCDhdF6hoiEjF76pHnnzsR2M+buUubBkQvlJvNOppjW8kIx9
 T67jFhm7LJ06lHwHlin7PAfTxgXljm8A0bC3QZyAbpyiGB02+RKU3pfHWyjyU3Ws8VBRAuXbSV2
 BcepBIdsi86efveiaJemdDxZhySfidXguM+44dc+xx9Lb/+XPpCOt3Y3dkJlXslmjqaZ+BVTqDR
 VAbVYcRJFZClcU0fHdINRC3hvp0Hmb5npbfZNufi0/Q5pXxS+cMtNrVbmtMbxDCP2D4wvZLQuZg
 vxdwI4s5kPTA==
X-Google-Smtp-Source: AGHT+IHwCOzZUHW/DBTEImUBd1KncTsOmaR5qXTSOXFqG3AixOhPyQhU207/anZeQERPXoKIdQBSKg==
X-Received: by 2002:a05:6a20:7f8e:b0:23d:6a77:78c9 with SMTP id
 adf61e73a8af0-23d70016273mr21093105637.7.1753726614885; 
 Mon, 28 Jul 2025 11:16:54 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:16:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/9] target/arm/sme: Reorg SME access handling in
 handle_msr_i()
Date: Mon, 28 Jul 2025 08:16:42 -1000
Message-ID: <20250728181650.165114-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-2-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 535ca76425fc1ffa4311b3a47518b06c596a55c6)
---
 target/arm/translate-a64.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7210a9cc4d..b66561a5cf 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1855,18 +1855,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
             goto do_unallocated;
         }
         if (sme_access_check(s)) {
-            bool i = crm & 1;
-            bool changed = false;
+            int old = s->pstate_sm | (s->pstate_za << 1);
+            int new = (crm & 1) * 3;
+            int msk = (crm >> 1) & 3;
 
-            if ((crm & 2) && i != s->pstate_sm) {
-                gen_helper_set_pstate_sm(cpu_env, tcg_constant_i32(i));
-                changed = true;
-            }
-            if ((crm & 4) && i != s->pstate_za) {
-                gen_helper_set_pstate_za(cpu_env, tcg_constant_i32(i));
-                changed = true;
-            }
-            if (changed) {
+            if ((old ^ new) & msk) {
+                /* At least one bit changes. */
+                bool i = crm & 1;
+
+                if ((crm & 2) && i != s->pstate_sm) {
+                    gen_helper_set_pstate_sm(cpu_env, tcg_constant_i32(i));
+                }
+                if ((crm & 4) && i != s->pstate_za) {
+                    gen_helper_set_pstate_za(cpu_env, tcg_constant_i32(i));
+                }
                 gen_rebuild_hflags(s);
             } else {
                 s->base.is_jmp = DISAS_NEXT;
-- 
2.43.0


