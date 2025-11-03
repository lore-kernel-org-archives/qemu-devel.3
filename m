Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A9ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lw-00015Q-UL; Mon, 03 Nov 2025 16:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ln-000132-0v
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lZ-0005NW-Iz
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaWkrY5rCFrcQOkGSahAZsAjKVM238HQDT5pwdu9p4c=;
 b=AqKlObAsREhYrUfmVA1pQ5Isrt/7TchysGWUw8mGz/ymcj4+N+Js2qJlAw8EzU+rQnfnBu
 xg7vFFTf539LEtgcL6Uui5NnSbFHyPRKr+WH7LlyUMiwIiFz02W75TqNYbqbY76QYQdrhd
 ZYMrXxebyWF7ZRqdRm06COpZp63K+FM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-hQgxn5pMOpWH17CxwzYa0w-1; Mon, 03 Nov 2025 16:07:01 -0500
X-MC-Unique: hQgxn5pMOpWH17CxwzYa0w-1
X-Mimecast-MFC-AGG-ID: hQgxn5pMOpWH17CxwzYa0w_1762204020
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b12cde7f76so31028785a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204020; x=1762808820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaWkrY5rCFrcQOkGSahAZsAjKVM238HQDT5pwdu9p4c=;
 b=A9y1eIjh8y4GYTFgSMZTGfZWjHy0gcI6sv3UJxbnu0nIKzcurc3K4u4+sDmb8UKnYk
 bIgqq748YuYPLpgU2yUUoLLSQQeLWasQLofhQwF8QZm9Avof0u4Rn1kyI8onBMP9GQHD
 S0m0ELdfFYUmYtOjBmYEkEI5WqwqSlO2iRFTJniFscgFdAbVCj5mRXL1SUZyUHNuMRMp
 yexkOf8EaN7ly/a5pmq7JWq2CiWlzT9D85iKJYHieGhLTYN+c6i/pwkwhiiqw8uBQc06
 a4Gp6gXdmqNRrPJjzxn/cH4qy2IL9tn1o72/Wt0LFdrfN+gIt+9lz4FhWg7nNYTRHcBG
 5k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204020; x=1762808820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaWkrY5rCFrcQOkGSahAZsAjKVM238HQDT5pwdu9p4c=;
 b=OD6UeoFBblCZ98nBYUd7C7Pq7moeu9zK6xrHs6NmfXDe39xxZuUzKE0d4Na01oDI1X
 YBsHfDj5EQf27C8KzeNcA1dJZr5XxE7SOfimwv47EOEYdHwvRC0FXNXWpZz6vyXErq8N
 dj8sz194rLMhWcvg6paf+2JegaPfbaHyoPw2V6uwI5Ps2qlF/qlilZBEOARWpoNd5Zma
 z1rBMzX8/+cnbQBN48H873qUc5+2Ug8gnywfRD9r/zW75IfWeBR1OEkDrQIT1/vi/+7r
 RBie/dEuyY98JUboQihAkXyzjLHgPyOCCkVlnThC5WK/hNuy5+Z5bCnDgPdtPNfwUVX2
 mj1g==
X-Gm-Message-State: AOJu0YxIgfLnOCH5/4Jer8AcARcjf2x59HL/p2HLNIQtMru27h6EYFb2
 WQWlJXrfjPyJRkHi0RDZdISJFPHE7r3IwJqvGAWf1W0AcItiyW3NcrWgq1IjTnU8sK0dZaS23Ep
 p1p5PJFpKeb0ABReW/DSw9NfWfKPchW3J+/WseTyHe3QTfqaDat8uCnUWcjzCNkTUOohFxtvf2k
 G3itq/wd2ghBBph7shJ/DmYFVhAtpwuAZRl9OY4Q==
X-Gm-Gg: ASbGncsHhb0k9a1KjMtMa2poCmq1Q/otXoYRjLWYj1XE0ev5dnSESUi1gc2Rcvb/SxD
 MxKTVWJ/ztiUR8/P7eSqpquUthDblozkK5mmd7Pz4aOdaGuh88ejHR/E6QZMwgIyyoW0Jo4PbWL
 GqvzwTX8glWBUoY1eQLF5pKwtNDyEHWMfJLzWzT/I6ixQduA1ES5OsG3j0DuFCMOMBD4sDStE4R
 7MWfvSwLmUAHDVgq1gE9UYc7iaXmJS23ZdmVsvikel+6rG2YsrDQfFeMKYlJXrY+gM7TgaHbqCF
 mt3DAPX5ArYzwYgLTRBENarabht0lZRjxhlIsPdj60Ji+DPDgzdCHLL1Cq52I2V0
X-Received: by 2002:a05:620a:223b:b0:8ad:32ae:b6d9 with SMTP id
 af79cd13be357-8b10d0aaad9mr91834285a.44.1762204020023; 
 Mon, 03 Nov 2025 13:07:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSt6jqX3VOkDQDVSy1XqQH77EyuDFlDXC8AkYBS4nKl9NGoi+NWYfhbee9a508f4m2rHcpNw==
X-Received: by 2002:a05:620a:223b:b0:8ad:32ae:b6d9 with SMTP id
 af79cd13be357-8b10d0aaad9mr91829185a.44.1762204019397; 
 Mon, 03 Nov 2025 13:06:59 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:58 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 21/36] io: Add qio_channel_wait_cond() helper
Date: Mon,  3 Nov 2025 16:06:10 -0500
Message-ID: <20251103210625.3689448-22-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Add the helper to wait for QIO channel's IO availability in any
context (coroutine, or non-coroutine).  Use it tree-wide for three
occurences.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251022192612.2737648-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h  | 15 +++++++++++++++
 io/channel.c          | 21 +++++++++++----------
 migration/qemu-file.c |  6 +-----
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 0f25ae0069..d6d5bf2b5f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -871,6 +871,21 @@ void qio_channel_wake_read(QIOChannel *ioc);
 void qio_channel_wait(QIOChannel *ioc,
                       GIOCondition condition);
 
+/**
+ * qio_channel_wait_cond:
+ * @ioc: the channel object
+ * @condition: the I/O condition to wait for
+ *
+ * Block execution from the current thread until
+ * the condition indicated by @condition becomes
+ * available.
+ *
+ * This will work with/without a coroutine context, by automatically select
+ * the proper API to wait.
+ */
+void qio_channel_wait_cond(QIOChannel *ioc,
+                           GIOCondition condition);
+
 /**
  * qio_channel_set_aio_fd_handler:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 852e684938..b18fc346ff 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -159,11 +159,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
         len = qio_channel_readv_full(ioc, local_iov, nlocal_iov, local_fds,
                                      local_nfds, flags, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(ioc, G_IO_IN);
-            } else {
-                qio_channel_wait(ioc, G_IO_IN);
-            }
+            qio_channel_wait_cond(ioc, G_IO_IN);
             continue;
         }
 
@@ -268,11 +264,7 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
                                             nfds, flags, errp);
 
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(ioc, G_IO_OUT);
-            } else {
-                qio_channel_wait(ioc, G_IO_OUT);
-            }
+            qio_channel_wait_cond(ioc, G_IO_OUT);
             continue;
         }
         if (len < 0) {
@@ -774,6 +766,15 @@ void qio_channel_wait(QIOChannel *ioc,
     g_main_context_unref(ctxt);
 }
 
+void qio_channel_wait_cond(QIOChannel *ioc,
+                           GIOCondition condition)
+{
+    if (qemu_in_coroutine()) {
+        qio_channel_yield(ioc, condition);
+    } else {
+        qio_channel_wait(ioc, condition);
+    }
+}
 
 static void qio_channel_finalize(Object *obj)
 {
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2d4ce174a5..4b5a409a80 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -343,11 +343,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
                                      QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING,
                                      &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(f->ioc, G_IO_IN);
-            } else {
-                qio_channel_wait(f->ioc, G_IO_IN);
-            }
+            qio_channel_wait_cond(f->ioc, G_IO_IN);
         }
     } while (len == QIO_CHANNEL_ERR_BLOCK);
 
-- 
2.50.1


