Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83900E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIF-0006XQ-UK; Sun, 12 Apr 2026 12:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHn-0006Pi-If
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:48 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHh-0004Uh-MA
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:44 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so2782331fac.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009818; x=1776614618;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AFqJHU2l3M+7nH4aoIVAt7Us+qXXcU/vpI78plz7qKM=;
 b=b39Phc+3CFoBEVraLsFHu4L5N9zCXKuiHoWMN1VKM8XiGFOWAHW6da0SqTqlD3kYR5
 5VYU/wkLE3vV+7ksFe23OStc8x8t/Vw/eTw/h9TayLOzjNHTrE5Vlv5oy8YdN5cVXnJ0
 tQIi+k/uIhjHVleM0vwh49Ra/9SGSP3jvndVLlhVLJtNVqXUPBqzjwgfrp0MmOBnlBzo
 DXT+5vJuRhLClYybqvgIrIHrhfJ3U7UEeRK4Gv4NtDMXxdJq88bXP14Eq08b36/iffyf
 0DqMyghKgnXcl6tzcsCXnOslfojnSzIOFeOvdz1/pIiKipBDKjygmXhUGq1O0VCeEtVR
 OoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009818; x=1776614618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AFqJHU2l3M+7nH4aoIVAt7Us+qXXcU/vpI78plz7qKM=;
 b=ZKBnYI4VhWrQiTu2MUHJsF6VP7hKcW8mlZxjMk4mJhI8pUd1xcRHLqT8lJ5Fn9YXph
 lHiBy19ei4YXHdY/ndPdeNvHMBxCPGUprLGlVzVBIaRa7y7AdCfBeZSy7sXR5QfCi/us
 l+HXDp8wZmO2aGELJTBRYa8Bdl3iIySFR6dWF63K2aI3mqUIUVccS6JQu/eHZresLPsu
 jGxS1sMIHelEpiJjJzjygVbhb3sV7BtiorDn+rgrbKBTqOFGHzU0qZ+/X3eMZPhXMhif
 c04FYkCfygC09OntrrlHlBzxJ5bD6ayoUzE4rggA5SuSZ+3+0a8hGIlE65s5QOp5j312
 DZfg==
X-Gm-Message-State: AOJu0Yx22smVnLlQN0QaSJOwX5kFNDIdDeC28kFeSa4227JCu0aRr5p4
 tVyUOnuJ3cQqQsdNzKSNGxbXf2/wUHxZT8RdwMZ0+PtxaKFjYc1CJvmlqQMZNZBE9V3URZVsRk0
 WKhSBvyc=
X-Gm-Gg: AeBDieuQgx5i+vlW8erO6nLQCNcH2YMJ6ex8RcTjziIQVnjdWNO/V88PAybVWzADfHC
 mAZ2OGmt4UtnUi6j0rYg8uuI9JoBuZ9lRYqoXwrQjCyMXujhCMpb6WvMN7mZwd4OiZYEMfAAJUw
 auyytLuUazCDfX4sa5kLQj5skckv2oexbegZrk6sPn4iwpd3/sC/uR3wr3ggZRpx2pFE0z18/Bt
 Kh03GRB9/J63H3RpCXAk7G/LCu4v5HSpTlp33SfRgVnu8YTAhsmoPavOnLVAfjaNu4OIL5ic715
 TPk5RmB4z3Ja5QfEIr1sJn+QioW6AOtQipZrbKJ9IbJh1FZVj9OqiKnoa7mm++B7rnGMIlKDVVJ
 TEu1sN7FBhe3wruJ6az2cyrqu79HU99jFF6Z9ajVc5muRxDngMHmHVqLQDsf7lVBmOv8BKxR7n2
 yeKfSTQ4rTvsnZ8XWKg7b3
X-Received: by 2002:a05:6808:1391:b0:467:1ad3:7ee with SMTP id
 5614622812f47-4789f10b778mr4888815b6e.40.1776009818357; 
 Sun, 12 Apr 2026 09:03:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:28 -0600
Subject: [PATCH 05/17] bsd-user: Add FreeBSD disk ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-5-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cMb3ivJfUvUazhrawmKHI2pYvxgGoimqonpCHhslrO0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28Ifi9mBxYSRBN4N64ikaJa77/RBsr8NmDbBP
 CDed529EFqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCHwAKCRBsHNEofbAR
 AFN2D/oCDD+vMREJcr5geVbzqmK3VfLLfzocMbbW9QVy4NhC6tVfpf13TiIXLI/33s/zHcmBujd
 fXDmzo3XZbCAPq5PVjWPSl2Wy6mm8vvP2y07IL2+h4s48taWRlsYObl36YRNX9c95/wMb9rhfUP
 oeZlH0h/IWZU+maHb9C0UuiRmrkhiif4G9bpupUaPNOlnAYjNkjr2KthXGnQtOV3ibT47DaVZZR
 KiQebNllIGpbVjYiB9oLXhJs6FupyiW1YnYEYeDxCotRisTtZG9l7T6Nb1sdcfZ2hBloHoeT6a7
 ynfRV6ILlowJmWBUGvewAibTU9SGCMnQtWbEqz2Mq4KUoRX//hgzG+9j0bvkYpBqqroZsuf2iOe
 meXmJENKz5YrB+EXeBbtfoPh2H9xMvHW8k6eREe90PJGonumScg/CGSFxHNU2cNf7FbM1L+cJ8/
 sw5Mfo6zrM/X3yRC1tGaTDTo2N5MxXt2AFP/V74fn5RGhGDUqe/6Q+FbeXu5U/l7b7iA+Q9ci30
 AXHi5/tv/k+cjJ3x3myQJHg1OJ4zUq+n7KfOcmAocX5MpBRh595YEHv4YGQdiWOFlHhGVvpV37E
 MmvLPOER3KgnIEawBfbSv+TgFvGXxGFY4Fj7LaWRDASplkFj0VvRtLWrCaAHlj80SUhEEqkZH+Q
 JPruHwfcNjFj+ZQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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

Add os-ioctl-disk.h with disk and storage device ioctl definitions
including DIOCGMEDIASIZE, DIOCGSECTORSIZE, and related disk
management ioctls.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-disk.h | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-disk.h b/bsd-user/freebsd/os-ioctl-disk.h
new file mode 100644
index 0000000000..9260953dc6
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-disk.h
@@ -0,0 +1,41 @@
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
+#define TARGET_DIOCGSECTORSIZE      TARGET_IOR('d', 128, uint32_t)
+#define TARGET_DIOCGMEDIASIZE       TARGET_IOR('d', 129, int64_t)
+#define TARGET_DIOCGFWSECTORS       TARGET_IOR('d', 130, uint32_t)
+#define TARGET_DIOCGFWHEADS         TARGET_IOR('d', 131, uint32_t)
+#define TARGET_DIOCSKERNELDUMP      TARGET_IOW('d', 133, uint32_t)
+#define TARGET_DIOCGFRONTSTUFF      TARGET_IOR('d', 134, int64_t)
+#define TARGET_DIOCGFLUSH           TARGET_IO('d', 135)
+#define TARGET_DIOCGDELETE          TARGET_IOW('d', 136, int64_t[2])
+#define TARGET_DISK_IDENT_SIZE 256
+#define TARGET_DIOCGIDENT           TARGET_IOR('d', 137,            \
+                                        char[TARGET_DISK_IDENT_SIZE])
+#define TARGET_DIOCGPROVIDERNAME    TARGET_IOR('d', 138, char[MAXPATHLEN])
+#define TARGET_DIOCGSTRIPESIZE      TARGET_IOR('d', 139, int64_t)
+#define TARGET_DIOCGSTRIPEOFFSET    TARGET_IOR('d', 140, int64_t)
+#define TARGET_DIOCGPHYSPATH        TARGET_IOR('d', 141, char[MAXPATHLEN])
+
+struct target_diocgattr_arg {
+        char name[64];
+        int32_t len;
+        union {
+                char str[TARGET_DISK_IDENT_SIZE];
+                int64_t off;
+                int32_t i;
+        } value;
+};
+
+#define TARGET_DIOCGATTR    TARGET_IOWR('d', 142, struct target_diocgattr_arg)
+
+#endif /* OS_IOCTL_DISK_H */

-- 
2.52.0


