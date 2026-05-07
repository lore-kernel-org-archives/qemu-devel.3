Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113DACD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWF-0007ji-AG; Wed, 06 May 2026 22:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVZ-0007To-F8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:42 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVW-0000XA-LB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:37 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso223993a34.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121033; x=1778725833;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W14kYHCQHomYoHQxZOwNdRoUVzbIwGboLu86edRaDh4=;
 b=KgTcgb2Ji3hNNLQ8xVvVu8h+QtgZoZl2nVMALkdfAsev403KH9SMpryMXRiar5XznI
 KHpNAHNOPNzwpXRIQB1j1Tg3hmY5KMfiVdpOYNTnR+Sxj7cVMoeVBMCnj81GhjQbZdyF
 waiUlk2npWgETBqa73SJdqrzc7NkTyGe13kZJ8tnNl6pv/1dLC5FiJv1m+iWS5aQlSsY
 mjUMo5dcBbvFuaPpSPpkJnRd4MOfOZgllDbww5PJMfr/8BYZemYU5AZfqo73gLmOxvwW
 stui9M5n7INiqErQ5pSd6CtTiSAnsR9JKsHfotxw3Bjz2HYjAfmhawNTXvPU8hePm2U/
 GTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121033; x=1778725833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W14kYHCQHomYoHQxZOwNdRoUVzbIwGboLu86edRaDh4=;
 b=G8fWm2p1mLSBF0D/K/rJCjINoXuW+zPyK5a5Nei0UCmkL4Aqe2PThulD1eArn7U4J1
 OEW+/FcaKCENTCvhmN9Lj+urVpANi1VsCEcVyrZbNU45Ar9D9pEexveusoXN/bkCtK9M
 6GO8ihac23P/b8VP0kMhCSWLbCZ4WJIV9tLbWRwGEoajtBHE4r3j2GbseA53WqUjKFzV
 1fzNCiksoKm+p8sj5+4Yt0w7Tjvrh3Q/1xep89SlCmSkvmMGzQl5VNXw9uZbnQwsK8o2
 +fRGziD94CQfjzKiGNQO5QBTVChfZPVZymogb28oSK0KCVKYKJOGB7t0otViAxeiyrUZ
 7HkQ==
X-Gm-Message-State: AOJu0YzxSXwky81hCaWu0yyWDTxlrfupL5H6IabRMknf+5ulZpKHUYmP
 tttNGi0VxabR5EqWColY1vswmK1r6SsRl3szVRk8p6HAWCMOa9t3om5HI8ipnNgkOtnmqAlSjcU
 zj7QaLvU=
X-Gm-Gg: AeBDievNpd62Vlhc4yv9GXLxDm2S3VjEqVcv4Scj3lRa3NtsdlDqc1P8/nkCHiIhRnC
 utJB0usxc2IMjhCmghWWeHZOUTaPCcsz7Bk/1xuVgy6ikcpzSgFnd3Cm1JHhqFDA7mNFaNlRKcb
 O5LWgpIOd/iyVcCuactZZbUYveqr51JWxNQWNPvOApeEr6TCiCJlatXADNdg68nS/IvTVWEI9+r
 sOj5ZJMjqBoKyw66N34JQS+0tump8vkLz1ykHL5lNkwBD4HNPNOqkNpXuZ6tMidmHZrIxSUDK0Z
 ZKFewxK2LCd3IZ01VANomXF1EJCbEZ530/QPSHZpYS0wXT2RKcLFekAo2wYdq1P5j3z7rAt+flo
 cArSjadYhR6Ck5lt/aheZhY4UYg4hYUvbjGYac5B5N96hcwrlojA8wInlRwK6Uy6B7fVvywfOmN
 7va7aVKEPda1wal2UdqJ7d
X-Received: by 2002:a05:6830:2116:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e1defc88c6mr3618008a34.18.1778121033041; 
 Wed, 06 May 2026 19:30:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 12/25] bsd-user: Add FreeBSD disk ioctl definitions
Date: Wed,  6 May 2026 20:28:14 -0600
Message-ID: <20260507022827.44499-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Add os-ioctl-disk.h with disk and storage device ioctl definitions
including DIOCGMEDIASIZE, DIOCGSECTORSIZE, and related disk
management ioctls.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-disk.h | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-disk.h

diff --git a/bsd-user/freebsd/os-ioctl-disk.h b/bsd-user/freebsd/os-ioctl-disk.h
new file mode 100644
index 0000000000..8f4dddc7eb
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-disk.h
@@ -0,0 +1,52 @@
+/*
+ * FreeBSD disk.h definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef OS_IOCTL_DISK_H
+#define OS_IOCTL_DISK_H
+
+/* See sys/disk.h */
+
+#define TARGET_MAXPATHLEN 1024
+
+#define TARGET_DIOCGSECTORSIZE      TARGET_IOR('d', 128, uint32_t)
+#define TARGET_DIOCGMEDIASIZE       TARGET_IOR('d', 129, int64_t)
+#define TARGET_DIOCGFWSECTORS       TARGET_IOR('d', 130, uint32_t)
+#define TARGET_DIOCGFWHEADS         TARGET_IOR('d', 131, uint32_t)
+#define TARGET_DIOCGFLUSH           TARGET_IO('d', 135)
+#define TARGET_DIOCGDELETE          TARGET_IOW('d', 136, int64_t[2])
+#define TARGET_DISK_IDENT_SIZE 256
+#define TARGET_DIOCGIDENT           TARGET_IOR('d', 137, \
+                                        char[TARGET_DISK_IDENT_SIZE])
+#define TARGET_DIOCGPROVIDERNAME    TARGET_IOR('d', 138, \
+                                        char[TARGET_MAXPATHLEN])
+#define TARGET_DIOCGSTRIPESIZE      TARGET_IOR('d', 139, int64_t)
+#define TARGET_DIOCGSTRIPEOFFSET    TARGET_IOR('d', 140, int64_t)
+#define TARGET_DIOCGPHYSPATH        TARGET_IOR('d', 141, \
+                                        char[TARGET_MAXPATHLEN])
+
+struct target_diocgattr_arg {
+    char name[64];
+    abi_int len;
+    union {
+        char str[TARGET_DISK_IDENT_SIZE];
+        int64_t off; /* Want abioff, but this will do */
+        abi_int i;
+        abi_short u16;
+    } value;
+};
+
+#define TARGET_DIOCGATTR    TARGET_IOWR('d', 142, struct target_diocgattr_arg)
+
+/* Unsupported, target_disk_zone_args is complicated */
+/* #define DIOCZONECMD _IOWR('d', 143, struct target_disk_zone_args) */
+
+/* Enable/Disable the device for kernel core dumps. */
+/* #define DIOCSKERNELDUMP _IOW('d', 145, struct diocskerneldump_arg) */
+/* Get current kernel netdump configuration details for a given index. */
+/* #define DIOCGKERNELDUMP _IOWR('d', 146, struct diocskerneldump_arg) */
+
+#endif /* OS_IOCTL_DISK_H */
-- 
2.52.0


