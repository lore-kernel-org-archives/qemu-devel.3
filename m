Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF2DC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTga-0001yI-Mx; Tue, 18 Aug 2026 19:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgZ-0001x1-3Q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:39 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgX-0005Db-K0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:38 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4ab47c40e7eso371257b6e.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097456; x=1787702256;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWM7OUNvTHuS2jleASEOMT1hIEbUG/KIuuXdOsvSLdY=;
 b=giFOZoCUKOY1dC291LZ8kBhYLlk5B8MZlOncHUZUHa7sBgd31Siue8xKyp8gUf39bn
 Yz8IYepLqM8DUYL9H+QP0C/siHqCsIUfIKOYwfB5kybUzgbwDwU/FO4PMcbqj1cMKdTi
 szIRgze87FtX3IrxJcrfAF7K+2dZvqIPdyUhQUyRyZ+OGb2O0m8z7MotPSJ0O3277OrG
 Ur8nH2RI8IxGrr/El6ct8gIj+W0XG+SYJ9t2W09x/7RgUhczVKFUqO7QDUoH+ppe/ss0
 u08ioRSflmkS3kcDZfK+qPjW+UvDCDbmQNhpJwLqjct+a5wG416qglgzxgUSCljhFztY
 5/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097456; x=1787702256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wWM7OUNvTHuS2jleASEOMT1hIEbUG/KIuuXdOsvSLdY=;
 b=n3dsBUrzgi2X4t5FClPVUIPP2jPW0z+GyrG36y6CKTV4ah8U8fL8AhXDtHuQ1RDALn
 a1zMBObw8h8DeiG2DAk+dA3ESvSGJ2ojnTfuIhMhj4Qvs80dVMxrka2fwiQE36otwPEv
 88M1Q+GsQX72d338oLAI/4YgRVMsvDRpC3dmtgpfApzNbf1WU2QMqA2+za5RcJ7SBZXE
 wh2WQjakjR4crgt/1ZP29rfHJjQoY6m6A8/YA13OXCMHj8LcYPTXYgXHEKQWerukIZPv
 0TNYXG1JFT64ba0WFkONoVjXGjR0q5/dLRtaoeMoK32cGLJQpCxmH4sKSVCpGauGuoqt
 cuxg==
X-Gm-Message-State: AOJu0Yx/kc11RPYeTlQ82UcR25F/uoD0TDRV9qHyIH7SyzjJKryc0acv
 d5ss4R8UmEcHO8SpN4ICTkVRdbQZi3nPKOpNRbssJMtbKGQ92us9c1fOhzTcB9UkaZs=
X-Gm-Gg: AR+sD12bNXrfdNtcOWm2TEhK3pXfKc8xnC7EMBE03ydnjcGI++br4oVX194aUD+YU8h
 9VZ/izGIRtI82BtK0shE3kNZYpTvdc1LySsmglFJPA3BzqF9VzPEgwHRTq+ispm48mP4UNgBKQr
 gPkbZB+v6SQ/jKW8nNTmXxVcvBNXCctdEt1KlJPQgFEaNW2s38uEKA3evYEfj1Tk+uKk5sAf2fu
 c6+h8k7gd+6X9jQh/p3y6+Vra6Scql1oig87aADhCjN57kULTNp9UUB1Hhat1FBLvafhVV8cCHh
 ppB6tXmGVUMMgZEn+C7Qmm9/zAljod79C7oLKepehWxJ0i2v2unfsWeCFPEpGdWmU29hk74H3nR
 yM2PXse5V3EG/eQAKSyytWWvzcYJnbwg2PjREUqx62mdFal5U+16hkXUbcabC66Lm97tHF0Yg6y
 9ws3aHb+HjHeUHebg9bDz4c1xiUjEhAr8gMxF6ZhCZuyPVR1gB
X-Received: by 2002:a05:6808:f13:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4b2bca267dbmr333480b6e.12.1787097456422; 
 Tue, 18 Aug 2026 16:57:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:59 -0600
Subject: [PATCH v4 06/40] bsd-user: move sys/shm.h lines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-6-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=VDw8FWYXjWq5IrVIJSTvSQkZ9EFhBBdS1PtzUEIgIcM=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEnzo48ti1FapOM2ajbkbwkQlkMf4o9DPSE0
 d47H8tb/oqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxJxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDI8RAAigjX4Em74c8mau4bVgrAYk0TxEmOxnd
 E6GlQwaBs1z7TWikX+A+d6nB13/jf06pRow4g6kfq5Rl7mnvq2JSvgYVmar7SgT/I5AQQSPBbdy
 K5r/EOQnSYQPkADA2jiqS8B3c4nf5tlYnh3DmL3bM+7JZR1tJ++CeWf/NOYZORztNKGbfa4vUxO
 /0gJLaCpPT7Lh6/A6CTq58gpGsx9VnmUopM4o8hzoP3Sz3bBSMtnDi7bezWDvU0rzNbWRSljrR8
 u0V4xNOSHraYV+37L/iBbVv9F1i3fvRYWMSlZIrncWJ12aR0DWITerOuwpdf/Gp6tTPpvi2qB0f
 AjmOJjnuQ0P+okPSlzWxzzeWsRkxBb8o55AZQ9ztP665ze7CmQUP4I7pxKZ577/SnE12mrlEmDF
 q2V/VSx4iilSUc/U8wc4PCztKlt/u2OmBGjnc53QGiPypkmA9UxYQEtT4KMDqEvlC1iyszzUwbq
 /ZS2f9EeXTWTyC8QYOxPH/k9K5BebEbKaSzRHs/QkpWY0qAweWOil7MxEaWHFihln8gIYQfQT6/
 IRDDRHGSu1zTrPO3vO7XKav1iD5CDq0Fnqo44dRccYa9Mie2k2wb3jjcbkYUlINad+eKDzq9QA2
 V370lB87cx3/I1eMnPJT1mkmC1da+imtgdt1UB19Byuz2fxr7Lzk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

Diff reduction with blitz: move these lines to the same place in the
blitz branch.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 0612be8bbb..7e70d6ad57 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -42,26 +42,6 @@ struct target_ipc_perm {
 #define TARGET_IPC_SET  1   /* set options */
 #define TARGET_IPC_STAT 2   /* get options */
 
-/*
- * sys/shm.h
- */
-struct target_shmid_ds {
-    struct  target_ipc_perm shm_perm; /* peration permission structure */
-    abi_ulong   shm_segsz;  /* size of segment in bytes */
-    int32_t     shm_lpid;   /* process ID of last shared memory op */
-    int32_t     shm_cpid;   /* process ID of creator */
-    int32_t     shm_nattch; /* number of current attaches */
-    target_time_t shm_atime;  /* time of last shmat() */
-    target_time_t shm_dtime;  /* time of last shmdt() */
-    target_time_t shm_ctime;  /* time of last change by shmctl() */
-};
-
-#define N_BSD_SHM_REGIONS   32
-struct bsd_shm_regions {
-    abi_long start;
-    abi_long size;
-};
-
 /*
  * sys/sem.h
  */
@@ -93,6 +73,26 @@ struct target_semid_ds {
     target_time_t   sem_ctime;  /* times measured in secs */
 };
 
+/*
+ * sys/shm.h
+ */
+struct target_shmid_ds {
+    struct  target_ipc_perm shm_perm; /* peration permission structure */
+    abi_ulong   shm_segsz;  /* size of segment in bytes */
+    int32_t     shm_lpid;   /* process ID of last shared memory op */
+    int32_t     shm_cpid;   /* process ID of creator */
+    int32_t     shm_nattch; /* number of current attaches */
+    target_time_t shm_atime;  /* time of last shmat() */
+    target_time_t shm_dtime;  /* time of last shmdt() */
+    target_time_t shm_ctime;  /* time of last change by shmctl() */
+};
+
+#define N_BSD_SHM_REGIONS   32
+struct bsd_shm_regions {
+    abi_long start;
+    abi_long size;
+};
+
 /*
  * sys/msg.h
  */

-- 
2.55.0


