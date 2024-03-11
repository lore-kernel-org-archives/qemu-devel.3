Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67203C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9K-0006aJ-Ku; Mon, 11 Mar 2024 15:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0003OD-4h
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4r-0000M8-4D
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4132600824bso9416725e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184365; x=1710789165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uGkqi61JFcx0yploTSJU0yOV4s33JLq/DllCnbokV38=;
 b=nPi0jeCD+2iLMXV2964VV52M9+/H6ck+LZ/sDDOqy+yvLnhV5a2pw318A2cdszWJ6E
 5QcrIcKTm2Grq/pItCQLdiVlEVODU7i19kugEiX5DrEt6+U80lLNG7grFMUl8KhGagqt
 46dWu8rhssjH4+Zuo8MDtNkz0k1scIvCM6ovbP3v71hh/dFzHx5nPYFLSp33coXqxwuw
 gwFRaUun6sMq4jYKQSKhyeE3TZBiAowEWBSY3YaafbMLvxmmijzTuBbm7m+g9gBGiyoo
 BYYqMo1YvFnqwz3utm1Spd/yF0BIS4/rTGwUBvBOJgxdJDYZZoblkSFaiBOw3oSUn16/
 e37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184365; x=1710789165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGkqi61JFcx0yploTSJU0yOV4s33JLq/DllCnbokV38=;
 b=pBnMf0RUfzFLo4I+KU/AjdvajFdCrJ6pPUcksznB7jrUNHJVi/MFQrlZ984GK4a1Wj
 BqwHm63377yBemT3XsaQmsuqziOsWZlZeZgolN31dLyQBO6UzzEQa2uFGQsC32tgBK9q
 PiFnNyXZfVt+peIU0yvWTFVyLCLharxFOIHLe2aBCP23eKmxNck/t8ys7osTIxEFe4Ep
 MuCvRAL2O9M0kRKZCVkewCReqGFHk2yQJ09JMozR5Lwy0yo2u3p986S4CdRvKPTZVba9
 UCA/eeiV/A6Kz+u3KVFkfa6o02nHvjNvJh0M723Q8x+YCbigREdXMGg2huYHdD0ZbN0M
 2JkQ==
X-Gm-Message-State: AOJu0YzHdqPpuNcVTGzAkBwDMn7suAvRzhlBMTJCkyEvnwhFmCo2OHHD
 ZVnNPSC2OhSkj/YqtBQEn3MC3ZRQ0kXiq/qGd2rQSEWL73xKluWZ9MimYX5nuhzC7lkTqrb+UGS
 Q
X-Google-Smtp-Source: AGHT+IFr3zRXDpWXZSHenrwNIuUH04UXs+Dwcb/Vop12VVBEb+MFxjtkbETUJHujxUBc3TZpPn3ZRg==
X-Received: by 2002:a05:600c:3b07:b0:413:27d0:45f4 with SMTP id
 m7-20020a05600c3b0700b0041327d045f4mr1039924wms.6.1710184365205; 
 Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] contrib/elf2dmp: Change pa_space_create() signature
Date: Mon, 11 Mar 2024 19:12:26 +0000
Message-Id: <20240311191241.4177990-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pa_space_create() used to return an integer to propagate error, but
it never fails so let it return void.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240307-elf2dmp-v4-4-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.h | 2 +-
 contrib/elf2dmp/addrspace.c | 4 +---
 contrib/elf2dmp/main.c      | 5 +----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 039c70c5b07..c868d647387 100644
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
index 6f608a517b1..4c127c9b1ec 100644
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
index 86e709e6da3..8a71e2efd28 100644
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
2.34.1


