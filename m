Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82951CE8D68
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 17:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJy0T-0005o8-IA; Fri, 14 Nov 2025 12:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJy09-0005Re-Ct
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 12:54:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJy07-0006f2-Mg
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 12:54:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso1608945f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763142860; x=1763747660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jkwfE8w9X+zb4L+yWFPm67KE+tgnj5BfrOePnspgBrc=;
 b=TJQVcs74CDPvYxYXwJEoKx2a3XBCUx0JplCJ0dV2aRNT14CDrTuCNdu+6hirldKo3k
 KDhhQIK8M6AkgZyLZf26FHWCsho97MjxTYit3a8yl01DxqajgC4CxbNk0HJolL3BpV16
 9MERgq6YLeGfPxCUUOnRbX9Cwln6mlU48MrBmI3HhyM2IkHSVvse4maQRsvFeI9RI8Gd
 OhVGvy60kmt3ISFR3ihLNYLrWEOGjHBO+UBocI6uL8tIAWJvl5zvG9mz0KpzCSsezbLX
 7iZvK/dMPRVl/+gePQ3LMVdIt41XwgJWiOmUEYf1HasAK6tzRe/tJ1rvL9fkxdaI+haa
 we2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763142860; x=1763747660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkwfE8w9X+zb4L+yWFPm67KE+tgnj5BfrOePnspgBrc=;
 b=kR/+tiuqcwncnDm4ytESrNclzAcpc5UxYpvGcZ23LVA1Nv+L5tSlCwrrzUfTXBgnAo
 MTo8zEmvGriPYKlfSxf/tVSdbinO7pKkNP9yYeNX5Kwhxrh2uQUZEQVBOsuPlRkWsfDH
 vZz8n1wGGr4q1ctNM7DTsNAcp0EIQbTdTvWgeliu4O5mWgwvB+gr8E0wv0CpsL5BFSgp
 TpvtMbaLil952M6J7ewJtngHhsAjVXYzYXMy9MbgQNLxDXPHWrf/b3cSuoEw9XdAx9fP
 Sy/NztXYM5nE1UljQqhL+pYu3gcTdKxTT3JbW6o54WcDuyQnxLJ+TKUsnRX0KLiq2+dH
 Rt6w==
X-Gm-Message-State: AOJu0Yw5a7yu7Sxkmk7FfdxsAliPq48DuZWn/EBPBTN6/HokMmMyqe8k
 axqhnBitXOc9y0TzRK2RPByiYkiBEeZwB9xSFlgT3NFm5FJ5QlqQ1D9PnLzwqeB2SRW2A5MFQDC
 nDU7B
X-Gm-Gg: ASbGncvCu+T3J2ScH/VbwHeGaJBwoxIwxpMXH0lZ0raQLBtmwjnTBJQijV58wJJ8KNj
 7YTNd1IY8pGlWOtPXtKCBM4XAN9KEexXBk2bpCOMqGVo+gG68fsRwo+6FLCw3/mEc9Jm15ADyjC
 am4+FAH8Ydhnjj1QmFa3h4Vb61Rov91bCkKxc0QT/B0/aV9u+WHePe10jtfckoiDh0mNuNuO56/
 eKuiV7eu5tkQAAoXu6Z1opNNRxYIt7czpiZsCmEfiaFTKobeBI0PgW/9Yq2AS1zWF4TkSYaH574
 vPg8f5nVjkmTXDDP43fKWdEZYv31azFbaIvrL9DSN+mgO82qoUetlZcYS5lEqXCF4nJybV7oyvh
 xzMJS1t5uDg+liwWJFTBlmvAYdeDqYildCFqre+eEmUguVXJSNsmgCTjQybJszSCdGBFr6Vrgvz
 cXlzOnaAd1/OtSR9+ITpfXpSxwiao=
X-Google-Smtp-Source: AGHT+IGZh1tJGFdGmd7VwlFS3m/eygslWGjlrH+INGxos65mporq4FaXMvtUQ5Yv56irp5Ittj69Lg==
X-Received: by 2002:a05:6000:21ca:b0:42b:41dc:1b5e with SMTP id
 ffacd0b85a97d-42b5936797amr2751689f8f.30.1763142860111; 
 Fri, 14 Nov 2025 09:54:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b074sm10775857f8f.7.2025.11.14.09.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:54:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/arm: Mark VPERMILPS as not valid with prefix 0
Date: Fri, 14 Nov 2025 17:54:17 +0000
Message-ID: <20251114175417.2794804-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

There are a small set of binary SSE insns which have no MMX
equivalent, which we create the gen functions for with the
BINARY_INT_SSE() macro.  This forwards to gen_binary_int_sse() with a
NULL pointer for 'mmx'.

For almost all of these insns we correctly mark them in the decode
table as not permitting a zero prefix byte; however we got this wrong
for VPERMILPS, with the result that a bogus instruction would get
through the decode checks and end up in gen_binary_int_sse() trying
to call a NULL pointer.

Correct the decode table entry for VPERMILPD so that we get the
expected #UD exception.

In the x86 SDM, table A-4 "Three-byte Opcode Map: 08H-FFH
(First Two Bytes are 0F 38H)" confirms that there is no pfx 0
version of VPERMILPS.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3199
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f4192f10068..805cfd08e83 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -643,7 +643,7 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     /* Listed incorrectly as type 4 */
-    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
+    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-- 
2.43.0


