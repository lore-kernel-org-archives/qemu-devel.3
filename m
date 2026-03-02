Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E09D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunE-00014r-6C; Sun, 01 Mar 2026 23:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunD-00014W-Jz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:03 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunC-0006sM-8C
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:03 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so2008768a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425320; x=1773030120;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8NnWK8xCgQpSxl8E7qhElpENksO9jhsVKxO2jvhWt8=;
 b=U00yoZI++oIWuGIPxGsLpo5PVo5kXXFOR8DoHq5i6gn6MhoW3oCczgIp8s+EMNd7ht
 5ZIF55aUFZuwpZoAHkR9qWXvKPLlpdZ2XkuBB1WAAiXKAWPl0wlbftRTNU4MZwdYTD1R
 LqphMF4silFYEHUMsE+vJ+hZ8CI9N39Y2IaKI9W6FZt70kL5ib9iAQKHsH1tFTuO18+x
 wSnrZ74ndxq3Ak8Io5lnafI/gfjJe+9ab6drVSomIlfDpvs92X4/7mYfYvusysdpxQbA
 PcTRRqQrfjIQDwbrbnJlNuV1E0SheZuP9kQwUuDzxL/NHDrylvazDJKSPQ/aJxuftQuv
 CTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425320; x=1773030120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8NnWK8xCgQpSxl8E7qhElpENksO9jhsVKxO2jvhWt8=;
 b=vTTQlEgPIkYPx0D6baD+Gi1e7OhvBVg7BDfnW6u6pcZtRt8NmWnR+d1zqOQ0nw3JdH
 c1uNiry4DWVnVEdEHi7Pt9qK8du2Wa1rdgLzYpHwfxHIkufyU2c8KjDneN/RmV1rH588
 RM66Ya9li7IZmjgDqQRpOnaP47i1hD89wKWU6yI78YknO/gssqwrww70rK2c8IFsPrRv
 X1hTkVfw5tvB7GiBzjqsG2twFgBSXwthOUKsrzyIj80cxgRgN1vTock8BzNxmBhW8yo6
 A3fdH9rnTzkaXI/8S/tQnzlSNIPvZ9IiBZ+DzQIQvhVHJCAVowh4GVxGTSEZFmXIHpwm
 HP2g==
X-Gm-Message-State: AOJu0YzCat08nXiVhEwwGSZR0uVNN36ctWZINpR7OtQWPsDxRC7tBYn+
 9sNE6OWQN9ya/s/lUbVTR8DIQSKz74XFMW0xj1So/U8uEB+ZbMwPgnXyHXNwsvN0+HRB8Z0LHb1
 sCw5P
X-Gm-Gg: ATEYQzxddUM81byRsS2x6TJVEyN/5cFbRE4tg/hkrfZSwoPBMbjCE6YXd0Sw0Ak0J0u
 K6WQ2FRhWF0Wbs8VdVvtoS62bZOvu6dlu71zqhQD78K05E8W4oQeb5QHbJq16ufVGA+z74voo8A
 UNqeIWb9ef0qh0swne7pfjBRedzlje00cVrvrVOW9V6uZtS4bgrFWyZw36VNP9k6C0yIFh4UgCC
 fVcvs75Sac0DWUyt3eb8DBWvxqGyrRhD640kMItX0imZFoRVKoIjxSs3AqRj/yq1FdZYVHkvah7
 KAvUOsr6Ey26h7Q4NoTR5rhqfhch6Y1+AM9qhoJjMSwpDggJode2haQimfry3M44ZHhTW/4r8sp
 VUweXXhzIl6ynMrWy0lpsXOa+yT9JjIHtFaAU4oXGBaZQXrlUu+3J5FBg+x9PIVeMdAuni+3Q3T
 vu2rPS83l+dA==
X-Received: by 2002:a05:6870:610c:b0:40e:a338:c8a1 with SMTP id
 586e51a60fabf-41626dd728emr6451400fac.11.1772425320637; 
 Sun, 01 Mar 2026 20:22:00 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:59 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/27] bsd-user: Add do_bsd_semget implementation
Date: Sun,  1 Mar 2026 21:21:06 -0700
Message-ID: <20260302042115.83410-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Add implementation of semget(2) syscall to get System V semaphore set
identifier. Converts target IPC flags to host format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 9f1cc8a0cd..3dffb977a5 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -65,6 +65,18 @@ out:
     return ret;
 }
 
+/*
+ * System V Semaphores
+ */
+
+/* semget(2) */
+static inline abi_long do_bsd_semget(abi_long key, int nsems,
+        int target_flags)
+{
+    return get_errno(semget(key, nsems,
+                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {
-- 
2.52.0


