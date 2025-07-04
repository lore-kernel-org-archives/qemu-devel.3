Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B6BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhKy-00018S-Hw; Fri, 04 Jul 2025 10:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIK-0005GH-04
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIH-0005kZ-Gx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:39 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-735b9d558f9so292399a34.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638896; x=1752243696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH6Ad5BaJtxdBkiinUY7/X5vKVIV/ggzsySF13b5Img=;
 b=UzQHZiyHkxy4OhCPIdANQp4KSck4L3HWNMrE22kSyxhqPhsb65usz6yl35qy77Ivjn
 6AeVp/KpmHXnOLwR8ZfR7fuwbxH9JKM2AlBENUZnFqbSfjYCh/mj7iDiKs0WqfL2AXTL
 6l4NTXx7wRc1QH86mepDEqQQOd2CDBS8Nwr+FQ+VzC0pgq8f/wp+5wnDINpsu7ZE21x5
 fmIywxDG+y5scrhM1GL/By5dSrKQya/gkF6rd9PXxa608e+1Kk264Mr8qn4N0FqixqgS
 6MkbmQWg7JzvFP9K4hFx2NsXZqW8xdAdLTex/9GHmxBde205bvkE9V9ReAWn/XzkVo3L
 DjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638896; x=1752243696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GH6Ad5BaJtxdBkiinUY7/X5vKVIV/ggzsySF13b5Img=;
 b=iUY7txMgaCAl4es7hws/h/GvWoeFq7NuiZjyBR8E8YEIEpINr7L/sSC53pRU0fAdZk
 QebiSiVfcB9D+ayYCfRBsoYS3rEZXSnvkW+l3OdiLXh7ygLwC3QdoTGJhfIYUL1/NaCK
 nbAqbcUgd1DzRvpDTB9bDlxAuuexLUcC4Uh256TeFxGEB3y724ECLHMy9aHAzZXAUUTN
 03VaZXNKykPWBVFwnF0P1pvS4OoahQUk5oKae0t6mgPP+gz/cpjcEkVmQSMm6Tv/rZ2K
 TM05KUtZLI+DycL/Fziqr6Q1wqRlQNc4tavPDxZVWN2wwonmpdHL5Z8tZWHoyu9UzWhm
 oJHg==
X-Gm-Message-State: AOJu0Ywdyy8LdsjRrtMcKspe/IWz5WiDdrmbB+WaV0CvZU8c5IhO/rUv
 6a6b5amN630QLVaTVRcQE421KXQsgoyCj1u+/zg67Ri+ZbwQCJuS+4jBO7s4tItNa/vCeQJtayR
 vJfBOk4g=
X-Gm-Gg: ASbGncsokUviUYcsuHEx9zBr2KL7noKkB382wjjXnPEdEkBZ9HqH5g6ICLMHFEWpepv
 xxQfEKICfcVorDA91p+fqb5LSdYJbJifk+xT3pmcurtGzesCF/+ZafbalnIA/IJVz+ij278l98s
 7odBViTi7uEHyYWps2YfZK7yht6nZC43x1cM60yJmk64K6XmE0l4htdaOneS/s1sBysANQKJ69D
 6xvTM86sGGtfvO7H3Hb3c1qr8Y8UTn0h7I3Xx0UdxwQDyqgFwoaUbzvMukL2qsAH14qSTAfZrRG
 5R2eczmUCTbip5Dc1Wu6QxSSC3p/g7Mfw0blzFwP8KyOHuhYipELaFVDyN83fMwUt54CyNmDi/A
 r6m/ysXXjo2Jr6YG2GKq/GtLnik2FtUuAZ6kjzfA69tiV7Ouz
X-Google-Smtp-Source: AGHT+IGDyLglTYGBNlQUtAuzAlW9rCAqvEhCHp/z7yardxzYqEuMWcZ8JkU2QqXpBCpynsTQZrkFKQ==
X-Received: by 2002:a05:6830:2c05:b0:731:cac7:364e with SMTP id
 46e09a7af769-73ca49fe83dmr1546684a34.22.1751638896224; 
 Fri, 04 Jul 2025 07:21:36 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 020/108] target/arm: Implement SME2 MOVT
Date: Fri,  4 Jul 2025 08:19:43 -0600
Message-ID: <20250704142112.1018902-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9f25273992..797035e289 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -210,6 +210,19 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
+                    void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    if (sme2_zt0_enabled_check(s)) {
+        func(cpu_reg(s, a->rt), tcg_env,
+             offsetof(CPUARMState, za_state.zt0) + a->off * 8);
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
+TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index cef49c3b29..83ca6a9104 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -39,6 +39,11 @@ MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
 MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
                 &mova to_vec=1 rs=%mova_rs esz=4
 
+### SME Move into/from ZT0
+
+MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
+MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za_imm v:bool st:bool
-- 
2.43.0


