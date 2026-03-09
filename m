Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF9F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEk-0000t5-NK; Mon, 09 Mar 2026 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEj-0000sN-Ko
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEi-0008NX-5k
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=cSjpR5YT53tT0T4RVWi/GPDjzvwZZMtXREbX40Cpq4cPwfln4mRWZbvlYY65Qx4kodoJSm
 ZSmOAYs6tnGQ6XnuDWg8ApK6LQ5lXh8gFuRzzHvKk+iXT7promK5MWYOEVq+CspNgTCGdk
 0yBvUkN1CAPZEVzMAPIFE+q7sVWgQNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-m9fzkmZONp6jbylB1WExnQ-1; Mon, 09 Mar 2026 11:09:34 -0400
X-MC-Unique: m9fzkmZONp6jbylB1WExnQ-1
X-Mimecast-MFC-AGG-ID: m9fzkmZONp6jbylB1WExnQ_1773068973
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso138889525e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068973; x=1773673773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=AS0WBVDWJDL8uBkiWaDVuGXwk6J09GKnnFqaKxB6M6fMuOYccsEc720/SSzHnY983V
 TC6AiDPBhIh19g8EZ5N1Qswy80f9ac1qCjpqot5DxCD25PKk2UO5ZzOPmABmu9f0t6lr
 7t8MY3yAwB5tXSoR675Xo8s9EQZZ+Xhu/sT3BogPfINy9v48E21vv3sF+Q6Agqdp6sqd
 RrxzjddOqVITKqJSXexH1N5sp37XCKqbQBVph/MJa1bxqBLPBGESC5RPqb63ZJIvTfs7
 z1gH8Vi+roG/1J5XkspmZmOlkJTqzgHpKxpVWP8G0LnjkPQKlYJMPp8E475Lsmq687H4
 e3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068973; x=1773673773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=KkNtbjjB6N1Bd/BAaH0F6ZZF2UtkBBKdbqkXVtP6IGSoNvEr6nH+5umFv+3wgqcJO2
 VzM8uK2SlWjiPZsUyiKHEIXleTll3W/UVf/SXxvtzXGdeNe8EodJQ2wPWe0/x2qBZiDs
 OqRZNNQ0fUhzhxQcUdzwj22v6kZ7e+h3kAk9ovUS1nCwHSrp2riJXCjd6F6VuzFAgXEJ
 3Zw/QKIHlf50dPrpJPh5TjJMnaiq7HBs2P+E+zvXwsMbGOUa4ReJtZXqO6RNc+ANd8N/
 xDcq5LSmnG08SV3YMDu5zW/b+vyeShSBaUzWclMmwdtUUWZHZr2YwIDKPDEp3/5tPbDI
 01WA==
X-Gm-Message-State: AOJu0YyT0D9LOpq84A4kFJ8PwLYV1a59/l15uAgsdCVSDYXWBDrGN06+
 QFK4au+DUvE0Iw8txok9Tdo4MfCCaPqg412w7kX4iC6cHMToOHc5iwTwDhFju8Z+XtQ15tRRj0r
 /Q6Ms+8tSwHTFgglL0P/hADOkDNAEm8vbQKCAAsTw71OpWSg/3MPE+M1/
X-Gm-Gg: ATEYQzwdpi+fHRoUhW5FXSYcg4y82kwFuyi0naoVkAUH3nzoFdMgyHCuxjwYWUgg0Ar
 CqQvfKW/y4tyQJeiMCv1HvEUdaevIa7rmWvEDRjgAgUphZeO5/GrFRz1rR9l0CEa/yktqDZSdH7
 lqK0a4GFOcU4wedDTchAlh8KbQYnpg14mUTfvhtb+t9qTOY6xXGAvNfV2FSlQ7rivtFZyAsVV++
 0rgxagCDz1hXNYq8ZkKW5V/wc015NHcrLXaOBrJxU74uDW+YviXo3E1R9XbpU5OZaVwfVHetn5V
 wyop83avAJw5KPvrpjp8j0y059B92mY6b8JXZwD7NyfeePhPHUtGg6Y0aLYaARChlWfb4A7G01o
 j0Mg5DaH/PYVDSgTqoHNU08yapiFuYDt3X8x5WPGeZ/wd5LRAkskojatsHUZhalW2juqNrWSCF/
 3YCI6n
X-Received: by 2002:a05:600c:8219:b0:485:2fd9:3d4a with SMTP id
 5b1f17b1804b1-4852fd94025mr124078925e9.22.1773068972965; 
 Mon, 09 Mar 2026 08:09:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8219:b0:485:2fd9:3d4a with SMTP id
 5b1f17b1804b1-4852fd94025mr124078275e9.22.1773068972488; 
 Mon, 09 Mar 2026 08:09:32 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853c784813sm63858295e9.5.2026.03.09.08.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 11/25] fuse: Add halted flag
Date: Mon,  9 Mar 2026 16:08:42 +0100
Message-ID: <20260309150856.26800-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a flag that we will want when processing FUSE requests
ourselves: When the kernel sends us e.g. a truncated request (i.e. we
receive less data than the request's indicated length), we cannot rely
on subsequent data to be valid.  Then, we are going to set this flag,
halting all FUSE request processing.

We plan to only use this flag in cases that would effectively be kernel
bugs.

While not necessary yet, access the flag atomically so that it will be
safe to use once we introduce multi-threading.

(Right now, the flag is unused because libfuse still does our request
processing.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index fc75a5e74d..f6a5f4fa0a 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -53,6 +53,13 @@ typedef struct FuseExport {
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Set when there was an unrecoverable error and no requests should be read
+     * from the device anymore (basically only in case of something we would
+     * consider a kernel bug).  Access atomically.
+     */
+    bool halted;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -69,6 +76,7 @@ static const struct fuse_lowlevel_ops fuse_ops;
 
 static void fuse_export_shutdown(BlockExport *exp);
 static void fuse_export_delete(BlockExport *exp);
+static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
 
 static void init_exports_table(void);
 
@@ -99,6 +107,10 @@ static void fuse_dec_in_flight(FuseExport *exp)
 
 static void fuse_attach_handlers(FuseExport *exp)
 {
+    if (qatomic_read(&exp->halted)) {
+        return;
+    }
+
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        read_from_fuse_export, NULL, NULL, NULL, exp);
@@ -322,6 +334,10 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
+    if (unlikely(qatomic_read(&exp->halted))) {
+        return;
+    }
+
     fuse_inc_in_flight(exp);
 
     do {
@@ -380,6 +396,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
     g_free(exp->mountpoint);
 }
 
+/**
+ * Halt the export: Detach FD handlers, and set exp->halted to true, preventing
+ * fuse_attach_handlers() from re-attaching them, therefore stopping all further
+ * request processing.
+ *
+ * Call this function when an unrecoverable error happens that makes processing
+ * all future requests unreliable.
+ */
+static void fuse_export_halt(FuseExport *exp)
+{
+    qatomic_set(&exp->halted, true);
+    fuse_detach_handlers(exp);
+}
+
 /**
  * Check whether @path points to a regular file.  If not, put an
  * appropriate message into *errp.
-- 
2.53.0


