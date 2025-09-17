Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F9CCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqjG-0005Cp-85; Wed, 17 Sep 2025 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqi2-00035e-JI
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqhy-0003l9-9m
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xC9LOczZKUqz4OC+j5hH68ZHE+u4axLUlzty3xnb2z4=;
 b=dQZkcF7ptMJyvsTT94vrgaeyFv1c2PfvG6o0HVenHFLbkAHWyym3NDzLrbJ6ZXCpDHW143
 fyTFdt6o5NReCLFWPva6Lx1v+2Q0mXq6qiqls+NVobqFCdvDrcccgXDeoRoGmmETuixZt4
 84pKJfX0q7RLrHGGXWel7Piu3DvwAdQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-z5zkgVX_Mg-FByJJ1tFjNQ-1; Wed,
 17 Sep 2025 07:52:16 -0400
X-MC-Unique: z5zkgVX_Mg-FByJJ1tFjNQ-1
X-Mimecast-MFC-AGG-ID: z5zkgVX_Mg-FByJJ1tFjNQ_1758109933
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B721919560AE; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65E7F1955F19; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 504C921E6779; Wed, 17 Sep 2025 13:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 07/12] ui/spice-core: Clean up error reporting
Date: Wed, 17 Sep 2025 13:52:02 +0200
Message-ID: <20250917115207.1730186-8-armbru@redhat.com>
In-Reply-To: <20250917115207.1730186-1-armbru@redhat.com>
References: <20250917115207.1730186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

watch_add() reports _open_osfhandle() failure with
error_setg(&error_warn, ...).  error_setg_win32(&error_warn, ...) is
undesirable just like error_setg(&error_fatal, ...) and
error_setg(&error_abort, ...) are.  Replace by warn_report().

The failure should probably be an error, but this function implements
a callback that doesn't take Error **.  I believe the failure will
make spice_server_init() fail in qemu_spice_init(), which is treated
as a fatal error.  The warning here provides more detail than the
error message there.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5992f9daec..97bdd171cd 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -132,7 +132,8 @@ static SpiceWatch *watch_add(int fd, int event_mask, SpiceWatchFunc func, void *
 #ifdef WIN32
     fd = _open_osfhandle(fd, _O_BINARY);
     if (fd < 0) {
-        error_setg_win32(&error_warn, WSAGetLastError(), "Couldn't associate a FD with the SOCKET");
+        warn_report("Couldn't associate a FD with the SOCKET: %s"
+                    g_win32_error_message(WSAGetLastError()));
         return NULL;
     }
 #endif
-- 
2.49.0


