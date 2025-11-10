Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF6CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9r-00083D-Ru; Mon, 10 Nov 2025 10:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9Q-0007UU-Ur
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9P-00013k-3W
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiQZc0S9otfidhonOxKcoAmt4++DcUiIFzKq2jBQlWQ=;
 b=iU77v+h+1hUantpkLxgMhGD44u/pt3W+x4EM1pYNsNviYY3hz39lB/rQTi2UbOX1WdyRak
 exwj+jeilXjGk/49zZecwJsGmLZDKSgwTdSe3CHtsp2zvRGLHNZxHeHvp7yG4XvehzQDIW
 RVlfRSVrhtfMr0GMtKkb+xuucbXvVeI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Kjf5PYBsN3SckTZPtoZ9yQ-1; Mon, 10 Nov 2025 10:49:47 -0500
X-MC-Unique: Kjf5PYBsN3SckTZPtoZ9yQ-1
X-Mimecast-MFC-AGG-ID: Kjf5PYBsN3SckTZPtoZ9yQ_1762789786
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c5c8ae3bso2582243f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789786; x=1763394586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XiQZc0S9otfidhonOxKcoAmt4++DcUiIFzKq2jBQlWQ=;
 b=sKjDxjSBo3zz4tKNStwI1kzcv9S7UKvAaCZu09aAcOMu6fP0CZh/YQLDP+LViqMNFr
 EBTxWlCWZYP82b8XZO6g9ET1b2Xg81CZiAjLjAjjQsVqqJmhsj18cG0LolK82RJjxjr/
 0vFi8WOnN+HPh+/kokUPXg6ugR1MjMBvP9qK2r/JPgciz7TrTysWoA4YTxSBYVU+TVtY
 LjHlA4htV4rKCo1WZXPhoagxXoIbqFTzoJdGlmkleOGUwaUlumhOkSyEuZFcnhr2SRqv
 HoLYbJRa02dc3RkL2rW1bWhhEEoe+MUfv/otzqx5SsONn3j/LtrMnjV7lbihHBoNObzF
 pNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789786; x=1763394586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XiQZc0S9otfidhonOxKcoAmt4++DcUiIFzKq2jBQlWQ=;
 b=wEJ/WHo698+tYl8Nq3rpan5p1dKjoZ9GC/srVL79t0t8QQmlWl5k19xdynr3gJ2+ru
 TwKKj4m690oInBqEKaZRbzX7i2cVDz1fjEzD1wTx1289d8dVc+XigkrvkPL8tFeedQrR
 6LlVuiKoYsztR4JS73OJMswdghu/+ew5GBzUK2vVzdKaD/zy5oe7O8/gX7J1Ra27f8g7
 M/ybPa65KFkdOwhrnHoXGarw2goY+ALbFgo1r5VqjIUo8PRWwVooVKtqQdZtZc8Hydq3
 D7WwNa3J2YF45/1gazZv8bnZpfwv+Id+2Ck+Xelho6xxU2uoEHmAbEJP43zX9eKOjb4Q
 zkAw==
X-Gm-Message-State: AOJu0Yx09VskjYZhqGT0RGc9RUnfvBwJAZgHw1IhVSQ5Zxg4NaRq+6Ys
 kobkmPLLWCGT7hCEJm9FOmZMJSZoTwOeOPee6EyT04zgWlGfS5GioJrHXhPHmdED1RcfPtOOvWW
 oAQ5ucDyDtvpalQkh8KIY+vQSC3jJalt9TqjPVk59gCwfQltFBn/JiBPP
X-Gm-Gg: ASbGncup7zgNurM24vvFYGwNobkOnvy7WRM2XDJhrWygAe28qkSd81C9dHs79ZGLnRs
 pldovicNRe0r1oHw1GazSSjYKNFS6crP2jAA+v3+cno6LE9x4/WufuPuS6/xfeX3B9Y8I3J2Oei
 DVoTG3udbVusLAQ5wpnXPUW5CMXrI6OyvDL983xnhwcTm38rT1It5ZkBKi43pH68xCMlZewlTEc
 OkUUepQctM3QC8f66At7elRteEcqFA5lDUCCF0TlFOjQXjYgBLLovP3lRxyM6WlNKz85S2JXReU
 9CHDjykET5Wo0glH1E3AR4OsLPSSp5+4Hngw4KqWbd+OceAx6bL5gEvNI+LQri5o/JV+eigqfLu
 rMjvZH/+ri35RRSuSPfEKiT2BOT22HQLso3stXbazPEJcXDuwKsIJHdJRWQ==
X-Received: by 2002:a05:6000:2d12:b0:42b:2c61:86f1 with SMTP id
 ffacd0b85a97d-42b2dc7f5c0mr5011767f8f.35.1762789786024; 
 Mon, 10 Nov 2025 07:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS5PIegtasFArTob8lo4VL4RLFJ3/lIFDozxlnGZSs+0oRoXTg6ZcFPcc6Tufm6dULhULW8g==
X-Received: by 2002:a05:6000:2d12:b0:42b:2c61:86f1 with SMTP id
 ffacd0b85a97d-42b2dc7f5c0mr5011745f8f.35.1762789785617; 
 Mon, 10 Nov 2025 07:49:45 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b303386f1sm14433781f8f.3.2025.11.10.07.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:43 -0800 (PST)
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
Subject: [PATCH v2 14/19] ssh: Run restart_coroutine in current AioContext
Date: Mon, 10 Nov 2025 16:48:49 +0100
Message-ID: <20251110154854.151484-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.51.1


