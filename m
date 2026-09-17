Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA09BC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73p0-0004ti-5D; Thu, 17 Sep 2026 00:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nk-0001tF-Dd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:48 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nh-0007KB-6H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:47 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea4c79fso154820a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619564; x=1790224364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gLVJVtNrLRxv+IfwL8FSgUzttUC7M/vJN/Yj7fCsjEA=;
 b=XmVqSS+L3995J0AlZfkUYjk02A9XDx63dvMKCxePutp3U0l/+nyAiwUujt7JyHQkv5
 bO/+iVvUzouZHt+CXW1wEVlDXICF+7SraUWotiXjEoJh8qTRetSrtjcDi8eMjhsszcgq
 Kzaf5dEknxLItJ3m5EPz0Dj3D7XrhSkGuIyJUb0pF/n5gp6PfklOkl41Q4dIedSVjDcN
 fb/fPzv+ESUDQq4JgdEdyfouuTmhu4UcyOOHbC6Mbh+V46iEKsAgevMWWQ9tn9x0v1UF
 YQW98RBI5Cc16s1qNujDbbtANEc5wxjDnkjNhr1BjSpmgdxKmT5w1xvnkmWj67h6K3Gw
 7N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619564; x=1790224364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gLVJVtNrLRxv+IfwL8FSgUzttUC7M/vJN/Yj7fCsjEA=;
 b=khA31nsYrAa1RKcGki7F3EL+slUbh3IfgqixFU5uZxu4ZAzDt3/uci6NSRVi/oxW6l
 v2WZahWGyEDD4oUo6lYvnZX/KngC3v3Pt817EeratXIK4fO3ht/4mRpJQNvr5BqVOs+v
 89FxZGP7k6xnsNs/EWf22ZGZTkuExMKJ0pTubiJyyoCR/686YBeAP0VcrDOxcjfJ0p/9
 CAW1omRvpKIAeN++ua73TybUwkKCdORxZ/eX7XKW7/Ussxa3xMgAL6GOYIYye45VOYnQ
 WvmMya8eG131DWEzkV7GE/srzxOTAZeqa47tJ+iCI+K0ePRL1qYx4i9csj6gyqGeSsiq
 MF3A==
X-Gm-Message-State: AFuF++k0zx9/BPvjamQn1oSUz8SjFm0QoAnh+xOVCg0oy+7Zg29vrnEE
 nJd4FtmVpk6XW7+q8git3Np2rQdyedSYyOLkBtIEkNXuN1n3gxY4cVT1nYG2aGsAEnK4NReJBWt
 kGqOaeLg=
X-Gm-Gg: AYBFou37eSQh9EU6k71pYzt9MzPTl11R/emJfyNV2PjECSUSmR7G2Vifz1NvkDEhzPW
 mjQNyhGRHhVmIci/3Kp3a2rLWdDkuE56N/3TFagyGIA3YWACJNeiXyG6B8DE7nGAr2+Sy3bu49V
 DVma8V35aTAazO5zUVInA/xWveM7S0nKFSN+ILC9Xac3ryTu3K26/DSWJmIJWMtOAnKTKX2Vh4L
 a1pAU5qOmP2vhwXa2CmVtEf7RLeEXTvEPA/xRUFv2fXd02G5qeb2cNr+e2Se1gjUq+hZ96a7d5k
 dn6nFNRcwS1G1zSHzQWi8+/BjrFhOeFsLIpqonQpH8r1kkw8ENYHQHQ3+WSopxvjXeZLlNNZMWf
 x3rwPKyRJHKBhiwKX4e9E5aWXdyWWvuIh355roGpl6aTWI4eCVrs6V7qLma8qSgNxSguKxAzSzO
 IFDw+XMO8QbEY9uY9xPTD92JEc1khC6I72bhg7V2yLjdrDBOBLrglofbITp7rPuNhgqxLDFOuYI
 pnEKco=
X-Received: by 2002:a05:6a20:3d8d:b0:3cc:eea9:f757 with SMTP id
 adf61e73a8af0-3dd5f5de790mr13553376637.16.1789619563726; 
 Wed, 16 Sep 2026 21:32:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 074/101] tcg: Generic expansion of tcg_gen_smin_*
Date: Wed, 16 Sep 2026 18:27:56 -1000
Message-ID: <20260917042823.542588-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 84902f5ef72..ada613805fe 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c31c819ebdc..2ccdddc8eeb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f9cf4675821..75b8536767f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1118,6 +1118,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1434,15 +1443,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1974,15 +1974,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0


