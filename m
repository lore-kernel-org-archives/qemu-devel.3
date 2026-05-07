Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EC8CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPj-0006FC-NI; Wed, 06 May 2026 22:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPi-0006EM-Al
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:34 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPg-0007do-Oc
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:34 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d55b97f358so271987a34.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120671; x=1778725471;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W14kYHCQHomYoHQxZOwNdRoUVzbIwGboLu86edRaDh4=;
 b=B8Fxo4sGf4Oic7AzORvdYI6k99dt1Ez1aDkkSv3UHCGiadRRJgsga/d7+wSElTjxsa
 8ZAxza08YtCeIfBHIeGvXsAtjCNquokxwwBIzc9vX+al7EfwYZ3n1sNc7bsa8TkhSkPL
 UEQtQDW0gm5N0r+jAvCcBgI+Uz0rxY5ymxvGiYK2SnUSfdQp3yt1TKBJQ0wjBERW9bOR
 Y8fFYBc2uwAx4xy5Fc/OYW3OrUkZxeX60tCGtYnTBPhplJf/4ymvIaaV+7EuUpGRj7+b
 6vmxxXUqeguZXwlH6Fzs35lS9qHkV6jk3LmD4o3Ww4a+2lwMrTp5evW0aiSzmrVe9+Vx
 pDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120671; x=1778725471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W14kYHCQHomYoHQxZOwNdRoUVzbIwGboLu86edRaDh4=;
 b=lh9fOgwUAOm6z2pu1mk2orvazMp4sASD/t1IsRrqQC7shkzswqL614ONVSABkEdb9G
 Sq5OrJdf3ZQrSIHhgDLsJw0nw4rD2VlQmglZCnuixApS4xfv+VoteLfjX16R94LB+bZK
 DSI0Da5CoC2Z/i6F0kZoMmOXPFqcTRSMj1eQePMuJ8x6VWS4Y3IrXzSR1TMVI+UdDgrc
 yt/kaaeIruvJirmSLGvtbNxlLlNWMRLZpVHaW73xIjGjFxw873SLLneznE8a6iMJm8mS
 EHjw00fPEALn7q+0C64L5pSR1oPASMvjjuvNeyC4V27JZJGM4klRFj918d/PvkDbkzfe
 6k5g==
X-Gm-Message-State: AOJu0YyyGzqyjrdQab3aiV6wivfAfwchL995vBgATFwGDYeh0oTRhBjb
 XFRE5Sflvc+c8ajpK2HJHJrYvJgOONCyTnBWfZwVERFYBddq41aKNZzUpshQajqCRtfCXzQFLI5
 i8zytCDo=
X-Gm-Gg: AeBDiesUsrBZ6YDSANlVdQH5w8ghWyYyqL4+2KMAUYHi1G/2Ycy9XbbTQ90Qi371kTs
 DOyYEaFbTrgubRmTOFKdfBQaeNxiljSOXPm5vkWtqtPxeCEGPTGZgWoaMwu5ne7MtXo9AoUZzOy
 kNwz8meTeVI5ilgXErJkO9gj4HbtmozFwZmqVeAvtYbRe0C19ZyKH4/VG+nscFL/4LG23DltNM0
 z1tCOr0wKNHYPBhhlsmsfoqzmag+D5YgbH7cnxCwImJSV9V1Chr+fBqHwboNYYYhM1MfefLK+xH
 /KUB/zXvPme8OVvLRpyLHrePA4mh3tpNXei1u7/QDndWCiqs2DQOKkxj9rfGCCw632WUxKUOhGa
 DWEJAb3ggVQ5Tqw1dMvzT2e6e6r1ntZ2vE0H9AJ9Ash0XyGMkFmKA9OYJ7GWscagm4sn3hjQbsc
 JfQoL0c/FG3xZFHM9KWNoxHKKdfoSXMKA=
X-Received: by 2002:a05:6820:614:b0:685:3561:8926 with SMTP id
 006d021491bc7-69998d235c3mr3097949eaf.45.1778120671369; 
 Wed, 06 May 2026 19:24:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 12/25] bsd-user: Add FreeBSD disk ioctl definitions
Date: Wed,  6 May 2026 20:22:06 -0600
Message-ID: <20260507022219.44171-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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


