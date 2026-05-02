Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F0CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsD-0007oK-H7; Sat, 02 May 2026 13:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsB-0007nM-6J
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:23 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDs9-00070O-C0
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:22 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd89701acso2561424a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741880; x=1778346680;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BOc9uTMmCA92G3fIL292SccORYO+WLIzqUH2YtTfrJg=;
 b=T+nKn8L2tIU8n2549L9Oi3RJiTbS256+PCHyLtPX2t6nZRsXtzL8YLX9HfRUgNl7W9
 dQ35GGJHc/uliCnuGLaGN/ZLc03v0uBCkciYQ5fWBcvfS8RIbQ/A9jpMgGQISkZleYJ4
 5stxHPT3TszI71frZL10ofI7bk1hzneNyFMn6hY9wkSZZXG51loIHABDr8lk/dO5rTMo
 dEI3oAM6IDn2XsdU6o3NMk8rEeWYJXM0LvdoCu2rpe46LK7iVo9Vjbx+fzUgrxaBK8Ro
 7ihwABdaYr8MpmwXBp4bBfk2R/VoFYg3eaBnURXZpN+vI9XDd1jLyMEyGdlb1KOBghoB
 oF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741880; x=1778346680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BOc9uTMmCA92G3fIL292SccORYO+WLIzqUH2YtTfrJg=;
 b=l6vfWHvOd2ghePb3dKi/Qev6S1+Xlh213fRKcclYFzoQ68BIV9xHDZ36lwVNsO8CI7
 ke6P4dUEm+v5ko8BwqX+JGwqpME3mjoCQ0FTsk9i3/5AQOMkOAdEAKTCBT6WWn81lsOy
 SZgOAoG22U1pta5m6G4BOyT/kduAvh0H0qJ0ruvDIQIS7Wzg/mHnitamPq1t410znifz
 qPVm+vlcizTttdeJhTolTCcBp5wsp2mD0y2IyLYze6jVupUKffRNzUIMHUztYVfyOx44
 AAZYV2QSMcCexXwFugL+IkCGv8gJbM6lXjy1KP3yBnYErZ+obPAxSb2/w4CPQdhVcYB1
 btJA==
X-Gm-Message-State: AOJu0Yy425Zp4g1kt2BFCqQm0dsMKv80HjG42hKhSFF03z4XXeZF2aEb
 HK5SKRbVwGj/7dUrs7WJw75KN3AIWIn8Ayuq23wvY2h100RsVtwLNcz1PpEOYXGYUY0fisrrVAU
 sqJyVA8g=
X-Gm-Gg: AeBDies+yyx39/eVGEyV79jSiPfJNcfMztBe5t6iRiMGtj7S6rfYgG43PiiJf7EgFeR
 a6444gUN+rxgy0w3f8+TpEALcNT+i366CaQrPDa+GNzR9riNSp5atD2QXQYAxfHjk3RHJc06tEa
 0Ldz093E314zJnBNtsY01FTtqu9HR6dBLMDXJp8AieCgcYusfF4/IAtgZZIhcLvr1ppZKcLsGn+
 j7MzWrIWuelF5IPvmazClQEWVN8vceZOUTM6vN3BuRLNf6cKrEeO71PZwHYY7dEYZLad7PB4BAd
 ItSSlUEhauviDSsSH9PbwPw+DeCk8L5Z82DTmIy/yScSRRZQvvXeSuMF6+UCoAS2jdFO3UvuMdI
 hG/lF/94lu+J+1RueKjWnjuvoMyk/C4GQnaYCP3JMebqiLzDPY8FwH4+FYOx+PukQDy5jxuDIcK
 /NvejvhO1osH/zdLKCvwg1
X-Received: by 2002:a05:6830:490e:b0:7dc:e45a:ade2 with SMTP id
 46e09a7af769-7dee125070bmr2170912a34.5.1777741879902; 
 Sat, 02 May 2026 10:11:19 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:19 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:24 -0600
Subject: [PATCH v3 03/19] bsd-user: Add FreeBSD file I/O ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-3-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=F0g3+kO4gd2eueBCVnHy7OGOkP9ymMkEKTdI6DhkBcQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/PX/tnw0GGqKv0wZvSoVACMGnUvS7/4BUUM
 NtT5QUc/iWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 AKahD/4x8CisNw9mFlW+6A5qT1/NwXeh0J8sTsNkyOCJCuESTHnm9ZXp8cXi6ymxyRkJ5f9ujPy
 HnaZl59WjS+Y/AOZEPPE3hwqt0eBFeYjpMTesEB00yqo7LVpO7Qz4UghWC7OfjB/FiTBDI4X1Bh
 SBZSVYo1dJtr9urbt+dY+mHvvmKjSxh6TW/5SJAuM486MKbzYoyqhr7BMB7+YGLIMUV5ZfMhokf
 zBMCLyfxqzfs2sWTBi14iYormwEufp4K4uQ3GFmOjbP2hmtKaCD6EgzN2+aJ+z/k7edgxsprENU
 ysfaOj29WviKSETg+S9ZmS3+r1yrH6qnBVymg3X1XekYjGLJVTDAork2RP8WtImwR3pXVUrmU5r
 ttWTRhVykwWueHRwzsrVrX15DwsYy+umEYtbVaZvRtzeD4Mnkcca6fX0GrMoQ+biMVEkjbc0Z7P
 gGl2nUAPgz/Cg2wDhZswISpI/YBzHOk/GR/X8lxJu+tKS9JDfT3jWkPIHuuzz/WoNKnXCpipggK
 XOtEPvI5XMd6Lw4q1oZft3zkLP9p3zTH9MDr9wNwTNMln6UHahmOgegIDCQpZdbCypEUEDE6LSt
 S2bctAD6lG1YBUB5E6fc+kgCUHrmwDaDaYcQlWaAxY8gVMqzz1BtycvyKkG5DcwI9+bDB1pRDeY
 bC/1S4Gu1DbK6FA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


