Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9714C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxY-0004qo-Te; Fri, 01 Mar 2024 18:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxU-0004pm-9P
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:29 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxS-0004CK-Se
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:28 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dcad814986so23696845ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334385; x=1709939185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1WCKXawMTZMOrVqL/DhlUtKi+hfbHIEOTuyKivWJBk=;
 b=q5IUtvV72ltONvA3wjmO4J7+0yBxTs4zRFqXZl4BD/GD3U9BYvy868l+ZkjzERNZVX
 3Tn14kD9Vi+5M1onqgkdTEmX0b7/7xicBlQRu7dw9BLgj4gMmpp5t2U/rnO+3z5zyKko
 pYj4aDYnmyFG5lfyh88P/kzFVmSeqjYncCFLkNHrVac6B5MBykgOwr0071Gp3QWBYFMC
 aG6wlGO9kSWmibvrseAOD7i30yV3QaZY0Fb6UWNDPlBkAnVkb8sBAEq7uDTxjVmAbO/S
 IJFMSkGqJS+JNq7p/XkYmncmfddaYzwXFFXbYFVAT3zYRduNiQ/clIUrC7smyEWHa8bJ
 oPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334385; x=1709939185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1WCKXawMTZMOrVqL/DhlUtKi+hfbHIEOTuyKivWJBk=;
 b=UQQoSRWgEw/KWyihMfH4nVvVZfZ+HpR6TQyWFubYJQJznqvfOMjJ2VWOlwxLDnbdlB
 USiwigGG5NBtGBgZdAoeW6Gec+uwNMqfTu2BubnPl9N4vV613ij9EyVDlxuzAWT5FQXn
 R0R8X3nrOilLDYuMveUR5QOcf7XkevUp6EF96+ixKDeW+OE9neQF8Gtg3NtK+pUENaUW
 M2yzfUuBbZbUY4AF76LAsoCc7OwcnxJMyEF26Hf+3Gq+ppRgoGpikwMsmX/V5+aRfNgh
 Xa5HFeZL/Od0cmbZdN90JlT14SSxjWVaUr3HX4HLOZnnzG26kf5ZlAZjpPExQUbOUoH7
 6ryA==
X-Gm-Message-State: AOJu0YyZ6as8eJzixMQY1uFWww6S1kzVsjsF3a+Dk9GKcYoWpGSwNfcn
 WfyZ22aeoFFGUxYEwE/cI8usZYFQQQsRIhjS7zqd6pDZAx7l2beWEPzSHUCBVkew9LrVwMh4/pR
 k
X-Google-Smtp-Source: AGHT+IGa43dslZ5wNDgRMgJScgVk/chbWoY+U0rRfdvNugLCnbt8xz5I+iNhAb+kpZzG15JPHwwEtA==
X-Received: by 2002:a17:902:d58b:b0:1dc:b6bf:fae8 with SMTP id
 k11-20020a170902d58b00b001dcb6bffae8mr4337694plh.59.1709334385266; 
 Fri, 01 Mar 2024 15:06:25 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/60] linux-user/elfload: Merge init_note_info and
 fill_note_info
Date: Fri,  1 Mar 2024 13:05:21 -1000
Message-Id: <20240301230619.661008-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fb47fe39c9..7b3a2c20f2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4514,16 +4514,6 @@ static void fill_thread_info(struct elf_note_info *info, const CPUArchState *env
     info->notes_size += note_size(&ets->notes[0]);
 }
 
-static void init_note_info(struct elf_note_info *info)
-{
-    /* Initialize the elf_note_info structure so that it is at
-     * least safe to call free_note_info() on it. Must be
-     * called before calling fill_note_info().
-     */
-    memset(info, 0, sizeof (*info));
-    QTAILQ_INIT(&info->thread_list);
-}
-
 static int fill_note_info(struct elf_note_info *info,
                           long signr, const CPUArchState *env)
 {
@@ -4532,6 +4522,9 @@ static int fill_note_info(struct elf_note_info *info,
     TaskState *ts = (TaskState *)cpu->opaque;
     int i;
 
+    memset(info, 0, sizeof (*info));
+    QTAILQ_INIT(&info->thread_list);
+
     info->notes = g_new0(struct memelfnote, NUMNOTES);
     if (info->notes == NULL)
         return (-ENOMEM);
@@ -4665,8 +4658,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     int segs = 0;
     int fd = -1;
 
-    init_note_info(&info);
-
     errno = 0;
 
     if (prctl(PR_GET_DUMPABLE) == 0) {
-- 
2.34.1


