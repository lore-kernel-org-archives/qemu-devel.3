Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AF3CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaTc-0001sR-Qx; Thu, 28 May 2026 09:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSUZG-0006s7-QU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:50:10 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSUZF-0003V3-5y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:50:10 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so7425407a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779951006; x=1780555806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=FYBMuSmF0842WXoh1o1G3zXiczca0JkXkx36VycN4hrTlfU9THhH6ivAMZCVHEBTYQ
 YWT9Zc7sb9lRSRXeO3xjKLsCmx3/YLlZ9CmV4ZjsPkehYps3R2reS+JOEQipCTGAJjXU
 rHdXPw00EZDNy5kBJOAYS74WKHoB9ekX6mGtJrR2a0DWbcKmZL8+U8/eKQQJQhye+WJS
 +91+VHhDGbjQ7H6Muy4J0iVgvKkJaK2amDrDHGor29rUUVo9pckRxcDMPOAT/40HePyh
 9zEEQVcRiiLa/ZAO51ArzZB13AfhphQy36L9bialyCte8SxpEx2/BB9PHPkmpIUFZ4YB
 O4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779951006; x=1780555806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=Z+1cgUoM5tP5ZReky4BVlr8FrEDcHm3G8K+g5k50y9gqWS8oSvT5Ub3pwNpbFfwyqj
 5IEkw+OQT0XeAlZhEYATl4yxCHN40Y4lHtLkmGbJNqn5rBvs2LZlOH/xOrnx4qqQxuXe
 3d+A36Vj+suifAmisQ084RFCAMNwQF06tKnky0VjXdMj3+NmDpGvfgyzhLEKozeT5vUe
 cn0QKDvYcp96/JnsjOXo5lAempd6mEUhmFLXTrCu0oAn8CNZPZ/q1rhpNizq0Li7OT0/
 0H77fZhH1fsg0H88M6wpe8JjY/+tFBoDtPdIgdw3wldBdOI6f7VEO9cwRv68tHda2Ns0
 yUjA==
X-Gm-Message-State: AOJu0YwGff0jPbj26omO1dJ4FItj0h47l978qIaGF2rfl1s9hb+hd+MG
 0fymipxlw0n/nwrHDSGG6qljKIfBId4JpJbrH8D+VHPxY7UQL920SSu+gFyxT7PN
X-Gm-Gg: Acq92OEYpkPzs3MdO1lMERyMozOGr0ubeBykkvdPZF9jtBFSC8PfxljYyoY9Y1fB9KL
 O3wvXlVC3pMRdFuDFCqkuEpezmYBxg9ikjJYIohQp4U+sbpK7cK7ok52juYUEnSrMW5GtnmzRZL
 OhiPpIgepC6d3OGTRerMYwJhzFjIy47ORCKg6Qwd0Y8hzM+4N7ctX98zEy9lvarTyjBcPn77lJP
 Ap133gcmK10S4EBgxvy4ebjEVN0mIsftiDRjGkye9iNKkhflvkSrnLutCCqfCdMRZZQC3o20+BN
 4AQR/he1ZN7+wfWPJmGWjq8hRR7zcpochGLtBzAc2WUaJcatvefvKVJr8U3Qri0war81qkM5s4T
 UUdXiMnVH8aSZmFsd1wZmDFJu0ljvYfl7ZntZk6ndefDgwsWIwF6Ck3oXxoTARDjj3FwFSAxuqu
 krdfG5GVs9zS5fvexA424=
X-Received: by 2002:a17:90b:3bc6:b0:368:7327:6326 with SMTP id
 98e67ed59e1d1-36a6741ecbamr27650249a91.1.1779951006381; 
 Wed, 27 May 2026 23:50:06 -0700 (PDT)
Received: from arch ([112.133.246.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852058557bsm14405961a12.30.2026.05.27.23.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 23:50:05 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/i386: Fix incorrect tcg generation for RCR & RCL
 instructions
Date: Thu, 28 May 2026 12:19:41 +0530
Message-ID: <20260528064941.351917-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=314abh@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 09:08:44 -0400
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

RCR and RCL instructions of a count of 9 is meaningless for 8-bit
operands. In gen_RCR and gen_RCL functions, gen_rotc_mod converts a
rotation of 9 to 0. But, the can_be_zero flag wasn't updated and hence
we skip the immediate if branch. This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1);

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
---
 target/i386/tcg/emit.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c5..a71af846d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3452,6 +3452,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     low_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3504,6 +3505,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.54.0


