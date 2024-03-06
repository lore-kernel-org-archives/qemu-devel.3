Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E42C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkW9-0004uU-4U; Wed, 06 Mar 2024 01:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVv-0004sl-Vm
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:30 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVu-0006Es-0g
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:27 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6e4f8f140c1so544025a34.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705544; x=1710310344;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A243LVbp1AwfUXsMdD+blJLZP6SXZ8l0TiQS7QSUs3I=;
 b=0ey7GjYD8BO8VBFAWirzUhGeZBZ/g8MJ51yCQX24p7Fd927WCwnUSMY05nLb8WCQj1
 yfxPIervzMHyHMx/DDl48yCEqlMM5v+siiuVUQCZ/PeAvlxY7tolL0VLeXfcXZPCv0S1
 q1Uoyq4g0kJxYKPMs5bckO+jCGJkxIfL78aY1KjTd4X/E2RTNUQvCvckAwxt6PVtW4n4
 80NwJZuf2/hcSE2ETsUsIa+25yBhE+2HoyImig8o683m1NAq7pcAIA9IXoXVbcV/IXLB
 6HR9LQhI1xhHpVHGeX9ToQeLrG+HumfITVHpk3rmEt5vnJBiyLGMhMXa7xKsflL0w6gL
 ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705544; x=1710310344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A243LVbp1AwfUXsMdD+blJLZP6SXZ8l0TiQS7QSUs3I=;
 b=ROul20OUhvuqhcZ0sxMsTPZL9FNCkyqR4r9MVXXzMkIX42CBRU6K+BnnDjEXzqyNAn
 hJOha8vgblYKDpgFNjBdPMXdrnH5c6a88XZ0cxV5QmrPsP/GxDuKUdfbOq16KgJPvXTe
 yu7aU9qzcqYBlkq35j0HaHv6TCkrGGQoLezgcW9RjK8Q8pmdjKi4Y/olGvqe0qfcOVso
 cfxN8d6rBam0YXlZ//z2b9Af0WmPTe8nQJ7TtHbH/Lhl+xD7+HGBSK2pYYB5/yVEGggt
 EB+RqVJgur3XO95QryelTEcCE7KDt42ppM37+miPnh0ElWE3CIV7s//V8Joi5bI13Qwg
 hMKA==
X-Gm-Message-State: AOJu0YztLm3rDVvngSzspTTrgM6FuFK9SNh7/lLEEILR8VmhlRyOZhvb
 P2U3anmegbalJ0GqU7IsgsW+dBMqvln49khp0C0CRhbyNEq34MhuzfNzC88llUg=
X-Google-Smtp-Source: AGHT+IGIuNTAzeTjpTyz4eoSmNr4CNTwQROCJ7aTf8C06E27X0rBrChP7GI38YwD+YE4BxFZAKo95A==
X-Received: by 2002:a05:6830:61b:b0:6e4:b891:c9eb with SMTP id
 w27-20020a056830061b00b006e4b891c9ebmr4685323oti.30.1709705544507; 
 Tue, 05 Mar 2024 22:12:24 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 b22-20020a63cf56000000b005dc884e9f5bsm10328337pgj.38.2024.03.05.22.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:10 +0900
Subject: [PATCH v3 04/19] contrib/elf2dmp: Change pa_space_create() signature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-4-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
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

pa_space_create() used to return an integer to propagate error, but
it never fails so let it return void.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.h | 2 +-
 contrib/elf2dmp/addrspace.c | 4 +---
 contrib/elf2dmp/main.c      | 5 +----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 039c70c5b079..c868d6473873 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -33,7 +33,7 @@ struct va_space {
     struct pa_space *ps;
 };
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
 void pa_space_destroy(struct pa_space *ps);
 
 void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb);
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 6f608a517b1e..4c127c9b1ec4 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -57,7 +57,7 @@ static void pa_block_align(struct pa_block *b)
     b->paddr += low_align;
 }
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 {
     Elf64_Half phdr_nr = elf_getphdrnum(qemu_elf->map);
     Elf64_Phdr *phdr = elf64_getphdr(qemu_elf->map);
@@ -87,8 +87,6 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     }
 
     ps->block_nr = block_i;
-
-    return 0;
 }
 
 void pa_space_destroy(struct pa_space *ps)
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 86e709e6da3a..8a71e2efd281 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -543,10 +543,7 @@ int main(int argc, char *argv[])
         return 1;
     }
 
-    if (pa_space_create(&ps, &qemu_elf)) {
-        eprintf("Failed to initialize physical address space\n");
-        goto out_elf;
-    }
+    pa_space_create(&ps, &qemu_elf);
 
     state = qemu_elf.state[0];
     printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);

-- 
2.44.0


