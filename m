Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB1EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTdb-0005CR-BK; Fri, 06 Feb 2026 16:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTda-0005CH-GA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:14 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdY-0002Z7-MF
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so781645f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414310; x=1771019110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DayYBerXyY6CHsXBV0GAU9T40hRQ10ynIDr82ZsZLA=;
 b=olMJ68MAN1GZAzj/mvzLepOW9LIT105tSnyAqvu3lzlsPlJ81beLMnSicu/gQD6Py0
 0ux967qixeX8a3vVmb/+e6jeCvfvazDxlDM6glGGMfy+rCnSo6mHt7mjEQIsXmmBJkaW
 BcQY8NAkBG+TsU9tjla3+DoxBwtlE9ZG9A6JbrD5y62hgD01dcc43dC6W4Bimi0EpJ1w
 AOnEfLG+gHsFs6oaB/oVG30OUb1HXN4QfqeOJDRaIHy8q0Ihr2LBrhCPj/qxIo+izevt
 BJUAXF04sl1QtMy64T2PYBih1KplkMWepMsZ3YxO9cLlGfiImWApSQ7L3zucwvV+cP7E
 HcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414310; x=1771019110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2DayYBerXyY6CHsXBV0GAU9T40hRQ10ynIDr82ZsZLA=;
 b=QnrP3CbQEfjTGPMj7IWAK1QaWYIe6CRAJiXvhUCtmELHLFjvl/ispGDEYy2vg+iX8P
 kGtwNW35KXBImrbp06zMVVAlb6QmW+7FQZS+9M6uPQgdLgNm6J84vFXOem2j5mH6A2vd
 mZ8cUlHY6Q3flMVceZje/44d/dtQiPZT6qWjS5v0HUPEYSz7kbLxw/SCDHO88TPFmgqS
 vKe6lq4pfHoLf5Wqz2LUgMY485ryyQ96ccJQc8bV7ueqdKLcfIScmif0B7ObtD8F5SHS
 XZ0Y5LNibOFWQHbxZM29vDk9q4SH6rLggp8dIGMwZwN2qHW8PdNlB4YhCPcHDJjgQMU1
 Kp1g==
X-Gm-Message-State: AOJu0Yyw7q3sRN0J9P8HZrVhfnFTUsCZ/A+S3QXCB4U2U5wVXttkF2Aa
 KzXUMM1KDIhxAhWx1d4Rf9OP+l+TYbucIdsyuijKjy9QXkxg4f43FkxdItwNFsU/dlEs4cO4M/W
 KQ88d5w0=
X-Gm-Gg: AZuq6aIAeGl7woJyRIJKEkvpVHy4ga6EkXdp7X86W20yWkpN0HDinLbtKIdzi85RgTd
 R6+RNJbDEdq0RQPR1jBtGJDxVzZhrmn+8clERdZoD37/Dfvu8FeNsCp1Apm1LnRQzmREnnIfgFK
 ndqxUQsQ+oPQNR1pH8T5hUIjcYC9X20EgU4nnOlzOuy5Lo2Z3gJtdwU3vOl6koWtlJOSwN8HdJS
 806O+H/eey2k7gcZA8+MS4eQC9ew5lKHPN7ig3VpWlsWFaG6288a0/3b5HE+YHVYJuC58dghE9F
 CXCq+XEH9F3gK5vL0uX80aKEEA/Cx90/pffarzKrdcfFrJkY7FLtZZ3T5s2N95t7xFuEG2CxLup
 px4led4c3VXzBJl835Udb9KtI1P7KZjK1xn0IUf99TsPXmGOcXXc/mbDgIz+8RxwVX1n3esBwFL
 opTzw2y5Z4/hKyu0AmklwTYw6Wp9FBbnnhAndSIRBUuS9NOWz+iVMlWGEcUjiF
X-Received: by 2002:a05:6000:2307:b0:436:1965:6b21 with SMTP id
 ffacd0b85a97d-436292448f8mr6374740f8f.3.1770414310143; 
 Fri, 06 Feb 2026 13:45:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa41sm8592401f8f.23.2026.02.06.13.45.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 03/30] target/s390x: Rename get_phys_page_debug() @vaddr
 argument as @v_addr
Date: Fri,  6 Feb 2026 22:44:21 +0100
Message-ID: <20260206214448.22008-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to use the %vaddr type in s390_cpu_get_phys_page_debug()
in the next commit, rename the argument @vaddr -> @v_addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-3-philmd@linaro.org>
---
 target/s390x/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a6c89ed0af3..d0c36d4a537 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,14 +68,14 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
     return raddr;
 }
 
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
 {
     hwaddr phys_addr;
     target_ulong page;
 
-    page = vaddr & TARGET_PAGE_MASK;
+    page = v_addr & TARGET_PAGE_MASK;
     phys_addr = cpu_get_phys_page_debug(cs, page);
-    phys_addr += (vaddr & ~TARGET_PAGE_MASK);
+    phys_addr += (v_addr & ~TARGET_PAGE_MASK);
 
     return phys_addr;
 }
-- 
2.52.0


