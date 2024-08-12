Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD79FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdLGt-0004W4-VR; Sun, 11 Aug 2024 22:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGs-0004Nw-05
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGq-0003h1-Fx
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-710d0995e21so2371729b3a.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 19:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723431535; x=1724036335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRhHm135dGLBKgHTs5Bk6uiyESpFu38TL3b65HCIA00=;
 b=TYmYP7kEiGi6Ybujhlfdcn2HdF/jG9zxqxDaxZZ3u5ps6I98Ul9+CZKQUVRXq3MdoA
 X+QarAwZO8xT3ocSLd7zybfS3dAdtfy9clgtE+fKg2Qz5tlevO26vZvD17ReM9FfIXMZ
 ubPAdStf87nUBBxzKPA5+G8w98lpD/kUPtMts0bNTTY/3oD2kU0SAy18ShLrue9SjaGc
 16cHGjVgJaSa7CtvMtJUjdxuYmcQ89EJA2NZlFlH90jhdJXmkaoGKUa+ug5Wf1d+BNH3
 Cf//7chCot6UoPaaECwczxp0QkK6N7UL6pPYmHlLTyGciBf1CCqwAwbSklxVBqNImwjh
 qq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723431535; x=1724036335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRhHm135dGLBKgHTs5Bk6uiyESpFu38TL3b65HCIA00=;
 b=uY3Ax2e6LTe0kYXNx54zRCYOKLOTVmLu8e+/oVVsyh1YztEQIybzR+dvkMdogiOyK+
 HPqP20RDRAmcr0u+c/PJrhp4+ay+WCWzUnIafkCjIgNuK6L/uu5CA557lu06HncHTYXX
 pwRdOzCeKo2wzQFcEicGDiWZ5RCd31pijXBQ1Bw0VwI8X4/VyHJ2+eY6Rcqhcaw7ct6Q
 KlmM9fK2LiEPITLZ9zFJQSd3z2ACK05utXBozbXgf60ncVT1WHUGlnrA0pLxVMQZx1wu
 7gsJlx5gtynKXyW9WoD487CCeJG0Vv0OstxrWhce7KnVz9lJMjhnjhgG052mCBVeWyMD
 hYJw==
X-Gm-Message-State: AOJu0YzaMS44l6ASsq0iJZB5AaLN3fruNJH91QkRSqwnlrInX0MARolf
 AaCBz0DQ2gHAWzQr7aH1vamd6X6XPdHBl6Oz4z3G1REH9sf//liYxmMQk4W1B4ZuA4vH3GRYLgX
 jQNk=
X-Google-Smtp-Source: AGHT+IGrkLo9fWBpsiO0Y2iwqHpkxetwZw+0N9VF770hB1YmLFkdgp4bogxObX0pCsC/KSoB62gp7Q==
X-Received: by 2002:a05:6a00:b56:b0:710:9d5e:8a3 with SMTP id
 d2e1a72fcca58-710dcaa69fbmr5541620b3a.30.1723431535076; 
 Sun, 11 Aug 2024 19:58:55 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43b49sm2984841b3a.100.2024.08.11.19.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 19:58:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/3] target/i386: Use unit not type in decode_modrm
Date: Mon, 12 Aug 2024 12:58:43 +1000
Message-ID: <20240812025844.58956-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812025844.58956-1-richard.henderson@linaro.org>
References: <20240812025844.58956-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Rather that enumerating the types that can produce
MMX operands, examine the unit.  No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 03138b3876..30be9237c3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1799,13 +1799,13 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 }
 
 
-static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
-                        X86DecodedOp *op, X86OpType type)
+static int decode_modrm(DisasContext *s, CPUX86State *env,
+                        X86DecodedInsn *decode, X86DecodedOp *op)
 {
     int modrm = get_modrm(s, env);
     if ((modrm >> 6) == 3) {
         op->n = (modrm & 7);
-        if (type != X86_TYPE_Q && type != X86_TYPE_N) {
+        if (op->unit != X86_OP_MMX) {
             op->n |= REX_B(s);
         }
     } else {
@@ -2040,7 +2040,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         /* fall through */
     case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
     get_modrm:
-        decode_modrm(s, env, decode, op, type);
+        decode_modrm(s, env, decode, op);
         break;
 
     case X86_TYPE_O:  /* Absolute address encoded in the instruction */
-- 
2.43.0


