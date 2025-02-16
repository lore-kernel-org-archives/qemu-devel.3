Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C26C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnx6-00051Z-C2; Sun, 16 Feb 2025 18:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwU-00042g-2m
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwS-0006QZ-5o
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:53 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc737aeeb1so493956a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748048; x=1740352848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0fHQegwRDh1B6nDUSydnGcbynAFoVglk72ebkdDcM+o=;
 b=acWxpvBqGJkvNgZDzByTw8nIe7MjIkVYKa9oKxy4vAZBFSiBVSIJbeebVqkQSUZc6h
 MDwmiCE7t2gAbslpKx45LPuwYJLfi7oni7OVXtolFWGMU7BA3NbVjHIsBue+ANi6aogJ
 bfYmkWnGHDSPs8a+ej8nGdBHHTFcoMC5mnfltTgt0f1iSnydkmFD31H10iG/BjW+CpKU
 sOhHEv/Qee7Aw+/GaNmETSvKOflFZDecxICX0yL7C1ntoozNmDwB4SfghOjxfRW9NmTZ
 VU9aNAPoveaOa/hEQB/ox7//0LsTYCiy3hAPKN/QPC38rr7REgov5gh2nOPDCf7Ux7wx
 0KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748048; x=1740352848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0fHQegwRDh1B6nDUSydnGcbynAFoVglk72ebkdDcM+o=;
 b=Js3rbkSCGEeQSqafVEQnWTrF5vBxEHWuyJG0+tC/gE5+NpK28x3qFOXL8G3+9ahAS1
 wZ2Zf/KHCKTRpb1MpxZCq82ikgypKLn2d1dbbskVaF3mStq5ai6IKHt0EhJ+MZo2M7Yl
 gDKDtgrss6ZH7nbIpl3Zp+tbq056wnTSIXxmNlNi8N+nSu3Jcg7wOqKjUEHfAAwRyJ8e
 Nk5FH4yTqf4QtFHEJlv8+kJSbZ6DJyx574C4EIS8VBXo9kuR1CIdS94bLGq93NRdfQqv
 lYZqUSzxSs2453vF+C+IfobzBK8gS3jnFol0B4k7bO7xnpXRB9ACnGPtF24CuZ/leXkl
 sYLw==
X-Gm-Message-State: AOJu0YwenzfrRyhGmT7bxD9k9Igh+n7xy1Al5mS5BYicE37zq0ENu01O
 R4FuQhsDZTAr1nAXSEypTWOP6Iko6EmPwd6k8WPGMsXHi9Juqug0Y5o2TJryKJVa5hjh9BTNI7L
 f
X-Gm-Gg: ASbGncsQPDys2oVzUbqWsPpgYNV5lW9dJqBv76muQxXRIbIOVyCWkeNSRSx8XEi5iIW
 MzJUYXFFyc/g4qpWDU2nsjULdTQ8h+ocutuwAHQIDcVEsOTCxu8hf5mpuiCq8YXqfnc6MRNtVrH
 Tc3UBjR/C5RfoGKxwrm0c/BmSqYAK0HtsIEgERwfIHmEbxmZSOD6MdePMO7nbqqu0I2a7faH1KX
 D/iwUEjUnN0paa4hmT7qt1rzkrkaSBarLxEdE4fNSAEmluPXTnnr4gWFrnP/xxnc5RRNJu65Y2B
 CPcGgiV94DD75STzGlhAtKGopQRBp6W7TqOiNLJAt57M1C4=
X-Google-Smtp-Source: AGHT+IEbJ+4iXoYjqxTRT8ABv/iQMoZ5E8xK5CyWjQy1rRPJVKlsxVbFrwMREzla15iWPwzdrdVJOg==
X-Received: by 2002:a17:90b:1b46:b0:2ee:48bf:7dc3 with SMTP id
 98e67ed59e1d1-2fc40f2210emr11995731a91.15.1739748048518; 
 Sun, 16 Feb 2025 15:20:48 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 125/162] target/microblaze: Use tcg_gen_addcio_i32
Date: Sun, 16 Feb 2025 15:09:34 -0800
Message-ID: <20250216231012.2808572-126-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Use this in gen_addc and gen_rsubc, both of which need
add with carry-in and carry-out.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 24005f05b2..768c6ee945 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -310,11 +310,7 @@ static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
-
-    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, ina, inb, cpu_msr_c);
 }
 
 /* Input carry, but no output carry. */
@@ -543,12 +539,10 @@ static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_not_i32(tmp, ina);
-    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, tmp, inb, cpu_msr_c);
 }
 
 /* No input or output carry. */
-- 
2.43.0


