Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F87C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydh-0001jT-1Y; Wed, 05 Jun 2024 17:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydf-0001iN-Pe
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEyde-0003qA-8W
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70257104b4dso253716b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624665; x=1718229465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQiUj0T/PhZH9aPIOQew7TG39LwQbDZ+11m+rsBXajM=;
 b=oMrCbql95Zslbf7bsPALssQkGmWWNudO74PCupFeVJOMZhupvAXWfYhLX0mgVbTKsS
 f17w3JTNwypsXjbzOzqy6dZ9Xs7DzIoBUpicK8KGZUaH0z5zfmO86YlecM+XhJYQLpbs
 3oDE7h7ze2CAIeGNs8F1SrsAFoQqOGdfm02VQdULHfDD0yZpi4inZUYtic2CoH2qLGa5
 EjJTLzHzOcOuNyYpAomSTO1pXFWdYNXFGjH+RNdCjTjUEdAhOII+R6wrB9Qs4gJdo/Hx
 xEJGFWX/tYu32ma0ih1/3LyZMsPsAx6S58Oh239pJqg4oqa5n4c8DYyCgzIvrtcUDBW5
 DClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624665; x=1718229465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQiUj0T/PhZH9aPIOQew7TG39LwQbDZ+11m+rsBXajM=;
 b=WYGKNeXgqNo7EPpGqA9qeWA480uOangs0AOTKx9QyGblsQ10L4LUV6XFUvETodiQf5
 z+Oht7dluI1Wj+4ir69IJfEGWamg69yGBDpuFCg4q6k2X1sm+pRmdqOx3oOBkh8A6r8V
 giGRJYv0ktgWmIisLESKec+HQRQkCVxyeZqdN6hk7OJ6hHJaiHFL096C4g1TVJmY+jrt
 2NO/DhTgPUaNiZxuoe2egRWWIIMCY6slW0FFImzyWR9lHU/PXIW/GvdEbb77GEdkzZaG
 gcwnrLzy2oGzIgamDZkvqh5dy00e1UC8UaVHDzQTledzd1u3iNjG1KX40wOhe4LSJNFM
 znaA==
X-Gm-Message-State: AOJu0YxqwHVPlISZtvmQlFZjPrA8JzgY7Pv5fuJ+oBlKY/E0PMlFwnnJ
 FjtSXsGF32CcmKY7zpBm0AnXh5pdBY93yaEe2TZM4JUGnXL8Q2abcNzQfp8cCCtYauQgAHO5tvH
 h
X-Google-Smtp-Source: AGHT+IHnwQjcgEJ00oZB0L3k0U1PJo/RiYi3wbrNoRsAhkQtkAVzcIVjO9ilftLdz1YXTo+CWZ1+jQ==
X-Received: by 2002:a05:6a21:3996:b0:1af:cd4a:1e1d with SMTP id
 adf61e73a8af0-1b2b70ff62dmr5062678637.40.1717624664972; 
 Wed, 05 Jun 2024 14:57:44 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 04/10] target/s390x: Use gen_psw_addr_disp in
 pc_to_link_info
Date: Wed,  5 Jun 2024 14:57:33 -0700
Message-Id: <20240605215739.4758-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is slightly more complicated than a straight displacement
for 31 and 24-bit modes.  Dont bother with a cant-happen assert.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 14162769a9..2d611da8af 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -174,17 +174,19 @@ static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
 
 static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
 {
-    uint64_t pc = s->pc_tmp;
+    TCGv_i64 tmp;
 
-    if (s->base.tb->flags & FLAG_MASK_32) {
-        if (s->base.tb->flags & FLAG_MASK_64) {
-            tcg_gen_movi_i64(out, pc);
-            return;
-        }
-        pc |= 0x80000000;
+    if (s->base.tb->flags & FLAG_MASK_64) {
+        gen_psw_addr_disp(s, out, s->ilen);
+        return;
     }
-    assert(!(s->base.tb->flags & FLAG_MASK_64));
-    tcg_gen_deposit_i64(out, out, tcg_constant_i64(pc), 0, 32);
+
+    tmp = tcg_temp_new_i64();
+    gen_psw_addr_disp(s, tmp, s->ilen);
+    if (s->base.tb->flags & FLAG_MASK_32) {
+        tcg_gen_ori_i64(tmp, tmp, 0x80000000);
+    }
+    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
 }
 
 static TCGv_i64 psw_addr;
-- 
2.34.1


