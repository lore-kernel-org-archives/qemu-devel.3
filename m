Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B9F3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbb-0001VC-Se; Tue, 24 Feb 2026 09:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaw-0000Mw-S7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:03 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutas-0001Il-Ri
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:01 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2654706a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944057; x=1772548857;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mA09Hvggqn9GHfS647IvNZqvRSaQAtXYvi8sqI7p/WI=;
 b=0riAN72xz602/Hagc2XX2J8XFxazGgjLREFkr0Gj8P9obVdUQzkYT0qnwLAcmVS3In
 EKEbDPyXu3mrDZgGSlscgbZ/9usJcOI5tVs/OKWlGC8Z3ztDQI+olrMHpHHAZWHuvxLg
 pbwYmKFOM+30NVoUMCmiXOMvYPUq3n4CU6Ys0thcH+IKk1S/NxhDBDfGeqjiQr2yzdm4
 z/bXOYFC04iW0M8Rjzqp72Jfro/VITJttACDgn5MTIlUSUAiZ2IAJF5H6IzrS9Zc3meO
 owlUEC56AYgtwyP0sdazs4NHs9G+DOcTQLwqWbCAuXF8esBzl86loPHvjZu0FsNbtdh5
 PfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944057; x=1772548857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mA09Hvggqn9GHfS647IvNZqvRSaQAtXYvi8sqI7p/WI=;
 b=nlO1DhYPZHFioQRZGTIavqpIuPuOSafnU6O/b/QwMca41T90wcjg4W7nEaK8wMADKr
 dbXhhNyZKxf7MCfwqkNY0n0JOY/3YwZ0xOWqqti7iGMAzly8BQPARi0koXezw406Sdoc
 XIXDYUMn0ZDMu9jrEVnT6t1LXvTPJDPoYf1yR+wB4qHQzWSMnunZq4jNnGGW13DLJphW
 DZJISG9MC3JqWtsEVFJ42RBv4CzYFC9UH0vc+s3ysAM+s0pjLwWqrkZ2AZPYsIsJy6VY
 si1nomy37hp+J+/n8s/JOz1QGZscz4YczRJg7jb99yMbwq+EEU0/ZxJEZQIAIQHmVqEN
 DW2g==
X-Gm-Message-State: AOJu0Yzos9OJYnD4tIxZmWQEJ8qPEdg7qqDwqnyEr0m32enwbnbz2HW4
 0Z4AWfmA8y4ydRcR2AUXaVVWpzJUPSJjCPpoX+5egH4tzwOGuhBZraqWgPJd1G9V9p6P2tI9pO9
 fMsS7fqM=
X-Gm-Gg: AZuq6aIxGJZvPfrMF+yR0vxVVzR9q91mpgZdcMWWUaYUDddy9EI75Axz5nNl9rsBQh+
 K/XyO9+XCnTL/TqOxB24by9vx1fXJEp240vrVfqt9NPATqN5xzUOjsFNb6XQJ3KB1ewmcLLtOpz
 alqtVGZ607bBmZ4upv8Mps+rUNU2gj+NNTL/QII2cfAWuwbcapx0HdlMSwxAXdl7BXzcDV/kXfD
 iF7/m7OV/z+bxTwxHh/vmLaTIsE6MHTiY9x3HmGDCcQJsDoRMh0SRns8iQHrtSKPgIN3QBDmmZj
 +sn8gNvYISDgxiGJeR5y48iYr7P+7ztZ/9sHsUVmpUez8W/8n2zBgfOFTG4vr/PnITbHkIaXL07
 SVTpCJijIalkbed+9P8fNCDYSE/clRWq0CElYKcJjQt7rM/f+e0yl/O8av8ER6GpNWB8B6/Ps0K
 IBIMGuZKZQzA==
X-Received: by 2002:a05:6830:2a92:b0:7cf:dc2d:8508 with SMTP id
 46e09a7af769-7d52c1d65d1mr6796688a34.1.1771944057336; 
 Tue, 24 Feb 2026 06:40:57 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:56 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:37 -0700
Subject: [PATCH v4 13/24] bsd-user: Add semaphore operation constants and
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-13-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JgJ6FfPtrykPcLDTkKP0gkFGiJijVzXyRUIWTkOWj70=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnQNSsZ/UPhUjRLR/2V16bFOMFQQgvq3R5f
 a9+HCGIW0qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AOOJD/0T5ECT0efKEBmxz7z4kVRSwXXT0ghB+dGOKxyXlbu4jaOfs5OsvAWaI7pkM2PGgLiw6ar
 DZheUKOIsbcvqrlpX2juaZze9w6L3CWnKQKit0HYtfeC0lGStz7VUPp4yB+QV0RW5za+xuwdao7
 HVTg+IQ/XRiiZT2aihcHG3aEU3uL7WC+E7+EKsEitWZTNb97L2VkObaDw2jjxF+3ZLvGG1UvRyn
 1BbZ65CE4XnaZntI1encqS1ArT5TqGbUx8eiAkwKOhI0CZ+snO53Sg1dW+W7lRDqOygQ95C+aOG
 EvYMHj9ARUyvPem9pjVy+Z3+dm64T+PfCVEy8dgFu/3WSDZAf6fEVQkSh3G8/2cFzOtUCs9t7EJ
 RFQzo+icQsCOGYsIVRNqEOfx1xZrl0cwB8p8QuMPrBxA9WgVPrd4YBXMHHWcv2YhaKLX3GSoYMv
 txf/syjhYA78moN6wvhyhD2h09T7QBFWhQbr2bswWER7cqOqOWvymhjuoe09mfADB8GVQW795sf
 LdGPLMlASX/DhqbRdfrf9iWIb8vSwm9OeV+KpMeVwVmE+DepjobYXHTRrN7dl8SYG2f2LVfTBfl
 lxkzXPEelbyBI5hIoFqqfHWi8FCXSJ9UibABEc1sXYpVI3v00mnQwKOwJ5BM9wHbfNwMW8hjdqR
 coBtHoFFsKcggPw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
and the target_sembuf and target_semun structures needed for semop(2) and
semctl(2) syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 972bcc425e..6a789b2a29 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,26 @@ struct bsd_shm_regions {
 /*
  * sys/sem.h
  */
+#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
+#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
+#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
+#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
+#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
+#define TARGET_SETVAL   8   /* Set the value of semval to arg.val {ALTER} */
+#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
+
+struct target_sembuf {
+    abi_ushort      sem_num;        /* semaphore # */
+    abi_short       sem_op;         /* semaphore operation */
+    abi_short       sem_flg;        /* operation flags */
+};
+
+union target_semun {
+    abi_int     val;        /* value for SETVAL */
+    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
+    abi_ulong   array;      /* array for GETALL & SETALL */
+};
+
 struct target_semid_ds {
     struct target_ipc_perm sem_perm; /* operation permission struct */
     abi_ptr     sem_base;   /* pointer to first semaphore in set */

-- 
2.52.0


