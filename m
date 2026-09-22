Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C9AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964B-0000dU-FH; Tue, 22 Sep 2026 15:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0000YW-Pw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:41 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963e-0002Ot-BF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-8137b129131so229529a34.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104897; x=1790709697;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3AHaNcYXSe+cuvDtPRXSeHNhcz7D5lhdVYzDth6l0d4=;
 b=DDkAzdZNz/VSNbOX3/7V4rOTjhxorE6XxD+DfJKyFfXOKxi/YTZkD6HmVORgIDgAd1
 L8M77i92P0ZWAIMN1HUYXvopLLamhWvuac2jZhwX+a1ytDaJg6WDZ5tx7YfI+QhydD0x
 pawB0XxK+dvwd4g03YZIyGIufHpysrsMMEPP4Z78B4JVZlENPzQxhhgND3JE2KAQqaZm
 9fCn1oibMWuyKVR7CEV1m4T+/wN7s6ybPR9iZoYc/KBHXKtHzf6tatgmLcufoW2wB5yc
 FbRVEnxXRKEeGan2QfYBoo9OcEXQn452/cNidqZ+V9nr+qpiQyf1vftBqdIWv2+bq0h8
 PR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104897; x=1790709697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3AHaNcYXSe+cuvDtPRXSeHNhcz7D5lhdVYzDth6l0d4=;
 b=2uH+Ibf1kXEVnldcq7DLDr4JfUY2eddCbZAP6vYtOBTe7zyGgardm9sUfCRwpigayV
 F7t7Zz//ChCXtKgMvOCHUp/KBb+vvlPWGR60xjOXay7k707okXK9lU3IQqD3z1jgvKU+
 NmWH+d0LUzjJWzA4iUM7oHXbKtR9/YgakVEGmrQzc2ZLYFqvARVH0UGLf+EZQPfq5XDc
 NBBIEDmyXCEHsy+IjxxEG5UTTD0lQVcPsvmvHWYCY0zf7mtAp84I7GpcBOCQmM4ofeXh
 z4IO2c0BKo6YwPjeHxThNTFZE2XgwvA0TBvbbtAGM8Qlo5e3cjgFdYeQySTNnasQrnfL
 A8jA==
X-Gm-Message-State: AFuF++m0oVTHY0KTEv/0G/eH+CASre9EoaQ0ElA7IhZIWHLICL6okGgY
 q1TLQ/h/nXlcilJt18Oau3VNw20QWmlHs9Qgr9/Y+M+vcbgT4HgOHd64KjA8y+zikZq8dViAUY9
 84aYU80U=
X-Gm-Gg: AYBFou3loP9Mi4zKz09SANQJGQo5GYAdlgkZY98mOA7WCyF8idLcX421DZMPZr2zMLc
 mG3yxRhys253Y6kDdoUpCBjET4kwFlB9LqZMyN2CjWOSmYrjkQHqnSo+ePHuNRP4r10T3hhescZ
 fyy8O/nuuoctK9B/JnAdTz1Hf0M5kfMaP/H2tIonVWKvdiYjdNII5SK953X/noKxGNZAuyPZKGX
 vSIQkIRH00XjyLpa3DkQXSRQ/yw1uZpNOqv9qGJzb/Mi4riNlR4Ya8vAXTRn699sV7FDpf0Y5Ut
 yF5GGZX5pc7jSGwBgNY8uXN4vddQr9M+ic7Hhq5VehAfIUl916i/SJiWLhIGKLxekIC9dtzgGs5
 x0ENAl8td/M82f/m8kNxb8Rwy88NSSkm/waCuuQ2M44O5YQeHTlRZTbZQLH8m3N6FuHfcKOVR7l
 d6OrQ04ugItXpb/s2SJKNIe+HIbvvcY6iGdUkyuNeypL6jxs6lkskdRb0U7CABH157hFsR
X-Received: by 2002:a4a:e84c:0:b0:6cd:3fdc:a934 with SMTP id
 006d021491bc7-6d2d3807d1emr333271eaf.81.1790104895825; 
 Tue, 22 Sep 2026 12:21:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/11] bsd-user: Implement exterrctl(2)
Date: Tue, 22 Sep 2026 13:21:05 -0600
Message-ID: <20260922192109.98467-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 16 ++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index be549c4bd9..fa40261da3 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -9,6 +9,9 @@
 #define OS_MISC_H
 
 #include <sys/cpuset.h>
+#ifdef TARGET_FREEBSD_NR_exterrctl
+#include <sys/exterrvar.h>
+#endif
 #include <sys/random.h>
 #include <sched.h>
 #include <kenv.h>
@@ -538,4 +541,17 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
     return ret;
 }
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+static inline abi_long do_freebsd_exterrctl(abi_long op, abi_long flags, abi_long ptr)
+{
+    void *hostptr = 0;
+
+    if (op == EXTERRCTL_ENABLE) {
+        hostptr = g2h_untagged(ptr);
+    }
+
+    return get_errno(exterrctl(op, flags, hostptr));
+}
+#endif
+
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7e400c89bc..e87924fbb5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1592,6 +1592,12 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
         break;
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+    case TARGET_FREEBSD_NR_exterrctl:
+        ret = do_freebsd_exterrctl(arg1, arg2, arg3);
+        break;
+#endif
+
     /* XXX */
     case TARGET_FREEBSD_NR_cap_rights_limit:
     case TARGET_FREEBSD_NR_cap_ioctls_limit:
-- 
2.55.0


