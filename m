Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB4CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPg-0006D1-SL; Wed, 06 May 2026 22:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPe-00069T-LH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:30 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPc-0007dB-U0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:30 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-68470763896so187721eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120667; x=1778725467;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqwbwVXSnkNJYwUgPRis0N7klAzS5K0nBAmWeh9H1GE=;
 b=QYUabgb7NTBfxoo9QyoNn4WFpNmz2FGdP4U/hb7Jx7YqoObgQIYoJ3xK32poGrFvzu
 qJO9Seg5R6oUF0hFbPDrJyL2k80TpqjjtI06cD4dGjkSj1k/4YuC68Yu9Sa5ccDUH8k0
 lTxf42O5J6BHyDRtOIAa7ssrQoWkHtszVvjWaivS+DcnCoOQroXyRoyMCRtdiyaS4zBb
 39hCrxD5zwPH023vsieg+/1fwmNxl7QegMAqCRnfcS5aIT25V65HnKJQUZnJoDsySUgD
 cTVfFHNyzlBRK3/VKYT270SBAKsPghHWWtzO1Ye6HE9Xao1DivM2VYCxqACc8CiYeh/l
 ngFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120667; x=1778725467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqwbwVXSnkNJYwUgPRis0N7klAzS5K0nBAmWeh9H1GE=;
 b=p6ihf1FmrIXC5KLExEU6aIeHI+TpyuofEGmqyalkw5LlqqZBT4dtY9IiO6ATQ5O7Yq
 nr1dQxEJVDYPoc5vy64fbMasliauCFKFGPam9/qOHF+0jvD3UymQwcYGrj4lvCbgMO7F
 j9hDOo21HA7PUjYPokYf77+C6tRjFPWJ/jc03GQ0ve6YQ49TAG3xV6R/aCfXh9cCWeR1
 8xlG4iIIixdRBGt2B6EBrRTJOLaWeXUu+R/ExuY51RBsQT5poOGW7Ob8YXAglzoa5j4F
 h0fWF9fojLYbqQyePxFvN69xCG55ema6iiHc+tAsNiE9It6GTdGc7/2RMBH9wc4TYe59
 VOqA==
X-Gm-Message-State: AOJu0YyJDZijQUozKtVdFcziGWD4w9dmiSGSSGL7HTAI72G8ofyxxdF/
 JHBusmsO8Q98hdXwgcV6ODPL6N1vZt3zJE3WOnYbj/nJKw3vCHDwvpYQLXVf90gXXjNtJmUH4go
 +JotM7NQ=
X-Gm-Gg: AeBDieu0GZxzQBBFKlsET9XtQAw0YoOBHve7N7H3bFZxIvWIG93jDX6uIq8UFz4uwYk
 16JGzFn9sIApyFt2uhS3xduFoGZleefZPAd3+r2YUCfLpEWk/T9eW+u6OMRyMrRVpdo4MJtchcK
 yVqhCXpHIcqigYFMy1L209/u8chWM/qeMbAHlVa9nDG1yFbkE3KZltbnwaquVXSFAhI1J1cCEno
 DkgTiPGagYXjdbE851lOusvUNdiwY96bYivO7hdzdyAPdSLm/7eTeHzsa9OM5yJoflXodk/1ZLw
 yrEUE90gwRFNpsTyoVGFVE0mFH4xmtKqlZlSXeuvgPGXfjCcPEdwPXyySCogN06c55WUm0wsUGd
 0wFHmMDpeZ0B4Ysr98ernyvZg97UIr1bjJBXOEOE6KfJEtKhq3BKeWn7ut9woG/lkC+tGIlrg0j
 aixoG8Xs/t2aUPO1PaY7ab13v7XT11lIo=
X-Received: by 2002:a05:6820:f024:b0:688:b73c:c41b with SMTP id
 006d021491bc7-69998d63c30mr3340022eaf.49.1778120667335; 
 Wed, 06 May 2026 19:24:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/25] bsd-user: Add FreeBSD file I/O ioctl definitions
Date: Wed,  6 May 2026 20:22:03 -0600
Message-ID: <20260507022219.44171-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Add os-ioctl-filio.h with file I/O control ioctl definitions including
FIONREAD, FIONBIO, FIOASYNC, and FIOSETOWN for file descriptor control.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-filio.h | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-filio.h

diff --git a/bsd-user/freebsd/os-ioctl-filio.h b/bsd-user/freebsd/os-ioctl-filio.h
new file mode 100644
index 0000000000..79e8f0b83d
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-filio.h
@@ -0,0 +1,34 @@
+/*
+ * FreeBSD filio definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_FILIO_H
+#define BSD_USER_FREEBSD_OS_IOCTL_FILIO_H
+
+/* see sys/filio.h */
+#define TARGET_FIOCLEX      TARGET_IO('f', 1)
+#define TARGET_FIONCLEX     TARGET_IO('f', 2)
+#define TARGET_FIONREAD     TARGET_IOR('f', 127, int)
+#define TARGET_FIONBIO      TARGET_IOW('f', 126, int)
+#define TARGET_FIOASYNC     TARGET_IOW('f', 125, int)
+#define TARGET_FIOSETOWN    TARGET_IOW('f', 124, int)
+#define TARGET_FIOGETOWN    TARGET_IOR('f', 123, int)
+#define TARGET_FIODTYPE     TARGET_IOR('f', 122, int)
+#define TARGET_FIOGETLBA    TARGET_IOR('f', 121, int)
+
+struct target_fiodgname_arg {
+    int32_t     len;
+    abi_ulong   buf;
+};
+
+#define TARGET_FIODGNAME    TARGET_IOW('f', 120,    \
+                struct target_fiodgname_arg)
+#define TARGET_FIONWRITE    TARGET_IOR('f', 119, int)
+#define TARGET_FIONSPACE    TARGET_IOR('f', 118, int)
+#define TARGET_FIOSEEKDATA  TARGET_IOWR('f', 97, off_t)
+#define TARGET_FIOSEEKHOLE  TARGET_IOWR('f', 98, off_t)
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_FILIO_H */
-- 
2.52.0


