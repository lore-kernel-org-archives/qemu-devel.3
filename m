Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD0CD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzW-0005fB-Mb; Sat, 30 May 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzL-0005cr-JH
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzK-0000dG-0l
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso6367145ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175577; x=1780780377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VB0QJcqyoVRmXmBw8fsbJF6h0psM6cqzMVuAr7gGazU=;
 b=QNB1TGxq3x0i4L5XzSO2ez1/JT8o47NKtc41hqOPOffcxpVlYHuAZ0/W1anIFW7uDZ
 WpEjClmhn7Q9Ptgt4RqQ9tZTobblsOGtOFisQ8ElKDtZ9fyZDHMvkNMDPbwESEv5I8DS
 0SZH2mygzr7r3csPgfDapQf+KWCnEUO4XQXmX+KIiRRdfH/Y3U2qbSMGcTVVE+jebp1W
 pd9Htdr8smEKNZ+41Vb+5BKYtlgNGqA6kActHKtAGZQVJqVg235kOzOd7pSDkUh/13xg
 yaogPz7mTPZ41vmgi1RBKhYHAfwmuvHei5yd0Ud4t7wDkkXN9daXnwpQUk0GxFf1CUNw
 m0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175577; x=1780780377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VB0QJcqyoVRmXmBw8fsbJF6h0psM6cqzMVuAr7gGazU=;
 b=qrIXvBgwNY31r9+Z3KdGyZi6pxAgv7J/xOp/GMwSrHvG5iEug04IuH43EHW9LEMIs9
 S0x1F8lJVLAl2Oc7CLbi5pXgCKe3+xrljMZciqfFvWDGJ7ZJv/iH2ezmQVTCeD3zfRI/
 D6AADI+HjLu41yunT38k9D3+V0hkOgdgLTcz6kR60e5Ys89kAZ+Pkt1pJqORw9kPDzbc
 +NilO/d2L5nP0fn5+HXcz2r5Z5SzcBN49XhpPlC9T7yRz+j1LGo0UUeultnPpwLM0PC3
 m0WfKpNGjbhVBv4ShYigR//pA5vGfS3jqntonulDbexnI9yYTgRv1uhJnhtfU29K0xar
 /mzw==
X-Gm-Message-State: AOJu0YywuuHfPwXWgTxDBGadod7kSXnTa7FkYby+8yE7f8Hp0vBDlipE
 QxbO/Dvs0C8Ls7ok2tFeklxuAZhJs94Gk2jVX8Ve5TKLsWKWHcCrRJTOLkkUgnACVXxbdp0rr/G
 dxOfMAYs=
X-Gm-Gg: Acq92OGsMiMYG7tfpXimwcOwtjbf4LnVuOA/rH5jjdKdfLF4p+FrEpgfPDconJt01Ef
 meSvYWBdZBD1B/gb7uFoHNGhJaJoCpU5iVvTUyCUbB3L5GVi/OM5sG9COdB/UXQGhRZwWDnKmny
 sMdBxt4ykgUrhQxgeLao7XJMGiBZuwsO+gSBXm+CQaEkRo+rAzj+W3W0K4KCvj4AUMmlvpIzh8M
 A6WeYdqU3U/sXjJ2xJ2P5OzFn+v1Wrq5RjiIPH7cX4DzBJ5ZNFcyFsW7U9HH72t9zbJ3x8IDX7H
 UvxIkaCVFmE+SkzY9MQiWq6rYgoPfkK68YYWxPDiEUTzcwrluFHtxf5q39U1/Bq8OjR6M74sEam
 M6mO06cl7QsH5FvJckL7COonZqfCTozPfDE9IgAlsPELPvCid88ueG6bQRRK4jNHnMDGC6BCMFx
 NHjhvqLFd/ht1cqnp5pfSXTw8V1jPk2uHxn1o4Fo8=
X-Received: by 2002:a17:902:c949:b0:2be:1c3c:72bb with SMTP id
 d9443c01a7336-2bf36860a25mr59753535ad.33.1780175576541; 
 Sat, 30 May 2026 14:12:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 07/13] common-user: Initialize mmap_min_addr for FreeBSD
Date: Sat, 30 May 2026 14:12:41 -0700
Message-ID: <20260530211248.375318-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use sysctl to fetch the vm layout of the current process.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 common-user/mmap-min-addr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
index b2b3762386..830c6f66a0 100644
--- a/common-user/mmap-min-addr.c
+++ b/common-user/mmap-min-addr.c
@@ -5,6 +5,10 @@
 
 #include "qemu/osdep.h"
 #include "user/mmap-min-addr.h"
+#ifdef __FreeBSD__
+#include <sys/sysctl.h>
+#include <sys/user.h>
+#endif
 
 uintptr_t mmap_min_addr;
 
@@ -31,6 +35,15 @@ static void __attribute__((constructor)) init(void)
         fclose(fp);
     }
     mmap_min_addr = min_addr;
+#elif defined(__FreeBSD__)
+    int mib[] = { CTL_KERN, KERN_PROC, KERN_PROC_VM_LAYOUT, getpid() };
+    struct kinfo_vm_layout info;
+    size_t info_len = sizeof(info);
+
+    mmap_min_addr =
+        (sysctl(mib, ARRAY_SIZE(mib), &info, &info_len, NULL, 0) < 0
+         ? qemu_real_host_page_size()
+         : info.kvm_min_user_addr);
 #else
 # error
 #endif
-- 
2.43.0


