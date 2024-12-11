Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EBAE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhq-0001YU-Bc; Wed, 11 Dec 2024 11:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhT-0000S2-Tm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:36 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhS-0002Dz-44
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:35 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e9586b82so108408185a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934993; x=1734539793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5H3jwXfSbdwnrjmx1RnKwqYLaWQdsoJQozLgKgKkG/o=;
 b=HyHBxhX3wQISuGjFraVHytqOY524Bvyy5nXUh0RQiGONhNcdk9i0gb3tfpz+SlWRDb
 p6AaAQj3OfPEuovCLaGUOg1urvJGzLM8nQUNRpoiQl4VEzdtl0DljxnJ7M7KAWR2NkuO
 1KCNOoyYm9IXQV6NsAnKVw+3I3tTeaK6uhqRJq/NeAmcjqmWmnphjBo88KXq6BdN5NdO
 d5kg4sSg3Q/YM9ZnPON9AOR+tqZugPIPJYSOFLxtzN8rzER3r9rnExTTcCaPZKvrKSCE
 bOSPARwXjL42kpXakeOABgLKHjEZhHi0mm944GTTli7Qf+86gusBUjsG0n9H2PkRn0Fb
 h6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934993; x=1734539793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5H3jwXfSbdwnrjmx1RnKwqYLaWQdsoJQozLgKgKkG/o=;
 b=kfj0Z0rjsPSnBpw7i7zF9YUFjPfWLlV1qCo2TJAuNheIzFxZoKuTpqeIyBa7HLkkOS
 IJbz3kBoDDJOSs7Z977hPyKeNsB+ibEC92OQQxFx5PJc4uEodkAYRdG3RfWEeG68p4An
 XtCfBSHodbZQZ5XmTZJeIkrruZ5WrQ8isPVWNFrFDzq0F0eRxsf4yVRHTvRkqU7b1ItE
 QVI01RwJrJvhEb+dZonAfmKGCJqg8x0lp7GJGrxQuoGlCZpex2LMNblPIyuC6Hnc2UM5
 WWEERkCc7aJQuMTTa9GviIBSTTSIRVE7N792WQvtvi0IbEF6H2meT2yDLd1d2Hh8ZhHD
 XGNw==
X-Gm-Message-State: AOJu0YxsfSCdIAq5JKJYte4MLW8B4tRl5DgUVWtEkRGQ/0De4zqX3xRP
 Ppa5cdmbTqJkyifpGiDS1uxbXaMbMsq+QotLSZilzZwqg/gOF4keItn8s/g/I8z2hHP4IgVyPt5
 8ncAbXgt0
X-Gm-Gg: ASbGnctTNJ8oQGz8ehaeeAG8GJgPzFO0Dz+ljXXY/a93SmsGbvLZJ4FcSsMUw6Nca2s
 YQ/lnHVq60Q9IkE4tIax9aDX3sQILLOn3vNVyB4rHAqUfGyz7hINyNtBt7ZhCI+rqVOEuA7n1kU
 B0HnDi0XcRiCc675pqkA2Y135LWO7fKJ2B/clAxgWwepV0ADXz+F7UBj2L+z9WKf1wcepxRvdrE
 uG5IG8UI/BxS0Xyzjp12M3WDYV2iZwtXd5vBHwevwzVoh/ZgEm0o2O9h4kHqA==
X-Google-Smtp-Source: AGHT+IFaI7BdseejO4SIxCWxJ1ovsB8SFzMlt2imqHmL2J0jY/XPrGRtH5GVhqcQDo8MTCZTk65QLA==
X-Received: by 2002:a05:6214:d87:b0:6d8:7d6b:cb78 with SMTP id
 6a1803df08f44-6d934ba8d99mr66207276d6.47.1733934992912; 
 Wed, 11 Dec 2024 08:36:32 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 53/69] target/arm: Implement gen_gvec_fabs, gen_gvec_fneg
Date: Wed, 11 Dec 2024 10:30:20 -0600
Message-ID: <20241211163036.2297116-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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

Move the current implementation out of translate-neon.c,
and extend to handle all element sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  6 ++++++
 target/arm/tcg/gengvec.c        | 14 ++++++++++++++
 target/arm/tcg/translate-neon.c | 20 ++------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index edd775d564..b996de2c15 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -602,6 +602,12 @@ void gen_gvec_uaddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                      uint32_t opr_sz, uint32_t max_sz);
 
+/* These exclusively manipulate the sign bit. */
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 2755da8ac7..01c9d5436d 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2697,3 +2697,17 @@ void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_andi(vece, dofs, aofs, s_bit - 1, oprsz, maxsz);
+}
+
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 0821f10fad..b9b3d1c1fb 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3041,14 +3041,6 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
     return true;
 }
 
-static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_andi(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x7fff : 0x7fffffff,
-                      oprsz, maxsz);
-}
-
 static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
 {
     if (a->size == MO_16) {
@@ -3058,15 +3050,7 @@ static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VABS_F);
-}
-
-static void gen_VNEG_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_xori(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x8000 : 0x80000000,
-                      oprsz, maxsz);
+    return do_2misc_vec(s, a, gen_gvec_fabs);
 }
 
 static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3062,7 @@ static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VNEG_F);
+    return do_2misc_vec(s, a, gen_gvec_fneg);
 }
 
 static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
-- 
2.43.0


