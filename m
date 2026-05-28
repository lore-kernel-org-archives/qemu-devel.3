Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C0ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaTl-0001uZ-E1; Thu, 28 May 2026 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSWd0-0001vu-RH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:02:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSWcz-0002Ui-6V
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:02:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso92347875ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779958927; x=1780563727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=bxDWxuhbYiPWGBmh8SsNAfG7gULsBkei8TKpr7krfoDomgQ6LtNgjlEzEU0rURleHa
 c7xz8tbWKwGI1zTIB6CWlNxTi+bjEvxwMGK6V0s7yPQKeHmkyQH8bAdJ8Yzpx0TWI260
 G1DPqauwfns085HGfcrHUQW+kUA2yto/Gpzz6331mcW35lFVcoX1m6QlVXFdSoQMNSqC
 sx4iFiyJ5fyZddDQvxmUanJOguKdutqEn0jgyCN+P6pVLl1VhVlnNgeBk/l6zd9z5qFh
 XoOuCOrNPEZDEQifWV74neyMqMlYhES+gX74FVWcBQrcNEM8npcVlCkC2a70oH+BqzpV
 2bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779958928; x=1780563728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=klMg+22UvdrqVF15azEKC9ZpCnRc8Rtxu3neVHWOedzy6yusivfWtOCj/uVeJRcKEY
 d5i5LDDlUK8FyWF+3+pnmD4PS2mxIE9t/dWFXfytS5sPqH+wpTEgi6bBW8AKJhz+zLiv
 gR5XFAsTRmDsR1fUBipcIlPHD5wmV80zNnyflrRvLVjt9lbbZQ+leHSij0C87mj4P/Vo
 L6nCWNYdHYfaxTaQh6gUbFIik8wWGgHg8TCz1vlUIglLVhhZY1GkODi7ZHPQUMajHjrK
 HErpQLlRs+y/2RIkQkoV6LjczZ+Y6sUyM0ctuQQD1657nJKioESky47AegodUxAhxJsQ
 UblA==
X-Gm-Message-State: AOJu0YyjoDDOF7arRRCy/hBMipLXPzAiIFzSa/FWqWWK2G3hjALhxOot
 XBT1WTVKG+gPrjaEh/iP0xJkMc0+Eeg0qnJsioyu9jroAkY45yhFX4z3Oa9ApjBb
X-Gm-Gg: Acq92OEUkwG/dLKyj6BmBka0aj5FdsCMuhBDJIvbyxSKecBlYWmxG2T1WfqS646wLzq
 lb4V5SJekPrfAIhOTPwr6fFzxfL88fI4Lrd2953dkPeZ9NIhrMFREZATlcJTpDbeBjQ0O01PSnP
 FyJszTQ5RBnIJCwhYd9+7lj8Bh64p7v4eNi6703Tg6j1WFuAQ6NsbzIhaR2E/gqNvQ2Cm7tTSx0
 F91C3TH61DYvhANz0dhR6oan/ca/ZW9fE0lK7xVyE42pkLOOnqpH1Vi/Yi94rpLNQpafR0nQage
 vcJ6xtPPMGg2uAfoCSmGjXBucSeH11G22ht2l3GgzmwvcLg25N8vHxtY6WPOtynTXJI8lCsINBp
 6rKleLuuK+0tg1YTCW066IiCo4YmdWB4v/M9nOXNVBA0hn7QmwjKhrnRJ/ZVtBhvCN9Qa1aHQ15
 ugr+8BPWQdnlvur7fzmqe3
X-Received: by 2002:a17:903:354b:b0:2bc:db91:f5a7 with SMTP id
 d9443c01a7336-2beb0735023mr302810865ad.11.1779958927285; 
 Thu, 28 May 2026 02:02:07 -0700 (PDT)
Received: from arch ([112.133.246.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2d47sm214938075ad.45.2026.05.28.02.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 02:02:06 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/i386: Fix incorrect tcg generation for RCR & RCL
 instructions
Date: Thu, 28 May 2026 14:31:59 +0530
Message-ID: <20260528090159.390530-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=314abh@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 09:08:50 -0400
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


