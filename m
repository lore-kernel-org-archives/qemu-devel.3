Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8785C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxd-0004rO-Oy; Fri, 01 Mar 2024 18:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxY-0004qh-19
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxW-0004Cx-IR
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so10569485ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334389; x=1709939189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0IQWSjcLXc40VTcQlmdhU2o876C5B7NqB15Y8LB3+3A=;
 b=nOf4jPsqFqYBsTdgCrg4Y6c4SGVpaJ5NSqdzpNIQCugZ/oVp2OgE29WoJqQBgq7fsE
 qtrW4rSK7QLa19bPUEQTL6L2kMXBLEsR1tvgPyLn66JdfL3ShPBvRixMU7XVnZEpKUFO
 xJRYGTicvGdydqQNp/CAjUHrmdJE9fcEdkt2YEK8IeomIXzUr2HL3LzY0m0fQk+A9Doz
 6dSiIk5CPRqysCJPgbH2IbtIWN70qDToD2pOSkzOSmakltmGZErA+NGdPpWYx5Oja9wB
 eN5CBlkkp4YBhsNdXmNxOYu/A++4xY6+2P7fs3J5nEi03efAulx8dFlRqPm8qEXPThtJ
 KYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334389; x=1709939189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IQWSjcLXc40VTcQlmdhU2o876C5B7NqB15Y8LB3+3A=;
 b=pgFQ2VvvIY+U8BGWMxpT4aeBZbk95eikuEGHYpj+LGm5niGEdyK6P2w9IGFjNTH3S1
 EAHfWU4L8+AyLqUz38oO60+YdV3dMOedXmomIk4JLnmHKJE6ayp6o7vVVJvPAnL62ApY
 3nQoGH8PXb+cE5E8SLDScuRYw8bdWHz1xv92O+xXk5uk948hRHINJWq83RjdVcBZCZyF
 vz1DrrL0+67rkw8+hdL8xbRHnjKy4GCOpB8mindDWHAgiAVG0IsZuHLeZwVH7BVTcld+
 5Pt2VPp52bE53a2fUIRSSAiQKCtHt/GMuadq0dYiHngnOi/nWJ31uWqOtHFLTWkGTFe/
 GjoA==
X-Gm-Message-State: AOJu0YwzIdOtDsNE9wEACqfzeStOIM7d2ZSBl74RuBhNCS8td8HFT2sD
 DBYmEvmsP4aJ6wgByGpoFEmIWzeyHyFhnY+cTqrUUW5SRYAOTxRVA4qhZ6YO1Zdn7+p9J7R316P
 O
X-Google-Smtp-Source: AGHT+IEEw3XfmaIBx87z4X+Xs1ZMq78KUA65W6HSk+0eSyi0Qv6/hf/iLd6jkT/CITzPkW33XMt6Ew==
X-Received: by 2002:a17:903:187:b0:1dc:adb2:628c with SMTP id
 z7-20020a170903018700b001dcadb2628cmr4097679plg.34.1709334388934; 
 Fri, 01 Mar 2024 15:06:28 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/60] linux-user/elfload: Latch errno before cleanup in
 elf_core_dump
Date: Fri,  1 Mar 2024 13:05:24 -1000
Message-Id: <20240301230619.661008-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On the off-chance that one of the cleanup functions changes
errno, latch the errno that we want to return beforehand.

Flush errno to 0 upon success, rather than at the beginning.
No need to avoid negation of 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 98b82b1a49..39d9ef9acc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4634,8 +4634,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     off_t offset = 0, data_offset = 0;
     int segs = 0;
     int fd = -1;
-
-    errno = 0;
+    int ret;
 
     if (prctl(PR_GET_DUMPABLE) == 0) {
         return 0;
@@ -4755,15 +4754,14 @@ static int elf_core_dump(int signr, const CPUArchState *env)
                 goto out;
         }
     }
+    errno = 0;
 
  out:
+    ret = -errno;
     free_note_info(&info);
     vma_delete(&mm);
-    (void) close(fd);
-
-    if (errno != 0)
-        return (-errno);
-    return (0);
+    close(fd);
+    return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
 
-- 
2.34.1


