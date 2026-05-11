Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582C5CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8Z-0002P1-2Z; Mon, 11 May 2026 16:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8V-0002Hw-HA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8T-0001xx-Pk
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN5TIB8xZhcm71D8v6fTPFcE7OV/kWkJLILB23cEv/c=;
 b=ezlNn9t75o4j0Rs+CA6C6jBYt30d6oyfm2vOZaeIIixtl9K8pwQTLltm7w+ZOkbSvY8SHV
 yCB60JBboxQo58sKIgPRgur632aoftdbhuHdEy+311cf/YKSC+xq0YGvf8ixngZhi9t+KZ
 sRAW7hT3GwtLRf/SJdYO7ZqFV5aTVZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-GCBrX2O-OXy8nl1Nx2kPKw-1; Mon,
 11 May 2026 16:21:50 -0400
X-MC-Unique: GCBrX2O-OXy8nl1Nx2kPKw-1
X-Mimecast-MFC-AGG-ID: GCBrX2O-OXy8nl1Nx2kPKw_1778530908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D8E195609D; Mon, 11 May 2026 20:21:48 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F9C31800465; Mon, 11 May 2026 20:21:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/24] system/ioport: Fix qom-list-properties crash on portio
 list obj
Date: Tue, 12 May 2026 00:20:52 +0400
Message-ID: <20260511202111.3091440-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Currently qom-list-properties QMP command will crash when querying the
portio list MR object.  It's because its finalize() assumes full
initialization done in portio_list_add_1().

Provide a simple fix for now to avoid the crash.  There is chance for a
longer term fix, ideally MR should be initialized in instance_init().

However that'll need more work, and that should also be done with cleaning
the hard-coded MR operations in portio_list_add_1().  To be explored.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ioport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 9209bff2eab..1a0e01fd06b 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -346,8 +346,15 @@ static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
 
-    object_unref(&mrpio->mr);
-    g_free(mrpio->ports);
+    /*
+     * This check makes sure any random object_new() (without doing the
+     * rest inits in portio_list_add_1()) will not crash when finalizing.
+     * One example is QMP command qom-list-properties.
+     */
+    if (mrpio->ports) {
+        object_unref(&mrpio->mr);
+        g_free(mrpio->ports);
+    }
 }
 
 static const TypeInfo memory_region_portio_list_info = {
-- 
2.54.0


