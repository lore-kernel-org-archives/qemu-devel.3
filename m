Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C11FE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1O3-0000Mp-2I; Thu, 19 Feb 2026 05:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mk-0007ML-2R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mh-00069V-5I
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so4606585e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497273; x=1772102073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8wCrjnbR6gN2s4JKqY08v6cnVRR6BXIZOL72N4+4TXs=;
 b=pPSN5CQyjH7s25zfGjw9Qt0vdsXAQ5YvS21lOjphHXdhpC5mglcAPWenXQizPHgWPQ
 +GF2/+OARzKHg9ozuBRVBNHyIbRnSAGxN9HNJbRj0ayBq+Clc7j1LdKnlKnYMUrVsQ+/
 As6WAiQHPXP8XecWNYMeB6/eHOWGe9R/83ln1ao/YcaHRB2VOlgelTPIfeKN0Z5NwDvk
 51+aNwrih0JX2KgIR00vXQHPDYIjazOHLjdvqwcJkknx/xWe+txJASSdprafg4ILDOUj
 y7+Ui5C3YO0H/vQzsx6P6r12z46h6LN+NyOFu6t4wP3tsZ64B4WqzDKxf8iR+nlVN54u
 BmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497273; x=1772102073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8wCrjnbR6gN2s4JKqY08v6cnVRR6BXIZOL72N4+4TXs=;
 b=hMtnXf0tHQxr0PFq5JrR6fiKb2pxSyUKDG2Owk1VBhZfVaGeh8+UcXuNsAmoH8LgsT
 m94tUzQ7rpbOCTPas7FUY33UfXrQbBAvvbMsQq4hOgPg2hgD7b++trvl7TNeVD7BhxBS
 ULJgJw2BIhU7CYl+vUmpd7sue9w6PhjgtJLW/vL+2FXLbIm0/KHSt1a2QjoZyGTwDS/8
 IVF1IWYRt3x0qdpJQr/N2QPVjKAOzsLOeUkY6LIoYXwktUUpJc4tS7lPLSQgWqyfEgie
 y9uFtlrCX3CBpozlGjYu1Tj8BIs8v87B8ENfPt6v1P4MEtR/N5x6GUticjbTZyoFoAFb
 t7hA==
X-Gm-Message-State: AOJu0YyaNZYdz4gFCrDiwzINXOyamp2P+MejOiULPzYUH4ybWB+pLrz/
 VYIBrACTl5kPaz8/cGjR9A0JSZuLepfWfz61nrDxcgYEAx2/eWYI8EJklj7j4ve8qc/H3kXHIZq
 dC3SL
X-Gm-Gg: AZuq6aJLaEr4tN5Vp9IXUM6zmXCEvvvzlWbskBVFPOdCu9SPZzlNRlwTxKQ+Le9qu5q
 HZL1uiUh7IA5VgCydRpWBp9JEIwSJFuBKt7Gp3dV2GK8IMPBZUKF694/pJBYRIqR6NjQfN6Dlvx
 ZAITfmgZ3/F+jcUUElzrNtLLc+uz2Dskx3D02BmenS/3PwD5eg66XucmF6xiVKb9cvqNS9uw0oT
 R/HxiaQZJ1pw1KBd5kheAVW5xJ7u3uiaKQR6e/PsdNEmjlCTaHiU4REDBPteFL0myAp2fLRXgK+
 J7VffUrG69X9VndbvKtkE6K2J5aSihpkVXQ0lTIUktOtlQu/ogMK+m9zCT4jomn8faJ7Lbe8VZ0
 Yov6XizUK8YH8Us+1Et2ugbklK4oMI035vhKMafjU1j1NrEuo8BGH03Pws6K+yoAcGvXInOzGJG
 CQIWpeIciZeJdZz3bennp3x7uPZGO9J5nuv8AMZTxGrO5R9nFXvgU2QoBtUsVs63H+Moupw68UM
 YB/W/K80peR4p5M9pJ+97hhGzO9QhA=
X-Received: by 2002:a05:600c:c174:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4839e66f689mr40534025e9.35.1771497273571; 
 Thu, 19 Feb 2026 02:34:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] target/arm/tcg/translate.h: replace target_ulong with
 vaddr
Date: Thu, 19 Feb 2026 10:34:03 +0000
Message-ID: <20260219103405.3793357-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-13-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 027769271c..2c8358dd7f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -18,7 +18,7 @@
  */
 typedef struct DisasLabel {
     TCGLabel *label;
-    target_ulong pc_save;
+    vaddr pc_save;
 } DisasLabel;
 
 /*
@@ -42,7 +42,7 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
-    target_ulong pc_curr;
+    vaddr pc_curr;
     /*
      * For CF_PCREL, the full value of cpu_pc is not known
      * (although the page offset is known).  For convenience, the
@@ -56,8 +56,8 @@ typedef struct DisasContext {
      * pc_save contains -1 to indicate that relative updates are no
      * longer possible.
      */
-    target_ulong pc_save;
-    target_ulong page_start;
+    vaddr pc_save;
+    vaddr page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
-- 
2.43.0


