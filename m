Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F72FD58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun1-00010T-Gi; Sun, 01 Mar 2026 23:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun0-000106-Hu
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:50 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumz-0006pU-4D
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:50 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4beaf25deso4682008a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425307; x=1773030107;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syqBF1LbiFuWImOOXh6vPy87R7U5x50IQsRbL1WIOrw=;
 b=S7cMG606Fguj6I90PptzndrMCg0DQydUehTeMANTgHVx2Oc1QEFj6uqUvkZSzxiQny
 b3fYRNRHEiih+gte1dK/wQMvp5/lZCQorqoKDIuwIV6AV4Uldc9ijD3oOB+H4dMNYyPJ
 F1Aqof4Qusk/cSY3qEZZrkg9gddSK3ISmgLPU0uw4Gm1qFIwNHh7DIJs+qzQeJZrHiut
 Z8gfLP8rYOgcXw2lC8w3mGfuD4wTSdzyUeeWUi0K3YI/phStrPbRyE1hZl0TbtTRyNG5
 XgUQO23RjGJPTWdendGs+rOzZCMvPtHixCaxBa+cbbM+35+/R6QMNlxJLKQTPGjmI/1L
 4bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425307; x=1773030107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=syqBF1LbiFuWImOOXh6vPy87R7U5x50IQsRbL1WIOrw=;
 b=o0/juyOQvFBy0XEgMiShqINKTh5zmUGybMIjWnprwv7M3BqBlqj2Mtvt3UOEguSfZF
 WTvfaJH8uPQqmEc9KsciaagCHQjNDznWIfVIPvb7nCM/ubG6U55muEnoeVsLPsAW9sj+
 dIq54pkgZLMzXGZ9oXNXc2eI08cDjeyp8cN0AuGB5k/l1vOKHQ/E1rmgicIuHOkA8jaL
 wb8W8CWxKrpspOaFnu23SVskdc7t9C53ta5dtLhHtvdfr1KI8Qt4Nup1L4EHLeGFRTQf
 FBDHyJAymXz8dq43+Apq/tE/s74ZwaZWfTHy8jD2gdRMeQPC0bMrT8rzf4A+cdMDKk61
 j/Hg==
X-Gm-Message-State: AOJu0YzDTu/jw0pYkyo0vj6PadaaJuWaTF4HRxYCXhDRPCmEtG2O46Ws
 rBm44WmjOJy4ajH9LvlDhioPJbi5+ju5bu6xhHEBDVDjDIrAGcgwyQeeBrUQ+uJqQMfo5UlVhiv
 sdQQ0
X-Gm-Gg: ATEYQzxQjtJgivNZNCBHsQ5TUmpMoKDY7BMyi8xdTYuhYm0GEOxo4EqatW8TwiW3cv/
 /UyConFIIYyr1GahlmH2jnqnhk8zuZgdWJ9feTWML0ryhR783BJTyUSZIGTco4Z/FunmZ37D5dl
 XJL+CtuYACuLYD8jB1FM+zRYjS3db5+tUcsIyjX3rOjCuC/uZ0ht5mGemtDopJaxR09v16esG/Y
 w23I/BqDuExiE4T6AAOHsDAjahOFwFUcCNJG4fhd3Ax8xSPc/wvCCR75QRSCZCd9DriMgFwKz2K
 e7DJYHwyf7AW+zauML0oSJCq5zn+23Sr1mtn1dwjjS79f4gQZCxgpK7hqdWQrwqZ9Xmp3UBISWu
 dqLg/fYx4nywp6fKVetEywq0y4+r5gjibIa1vgDGuAQuqQ0Uu8u+rVg1tdF1LLpd4h/tEqMSEyJ
 N8GmHwr0ktjQ==
X-Received: by 2002:a05:6870:b514:b0:3f5:b761:5234 with SMTP id
 586e51a60fabf-41609f5f419mr7855756fac.28.1772425307639; 
 Sun, 01 Mar 2026 20:21:47 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:46 -0800 (PST)
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
Subject: [PULL 10/27] bsd-user: Add host_to_target_semarray for semaphore
 operations
Date: Sun,  1 Mar 2026 21:20:58 -0700
Message-ID: <20260302042115.83410-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Add host_to_target_semarray() to convert host semaphore array to target
format for semctl(2) GETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d1645db46b..65fd7b72e5 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -68,3 +68,33 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
 
     return 0;
 }
+
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_arrayp)
+{
+    g_autofree unsigned short *host_array = *host_arrayp;
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+
+    nsems = semid_ds.sem_nsems;
+    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
+        nsems * sizeof(unsigned short), 0);
+    if (array == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __put_user(array[i], host_array + i);
+    }
+    unlock_user(array, target_addr, 1);
+    return 0;
+}
-- 
2.52.0


