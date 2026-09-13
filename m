Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD15EC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBT-00056y-QA; Sat, 12 Sep 2026 22:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBK-00045E-PW
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:02 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBI-000207-Ug
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:02 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eb79fbso5364225ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267379; x=1789872179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zSlW6OQRrX4VNtTUqMHDxZbWN8QYrduSbBaBhpueEU0=;
 b=TcUBVYRrPVULZERqVH6Vh5O/+HqQk1Fb+eJMtwj+04uHeXe0zikEnSWSDw54pHU3rg
 hKFNJeX0e4gnw+mLce0C/VNE9E4vgvnJciCCXoBsPukjv/9J6s0SvkQT46gWn2TIJ+jm
 kUDe9P5SSZi7yFKa7mtxteCWsxdHdzc+JZALAUeB3tzGq/elEra92QoKb+GeqzZ9EJ3y
 pdDqS9hJrolplXFLLXc9SJrlzZK+ucHBxY5Mnip3Yh2AoSXOVgCC9l5+Tj6PibeWz64c
 1d2HYzTbaAeWMkPRkVcfTsZBc8/RaXIcO6FjJ08Wp3rLGL7a+D+5BvtUpO8dPP32ywnz
 eKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267379; x=1789872179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zSlW6OQRrX4VNtTUqMHDxZbWN8QYrduSbBaBhpueEU0=;
 b=VS/3UzDpZoOFTWlD11kuSVDpKUq+NozruXSJYL3DZ9nKfRHFSRMFPKzAKeOJzUCgrx
 f5gV6zNVARa+UtxJWtt2uhWKzObOF6UzKDtEJpbENfDBuHDOZcD8IZ8xDbbcJB4Kb01c
 C0aO/9briVWZfbaG0xMJgWNr7b2jlsI6ntq/D2Dx/WzTUhsIdQ6QcyhT9pn7QeY26njd
 ARoaJLSC12DGPRHzlN/fT2MpxZnI62YxracVdAQg4D9/t19rqQs8SKT1JmLxXlkn5CBv
 1ViVyFj5jqhEO3wFx4jeiUoE6FBKQJzpUYEBGqA6/gLnrO4Y73n0JMNyc3ea785hf7yt
 bMDw==
X-Gm-Message-State: AFuF++l18xXqEnpipe7Jlpdnh7Uwwq65rriSL2fm9NRtAM4+o86sin3/
 a6w99aBvg4LSrhG3o28wC4N35RtAEwky1zuij65Y9SgY2UVwR240OVcwThiinbu06QnYgHVmmIj
 p4NgURAM=
X-Gm-Gg: AYBFou032MZj65NvB9+R3vz1y/0DS0RFyNGiKt3XtVQ15P9An1bVPSTBXAGjOJIOMRE
 D+KStD2nLz3LmhnhRvhvgzK2wR7LN0flwQtmjHl4n/Gm6C9+vvsKdvxKcTs6tTVFclwjo8hH5no
 H5i/1StUpUXjhIEKCQGz8zVQwtuZBKC7JxwEQEBtBufYi5Vb1YGZGefhAcxw/lVhtfAfZxHTYTw
 1a8vhN8NI8On6xzf+sWusCbvzBXT05MN14ypDzxxi7gLxh7cTcbY1F9rGiHkKSOZkVSbiLFWBk2
 X7wxrFF/31reTGeDrBJi61BqO9qVVQplABplw6K1YDIzu4MsuLI9ZoYgIHSn71KcORawAD6Gobr
 qJRXEq81PoDKGw1m+UyH76oVzI0EPyFSEK0RabxNqlesERTSP2xWyZqHsOsEZk5u+0AezunPAx+
 TpwLUsqS36TxWaQ/HTssoGfs/cTCEMlOVzRrcCtY+lqTWW0sKlJyoTnBZdu/snfL1bJbQpQnEbd
 EJdNQI=
X-Received: by 2002:a17:903:4585:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2dd2a34ab27mr214003185ad.13.1789267379334; 
 Sat, 12 Sep 2026 19:42:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 73/86] tcg: Use smax in abs if available
Date: Sat, 12 Sep 2026 16:38:24 -1000
Message-ID: <20260913023837.741866-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 467542a7ae0..2c15256fa1d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -418,11 +418,16 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    int width = tcg_type_size(type) * 8;
 
-    gen_sari(type, tmp, src, width - 1);
-    gen_xor(type, dst, src, tmp);
-    gen_sub(type, dst, dst, tmp);
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_neg(type, tmp, src);
+        gen_smax(type, dst, tmp, src);
+    } else {
+        int width = tcg_type_size(type) * 8;
+        gen_sari(type, tmp, src, width - 1);
+        gen_xor(type, dst, src, tmp);
+        gen_sub(type, dst, dst, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


