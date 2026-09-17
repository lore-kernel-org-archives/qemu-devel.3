Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C2C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kc-0003T5-SP; Thu, 17 Sep 2026 00:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k5-0003Ce-18
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: from mail-pz2-x1d.google.com ([2607:f8b0:4864:3b::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jo-0006nI-F1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: by mail-pz2-x1d.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso258343a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619323; x=1790224123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e5JPmZJzpt96w73KehN/JsFKf4BffDhuPjFz5scKOmk=;
 b=rzV/7hDiR+gDEB8Zte5r4vCeYVAu7DbHOxhRx5OcaEvq38DpbRJ3f382FfpBIgXcLJ
 GYQrf8Odf975IZXDhf+ThLZTsNIr5Llo0YopsLbQYgKjbjOs3ow6MvTtK6E+rdlip1U7
 +Qw2ZyvypTpY9LKMBw60Uu1AjoK8TdQ/U8EuVu+Dk7IJSxEvHInRJFcmVHDRz6ex73Ea
 M/rwzbnP9G38visCgBnDYJJHF1XBo2gmdmfH6/mYFaGWKyLxJWqW590PjgYaHbndyBiR
 E1AJq3iYO4bvM8qAqMB/7BAaCd/o1zx70hSER5Cqsh2hF4jNw18ehlcG1UokcE4ChP4B
 9xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619323; x=1790224123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e5JPmZJzpt96w73KehN/JsFKf4BffDhuPjFz5scKOmk=;
 b=Rswp0R+HROgYyN13/V+N9z4NWp+cJWB/b7WbdYLprQb6fqvGR7eJkh/bfHO4isrzId
 3b+vto/ndlELyOEgtnsfQ69baycTHBgHluQbetF2hGykP2zl5cyhYZ2FNwklThWBDYw1
 0Wb0g7jXRYvtjGX2wFBZIIqEOSXE8gYTgeTL0KZIPIvmmWuU0G36TJ1o6rUU0KUkOuSY
 QQWCixdLo77rf/YCDAiYMZESLzq9bQqRyZg8Q9JTBO5rmz8K55rK6vzM8LZ8XtyOYYYj
 vdRzp7v1vRCWtbI+yhk/OXbjW7xozcu0jFePoVRtxcilo4gVUNuJ+4DFp/0at43HkqNF
 t3iA==
X-Gm-Message-State: AFuF++myKlhItMwqAUOaH9gQLPHW2NgYNslmqEkISo+MqrjKTik8yIyZ
 4kIfPLLnS7acePbK96rGbAeAiTn0z2hj7tPI4qVAXRUSPI93GIhhZAh8BFo3QwuA9ko1eseQMNu
 PtOfAvOo=
X-Gm-Gg: AYBFou0TOuLnFLLupmoiUQgtOB3x5yLwE/vURble5Cmc42xEvG7F7z8f/GDmtqRK9Kp
 5od4EbCwa85lZva5ioW+JzR3nHOgqleGzRmxjbuSKcOZQIJYq+2aQkLB//WP4LNrgPcnKBhPkDo
 JNP4V2V4nj8gtYsVEfNZv+3saIGwclueib0mKxZlj9BPsTLk72XwO66fTAc8JWvWvkHbO5N0X77
 hI29kNPMLSWPdHdh6UK2wEtv3wxyd1iRRgtMDPAhG3FjS0Ay6INZMLBdJjy4WPIb0dIXPf/GaES
 f6PpXbyclIeEUeD9FFj+qCyeO+0VCh7KCtXwmxvYPSMzxq31Iae4YOCb1IjDLsZVRO08mRhJrHe
 kOzcty9dNhv8opzNqyNZjlG4i0unAxPZboVC5Iled415WJdcvqsP03mtrM9LJ3C2XgYhF/s7Glm
 uJQXSbbBVng4/AEaZToxsTtlDgOlIvkCPZGaedidR4BJUzbzz0mDN7LxAK4Bo+Kw+PlQwk4lsxl
 seu8C4JmcHAOCnWR/Q=
X-Received: by 2002:a17:90b:4d0e:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e1e47abbbmr14117236a91.12.1789619322697; 
 Wed, 16 Sep 2026 21:28:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 015/101] tcg: Generic expansion of tcg_gen_subi_*
Date: Wed, 16 Sep 2026 18:26:57 -1000
Message-ID: <20260917042823.542588-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6be93865326..db5315a5cd5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index aac64105175..122a71d7c4a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index be0db3195c2..ba756d4aa69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -444,11 +449,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1571,11 +1571,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


