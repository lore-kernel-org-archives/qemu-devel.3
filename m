Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C629CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCz-0000uG-LA; Wed, 08 Oct 2025 18:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCc-00009g-4q
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCL-0007MU-9d
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so316191b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960784; x=1760565584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UArNSBfDRY0R4yQf7I4KwaZGkKosB9HEkNsmXAhE3vY=;
 b=P3Kp6OXPU2vSiN6VOwSrYakw0f73OGUmVaj4Yaw9sODUKnkCokURmVE5/jXi21nIUA
 5AD02o4DYzxKYKiDqEn/NTu1X5LTmMRk8DCY49fuwSXtYgGbaQugmBMghxy1LIf1XfXB
 MI9R+/uyBGCOBX7DHGRKDX3364mSArydcbzOrR6Rg8xtvT+tKiE9xwsIRqBOy38cyqWd
 HkSL+QrzbhY1HCto6Nrx3cTQ46FrM/7ygI27phWesyeTgZVe/GM5InJEKhqe0PjXMS7L
 TDnWlxSjXioS1c2CR9VUVo+28JfRmEK9jMdMZcH89WiwbXFvurGeHzOlrnUR+txos+Ba
 BQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960784; x=1760565584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UArNSBfDRY0R4yQf7I4KwaZGkKosB9HEkNsmXAhE3vY=;
 b=bYQfO2edfDwKsb0las4lEig+siS0xB6MVsEX6k0cPZpGF4QMR+5ylImj6XW+xS021s
 j7aSIcx2mF0C4KDTDRM65JF2XXI7k0JVmYozNWkgRs+HDowuKggW6RYKhHsfBAGKJy8x
 IlJJlYH+j+1T5uNGp0fOG7e7KGAKzElpXHhVwLzI+AwqWQST8dyEM5F2KVummSq/Q/HS
 AD9h34tdkAiD/gangpTJh1y9wnOIwmsTySs3BwVD25AGJpjMMjSedVUqd7sUEdio0Kuj
 4b2fTMCyJqHgSjZYz9tlupoKKYXGbsQGd7py27MVfC1isuUh2FhVYyyIkgi2rV7JCEHe
 H3+g==
X-Gm-Message-State: AOJu0YzjCctwwPGLnaEajr8zKB3yQnpygG9nB2HNfqYwoMw93OODh1Ak
 +IbuCuRKe7CD9iP46TwLx0lYOVLaa7LrTch75T/5kTJsHe/1uzx6W/ahpK82uOcyq8AM4S1Pn8Y
 7cro9X70=
X-Gm-Gg: ASbGncvvaaPrLFan7DxyA+Yrg+7O9rGVVxESd7pSskqKguWFEqBDZVGDgVxHMTJyJuV
 GSfH/EhnpujJg4WOBW4FTLM548iz6dbDvg/KQkxyyeiypCBMOVlilgCQBPpFMponS93ap4IZtmT
 Did+k39dC5P0SlbNw9Z9cDNb84Hxp8SkAbtKE2Mm5pkzQb/KZ0iL11Dk7QDr8zNmHvhX1qnDOJz
 o5V/WJfVEj7930pt8KGdo1TJ8Ci3noUVRYZS8eXbvTTTEw/92l7EdxwNXTxOQluLCD8hNIqiVzT
 d1jWeKvcSwuCpcCBqJcJnb+3LB2XbAqqFi9atdDLVEzGCARvhEs+22Ljtz2KQD+1f4fm/i/sRiG
 rOjIQJ84EbAV7ukXfsJ3tTthtunphhVnvXeuDs+CSLzmqOF3yOI1EbH3y
X-Google-Smtp-Source: AGHT+IHDYSXBY2nqTbZ/E6lxh07CwYunJc73WC45dNj3FIN75MB8pniTkwtM3ZQdNHQVkyfrTnZOhg==
X-Received: by 2002:a05:6a00:189a:b0:77f:2dc4:4c16 with SMTP id
 d2e1a72fcca58-79387440592mr5825893b3a.21.1759960784071; 
 Wed, 08 Oct 2025 14:59:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 45/73] target/arm: Emit v7m LTPSIZE exception out of line
Date: Wed,  8 Oct 2025 14:55:45 -0700
Message-ID: <20251008215613.300150-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 57bc8ea4c5..3df0bbcb7f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5598,11 +5598,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


