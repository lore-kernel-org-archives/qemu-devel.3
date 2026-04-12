Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B6E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIC-0006Uk-SH; Sun, 12 Apr 2026 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHp-0006Pq-FS
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:50 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHh-0004Uc-O4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:48 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4233e152457so2636401fac.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009817; x=1776614617;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uXMRYLbIrSLe9wi5/S8Sasx5IZ6DFxOdiiRJnfLgI/Q=;
 b=Yw8/ujrXrV34j0D6b06E14dr+L/2MUTjUJox3x1R81xzcPAY89vp+C4LkDqF0abX8/
 p6sGTcokuBjbSicivz1+DWmkzTSvz3Xi5fzqPkhrsjOjwA6xVbH1IQHuYt4LFnJTKIz+
 b49quiUue25XZgEOVJHDR/eo50kICOgAx2z+3uOd2xirISPYpf5ayxsK5x/UD6h5rRGz
 GnXLf/P5+CtknGYrgFqPej9CRVkX/9Yg8uaGu6NzhX8BRVNn6lYQrKqVyknMvggmlNhY
 xAfMSm0oL6rBffE8wRXroPnlmYhrNWFKq+LMdR4O/6UFLYC/D7mMlc1kc0REcc0SRid5
 D46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009817; x=1776614617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uXMRYLbIrSLe9wi5/S8Sasx5IZ6DFxOdiiRJnfLgI/Q=;
 b=Mipl6t5b9B1JxjhBfqK8SOJeJzMtqLnpRYZKmD8s7QzXgpm7upSFWETvKncfVw/CUl
 Y4hm671FudeqBVjSv56AnSDS/VNK44jEonBt+9XQtiEJxR0C5MaPadx11hE4tIFGmYmQ
 zgJvfXA5zCtHNbkPVLlBpK5zZNid3Kb5b3AXbmA+53HEWvzX4E3ih16543BVex0/5lup
 x4WW2byYYdHjlXXIqeuu0BaLSafdvsPTr/3yh1CTDqrBeu0Uty9MMD0npqZYxq54bCjA
 xOUbE17m6+ga7nLslUyUgT5cAAJKpbxc1EZJJ4p/5/K3pT9rG7ZUvhbRrlIxw1AQr8u3
 EUgw==
X-Gm-Message-State: AOJu0Yzltcnejx9ihNpL10BkrY58YA9t0tDuI4IRhgqL2QZwRimQJpc7
 yulFsCbxeZKWVzqR6UiZM6UGqY6Xaefsp9HUs2qKqvAKXI6AfIB8F1rJ21pO3pRAXzYN3CQbIR4
 bNZ8VQEQ=
X-Gm-Gg: AeBDieu4L4vAKAbPYvbni/Z2pDXj6yLdjEDB/Sgs20S2Y3WQr50AaqdNuV8NX4PSvxw
 EVLiByIZ3ISdb6piJ1HxHQ4a+aTesHvqOLoasUqEgTMoiEc8thFnuLn6lKX/3F25ChJAQCItpb1
 Tz7f502Up9BEowWml6nulnBt3J0JtgYYtgzQMvFwrIqaOXI6NjM7XZUERMFyH/cCMGRxXaT8R8n
 ysbt4mKUYNz+nu60TPMVznIfxfCFtRO4GAzitnEDz5eP6RSWqOw2KGVI/ZVdDxpA/SZYGyF1C9n
 rvOoAXeOyPXhTk3SMpMQTXE41wEGy0xNszNhMecVVsfid5/xBbfzsKFVo+2qeC4zaKv/87Xtlrm
 7JE0EPKQ/ZixfuABcjlbY3IKiuTcjeZtM4k3DlN9ZtigCaaVEJ5pvy4JXlt4c8qx+PmxQZIGrqE
 ON1LLmmOxz5Q==
X-Received: by 2002:a05:6870:2112:b0:422:fb29:8248 with SMTP id
 586e51a60fabf-423e11e7782mr5530644fac.43.1776009816903; 
 Sun, 12 Apr 2026 09:03:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:27 -0600
Subject: [PATCH 04/17] bsd-user: Add FreeBSD cryptodev ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-4-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2915; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=HQVEx98MB+ubgsNcOdd8V62hijQU2ZsZtPK3SIbf1KQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IfKFT8T1hc5Ts35E9R+ouuHyqZBqskLp8ll
 83PM3J0so2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCHwAKCRBsHNEofbAR
 AJLmD/4oWkMLoSE5xqfXl4d79CbRuDTk4WCFpP3TC6UPHxfZUu7mdVawP6OMAlSnujPsNHKJ2rk
 nnPA8zWRWY+FlOBgGbIRYRXF/JAOuUpfaO3Km9VBl5cVzmn+QeFcHGpfaCtihtrXSJ+qU/6Y8ko
 Qw90yKiGYsyw/8fU4y+4NLt5KQLNgM2n5lIDbL8N/BW+oyZBJ93wtYCVsTgysCwO5wP3DnmCS9X
 9+f9ylhTbce3sG4JAKTaIbU9kBn2w22Bu+31jIBQxbEU11mxseNHqguidtEHTg/LI2I7B7+1JAB
 fZs8oKVxfbOUe9iNhWd5fG36VPbwpThIOLe25hv+/W0E45eWoCVINVN4UxKkBEzr1WnUmQtsN66
 oG0Z22+LWqM3V0ttLkBzfZDALOAjV0cLdeZcjN8VIJmqumEnFHnHwCACFAJkMkHGZqLpNtMp2/H
 4YOjBL2yNRxs+pQG68XMXH8kdAHGm649CoWA0v68JDUIIg03Dw9b/dJ5+TD3p1JpoZK7U2YiXB4
 Yg+wNpwXkiiA2VX0NphPbSnd4AtOnfp6DCB2nx4xhni3wn7CQjzu4CnBM8x8QX7/vidIS//aYjC
 fRWI7iSA0gJOT8BC+mN0XoDhLAvdqokQk4EERaQK8oySeP2sA96/Pjq0W87eBMks+UWAoAF3yQk
 ruSDnchx92WZpRA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x36.google.com
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


