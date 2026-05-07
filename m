Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4D0CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoQ4-00078K-Oz; Wed, 06 May 2026 22:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPx-0006su-EP
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:49 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPv-0007hR-VZ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:49 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dca4debedaso388322a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120686; x=1778725486;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3OaXMborORMMatPmIFsXY7DKnDgCYWPTloY74MIZzQ=;
 b=FD54uHMS5DFh8rD90wqDNAqXuUNcOHzP5C2uKpAN8iRpD1An1HnPYdiDWC5YhisioM
 X+ooN6EI5Db6XNEca8LTIffAM+N2MFaH/eX4RW/QEhP863FD+ejCPcG4jDFjfdosuigt
 PVV/EAnr8gmvkbY62cFJSAAua24o/W6wGsV69jpe2dc1+Ebf+41N+uDX4rNojgJerwGK
 zFagh8myJ7VgxLDN8UcD6oK+v2QVZy6MsQmNPLda3oaNbc+ZstwGfGfhP39xm3Jti/9W
 H9pe75eHQI7Ey2BIVWeiRZ8fxxJl0Z3naP6VpLwmGaokJAUm8Z75dK8Qhk02eoQd/W00
 dljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120686; x=1778725486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3OaXMborORMMatPmIFsXY7DKnDgCYWPTloY74MIZzQ=;
 b=TkGwD8Px7xrTg7ubKX6LuFFIhviRafJMv3zfqOljc4qi0hopSnteVAVxAUTi0F2duh
 RRC6H+uPu8boujXuST/uh3gTpWAFk9HrCz5J3CzqKFQnyIy++twCFqyUe0J0SY6XfGw/
 lVJwyPeUS2vk2XrJc8qXdCGhcAOItdDy701qoKBqjBnqqVhmE9DI7FxR0PUu5MzshwiC
 g3rGnKLVOGzZmWkwEZMTnUQkv/aeeLeiaHqZ4fGyNpxOoZtQEV8pAaYsTU5rX3G6gvsQ
 MwC394T0VMlTzQezEc5X+9zMBdEwFbg84L4Hyfjy6xdYRii5tOoU+iFxuQff1flzH2Bz
 hv4Q==
X-Gm-Message-State: AOJu0YxBaebRljSgOrgayPfe7S8AV21ainZTZk1B9DBBwkGo0m06ijdJ
 QdEMv1Ye13vPpfppMwf0HYzHFe37xq3xKkgFgMrFJo2yOP1KhBEG/vZvf3Wy4LioP77WMmGGlA8
 QpR1Hl9U=
X-Gm-Gg: AeBDietwfcFddo4ymi4NWhFwaFjqk2d4dpsZK9IVIme0lQyU6GRmQtTQjDPjhKGxmm3
 2eCBkGF6aQzEb+ktAwf7XJyVuqkEO6asZpwzjXAJZ4IScgbVRBq4SqIBahEvV5Tz/8vSkGpPvhy
 UH2KuhJjVP+Ugd1jC4cjQw6Tj9SHwHYw5WFzIvPpqomDtWwQp8p9XtGC57pKG1MrDcCWTiQJVCB
 sdBNDa5UyXQ7fcItTUka4OM2fZ6Cyu8zQxgbfw5I/pOWneM8uDqgjrRo2eKrlJk+0IBtSOaWIuE
 4IPANH4TwLOPODeHRYvTpi2gV96+TdmpxrcdSFUjZ3vNH7TP0E8SbH1Jer0fcP8oW15cSyl4tro
 7oZrfe5IL/xv44PuSC+miQDq+n3PfJpj8qpMb8zglQfebRPEzI4bsFI6HhCpGvkkb+2JZxYB3yp
 LuizdDQgm+UcKAB4qlFcvo5uSQl1eRO24XULJ8jCKttQ==
X-Received: by 2002:a05:6820:2005:b0:682:3fc6:5581 with SMTP id
 006d021491bc7-69998cbae19mr3171151eaf.7.1778120686320; 
 Wed, 06 May 2026 19:24:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 22/25] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
Date: Wed,  6 May 2026 20:22:16 -0600
Message-ID: <20260507022219.44171-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Add special handler for IPv6 interface request ioctls that take
a sockaddr_in6 structure as input and return an integer flag value,
such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index d2eb9105fc..8d25d84dbe 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -260,3 +260,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
     memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
     __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
 }
+
+/*
+ * For ioctl()'s such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6 that
+ * passes a struct sockaddr_in6 in and gets an int out using
+ * struct in6_ifreq.
+ */
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg)
+{
+    abi_long ret;
+    struct target_in6_ifreq *tin6ifreq;
+    struct target_sockaddr_in6 *tsa_in6;
+    struct in6_ifreq hin6ifreq;
+    struct sockaddr_in6 *hsa_in6 = &hin6ifreq.ifr_ifru.ifru_addr;
+
+    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 1);
+    if (tin6ifreq == NULL) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(hin6ifreq.ifr_name, tin6ifreq->ifr_name, IFNAMSIZ);
+    tsa_in6 = &tin6ifreq->ifr_ifru.ifru_addr;
+    target_to_host_sockaddr_in6(hsa_in6, tsa_in6);
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &hin6ifreq));
+    if (!is_error(ret)) {
+        put_user_s32(hin6ifreq.ifr_ifru.ifru_flags6,
+                arg + offsetof(struct target_in6_ifreq, ifr_ifru.ifru_flags6));
+    }
+    unlock_user(tin6ifreq, arg, sizeof(*tin6ifreq));
+
+    return ret;
+}
-- 
2.52.0


