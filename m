Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E16CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryXg-0000yD-Ta; Wed, 03 Apr 2024 07:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryXV-0000Bs-KW
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryXU-0007Qi-42
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso4988472a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142739; x=1712747539;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSwN7T4THBSw8DVoEdw6sbR9jhN10SDsiob3Jp9LpFY=;
 b=sLSOZb8Rk2/dsGDC6CxzC/J282TWhsvYM2gZ+aBMrd6Bx4xFYY3An3djVf95zLKvGF
 ex8fcypW8fqflEcZeKQE6eOujbURLpQOpZoiwDBAPJZrEpwBrizl4t+t5HYqqMysC6dZ
 pPRblRY1ktMlZt1Gs3fIHZlguXSUlHYVWSlRd+5OFMP/S5EvROvT8bFaDtfo+OZuW/AV
 N9XJ0PkMnGpUKI6rK+QTIng9v/6OkXgK370GsVU2isEAq7lkLmNjc4YTlmZfrcg+fVga
 9QUV3E89Q5uO56ccAct9sF3hWbcgAIycLVYI3397j4qDimfuDNKNyfvwBJO+Ci8js4Z5
 v1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142739; x=1712747539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSwN7T4THBSw8DVoEdw6sbR9jhN10SDsiob3Jp9LpFY=;
 b=uw1PFWRYcZaZH8YZ0jyJJejMYtTM99S3ufDu3UqnMFPPWBlY+LNyqa8Nl1+xc7BWgV
 x6PEL6XP+CsjcH1S+nx0nx81H4dO72oc9I4z+EgEXUyxnU0BZf8tczrPfX1AyCWmd5e3
 hgpQFvdNUlVF8Y5o97LUc4b2ubnIX8rHh8NY9b9J8lnJgtku4fwaYEEV/N0048d3klPf
 bSurraBeQnSSOyHYVPA7+mXBvNJMT86jk82koDj74sQ57Gg4ZvC53+MEBrWQmLuzcc5v
 CRUey/e+v0WY1aZTNhNtLk3sfQ0/A8yDrCPHVoTeD5n2OT/fe/F7pJDs7xjDH1XaHSEy
 YFbA==
X-Gm-Message-State: AOJu0YwS+y7gSyr0gC80I2gETT2b6ZxSrnsyLinRXmyuq+Yy2VblgtSC
 WN4blPji2k+V1LdfLYibKV/nB3IWtD2E5rbfa42RGkprMxvPuHw0k6Et7ECV3JQ=
X-Google-Smtp-Source: AGHT+IHNwZK6NqT9RyUnNXsKCr8xJKuGN7PIAXmN8oTsUTew1xtf/8wdCF2sZ2D4GAdfapSja9IeLw==
X-Received: by 2002:a17:90a:e7cd:b0:2a2:39ac:abf1 with SMTP id
 kb13-20020a17090ae7cd00b002a239acabf1mr7680093pjb.49.1712142738847; 
 Wed, 03 Apr 2024 04:12:18 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 d6-20020a63ed06000000b005f3c84e12c9sm3913291pgi.48.2024.04.03.04.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:12:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:08 +0900
Subject: [PATCH v9 20/20] ebpf: Add a separate target for skeleton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-20-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This generalizes the rule to generate the skeleton and allows to add
another.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/Makefile.ebpf | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/ebpf/Makefile.ebpf b/tools/ebpf/Makefile.ebpf
index 3391e7ce0898..572ca5987ae6 100755
--- a/tools/ebpf/Makefile.ebpf
+++ b/tools/ebpf/Makefile.ebpf
@@ -1,23 +1,24 @@
-OBJS = rss.bpf.o
+SKELETONS = rss.bpf.skeleton.h
 
 LLVM_STRIP ?= llvm-strip
 CLANG ?= clang
 INC_FLAGS = `$(CLANG) -print-file-name=include`
 EXTRA_CFLAGS ?= -O2 -g -target bpf
 
-all: $(OBJS)
+all: $(SKELETONS)
 
 .PHONY: clean
 
 clean:
-	rm -f $(OBJS)
-	rm -f rss.bpf.skeleton.h
+	rm -f $(SKELETONS) $(SKELETONS:%.skeleton.h=%.o)
 
-$(OBJS):  %.o:%.c
+%.o: %.c
 	$(CLANG) $(INC_FLAGS) \
                 -D__KERNEL__ -D__ASM_SYSREG_H \
                 -I../include $(LINUXINCLUDE) \
                 $(EXTRA_CFLAGS) -c $< -o $@
 	$(LLVM_STRIP) -g $@
-	bpftool gen skeleton rss.bpf.o > rss.bpf.skeleton.h
-	cp rss.bpf.skeleton.h ../../ebpf/
+
+%.skeleton.h: %.o
+	bpftool gen skeleton $< > $@
+	cp $@ ../../ebpf/

-- 
2.44.0


