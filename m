Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF9CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENCu-0001es-Cq; Wed, 07 Oct 2026 04:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIjY-0006lN-AF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIjM-0003BI-6D
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791345243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=WEwuTwhQ4ByrUV3o/R5M765SvhV9yQNXiSGOvEgeWD6w9o3+NQsNR+5OFf4hHVIfmbvyIE
 hpVaO/6UHY5MJl/9mtj5EajTJAiVAy7TFVbNE2spyzOaB3j9Gk8KxQ0OJJyzw8xyUfumvq
 crhGLhcJj/WXHF5L34x7cJS++fCK/Ig=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-bp19xN5IOCm6Z6Xauof5vg-1; Tue, 06 Oct 2026 14:20:53 -0400
X-MC-Unique: bp19xN5IOCm6Z6Xauof5vg-1
X-Mimecast-MFC-AGG-ID: bp19xN5IOCm6Z6Xauof5vg_1791310853
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so55198341cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310853; x=1791915653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=eb7X5PgthJtPt9H2G5hu5nLqD1uZvEdQWEqi4ZTzRDOAe19vKqkC8P99UysCaSOboM
 v5cGv+g2gvbLZv65ad2BC0mqFvLQ3HlS5HEi3XNN5Qx3ou1L/WLue7hofmiLeF9aueex
 zzo5g3KFUKshTugF9e8caSoWzl2EEQ87HIyIf9/TCqG9JMA1M4JhidykMJG6Ob3uSJ71
 jm1UGGB7XyZAs7pU9cI8LxbSoX+vCH4RcqZSfhudnCInjChuQ8PHSz4fX8dyzLk5Ixdo
 DEnms05jm4JPLSmgY1qC7EI65JyTxwLJFHyoPhSETp0vYIeQKhtRuutgoYvtwhJnqnOI
 SckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310853; x=1791915653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=Io0wzZHqIfooL6lxtP7f4c9qFV586Mg3nEjZdyat2XIX/B/TWcRdJ1j2KHSUq2Rqve
 vIHYmcZPF6I6Ej0RjQlmIM+AWZYOZh3IrO2LzaWRDqm05MKaJlKIlZ/5OfgYQE4ztfnh
 xBzjzEV7taP1Ejew8MzQ0yrzJwK3XPAQaJSL5LwHWe/JF9Y3yKnw1EQxKgahh5yFLyH1
 XQx+/Jj1OHik+XcwxQGYhaQZHfKsWPvrqIwgOfWmMG1uI8IijiIB7cAliRuyiAxbM0uu
 KmbaqyCoYemQG4H1V24LawPxg7R5ANbPHWT1fDnaFqUj1S4stvKNyNihbksk/TQALwUl
 EGQg==
X-Gm-Message-State: AFuF++kY9C4Xv14vidW6zVEfbIbEv5426dMG1IbOI/RVRVyYP/jp/b+c
 /eToY8XMwQcksSH/9AccPwZE3xbj6peLMVuwOlYrco7Oa4YdqZAZCjdAzb8IAZA033H0dPgr76N
 vH4qBPDVv0Jau9+K8rBts4BEQ1FFoxN3gd6mvSmgxn7V5PBzjd8DGOoVp0fFDq6cxvNP/8/C0i0
 QIxIfkPDYjoacobOV0jxE54MbXEhN9HSKD986LKQ==
X-Gm-Gg: AYBFou3NSlz2HeNl1eHEHyhj99oRy1tdhmB++/+GJMys7qT/OGEVMVueQky1aPp9BEj
 mkLm7N3FMZJ+3BUqrNc7ZzYbprSrBW7dIoAR91wRBX6xgWnMBAYcDJ7+oSWjiScc3S34ZF3ao0o
 AgApoDhm1MnzLbAqiL7VfLcJZ2LwoOK6+ufG+aqk3VFtQQDLBHU94WII68RXXIvj+jgkYFdnD5d
 feogTmt6kFP7DBSDyFm5C9j3BxLja2LWyrNWs7i53tQOzaflyWnRhMxiowR6VYfoR90hyPz6am2
 SHm0dCwbwxFCgb0WmNZEtiU48fQ/n+2vwsM+H61IEF252B/qB5ccrbFYJhdg66zcJOl8hJ0=
X-Received: by 2002:a05:622a:6f12:10b0:535:70c4:9a92 with SMTP id
 d75a77b69052e-53570c49d02mr9959391cf.72.1791310852815; 
 Tue, 06 Oct 2026 11:20:52 -0700 (PDT)
X-Received: by 2002:a05:622a:6f12:10b0:535:70c4:9a92 with SMTP id
 d75a77b69052e-53570c49d02mr9958911cf.72.1791310852225; 
 Tue, 06 Oct 2026 11:20:52 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53571f19a98sm1962751cf.3.2026.10.06.11.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/7] migration: Fix socket listen backlog
Date: Tue,  6 Oct 2026 14:20:42 -0400
Message-ID: <20261006182046.3767283-4-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU incoming side may have set a wrong listen() backlog.  After the
support of multifd + postcopy now we have four possibilities on setting the
backlog, some of them are wrong:

  Vanilla:            1 (correct)
  Multifd:            N (wrong, should be N+1)
  Preempt:            2 (correct)
  Multifd+Preempt:    N (wrong, should be N+2)

No real report for this, found by code observation only.  Logically the
backlog (pending accept requests on destination on the listening sockets)
needs to be the maximum of possible channels.  Otherwise if the accept
queue full on destination, source QEMU may hit connection errors.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Fixes: 0705e56496 ("multifd: Use number of channels as listen backlog")
Fixes: e274188612 ("migration: enable multifd and postcopy together")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index f57f1a8e7c..31bfa1eeeb 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -139,21 +139,32 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
+static int socket_get_max_channels(void)
+{
+    /* The main channel is always wanted */
+    int num = 1;
+
+    if (migrate_multifd()) {
+        num += migrate_multifd_channels();
+    }
+
+    if (migrate_postcopy_preempt()) {
+        /* The preempt channel */
+        num += 1;
+    }
+
+    return num;
+}
+
 void socket_connect_incoming(SocketAddress *saddr, Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
     size_t i;
-    int num = 1;
+    int num = socket_get_max_channels();
 
     qio_net_listener_set_name(listener, "migration-socket-listener");
 
-    if (migrate_multifd()) {
-        num = migrate_multifd_channels();
-    } else if (migrate_postcopy_preempt()) {
-        num = RAM_CHANNEL_MAX;
-    }
-
     if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
         object_unref(OBJECT(listener));
         return;
-- 
2.55.0


