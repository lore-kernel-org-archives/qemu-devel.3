Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC11CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2mk-0006kI-Jr; Mon, 17 Nov 2025 12:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mh-0006ih-ML
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mf-0006ll-4N
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so30975285e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399575; x=1764004375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zm9KzVzoJUw665v7OdINjbHAvr0+RcZ7YFxld/TN60c=;
 b=ux3heA6KGo1zlV+b0E4iJIEhVdfx2m/XGj77BX3Fqd+vOG2rZmDZ2mlMrppTlCkWfs
 p0Xu9aIIuSN1uZaX03SDg0xzhIzOo7Xj7R29Urp0mqc75UT2FG7zXnI8+maIXub3OR2n
 M8jn0sgK2+zPhlC+qkXHEztVmN6+mDtDs1llm88DWmQc3ZHGBNtJ2V//ASB2zAluYBQ1
 tne2yqcJ6ucGRh/l1vjG6sRN44+xE8btK10xX+0Y3sMER1vnFV/ifywYw4PBS3/mEMOn
 QFgjB1LT33EdxcmSl8izmwArRbf7hPYqN+LQAMP2Oq/dgjRykdiYhQCDkoOl3gjdj+Q3
 j+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399575; x=1764004375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zm9KzVzoJUw665v7OdINjbHAvr0+RcZ7YFxld/TN60c=;
 b=ApY89YM90w9+IplL5Om0qtNONGeoX02mzuwa0FoeGdkENzOIVKnPFPiFiK8XH/+1hY
 i/ws6PbZR+sr+toLlLeOiBITbIlJprz820F3dMkMnewkaLhj+BudlYQ5JbQK5ZEkXguX
 VnZQ/HAnc+I6u4Rm4MBSONeljybIzZLsfpqc8/QqwMj2X3O4zh6ZBnh+13pUvAPRWRzp
 OpoWUIkeriizT8ORNkH46FQIaXdRFGTks70D76uej28MsHzl+R3bLq9zAac5GsuYe3z/
 jqA0CY3g9UBu4L1SNxLWeg5YGh1k04e9bNdiaMFedgZBA01A/p061F224ZSQ4aOBkNSl
 FBqw==
X-Gm-Message-State: AOJu0YzWaZqsD7V8zn7ZdfxSEWEKZtUEUaOqs/uvYwjyiKG4AgMZs30d
 MaQrzecIK7DvegprAejKkklqMCLPq7FPTIHiRd/uCJsLElyW9OEp6CSBIvIbDS1DZPtSrgVM7Tp
 Lfk2SMRrdlA==
X-Gm-Gg: ASbGncumzdkud/LOPY8/6CW6uQrPsPp5vAzQipGLp5FZbj0k88S+Yvo7BIOMJlvqKZu
 Vlb8g8AmcqfVxCLKOI+cNnbv+2JPdjKia1YNcIVlk4vA+y5iD1AFZH9tWeF02cgeNUyv3CjeoEc
 3ajW90K9tS/6g1g3A36mSqINtbCEEP+J/DhapduuHwnZKv3nU4j3+K7YUn+1GgrqjoMoZmnXuda
 s+FUfH//fBu8pRhXbCsnHXeUycL9aWVLZInLMObVPjHTC93i9DcDHo87D1yyDx9ft5fehoMG0Ox
 MuPhzbNI0hn+SJcw4dZwXkuk06bo8vzeU48W+kXBWfD3sV6JKyQsrb0q5dsPX2n5ARQrlsCAIOU
 rITeW54eGbv2QJ0gGxgKP1gtriKOkuMrju70CDHwZdKgc9M95qTeGVUivRml9cCDMwUmtZzdX/X
 d2NL0Rct6J+FMA2GAjw5To0iS9HsUuebXSQ34ke0RZrDOdRhkX/5DzHQqEvP4j
X-Google-Smtp-Source: AGHT+IF2XbjhpUYcFu9uh9y4Lh1x7QCMIhGtL/wtw/n4Mef1L7k/CZCtzjj57zNK9QI/wiWxkq+OkQ==
X-Received: by 2002:a05:600c:1396:b0:477:6373:f3eb with SMTP id
 5b1f17b1804b1-4778feb53d3mr121355805e9.31.1763399575305; 
 Mon, 17 Nov 2025 09:12:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bb34b0asm115465245e9.1.2025.11.17.09.12.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:12:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v3 2/2] docs: Mention 32-bit PPC host as removed
Date: Mon, 17 Nov 2025 18:12:35 +0100
Message-ID: <20251117171236.80472-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117171236.80472-1-philmd@linaro.org>
References: <20251117171236.80472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
("tcg/ppc: Remove support for 32-bit hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a72df26dd24..422b9c98d35 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -902,6 +902,11 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
+32-bit PPC (since 10.2)
+'''''''''''''''''''''''
+
+The QEMU project no longer supports 32-bit host builds.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.51.0


