Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEACCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0w-0000r4-H1; Thu, 16 Oct 2025 08:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mz0-0005jZ-SD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mys-0000UT-T7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47109187c32so3480495e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617268; x=1761222068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AyoHyu+3x+RmN2fv1vN+8a0sulrF/dPr3KwOq/zbGuw=;
 b=pDlZNgdKBv6PWrJcpX3NK/IJTG1NnNa2PUNJUh+YK8zfEP8bCzSzkMKUcS+4vxKZJS
 6eWwtB/3Y067/9s9X83Y6M79HC5inqpi35gbXkd/0+IK7AiJf/UIcHFVYfVQfbcvCCng
 VFRP4bBna1t9V+GXcWpjx4j3SqduW4pGo6eIEqJIqLl9QMRF1nr0u4l0U02vqvxlugsI
 60FUedru0Tduscqe+qW9GLjwNIC1KDNKnw02vJChHZ7LsihnjLVKnFsxT67l32GDksrb
 ZfWgWkN/HrGVfRs0D+F8PZLy2rt04AMjMvZn+yAh73By5MSehhyOO15n7ricek51C5dj
 FBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617268; x=1761222068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyoHyu+3x+RmN2fv1vN+8a0sulrF/dPr3KwOq/zbGuw=;
 b=b3enjhE3EjBkUniOTic4prTrkyFSIkSIVkX7LpEXj+XXnZQBOVWWy8fcO6Oe2icPG7
 gygYbWIzi4oiGfFcAQ92/NQ4OCms5hB++6oxDHb73MsPsWETjKLlg2nDEMl23UkReUgs
 ejSTSwg/cVQ2dYYabEtsZ3VMziQbB9VoOlB83tvbIyEYvqT0Ubxy+l2oSQWyR2RcpZ+7
 2JiV3kt+50qOcBYXQnP0OLm50i0hu46b5sTUeK2G7/JS9PZqTwlVZyB3oWI0k62ju9VE
 kju1vaabBfzyvvLxRXiUkT16zVt7ouHR3ag2bjxeoXVNGv1qtt0bBrwWeujjmciKJ6dS
 GA0A==
X-Gm-Message-State: AOJu0YwBKzygm6fTf6GFIvqQDguoWAxFavZFAYtb0QXAXcbK+cMx1xnS
 WvEBzFK2jt8N05TYqX3jMjC4lE/9+Aig4j4UWmWZ8URACMDMNefanzELfdofbY4dBH7OhZ6KxGP
 qIdrk9Dg=
X-Gm-Gg: ASbGncvB68KFs9kSzs2EGd35aHhJ6dLntXL+9WUiQZ6hVIfKPrjgyYPJOoCU+bEBC0R
 X1LWjil7RXaIHGI498pq0ZcTThfMCQQ+EbPdcZEY5noL/w0PgdmSAUbt/QfRSSjSUOFvUx7maGf
 Ttsx0b3o8n2HWbTN2AjolQnRqMsLcGh7CuWdILR4yIw8Zv6A8KlebxolZKnjJeeO2ayIHLpjDC6
 6oDR0xIu8PJQHKy6J/5xGHgdnMOLBcJh9EVbXgmr7gXeqHnOsCnZXYsAq6yKVSNGRUudSvlGEjg
 eNho0iZsZjfj+sLl9WF5JMqg9eJKk591HZwo737pcYVz3zbpTiVpZVR2sf8ffs2lLTPBpQEFrf1
 CoxSgWWJM0ySAqedes/dA35tst7N8GKYmAnafI4y8MeW2ND1SllYSh/C/Bp55uVxXf/mWgH35RO
 Qt7xjCMjcgz+8Gg28Xjw1egbwnD8YiUDE+pDIHwLv/ZokPzi44V37yyA==
X-Google-Smtp-Source: AGHT+IEjG4MELIVv4VdYJGDaBhOHs9TyAe+s5+Ua8RJgDY530EP8rv0JnFuCrYn1lzDonAuwtQfL0A==
X-Received: by 2002:a05:6000:4313:b0:3e0:c28a:abbb with SMTP id
 ffacd0b85a97d-42666ac39a2mr20831887f8f.13.1760617268598; 
 Thu, 16 Oct 2025 05:21:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cc0esm34730076f8f.6.2025.10.16.05.21.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:21:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 72/75] target/xtensa: Remove target_ulong use in
 xtensa_tr_translate_insn()
Date: Thu, 16 Oct 2025 14:15:28 +0200
Message-ID: <20251016121532.14042-73-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
for virtual addresses") the DisasContextBase::pc_first field is a
vaddr type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008051529.86378-2-philmd@linaro.org>
---
 target/xtensa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 34ae2f4e162..bb8d2ed86cf 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1166,7 +1166,7 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUXtensaState *env = cpu_env(cpu);
-    target_ulong page_start;
+    vaddr page_start;
 
     /* These two conditions only apply to the first insn in the TB,
        but this is the first TranslateOps hook that allows exiting.  */
-- 
2.51.0


