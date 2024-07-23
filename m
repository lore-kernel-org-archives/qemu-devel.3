Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436B5C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIKR-0005lM-TV; Tue, 23 Jul 2024 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWIKQ-0005kd-AQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:25:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWIKO-00077k-K6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:25:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so3360999f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721751926; x=1722356726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUqqESPN3rURYwrIrQ9xb/I9TaQXbTrIwdP6WuJ8a/A=;
 b=xIcUd5NujFo4h4NiAcVzevt8CaJVlB9YWQhsVXsRa0Qm02uV0odIih44XUjw7yA0SY
 Tk81fzdwcdO3xh+8TC5bb+hG9nS2l0X0NPJse6uaRpE54k6jw4+I0eyTgBNepHq3E4kF
 qfHxNnI+wMm3/4T/NDFT7zOjadsA1v6Sq37/02zxrO6jxpMgIgHmh3RfY+n8VD8K5N/c
 Te72DFcXRaDss67iiLezNR7H80b3AiKaVrMvAvdgqHBbw/F+QPVWOBkmXBHICqzWC9dr
 +GtUROYL+NM1L0tnsDkGBiGSpLfcJ8i7qSTmOho4+znCZQHjKKtGkuLucx18StcSJgLr
 bs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721751926; x=1722356726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUqqESPN3rURYwrIrQ9xb/I9TaQXbTrIwdP6WuJ8a/A=;
 b=QJvMtLYns9NoqQ4W0CYDwEZyq83t7SjEaWxjXFCLHTD56OWd8fh5LtrQKLSb28YjY1
 xCcdZujU4DuQUWe41wK/mz61lZDly6MQkkaCX3LTVY+5zcKuPnu4ko1CwcYefBZcwuBh
 5iEmhMIkaEKiVmx5ZjuLuobi7UGZicpJxSaVysc5iedPIFlr0QI4rqSScYWWDqwT1SEh
 A/xPfW75xaFYc/UeFgrFxPbi0mw53ebfnn8b/mMRqtO+q7RM2W99D2GnIfEkknBQUUGK
 f8vR1e3rmv1EsI0iTwejTb0iFGmIaEj0PbaiFQyVm053VClzPtY09xjtC8kleNOGbHpb
 HdfQ==
X-Gm-Message-State: AOJu0YwTY4tHSxX5jy8h1oWDZVWhPQoftoiOlGzdRsCL0HjzsVAmLJda
 yaNtkrOy9liWUUJYxFIEIPPPwLyyLmUbrgq9zIYkmb4ZONpCyoNMnt1LwcUzD8o5mRNyoc+HOor
 +
X-Google-Smtp-Source: AGHT+IF8LZ6zqPcxpeVVD7P7UVd9ioRazpG/o1MhIy164mxPPVrGHWUPDGHvQUeC/gMLYnQ6/IxuHg==
X-Received: by 2002:adf:ead2:0:b0:366:eb45:6d55 with SMTP id
 ffacd0b85a97d-369dee43e96mr2407569f8f.49.1721751926528; 
 Tue, 23 Jul 2024 09:25:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm180936945e9.6.2024.07.23.09.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 09:25:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/i386: Remove dead assignment to ss in do_interrupt64()
Date: Tue, 23 Jul 2024 17:25:25 +0100
Message-Id: <20240723162525.1585743-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Coverity points out that in do_interrupt64() in the "to inner
privilege" codepath we set "ss = 0", but because we also set
"new_stack = 1" there, later in the function we will always override
that value of ss with "ss = 0 | dpl".

Remove the unnecessary initialization of ss, which allows us to
reduce the scope of the variable to only where it is used.  Borrow a
comment from helper_lcall_protected() that explains what "0 | dpl"
means here.

Resolves: Coverity CID 1527395
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/seg_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aac092a356b..bab552cd535 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -926,7 +926,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     target_ulong ptr;
     int type, dpl, selector, cpl, ist;
     int has_error_code, new_stack;
-    uint32_t e1, e2, e3, ss, eflags;
+    uint32_t e1, e2, e3, eflags;
     target_ulong old_eip, offset;
     bool set_rf;
     StackAccess sa;
@@ -1007,7 +1007,6 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         /* to inner privilege */
         new_stack = 1;
         sa.sp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
-        ss = 0;
     } else {
         /* to same privilege */
         if (env->eflags & VM_MASK) {
@@ -1040,7 +1039,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     env->eflags &= ~(TF_MASK | VM_MASK | RF_MASK | NT_MASK);
 
     if (new_stack) {
-        ss = 0 | dpl;
+        uint32_t ss = 0 | dpl; /* SS = NULL selector with RPL = new CPL */
         cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
     }
     env->regs[R_ESP] = sa.sp;
-- 
2.34.1


