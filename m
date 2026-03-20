Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2871098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Zi1-00062i-Cb; Fri, 20 Mar 2026 09:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zho-0005uf-DC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhm-0000LE-3A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:15:59 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b976536806cso303958766b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012556; x=1774617356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbg/XjaS6+MPWBcOfNuHiSkOYAA/xRfptxmMgNfQPiI=;
 b=BPj7O80IPK0kdkKc2rYnQBNXb9s5feQCBoyak5nHfWQsto3rWXFsfa1txw8zkRd35P
 2ocH6xN/cYJA/rUk4RrUlvWI3OTmGj6YwqP28nN8ZTeEqtbOvlzTZMj0De40/dfnWHnm
 X5xRi1BxCFOomJ/q6nfNy9KwuGU4krzm7ft4R+zu9+U1nfFzSlBXaD9cSSf7ezb3a1j/
 AtYKhTfHTBr3+91KBIKUbNfjvRtjzItJOgTmS3HZVZfmhAMvKTeMvYOIT1qvGAZVZnXs
 tUAZK36npro849b2D6ZIn9uFEE2DXfawC1NiXzkg6K9la15wVie/CiXjtSVAn8oXbboD
 Wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012556; x=1774617356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbg/XjaS6+MPWBcOfNuHiSkOYAA/xRfptxmMgNfQPiI=;
 b=FHUnfsPYOnxNoP/3A4y5ZSCMQqMc1GAh0BAfoY2aG4SMZD16IXhfoz6mg/XEMFHsbw
 7kOd2UROKpCs4lTjpYE34lOqqGeIRWxVLXd/rCZH49xHiECqQZuhfIObKKm4mHBsXe0b
 vNoPp0+4j0Rkx9RScs3WkF03fxV8kPvt6txN1FbKdacbEshsqxaIvK6s3h1QGB8mcxxl
 riDSNMVKHRQidMCUxqY/eWTTX+UsTQ4hLyZvi4TJ1HM+QTM3DkjZHFPdwC0psg4jVlm+
 DtYGRGBV2aIxvUlSkM2F19orInFGAGz3480PlYNl2izWiR7kQkT385jRH0uj7f68M67L
 zMYQ==
X-Gm-Message-State: AOJu0YyK3bsWS82LhvtYX9ptFp62V/3/OZSzZj84HbNMNVPxGk/jkNo3
 fvkNW+hPnxOPTywJILveUA7d+gy3xiAarVHMn8IGvOcWwID7YoWPs8ksDWRbOanYoSw=
X-Gm-Gg: ATEYQzyFRegQXt/wVmfD/KqneOXl3+Lp90KuN1sKBRsvJ4WiDFeAHUhD4Mh4tczLpXO
 6qpuNCGaAxzAo1IwfUkQ/oXv5Ib/nTH2aksQoB2kCzT/l2qfno0QoFV3r6ooD+h79MzkWMlB50j
 r1PC2qPJHhrLJsj3YvPsFqDFP0okq42Oo2OVTQKwl7iCZHhu9ikFDAxh7RTIelxVtIz8XIQO62m
 5UfxNyJUrYwcOMeAzCBM6G7wh43uMGwus3WVaHLdhMvTsimlRJmPFZ1MNJtkLiJU0IW9wRU7fsz
 HLNQy1VpHVxXkyc8SDJDoJ/pmVtFHNbNG4n+t/um34TeIcLESF5S9BpOkmv9Bs6EXOAP7Oluav2
 /jISW3qNly61jcnZ/W22yMKxYovgvO42rLyCkJYZ9qXJhHgfWYKQPUd/mdspx2JE0b10kv14gaF
 xVTymetLvK/kF91vq8FgXxa4k=
X-Received: by 2002:a17:907:d307:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b982f1ec9cdmr220292466b.3.1774012555972; 
 Fri, 20 Mar 2026 06:15:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832beecf4sm163503866b.0.2026.03.20.06.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FE115FAF0;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 33/35] tests/tcg: split stage 1 between devices and RAM
Date: Fri, 20 Mar 2026 13:06:04 +0000
Message-ID: <20260320130607.2071996-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

All the -M virt devices live in the first GB of address space. Add a
1Gb block mapping for devices and continue pointing the second block
at stage 2 and adjust appropriately.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/boot.S | 43 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8bfa4e4efc7..03a5bad2ab0 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -248,29 +248,34 @@ at_testel:
 	msr	ttbr0_el1, x0
 
 	/*
-	 * Setup a flat address mapping page-tables. Stage one simply
-	 * maps RAM to the first Gb. The stage2 tables have two 2mb
-	 * translation block entries covering a series of adjacent
-	 * 4k pages.
+	 * Setup a flat address mapping page-tables.
+	 *
+	 * ttb (Level 1):
+	 *   - Entry 0 [0 - 1GB]: 1GB Device block (for GIC and other H/W)
+	 *   - Entry 1 [1GB - 2GB]: Table entry pointing to ttb_stage2 (for RAM)
 	 */
 
-	/* Stage 1 entry: indexed by IA[38:30] */
-	adr	x1, .				/* phys address */
-	bic	x1, x1, #(1 << 30) - 1		/* 1GB alignment*/
-	add	x2, x0, x1, lsr #(30 - 3)	/* offset in l1 page table */
+	/* Entry 0: 1GB Device block mapping at 0x0 */
+	ldr	x1, =0x401 | (1 << 2)		/* AF=1, block, AttrIndx=Attr1 (Device) */
+	str	x1, [x0]
 
-	/* point to stage 2 table [47:12] */
-	adrp	x0, ttb_stage2
-	orr 	x1, x0, #3 			/* ptr to stage 2 */
-	str	x1, [x2]
+	/* Entry 1: Table entry pointing to ttb_stage2 */
+	adrp	x1, ttb_stage2
+	orr 	x1, x1, #3 			/* ptr to table (type=3) */
+	str	x1, [x0, #8]
 
-	/* Stage 2 entries: indexed by IA[29:21] */
+	/* Stage 2 entries: indexed by IA[29:21] (within 1GB-2GB range) */
+	adrp	x0, ttb_stage2
+	add	x0, x0, :lo12:ttb_stage2
 	ldr	x5, =(((1 << 9) - 1) << 21)
 
 	/* First block: .text/RO/execute enabled */
 	adr	x1, .				/* phys address */
 	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment	*/
-	and	x4, x1, x5			/* IA[29:21] */
+	/* Note: we assume RAM is in the 1GB-2GB range, so IA[30] is 1 */
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and	x4, x4, x5			/* IA[29:21] */
 	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
 	ldr	x3, =0x401			/* attr(AF, block) */
 	orr	x1, x1, x3
@@ -280,7 +285,9 @@ at_testel:
 	adrp	x1, .data
 	add	x1, x1, :lo12:.data
 	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment */
-	and	x4, x1, x5			/* IA[29:21] */
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and	x4, x4, x5			/* IA[29:21] */
 	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
 	ldr	x3, =(3 << 53) | 0x401		/* attr(AF, NX, block) */
 	orr	x1, x1, x3
@@ -290,7 +297,9 @@ at_testel:
 	adrp	x1, mte_page
 	add	x1, x1, :lo12:mte_page
 	bic	x1, x1, #(1 << 21) - 1
-	and 	x4, x1, x5
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and 	x4, x4, x5
 	add	x2, x0, x4, lsr #(21 - 3)
 	/* attr(AF, NX, block, AttrIndx=Attr1) */
 	ldr	x3, =(3 << 53) | 0x401 | (1 << 2)
@@ -317,7 +326,7 @@ at_testel:
 	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
 	msr	tcr_el1, x0
 
-	mov	x0, #0xee			/* Inner/outer cacheable WB */
+	ldr	x0, =0x04ee			/* Attr1: Device-nGnRE, Attr0: Normal WB */
 	msr	mair_el1, x0
 	isb
 
-- 
2.47.3


