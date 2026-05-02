Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A49CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsN-0007s8-Ab; Sat, 02 May 2026 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsJ-0007qQ-KT
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsH-0007Bm-8r
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:30 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbec19732eso2355392a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741888; x=1778346688;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XiRXymXrkWv23qcdXgj3K3CF07+lwiWxAViASFYNdaQ=;
 b=sAFblp2RbcjMAhDyYfirdmWHCAYjWTrIoYfAh1Q1m8Ly3qlSpHVQajxG4dgakgEvN3
 MwFfU9UtOWoHMKFebiz4/9AkMZvwnHUC6khF7uyAzzNi7WStp878ZmkWxXIaPYQL9tiv
 I6kstYhKfxkXS8CGDzGGOxaN1id+zN+kNqR3NVPZ1e3/TfkeK8+C+KIwLGDkDvz2SLqG
 UzE71xTgynyKmkbMDi6It9oZJEFgz4e9NwRvGJX8pXoucMKRyyNacg470pb4klAnS0Ym
 pYed+jY+XHwRjhwWC20nuIIYFrfD+x5phAbtT4c3iXkiQrJXmpOz3Eqm5bR5QOH6nHS0
 Inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741888; x=1778346688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XiRXymXrkWv23qcdXgj3K3CF07+lwiWxAViASFYNdaQ=;
 b=Lxrg06ot/pJ2jID55/7qKgJ8PvApFK0V6DaCGspjRieEBM3gGwTKDLh5n+FEMOuVsI
 LjnfkicMVUujUEeLSnGuxb2qwO5DSr3EIiXoGPaOm5RIgJv4sxz942Vc/dgRjZRCXaTk
 ySVjEiWPnUvlsnFsuk1SB8JKRKFz+Q/tSpKbXrFzHT1txyzWZiHjcd/41EfGP+rBs0n9
 vCgpbvAWGcpSdd8qr/28bFNUOuL9nD15f4iztaVrRK98GK3JTc5KBh4U2t+KgXJlLaGj
 Mj/7BRTkKoZty0Y1ZDF+ES5ut8IZPEeg8ZoJ6B7nnT7NeqQIG6JMJooIcjv+IfM1ZZ65
 KZSQ==
X-Gm-Message-State: AOJu0Yz+wERDETAh++kYi+TUlINSTsmMy3xqzAF2B2W0/IrWOJYOXnek
 spaWdtWjqU1fmVhXcPauuYqPrbkFB+7GJ2Y9hV/5OZAzgLXt9EZx5L6UUFj3kAA17FgWXcnRPjn
 YtI/bqVk=
X-Gm-Gg: AeBDiesvSeUHUsThkbjGADfLGn84UhG2Z3zAvz9ui6t06w10EYhnkRMTvh4UAcK6D+s
 eVnkRpiDiAijUU0dWz3vvMkR7Vxp+pnBXwDmZIRqQS/87wjOXSBkNmP2DKKyLPmAMyHG9sLBXe5
 1+o9zA8lwyfynFOVQJh0ebXtom/8brIySqWrhI2cvpCo4UaaOJBGce9G8YmZgVVeNKHlE/zZAQs
 k97AWTLlCuNhE36MtQN8Z4Vd8o/A1NHWhJcUoLhU3AyM0FitZmqigoGsJbkbfY+qn2dlyqP93Yo
 9mF6DVp3BduVDUB8umxTAY7hDCOOO1qqvGGEptQmER5BQrkr9bQf7/6nR0F4iLkKOKSyT6IKQWP
 Y/R6DwGZFb+AY08ljXxKKjBzcejwN7bmAkVQ5JVe5fqhveq5mC5FMJ0QX9GVUMYzsH1mqsPHIDA
 q8P3uSd5NOEfll7K3kD4hLk+DulfNYgm0=
X-Received: by 2002:a05:6830:4422:b0:7d7:eabb:2a5 with SMTP id
 46e09a7af769-7dee148a3a7mr2360399a34.24.1777741887882; 
 Sat, 02 May 2026 10:11:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:31 -0600
Subject: [PATCH v3 10/19] bsd-user: Add bsd-ioctl.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-10-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7krySvXGKAFQniXOZAf3gvwvHJtjuTrz7smA6FnxKN8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/Q+XbvNJ1URBZTRpQ9DSy+bDLFfCF3PbMy7
 JusAhz8ynaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 ALRgD/9rNQvifCMgRQdkADiwx4kRDsCnvReVb6VQFJ0UcwjJ5DjlG3mm+G8PwfPVVohWHQNKYiY
 vk3mnzCdHnETe3LC5ifF6taGuyvmggBTPAatuqvVBrPiskFfeZzPcfAJzqsPLHo8AXDqljncOnF
 iquK5Bk+2xomiSmchTMo3UGsV8Ok6y6GGLPScTDYv9JMETRT2kTQJ87cSNlHJklfVTEf4CAGOjF
 lN3sjjNCjcPd5WZAJzZiIw+a2CaNiQ5lAK3dt6RDexlKWmGA5Tm9hIZjkaKfRXZ/e38e8OL4l2H
 26yySwZwSDqkEGIeWdL1hnWfq9kXx+uCdbw8K+ebfM4ekbEr8aUyMgfq6Z6/X9/GbDq4/3/caLf
 c1SHuV51azYdKGWKQx+wbODLZkS+lzP6GRJeI9hR/8GLu82TgvBDjRQw1HE+5An+sM52YVnn+Hk
 VU4+ZHjkpqnKD0xqElGQb0hICfnFgXs2H/EEVXnUZp8s1E25IkJS3gA3wwYvbodJ1aKM3qElX0W
 zIQ3BedbVw2nTpK/EYk8xP32lAizHaPyM/8CffSc/WgIEwR0Krsspf/13Y6WcLn+Xtf6Tkf9T/C
 YG2b+v/mL4EnDsEDOGxOPcB5aRHbTtd4XyD2OEkDfCq7pbRrWsyel69H+fGG8tJIEe8YbVdyYYZ
 m6LMu6FIAzAMd9A==
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

Add bsd-ioctl.h header declaring the public ioctl emulation API:
do_bsd_ioctl() for processing ioctl system calls and init_bsd_ioctl()
for initialization.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/bsd-ioctl.h b/bsd-user/bsd-ioctl.h
new file mode 100644
index 0000000000..bf9bb72bc9
--- /dev/null
+++ b/bsd-user/bsd-ioctl.h
@@ -0,0 +1,14 @@
+/*
+ * ioctl system call definitions
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_IOCTL_H
+#define BSD_IOCTL_H
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg);
+void init_bsd_ioctl(void);
+
+#endif /* BSD_IOCTL_H */

-- 
2.52.0


