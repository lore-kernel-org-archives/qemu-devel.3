Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A9BCD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoW9-0007e4-VL; Wed, 06 May 2026 22:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVX-0007Ta-AA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:38 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVT-0000Vg-Lm
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:35 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so411973a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121027; x=1778725827;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vib50DBJzehDTQwGhRLm3cUJrd276SOY6qdTRikBukU=;
 b=ejMRiwGMGWF4fiK1jmXBHhs2Ska/P68zWGd0kgNasRSQdxisMb02NtDpPfxXQ/0FQH
 6sSKgIYGuzNJBKl4or005bQIGTZPFv8bdb+HR5/KH5SjrGnlwfTgOTu+fsY0XvBxFwLm
 Z1N7ePeyPh9daXtRVa37I9DSjYJOUq9Ar4yHzoD/FcUgZr1DI/rm2MovJipSw0EFoPFe
 Zn/ExUzlHq7vSCEFMzrMRWKm2529eAFjnj+7GFRVeFSZe4iEuFKK/JznXq8AeRvl4+cq
 iEiE7o2TbOgUpxE7HyswFJs2RqqIC+3+lJheyz3N09Rj4HteJUEfyCd1zPXeqVfINgXe
 GiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121027; x=1778725827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vib50DBJzehDTQwGhRLm3cUJrd276SOY6qdTRikBukU=;
 b=k78102zyLfXokNV5gmBCHfmUiEPs/QWyaTRpUvIy5rpVK8gZM1qNs78LwJqoRHAWXi
 WPPO36RXJwFlRIK0xqnC4ecB2HAXSlHfMg08033pgHdQxEPzGGU1fthIGvqqzLwaCHQI
 XVrovqk4uklPjme1tXRrs5x9sow+KGFV/tam4cGN5sX7mRxrm0Np/AX94k0/fy0uKYdt
 jSEWXGH8zPBI/+yztCVXwzZ/sm7pONHrkIjd09iBrmBZ5sHX72O58cm1PAqEM8qtXj3/
 8z00khCSXKXzP9aoau9ETAMes469zwu32wciTlkYT/roJT5FpZoecoT3tzRZCh3VmR8A
 3YGw==
X-Gm-Message-State: AOJu0Yy7xOuxKljU0579B4pfvJujWxJrRM6U+oCMAJ8MUzrVzCFh9tNx
 z46fmBkyZlR0co5qLQHQzNtgEmscUreMpK+xrxBwmkdZCNOJrYZG1h6LgKBU6AV/CwIUWK+3ys0
 dnUGsZdw=
X-Gm-Gg: AeBDiesbrIJo4B7h6yLMePSJJ+6e7Eq5qr6+ddvPLCvwN3Kt+Gajnb+0KsVEGSdaE+I
 d0iX4R2NmydD8h7iQtF6kqi+oG1K7Q0vFzYqVHtQs2Ek+OKR8a9AvqozwPFEfLyV34F7kmqLn1B
 vtO2kRD9TUC4wyTVStYoKqvioVbwEMt17zWI2OK6kRZSiqqsdE5u0AygP43LYgQIpONjcKkBR5T
 +gPUP8uk9at/FS7Wr421Rop7SLm9SHfzul5IIODSxckXwlyJAkEkNsO8gWHBo1vihK7Eh8L5On4
 oXnCYWIllUAxXPNKAsa7q0NoPzkVzk1XFH4422WUFzzeLChHpY+8VbbPbXq2qBURJhu+kZjbHh5
 ONYM4WVHWlvKMfS2wVQiMSiwp16UhuHKX6ZNFyyfHsT2HDsc34L0tB+FmA7D3XSOrxKHyXuOU0w
 FDqHXOWyAteRnQjrbkTkhg
X-Received: by 2002:a05:6830:600c:b0:7d9:b58e:55ed with SMTP id
 46e09a7af769-7e1df137a49mr3886109a34.25.1778121027356; 
 Wed, 06 May 2026 19:30:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/25] bsd-user: ioctl: add common definitions
Date: Wed,  6 May 2026 20:28:09 -0600
Message-ID: <20260507022827.44499-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

Modeled on sys/ioccom.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-ioccom.h | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-ioccom.h

diff --git a/bsd-user/freebsd/os-ioctl-ioccom.h b/bsd-user/freebsd/os-ioctl-ioccom.h
new file mode 100644
index 0000000000..3bb9ef2710
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-ioccom.h
@@ -0,0 +1,43 @@
+/*
+ * FreeBSD ioccom definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H
+#define BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H
+
+/*
+ * Ioctl's have the command encoded in the lower word, and the size of
+ * any in or out parameters in the upper word.  The high 3 bits of the
+ * upper word are used to encode the in/out status of the parameter.
+ */
+/* number of bits for ioctl size */
+#define TARGET_IOCPARM_SHIFT    13
+
+/* parameter length mask */
+#define TARGET_IOCPARM_MASK ((1 << TARGET_IOCPARM_SHIFT) - 1)
+
+#define TARGET_IOCPARM_LEN(x)   (((x) >> 16) & TARGET_IOCPARM_MASK)
+#define TARGET_IOCBASECMD(x)    ((x) & ~(TARGET_IOCPARM_MASK << 16))
+#define TARGET_IOCGROUP(x)  (((x) >> 8) & 0xff)
+
+#define TARGET_IOCPARM_MAX  (1 << TARGET_IOCPARM_SHIFT) /* max size of ioctl */
+#define TARGET_IOC_VOID     0x20000000  /* no parameters */
+#define TARGET_IOC_OUT      0x40000000  /* copy out parameters */
+#define TARGET_IOC_IN       0x80000000  /* copy in parameters */
+#define TARGET_IOC_INOUT    (TARGET_IOC_IN | TARGET_IOC_OUT)
+#define TARGET_IOC_DIRMASK  (TARGET_IOC_VOID | TARGET_IOC_OUT | TARGET_IOC_IN)
+
+#define TARGET_IOC(inout, group, num, len) ((abi_ulong) \
+    ((inout) | (((len) & TARGET_IOCPARM_MASK) << 16) | ((group) << 8) \
+     | (num)))
+#define TARGET_IO(g, n)       TARGET_IOC(TARGET_IOC_VOID,    (g), (n), 0)
+#define TARGET_IOWINT(g, n)   TARGET_IOC(TARGET_IOC_VOID,    (g), (n), sizeof(int))
+#define TARGET_IOR(g, n, t)   TARGET_IOC(TARGET_IOC_OUT, (g), (n), sizeof(t))
+#define TARGET_IOW(g, n, t)   TARGET_IOC(TARGET_IOC_IN,  (g), (n), sizeof(t))
+/* this should be _IORW, but stdio got there first */
+#define TARGET_IOWR(g, n, t)  TARGET_IOC(TARGET_IOC_INOUT,   (g), (n), sizeof(t))
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H */
-- 
2.52.0


