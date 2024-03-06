Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433DC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWW-0005BI-H5; Wed, 06 Mar 2024 01:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWN-00050A-FQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:58 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWK-0006Gx-Jp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:54 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5715309a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705571; x=1710310371;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DgfW3dC2BQFvXbkrpvVsfPqRuCKLeW6kZAejsXMFwME=;
 b=qKgJT6tJBenYKV/gKCcrjC65DtOu3QzamAcWWiuuvIO8yED737641YHBsMxNM/ABwQ
 rLTNkTf52zo+VIbayQJM1mBMYTo9Ga2r6YsZU8YVMSGaky+GCuOVjTbcl56zPngY3wrI
 2woUgK/mXlNO2ix8jLQf7Tgdk6ZgzThwqDSCrpGYxwTPNgRqAnXpAKBTUMJ4QUx+fKf1
 VdRQpCIB5kq83V7eDVPeXRTPkC31PO6FnW7oy9gAUzFR9OyqWOCC4EB297M4KYYSDxP+
 SBs2CTSl1+KBPEUZ1A+DgRf0TcImwatR8Q08lb1WZPHOw2YYIWyABSE841qZmhv4DeuV
 Wa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705571; x=1710310371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgfW3dC2BQFvXbkrpvVsfPqRuCKLeW6kZAejsXMFwME=;
 b=q3I0Cs3jLM0fYgFuir6N5WXNWuZqwRq3Rj0+YlVA6G6a7suOQKk0VMNC07BBqi3o0v
 iXfiAMcTLAufpe8KjB85EyiqZNYrDUCD89N3GnK5ay4ix62+BgnVJn+3lt+jh7LDFmZv
 U8J+MH4Vk6Q1UPMdYLJG1QFU2Yyn2ZGqMLPkjcw9m7aVoosrgVWDy9huRtVF7UqYLaYc
 QGXc6VMxCPN87NFXXJQKs8i+EIvNjDeQi9FkljtBboBKrGPmb/nieotEC1q/WYinEO8b
 cVyRc43b9sTdPTbTST124FelCxodX8WIVBAjstA8YCnuPAfG286iCpYnjdJHAC1bkI9h
 Pflw==
X-Gm-Message-State: AOJu0YxAAnQNeSjBqhtCXSSHbCJ0mnl7cGXhldWUSJJCnRAixthy1DUt
 1NPdueCmhy+L5kqYprjS1uw5X7eDrrEQPUMP1QKsVzN7EblCoRFQlFQq6mOwdFk=
X-Google-Smtp-Source: AGHT+IEEa7xDE0YMz/BAUAx9C4fmbda+pIxEjgTxSSJkPUNQGHgjGIj6XPoa3TKJMsk13zPEJtg8vg==
X-Received: by 2002:a17:90a:a08d:b0:29a:cc76:2346 with SMTP id
 r13-20020a17090aa08d00b0029acc762346mr12162113pjp.24.1709705570899; 
 Tue, 05 Mar 2024 22:12:50 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 m2-20020a17090a858200b002997a5eea5bsm10474861pjn.31.2024.03.05.22.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:18 +0900
Subject: [PATCH v3 12/19] contrib/elf2dmp: Ensure segment fits in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-12-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This makes elf2dmp more robust against corrupted inputs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index e01860d15b07..81295a11534a 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -88,11 +88,12 @@ void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     ps->block = g_new(struct pa_block, ps->block_nr);
 
     for (i = 0; i < phdr_nr; i++) {
-        if (phdr[i].p_type == PT_LOAD) {
+        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
             ps->block[block_i] = (struct pa_block) {
                 .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
                 .paddr = phdr[i].p_paddr,
-                .size = phdr[i].p_filesz,
+                .size = MIN(phdr[i].p_filesz,
+                            qemu_elf->size - phdr[i].p_offset),
             };
             pa_block_align(&ps->block[block_i]);
             block_i = ps->block[block_i].size ? (block_i + 1) : block_i;

-- 
2.44.0


