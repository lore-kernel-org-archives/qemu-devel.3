Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5198CC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA0-0005JR-94; Fri, 18 Sep 2026 00:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9w-0005IR-Ig
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:12 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9v-000490-3p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:12 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso210712a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705510; x=1790310310;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nLDE8rSQgGkGSmO1rhlXeHCgMm2I4kYbhowtxMdHM6M=;
 b=GktThzgPLhc/kh1sVrOqFEO1rBYvD0OSdkPtoN35apyVoqKsowXtIrMhJ+KyAv3fr3
 fAhvSiQs3W0sXjvZPiJ281SZaIEqdofG0d8EMA+3GShwxh+kh00xce6PU62OWhzXizS1
 pYpES8QaboJM1NlysjOJE/MYo6hPf/OvBz7qHK58gZ6KyuTYzZj4WefuMCh0fZw+607O
 Yxo4KPWX7M2CLWNbnUELDfZrckayrNKLVUwYRIykITZRvycSdyOMd2AYUQ6WJTKj1kHs
 5O/qWOmKrSGtqoNXDAdoltiMUTCZBhPzsLjMfF9ifveWpMBKF2vAiayxlWJbkTjrZFY6
 3s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705510; x=1790310310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nLDE8rSQgGkGSmO1rhlXeHCgMm2I4kYbhowtxMdHM6M=;
 b=VWO7KMwiU/wJD2ci8sHqtd7oeNZReNbIK4H5gpCtALdydEW9cUBMgXGB6a/irAsTyI
 FFRtwqc7NBzhq7R2Ci2IHhrQJUrFXkcMrlyHaPgr72gEFDgYEyafFHkdWW506qKP26Pe
 GoVZnl2gy+ERPDsUJimWKBfj2pTgOCwVV/uCIRNESflyRCIL/wGICwLQYp1BUGTM/kA+
 jc2pnnnpVZmCiC6wg6owpssgTlHFA5EKVko4B4vGiR/MSP9q+ppeTQQ0NnzEB2mjCcCb
 EaOc5i6L1vkYwacrY2aBaLS4r5aF+aG7HJDTxO4HkjZNTsX9mQONgNtQoaU0DwxHlegg
 mqGA==
X-Gm-Message-State: AFuF++mJxSDrYK95aIBiWQ2VWXxqyMyZ6duh7pfv5qe+ZWQOjRDL1vKD
 eYIvuyPDTMF1DBgpjnwwX78DUuP0aCUXnvRb7+1lHGd6dMXNagB6q183MG9xvZbeFR2jW4opm1P
 NUYhI4SU=
X-Gm-Gg: AYBFou0A3HNk5vZ7laJhko37t7PbtTebsILd3+RHq+26vIpBvm4BRoSyjbWFLNBuIIv
 ndEk45IoyjHSElEIGfcJe3tknhWkjmIkyvFskYjYU9aeSXDXjrWcE4DZkQ47iHKBi1To+Q9CXja
 Qq9KDAWtA9KI2QQnLBf0ghfHAH4r0eqdyQDtJzb9taLqoMIBuIgBJvctdO747QJNEwaj5Pk5pwH
 loFl6KebkvmZueVmqQG5ZtgSJhRD0j+hFH6qlDU1zbF4pD7liPAOimHAhLQJ51ytXN9zJHhIqOZ
 9jneVqZcecSy0/NvsrwJ2ScWQCbcoGxZm/P9HTYj0V+2EZ7OnPqwFU/jgGuhCEMf5h01BnMM689
 Htp8GJyPsBwGl1n7+9tQB5TljVnNyW4HFhsbROejLNXTgnIbGwFze9APR34ntAaD5j5Qljc4p/2
 EzgyLx4LgWNej121MLj9f9Ymhc0UaEaKAE/6x7HU0XmDTZzV0dH/s3bkUYgQ==
X-Received: by 2002:a05:6830:3106:b0:804:bb22:6d42 with SMTP id
 46e09a7af769-80de27def06mr1572116a34.17.1789705510071; 
 Thu, 17 Sep 2026 21:25:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/41] bsd-user: Fix copy direciton in preadv
Date: Thu, 17 Sep 2026 22:23:44 -0600
Message-ID: <20260918042422.38713-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

As written, we copy in the vector and data then don't copy it out, when
instead. Instead, we should copy the data out. pread and read are
already correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index dec59bd80b..7ef9470c4e 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -113,7 +113,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
-    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 1);
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
 
     if (vec != NULL) {
         if (regpairs_aligned(env) != 0) {
@@ -121,7 +121,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
             arg5 = arg6;
         }
         ret = get_errno(safe_preadv(arg1, vec, arg3, target_arg64(arg4, arg5)));
-        unlock_iovec(vec, arg2, arg3, 0);
+        unlock_iovec(vec, arg2, arg3, 1);
     } else {
         ret = -host_to_target_errno(errno);
     }
-- 
2.55.0


