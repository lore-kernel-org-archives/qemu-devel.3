Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F75EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJH-0004nk-Az; Mon, 17 Mar 2025 14:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIm-0004Ut-2H
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0006Cs-1f
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso88731915ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236481; x=1742841281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=H9vB6z5EbsXQH5NQ61mhUXNOByRlDmN05TQo/y7BSE+wBbHTp1WFXWVNzY0U3LlYwA
 7miH5FCWuM+9uehGpbIhAtp0GOqA3859ZDVJtDLEbRfZTtxmBY40xe1TlqMvK6YHir5+
 FfiYM2rraan8swxOJ4XzqkTfQud/FQlrJ3ICbVKZ8d/9Nr9hVyjyc3f/s3Ub9cehAU8F
 IdtsrMid5K4l3ZV+oTrr0XtrdUHI8A2CtUb/Sl1p5mZ/3zSwv9FWqft35x6ivwHdaPjg
 bAjuqjmE9iLLF27037fuqDcr1y0LfPImR70ec6/FzNM3Stj4yXXyi0In0HLmwdk5+ZHX
 1ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236481; x=1742841281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=pjV1reK4MtiikwgKcKOWjLUNB1bUCBTiU5GSHZFzamlkguDKLhu6nVTetPm6UzjVf+
 fluRlzRcMee9ovvAcfhjVQD5ftJVQXipn12zdYsbre95k3J8bmC8A3nRkKrEpUx/LNPB
 +66iA6OUvoQDJm1kF6lPbBm/zPCrK9ELvsSmx4zK9aDVWBYIvMuImEU0Z2eb3pwp+oDx
 4y8UedOzjSL8gCilHUjMFvV/UmuKQwBc3M6eH6XFQKuUqohqxPAHfAssqOImj7o5YGKC
 pZ2hhXx5eaPlLeTk5fPs/mhXqDGDYhho5Li+67WPANW5Svm++9dJmSFUqDVl4p+xDscS
 IA+A==
X-Gm-Message-State: AOJu0Yxrt4jr9jAv/FZy6AlotwmhvqAwOtPFTzB7oLJjHEicvIL6+H2E
 Q2osLejPJbS2hdBG8cZuNGxkw95YYEgQiqtAjWEF1ZCIN7UFJKKQCQjV8akhKD2M99KwfHLHiii
 g
X-Gm-Gg: ASbGncuGNnMg0SguaSErT+1+iDOF0j/rH2b4E4Xvg0qLw8deu/j6lrPgCnklfORd2un
 2uJ4LCde7AhgId7qY1FjNu7bYDC5NP1VxY08wBU0o4lRNQW/PL08ucnzLbra+sloNJHbfS+/i/5
 N+cJhJeflK7c/frRA7CRJXwAOZIg3AqFRXEwkHA9qzK/8GlrNuiG1SxEK61NlGMytyO4hAKSXYs
 marH9vJxsB8DgP5ezZZ1irJ6+pCS8Bc+RYMA23Lx1R2zP4Vj6g4oVqcW0S3Vn/bYFMbpj1yI/gv
 bFERBTSkC2bz29gjintrLDhumyxS++axpWursiiyv+yT7xM8rbY4WnI=
X-Google-Smtp-Source: AGHT+IHJvFyPD498ouch6ktpEIoYmR6xx3vtpzwDFb0ar1DtZX7lkpskC+JCwilCa8dJd3A5JvQbZw==
X-Received: by 2002:a05:6a21:7895:b0:1f5:9961:c40 with SMTP id
 adf61e73a8af0-1fa43acdf8emr1048891637.8.1742236480716; 
 Mon, 17 Mar 2025 11:34:40 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 14/18] system/physmem: compilation unit is now common to
 all targets
Date: Mon, 17 Mar 2025 11:34:13 -0700
Message-Id: <20250317183417.285700-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index eec07a94513..bd82ef132e7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'globals-target.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -16,6 +15,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.39.5


