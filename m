Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD6EC5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yB-0003ga-AM; Thu, 20 Aug 2026 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5y9-0003g6-I7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5y7-0005MZ-PN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHcQ+5MsxeOy0E6QUpuQYiOF83NOeZ6t66HKr1uZkgc=;
 b=FUQ6Tv3lpDeggBRydNEMbm/4lSmNyDAskpUPXcj3eBJHZ3p6RPJrru33I61YlSTdGyaCQN
 b+6xyToge0ubNfJoDTdArdUM0ssSOn7yLczM82G7gU6RKcovYw8HfUCvztNzLlGGJgeifs
 3KzRK57wx0+w7MGGDnv55A/neZhsanQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-4k3p2fLYNBWtfv358Ndm0Q-1; Thu, 20 Aug 2026 12:50:15 -0400
X-MC-Unique: 4k3p2fLYNBWtfv358Ndm0Q-1
X-Mimecast-MFC-AGG-ID: 4k3p2fLYNBWtfv358Ndm0Q_1787244614
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-499a7993a9bso265125e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244614; x=1787849414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jHcQ+5MsxeOy0E6QUpuQYiOF83NOeZ6t66HKr1uZkgc=;
 b=ebmcuA032vZYudTzcs1a2YryJfXEXC69+KI+qFKOL1nFNvQcv/0yLv50TYm6Fx7dOk
 cad9Q9MZ/CA70hyOAOtt2aTNZSNll2wfQlkPd8EXbfTwKIbfCnbOi8hH2F1J1IpNg3DO
 di5IKFCQa6yCDx+zjJ6pKUOggMH/LUmHdrZipoyGegE/R6X9hjosMGhidXizuAQkCJd2
 t9Bma4zNZw8C9eXWLQqf5sN3jj7NrWUS1JGm3V4jEG+UAWWzxPuqYSID+xrlVVgiadgy
 iud/JOhw1++4K5IyjdLSlRRoWBsFeEQ/+KMoneD3mtryz/ldu5NCiJf0tH4jpx3S1zMF
 WqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244614; x=1787849414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHcQ+5MsxeOy0E6QUpuQYiOF83NOeZ6t66HKr1uZkgc=;
 b=jDDt4pcq7c+EekkE8l0vLcaP0nQrGfR56lTXfHqw8qMNys40Cb9IY6Gs+O6RvQx/p+
 y0KHyNT5PEJvqYGVpJ8lBMUhHCutp9/bO25vi3LlEvPUmu36bGVApU074U5UOrLS23oP
 qRb2ktSSUYHrLZqw4nsVB3/oIqY9H0yf58FEw/7tjCg+AfqtHLAmTo+674W+NkJHjms1
 n7j8viMOlGg2Kqh7a3rX4/CyYlbVbQDCPHzP89CM9zOSqhuhxlCuvMQJmLIzpXoF25LE
 zn0n+qClbq8GUDzUtSTbd+w6eB8ja8I90WXY2Ert217jUfffjAkysWg8a9HWZbcVOwor
 sV4g==
X-Gm-Message-State: AOJu0Yyt8ibZ+eGiTk0HT892EZ4FWpyKzoY/H0rzUJQyoHpdZCN5lXzJ
 /GE9sFRE3CtrcL+TPV4ulr1DmgzKGOq4yU2HVhlACRkb2ljLlkSZEFWu0y7ijbK1F9anLfUzh1Q
 0dMbKB+HEqwup8f8aqmy8+aKbfE21BmmzWt2dxLIkV8AcP7uBh+ULlT7hHvNqrYTYynRCPdKTdU
 yPk/7JhNKM+mlFQUT4nG5oNBCfegr1Czz5ch6bzc48
X-Gm-Gg: AR+sD1082aAdyiwsSRw+SnPyajQ5zlQBMnjZ3utJNbJl+gfKIt4p18EjUiabPl5+HnJ
 VwxB/UIM4EXdOR7/tneEwrk+vttwmukNIwbGIjza05CT0/cb/2TCw9W2SyPwSTPHtvXjAIxsTcT
 nWzaLutIFHu6ks+ZeKdSI2GKtkbPRsHnsMBR31ZVLQU5bVNnF4CUtmAFmqDvGyxnkw477S0Dg8p
 T7pmxbZMTXx9eA8C03ZwOMHB7jStOatWpjqHnD0WaLjHJ5y1PV/oej9WJ6WkV1Y5cjvYEbwIofA
 n+8lWwE6ByTFtrUPdnNqcv3J3NYg6lpI2/0NJG+nzbBKjRcRkO6Ef9jIhNlf916AUxBqbS4C2aV
 LroSQgXkorXuNUnTEspb5Kllcp78iWVtG1o2Uc+HLSgzTvrL0wFI3i1iGUcAF1cSiEvG1qFyKsN
 clHOQ=
X-Received: by 2002:a05:600c:5487:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-499b821831dmr7087735e9.0.1787244613926; 
 Thu, 20 Aug 2026 09:50:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-499b821831dmr7086535e9.0.1787244613475; 
 Thu, 20 Aug 2026 09:50:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0e473dsm145979715e9.15.2026.08.20.09.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/53] target/i386: fix incorrect decoding of EXTRQ_i
Date: Thu, 20 Aug 2026 18:49:07 +0200
Message-ID: <20260820164957.1895963-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Simon Scherer <scherer.simon89@gmail.com>

The decoding of the extrq instruction with an immediate operand (EXTRQ_i) is
incorrect. Per the AMD manual the instruction encoding looks as follows:

EXTRQ xmm1, imm8, imm8   66 0F 78 /0 ib ib

The /0 indicates that the "Reg" field of the ModR/M byte must be equal
to 0 and the XMM register operand is specified by the "R/M" field.
However, qemu incorrectly uses the "Reg" field to extract the register operand.

This patch instead extracts the XMM register operand from the "R/M"
field.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3611
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260625155613.192643-1-scherer.simon89@gmail.com
[Check for the reg field to be 0.  Make decoding of REPZ+66 consistent
 between 0F 78 and 0F 79. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac181308ca4..ac5964b95de 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -603,23 +603,33 @@ static void decode_0F77(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    static const X86OpEntry opcodes_0F78[4] = {
-        {},
-        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A)), /* AMD extension */
-        {},
-        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)), /* AMD extension */
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F78);
+    static const X86OpEntry opcodes_0F78_f2 =
+        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)); /* AMD extension */
+    static const X86OpEntry opcodes_0F78_66 =
+        X86_OP_ENTRY3(EXTRQ_i,       U,x, None,None, I,w,  cpuid(SSE4A)); /* AMD extension */
+
+    entry->gen = NULL;
+    if (s->prefix & PREFIX_REPNZ) {
+        *entry = opcodes_0F78_f2;
+    } else if (s->prefix & PREFIX_REPZ) {
+        /* undefined */
+    } else if (s->prefix & PREFIX_DATA) {
+        int op = (get_modrm(s, env) >> 3) & 7;
+        if (op == 0) {
+            *entry = opcodes_0F78_66;
+        }
+    }
 }
 
 static void decode_0F79(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    entry->gen = NULL;
     if (s->prefix & PREFIX_REPNZ) {
         entry->gen = gen_INSERTQ_r; /* AMD extension */
+    } else if (s->prefix & PREFIX_REPZ) {
+        /* undefined */
     } else if (s->prefix & PREFIX_DATA) {
         entry->gen = gen_EXTRQ_r; /* AMD extension */
-    } else {
-        entry->gen = NULL;
     };
 }
 
-- 
2.55.0


