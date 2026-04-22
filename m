Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872D5FA1FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaBn-0000RC-0u; Wed, 22 Apr 2026 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFaBf-0000QT-IY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:12:27 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFaBd-0005PU-6X
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:12:26 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so3488787a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776874342; x=1777479142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIJNbJLFgEq2pH+htk4KgGE3k73wrk86Zv/GANULP9Q=;
 b=P79YSlRJ/M//wX5J0PRzWet9Y7difIEHeZdsRX1clD8R1iCtPaDpWbJT7sOIYpWiLy
 686VStkMIHPkocCwcNk0zWDLeuvI/lcS5jPeequsev35hSeGNWGWBqZSUj05Z1VjkMJC
 yd0XA06QZ5ZkNz8Dw2it+wzDz/LFIjeYb6a2ywZsn8b61AemLpncfYpN4V49HaxpbzcE
 eAmFkhL3+IEJu90BZsjK+KAaDUHrfcEfQGpNZMBfFGRtWkcfxNefXuCg1O7R9TOVeMCu
 XnzEj5zlqz6QWpNing+ubZ+AFczGE8A9LhlB452ViYGmlLdtF8HUjNKgM+ZY0A5reJme
 GbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776874342; x=1777479142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIJNbJLFgEq2pH+htk4KgGE3k73wrk86Zv/GANULP9Q=;
 b=LwmG0hGD2YIv+a+tGjEiDEbiPu6Xzp/NT0jz4pPpRwQb6j2aryWTHDL8kVns/T5IOm
 A3/QLw/kOu8v7c9fj7GBbFRnMsic2eigWWWx9L+MEqj7WIXgNC2lW89wurBkFFyb8WfE
 sEq/y+aAkNfwTVn6oYw5/3agN3E2TPVSEDhNW27b5/pHvgadi5RkmLHZJy6xQwIKWHaH
 RdZDl2bXjSeP65oJT8shCd5EGkrij1+MZ1ydBz+fM1OBn0ZfezY10xaDPlzcGCmnEo6a
 Z50PiShdN8sCN3mEN2HxtlF3NFgSSzqgPiQ+VY3D5csERS3nbqhTL1VBoQLcuVk9b+6y
 HM0w==
X-Gm-Message-State: AOJu0YxrIcOzxHEU5y7qs8u7jGIWp46BmPMeX6B2hBoWKPgVBolkk10/
 pexH2HZOGiEsJxSV0/p4IBamDykYJeqWfic93BxnoA4471+95Fw9t9Q1q+PI5g==
X-Gm-Gg: AeBDieuXAGJkysjo3eHfzgF80dPP4MVcO+MW2A7xd9G1E1GsBrQjCztPGWuowBa1yyE
 us7o0GbCk5Yj+AxLjl2nwdrS7GocjOpbFggvL13rGW5EEuHs1MhX70cTyaNXoVJYdD81Ciimx3y
 Yq8Zs6JiIOiEmJX7lBWnMrtQkzoL5XONTO5js5vDF578642vlotLo2/VvWyWKs9rvKxmnvxDY3j
 mDeRv0jVxRmpBOf6DkicxCl6WpISqQjdQ5LzCfRTCoSI6yaCUbHMLfg6CmVpGLUg3JaknPNYG5t
 T/KbwZ6gfLCJCWmij5GkcWNEiGybUdLRzkMa09TXBC1pZoNtPZlbjWlBqBEIUybswdJebSpysTb
 RuNHU//gEl9EEQgZQJYu5bHGoD31c0ErrxrFhSL71e0h0tUsrktQ6uxGJacmjs/3j7WfXwaz+tX
 VfG3DsXY6j1zMxqOi7hzm1x8c76mW+OyDU7ZQp2EmgR3PDaNcMqw/LUmrlMxS8j/UY6T9W
X-Received: by 2002:a05:6a21:e098:b0:3a1:d516:36f0 with SMTP id
 adf61e73a8af0-3a1d5163ab4mr17460252637.36.1776874342211; 
 Wed, 22 Apr 2026 09:12:22 -0700 (PDT)
Received: from localhost.localdomain ([42.114.219.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm16558138b3a.13.2026.04.22.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:12:21 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
Date: Wed, 22 Apr 2026 23:12:02 +0700
Message-ID: <20260422161202.34150-2-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422161202.34150-1-viking4@gmail.com>
References: <20260422161202.34150-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

When a multifd migration is cancelled and the user changes
multifd-channels via QMP before cleanup completes, the shutdown and
termination loops re-read migrate_multifd_channels() which now returns
the new value. This causes the loops to iterate over, for instance
fewer channels than were created, leaving yank functions of the
abandoned channels still registered when yank_unregister_instance()
is called, triggering an abort:
  qemu-system-x86_64: ../util/yank.c:107: yank_unregister_instance:
  Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
  Aborted (core dumped)

Fix by storing the channel count at setup time and using that frozen
value in all subsequent loops. The live parameter
migrate_multifd_channels() is now only read once during setup, ensuring
teardown always operates on the exact set of channels that were created.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/multifd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 035cb70f7b..69c8f6747b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -75,6 +75,8 @@ struct {
     int exiting;
     /* multifd ops */
     const MultiFDMethods *ops;
+    /* number of channels created (fixed at setup) */
+    int channel_num;
 } *multifd_send_state;
 
 struct {
@@ -483,7 +485,7 @@ static void multifd_send_terminate_threads(void)
      * Firstly, kick all threads out; no matter whether they are just idle,
      * or blocked in an IO system call.
      */
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < multifd_send_state->channel_num; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_sem_post(&p->sem);
@@ -495,7 +497,7 @@ static void multifd_send_terminate_threads(void)
     /*
      * Finally recycle all the threads.
      */
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < multifd_send_state->channel_num; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (p->tls_thread_created) {
@@ -577,7 +579,7 @@ void multifd_send_shutdown(void)
 
     multifd_send_terminate_threads();
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < multifd_send_state->channel_num; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
 
@@ -615,7 +617,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
 
     flush_zero_copy = migrate_zero_copy_send();
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < multifd_send_state->channel_num; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
@@ -632,7 +634,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
         qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < multifd_send_state->channel_num; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
@@ -926,6 +928,7 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
+    multifd_send_state->channel_num = thread_count;
     qemu_mutex_init(&multifd_send_state->multifd_send_mutex);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
-- 
2.43.0


