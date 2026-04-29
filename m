Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143EAFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Bk-0004S2-P5; Wed, 29 Apr 2026 10:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bi-0004RM-HU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:54 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bg-0004XZ-O5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:54 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6948d7ccfbbso3973574eaf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474011; x=1778078811;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AMr7jz7FRFjQWOZT8lC9LVSiGIZkZ996tBpI4CHStjU=;
 b=SBCBQIlyRlDhE86INXN4VoYGDTZtT5NoLeGUiXDu1hJewRlksXqwmVVfxflhMxlOsy
 3MCsiKetjme0EmvLQDyJ5ZSY3YuwdQy6+k0skECyecEXBOZYSWerYfIkFwldS9+WwG0+
 6Yf4JtTPpfuEbkj2eEcX2zcB3K93zIkazIHdVz3ndNhCEYzQ8L0eQ8v56H4REpEH/xnT
 yWujJI3+2zvy5QPT/z3sikBVt6TRgwkT33GFrXMShqMyIrr7Eop/U3nP/INau/fehEou
 zyX1ierGKvlhvYictB6Y9t4ba7nUGCx9sGRz8/pOvcCUFjiyCyV2Khzy7oc6w9dD8gel
 aIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474011; x=1778078811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AMr7jz7FRFjQWOZT8lC9LVSiGIZkZ996tBpI4CHStjU=;
 b=Q7/eDNw+gRkzYNTS5VGjdV51zGO44pQFrv/qgVzqnvrseKMJn8IqlXMLlsbOHppvUO
 NnHL3+jdSbAksor1juyAERF8BLj92+HcBDdGleEw4xbs1pjf7q3WOAPk5f9EpCioBvrz
 1TLHoDTOgLmA91l5RhT4tgfm5wwZJyzRAVwaxULzKIARMBHrfgzeLsB/FG2kkEL9A/zI
 b9yyX1P9ul0IZaRQ3e9+i3cEsUsDZOXLuidiaTMABFtrYB02spyyOwVKP5uhVR58Bdlv
 fdWgpXaZvD5Ct9Kvf7fJzYopEmPRQDseN9tOiMdCPdbAbrhDy9vv+ZCHWpsBKc1Th5zh
 QF1g==
X-Gm-Message-State: AOJu0YymWnkvBcaP7mhtdOlc3zGjpt2imzm/98b2rUYRu/yi2xjCP1Qp
 t8QGjLTelwGRC57lFfpM4uXauBJEcLnc/BA/tri2O/B8ZPWR+v4xF/ePKX/KmSgXdfQ=
X-Gm-Gg: AeBDieuQp2GsYFcavVrUJSlVuAGpzMWPp3r1FOwJYeiWsfpvbtmqaZZA1/Eckekxq9R
 IIm9b1C0iVNhHkCUkU/90dLbZvQSlGG4+K79ZmOZjbHuvzpdktBNc0Rl99jgw8ikDPVHU19Xu0B
 5+hlFGQCmCWUg2bA1crsAOJ9bp9EvozE5fXFeWVgUBLJ3hYE9xuXn11BCtzQCtU7n6pM36pu5vi
 6/BYP/Z/mGaEihQltFY9fVlPs1JLkl1cakQMOGxta968oRAkYD2uw9pxVqC+sqXbcrp6XMgSdjI
 HW+QfVTkwm8IjmKdXVMZArO33OhCDGGYqDnM7IRMJiZhvtPz8Saz9Q7IUUe5YeXcpeVtR8wHC7C
 BHWOQ2f7n26g68j/ey5jGCXF7UGCld+GvuFcdjDqWDh9R42WWD4Wio+PUBcFNHGXrHGcxbNxxvc
 0h7xw1CrPNOU85Vqbi+7ag
X-Received: by 2002:a05:6820:2916:b0:67e:21c9:ab55 with SMTP id
 006d021491bc7-6965ca67f02mr3987868eaf.3.1777474011471; 
 Wed, 29 Apr 2026 07:46:51 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:08 -0600
Subject: [PATCH v2 02/17] bsd-user: Add FreeBSD file I/O ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-2-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=EbvF/Y9N6ysKAY6EEB2dujgG2t2X2bzpyoB14Ggqvkg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl8CtnogfFwFkClwNKPs1v8dheSvwwlCXoEn
 MaA+5pHeHGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfAAKCRBsHNEofbAR
 AINEEACG9CB18khRE/WWENqq7O5AXHI9cfzae1FwUzE+GbGu7UJVlKfYYaiuJgPDeEpN8wVXcqK
 AOQChJnHonJWBEOPsjCS8D5kVQD0g4A+3rzHsNa5n4GGm6Pe0oWk/syHN3mhMuvFmG6mPUNtP47
 Sl9tHcwv3JzGx1uhX+iwoWhdG74DjopEQUS5BJzXCItXUz8gzUq23taKhOaYXxFs+kZei9wNBb7
 SA/UkA7VujxRBr2T2NEsc/A30nSuzXLw98TQ46ytHaseD8AWEW+HzxW76fQEYwp//IscxF17J/j
 zP2h4lUtuc/QKWCyqsQqKxZ0cM9hgXsaHmCCyuKTvNUGqXunkSf0OxrjsYrmjv9oRl2CBWOpqjn
 /dRBf/UpZtZzhpuoEud7aPDN0b17LHbyHchuOkk4UPfqps4jPIZo+IU8z7qoN/BErdt1bwhG8v6
 dSaJGOhIV+iEFM+2VSxZFM7r/Q2xsKFx6AyHb+ZW7T0vZva3Kkj3cGMfujRbp51ki9Ff60sDU7w
 YU3q7sXLuSrMU1Yp/oXRLl4Op9KlYnQ0W30vOmnjJocdg9UoR0uEP4PsxpEpJJpQ2Ja+a0oO2pj
 3TaaA8Wz1P/6UgbJJq4GsxfF026Jj6IYUR+bBrSMj1LL3ZzhC2jDfwnAZetjpZ81ePf8pwqbGfI
 7Ht1QiFL/DDeycA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc32.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-filio.h with file I/O control ioctl definitions including
FIONREAD, FIONBIO, FIOASYNC, and FIOSETOWN for file descriptor control.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-filio.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

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


