Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B045DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Bm-0004Sk-Q3; Wed, 29 Apr 2026 10:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bk-0004S3-OX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:56 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bj-0004Y9-3B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:56 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6949f3eeaf6so434579eaf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474014; x=1778078814;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uXMRYLbIrSLe9wi5/S8Sasx5IZ6DFxOdiiRJnfLgI/Q=;
 b=u7WDJEIJZGiHzyxlNXV7eJ5wjf/lH3nUTZVTSeIJYKoUMSyvrTCO8S1xTzCLPHL+TH
 2OyiS3IBYMKkNf/PsmPmhIU7uqPxSwtFOimQvoKuYIEdRR5YpKGESYL7R57UuWh66AQb
 pNxUVPj+sRLJNTbhQUTPa1TtD6P7dtipT7thr/CUVQnhqPBMtAkx325Se0T2hxSHvFsh
 jemvn5qymy4Mw7dRjP8ttRjQy8fSV587wgGJHTCqs9N1mtMEzINDozkodYMRKKLjDK0i
 p0Mmm91yMWhdOp/tES1tFfFBl4B07FA9ZE3EEDZ/4aDeOV2bgS3iwGt6OXmrvvBkwI13
 FD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474014; x=1778078814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uXMRYLbIrSLe9wi5/S8Sasx5IZ6DFxOdiiRJnfLgI/Q=;
 b=sRzrCA7Eu4kRB8GhZZaxw0Hm0xi0hvhoWtQmaZDL5Ve3tIa8hh0P8cETIWxNs/9ezz
 d5/ql++l1kaXouNJILNOqeQ66RaxcWpcYKLl4hVCq9wb2zUCpDYaOiguFdQrzyGq2Jpc
 dB2Nb/FpAjFnVYPeJfgNh2P4+/Qb+bqS6Sr9R1lHN6YI3S6qSTBRJPp7bAh13Qmv+kTQ
 7OFHr4vS/5zVCQSp+agCRcRseZK65UuSoyJVDTJan14G1SGBR0e2Q2gWWGcDz+zbptx4
 JH9ZKqL/gpi5Cdi0oiQErzer/KTv9oqvPrjzCJY4RVXTZxJ6AIBK4bWSl/Z6lZlq75n2
 9VsQ==
X-Gm-Message-State: AOJu0YzHKFllwi/G0UlXXG6noPP65ZnqSXvh3lSSJSnM4hNJBy4BZyfj
 Wl3F8XJAU0UyBWYb51uw9V3OxIJf02PRWna/SlCQZZqS0wh6eYjp9mUxtkJ47ceR++g=
X-Gm-Gg: AeBDievrsM8OHQYDcIS0iBEaBIy2Gds4+u6v+k74bNdvU+Fr5jbe/1oOhmUb7fUsfAQ
 GjTndGaoeBBFnD9Dr3HRW2E7pOVT+3hFG7aX6OJ9/KMCIZLFOHMsVL23pq/nPFcEmyCWMle8xea
 bHDJkapwLj/KGBaQLvWQJhHJIztHEXCqnE52aE6r/S8EeyIpbHwok/Qs5q+2tNFeXSICmV4va4O
 Ffx7gOzuPkxilsM0mj9fuNR3osZcDtye7SVDzZgh4LYsVXCcIUVFg/niUKCHLmVSAgsF+VdL//1
 Ydtk4rISw0JUAiCmRFA0DA/dJQPfIs4CvTkKtbU93xJTjQGcUeJvZwNjAjMxMKVgin3iA6nHbIq
 7Dpz91kBGp5wyfZMNrU1Q/sW12FNf/L5WVfSat4hftwK4iNpA2QvOrlh1JXIyXpSxNaVYO+T3ly
 us6KPhIwneTjGS3xCePKl9
X-Received: by 2002:a05:6820:60c:b0:689:dc9a:3a79 with SMTP id
 006d021491bc7-69669a3c85amr1258166eaf.27.1777474014021; 
 Wed, 29 Apr 2026 07:46:54 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:10 -0600
Subject: [PATCH v2 04/17] bsd-user: Add FreeBSD cryptodev ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-4-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2915; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=HQVEx98MB+ubgsNcOdd8V62hijQU2ZsZtPK3SIbf1KQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl8UDPRgfRfV9yBhSmMZGctoXqi/udB2cmlt
 FLBWPvJ0TmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfAAKCRBsHNEofbAR
 AAOAD/9kg7q1Znm6Y3Wn05SIndpSgso5g4O9p91Z0aasYA4+tQq1bmzLI0x01l/0vhTY8MS7riM
 gSAFY5QHKXMZuB5VOl++ETQmEWkUyxe/6tUximjDOIOihB8dUt9ppiq8O6PzDFTCa3t2mBQLIhs
 EfJIlzVfmRb1xI2Y0eNxU+Zas8Xg+JQeQO/ccwy9YwAygVij1Z67+0UY+9J+zTJgRQXFvF0MxT0
 OQ+UYrE3y2i4zom7/ycqEZb1xYCHzzy/VFHfwTp62XwYYUYR/GM6O6Xb6Fw6chk0ebVl29CxHpY
 jzehDesRujlCzupcD0MpZwIp+vcO2hEkG+UmIMsXjnP2oX89QmFUSgPHvewb0PTfPwmySTh4te9
 kZYswqPqzab7aU63lQ/zJ4cJPvglpazx60yVrAxiqPC4TmfXTdUvlTED48rTXVU5bObV28prV10
 84A1V7bcx9+1RG/oa/ZJ5bclzXUQSt0NzJm81UHLBnqcqoixnXyVWbFewt6WXpMDdebXqI0k9VS
 pwLCXmlNhyIZxW1mEtDeEpFEUWmTwjiG9wwrC4AQgZIQIyrtRQx69LDdwlg0XG8r1TGSUBw7/ZL
 /zITM6buEHOK7oikCAjRrXmZrkNfTGsEkb3n89iAgLzyFIjpGQi4D+zl4wimY3aOgM+baJqndCB
 461r2yMA0dq259A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc35.google.com
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

Add os-ioctl-cryptodev.h with /dev/crypto ioctl definitions including
CIOCGSESSION, CIOCCRYPT, and related cryptographic device control
ioctls.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cryptodev.h | 74 +++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-cryptodev.h b/bsd-user/freebsd/os-ioctl-cryptodev.h
new file mode 100644
index 0000000000..dc88521057
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cryptodev.h
@@ -0,0 +1,74 @@
+/*
+ * FreeBSD cryptodev definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+#define BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+
+/* see opencrypto/cryptodev.h */
+
+struct target_session_op {
+        u_int32_t       cipher;
+        u_int32_t       mac;
+
+        u_int32_t       keylen;
+        abi_ulong       key;
+        int32_t         mackeylen;
+        abi_ulong       mackey;
+
+        u_int32_t       ses;
+};
+
+
+struct target_session2_op {
+        u_int32_t       cipher;
+        u_int32_t       mac;
+
+        u_int32_t       keylen;
+        abi_ulong       key;
+        int32_t         mackeylen;
+        abi_ulong       mackey;
+
+        u_int32_t       ses;
+        int32_t         crid;
+        int             pad[4];
+};
+
+struct target_crypt_find_op {
+        int             crid;
+        char            name[32];
+};
+
+struct target_crparam {
+        abi_ulong       crp_p;
+        u_int           crp_nbits;
+};
+
+#define TARGET_CRK_MAXPARAM     8
+
+struct target_crypt_kop {
+        u_int           crk_op;
+        u_int           crk_status;
+        u_short         crk_iparams;
+        u_short         crk_oparams;
+        u_int           crk_crid;
+        struct target_crparam   crk_param[TARGET_CRK_MAXPARAM];
+};
+
+#define TARGET_CRIOGET          TARGET_IOWR('c', 100, u_int32_t)
+#define TARGET_CRIOASYMFEAT     TARGET_CIOCASYMFEAT
+#define TARGET_CRIOFINDDEV      TARGET_CIOCFINDDEV
+
+#define TARGET_CIOCGSESSION     TARGET_IOWR('c', 101, struct target_session_op)
+#define TARGET_CIOCFSESSION     TARGET_IOW('c', 102, u_int32_t)
+#define TARGET_CIOCCRYPT        TARGET_IOWR('c', 103, struct target_crypt_op)
+#define TARGET_CIOCKEY          TARGET_IOWR('c', 104, struct target_crypt_kop)
+#define TARGET_CIOCASYMFEAT     TARGET_IOR('c', 105, u_int32_t)
+#define TARGET_CIOCGSESSION2    TARGET_IOWR('c', 106, struct target_session2_op)
+#define TARGET_CIOCKEY2         TARGET_IOWR('c', 107, struct target_crypt_kop)
+#define TARGET_CIOCFINDDEV TARGET_IOWR('c', 108, struct target_crypt_find_op)
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H */

-- 
2.52.0


