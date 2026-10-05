Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C7CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhXk-00012v-SI; Mon, 05 Oct 2026 08:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVk-000679-ME
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVg-0004lR-TZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38McGp5Xm1dQXhbAUpMdkHym6qcL4iNQX0mqlyg4uho=;
 b=cm8Iu7LpBXGalpk40nXLmbHyol9qhiSLv6BbshA7b2jbo+2N9SEwPUOdHsPeFTqvsUCAuI
 UsgbE33Z7PDp33g85c5Z65OtqfgBhv0CACofiCwLysk+U5gEvYk2qfgeyKeJHpFNM4ASbd
 sZdhqcCKCTnIVPssa2F/BYBj/M3l1Vw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-HQyeNoq9MSqPe5Ok0glSAA-1; Mon,
 05 Oct 2026 08:09:32 -0400
X-MC-Unique: HQyeNoq9MSqPe5Ok0glSAA-1
X-Mimecast-MFC-AGG-ID: HQyeNoq9MSqPe5Ok0glSAA_1791202171
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 846F11953990; Mon,  5 Oct 2026 12:09:31 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACB773001D29; Mon,  5 Oct 2026 12:09:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 18/24] hw/ppc: remove mistaken use of
 trace_event_get_state()
Date: Mon,  5 Oct 2026 13:08:49 +0100
Message-ID: <20261005120855.421973-19-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
2.55.0


