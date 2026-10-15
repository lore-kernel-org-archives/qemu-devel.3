Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9C3CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ6K-0005uD-1l; Thu, 15 Oct 2026 06:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ65-0005V9-Gp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ63-0007ww-Ma
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkbJ9i0YnAjOqz21ZmHzFvFJHtPrYwGsShwjnwbM9ho=;
 b=OP/B27JUU+gd8Puv+sNjl/vAqFIWpVs1PYLM27tjV1RZUOVW3tSDe6l/PMmYMICLu3FWfS
 /kOoA7jm79nxiT+sBolx586LIRFSWV5Lp1ej9ANxFtQ34Bjf5Ljrxkz17e3Cp8iC7NVrjN
 4IOxbGx7z+xO4cmBQUNdqZGPZsAsijk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-WPIG-C4vNlaK3ljdJYpDiA-1; Thu, 15 Oct 2026 10:54:01 +0000
X-MC-Unique: WPIG-C4vNlaK3ljdJYpDiA-1
X-Mimecast-MFC-AGG-ID: WPIG-C4vNlaK3ljdJYpDiA_1792061640
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a17ec7a49cso36802045e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061640; x=1792666440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KkbJ9i0YnAjOqz21ZmHzFvFJHtPrYwGsShwjnwbM9ho=;
 b=Vgely8CHloBtCfvg5bgR8rn6XnOqvmzb+5Zq3J6UrI9Qm6DcTa/daLC7LnPRe3L8jM
 /qnzRARXWk8+J1GvppJfm3o1knW4Q6BQgJ9MpLCfezhy31Fdbev8w6/qkSPZH1mE1mI0
 6g6QPAt56MzU+BKDGVaIDTOrKXP4mqXi0mvl1EfunSw0w201uXZyXsASXza91Oe4scwZ
 OfEt5/Li96nG1iJ5PsSxla4cPFcBaGkyNamkYK2H8ibJRIN+3vhZ7k8A+UiWrQi3br46
 Jfy7keu0anNl5alU1RXqIi7EoUQcOelLZ0ENYu83H4j+5pwOH1t+YfmDcWodj7MlxBye
 iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061640; x=1792666440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KkbJ9i0YnAjOqz21ZmHzFvFJHtPrYwGsShwjnwbM9ho=;
 b=F53GSa2JbSXvrnlLfVkzOvvP0dNYkwa2qzNGLp04xo4m/StKPIQgSAvRAvGh12LWlG
 Re27/TQCnTrriJsFSX/7trgAvDIAEBD8Z65vyCI/NaOldsBqaQST7TKFAOwdzkt24wM5
 JlDOy0XtLNKQLNz750UCU9TKK5gnQxOvjkYUa9pYV/ebN79y98PGnKdl7LxdzF7utHON
 Pg1tZgvtugtFdQFGMQkjZCXyqAyWR1f5ANTRx17uTECsfO9n8Ezpe/OQNJ4EY0AItvQO
 F0Ue516SQMgUuOR/PGNK3m6XK/6oHQteSNkKu8Birs25rR7h0iMzRdhPrnuB8DYKjYcB
 49yg==
X-Gm-Message-State: AFq9FYJ9daRXuI6z+bpop58vFMe+WtjtmhV0kpZNMbTIfn5Ihg2164Ve
 1KeCxB2BI5N4BfjBz97o1rmI3UKJR5GeWBeCzLSfIkuirmy8BHpM/IMBwuO+kOJMR4EVuTuX0yi
 aPntyanzuJ11N+ULktQ51YMAkD3nw1UgwFryELZ4AdbnoegiW5GCzDBViTmhVCJkEdykX0D9yEL
 EAmTXFXUwpdZWRrAltZ9zUdtQeO587aCgkyw1CaldS
X-Gm-Gg: AYBFou1wWPNu3xdSFhy54PnrwXqZq5LQn0x+4d8xHmIt56Cebf26kcxoLtd2KunzsWt
 PXKYCJkmNsb9fvncEAd3poCO01ORVHOksF/Uc8Y+kITUcjXf1F+RZJ+/hp0SKClB6AZgLPjXmJs
 e3CpZZH3l7zAIRnQ+cCDNnikEn8Y03U5enh6vCpSR0Ofy19WGFlMJPbiwzatiWytwsoOJX/xFvq
 NVDK3tZ2Ph/ZK21aakZkK/DDzmlg2AQos4K4HEEjOfwfkeeBLs1EqEaZ85IhpaAOe8SHBvmsPv+
 7pZ8bo0faqnBIjPvWUdLHEFFGdjRPYnBi7rZZk+4IYBTTCwdsnf8gKpIGc7oqN6vrY75pmOWxKg
 zrZo227zmXdTpFNgxxD7fsl7QNRZ5Mo2N2hKBwKGhXcNshq5bm7dovs/tEB1nDa7r+hrUbhJnkK
 mv9YSN
X-Received: by 2002:a05:600c:548d:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a18e49c128mr380899035e9.13.1792061639956; 
 Thu, 15 Oct 2026 03:53:59 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a18e49c128mr380898675e9.13.1792061639484; 
 Thu, 15 Oct 2026 03:53:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa34sm17813874f8f.20.2026.10.15.03.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:53:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>
Subject: [PULL 02/13] target/i386: fix immediate stack adjustment for RET and
 RETF
Date: Thu, 15 Oct 2026 12:53:36 +0200
Message-ID: <20261015105347.827029-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Artemii Mashanov <ralerrdirsardx@gmail.com>

The imm16 operand of RET and RETF specifies an unsigned 16-bit count
of additional bytes to release from the stack.

Previously, gen_RET() and gen_RETF() stored this operand in an int16_t.
For example, 0xcaf5 was interpreted as -13579 instead of 51957.

Use uint16_t for the adjustment in both functions to preserve the
immediate's unsigned value.

Tested locally with near and far returns in both 32-bit and 64-bit
modes. Each combination covered the form without an immediate and
immediate values 0x0000, 0x0001, 0x7fff, 0x8000, 0xcaf5, and 0xffff.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2599

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260924200420.21068-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 531398d356b..ed56edf8a3a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3816,7 +3816,7 @@ static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     MemOp ot = gen_pop_T0(s);
     gen_stack_update(s, adjust + (1 << ot));
@@ -3827,7 +3827,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     if (!PE(s) || VM86(s)) {
         gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
-- 
2.56.0


