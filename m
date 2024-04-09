Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398E6C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dq-0003CM-AE; Tue, 09 Apr 2024 01:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3do-0003BL-F4
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dm-0005JL-SH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecc9f0bdaaso3638709b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639005; x=1713243805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N8gp+LNEKmu7cGCLf0zC8bqAS5Tm3qcAiz5MWMTkDck=;
 b=ZojU6IOETqP78QiVsHkLT+VKs4ymZ1qa+QnpG7DHKTJABpC0r/McU+d0uG3Y0jEmJ3
 Pq9PbO/iNpKnb4DQIeHA+zFUKYRhr470BCWZ/lfl+xY2YY02s0dRVxgk0ALJ7wHUizyC
 ZmR5NAPyzmLNK2v1xlBG1tp/6QgfeB4zHlaLeUEJsUtg9/3e7NwWr3CE3VqAW4dYEJmg
 7O36i4Rau6Hc2NvTBTsTt/xQV6IsXV2no1AW89i6LCMmk9HqUJTvYAOKBGc5WAKY+ol7
 mpVKdY9XyYGqZAMTC79AdK16xyNk1ByHXUC8NEUyTLQ9CLNHO4f4QY5DNzTn+HgBYeKH
 FXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639005; x=1713243805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8gp+LNEKmu7cGCLf0zC8bqAS5Tm3qcAiz5MWMTkDck=;
 b=kbTAgvMgdzfXrZEuCWfLaqWCd9Knq+zJpV4SuD5UqHf2NlejU9WkxqB+JSDw9MG1mM
 7MV08dkSv/j6dQqHHUXasbWMj8JE+IJ3rkJVjAlmt1l1Ks75j5cr5zVtkdnSpb1mHODl
 YWLcpsWbpRFg3FPMuXnDAuSUcGQELeaMPqHZwlSS/JfDqW7/iJTa1LidhJUcV71rSlzx
 3az34ErFbvPdfhoLr/YqLJMUcCVi5luXS6R5Z34x0qU8e43k8UVSibDSHaxU8/gQyFV+
 hBl2N8LXI077oc3377mwLdhck0ZAmBcGhtOCC3vdh1ztXuyp7qMXivi5uQIw+BWd76yB
 5C/Q==
X-Gm-Message-State: AOJu0YyvNOh7DCFpnMj46FAYnmaV6CuYqc1jlqxx/3nuoIU8mqVyOYsh
 CRNDzXeyM0HtGKrinV7PNSXecOeuNOLrvFbalin+et3bTUW8F5MABZToKfS4MAK46oAdp7gwLSR
 K
X-Google-Smtp-Source: AGHT+IG7OiR+IRLzIL+UOIN+wcSa5DA2TjmU1y9egeSHq+YOugiLw3RV5bZLBCn7Ax80uf20ANd5cg==
X-Received: by 2002:a05:6a00:c8b:b0:6ea:e2ed:497d with SMTP id
 a11-20020a056a000c8b00b006eae2ed497dmr10312574pfv.19.1712639005339; 
 Mon, 08 Apr 2024 22:03:25 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/28] linux-user/i386: Remove xfeatures from
 target_fpstate_fxsave
Date: Mon,  8 Apr 2024 19:02:50 -1000
Message-Id: <20240409050302.1523277-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This is easily computed by advancing past the structure.
At the same time, replace the magic number "64".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 547c7cc685..a4748b743d 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -66,7 +66,6 @@ struct target_fpstate_fxsave {
     uint32_t xmm_space[64];
     uint32_t hw_reserved[12];
     struct target_fpx_sw_bytes sw_reserved;
-    uint8_t xfeatures[];
 };
 #define TARGET_FXSAVE_SIZE   sizeof(struct target_fpstate_fxsave)
 QEMU_BUILD_BUG_ON(TARGET_FXSAVE_SIZE != 512);
@@ -265,7 +264,7 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         assert(!(fxsave_addr & 0x3f));
 
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
-        memset(fxsave->xfeatures, 0, 64);
+        memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
         cpu_x86_xsave(env, fxsave_addr, -1);
         __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
-- 
2.34.1


