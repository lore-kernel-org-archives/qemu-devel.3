Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F556C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ow-0004d1-I9; Thu, 17 Sep 2026 00:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nN-0001Vx-En
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:30 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nL-0007F4-MN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-39647184c73so309203a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619542; x=1790224342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9s71lLEDyz/uvymKsLigfB+L/+7adjDVyPL7LN2hB1g=;
 b=RMg+tttgk5CKtEoSWV9Uer4HH/ZFDp+F6T0osK+y0276aWNCQ+Zc6/QrJnagIUVTVc
 GfZFQLOvOzuLq8MJbBydYj0bqemPaWlEDPLDVsx6m3GE6+/2vK55w+5YUY2O9ZjTVpPc
 0gzPO7kLPHQFkbzWLjcSSbyXUF/iqdWekf/JdV9Rfwhbdxq8Xh+s/0io2vhC9raMHXsQ
 e8GUdRzaA5Ror0MNcQyV7EpN6T3wDsrKcJrNylA8oAtIk72sd6dTcgWTD3uIp8KuRmX8
 fsoZU8/z6e9SZtA8PvVM/vomMcjRDXEPabdLDf7p0lXX7FKxP+X2viV7BVEi+mjiPlDb
 kFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619542; x=1790224342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9s71lLEDyz/uvymKsLigfB+L/+7adjDVyPL7LN2hB1g=;
 b=tyB0CNLyBT+roxINQuYdNoXrWxHHlPjKNNSGJoskw2xJw7aymYn6zHCMhjTQE22paT
 n16xJ6PKaC/rXfciKw/HEX0201EgoCdKTGScP/Dd6LLbNfY1ub5u50eu2Tvv98nhp5mF
 LgN+r07rhH71slKzXy1tK6mulYtaC6AeRevFeMzkB3CRYhXo2/BMvSYYMRMHTOooKzZa
 EdNhez1UfS0XGgYF/FNvvlME2Bp13JwLeQoF2/dDgKYVu8tRrg6kj0DsRTQq2GkPJg8S
 ezyfEoxT6qRO5syZPqUigOayoXZbH0ZG6I682fqWfD3R36JS/9CO/h8RxnXpVdUlfYqU
 KfSA==
X-Gm-Message-State: AFuF++l3Bm/+NbM+YymKKs0ssgvioFDsU11hXb/cGz0Zi8LTTdBzm6OU
 zRgfxqisBWifY5eVljX3yqXnuw6FZUV33Ud1iRy2VZ5pkIMxfm+sHHeGYU8q3llT1pRWeSfJ08R
 QpPHgEzI=
X-Gm-Gg: AYBFou3FTbdbPxliS4u8JLqDkwZcBEoOM082+qXDMu6fXtj63fBdQp1L7r8Ffpn1ZWT
 z3dmANrKa4QqwHnYl1F/KMNS4uh+d/4F2sldAu5cd39cc5PZMvJhPK5FtB92RzTZmUrO4E1hPee
 I2evk/kC2qXIV0dgK0hhcyOGgj8DLyznINPYqfvrecB2JgAPeGNYA8bxn1GwZ0HmGTqSSMVSqgb
 blqJH0gDhGaWe2DQ1RDNnfN5WCTo3pJXYZzLguBPcY4OZbDCPq6DDzYoIai+6ql9VwtF0B/6lcj
 Xsc+WsCMGppo83oI8mlpWygTLa8p3j4D8EonPvt68yLwVUpu56s/NHF+wQQlg2A12JDuoGJ/gs2
 q775/oYcOzb9ym5gJw9rO6cQ6s1m9gcrulh6Zf5E/3te/lBqDvyW3PifryRlBqzqXUnnNqVZGNs
 pVyJdNDHlfNfOjzkMlR76T/f6+Hl/2vDR2eIfxOeVRQiO1TkrEdj3QJ4F8KcNugdv/KcwvPr37J
 5mtCKw=
X-Received: by 2002:a17:90b:2b47:b0:39e:888:3841 with SMTP id
 98e67ed59e1d1-39e36106e9amr3405783a91.16.1789619542091; 
 Wed, 16 Sep 2026 21:32:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 053/101] tcg: Split out gen_ext_i32_i64
Date: Wed, 16 Sep 2026 18:27:35 -1000
Message-ID: <20260917042823.542588-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index d72dee683b0..3453fa97b45 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -413,6 +413,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
@@ -548,6 +549,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
@@ -2301,8 +2307,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_ext_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


