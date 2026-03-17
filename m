Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCA4FD8773
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Uk0-0007oi-Gi; Tue, 17 Mar 2026 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Ujw-0007m3-SE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Uju-0002B9-KF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773755139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmGIqL4wPaYFmnanozNn72U4g94lElsPqe9qyukakdI=;
 b=Nep4qmsZywoLbycOoZsxGg6WwDjZiDfBrt+PEQNcdHN1rYT6y+I46WhqNwqIHXRGVvyEAA
 dYHJpDqzZRTvvKV6n7zcGaB9lyJ+GZWu8YvpCXkgzQZ44CJysGA+cizSXoUzSQEPYjpT05
 kBhGUCWX0iSqF5BFy1Wy9dP4tMSCQY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-gASXCAACN1iqi9gRVxB6AQ-1; Tue, 17 Mar 2026 09:45:38 -0400
X-MC-Unique: gASXCAACN1iqi9gRVxB6AQ-1
X-Mimecast-MFC-AGG-ID: gASXCAACN1iqi9gRVxB6AQ_1773755137
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so6812395e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773755136; x=1774359936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmGIqL4wPaYFmnanozNn72U4g94lElsPqe9qyukakdI=;
 b=kQ6TKZJQgNVxYOtsiFwrSw7nddpEAawdtX5NsDSV5UCYhvahYegob/WNx4EubHKCug
 SZU/hUd/TvCkIT7eV0RhKkyor5xrknngPdinZqoBjX00CVIzetKaGH56LSXlENpq9buk
 BWOKvcm2tpcOa+HqLzHVXTz5z6UxlJdcqRMmpXjUlpwhYGyBh0wO2nQ/87+judJGLam7
 loDhEZExnhdWr+EHWKVIJkRGISXwY4GO/dl0qa3KTdlXk+dJ3KscnTIFkueWNmFnmazG
 Zk0TejcC2Lg/X5TK65zoDHV1IbsjqVcnxgyd9cD7QBa3At8jAuXHXdq+xhextDYoMwje
 UHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755136; x=1774359936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bmGIqL4wPaYFmnanozNn72U4g94lElsPqe9qyukakdI=;
 b=eOAjOqMtvlZ61zkCugGLiQBs5USM5kqmFcuE3DeEiJiV0IB9QGIijfCKyp8g/WBhSX
 TG2tpdvLjGj1yBk5PTHRhmg23DH8A2svYiwa6aE0K+u08yvUqH15pmhX5dh7Awjfx5fl
 x9Lc96hu7cNloSdY+VlxtRbD6GakePhH3/bz9X4O0hzgMNRtOXNXF0If7wIfxQ24R4Df
 NYiizJF4hAEBsvVONMPU0PRpK/YaG1i5ZUxJVHl8StbES/3lTUIyqTF+cwa7s0WTvrs6
 3CnW3tsk9MSc6jkl1CmoAipfb/OtvIayEFqngj9lqQlKqyZtR7wsMCpN3tI8rLGJgeLR
 /CkA==
X-Gm-Message-State: AOJu0YzBZxtc7t6nyVNanGV+11kfbqSenygm3f9n5/b/kDip8c5j7rLi
 Y4+96HzcioZ/9prqj7FHhadysZGwKb1qI6KQk8ptSRqgrkCfwe2Xb0kgBy1ipWUpEqsQuTsbNQ+
 6RQh24h+YkjAdSFqOzgliUGsrJA/25TP54b6RspyzrxlX9yyAnr1V9ow2f8h+a2o1
X-Gm-Gg: ATEYQzxZ8l+uY+GAFx7nOq0m6S/BwL6JD4lzQWW1PTwl+vBdyHI8N92eRY9Eo8aRUdq
 z+P9q3rhVsR2FSjm79F9gsUfgIlsPHsDA0uieZvdVYqNtpXGq7NYOB3CUwHf3DkOuYELKk2EkAo
 NFqgkmLE8GOxL/7BJz4bcdOVtXjMKTT/H8nVeyD3P3SK3kbH0PohlNEbeDcdmfbls7pHsvAgdBO
 AB3Sa8QMC0nAu4/4oqjQUp+qwHjcJYN5liuaoiLwfT2xmnaGxewcHFDu5Ej1ZzQ7e0eg/krSd4b
 Bz0oEUUpr3WwDSP+EXfXC2/V3dW5SCBhwvSVYVinNr1SIYZ6G7F9PBrqHsQW+VqZv01wN5xuXnj
 3krxXPOEuILF7lumBMLZDQ7sx5JEo90tFcNnmlFgvr8x2N+1VyJSc2LSzBQhh03TYEr5ukOPgLi
 Llx9Y=
X-Received: by 2002:a05:600c:8488:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-4856eadba01mr56975355e9.15.1773755136265; 
 Tue, 17 Mar 2026 06:45:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8488:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-4856eadba01mr56974815e9.15.1773755135749; 
 Tue, 17 Mar 2026 06:45:35 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0a83481d97604204561.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a8:3481:d976:420:4561])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563903bbsm193759595e9.0.2026.03.17.06.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:45:35 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 2/2] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
Date: Tue, 17 Mar 2026 14:45:21 +0100
Message-ID: <20260317134521.112121-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317134521.112121-1-hreitz@redhat.com>
References: <20260317134521.112121-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

If s->replace_blocker was already set by an earlier invocation of
mirror_complete(), then there will be an assertion failure when
error_setg() is called for it a second time. The bdrv_op_block_all()
and bdrv_ref() operations should only be done a single time too.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20260311145717.668492-2-f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/mirror.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index fa1d975eb9..2fcded9e93 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1276,23 +1276,25 @@ static void mirror_complete(Job *job, Error **errp)
         return;
     }
 
-    /* block all operations on to_replace bs */
-    if (s->replaces) {
-        s->to_replace = bdrv_find_node(s->replaces);
-        if (!s->to_replace) {
-            error_setg(errp, "Node name '%s' not found", s->replaces);
-            return;
+    if (!s->should_complete) {
+        /* block all operations on to_replace bs */
+        if (s->replaces) {
+            s->to_replace = bdrv_find_node(s->replaces);
+            if (!s->to_replace) {
+                error_setg(errp, "Node name '%s' not found", s->replaces);
+                return;
+            }
+
+            /* TODO Translate this into child freeze system. */
+            error_setg(&s->replace_blocker,
+                       "block device is in use by block-job-complete");
+            bdrv_op_block_all(s->to_replace, s->replace_blocker);
+            bdrv_ref(s->to_replace);
         }
 
-        /* TODO Translate this into child freeze system. */
-        error_setg(&s->replace_blocker,
-                   "block device is in use by block-job-complete");
-        bdrv_op_block_all(s->to_replace, s->replace_blocker);
-        bdrv_ref(s->to_replace);
+        s->should_complete = true;
     }
 
-    s->should_complete = true;
-
     /* If the job is paused, it will be re-entered when it is resumed */
     WITH_JOB_LOCK_GUARD() {
         if (!job->paused) {
-- 
2.53.0


