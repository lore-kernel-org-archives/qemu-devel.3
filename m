Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFX-00009M-Ul; Thu, 02 May 2024 01:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFM-0008UO-7O
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:44 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF4-0002cP-05
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:43 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-23db0b5dd28so517246fac.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628665; x=1715233465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2qMHX2+XNKUy8pt8yib4yrbmg7rCMDrLvF6E3jB/iQ=;
 b=h+nBeluu6wX3LOz0iyFqSzrNqJTCHzUKybYjnzRRRFhDAKfGS837SgvCnh/MTbIhDw
 aaiAXLhGuENdPBsDzAo2by38sr9AXT9KlF0Y3I2WkC723i2zLdvGlIwFutiLr9pwnY5O
 wMoyO8v3Kz0qS5IO8DlP9R75JHAMxWjaXZkUir/CCJxfh9/sRAGg4nf+7e+QSIPcDBxP
 xQ0t5+6ttbyTxtEdSEQsi+8px/6wWHpyXf6KJVd+iDeQLrVymk5octFlL55AlXxVXHyE
 HKXR5peJ2ZFxIDsyflQdZ4CSifs80pSzFjDHMoeS/3m2qpZ4YpUzhw0HuD4+V2hReKz0
 BG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628665; x=1715233465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2qMHX2+XNKUy8pt8yib4yrbmg7rCMDrLvF6E3jB/iQ=;
 b=FpFInaLCho2W/urOkLNc2rff167ZjEHh7UjLG7EhSrcURwrNxL7dGD5jbqpS6oRKRT
 IshBBLZUQ0/WcRFitepbpuJ6qkxxaOlzk2EL0wCytIIy0vqWeVOYHyCBnFRy1o5AtMNw
 sJdLtFrMyUGuyTFCG1n3yAcl9D4Ec+KEt6/L4LlJ8JZfjbrIC889C7NYgp5+LEU9BxqK
 N0WXi3gMS1uJNXewKcDYz5hrVQFBTWk5B690bCEBIX/FIZen6+vsg40MZDHJbMkZNDNr
 OSpT5bg93IrGAs/tqzVFVBlDhOiZF/0IsRWr84NgqWGN73uC7SONxRxckgyr3I10XKqA
 nDZw==
X-Gm-Message-State: AOJu0Yzl22IFkiA7VkO2PGA6BY9UtIdDuusvW85uZC10cpTjsWDhFmBp
 lfXCIdZRrzL83uAcggLHWpnb5VCCHQ8VtM558Zfi7CmmggXlDtZ+TF5jDmvxrb+g8O8pGeDqrr6
 L
X-Google-Smtp-Source: AGHT+IFnbxn/+FHcQHKZ2ouEnOWfISkF36KYrciVmgstNqS3pJ4JD5oIIx9j7ALJ+Fp9Lo7a6LVLag==
X-Received: by 2002:a05:6870:b629:b0:22e:b2da:af39 with SMTP id
 cm41-20020a056870b62900b0022eb2daaf39mr1377566oab.47.1714628664753; 
 Wed, 01 May 2024 22:44:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 05/14] target/s390x: Disable conditional branch-to-next for PER
Date: Wed,  1 May 2024 22:44:08 -0700
Message-Id: <20240502054417.234340-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For PER, we require a conditional call to helper_per_branch
for the conditional branch.  Fold the remaining optimization
into a call to helper_goto_direct, which will take care of
the remaining gbea adjustment.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 3622c5c883..c3c821430d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1133,13 +1133,13 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         goto egress;
     }
     if (is_imm) {
-        if (dest == s->pc_tmp) {
-            /* Branch to next.  */
-            per_branch(s, true);
-            ret = DISAS_NEXT;
-            goto egress;
-        }
-        if (c->cond == TCG_COND_ALWAYS) {
+        /*
+         * Do not optimize a conditional branch if PER enabled, because we
+         * still need a conditional call to helper_per_branch.
+         */
+        if (c->cond == TCG_COND_ALWAYS
+            || (dest == s->pc_tmp &&
+                !(s->base.tb->flags & FLAG_MASK_PER_BRANCH))) {
             ret = help_goto_direct(s, dest);
             goto egress;
         }
-- 
2.34.1


