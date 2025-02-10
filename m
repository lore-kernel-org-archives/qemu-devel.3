Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE25C021A1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW43-0008P3-RC; Mon, 10 Feb 2025 10:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2q-0007F5-Mf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2o-0004in-RH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43944c51e41so11321205e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202597; x=1739807397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yUBcHpc5OCe44EFqf9E+CLvvwsZEvaTZC3OB4U4wEFU=;
 b=iz72c136EF8LaXdB8AobzR/YcziPqCAkUkFC6xp3YebyUk8SgDgF8i6Z9iDNxLFWFu
 hDQlmevKtqegIDQBs6s82FbpL7hJCGQoz2WkKhnXWNR+HyWEkkll4d/8bvsWUb/9emqz
 bNWQ/I/R7vklZr2jY3XC5Doqi87BVkhWMJci2ZVYQAjCY+t5n5yW5LsT1Meidx/U8HBG
 F4e+06JiO/QiG1xFLJyc5LCuMW6HLWIivv/mh9GyNgm4YuThwLvmt57QEPja1mE7zK0M
 GmUx3z/frfUiLNb/5xL8SGUX0JAVzVKRPUwWtxr0s48DA79gFpPp0KTectK/nMA2bZPP
 9pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202597; x=1739807397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUBcHpc5OCe44EFqf9E+CLvvwsZEvaTZC3OB4U4wEFU=;
 b=EO0f9PGfsuHPmZqDokIeMQtTFDavBrlXFXVFWkBNWhM3fczNEYi2WihesleiuleaEp
 uRSGO/32JlSzooOxhBGbi+u6deSKCPZrhXY/YPKx3qdaMWZnEWMJXrTAbw93mMoNi+mG
 7ZcDYI1xHBZEyUthuxOACPB9UyncuhpHzAHAmFAldPlWS5MggbMTc0GRsOKvqGlvs7OA
 UIxFaqzH1gqYnC2mbsFSU67nJEzez/pdA1kNu1C1Au5szO0phE6FL9tPWd5zDhyDPhxS
 6sv2SLNvi6Uzxw2k2AuBooifYuUpIHFADZ2PoFv5ohR1+9bwWebLug7+WOHLh5Bi4K8k
 VQgA==
X-Gm-Message-State: AOJu0Yz7/FrA1qumvr11umUSPni2EtqC6YT5S+gwyMUz6UCLTDz1B4sX
 NrqzwTIWVFvnS7wXx2vORXSvT3OKpkuI1MnlNqcQu0FCRBPfm8Y6j92oCAk1LqoxT5sdrtvRaXl
 m
X-Gm-Gg: ASbGncvJl22Ut+HophVLDiV3szMCTa+fd8IYKON37z9t27wS5gmgd4Bu4TL2uBV6hK9
 U99P/pH9mPKzvZwlIb+GrQMcm4i5vrhj0+CHkLFGxsw2WS4uXmXAytFgtOdr/V32Ls38AhDve5R
 eY4HCscylZoroyYeKbxn+MbVqRefHpyndo65CLVMQ61QFhbdMFGSOHvl994snI9cpeT8dyGZjlA
 oaRkPLs4thEkfGBcsUym3R1O5YzlVdI6tFKBmtbURn1IiLllqnFs5SmLMxdQq+lmbm9yg7zIjVA
 bhBDIbgajUxNIrZ65FsH
X-Google-Smtp-Source: AGHT+IHJVZXJO0p17//VgEa/8/2BSPWYNK9HdHrqEEBPJQNNHo9Fb7wlLYkkIspMtu5ivVYixI7P6A==
X-Received: by 2002:a05:600c:1e0d:b0:439:4827:73d with SMTP id
 5b1f17b1804b1-439482709dcmr24849095e9.18.1739202597256; 
 Mon, 10 Feb 2025 07:49:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] linux-user: Do not define struct sched_attr if libc
 headers do
Date: Mon, 10 Feb 2025 15:49:42 +0000
Message-Id: <20250210154942.3634878-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Khem Raj <raj.khem@gmail.com>

glibc 2.41+ has added [1] definitions for sched_setattr and
sched_getattr functions and struct sched_attr.  Therefore, it needs
to be checked for here as well before defining sched_attr, to avoid
a compilation failure.

Define sched_attr conditionally only when SCHED_ATTR_SIZE_VER0 is
not defined.

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2799
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6ee02383daf..df5ed18062c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -360,7 +360,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
 #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
 _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
-/* sched_attr is not defined in glibc */
+/* sched_attr is not defined in glibc < 2.41 */
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
     uint32_t size;
     uint32_t sched_policy;
@@ -373,6 +374,7 @@ struct sched_attr {
     uint32_t sched_util_min;
     uint32_t sched_util_max;
 };
+#endif
 #define __NR_sys_sched_getattr __NR_sched_getattr
 _syscall4(int, sys_sched_getattr, pid_t, pid, struct sched_attr *, attr,
           unsigned int, size, unsigned int, flags);
-- 
2.34.1


