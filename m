Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5045DCD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoVy-0007aC-15; Wed, 06 May 2026 22:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVW-0007T5-7I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:34 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVT-0000Vs-Kw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:33 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4be94eeacso417558a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121029; x=1778725829;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqwbwVXSnkNJYwUgPRis0N7klAzS5K0nBAmWeh9H1GE=;
 b=mcZVXUuXn1SxlfsysWBIwWPy2QRDnBStbLc0y3ESG58cKeH341kaaXy1g05Rsbz1l3
 RMvnuiF1von3uwbG9rHGPU/x/Hh6rdBd1+OlIoK8oKtfJq20iYcjhfTqus1PfxN+ZGdQ
 bcUmcgWiAqBZ7OZ4dluix9JC7V7Za9SYuHQu2YuLVSjhaMaWoiQXhVMHtO6JrlhFo9Tr
 PSoZhLbfcAN7N8A2FLNx09Lx/Ye+J2lALcJ7l7mhPgSxPD+weEr7USBJHgiiQlW71ZU6
 thcu7eqHOe2aek1dyV/hmRhPHMr5jOjyp3CyNXejSl1iU9a9qcCjzjE5nkgy4zzIj8e9
 oG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121029; x=1778725829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqwbwVXSnkNJYwUgPRis0N7klAzS5K0nBAmWeh9H1GE=;
 b=jZLjRALo7DEWVklujHXIk0lLT2XeIIn8XAGl0eRhouEUrWr8bKaTMplbGzhdB4+En8
 iHg4i9xTao2IGRQOnSRWMgRBgSSklYAycKzVDztydIr5OtSIGv+rd1FiKhDxn1VRRK0G
 Autnb6lhZLje1E5WkvKWuZew8IpP+eWSrQ2tM8FA5iW3CzXhd1H192VPCoudRjL7UJaU
 37zjz3xrTgMm8JtXPXGRcX7iw5mEwPaFC4gRnIpzUnSDxeNxlak2ODSQq8kHQVAfr8kI
 DOSqMP3204jbgVIEm7hQf6apNJbphv62ARiUXRtoDc96Vuq/fF6u79JSzzLOkAdkFxbj
 WFDQ==
X-Gm-Message-State: AOJu0YyCbQ1Q4Kc23oZnOTzAN8BggNOoF/Eou2nFUQ3bgz6+tE7OhhJt
 HZgyF33Tqhinvq9CXXsr3eUX9lVP2zxUzrX945qQLGFUnEemKwpDBU6jXzkp7Ojs0p9TACzrQhJ
 EwUMO0n8=
X-Gm-Gg: AeBDieuUqxJx+y1xxVEP7J2sG2LPCiyVUNL6WEtgBYSFtB8lSjjJyVx02fBTFxov9CP
 2Q3cAj8cCFxqNGQW38wf8gER9aGl4/Pc7AVrEbBqk5jnMusDCdHJ1B8F/AZKqJ4sCVFxT13KSt6
 o62KTEzkFlEzj1kZd1EKZ1rGKAKgXDWUs3sGL6g+6qAFY5qATscbDeh8c4o65VaiK9r28D8yh14
 lXeGyjk0TwqwhL84pTQbWjMr05kY/p7MOGzFg5tnC8WRVCRn5v0dsErvsbl5bp+bwF4FBTY0Sfx
 Wn6F2nREA0OD+AuYg/+PcRDGFQyoDeWOK/7FVGgkOzCOdzqQJ39Me9rIty0PI6cY3WJanOdnvJ5
 xeh2pf0nvLRNFLKaB7rp0LNa+9Ia1zx7QPNMg928qmvD0cB63Md3vbOLf1sN74sPnNEXjJumnnf
 8OoD4lCGYoHx5tCkXH9yyrfJ/aTPNV5W0=
X-Received: by 2002:a05:6830:6d48:b0:7dc:d0cc:922 with SMTP id
 46e09a7af769-7e1df194678mr3520151a34.27.1778121029637; 
 Wed, 06 May 2026 19:30:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/25] bsd-user: Add FreeBSD file I/O ioctl definitions
Date: Wed,  6 May 2026 20:28:11 -0600
Message-ID: <20260507022827.44499-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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


