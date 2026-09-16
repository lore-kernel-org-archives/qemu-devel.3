Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002DBC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNt-0007zk-Fv; Wed, 16 Sep 2026 09:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNC-0006jw-01
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:34 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN9-0001PO-Kh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:24 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d37f9dso450248a34.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564101; x=1790168901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dg6SBhTcgYneB6EiS3pEoz3QxKzqFdxH7kQ/6gE6DUw=;
 b=Fd+fOaFJHff+btXi9L6+tDsUGkfKXYGCXaKDgcNO6wcCsjS+BUB1x6xmOZBThooxn9
 9DgxVN8cSwrqOSpOQIEeCyDmCdQJX1ldEeWe1XMCaJtJBIyr6RD0+3v+4nFqlArXn6kD
 ATIRPZqYk/wmX7JLHfAvYzjGl4M6nU32FVOe6AK1btNRzMjhsSopXxPZ9Ctpeax5sdy/
 z2MwK2eTjQ4XMSLvLsL/TJI6w/2AglIobECfD+ELhNwauOrOORxl2OjnhXRP7TNNB35/
 BU0RNviVnks7GDCnVxFovo4PG5KV/xoH6gjtCZRyjBg5yYnYg7o3YkzTHSd13UvMB36+
 /rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564101; x=1790168901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dg6SBhTcgYneB6EiS3pEoz3QxKzqFdxH7kQ/6gE6DUw=;
 b=NyffrQcd3KclY9l5Ts81HtgFjJ0lsG1wV4bgmCPE7hSMjdYzmNbbi51Y/yFGrBU0hf
 +4ZTGu7SmB/KGETC19l3SYeaGtL7Ea/yaxPoCCBrLgmphIyb6hGKgwBetKJclIcaTQLM
 rY9ZlNoNupIGpmQoFrQZ7C+WXYCglGAPo9V+IB4h9fzGJ9lkcKeGAe2Tlt51rO6+SBH0
 Iaffw6ggdEpqrBdx2KJfJN7TAY3UowrsXtT78J8zPgbcYKFx6SoK10VVzi7o5tQ4LutL
 umvIuVG0xvqQXKlLKZFlzebD+I+028Ca8JMv8FV0Ae0rC8UfixSNHSfYpRsXIXo+dOZ/
 scDA==
X-Gm-Message-State: AFuF++nG2C+0YtKlDwEMYAMRcAimgIyqweV9MBXpjT+AcKRkpRbZgw2B
 n9foCHE7RjbJ/XNQtbYRnZclmwyS0HgWJXn+YaGfLlZtm4U07cjiYfLf40rcvZmko85FBt8j4Qt
 AnZaHLXk=
X-Gm-Gg: AYBFou3Qv0cmGunKi7NODowgndEAMeJ1prP/1B0Njj/hr49KQZw3auO+OS/Br/443s+
 UzWmjoWLPIsUQQoiw7vwV5C/r3TOkZyp/f6YzCzkzxhJ84D/uB8bZAzFbcqp44FrGd2cEpO9L5w
 PQ1dWkbHcUX7vAUQWvdNk0Jn85d6Nm8mZ+U2TT52WCfkWn0YmgyVzS5LnT63dsCwzbrtNdpl4d4
 Ho+rizvGE3yAAO+ZOSgdGC1UY31mqJ3oUeIkFpk9kRYcUq9oP2Xd6GnO9uMlFt77lWIJRCERoxe
 OkEf37YCDniDieeCvZXwAcPssGMGsnT54E7RzsBKgSYJS2WG8sWDIWg1WYNOxMPdzqUx4ids9Yb
 OKQAY5rhy4bPrbp6ZZv6oJo83tGTmMBU0RL54h1K8fezPPOdCNgsQ1IoRjQTGQqVWXBsqOGOp1a
 J8O17NZl5i0Z1OAJIbjqvXvp9M4CK9IwpGcLjCYLwAsGbCnOJgEychlz7huC46uC2Ryoj0/S5A4
 d7jQmY=
X-Received: by 2002:a05:6820:1897:b0:6b7:46fc:1d7 with SMTP id
 006d021491bc7-6c7d41de430mr2544728eaf.54.1789564100748; 
 Wed, 16 Sep 2026 06:08:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 47/92] tcg: Split out gen_extrl_i64_i32
Date: Wed, 16 Sep 2026 03:03:22 -1000
Message-ID: <20260916130409.3382710-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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
 tcg/tcg-op.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 002d629aeab..861b1ede949 100644
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


