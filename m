Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B5BC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAu-0001YK-0M; Sat, 12 Sep 2026 22:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAr-0001Ke-N7
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:33 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAq-0001rJ-0z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:33 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso3724235ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267350; x=1789872150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kVRWaBnFThAilxvxUokXcalYhtA8KLymwGNHL4/p+bE=;
 b=CVbDIAU1lBDTGwV+7twMkpqq4hJhDJD7MlkTd61MP2eY368NrTfMq24QNr7CIitqT3
 EqZcbQW+iDlxdSj4xq2zc/okDfWHRB3f/aGCQWMg4HJhouO4dzf5/Q7yleZDE/aXhLgp
 7G3wr44hAQHT222faTzKe/71mDGRsjWnOEkHUGUFhaE8sidH/Te0tcJT1tt+ugxzTYHg
 SyDAZ2UZYFAT9MR6ZjmiBZ9M/rtHau4KHLasVYJaotnj2nnxTQwMrZovQQx7TXd1i+4D
 DqBT7q2J8nE2hKtFM6Kdh8KQIq/gRzADhLC9SSLVBHJSQmVChbCgzmxfK4KNkeCN+0bE
 S84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267350; x=1789872150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kVRWaBnFThAilxvxUokXcalYhtA8KLymwGNHL4/p+bE=;
 b=p84RJnC59J0tETV6On1yHPTnyXZb8PoD/rj0UnJqytHVJHM/1QDwIc/E+x9hNrFS3c
 5Ds/dftaWMs4VayRQFck4ScDpQZ0ZW50BsC7lnYYTAlK/TOLwUHH1WVj949USuZn8qc1
 IQigkOy+/1ctL4x2MX2qqpznyAjyFRhJm9mUmlBIY56RQ3T3KOYArEK0+UMbQkaCeZ8t
 U4NfrUvTviMbFyy//UFS9m7/KSzGqWHkKGvTtjkGEru4rGzJk1AONIF+oWPKR/18BmOL
 WnKYBU0K8rlk0LSzcZzwFWLJh1ptfaOfZDa7qpZaeffGKrcyiDc8NMBECYz1s4HtfFfO
 UB4A==
X-Gm-Message-State: AFuF++kvN96lYK/geziKKCJ+DYcId6VLoOc7YBCJEeZWvkXZadvRRcwu
 qEkLnUANnTm4C/xMQxQe7LjtmBY3YWty/ER6E8JPNb/ZjcxwlStifrjAPmnMxII2I5nxlYNscqe
 vDS1jORU=
X-Gm-Gg: AYBFou0nwyp30ly3zo35OkcpjsXDRpOtkRkpKN3x78Z8YqEGB4/HofHz+mQKQMKApap
 BliICx/bPfZ3rrFMRyX/XtFawGUshnFYUGtbMPDacwLtHXI7xjXbTnS91/f+VRaOYTfIBhcHPyy
 f+wcmuG+Y7BtlgOaPsw+QOjm6pc/58fUzmT+K3FlWM7Y5OZcY55Fdjbll1zSUEFe21OW8w4F5WV
 0bMHPOQj/bNZ0IynSpJhvTfS+alQ3TcrbcqJBcXl8c7txb0dihv3dvAqdRwmq4YDeQFrRkuvmJ+
 +hRJC5l5h0TVOeXSkg7caJupLpzxoUjyrrCgw+kVgSfOn6dOM4rEN0stSnZhinGACLyp+FyCoXm
 Yq+2D3orf8E5HTT6OdbfGvgXVULwQ9xFFhu4HfYPhOHTzPNrLHOvBV7RBS+HMzsmKlyt6E3qOiQ
 CfwyIFo4zRqzP4YAQBd5jqStHP5bwEXULKKJtGe8rYHcm3dgwYJAx74T08FgWmAF36tCe+xAdiz
 M8b3Xt5
X-Received: by 2002:a17:902:d60f:b0:2d8:d4dd:24c0 with SMTP id
 d9443c01a7336-2dd4bdb245bmr86786335ad.21.1789267350033; 
 Sat, 12 Sep 2026 19:42:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 44/86] tcg: Split out gen_extrl_i64_i32
Date: Sat, 12 Sep 2026 16:37:55 -1000
Message-ID: <20260913023837.741866-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7f05dcf2c68..8a5e0287411 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF6
 
+static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+
 /*
  * Generic expansions for templated operations.
  * We have used compiler type checks to ensure all TCGTemp
@@ -537,6 +539,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2273,8 +2280,7 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrl_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


