Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12312C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7es-0007Mz-55; Wed, 31 Jan 2024 05:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rV7eq-0007MI-Tx
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rV7ef-0002eo-14
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRMAebPlP0o5J+cwha+CSiFm52p5NZNrH4ZFcNtJLN4=;
 b=HidW1tLgzRH0FmXdOWV1YDIMssa15kv3WKN7iSpgDNY51tOM995Uh/XIR/v0jRFUoJelER
 f+A7yQOEaWmNktdKjHEZxQNpjLNa+FLDJiBNS35J//ZzBbWwIts1UMjZFFlrHj8rsfTcy3
 bQeKE1Dd3kYIaGK8dvRswUhOvKR44hE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-SIfuG6KkOxeUUobihJ5Aqw-1; Wed,
 31 Jan 2024 05:17:10 -0500
X-MC-Unique: SIfuG6KkOxeUUobihJ5Aqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82F7F3C29A69;
 Wed, 31 Jan 2024 10:17:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C27DD1C060B1;
 Wed, 31 Jan 2024 10:17:09 +0000 (UTC)
Date: Wed, 31 Jan 2024 11:17:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <ZboeJIXKDP7OP9YD@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 29.01.2024 um 17:30 hat Hanna Czenczek geschrieben:
> I don’t like using drain as a form of lock specifically against AioContext
> changes, but maybe Stefan is right, and we should use it in this specific
> case to get just the single problem fixed.  (Though it’s not quite trivial
> either.  We’d probably still want to remove the assertion from
> blk_get_aio_context(), so we don’t have to require all of its callers to
> hold a count in the in-flight counter.)

Okay, fair, maybe fixing the specific problem is more important that
solving the more generic blk_get_aio_context() race.

In this case, wouldn't it be enough to increase the in-flight counter so
that the drain before switching AioContexts would run the BH before
anything bad can happen? Does the following work?

Kevin

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 0a2eb11c56..dc09eb8024 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -120,17 +120,11 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
     SCSIRequest *next;
 
     /*
-     * If the AioContext changed before this BH was called then reschedule into
-     * the new AioContext before accessing ->requests. This can happen when
-     * scsi_device_for_each_req_async() is called and then the AioContext is
-     * changed before BHs are run.
+     * The AioContext can't have changed because we increased the in-flight
+     * counter for s->conf.blk.
      */
     ctx = blk_get_aio_context(s->conf.blk);
-    if (ctx != qemu_get_current_aio_context()) {
-        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh,
-                                g_steal_pointer(&data));
-        return;
-    }
+    assert(ctx == qemu_get_current_aio_context());
 
     QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
         data->fn(req, data->fn_opaque);
@@ -138,6 +132,7 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
 
     /* Drop the reference taken by scsi_device_for_each_req_async() */
     object_unref(OBJECT(s));
+    blk_dec_in_flight(s->conf.blk);
 }
 
 /*
@@ -163,6 +158,7 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
      */
     object_ref(OBJECT(s));
 
+    blk_inc_in_flight(s->conf.blk);
     aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
                             scsi_device_for_each_req_async_bh,
                             data);


