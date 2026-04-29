Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6306CFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Bq-0004Tu-RB; Wed, 29 Apr 2026 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bm-0004Sx-Vw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:59 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bl-0004Yf-52
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:58 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4756e74f8edso8740360b6e.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474016; x=1778078816;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AFqJHU2l3M+7nH4aoIVAt7Us+qXXcU/vpI78plz7qKM=;
 b=z79WnyVpxXXermsqpy2eoBcvzesyrNzDLzavUBNDNWTuVtiXucakIIPQTU4nhpGr2x
 uzMwmiuz/pmf7Ra+XeR2emfdarFmlzV+IGvMAYaqgymkOklwH96hnzVP9nyWyJ5B8rqV
 3dR+0MonBx7g/MAyqpmZGMSqDQNE2Q7MFeINlenEoTbWHy1KGbO4EXovJ7NY7YQJe2G5
 SgeriRkdsOTP7H/zAI5qEyS3SFEMmuIGWao5Se05xFPxowFWpHuv8ByUeJhl5CxTm/+6
 24nTpj77VqxtjjEeEnqhnrA+4dZcbv6P9wDqK8kaudsguSO8zDggc2pc3tUrvLSusAFF
 sHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474016; x=1778078816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AFqJHU2l3M+7nH4aoIVAt7Us+qXXcU/vpI78plz7qKM=;
 b=TZssw4H/uV03281/T0k2UuCo4hSsZ+JC9iWq4IsLFuDbHZwb318c2UWyN8QFnpcl/j
 OxSJsRR3SeXkmgyKJugk/jnfTVBDGy/mnKshi0txSpB851LwUzu4QcxzMxWlqgDQ8WHV
 sGYjuLORq6l57+dmd2e+PS6jCo+czGGeQ0Q+/NjfG+BXTq3O8gmzMtYpAyXAsYUeF+Xo
 3rsbw9Bo2JzqFzN++d9RqTczVVEwIiDuHDLXCk7/czGict3ECOtHVipqgvTDE0ep0Hw0
 SDALDi9Mps8T4g51LIruut8+2NFQYYJ1p3CZ3iMOLezs4zHVVcnOgQAr4CDAtEDUAbLz
 6JLQ==
X-Gm-Message-State: AOJu0YxTrwnRGARRAyhM1SDuXvai3L5y7Ol0HV4zqSdH8CufDDrkpLZ7
 ZnjWqyDphiMUqT5ENqH68q1xe5+QWSd0xKNKw1D+jZxZ3eywCBTyDWaWfjBNO8LNxMc=
X-Gm-Gg: AeBDievYdc+EpiuG+fiD5Z2QNiYo2SVJtDKw+jw0UeQrzss0V20FTKqNchcSDxjUvLj
 c0x8RbDbQeWNPqYL2un1+KAodPI8N+90/mH6I2EDS+aGtUSfMUaRdYmBPaupPk6y4cR75m4z8gE
 UO/T89oAvYmXjoNQUxZVNOxxa7q1pWmqX1kH4qFq0kbB3Y2o/eZkmXt4Io40ebEJpO8IjJaqJXx
 OimqAINRocOqSlN/JCrmzFQOJnG9C8Nwy1vBlQ9D1TOzPegy5HMCvKp40LczGoltspUSz8PDSwm
 DbaBI1QNAXf8etOrYzXahjGB31WuQVoZNMDUyKzw6+dF0cmj+SaWaeqcSkWX2bC4RttmhqPU+fL
 r28eyXsvifzNZ/Fg1aOj0Qg/gc/SGY0+HVsl87sv/GNqpMyjADeo9aNvdmQzJdh5i/o6BAQkMwQ
 XijmKCjLQCZkSWRAhODrYG
X-Received: by 2002:a4a:ee0e:0:b0:694:91ab:ec85 with SMTP id
 006d021491bc7-696684c2c8emr1993860eaf.42.1777474015840; 
 Wed, 29 Apr 2026 07:46:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:11 -0600
Subject: [PATCH v2 05/17] bsd-user: Add FreeBSD disk ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-5-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cMb3ivJfUvUazhrawmKHI2pYvxgGoimqonpCHhslrO0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl8CmmHIQTydgLsIOBB9gyAUWp/CKxqREOGp
 S8UXK3eEOGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfAAKCRBsHNEofbAR
 ACi8EACqtd1zOktWZcKK44xogxLQaf5r+p0qGMg2O6GdbUn/lQkpDDhGBJwvNXSZwALEr894Bq8
 Sn/yIfuMkqZqFWa0otx9KCLToiHofqPsPZaQhuVS7qcGz+TVs4ZZWvGPiq4wvZB4S1dYiHqQLL2
 6v6gW6qS3DgrHJKRQhmxfX4VEHREuFoxsu1Dh/cPRJKsYHd0zGfn6NeqD7MpIOUeK6PWY/92+Mu
 iOM/b8ofdeF54uh6UfDNFi68LT5tOXQkDMQ+Z6dUTfEKTiH27WpKLGBoS1Lfg9uxm7JXOHBbRWP
 04srzmHB8Dt1iSwN08R2mR361YfLYltHfemsFmmIGWCwgw1pkWlnatdbgRe/ZgvRJ/1h7UOiJOE
 ep9aCpyTpo1CZHGjD9TpfaoT2+9BTSEf18TEcq/7Qzf3y2ziLu61J2qeazlXAtoZD/uBb7a3r4C
 jY9+6IMdrsncijmWCSlV9Na4E5/X0AT6an+0ZxUov56FWiXyose+KELje2z7AcqtK9KDvc65Pf5
 qhwGXvgx4BiEM6VPbIGDcW3s4RIz5OL7II1kR4JoDxa8nR5y5XveppunNgo+nMB3Z6e93Ce7zdR
 SlO4579uBnh4Q0d/5M7XKOu2PvDlstpTMf4CJ9eJdHNm1HVvaF9sVM8AadWkWRiYtJ0IynRPRuJ
 uzD33y8Jvs3T+ow==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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


