Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108E7C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pJ-00063p-K2; Thu, 17 Sep 2026 00:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nL-0001VC-UJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:25 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nK-0007E2-3p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:23 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso382937a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619540; x=1790224340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jHctAB//cJFPGP7zTANxE1gzaMaHznpNpHedhDZ/sXI=;
 b=DpYUoOHcEoYgn5zRtluJ9DOF1o9+XRMAw+Uu205b6u8ORfJZyelMLJ2ytF/yy4tJMf
 relGGivIehFERemwvt6Yd/ZQ5M2ol6hzeUn6pdUOSa2CA2Z+XojXsZWqyKkydJxBcwUg
 Ma4rZOeI+hB3Kq+2y6Zqt1XZH5xUhMs0R+b7tuBJTeDFEuOfKONj/d+cJYrFl+6dM71F
 Eq2NkGpCkRSCmtMWNMDP4hjIucPHQ5noi+hmskYxFM98eKLI7AvDuywYpNpjaOom8Ffg
 nGUvSDeBASUghbeqp/uhcY87ZZCKQYzNaDezrCCcuCNC8ZI/rW/Od+uDg/oAWAfOA+El
 Up+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619540; x=1790224340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jHctAB//cJFPGP7zTANxE1gzaMaHznpNpHedhDZ/sXI=;
 b=cBKrnFdh1KapIotLBQAWQDhDH5v8ckxxKWjerMtBzJlbr7IsDew8l70Gkp48lcpIGR
 Q+f9vc3Rhd2pee0BdZfWTE9ucaMIGFjh4PlHVoupmuFvsGamZFpDqcqV8d5npXyRuegb
 tP5cPgj7mdT+bb8drKDsRitQEgccFWRLvk7U+bprYWUtr+7KEjAaT2j9mONoPPhhs1Yq
 Np6bVfbRRIwreNPv8W9yr79W0PTVIOydDCI8MzB9rpawzkw25S7YIpOM7RoweMG78WfL
 ywpavKOjZC2e1lkyBKpTrMXYxva0Qy48bqVZX/np6Ftk9SsDnuyh9MiyTzpNOFYZPd95
 A0GQ==
X-Gm-Message-State: AFuF++lh+dxCWtk4ArsLYTIaXLkU5/8dx64IjrK+lzDRQt7UNX58wQRR
 WyheT3/a2EB6YMPmByce5jA2A6NCIrhB6yQZqgIKYyEssENZp3VWtBDfEBJBDoYP+9Ne77xQSMZ
 gPSt4apI=
X-Gm-Gg: AYBFou2G1Tp/rxZ+y7ZdHQps9K40dJ2WuUsBX9fuNnk0zax0iD2ler9bTe7F3if/mJs
 i4mrRiTaoIx2wm8EuGUytsenO2ae3eGLIzCy9vFXw85M3A9MgMGbUujZroiC5LwgBojgUYIuVt5
 bbsqIeoGG12mrVaChueFq/dBu4wdWsoDmut6xL1CuMlZgVFzsiPe245NejyhT2UUJOSZUP9Xqdd
 O6bp3BhnP8pMzJ9SwvjgW6Y/Lek53cicfKj4l1HvZLoNxkQOdjn3hHfbTivWCrP3L79k5UH49jt
 VO8lr6hdcEiBuqdZPbIxCB0F/+LvKMIBzz10TgmYRUsPeZ+yqcSaWWg4EFrvI2zRzX8E/40nP5r
 Gd0MCw3cOAa9zo+doEgVYJD5E2/ytVuwcP49ntPL1f0gBapy9dQR6BnyO5sBWuc87g44FmppK5A
 AxTqunzYiYPhC5GugUjUd8P3SYR0HcbcvS6OKkNQlqXFiEYkZEJiUJJp6J2Xb/eZB1aP/2qq/5y
 ERwEIM=
X-Received: by 2002:a05:6820:4b0e:b0:6be:6f42:3a86 with SMTP id
 006d021491bc7-6c7d44e8059mr5440064eaf.47.1789619540314; 
 Wed, 16 Sep 2026 21:32:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 051/101] tcg: Split out gen_extu_i32_i64
Date: Wed, 16 Sep 2026 18:27:33 -1000
Message-ID: <20260917042823.542588-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 801ea56498d..95685a86873 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -412,6 +412,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF6
 
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
  * Generic expansions for templated operations.
@@ -541,6 +542,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2285,8 +2291,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_extu_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


