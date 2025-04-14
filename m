Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C42EC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 19:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4PWH-0005vS-6b; Mon, 14 Apr 2025 15:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1u4Owr-00027j-RA
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:54:25 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1u4Owp-0006mq-9r
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:54:25 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6f0c30a1cf8so51004136d6.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744656860; x=1745261660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnPw6CQC/Rs6Gnzgq2fiqjMDcByg2P+791cufmNvCio=;
 b=jDZPpvQXVha9OPUscNn67A2pEPUDiVqWzvV+Grn17vFrtChhVFVw96Gsb88ArbJpHu
 35a8FgMM/AmVNgUt63uvj+pip8SDu+3PPp7vlUm2z8VEWNO4hDwrYYP25JZye5FedacS
 56q5CP5zVyq50AjuT251eAQlLrET32ThVB1u8OhHQptyE3vcXrweW12lcMCfrO+9pfhJ
 vdMsntKaat0t+VqnY+Hg8yJQCVZfggmgRZSb0R0Urn8kKQle3/dLKpuJFW9kQtbISTaO
 cQmNGOiTltyVk++SBJdGh0h2lmX7UEj7mO592sJotcSlS8K5MeHVi5h/NxxRR2P89DmO
 Yl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744656860; x=1745261660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnPw6CQC/Rs6Gnzgq2fiqjMDcByg2P+791cufmNvCio=;
 b=oMQ2p2HH2alN3vgUQeji1nufnbDo+iReCZtfLCqWsoRG7F/xaTN0WgopqaIjf6M07Y
 ZLJXKrommnEDAO1wTV6f3wd2vsvZPhCI/0c1tJCVAIDCAhshtmtV4LJDlH46+VXrwRo+
 pU32c/hRqLXMHqbQjRwYIhTW62JfCcJuq837AMMCCoFvkx8+ZDM2LqtnvUxMqvd9Yv25
 pJdBYf6UHaCy42mWfnBj8x18iaNKLhoq0fsoM2ltcNPw5wcCanOflsw8Vd4cScVbwBay
 Y/gF2yID0uCbzSk+DDzaNiRBSTk/ambTp0SXYEtRPGqd003u8ULV9bporUxDSpnGfsEj
 +n5A==
X-Gm-Message-State: AOJu0YxjlUUqZ2CTXRb7C2fxUHD7n9kt+PFBClVPpVX1x1OlUh3Vbt+v
 wj3//noKNkEWbDrGR6zxF+CdF7yiXVCGLjnR784tVlhcVQz54kRte+FLug==
X-Gm-Gg: ASbGncu40KxkKRW0vv3Kv/5cWWUET6m8XgOweO7lEXpWULzEhR68O0NDu3Kg1P3e4cJ
 Lbm8HMX4xWxBO8A06JFq88llVNxuZtjZ2J5cPAT1uBTWq2WuYeK4Pvz4KZ85Ydr/0byWyNxrXWV
 cJYs9bb0PvNdPMrQyK3lfJY6DuwhKvrxL2fZd5EEZBTuy9JuexOjexHy/C2qWOKa39AKiv02LoS
 9DFj/wKWHymLXil3wBF1KiaahSATdeUplhtRz038U95/Roqiclc2feusaQ6UMvQHTTyr7tyehgf
 QDNE4D4yuE+vQB6nSvBhWonUdXBGLJBDFKt0kklK21Z3j7iY3uFk7CgwJCAZqxUZfKp+ALTRyna
 Epd57tLbHKVwnmWXr+38F3Gb3hj+jRrWZj59itZI=
X-Google-Smtp-Source: AGHT+IEUMRqwVOY1CeQxwvy0hy3bUAbhKim9/3Aj4Mg6L1b7y8FcscmBIplA7xK9XilG6y7V8Ne5fg==
X-Received: by 2002:a05:6214:2601:b0:6e8:fabd:ddd with SMTP id
 6a1803df08f44-6f230cc1354mr173178486d6.1.1744656859713; 
 Mon, 14 Apr 2025 11:54:19 -0700 (PDT)
Received: from paper101.paper-domain.cs.uwaterloo.ca
 (paper-base.cs.uwaterloo.ca. [129.97.152.163])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f0dea101aasm86688676d6.96.2025.04.14.11.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 11:54:19 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Brian Song <hibriansong@gmail.com>
Subject: [RFC PATCH 1/1] This work adds support for registering block file
 descriptors to the io_uring instance and uses IOSQE_FIXED_FILE in I/O
 requests (SQEs) to avoid the cost of fdget() in the kernel. It is a basic
 implementation for testing,
 and does not yet handle cases where block devices are removed.
Date: Mon, 14 Apr 2025 18:54:12 +0000
Message-ID: <20250414185414.2922845-2-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414185414.2922845-1-hibriansong@gmail.com>
References: <20250414185414.2922845-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Apr 2025 15:30:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/io_uring.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/block/io_uring.c b/block/io_uring.c
index dd4f304910..94a875fbae 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -58,6 +58,11 @@ struct LuringState {
     LuringQueue io_q;
 
     QEMUBH *completion_bh;
+
+    /* fixed file support */
+    int *registered_fds;
+    int nr_registered_fds;
+    int max_registered_fds; /* size of registered_fds */
 };
 
 /**
@@ -323,6 +328,41 @@ static void luring_deferred_fn(void *opaque)
     }
 }
 
+static int luring_register_fd(LuringState *s, int fd)
+{
+    int idx;
+    int *new_fds;
+    int ret;
+
+    for (idx = 0; idx < s->nr_registered_fds; idx++) {
+        if (s->registered_fds[idx] == fd) {
+            return idx;
+        }
+    }
+
+    /* Grow the array if needed */
+    if (s->nr_registered_fds >= s->max_registered_fds) {
+        int new_max = s->max_registered_fds * 2;
+        new_fds = g_realloc(s->registered_fds, sizeof(int) * new_max);
+        if (!new_fds) {
+            return -ENOMEM;
+        }
+        s->registered_fds = new_fds;
+        s->max_registered_fds = new_max;
+    }
+
+    idx = s->nr_registered_fds++;
+    s->registered_fds[idx] = fd;
+   
+    ret = io_uring_register_files(&s->ring, s->registered_fds, s->nr_registered_fds);
+    if (ret < 0) {
+        s->nr_registered_fds--;
+        return ret;
+    }
+
+    return idx;
+}
+
 /**
  * luring_do_submit:
  * @fd: file descriptor for I/O
@@ -339,6 +379,15 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
 {
     int ret;
     struct io_uring_sqe *sqes = &luringcb->sqeq;
+    int fixed_fd_idx;
+   
+    fixed_fd_idx = luring_register_fd(s, fd);
+    if (fixed_fd_idx < 0) {
+        return fixed_fd_idx;
+    }
+   
+    sqes->flags |= IOSQE_FIXED_FILE;
+    sqes->fd = fixed_fd_idx;
 
     switch (type) {
     case QEMU_AIO_WRITE:
@@ -447,6 +496,11 @@ LuringState *luring_init(Error **errp)
         return NULL;
     }
 
+    /* Initialize fixed file support */
+    s->max_registered_fds = 1024;
+    s->registered_fds = g_new0(int, s->max_registered_fds);
+    s->nr_registered_fds = 0;
+
     ioq_init(&s->io_q);
     return s;
 
@@ -454,6 +508,12 @@ LuringState *luring_init(Error **errp)
 
 void luring_cleanup(LuringState *s)
 {
+    if (s->registered_fds) {
+        if (s->nr_registered_fds > 0) {
+            io_uring_unregister_files(&s->ring);
+        }
+        g_free(s->registered_fds);
+    }
     io_uring_queue_exit(&s->ring);
     trace_luring_cleanup_state(s);
     g_free(s);
-- 
2.43.0


