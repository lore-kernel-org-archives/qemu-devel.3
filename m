Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3741C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZubQ-0008K1-AT; Thu, 10 Jul 2025 12:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZuNM-0007UF-Fe
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:44:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZuNK-0001Qg-K6
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:44:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453643020bdso9430195e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165837; x=1752770637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Db41WKKXa5CdV/eG95AEOzhzbaLo514xBnU6yI/kY2k=;
 b=MXCCuBJC+x1nkOFKTyb7bK7iwa10u+ygZBtadZcLkUcJOWHUDIkV1yFBtiQSzW6rPp
 4Si7+11wOIhPJe4Myv0RrwiP4bD4jnHk3qwIJ5/xDXXsCxl5oBNWsr1iA4gMHFs/+7jI
 99SckPqpsYGixxtzRpsfvOC13XMPMFsyID7jA817zw5i+BCs0oR2FX1c5I884rWzkib2
 hMTBLSAOEZ0VtsdNyBZ3+v2byh8iZfe9ri+cAyAjUgkgpk80f+bLvt2E2w0F8vn/RPUX
 4ywku5kvmVZ7NqRb3AcEXrKBj8Pb5beU6+eEmdoJG9QgTtqAqkm2scU0thUSyBpZhCmL
 TTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165837; x=1752770637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Db41WKKXa5CdV/eG95AEOzhzbaLo514xBnU6yI/kY2k=;
 b=KAuOn37n/Kh/1Ojir+YPmoq3kaH9t6IT+YHlOl1a+PBPnRFUYzo/5WbRs3LNlU1+/5
 ObUNlgLiIzSJzbBO9rP/Yw5xpXpCAQxWd8SScsULcE9KA/bGKbs3TSLRGm4a4wMruQYh
 tH+Z939tYyOa4NcEzhrl1Jqu5Cla4PkAYer+kve3wVa528aumpPOnnTIRWWGUGzP6Enq
 EgwwtwHsmi0D2p3FRPt0ZEtkZkINBnEhPwCNhlTkt/sZifcjo/Y0cW8TGo8YgvdP+5zs
 QhtwjNxT5RVH+xTgjnWt+wrnXH9v5JmgwD7dgE1hDJkXQ9SslwWrpOsYa6O6+t4oP3/8
 xM5Q==
X-Gm-Message-State: AOJu0YwwziCvYal1+/i/Iuk+0C3J3lWe0wR9ALd+pd7weskh4t2S2gim
 8jLs3FUfN/Qx9ml/9pHWUsigWtgIivlKeDcOEhHrzKTphmFMlq9oYoSB1yRe/cSzuffsIFXLtfh
 H78wQ
X-Gm-Gg: ASbGncvZyrZTnycrjz67KPL28sMqj1F99vqYt8kaDAhgRWcdty8F25tGDsb4ZrlmKV3
 R6wyk2Wo9xP19w/TinodydDcRLOSc6xKPzhwfeo7TlmjCFvc/2ow/Exy0n3+Eupy8HVFDJlLETB
 1D3uH2EEWq4tHOfkkb+dTMzR29y7W3aVUcV1j1h/6EyqKJ8K0RmGZOMyPlD8LUSz1RdRwISWyMm
 P9ResOegVf6NA7MnRVp/MJkwXpyA9YKPpVlO9hMfn61Ou0EfAJLwKRDwOfVCceKs7Q2yWlYsdn+
 uyq4eOTRIboXEyGXj8NGczwbtCmbMBRdgwNJpj0WmXSM0YB4O2vmRyhuAv3/UFBbWnkz
X-Google-Smtp-Source: AGHT+IF9kjEa0IRSFHuKoNWxTyt+LTYNsOdTy1d9VSPCuR2w1M4b7RvsIaN3Fa9YJdavJKQ+aQnu0g==
X-Received: by 2002:a05:600c:1e26:b0:453:23fe:ca86 with SMTP id
 5b1f17b1804b1-454d530eb0dmr74979935e9.4.1752165836901; 
 Thu, 10 Jul 2025 09:43:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd55b068sm24259035e9.38.2025.07.10.09.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:43:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Check for EFAULT failure in nanosleep
Date: Thu, 10 Jul 2025 17:43:54 +0100
Message-ID: <20250710164355.1296648-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

target_to_host_timespec() returns an error if the memory the guest
passed us isn't actually readable.  We check for this everywhere
except the callsite in the TARGET_NR_nanosleep case, so this mistake
was caught by a Coverity heuristic.

Add the missing error checks to the calls that convert between the
host and target timespec structs.

Coverity: CID 1507104
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested via the LTP nanosleep tests, but they don't actually exercise
the EFAULT codepaths...

 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597c..c600d5ccc0e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11630,10 +11630,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
-            target_to_host_timespec(&req, arg1);
+            if (target_to_host_timespec(&req, arg1)) {
+                return -TARGET_EFAULT;
+            }
             ret = get_errno(safe_nanosleep(&req, &rem));
             if (is_error(ret) && arg2) {
-                host_to_target_timespec(arg2, &rem);
+                if (host_to_target_timespec(arg2, &rem)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.43.0


