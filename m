Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A240D5B165
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hGJ-00079v-5H; Tue, 29 Oct 2024 04:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGH-00079Z-GW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGF-0003wV-Ol
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730189251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bv3Ni3J1teSkGbpGS4vKRXQ+UmcTRKnZUd/nHd5DYY=;
 b=UOx0fhUNr9N4t4JufYo+T2FCYFnf5MCetymSwNs61M/HPGJbVGc1Uz9RjiE/ZYAsS2dg2M
 aT/C26A7h1b07zMC8VV3rWEE3ALu7rgw5PiPlyO0Ba28og8OkAFagYWsrbpbbZ/d5RlI8v
 tCiqE1sMu/eRCwQ5cX0bQjDqWu84+KA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-UOQ1082XMmeVbf4_98UQmw-1; Tue,
 29 Oct 2024 04:07:24 -0400
X-MC-Unique: UOQ1082XMmeVbf4_98UQmw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81BEE1955F3B; Tue, 29 Oct 2024 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 963B81956086; Tue, 29 Oct 2024 08:07:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/14] hw/net: fix typo s/epbf/ebpf/ in virtio-net
Date: Tue, 29 Oct 2024 16:06:53 +0800
Message-ID: <20241029080705.3238-3-jasowang@redhat.com>
In-Reply-To: <20241029080705.3238-1-jasowang@redhat.com>
References: <20241029080705.3238-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index fb84d142ee..7c050246ea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1254,7 +1254,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
     config->default_queue = data->default_queue;
 }
 
-static bool virtio_net_attach_epbf_rss(VirtIONet *n)
+static bool virtio_net_attach_ebpf_rss(VirtIONet *n)
 {
     struct EBPFRSSConfig config = {};
 
@@ -1276,7 +1276,7 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
     return true;
 }
 
-static void virtio_net_detach_epbf_rss(VirtIONet *n)
+static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 {
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
@@ -1286,8 +1286,8 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
     if (n->rss_data.enabled) {
         n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
         if (n->rss_data.populate_hash) {
-            virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
+            virtio_net_detach_ebpf_rss(n);
+        } else if (!virtio_net_attach_ebpf_rss(n)) {
             if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
                 warn_report("Can't load eBPF RSS for vhost");
             } else {
@@ -1300,7 +1300,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
-        virtio_net_detach_epbf_rss(n);
+        virtio_net_detach_ebpf_rss(n);
         trace_virtio_net_rss_disable();
     }
 }
-- 
2.42.0


