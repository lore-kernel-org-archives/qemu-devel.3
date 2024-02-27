Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E998C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VQ-0006VY-4F; Tue, 27 Feb 2024 13:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VO-0006UZ-EL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:42 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VM-0001Sg-S5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:42 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e4670921a4so2609175b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059719; x=1709664519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxsvOR0/a5Fiag9KhwB5MSJsMkkn1D/1jCzIg2T94l4=;
 b=J65mZqXGCpH6CmPVl5mSGPssxRy4nwkWCiLpbJr547qkUFc6CEXd+sUxbB+KyZfdd3
 dRqxp9VjFwkWajQfO/oprV8xJ6nwj25Tl8a6GKDqX62N1nVnYNC3yyhuoW0wug6+zPM4
 qj3AHck2CLX7MjLF+d+tvBrRW6864cSBT6htUANIXigzVfMU2Jik62EpIRwM/hKdm/7l
 d46jr+ywRKgiFG8NNdxv5WRLGmUgIr5Mym3it+RZPKK97R0jHCX2FmfLcIDEylseMRRB
 RbRRH6Lj11TWIwR7ImfZX8xYB67yypiEtepN5rijz8F9gbpbDKraT6uKg99VMNpageVs
 Niiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059719; x=1709664519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxsvOR0/a5Fiag9KhwB5MSJsMkkn1D/1jCzIg2T94l4=;
 b=Duot5BLtyZyvrqHbp7/+EWZmgIRPMDfTv+xOaG+Qkci71V6XSLNxJksx73TH52jeeV
 1u1P8ubxfT8oY3CHcu7sTDiynNHcjxShA8B+xJHojOMWfNUyvSs/HskuFLqV02L6Y4Ih
 p/uVwD7NqAp2oeUYEGmBU6QmdeiVVZAGB3yiy57ew50JKMmB92ikUi4eURqRXefPuP8R
 t6vI32xlvwXriaLGZyNcbEQlJucGq3rurWTg1S31gnIE/WRlMJNRKt/b6XM7P80pVWk2
 DyO1fRxBZ7jkodfTNMy8ftgIF64JH3KLehxKvKDXUWbqfgJfB+glQuCEfYnpm9jDcTDU
 sv5Q==
X-Gm-Message-State: AOJu0YxgpdgEw4NO0MLoW+/hRrS/MgoJXde76sTbABd+kzJF2LcdNYYI
 N09O+/v5peLCs1gaC1QLWdtA7DS3MrMI9wU2b1CjUv90/QMyLVzQd6j1KSFRuAbyhiBSy2HRkPT
 h
X-Google-Smtp-Source: AGHT+IG3HA4sPOG7A9GguxkXcS/EGAtKEqjqVf6uu/rYdVPHrLQRxDlRwxtHqpiBxoRyawSC1zKtqw==
X-Received: by 2002:a05:6a00:4fd5:b0:6e5:109b:959 with SMTP id
 le21-20020a056a004fd500b006e5109b0959mr8672528pfb.25.1709059719552; 
 Tue, 27 Feb 2024 10:48:39 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 02/14] linux-user/elfload: Merge init_note_info and
 fill_note_info
Date: Tue, 27 Feb 2024 08:48:21 -1000
Message-Id: <20240227184833.193836-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


