Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0020C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFus-0006z1-Kj; Thu, 22 Feb 2024 15:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuq-0006yM-Kr
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFup-0002by-3n
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso353865ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634614; x=1709239414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNAOuzYKunseGhjt30zEM/eN7uq1Wl50v8pWc8K9LWs=;
 b=PfLkPevn825ugMpAo702PT0p+t/DiRPWWi5tRdvAsEwz8Kyr2X1SfG7nG9Mr3zGzzR
 ksxL2VORDPbAq4d4gt5uM/on0aGA0V2hSNKzRrVBzTaR5ZGS+8mVfY4qAFT4LIripzZT
 3+td0U6EcgGp9US50orQeQcRJrahbgUF+E5R3yzBSVdXRRTD3O/qJDCDJWAIlw5RXawZ
 Xc3Pcl9gXRTNGTKUw19mjOxQLMoIsayFmpEOoRF+a6ZLIbkpSM26prwHKlcB9d87YdKd
 eK5qCT41wcPCS85J5XFgPoybMgBOgYXL3IH49l9BUMyw/7dZ1fJ4Xr51wJBPdexM+MG1
 kiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634614; x=1709239414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNAOuzYKunseGhjt30zEM/eN7uq1Wl50v8pWc8K9LWs=;
 b=kp6eBu23YiEqk/wrZ9kZuC6gxDbC70/Fc7TNv1Hh7eKoZjtx4urq7hV94OcLDUl+VP
 Ed9PBq8VXvb/4s//gaMSoEFyBteuuD1Y6fJoKf/mC0MBZOmOtv7P+QBY7hHC85iznTe6
 ycxy+y8szdI5rod11MRExtv7SSNxcUh2QlskouUgkSG1K3vtBx9ji7XtX6I9CMG/Hg0g
 wpGSUpNUW2IYoz/KODqukVJ5oLY0JAi4tRmKPb4HpbWcKejbJJANabSc7mX/V1MZPQjg
 0imgJBOxwD0doWQdxi2qJbY2mhlSMdXUN0IB0t2QwGQz3qK568HluiW8836muIbRTRZn
 gW0A==
X-Gm-Message-State: AOJu0YyFoVoj9THP83ZTYj/iseqGIV+K1tAZwlD2/svCqPqUwOF0MH6B
 SWCm91py0O7AeExUdQoyAlErWaZ7gpHY28IYRvC8gf7IO9bldkkZrCJ0jmQPrd0WFFEoTlE7KQP
 R
X-Google-Smtp-Source: AGHT+IF5q5UPALYgHWNKN4dHd3H6eNGItd9ca+N9As9VGDOe/3/wGV0sI09yoZ0wEYWIaBD1vQm1Tg==
X-Received: by 2002:a17:902:7d84:b0:1d9:7095:7e3c with SMTP id
 a4-20020a1709027d8400b001d970957e3cmr19202644plm.57.1708634613748; 
 Thu, 22 Feb 2024 12:43:33 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 05/39] linux-user: Adjust SVr4 NULL page mapping
Date: Thu, 22 Feb 2024 10:42:49 -1000
Message-Id: <20240222204323.268539-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8eef893d0..e918a13748 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3912,8 +3912,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


