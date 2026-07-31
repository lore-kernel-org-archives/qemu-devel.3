Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0ABC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQM-0007mu-5T; Fri, 31 Jul 2026 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPR-0007RE-Is
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPO-0002Cq-Dx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso15496105ad.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524197; x=1786128997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eyC4JTqhNse1RFu4uJWHTmfRM+J0x4ahGdWjrgnYMPc=;
 b=orCgIAGgjvCvswzYBt6cKHv+vU1ievUJ0RNCsKo1/cziQfge3qL62oMsUqbnJsYZVV
 7rY9jY9z7X3ADhDZqr771YlUynN5knEnwbYfiu6iahJMPD38IZN2xojwRAf605OuK79j
 i7p7EcxJqL8+JA21syy13g9PUFAsGilZREXcfRUuviwd8dc7Scu0X/XePckDcucXFgHk
 oJYQD395wfk9K7OEe2vD27fRB1L33byz9T92r223s+g4ujK0eEr766u93oL9qtDb/sOp
 JqhHdFVwCpAtK+OfgE8UQB7MinREaic3GB86v3AKFOGW25R2iHg1sudLbAoK8QxWl9PA
 0Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524197; x=1786128997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eyC4JTqhNse1RFu4uJWHTmfRM+J0x4ahGdWjrgnYMPc=;
 b=JLfKrBaor56RleEbNhRkeDzMxqI7pD1R2hh474iALTIXfqyrnXriMSCeiJ4khuobW7
 0eFK+8nch7GgCoeewHQYuWSz19MvBOYLKf+cGRxUUr+WGMP5xnUUVk1mgG83ZgKxuIvp
 C5Qro+vV2dQL5GiK+8KK8/rokIf8xvWQolRQBZzgwPcEn2RzE2KxsGLVYlDYNEqUYbXd
 D58fDZy4n8YO89nFYxKBYR2o91NAHZwkfreMxdjj4zDEC3luhVGiyjOUbXDnHq7DfwRM
 POw41lkoTatnNd8capksuCZigq7k4GYVjdKf4nZwcTKYGdq1o+vAl+73eQyza++AOVvX
 jfCA==
X-Gm-Message-State: AOJu0YwJUApdcTv7/rcwRBdXpf/OMUB9uFrwOXvL6ZsqWWaGQZuFj5BN
 +465KJolO1jLRFFZqhKQtnNvIKUNApNZALXNOQ6OVmCeGxIpDogEPVr2+eFsg6YzcvxgIjqg7RA
 p5tIR
X-Gm-Gg: AR+sD10PfkinCF0AU+W9zL/4CVj+abx+F80IdhDc+YKehj9Huz9+BZz+Gp3WfGSniyI
 TL0qL1UTN7oJ0uIVXQUel/Axfle18GadTwJDUCzEECL1syHl8zEBe5d0VUfkwfZbrMCFDtzBhwQ
 8D/34t0OMa42izvGDKvdiUdncORsDX6PNwbsG4NsqlN0l9Dhj0QCkdeTdmc5/DtDj91RiIVM1Zu
 8ejM8OWKvII+6LSwapZTLfLQmi3DHKTcrWhp3FJ0AOZGSCX+XLpXakonrUn/SKWHj+GoLrJRc8l
 yHOO+fsGSrsFUugxCFzq7IhOefxM5mGzRcNAulUL/S+lc6ChGSTY5y1e9BsW1hzM1fLT4Q3v/ir
 lh7JoqYoHDECvQ3IZ6HxOJ6t4n1TYJtaOruc7xDCK0uw8T1csznPHdhywmCpkZ47xJs9kNnVY0c
 2B+cFiQOE+X+QWdDNSkX2yioJ5LqtEn3VGfP+1VyR0XI3KVCwzLIms7nboVMIJbZ6mYOiK1ap4L
 NK5dMMNO/YInfcjMAp5QA==
X-Received: by 2002:a17:902:d48d:b0:2cf:8363:5ab7 with SMTP id
 d9443c01a7336-2d0523f9efdmr9508555ad.26.1785524196696; 
 Fri, 31 Jul 2026 11:56:36 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 08/14] target/s390x: Convert op_st8 to op_st
Date: Fri, 31 Jul 2026 11:56:21 -0700
Message-ID: <20260731185628.23161-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Begin unifying store operations by storing MemOp in insn->data.
Start with op_st8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     | 4 ++--
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 34ee2d6087..feaada544a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4342,9 +4342,9 @@ static DisasJumpType op_stfle(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st8(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_UB);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), s->insn->data);
     return DISAS_NEXT;
 }
 
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index f72607e389..6fdd730985 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -859,10 +859,10 @@
     D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st32, 0, MO_ALIGN)
     D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
 /* STORE CHARACTER */
-    C(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st8, 0)
-    C(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st8, 0)
+    D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
+    D(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_UB)
 /* STORE CHARACTER HIGH */
-    C(0xe3c3, STCH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st8, 0)
+    D(0xe3c3, STCH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_UB)
 /* STORE CHARACTERS UNDER MASK */
     D(0xbe00, STCM,    RS_b,  Z,   r1_o, a2, 0, 0, stcm, 0, 0)
     D(0xeb2d, STCMY,   RSY_b, LD,  r1_o, a2, 0, 0, stcm, 0, 0)
-- 
2.43.0


