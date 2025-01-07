Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2AAE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Ww-0000G7-5q; Tue, 07 Jan 2025 03:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wf-0000Bz-R8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:21 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wd-0002sq-V7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:21 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216634dd574so146565835ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236878; x=1736841678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJlj7vldTKPmxY18fGpfx55X2MKjq+6b15/qc0PmkKg=;
 b=gs4LFR+sdBW/UWVzrD5uM+gp+dSxNCK7/PYxIiCVNY0q94K83bfItoifvI1chfzwj4
 Pe2TZro29WE8GKbjfxv+KRlLtEWOdpHR8mRXL/MSbiUh3f1y2PzXsMKyDShcVmR6HgmC
 sx7RE9qk3CjFB/eDMkYmXH18PujXtQbTeI8ANfxh8NfOLWcGH3rmKQxlsB1/ToQ4qqec
 BPiVfg9xrfktLfqtIJxPWIasrXdeTDVVzfomHlU+2EHAEdXmjzhAvjrxuXsfDinCuyLp
 genm22FgOE4nSHFuxMEJV9j6DrlTpen26BDp6UL2x3TkkvYa9NYdOhR20fhpCLHg8u/6
 VKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236878; x=1736841678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJlj7vldTKPmxY18fGpfx55X2MKjq+6b15/qc0PmkKg=;
 b=pK8B+GI9pM32iU8wRSyhUJaxcb8XK0xKR9XabqBxCAjKeTKmD9cCl4YuPOe/OGuxa0
 QYvEU7/82gTyBALXTZzO7ZWspRG6dhJ79ZRtntxKRyGzLfs4b+1ibGNXrP69wFP1yMKb
 YJs46RGVVI/1xe84TV/5t1uLWcnWOEp7KKS0HRfm6Ku7g36pwrKIkFJQEDWyKpRDV7DY
 jCMzFDLDYA/gogJWWSCNb8fONPJ886u/80y4eGk2vCLoU/ohJw/kT/sK7ZRTF0b1MsPP
 Gqk9+HjRTSfYuKwFGM72EXAkDIn7lWKCsgBjGVLpKqob3zE9vGlX2Xq0Bra4SQbkLJ/N
 vXZw==
X-Gm-Message-State: AOJu0YyjDajPvjsAWcqLnQ9YsLtwlZVEvsLp6ekwEtmnqSy3I7PEr55v
 pSgg5IEYRFEnqLKBpgNnM1gF+ePIGOROMGmzEA/KAqUPpzbgyT7BckiqJdfs7NzuUO9qOdm3mcJ
 L
X-Gm-Gg: ASbGncszSt9l15ybic+IiKfHXF8mGdSs9/CQNIhL1R9SX19WlXIbkcmwTeeaPSOjsBQ
 HA2bGu4uJ7CoDzzPfqfDzZOXEyw5mG6SArJEcz/BRh1zbY4vkTmCPLf659KvwbDkya/ClArhm29
 rLcxEkuK8t6tmI6Dtk0W7FEsCvKh2G/bGuYZEGtfKN8LvbWqxQKI7JevE6mFwYXchYQY8142V86
 0z8LkPrJn/B35nEXUGuvIQiJyxPTTui0GL5Pyz4RkGTiNUndurgRn6xu3lHC24aFmRooxIHyj0T
 bjCVEIVzXurBJd1HQQ==
X-Google-Smtp-Source: AGHT+IFlgvPlvKlDGl13Vm31SEDk9xvKDgw1KLHmmAXnwadk7LqFV9jzOqHjG5yKfG1zOnhRrA/PIw==
X-Received: by 2002:a17:903:944:b0:215:a3e4:d251 with SMTP id
 d9443c01a7336-219e6e89b86mr925941295ad.6.1736236878634; 
 Tue, 07 Jan 2025 00:01:18 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 04/81] tcg: Copy TCGOP_TYPE in tcg_op_insert_{after, before}
Date: Mon,  6 Jan 2025 23:59:55 -0800
Message-ID: <20250107080112.1175095-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Simplify use within the optimizers by defaulting the
new opcode to the same type as the old opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6838ecdefc..f2bbff8079 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3249,6 +3249,8 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
                             TCGOpcode opc, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
+
+    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
     QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
@@ -3257,6 +3259,8 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
                            TCGOpcode opc, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
+
+    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
     QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
     return new_op;
 }
-- 
2.43.0


