Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D5EE6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pt-0001u7-KM; Tue, 23 Dec 2025 09:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P1-00013S-JZ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oy-0003iu-Rx
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7Ft85ngIjHj7BTolKwSSNwqwExgehqFdfkFkCzmeBU=;
 b=EtB9TuuPqV0yS4ga29x9K8i+KE3o9YLJyTkdfvylH7esa2iKNAgnAITjHT+/U+ODV3Bh0y
 HzrdaT/+YEoe9c3eXTV1ABn+CuOxpV+PnlaSaIy8PM79uPWEk5YadfqJeLhaKfU78Cl+AM
 B9u4DCwl/1Hf6Z/N7BiBtlwsslIFNVc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-pJuxy8c8O--VT1dEK9YHSw-1; Tue, 23 Dec 2025 09:30:14 -0500
X-MC-Unique: pJuxy8c8O--VT1dEK9YHSw-1
X-Mimecast-MFC-AGG-ID: pJuxy8c8O--VT1dEK9YHSw_1766500214
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e41884a0so1308686485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500214; x=1767105014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7Ft85ngIjHj7BTolKwSSNwqwExgehqFdfkFkCzmeBU=;
 b=p+NwmaBzxsj9uWYK+M7w+2HRw2cbtLqmIB4I+bIEq9+QW4XROI4Gh8OWzNWIKTkVtv
 7CvzIQIK399JYzFvYXTpqpnUziUa/cCHwfR21M6OCogfF74tNYBWQ8NrjXwTR05CrVrA
 YrzrtuyNKAaz5Dv0vBCfe7Awi1HH94GkUTDoIq5s87NGZ/h8YDCynsgHb+pFh2Y/MhCO
 t0BZUMquBKGHAy9RxazHi57BnvHCexQCzuZeFSRtqqI7VI4NDoXfbAoVO7t48rFD2NKd
 iEQpih17byITtYlhbNpA3v12kt24SwMCjLA/aOMT8uvov034Uvtiw8d69dSlXXHbGB52
 DJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500214; x=1767105014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7Ft85ngIjHj7BTolKwSSNwqwExgehqFdfkFkCzmeBU=;
 b=WTCpIH2AlwxZcYj1birQWtuSAD8C/0A39rRYmBNiPDtp075XKhJcMLrCmBQyOC8zRQ
 Z9XVCJ1cTBMLaOKWJ7A+eDl6eLicTLFaM37TjsKqapeOgUTJeo8lNyculpZmyjQuBACD
 +altygBRFNCboFccURwvOH11TEaGxPbbOCS16WLvILvevONgK/YV6NDkG15zi8Dp26R/
 lq5zBaxFTvEsvq/jWw9+gavhShB1oT2HyK9UYJq82egdxL+Fiev5FA7nD9cqAOQxtjk7
 hVXu73x2laX+R4NOLHWLlbz/qbH3m/7DkDqo8uKDHrcMcIpH81wc738BuSa9PqeqiR8L
 dK+A==
X-Gm-Message-State: AOJu0YzJ5NxmYPzjzqeQt3sF+OzxqK9rgSqyZAOqdGX4B6N5AdGaJvpi
 oFm7vkHQrj38JTTF2dgR6I/KyyovkuBDVd6jnC9gD56LJDKkzO4rSU6n3+nj9O7+QiEAb2DGa9I
 3ednCBr+pjkxZi7IReZZrYixi9Vvp+l2nGTqf7kYuLbBwjSR9r7OdGsxq7R0Q9+Lr9lrPkejBD+
 aSpxKEi1UziBgaLRjKrYDycjGg3os+r6dtXkHPsw==
X-Gm-Gg: AY/fxX4rta0KdCupw5xQhFMYOphZMJEQ5dsG5WJbBBEvhBgm/eaPkh8361IUReR+9Fw
 ybOAfb2OAHNK611dWAxASF4rPuYj1eiVZy3R88VlO1dBompScoZ/wRBxAAatsukVYOE0T+TLKHD
 EZwhDh+b+gRcq61KGYDxPuwXfp0Lpu8BFmp7wUc6UlhQCEnwZer28C+n7rPj4HpcpmN18imww+x
 36lTVvQ236JLTr+MydSbDgo2ajDyf2bVtOJNln/yfaoH7pV7lF23dABi/VFd9GKS1Yc/Lbu0zRW
 obaSA6Fuo8Cu7TQRxrsgOxAwRS7aLKQW83tnRIn6HWRvVk75YBdlodMlkFWk6MtE1aLWZh6zdjD
 kcQ0=
X-Received: by 2002:a05:620a:404d:b0:8b0:f04c:9f0f with SMTP id
 af79cd13be357-8c08fd03911mr2494151885a.63.1766500213974; 
 Tue, 23 Dec 2025 06:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrxYtmNJGlCxe9xkOOTdk7a/mhL+td1G66SxoU4ex3OSiwVzzgDu1OCMaMzqUwYPvlvTs44g==
X-Received: by 2002:a05:620a:404d:b0:8b0:f04c:9f0f with SMTP id
 af79cd13be357-8c08fd03911mr2494141485a.63.1766500213341; 
 Tue, 23 Dec 2025 06:30:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/31] migration: Make multifd_send_set_error() own the error
Date: Tue, 23 Dec 2025 09:29:37 -0500
Message-ID: <20251223142959.1460293-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make multifd_send_set_error() take ownership of the error always.  Paving
way for making migrate_set_error() to take ownership.

When at it, rename it to multifd_send_error_propagate() to imply the
ownership transition following Error API's naming style.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3203dc98e1..651ea3d14b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -414,7 +414,7 @@ bool multifd_send(MultiFDSendData **send_data)
 }
 
 /* Multifd send side hit an error; remember it and prepare to quit */
-static void multifd_send_set_error(Error *err)
+static void multifd_send_error_propagate(Error *err)
 {
     /*
      * We don't want to exit each threads twice.  Depending on where
@@ -429,6 +429,7 @@ static void multifd_send_set_error(Error *err)
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
+        error_free(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -777,9 +778,8 @@ out:
     if (ret) {
         assert(local_err);
         trace_multifd_send_error(p->id);
-        multifd_send_set_error(local_err);
+        multifd_send_error_propagate(local_err);
         multifd_send_kick_main(p);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -901,14 +901,13 @@ out:
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_send_set_error(local_err);
+    multifd_send_error_propagate(local_err);
     /*
      * For error cases (TLS or non-TLS), IO channel is always freed here
      * rather than when cleanup multifd: since p->c is not set, multifd
      * cleanup code doesn't even know its existence.
      */
     object_unref(OBJECT(ioc));
-    error_free(local_err);
 }
 
 static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
-- 
2.50.1


