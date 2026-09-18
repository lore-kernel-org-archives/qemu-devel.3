Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87372C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA6-0005Lx-C8; Fri, 18 Sep 2026 00:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA4-0005L5-Ny
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:20 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA3-0004A6-7W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:20 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-80032c08611so188873a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705517; x=1790310317;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKa4VLZ5jfw+X6tvUsehGfxYPqmvOq6odUzllSREcnI=;
 b=dgNcj/UNLNo7GwIwW+gpIYHOwjnph5Sd1DW7lbmx+Rc3FZtz5/Vl5m75iw1Gh9VsDz
 jrdwUDwfL9TJoLLO+M1tzoaoZtaViF1LL+okOVwQ+ylCd3Xw3XFfVWoqI0an327ffXH4
 CLbGMHyH8bRixAJVnAe9bo+WUfNIaq56bJQpGqZUwuu0KxPqXnwCyS2fYBCmU/FagLvi
 6dHYzdpWIvcbdzDjBjN7BBFXtixqDQdEzzEiYnpaioBcrfRofJBLv7HISO0Ikqp5Q9vV
 K85L1ttiFbKrSEhWOpBshRmvGsuIhTi66iUAOwE4pRzahN1ibjnhBPLh2zGSHebzz6Lc
 R99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705517; x=1790310317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKa4VLZ5jfw+X6tvUsehGfxYPqmvOq6odUzllSREcnI=;
 b=yfAuIlo8ZDH1T7lVK0Zda4/3LB0q5Y7PtGYdLDV6HKMW5NraLqxTkzDHvedvErtVUl
 ls6wcu7qKUrBylzFagbl5ZPSnRk16Z/b6gMrdDJlLNmSIuaVlQ5GeVSs1CC/n8YfgtXc
 2R5vRg/Lya67S5jQmU0bKqqUFDhJF+JVHFj41Puks126xmBMcxsYECUXa96kfwT8YSUr
 JF/zCdw+LPNZoUtXrX/yv3F7vDv3qkZgs499D9JIC0GiMh3LKh4vKqkexXmazqdKOzSF
 2UDoDTLG9ju9xTT0j3+AXHLLVWLkB88WdNxl5OmG1UojLqtHNE2jJB7JW0bTIaFDXJwy
 oFXg==
X-Gm-Message-State: AFuF++lxYUp2SQOjwk/TrnjJUZ1V8HudtAf4VfGmIHoLW9B6jOI0X75U
 r9T/0WX5OZI4xLPNtzzpheZaW5L50IUg0SRqYCwwASwe+DY6yUvyZPWuOmVhh2HyjjHUIKdTgtY
 /h2S/Ilw=
X-Gm-Gg: AYBFou0OlfaQq8e7DK4Ox7mippRJJfpYlXlji/gXjvIZuBP4OA4l3Ufq7qMb4ekcsbb
 MRNSHY+G/PQcaSuACR5nmrgFJIrWKJTmNU04y/O1Qq081EcdfIYOdTz9A18gsUKYoZDj/aGOlMW
 KT8pbYrTz2+IEcWdUf4F/4KvUUHmyEC3A1cb8PDdQfIJR5+VXLEt1ghDVoGqe6jkon1QukIk7eZ
 0uKtB07NHP9OsBCfyosb3uLTW8srDLPSR5pw0Hu21Iw3uTfaghk+DroSYcpub2dP6e3Iruh/55p
 kgffjqokMos3I/h9PFItRS37cvRteBao9Qzfmy3mZlDcqr1x5UC9XQKwtjrHhSzo/UIU9052XaK
 pA2nAITV/0mH6fDAzmkxlXUTHnqPIHwnKXQpqYtYnq/epFRPUjr0/dhaVkL1IPEnl4nXzAqpr28
 vDf5aLj/7+Tk7koi8vlG3Y5WhVTJp4963fX3wlzgOvmsjMYXY7Zl9qou7o7g==
X-Received: by 2002:a05:6830:650a:b0:7f4:ec2b:e8c5 with SMTP id
 46e09a7af769-80de0753fdfmr1350477a34.13.1789705516764; 
 Thu, 17 Sep 2026 21:25:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/41] bsd-user: move sys/shm.h lines
Date: Thu, 17 Sep 2026 22:23:48 -0600
Message-ID: <20260918042422.38713-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
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

Diff reduction with blitz: move these lines to the same place in the
blitz branch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


