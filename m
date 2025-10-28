Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C1ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmew-0008UG-Az; Tue, 28 Oct 2025 12:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeb-0008Ep-Gw
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeU-0003kl-Kq
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0JjoR5QFLg5Ya/8VWQa0jjW4vk8Vly+iRXL6VOjsbk=;
 b=EH5VgDJ/Sb2TA7wZmGC5Q2SwpHtEVfU3lRfqHfUsiXfJvepqZqxSctSp+CUMOCpjCPaUWF
 8qSJ4YL6OROQmsurgdocdRp8gIFi8cbzo9v1PffmEcNSw9uDweD9a5o6TT5NOm/m0sx2/0
 kUhMhVylVoko6TggWN96mqIOFIe3yGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-H43xj-ftN-KbUvqBrq4-vg-1; Tue, 28 Oct 2025 12:34:25 -0400
X-MC-Unique: H43xj-ftN-KbUvqBrq4-vg-1
X-Mimecast-MFC-AGG-ID: H43xj-ftN-KbUvqBrq4-vg_1761669263
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-471001b980eso39603195e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669262; x=1762274062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0JjoR5QFLg5Ya/8VWQa0jjW4vk8Vly+iRXL6VOjsbk=;
 b=o8aJLsSQAmnyldB6utGvJ7Y0AuGAmRE09ToqXv7KlHmnXz5o2Mhvj57Q/pILkfIvFb
 PLedrG34/x/fD5VA9r3Ttj+22CkGR5dakR+jqzW/0cNtwHECv+/Bmz7uNS9i/Nq1YXLY
 qU4AR5De0b9G5q9xqi58OkgplwD1H92Qh2gZ/CrKNGVOPFB15vDCn7kcSOxKv0P0QFjd
 tmXQmqS7GeQSOkJtqxOzHnWMwcCIKdKw9/A3Wzmc/G36I+nMVxCamqAEvT44fh3FZDtf
 J5UnoT/kAKviaPX4d8kXx9Yjnpn7uiJoT/pwUocUdDEs8/JFE7mk27iSVaT8mJHX7Qe4
 8CGA==
X-Gm-Message-State: AOJu0YwR88L5YMkvcbOcrh+1anhevg9xO9hshhRKINm2IIjwMkDf1jht
 gXYjm4wQ7Zw3YGiF01q/lU1+/UJ+jHvXmDMAffYZ5ho6OW1xQwkRppCq83KQPnA5cI7/B9xm2NL
 5RHOddzA9zG/F6oQmKoUwdWxJbzUAkPpBcZW3Xuhp8hhn/Zk6dWX8bMmH
X-Gm-Gg: ASbGncsYjdFcwaA3yehcDFHonQ048rFKjBVvEw5JSioUGISWCBrEtLB5eqY8dPnc1wx
 naZw9CKd7SVS8JjCq/+7bxNch3yOT6EQzmpc3NVTgkPVxQYN8FZFdhdHZKaxNHce0tyscMgl6Z6
 FpB6uYrC5MfyLYvEIFyXLZ83xrvmVsdOT/fStS86ambtemxqc/f1JsA6ZNPzT5w9AZy+yIy9eqb
 5AgjoxRWsBK+nmPHjM0SRJMnexeQikUjNjAyT9TXbOu33xTKDtgQiLB3xejkwrFh+aWALme7xT5
 0c7AKzGh8Ld4BzWPj0zTaS3KL9fZoQOYVefH90yARbqyacU1ZXRqOlrhzFoh5pR0HFt0+zGh3KX
 4CzF4a5VYUNGcoccXF55qazXOrF3ZMukdbFWldWQ1iwz//WbZyOreSWyGsA==
X-Received: by 2002:a05:600c:4683:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-4771e3aca51mr69955e9.30.1761669262500; 
 Tue, 28 Oct 2025 09:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFsYdEGDyF3r0kYMxsuNQaA3yRv1rRLBfSmdZvKVr5ZxxBBxUOp0Nd2SX0UlHsrbEZGprzyA==
X-Received: by 2002:a05:600c:4683:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-4771e3aca51mr69685e9.30.1761669262053; 
 Tue, 28 Oct 2025 09:34:22 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3ace25sm38805e9.9.2025.10.28.09.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:20 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 11/16] ssh: Run restart_coroutine in current AioContext
Date: Tue, 28 Oct 2025 17:33:37 +0100
Message-ID: <20251028163343.116249-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

restart_coroutine() is attached as an FD handler just to wake the
current coroutine after yielding.  It makes most sense to attach it to
the current (request) AioContext instead of the BDS main context.  This
way, the coroutine can be entered directly from the BH instead of having
yet another indirection through AioContext.co_schedule_bh.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/ssh.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 70fe7cf86e..bdec94e9e9 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1010,19 +1010,18 @@ static int ssh_has_zero_init(BlockDriverState *bs)
 }
 
 typedef struct BDRVSSHRestart {
-    BlockDriverState *bs;
+    BDRVSSHState *s;
     Coroutine *co;
 } BDRVSSHRestart;
 
 static void restart_coroutine(void *opaque)
 {
     BDRVSSHRestart *restart = opaque;
-    BlockDriverState *bs = restart->bs;
-    BDRVSSHState *s = bs->opaque;
-    AioContext *ctx = bdrv_get_aio_context(bs);
+    BDRVSSHState *s = restart->s;
 
     trace_ssh_restart_coroutine(restart->co);
-    aio_set_fd_handler(ctx, s->sock, NULL, NULL, NULL, NULL, NULL);
+    aio_set_fd_handler(qemu_get_current_aio_context(), s->sock,
+                       NULL, NULL, NULL, NULL, NULL);
 
     aio_co_wake(restart->co);
 }
@@ -1031,12 +1030,13 @@ static void restart_coroutine(void *opaque)
  * handlers are set up so that we'll be rescheduled when there is an
  * interesting event on the socket.
  */
-static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
+static coroutine_fn void co_yield(BDRVSSHState *s)
 {
     int r;
     IOHandler *rd_handler = NULL, *wr_handler = NULL;
+    AioContext *ctx = qemu_get_current_aio_context();
     BDRVSSHRestart restart = {
-        .bs = bs,
+        .s = s,
         .co = qemu_coroutine_self()
     };
 
@@ -1051,7 +1051,7 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
 
     trace_ssh_co_yield(s->sock, rd_handler, wr_handler);
 
-    aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
+    aio_set_fd_handler(ctx, s->sock,
                        rd_handler, wr_handler, NULL, NULL, &restart);
     qemu_coroutine_yield();
     trace_ssh_co_yield_back(s->sock);
@@ -1093,7 +1093,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
         trace_ssh_read_return(r, sftp_get_error(s->sftp));
 
         if (r == SSH_AGAIN) {
-            co_yield(s, bs);
+            co_yield(s);
             goto again;
         }
         if (r == SSH_EOF || (r == 0 && sftp_get_error(s->sftp) == SSH_FX_EOF)) {
@@ -1168,7 +1168,7 @@ static coroutine_fn int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
         trace_ssh_write_return(r, sftp_get_error(s->sftp));
 
         if (r == SSH_AGAIN) {
-            co_yield(s, bs);
+            co_yield(s);
             goto again;
         }
         if (r < 0) {
@@ -1233,7 +1233,7 @@ static coroutine_fn int ssh_flush(BDRVSSHState *s, BlockDriverState *bs)
  again:
     r = sftp_fsync(s->sftp_handle);
     if (r == SSH_AGAIN) {
-        co_yield(s, bs);
+        co_yield(s);
         goto again;
     }
     if (r < 0) {
-- 
2.51.0


