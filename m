Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AAFEE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigG-0003bj-9G; Sat, 07 Feb 2026 08:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voift-0003Jq-1s
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifr-0003FO-Dm
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/h197Ye4vwe/RDsUiCKSabQ/LWbJNm/iv8nehvs3ca8=;
 b=UIA8o0x/ZUjt4NIiQTSV8NVQhYQR5jv17NM0zRmlCPaHBFhej5dQXyoQPOmlKhqFo1VxqR
 pfJa5HGfKfc0afy+2Twwhko5FpUvvHgdj9kCxEx2i/YAc7zFl6cDveu91POolRHshDCbZ7
 x/V/DsO1/UQjwUjN28x7J75iruNHciI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-QTq1-qbPMIG37Atb1gEjiw-1; Sat,
 07 Feb 2026 08:48:33 -0500
X-MC-Unique: QTq1-qbPMIG37Atb1gEjiw-1
X-Mimecast-MFC-AGG-ID: QTq1-qbPMIG37Atb1gEjiw_1770472112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 860F018003F6; Sat,  7 Feb 2026 13:48:32 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61D9B30001A8; Sat,  7 Feb 2026 13:48:28 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 07/12] netfilter: enable read_poll when redirector created
 while stopped
Date: Sat,  7 Feb 2026 21:47:23 +0800
Message-ID: <20260207134728.1495932-7-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jason Wang <jasowang@redhat.com>

filter-redirector uses a vm change state handler to enable netdev read_poll()
when enable_when_stopped=true and the VM stops, so that host traffic can be
still drained into the netfilter chain while vCPUs are not running.

However, qemu_add_vm_change_state_handler() does not invoke the callback for
the current VM state at registration time. If a redirector is created after
the VM is already stopped (or if enable_when_stopped is toggled on while
stopped), read_poll() may remain disabled and packets will not be drained.

Add a helper that checks the current runstate and proactively enables
read_poll() when enable_when_stopped is set and the VM is already stopped.
Call it from redirector setup and from the enable_when_stopped property setter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index eb703b7dee..c1b9dabacd 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -314,6 +314,27 @@ static void filter_redirector_vm_state_change(void *opaque, bool running,
     }
 }
 
+static void filter_redirector_maybe_enable_read_poll(NetFilterState *nf)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    NetClientState *nc = nf->netdev;
+
+    if (!nc || !nc->info || !nc->info->read_poll) {
+        return;
+    }
+
+    /*
+     * When a redirector is created while the VM is already stopped,
+     * qemu_add_vm_change_state_handler() will not immediately invoke the
+     * callback for the current state. If enable_when_stopped is set, we
+     * must proactively enable read_poll so that tap packets can be drained
+     * into the netfilter chain (e.g. redirector+buffer) during stop.
+     */
+    if (!runstate_is_running() && s->enable_when_stopped) {
+        nc->info->read_poll(nc, true);
+    }
+}
+
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
@@ -366,6 +387,8 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 
     s->vmsentry = qemu_add_vm_change_state_handler(
         filter_redirector_vm_state_change, nf);
+
+    filter_redirector_maybe_enable_read_poll(nf);
 }
 
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
@@ -484,8 +507,17 @@ static void filter_redirector_set_enable_when_stopped(Object *obj,
                                                       Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
+    NetFilterState *nf = NETFILTER(obj);
 
     s->enable_when_stopped = value;
+
+    /*
+     * If toggled on while the VM is already stopped, ensure we enable read_poll
+     * immediately (vm_state_change callback only runs on transitions).
+     */
+    if (value) {
+        filter_redirector_maybe_enable_read_poll(nf);
+    }
 }
 
 static void filter_mirror_class_init(ObjectClass *oc, const void *data)
-- 
2.52.0


