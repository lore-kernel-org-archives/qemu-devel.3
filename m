Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364AEC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8V-0002OH-FB; Mon, 21 Sep 2026 06:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8U-0002NC-E6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:34 -0400
Received: from mail-oi2-x27.google.com ([2607:f8b0:4864:32::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8T-0002ex-1q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:34 -0400
Received: by mail-oi2-x27.google.com with SMTP id
 46e09a7af769-8055dcba0a5so414700a34.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986032; x=1790590832;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/aafcq/csDJa1UZaYBIFoIJSQMYPsOz1xJbfqG7LhTg=;
 b=AsJBV4EIwG7R67XlkAfcPiQZeJ4TiIK1cIEahT47ipDmO/k71afxmBHqqq1mq1yU2/
 0qmekicGKyQJHIBe/d5/M7/si+2Korx4gnAwimrfh+UOrlKbr4Zy+bXgzE0qMT+O3sY9
 BiJOADzBx2BHBL4s2oQk2ZfUacAdTurOR37ovDTbRi4woKf3RKKzlomYWvs2tvMjTKJo
 4CO9IpRYXOH2allPWIMpZmFa2PWZBD/S6BzYSaQXjuFwVEFH9cKxvX5NvhXLyQauFS3v
 XRCvEY44DilY2WzSi5M2O9dx3TwKyUvePXeohqoMuKpkmEQkJgTkxTCbenLv8Zz8v9y0
 4TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986032; x=1790590832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/aafcq/csDJa1UZaYBIFoIJSQMYPsOz1xJbfqG7LhTg=;
 b=dnoI8g9vjYTTolcfG0AjEI3s/2lcyD5olqSQHtBbWmhHJDtimj8usfl5otWDaq9U6o
 Yv35VzQ9Lcrnq5p9m13EcfIiTNd4mt9/+FVDAHUfc0B8umqqQA5unGWDxZ61HRwjmYWH
 I45KBqa9Hott8oB9v3KzTe5QAULWADX3z7GD4Rhmip5N20yoBAa/ApkYtIP6iJJIKfh1
 Z5Jxj4DNxk+zmnIcCw6rTHxA00UbAGEOaBCHkJCUmF2NbohwQ3ToueB+XUsLY767zo/X
 7jpku132udFGvPyLptmhh3ZvPaH8jOcJ6yVFYPnbuaGlwIBlc29cp6TtnD07Z2eGBrPc
 EdtQ==
X-Gm-Message-State: AFuF++mUBhPz9eza+FcUxrTMUhbphoCrPMtnRJp25ThAWS7k8/nVxApG
 VKzvxJXSBhNuM66pXRNPG75ia5u28QF7jvnDsgk8s9YxycZptlq4HrtcLZSWb3DyfkJByGPuKpJ
 9kZbhmpE=
X-Gm-Gg: AYBFou1YX9jm8Yg2zF9jZXoxakZaTBJImIY2UDG4QZkHxMEbAzHymcAqODTUlaI7mF/
 YguVlSgUrccc8vfWBWeopVeLJxmNwm/K6KJNLzrenMfJsYaEBxFiz8ByErElKWPCPvtSUAmEu35
 FO9mD5P41fSngbN39AIa5sfz0s3t6bHmi6mF8bXWMhVHfFjC90AzB3FIJItmk+Y06pVCJFPzcd6
 UfoLArkRYiSSKs0kBgMPgOV4OOJ48df3z2W1VwQM3Igxf0IRByHzzzBj8cImPGAJKu5fmWbGxwQ
 UA0Ul3Dwv6PJm34iZiy2AI6PLhp7JMfetKJQYISbeXEVdxH9PqcEjlyQYOAEWl6nmT7UZbK9OUW
 GDyJ9RUHCICric6jDADU2FdmSPE7N+yLcs2+0jfF8gEIC1pjiVmY+AHrc82eQaOA+FQ8ooAK2Wc
 gTKOd5aSDfNBdK/sm5y7P2X5c6OzKnrW6Ds4gWMooIdtnDvXDwbvdFtHMynw==
X-Received: by 2002:a05:6830:25d4:b0:804:e0e8:1a86 with SMTP id
 46e09a7af769-80ddea721ccmr11549002a34.1.1789986031828; 
 Mon, 21 Sep 2026 03:20:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:44 -0600
Subject: [PATCH v2 02/11] bsd-user: Drop support for FreeBSD 12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-2-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lwQPYjfcLlLGXO1WOwNb4B+G4uN+9tStASCCSyWsQTs=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTdU3jlecnLDwTkqVSQDRKRsnXSr+ZbOHsG3
 ufy4AM7K8OJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCtIhAAu8eNdGXBfCdZ3lqfYKsxGvb+SeuF2FJ
 fJrf8uQfCdzNw6cUFTD+0PC4ubhMvs2O6oyXMtFvDe0DmAeOogAdLnbbsfCoKz+BmXvY/slr2Da
 DFk/oBBgJNgaRkBdxoK3Pqr2aHSZ8bVpj4fgVPCHVn+1vLCZ9247RVZdT5ArVfsR66F/5fL15d1
 ChLwt8S6vYsR9HE0UYuO/Uq0LZIlzKTMF7Ox7EAq55gZKHbZBi/+F2bRdaoFEuR3D9WpWkvH3nE
 Y/brTr6TB0p+C7BXc36x3w60/zmRWQv9Rjanqjt10mCEKqicFyV4lSR3cDFwNdrMACv3ztCoSwr
 prNgbilpErgJaT+9nds1jDOmHoXks804BEsFYlEkhuzONBUL9IOp7ltK/1jLlSU4kOaOoX1l2xe
 drguQcsSeDCHeN3dOz1Qm2pRUMicNv0OQnMAqzxB5GeqhX4WLF4oOwse4OC0dZjkdAjBxAlQMOB
 FLWfDVWQnWImNYnT7QLOOVq1Gn4NxHHI7QhOiGi7OQRTiI6Ln0v6NAWtiOkGk+yE7eVhPTlu85K
 JGEY9Au0Hi/eHZ2umglkt25fflqUjmT5PbX/5AEq19JYStYskEGTj5ofEMr1fcE7+kXQywtyR9W
 o9uF8XO+OFBqlpgXADMv1VncPc1+190oYEJXlxEuQLqkuQ5XJOfk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::27;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x27.google.com
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

All supported branches have these, so we don't need ifdefs anymore.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/target_os_user.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index 9703b9a61a..688da6c81a 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -297,17 +297,12 @@ struct target_kinfo_vmentry {
     uint32_t kve_vn_rdev_freebsd11;  /* Device id if device. */
     uint16_t kve_vn_mode;   /* File mode. */
     uint16_t kve_status;   /* Status flags. */
-#if (__FreeBSD_version >= 1300501 && __FreeBSD_version < 1400000) ||    \
-    __FreeBSD_version >= 1400009
     union {
         uint64_t _kve_vn_fsid;  /* dev_t of vnode location */
         uint64_t _kve_obj;  /* handle of anon obj */
     } kve_type_spec;
 #define kve_vn_fsid kve_type_spec._kve_vn_fsid
 #define kve_obj  kve_type_spec._kve_obj
-#else
-    uint64_t kve_vn_fsid;   /* dev_t of vnode location */
-#endif
     uint64_t kve_vn_rdev;   /* Device id if device. */
     int  _kve_ispare[8];  /* Space for more stuff. */
     /* Truncated before copyout in sysctl */

-- 
2.55.0


