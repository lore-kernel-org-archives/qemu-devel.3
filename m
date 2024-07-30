Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D876C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLU-0004FZ-MJ; Tue, 30 Jul 2024 05:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0003mM-Ey
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLK-0000bj-Qw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368440b073bso1744461f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332429; x=1722937229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0K0Gkugc0azQ0l2zlcwkWWXyTIwjww7OgMp4rP3ZvNg=;
 b=OUuLXmM9FiiuO4OUft8H42nhh2XZjDWxB1bbQF6PJ2L1hHMIf4a8WTxeIcq7UnFH+p
 cBeyleunjm4C6BnrFHAsAMu4noE7LZ7f1LhFsIWwQdtoV+lddf2bdvjDa6onFqIYTq/R
 EvhMQvUKcRFnfzswzBva9GZF2DBdJ+vzZ5uSNYm1Juv6FvVJyKimclbvS0mx6XovWzKb
 1pu1pq7xiuJHrsdOQ5iwCsr73C+H9muF95T/D7yZqTeOetIB1UL+UlGsJbInTtsk1Lxv
 PdrUKg9D6JWogegVIci7/+oOVNzl3gC6L35LKCLOsuYxcpg/Tg/AOYTkK2UoaAd1gK4i
 FljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332429; x=1722937229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K0Gkugc0azQ0l2zlcwkWWXyTIwjww7OgMp4rP3ZvNg=;
 b=SiE6ysOJAbQpR7yJx+NbormcUSUNSv1ibUxWGYXKZSPk54TwB1gizWN9rHs5K8Es9k
 xqyMDiW5mKRa4A+rKM9kiYvnGXdBKxFqRxBk/on3wZ8KtzoK6UJa1UMC8p1H/OYelWcg
 j7N+Lx87nMUA0rafXyqCu2MJEOsmFH4bwqpSlQiN7qUWf3K3R+ThWCWPSKWVTRLC7sDM
 75cwHTbaNaBk8Mo8BEeIGFb0oYpi2QI8S8Xs1TfllFmcZdB8+UNbZW17x4vicgjwoswB
 fwPnLZSuehuZh9lBTeJz1x8+ypcNpROL5CV/yYPCNSCfaHVBp/6SrQCiSHYp+XC6xlDL
 Yfqw==
X-Gm-Message-State: AOJu0Yx0Wdn9rIHM8fyFCVRLtthMRgdZ9BxyX0qzn6K/C+/SAEeUNMqR
 MYeVPbLSp2QN+LxBRAT3KRl2L1l8sHonH7G+MQZUGcQvJXccRGV3sLelptToNKFddjsWy94RtO0
 5
X-Google-Smtp-Source: AGHT+IHmLNtRRGDEKY1q73mgMEXL5NV4tyUnE/fhG+tFR+pWp0akK3bsmluDIAl+/K6m44o/wPe6DQ==
X-Received: by 2002:adf:fd8d:0:b0:362:ad01:5435 with SMTP id
 ffacd0b85a97d-36b8c8ed70dmr923232f8f.29.1722332429238; 
 Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] target/arm: Don't assert for 128-bit tile accesses when
 SVL is 128
Date: Tue, 30 Jul 2024 10:40:11 +0100
Message-Id: <20240730094020.2758637-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

For an instruction which accesses a 128-bit element tile when
the SVL is also 128 (for example MOV z0.Q, p0/M, ZA0H.Q[w0,0]),
we will assert in get_tile_rowcol():

qemu-system-aarch64: ../../tcg/tcg-op.c:926: tcg_gen_deposit_z_i32: Assertion `len > 0' failed.

This happens because we calculate
    len = ctz32(streaming_vec_reg_size(s)) - esz;$
but if the SVL and the element size are the same len is 0, and
the deposit operation asserts.

In this case the ZA storage contains exactly one 128 bit
element ZA tile, and the horizontal or vertical slice is just
that tile. This means that regardless of the index value in
the Ws register, we always access that tile. (In pseudocode terms,
we calculate (index + offset) MOD 1, which is 0.)

Special case the len == 0 case to avoid hitting the assertion
in tcg_gen_deposit_z_i32().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-2-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 185a8a917b0..a50a419af27 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -49,7 +49,15 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Prepare a power-of-two modulo via extraction of @len bits. */
     len = ctz32(streaming_vec_reg_size(s)) - esz;
 
-    if (vertical) {
+    if (!len) {
+        /*
+         * SVL is 128 and the element size is 128. There is exactly
+         * one 128x128 tile in the ZA storage, and so we calculate
+         * (Rs + imm) MOD 1, which is always 0. We need to special case
+         * this because TCG doesn't allow deposit ops with len 0.
+         */
+        tcg_gen_movi_i32(tmp, 0);
+    } else if (vertical) {
         /*
          * Compute the byte offset of the index within the tile:
          *     (index % (svl / size)) * size
-- 
2.34.1


