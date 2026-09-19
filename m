Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E242AC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yF3-0002oc-5X; Sat, 19 Sep 2026 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF1-0002oP-OQ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:43 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEz-0008Bx-Mw
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:43 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccde2ad9so1853539fac.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836520; x=1790441320;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKa4VLZ5jfw+X6tvUsehGfxYPqmvOq6odUzllSREcnI=;
 b=dmArt3nRxPnSyCWhtTZz1UFwCv8LSzfc1byQqOsls5XzitgLw12OCx4dTWB1wqoIqd
 nNArVmZjrIq8xAzvhqwT1rQZkPBeAT0CgmBz84DTEoZYLlM3yOH35Aw8oqR6l5rSNekI
 KB6lwQjPluU/hoiviQCotfmEBJwReb4jYxoDST+nbk/ar5s+4RJgwRF4+lSLBGbp/X2F
 WfjG+loVUX3QelS9bp8JAXjGTlkKJwyUhY+R0wKMWSkZr8/kTH21huAMU7D90vNgoBJd
 TOwUO5EN9kZjLJuPyXbqtvMg3xwqOJgITjxREt9H2VCA8P9Thnynu/UV75CigZCjrIsX
 i+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836520; x=1790441320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKa4VLZ5jfw+X6tvUsehGfxYPqmvOq6odUzllSREcnI=;
 b=jqMuiXJwH1FERrPtldFX+0GEPnjuVC9tEIuZ3RjiQa8O7vQfE4Zr3Qyo0Ie0atCTvR
 ZfuSMEzXDOThGMKx3WbD37iLacAvzblmctjcLFUePGuSf84LuhdQvAmSmEvKSEH+Ub8U
 Jg1EP0Sc0aTB+gzDK46spGm500SNzpDOf40GbJDp29BZXl2+qiQ63x0wAJrxsYuhjb/J
 C3cxLQ1AK7x+KbF0/QUUANEoqJ4qlHbs6gPX4j/WuayZtdzGV4yC2tNrhB+7DpgIlxv8
 bbXCI2HUhDGmyDBJMz1kT+DKkF4twr2usEB+EcduGks66bnNaU5xeJowoVcXjG9bzAs/
 H4HA==
X-Gm-Message-State: AFuF++lCUPq2iAMBN0/WRELhDQjShTdaXCLOHm9Oc8NrTowf8RjgyzH9
 xtFe70yLlaPbdlrSMGWC1I8lCdbi8OgwsgdvznCancNTRteg8wUtNPZzIgLYJ8RndbRBvsfEi+Y
 yYviB794=
X-Gm-Gg: AYBFou26gmWaxxvo4tDCNKIBmr3vygEj/pz/sUuHkMMePjJzdm/kGyI3Q/MhXCjCBN6
 4ezBqmOsOJFAC8M1nRynUht5zsjdxMWVdKwKkKq+uUVoJuMnZAULzSzmyTH+9M9h7Co9o5NzKDc
 ZgeHIvwBb/5KP3mj+5sszXj6Tv6xbyUHoZ+pO5ZOdvuZIxBvvQ70ZnsfMulBBvlzc2i2X1u2Dfl
 yZgRUPOP1LqQToyjCEHK7QvR4ZKVlU5j9Ynu4UiJ6GDkRd0pYQr3TLYY6Sz+RprOil9z3N0NYim
 gFJ0RCvN7e9M0xs4cZEvbQDURkSi7s5FfTujDtw4+k4jbGnqz2jJXiFUl5ZvlzIOM1HIP7m4xZH
 EvoJSlPzvYA1s4ZUAr38HpPj17BBKVbjB/5/a0lk2YshCwYEjSrosTEDHo0Du7fg00p8ZskfQbf
 +tn8rpvVMzt7Anu5WbdHfW5FUMZilhztBY1cdZ3egcbwrywcG0q+g3WNLkdg==
X-Received: by 2002:a05:6820:4b0f:b0:6c9:80d9:5e6 with SMTP id
 006d021491bc7-6ca9bf53de0mr4779637eaf.39.1789836520497; 
 Sat, 19 Sep 2026 09:48:40 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/41] bsd-user: move sys/shm.h lines
Date: Sat, 19 Sep 2026 10:47:35 -0600
Message-ID: <20260919164810.70151-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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


