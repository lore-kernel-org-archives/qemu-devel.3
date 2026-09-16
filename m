Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713F0C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOP-0000e0-JL; Wed, 16 Sep 2026 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNf-0007Iv-EP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNd-0001YS-EG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2db710396ffso17071145ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564132; x=1790168932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l4obvJtSnioODCzECek1RrGUuUO0M4fUpyaE9GEjHrM=;
 b=KNXSbWz63Vr4IwqZpn6jl+n8kOCDrZgMyEa28i8owZKcyjeZ/MqhZBTjlxgaandvLK
 /h9gIGiFqoVuK92kShSehYOUewykWQhKU7c1Zn81VCof/+qmeSmpTaGq5qOh6V+UzAae
 DQjzyNS6bWkKdjiuCOhInxEsLc4nSd4qgm6l7N+9UugxLq9NKKIoNhF61/S9h/zm2/V+
 nQRIC6iHgDhXkT9w9//LSAwuOkyGFfovUdxKliNQELD6PwaFGH+tImOt1TT3rEiHqe5i
 9jkBD7d2lwSOQ3KVE2lbuWnzzWP07GZ90sbpRCAEAYn9eVvTM2lT/aYA4dNcIK0jq+11
 3jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564132; x=1790168932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l4obvJtSnioODCzECek1RrGUuUO0M4fUpyaE9GEjHrM=;
 b=sILlKgMyZQS4LVgi8a5IhkyoQPcKRo6cTgz/obc4jBZoqEdpARAqgc+yVw/yVOKTM+
 hcEhKI+oW9UHumZTWL3shseHYD9ZHXXkICTuiJ26ce7nPv8PfIBJRSirXqTdwXieUKJd
 tsqSIktjfrLafaw57K6BZtrXIXLjJsJ/ieFQwjHNsFCgKSwRreA3CMDxo8MmwX7ZGKId
 HVUSL+i6xR/Y0J/0vVAdcwYCSGJ2xNREsMIIE5GbWmOEfifPlT+BRdcmjE7IKWGY6bxr
 3P9EZhlCDNuNaMHZY1IuDuQiTZuc3xmNZz/U+7GRqhWdWYk37c8TvY1osmvIfM9czeWD
 ysoA==
X-Gm-Message-State: AFuF++lzfA4aMSxIKXIBJjzq+cX8gBx+Nnq6vLgsmYaglQNEubA8QYdI
 Dvgy1ZLb59ExcqTqJsQQ9HvxY2E4xAW5RUzU5epDEMI/LM7FYDH8Une6qfDmxzMKTQ2l/CMK4hM
 fT7nXIxU=
X-Gm-Gg: AYBFou1y7WIfB42+Sb28JeAZuQqUCK+A9yagMEXHrdHYwg/3Ax9XhHon7r3+sEXSerg
 7/Oju+c3KumXA3+srIioR0ZYZsDQTTKNFxkOeMgg53Xc1btXDCgJnMdNI9cHazvlMzX9ZA0LBA9
 AckDoiht3mHrx2qVZ6AGBT7HO9GbPIvgpu28mTeiD3XcI39LJ8Vbs7YurBQIctamzQ+FH9uFQXU
 nb0kETjA/4lPTBurt1IpCBw6TUS3E+4J+53m7K6NKU7kaW6IQVbKwpxQDT9IEij+IVZEDyVh2tD
 2NZxeL+KPv9uISRZov5Xn2yyvV6YIZICrKLemFhjB9hWP193OiYGwg9qY3fWFotVHsivDYPYOBE
 B3OVGL1YeomVuKZDEzOCiafbil2sxR+Xh7Q0vviHjHhAzimbcsNO5P68JUEne3DlXl4IfRv8Ue3
 rjpwjsOv7mi1eRpn/MayK1FKZm2HetZORokPgDOJSX0fPxXYANdpqFIu1ZUHnWwip32Ds9eaLuG
 tQo8w4=
X-Received: by 2002:a17:90b:2d8e:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dfdce1f86mr12012232a91.0.1789564131662; 
 Wed, 16 Sep 2026 06:08:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 77/92] tcg: Generic expansion of tcg_gen_ussub_*
Date: Wed, 16 Sep 2026 03:03:52 -1000
Message-ID: <20260916130409.3382710-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b64b54fcdee..f547dc14365 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 69df7967c76..48f5acd5dc1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,5 +62,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 335af620dc3..1cad8bcbc69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1204,6 +1204,16 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+    TCGTemp *zero = tcg_constant_internal(type, 0);
+
+    gen_sub(type, tmp, src1, src2);
+    gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    tcg_temp_free_internal(tmp);
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1501,16 +1511,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1995,16 +1995,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


