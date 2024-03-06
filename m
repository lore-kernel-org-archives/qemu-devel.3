Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E72C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkX8-0005zO-M0; Wed, 06 Mar 2024 01:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWi-0005SU-7D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWf-0006M8-Mh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:15 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd10a37d68so27382775ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705592; x=1710310392;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vWeSXxnvukh1qTIQXUJcznaqlBnX6VJYT1GjqHDMtek=;
 b=dhDpM6IRbgxb47pI5hrmD+/qnx+FF82VqZ//GokGv1HDVFhs06Ml6qCZEhnJo1M3eJ
 vqMcuIGrrqyncJzq0VZhNIz0R91HC4y3nI7pPgFuEiOWk2xPvxZzCzBXMKpzjEuuVsDg
 8w6JKW12y5994355igUN6vTwWuTCMutB8Vi6C3ZmL6DesBh5y55yVJD8tWEF9FS+2S7P
 YWNtmth9C/QdD81R1BTaBntmC1SfL4vIMXvqmDSuaHzazSL38xUl7ZzYwbUxsiUYwCOj
 TK/7oMPeBMvS+hnawLMbcBa2JplEffaRCrYtDaHXZROiG7Xn8wJgZ+zT2dkz/h1++rTa
 /BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705592; x=1710310392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWeSXxnvukh1qTIQXUJcznaqlBnX6VJYT1GjqHDMtek=;
 b=SQLqVNnhD3KVEDs1Xj8+1TZ5/jlZ5n0pAJtCXDCTXjHzmPyIOjsh1dPA4Zuvm2dcLx
 mPfeyo4gA/zoIpffJJ+X9Glen9Dc9c0QqDhiYjA6KbFKxNxU+HrSrevVL//oMWbb3L8D
 oyUhboB41S4/tWWIpIt5aG+hi6ZERqDzyMmGeciOFvZGYebEjqdOehczVdfVY0DvPkjF
 XHpfZbSXP9GyF6Hut9hrKfd6TzqBHIVJn3Mxb44724BOgr2K7jj4o97Po7PfDX7+nbwE
 kX3q79UJJAMt62LddlsSFjEtPF57exVssrddseWZsyKyHv6wFloyWHY8Aug52fq1GHcd
 9SZQ==
X-Gm-Message-State: AOJu0YwJMsw0DSrKiRvrdp7tjQETDpC7DCmgOngRvPtewKvReHBC7HfA
 9V0lDjmvcpC3Q3fTEH4tc6nVHxIm5lsH2sDWeZfvI4OpYPVx3X/LP0Ebbnv7e+Q=
X-Google-Smtp-Source: AGHT+IEQaCP7Atw9WKvSqj7bSVsujj8hc1pUllt0aKPOEcwic7uWYrt346WbsIYi5vvH8/Un5e0AQA==
X-Received: by 2002:a17:902:d50b:b0:1dc:d773:ac with SMTP id
 b11-20020a170902d50b00b001dcd77300acmr4613895plg.7.1709705592254; 
 Tue, 05 Mar 2024 22:13:12 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 l14-20020a170902f68e00b001c407fac227sm11584615plg.41.2024.03.05.22.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:13:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:25 +0900
Subject: [PATCH v3 19/19] contrib/elf2dmp: Ensure phdrs fit in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-19-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

Callers of elf64_getphdr() and elf_getphdrnum() assume phdrs are
accessible.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/qemu_elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 8d750adf904a..c9bad6e82cf3 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -132,6 +132,7 @@ static void exit_states(QEMU_Elf *qe)
 static bool check_ehdr(QEMU_Elf *qe)
 {
     Elf64_Ehdr *ehdr = qe->map;
+    uint64_t phendoff;
 
     if (sizeof(Elf64_Ehdr) > qe->size) {
         eprintf("Invalid input dump file size\n");
@@ -173,6 +174,13 @@ static bool check_ehdr(QEMU_Elf *qe)
         return false;
     }
 
+    if (umul64_overflow(ehdr->e_phnum, sizeof(Elf64_Phdr), &phendoff) ||
+        uadd64_overflow(phendoff, ehdr->e_phoff, &phendoff) ||
+        phendoff > qe->size) {
+        eprintf("phdrs do not fit in file\n");
+        return false;
+    }
+
     return true;
 }
 

-- 
2.44.0


