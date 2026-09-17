Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A79C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73oZ-00040r-9E; Thu, 17 Sep 2026 00:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nM-0001Va-PG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:25 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nK-0007Eq-TW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:24 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so228879b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619541; x=1790224341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2gIK9i+abIagtrUqREW1McmS12OAOh5C5dbuLb9AgzQ=;
 b=Ic0NWjMjLTDdBwRlDVOipGFGGCP1hnecdYYbiPPKLJMjhBYabXkau6RiJfGx2U65I6
 Tcmqe+WGfYYbTxOEKohaAxETsqOarq+ba27AEjFV5fRDy0cjdYuonj0uEKz7HT+YNjiZ
 0Im5kWiQH7pscXUi5g6gJLTgVYeLgIEsvyuYvfa2UknaX3XYgw2hI7HQ3rS4HFSeAnUU
 C6AMpg0PFCwDqKtxc4L+6Wa6qrHsA0Y2SZnuUeexpxxZoi8BKh9yRc1YxAMEBi0eXtg+
 dX7TRDNa65fcC/89LpCEliYa1j1gCNB0MMrK06W1i1tNhSaar1a7fPjLK187vWKVfC5f
 1mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619541; x=1790224341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2gIK9i+abIagtrUqREW1McmS12OAOh5C5dbuLb9AgzQ=;
 b=WgaegEPtQsSsaQeMslVbgY4CeIwwpytHARxybak4jX4vTdgt5ryVx2NuXUa/d3MgZG
 ue3TnIw7n51CEU4OnE5O9ZjJa8HE8MRl2QljssBjMAvCAKo35DvYNS3dHBfecCVU5HIP
 Sf6wIjMsqPoE65KGeRI5xowiNEmlZdFIT8jkimgeHSLv8Sqkc7unqU8AM2K2cY745PKw
 fzKgM8t+c2UuiDjngdJS3IYMFBBfL28wQqvC7E4T47Ksn6z7ziZYwzZMZmi+1a3SsiSu
 wxVFSJvHGPdGpLXXq3/Pq64p4eAsWBG11dIR7Pzu0t67jpjED7BnJmw/IqsNSL2esn3c
 Qr3A==
X-Gm-Message-State: AFuF++lHkguWX84Vn+rxJwpXHELVIgsBba9cYiC1Xr1SHAXt9wYRP0vG
 RwGesH3NhfMnPRwjuoSDSzFqbdRbyNFE7S4sdR/of9BCfqp4dNdJixIJEj2STHfkZ7ECKyxTGPo
 /V9Vrbe4=
X-Gm-Gg: AYBFou3UfHfXdSJqQPurxJtsOK2IGG6Oqip7U0aoHWWok9JFfpuLMOrHQwrWQ535cet
 50GG8RRisa3l5YOKSXXhyIyBejDvmy09vbWawTSRktww59Dh9tQnHqvQUxRB+ztchD6X3Km2XBB
 iu5JTueSYwo326Ksjrz7G0o7I7c6zdwskI1NfcL9i8u7W1/5WHrsbCa0UcQBua81N2d6OlErt23
 fksFPu3TyNLg53cfov2i8iLsgGtDoNFCO22qi9KWvV68LWKFgDRbtOWRslQwARIKU8lvuSC6sHP
 SblyIMrBHXWUBECJYfBWfTEGKq0GotEwq3++nVG0Rz8sJx7z118amDeWANXaKsTiBWJYWIHUoI4
 Oozeq+t5zWidKiQYD2frkfnPch60kqp5dUoIYBJ38wmF1mPv+pS9tUXDZeXA+A+coFbln6f9jIh
 bZekB01uZXBl0hFY5+44UFEHD00EL6KmWCrAyrq7Iwdnhu3iA/1kYMKPi7JwaUUok5MkMZOrIYE
 ilF9iIN
X-Received: by 2002:a05:6a20:7349:b0:3cc:b26a:7686 with SMTP id
 adf61e73a8af0-3dd5f3d08d2mr13026002637.6.1789619541184; 
 Wed, 16 Sep 2026 21:32:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 052/101] tcg: Split out gen_extrh_i64_i32
Date: Wed, 16 Sep 2026 18:27:34 -1000
Message-ID: <20260917042823.542588-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
index 95685a86873..d72dee683b0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF6
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
@@ -537,6 +538,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
@@ -2285,8 +2291,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrh_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


