Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E88606A931
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fo1qIYDS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt2K-0007wF-Cf; Mon, 02 Nov 2026 09:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt2H-0007vT-M5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt2G-0007Bd-5e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793629759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtRHsEP0BhVRB1hLbXnl2pGI9U2k40CZuJQKVQdkTbs=;
 b=Fo1qIYDSMxVeVBoq2aKLWnF5NejHxpgRlo6uAXD28syZIvwNJQwEZWbld+H0HPLDN8GEkq
 wwA/9E9+QGB4dJ/B3WfhN9bBaDX8HvqodOc0hmH0HwBPhPkhQz4NmHwjnqjvygxmPXveqo
 Sc12y4QN9ZdWwGwxn2InF2tiYUXfSdQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-TYBZikHFNoaZYekwDHn9EA-1; Mon,
 02 Nov 2026 09:29:16 -0500
X-MC-Unique: TYBZikHFNoaZYekwDHn9EA-1
X-Mimecast-MFC-AGG-ID: TYBZikHFNoaZYekwDHn9EA_1793629755
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575F21955F2A; Mon,  2 Nov 2026 14:29:15 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18C1B1800480; Mon,  2 Nov 2026 14:29:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 18/25] hw/ppc: remove mistaken use of
 trace_event_get_state()
Date: Mon,  2 Nov 2026 14:28:37 +0000
Message-ID: <20261102142844.3464712-19-berrange@redhat.com>
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Conditional checks must call trace_event_get_state_backends()
which checks the state of all backends (dtrace, ftrace, log,
syslog, simple & ust), while trace_event_get_state() only
validates state for backends using QEMU's internal state
tracking (ftrace, log, syslog, simple).

Furthermore, checking qemu_loglevel_mask() is inappropriate since
there are many trace backends, of which 'log' is only one.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ppc/vof.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 873e967f1e4..e2ff9bf96a3 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -252,8 +252,7 @@ static uint32_t vof_getprop(const void *fdt, uint32_t nodeph, uint32_t pname,
              */
             ret = proplen;
             /* Do not format a value if tracepoint is silent, for performance */
-            if (trace_event_get_state(TRACE_VOF_GETPROP) &&
-                qemu_loglevel_mask(LOG_TRACE)) {
+            if (trace_event_get_state_backends(TRACE_VOF_GETPROP)) {
                 prop_format(trval, sizeof(trval), prop, ret);
             }
         }
@@ -337,8 +336,7 @@ static uint32_t vof_setprop(MachineState *ms, void *fdt, Vof *vof,
         goto trace_exit;
     }
 
-    if (trace_event_get_state(TRACE_VOF_SETPROP) &&
-        qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state_backends(TRACE_VOF_SETPROP)) {
         prop_format(trval, sizeof(trval), val, vallen);
     }
     ret = vallen;
@@ -584,8 +582,7 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
         }
 
         /* FIXME: there is no backend(s) yet so just call a trace */
-        if (trace_event_get_state(TRACE_VOF_WRITE) &&
-            qemu_loglevel_mask(LOG_TRACE)) {
+        if (trace_event_get_state_backends(TRACE_VOF_WRITE)) {
             tmp[cb] = '\0';
             trace_vof_write(ihandle, cb, tmp);
         }
@@ -599,9 +596,7 @@ static void vof_claimed_dump(GArray *claimed)
     int i;
     OfClaimed c;
 
-    if (trace_event_get_state(TRACE_VOF_CLAIMED) &&
-        qemu_loglevel_mask(LOG_TRACE)) {
-
+    if (trace_event_get_state_backends(TRACE_VOF_CLAIMED)) {
         for (i = 0; i < claimed->len; ++i) {
             c = g_array_index(claimed, OfClaimed, i);
             trace_vof_claimed(c.start, c.start + c.size, c.size);
-- 
2.56.0


