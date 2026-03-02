Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA0D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumv-0000xm-0d; Sun, 01 Mar 2026 23:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwums-0000wk-SQ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:42 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumr-0006nt-A1
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:42 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c543472fso4525754a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425300; x=1773030100;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5/uDZL+pfA8846vGTVfG7ScTwbgen6X8va51XqwLIQ=;
 b=MSNZ6Wgip03Co0IwVO8Ue/clOo8zKzHSwoCF9y9WR52BPM/Uo8GV35rLbtm0I4j7MI
 G464/UdMatFcuxRtL7P5IP+6E4K0GMlSGzYW4cA4zCORLEPkNY+C8Bp3ECyjTqM3gJTn
 FcDD27PUcmDXkH8ucZW011SpQ0o0eNMQ3YX1CoJmtAmh9Z0XXlC5014unvL/KMg2N/G+
 tg4qG+HpS70OwHf+3yX24J/eBNBqEZWFQEkEBN/+yqcu2i3tdDGcRnpzZpDFwqaTX3rt
 TvxJfvTO1S8H5QQMm1mOZN5BsrLkVp/Z7m6jEl2jqNbqM5/tjDxEItGwWZETUSNREQ9q
 ntOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425300; x=1773030100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a5/uDZL+pfA8846vGTVfG7ScTwbgen6X8va51XqwLIQ=;
 b=wZfThYn4bpO9Pwy1LvmC57s4D5mQ4F/riyho3gqRTPzh5YKXmktKsoHY3XkWk8tE5G
 zeKmTpdhrSFW4RxAr4fCu7uf7t0Rrt3Z/JLjFMTiUPhQb1CJYvMcJzuU1ks7MMutlOw6
 E4qqz9r5lFJRgLNkXYamex/KMjEyPdFzDNaVrD5oP6KKLJPqEhTVX2m6lTjVRoo38lCv
 WdbXWMxysl9fsGwl+DdQaMYrFyPrl5cE/yyAnJojoIGmNPa2TMOaYG77N/2EPs6yNQKW
 ukrbL8b1K2cVXVaMQi6wbGw3zQ/n/wyVsBmv3FldVoreWZ56Ew2I7iCx6tjru55qPr5G
 sgoA==
X-Gm-Message-State: AOJu0YyQFLlUTaaCJuLZCXGnMJ5yQmxHbYwj/eUsZlW+mI4Dn+I6elt0
 yjf4XLaQ/pvszniVr52YM47t+j+H+e30RSkq/1HlgHXzVf/wcGlVjsUY2PIRzyN4yiRrV7gROw5
 F0GOb
X-Gm-Gg: ATEYQzwkPBdmTjBLdZQgb/cYo3cI38sVclTb1+6U5EQ+zCGWyiwSItSQgnuQXdXPHl9
 cVeJZDqJoEcMoE1lj90ttjDpqqD0Jm/rGwox9X5aRplBuhsN4PH6Fksys8yk66fbT4GGIeAi/nD
 dg5dzQ/HjdGz2F/kXaAWlPFgeFrzrh4FIYsEvodeVyb7jFCDgIXztDViTB6IdaEOJHCA+e85aSB
 w0+xeICjGLzAtByVMVZFz+y7FUlwclYDRSvwJEpZfc7wrMmSZvUKqeFywZA9vD+iJq3zEmj+A7j
 dUaEVRpE+bDsYmU2SRtJOSQ+aUo15Eupd/FSfXyDfDwJRJBM5hGYsG0iP4qvcR58k+cbbdnzG7X
 mlRYaGAuX8oPYsroVFATvYSy9AY0QeCJEd/+g2YleWVwaJiHj6Tbb/qHqxctxKur2oxEIXmRUog
 RvuP99lWkKJ2bhPxVzpwpE
X-Received: by 2002:a05:6870:b2e2:b0:409:62ce:83f6 with SMTP id
 586e51a60fabf-41609cf800cmr7914674fac.5.1772425299924; 
 Sun, 01 Mar 2026 20:21:39 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:39 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/27] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
Date: Sun,  1 Mar 2026 21:20:53 -0700
Message-ID: <20260302042115.83410-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
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

Add the target ABI definitions for System V semaphore and message queue
data structures, needed for semctl() and msgctl() syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index b42dff153f..a4967b444b 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -90,6 +90,42 @@ struct bsd_shm_regions {
     abi_long size;
 };
 
+/*
+ * sys/sem.h
+ */
+struct target_semid_ds {
+    struct target_ipc_perm sem_perm; /* operation permission struct */
+    abi_ptr     sem_base;   /* pointer to first semaphore in set */
+    abi_ushort  sem_nsems;  /* number of sems in set */
+    target_time_t   sem_otime;  /* last operation time */
+    target_time_t   sem_ctime;  /* times measured in secs */
+};
+
+/*
+ * sys/msg.h
+ */
+struct target_msqid_ds {
+    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
+    abi_ptr     msg_first;  /* first message in the queue */
+    abi_ptr     msg_last;   /* last message in the queue */
+    abi_ulong   msg_cbytes; /* # of bytes in use on the queue */
+    abi_ulong   msg_qnum;   /* number of msgs in the queue */
+    abi_ulong   msg_qbytes; /* max # of bytes on the queue */
+    int32_t     msg_lspid;  /* pid of last msgsnd() */
+    int32_t     msg_lrpid;  /* pid of last msgrcv() */
+    target_time_t   msg_stime;  /* time of last msgsnd() */
+    target_time_t   msg_rtime;  /* time of last msgrcv() */
+    target_time_t   msg_ctime;  /* time of last msgctl() */
+};
+
+/*
+ * sys/msgbuf.h
+ */
+struct target_msgbuf {
+    abi_long    mtype;      /* message type */
+    char        mtext[1];   /* body of message */
+};
+
 /*
  *  sys/mman.h
  */
-- 
2.52.0


