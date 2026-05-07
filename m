Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FECD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPe-00069D-9V; Wed, 06 May 2026 22:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPc-00068T-LY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:28 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPZ-0007co-Tw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:28 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6949192b840so104225eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120664; x=1778725464;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vib50DBJzehDTQwGhRLm3cUJrd276SOY6qdTRikBukU=;
 b=VxC5euSbCUrH3XN8W3fIfViRrQYSp7OOyhf5pjLJCldrDZbVyoO4WFbK9D/1az+uxU
 DqZ5otIG+adHs+2mopH8XK7pz3gR3sufczJMPxfxJfZKTDBrrLofTRoI7QENu6zslE5r
 QWnqkG19Aw6g8QFBdLiISNu/egHzwfvP79XjI4YMoslgbu0ApjlF9/80A4yUB6OQScgT
 Q/RdUNvpKbWmkgE0U4qiD7PQcl4nxDsT6NFZA146YAOhDGbUYw3C77JQEKiRjCs1SWAE
 MxxIrLcjv/Qkq/nzw2LT2wJqE5ofGWNtVKHzyZmD46t2SXiAFYeZTxrqrJV/SBOB6WIX
 8Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120664; x=1778725464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vib50DBJzehDTQwGhRLm3cUJrd276SOY6qdTRikBukU=;
 b=BjbfSkGoAe/dypX6wvvBkCYUaEfPIZ1H3nOikKoTFKIMzOl2iW3KQXNqxEwo7Aq4JY
 sU27Nw5RfcBV0vbPj5tBYbNL+l/wjsmILCMhDi/K8uffm+GogZTJOvuKZO9qJLPnoFp5
 pT/HM3NGw0xWbJf9bW+LN2Cs6f7ulwhdQrBETicKqDhxjScs6FrFPgsWNHLhmYB9rRLD
 4jdFt4j3sNQ5hsRrVUUAe8d7GVYzh3a4QX8/ooHdAUPz4MSzV/2nmTEnY2jDQg0RTe1C
 1sUzo0Aer5vmNXuoVz8SLqC+zAHMiX150sGjHF+whr0NxoGcDoaq+W1kwy+Jlb/PPCMJ
 p/AQ==
X-Gm-Message-State: AOJu0Yxfb3PlmzX9TdTfjjpXUVzxOVPzIfcg8+8u4ldq5/TE15AUU41k
 bi/JPD4WgmeNuJzbktZg7Z7Ljv2+YpLEt//T9iBNvA1lSeK1PL+tiumYQ9xzivH4m2Q+lxVKACX
 7P9ZBrfA=
X-Gm-Gg: AeBDiev14urFMqe1SGkmwSNaCmGum9L4ttIMjt2oM2HIbkHJBSW7q763oskdVmQZQ5w
 K94jbebycKBHBM9Pg2AhZZOGvOnTMFkAlMo0QFvK1/KrDp9gKaId/aK+QSMXbcBQ2jBvlPUHFNi
 66Cw2Ld9MCJWXZQnBwdcP3pU6v8TZQYVKDKoQdluUYdEczLjznWO9o+rBmmAZHwNoOQxcyUyT9O
 NCySRSIcHTV1ybspLVK8QF921vFKCMMUZuJ+ARYeXN7fGjL3c39wA9jclkDppK8b8IH4K3Xckd4
 ONXTugbpO27a1082lKgTmiRJ3F/KdHqzvQpRYsHaGyIuPOOgngU+FoH5IV9gFprzmwd3BSNz3kv
 VTjIXcIHrjdq6r4L9AyFTGeyfpI0gH6DRc3Z0bqgZ69BolGf+TKRreZQ9ApZ+G8bv1bXWDQSOXQ
 G5AQzac4yokLDcufmBOwnn
X-Received: by 2002:a05:6820:16a6:b0:694:8cb0:4efb with SMTP id
 006d021491bc7-69998c91a22mr2963500eaf.8.1778120664471; 
 Wed, 06 May 2026 19:24:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/25] bsd-user: ioctl: add common definitions
Date: Wed,  6 May 2026 20:22:01 -0600
Message-ID: <20260507022219.44171-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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


