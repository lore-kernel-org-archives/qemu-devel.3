Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEC0C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80b-0007SA-KH; Thu, 06 Feb 2025 14:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80B-0007D8-Mc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:31 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg809-0000VY-SR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:31 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9d5e0e365so2017546a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871848; x=1739476648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PddwxWDB2j+zcRTwEZIk3BbnocBq9Wkl88ZErJ2pTF8=;
 b=fzf+dAgqdBYSGRkZJ1bqui76s4Dm2SSU+V6hm+i9MPcGkYxre0GBgo0mlP8HwihMDp
 f/BEwTe/hyXMoyMJUrWJTkhyesXyD5YpgkQP7IM/NzfTy39kgAoOEiupLoIV+wriYuqb
 Rmb8K7MOEr0aUhOqFI3QYZPvCSG0SWD0urDwifhry9lqsxEkG/gKIBay35Lpla2Hc839
 YTWfQBCer6j9ZvwItFTWE/bxKod+SEEzwZgMrwPsREJUAOeX4c6e40+BLd9iXCD39WmQ
 q1ZW17y3yvvrgwE/utNDk9lLE39+jleVK3mrlFJVYCTMhUmXiAcFEX4zG8vivw4c/RNx
 SfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871848; x=1739476648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PddwxWDB2j+zcRTwEZIk3BbnocBq9Wkl88ZErJ2pTF8=;
 b=ZYiBUSEqqwy7jBdmHYIeDhr5sVhtUJ6BVGl+32GxQn/idtflbrJjqq64MsaifbVmiw
 OooM79ub/HxX/1lm0c8TH1F7VR7EG8Yxz44qIofoYi5aCZM7DDdVQWs1ZvhC/M8dpD1k
 FTj5QluvLvCxGfJys2rpXdmRECCsD9PjxoVKCEu7bbovZ9Dyk8qO1r+ZapiWaV8rpN+O
 yklTkuCl5G+dNWqaLGD7TAs0vZXAH51rHkh58aqHG3QkTODCs66NJ5XC0l/29afvWv6i
 k4RRbF2ycbSNEg5lxLCfBDGo4xO5pLALZvh0OwJBf5web/74IEdfLnB6ETX5suO7gUnw
 cvlg==
X-Gm-Message-State: AOJu0YyYHW8i7tbcq15sn8yJYLZ75796gTQQ2o4DNXaDbkXuSNJQCOSG
 XeVhEM4O6swlBnFXN379VBDvCFD1GP/OcrKYYG9J8zuMa+8DrNsYKDA3E6MfFNGbIAh730rRns4
 X
X-Gm-Gg: ASbGncusOR10e+KZRS2P0WSXBSD9Su+tLriCHP2iBySvBjsf/uglBYOIZ83IE29IoRf
 TeI2XVmFxLrrgO5ZZc2XQ88yja36QDW4ZvSbazHpdGuyC4cGOFOvjGf5YNuWUG9cOj+U/Qmnvw3
 smXltQBmn6wfsp70zUzaWm+vDQb4Em1YnkGMwg2D4bVNkwniSg2rbthWsh8eX49x7lSEtloH2Yc
 wEG8QH5hl3VmWCzvR++ZIlPxFEOPmx875So5+GC8n6LTvcGhy+YqAg7UuIjl9oXmkMHesAabXTR
 Lt89hu8Ocw8mVKWD8LxLNwIL6qm2bqqXTUOWJHBdwIqa/KY=
X-Google-Smtp-Source: AGHT+IFR+UWyz1G66bdmidcW1L9iau7g9uSL6HF3go0onL3uVacKDew3leOZz1Ok4K+qU7kZt7nybg==
X-Received: by 2002:a05:6a00:cd1:b0:71e:2a0:b0b8 with SMTP id
 d2e1a72fcca58-7305d426c9dmr780647b3a.1.1738871848358; 
 Thu, 06 Feb 2025 11:57:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/61] target/arm: Implement SME2 LDR/STR ZT0
Date: Thu,  6 Feb 2025 11:56:30 -0800
Message-ID: <20250206195715.2150758-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 ++++++++++++
 target/arm/tcg/sme.decode      |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 37f4d341f0..8b0a33e2ae 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -291,6 +291,18 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
 TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
 
+static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
+{
+    if (sme2_zt0_enabled_check(s)) {
+        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
+           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0);
+    }
+    return true;
+}
+
+TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
+TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)
+
 static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
                     gen_helper_gvec_4 *fn)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dd1f983941..cef49c3b29 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -55,6 +55,12 @@ LDST1           1110000 111     st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
 LDR             1110000 100 0 000000 .. 000 ..... 0 ....        @ldstr
 STR             1110000 100 1 000000 .. 000 ..... 0 ....        @ldstr
 
+&ldstzt0        rn
+@ldstzt0        ....... ... . ...... .. ... rn:5  .....         &ldstzt0
+
+LDR_zt0         1110000 100 0 111111 00 000 ..... 00000         @ldstzt0
+STR_zt0         1110000 100 1 111111 00 000 ..... 00000         @ldstzt0
+
 ### SME Add Vector to Array
 
 &adda           zad zn pm pn
-- 
2.43.0


