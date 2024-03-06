Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03044C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkXB-0006Tq-LJ; Wed, 06 Mar 2024 01:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWL-000504-IV
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:58 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWH-0006Ge-HL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:52 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd3bdb6e9eso1509945ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705567; x=1710310367;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UXGMflu8bENqYfrFajkcEbsDHg6+XTRMDkWLE7IjkMY=;
 b=IOHVMYsQgiKZiwALQqFHSxodbwSC3lx0qIyM6UlUtpbpV7FciI0Xi2rq+6mkN8VIHU
 5XJSn6SeEPpKK/4r2WhbQEcixaVZTno+Toj70vek/lUndqEHK+e48h+sfsJOaenMmAWx
 eukvs4v5xDW8nEw+QSZQSppHFDE8dS9QII/xYWlLA2v87nPHw2jyg7kHuANplVQn2BDP
 lADJVVbS/wWlKD7gjQg+SsPFxnWH5mFj5hSZAPX3l90Y8v9wvSzYlYZo4kRkFUsMpCf9
 yCMM93Wa5xVB2kMDKQr7lb5BrRG0SRTlonV1iUd+ZyvNSGCxsz5jwrkw8iI+qUcLa9KT
 BnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705567; x=1710310367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXGMflu8bENqYfrFajkcEbsDHg6+XTRMDkWLE7IjkMY=;
 b=lA8/nsqkS9cwd9rLKuqlFZn+PT7lDXBXjGTGVrBMt6AOvnLvAAPfVeK2waK6nEYaVW
 K1Tiv6urCC5y7y25C2hyvYM+WOgZDPElehq2SwZFh41hs9PPihP3/DAkragV2pnptyAc
 xaf5tWZJmvOBnGz0YTA+mMf1Z/xh7GcfZmrTPr/uq/ROGc0MGEwjQGNWxKrMPjqH+xZW
 ofbsbZIU7S6TgU8ST9LnsUOW2QHiAEdbK6rscs74cneUwdURoNb3MKZuift28yqRUZPl
 Ifbg3sCoAA1vbork9xssOWMIAvvkKALZ4sU1d4g7xZXCPqJLEELByV1p5XmfqPLBAo0e
 hm/g==
X-Gm-Message-State: AOJu0Yw5/xXTSn3wWdRJQsEvnx2IK2RMvXvARaniQsLosj7qsBxxhTsd
 8ZGFsIeQsKUTU4mAMnNWtU6gaosuko9+glZZVVNerIJl5luqaqCnCKVXctSHfyE=
X-Google-Smtp-Source: AGHT+IEYL06qoCc7ep+BEc0qsCwIIki6YIvA0IDb9HSk323OaCuo5uWrxzluE616VWB+Cq872lnpww==
X-Received: by 2002:a17:902:e74b:b0:1da:22d9:e7fd with SMTP id
 p11-20020a170902e74b00b001da22d9e7fdmr4703715plf.20.1709705567491; 
 Tue, 05 Mar 2024 22:12:47 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 kv14-20020a17090328ce00b001dcad9cbf8bsm11652154plb.239.2024.03.05.22.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:17 +0900
Subject: [PATCH v3 11/19] contrib/elf2dmp: Always destroy PA space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-11-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

Destroy PA space even if paging base couldn't be found, fixing memory
leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index c290781feb18..51e1abe26a17 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -549,7 +549,7 @@ int main(int argc, char *argv[])
     va_space_create(&vs, &ps, state->cr[3]);
     if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
-        goto out_elf;
+        goto out_ps;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
@@ -634,7 +634,6 @@ out_pdb_file:
     unlink(PDB_NAME);
 out_ps:
     pa_space_destroy(&ps);
-out_elf:
     QEMU_Elf_exit(&qemu_elf);
 
     return err;

-- 
2.44.0


