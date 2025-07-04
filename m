Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F16C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhL1-0001ZB-TD; Fri, 04 Jul 2025 10:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIJ-0005GC-Ka
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIG-0005jk-N2
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:39 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c47631b4cso861046a34.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638895; x=1752243695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4U0q/GIZDIM1qKxpzjtQMthSMqQD0Hh4uuMO2n3mIoY=;
 b=MOsYypxEKWa4zycFxgDk5eKj9Cxtj0NwUXInlPbgwNIrS3em0K1Y69g1oIHP81/YcO
 MEnwOXlauFjwHE7on55blOlitSm590Cexa3AmCZk9ejtg6Jhu5/M6eHazkNKf/dSYruA
 rFNpalAD0RfHUG6S2UZYqkfwN+tIDj0P2moVFK0QRVIdDeFw6B6IXawmsVJwv5jEz3JC
 EVjawrqK1VvEJwze9zDIBY0r8FdgqsUSKCJs0GNSMGCvMeGH687iKPDfXBaQzZ3fBiq8
 d6pvcpZhzgqVhZdn/qXhV9RnBCpGlIjLtYe8bjbdjmmjNRjeeeDk0oinV9y9uWJzmTZu
 YzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638895; x=1752243695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4U0q/GIZDIM1qKxpzjtQMthSMqQD0Hh4uuMO2n3mIoY=;
 b=og64b9gPdUcfuDlncY+WuwtUw7Ydez2qs9I5rJYEb92EbU+xturqaCZxdc1V6jTUam
 Re39QdYy71R3m7OLOOd4pdkQv3l5pnywlGuYsiFxVbmhTNj+HrMCOpRoIFy8BzmW8kqv
 Nj7zzOxXpkqfnkDMSIZT91MReONdCqhnF7zthY0H7T2DVsXjy3m5+jNnjHpUYbGk5t+f
 VTJRYi2NIQo2X8LdPdI8GoUH9Mf2xntMolnOMi4snUWbTknDlF2ghfozfE0rkJ8r1PtV
 1h+yKlRat5jiDPdSEa6yzYPecqEMPxdRGAafBxBFUyyrg+GAEEvpUqEypJYNnXqhz5hY
 PdQA==
X-Gm-Message-State: AOJu0YxYujHx/ZXwOJERo+E5LjtPl4KscxcV60YnpiuNotAkAIa2UJzM
 zcc8nyhMU6QGhUyqKyfdJF4YAbruWcEkktlbYyMd/sQhJZZ0sqSSnHVhBUGuuxqnQh4iLZcZhsc
 4SHX/cEM=
X-Gm-Gg: ASbGncvSo3V5/nfyyLr8EoqsQmPZpqELmcOFH/Gvw/freQ3cv/AX27+AwZ029ewXHbW
 +GVIVXXKeCzuH3j9bRupLXP3alDDGvdi+aNFei4jKW9PNvxZqlFcsXSLBjKXUtXSQAqS9MA6I8Y
 vq+A9I3g2gDWr/FoD7PtA1aUE/Triz3gP1Xw5D7joEqU156t7D0ZAgbgWk5euIjVXyvxk4nNHkN
 LIjEiEKshNyLzseH0PosALbkKXC3SYghZofE8JEadnaZ7oss7ERK5wG+5Btj1Cmq2rTLg1FjLXz
 wZd+8/Nt67UeU88u9f5Ml7njk+9/di9v/Eb8Z7dlh5dbCLsarttvCb8+r2oNEdK0p4qyJqkRV4L
 /Vy+jt/6tZy2MbBS0qkoAdcj+IGcMtoTX5dMdVaIzZylrKFZQ
X-Google-Smtp-Source: AGHT+IEHBjF+Zmv1s12wxT5/RvpvraO4SmZz7yUL1wj9a0ZsrLMe1CAGp1vFgK02/xL0HGsoVHQRbA==
X-Received: by 2002:a05:6830:4188:b0:739:fae0:73c6 with SMTP id
 46e09a7af769-73ca6797bbfmr1550975a34.25.1751638895443; 
 Fri, 04 Jul 2025 07:21:35 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 019/108] target/arm: Implement SME2 LDR/STR ZT0
Date: Fri,  4 Jul 2025 08:19:42 -0600
Message-ID: <20250704142112.1018902-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1dbd0199af..9f25273992 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -292,6 +292,19 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
 TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
 
+static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
+{
+    if (sme2_zt0_enabled_check(s)) {
+        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
+           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
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


