Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF48ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGzd-0006dH-A0; Thu, 05 Sep 2024 14:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzL-0005p2-1E
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzJ-0001HH-Ko
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725560022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNUUuqSRzYX0POnmd5u0Eimd9GLrqiy5Ip/mekTfUeI=;
 b=iR565ud8L3fGBWRrJd20zxDkieSEaZS+syN4RYBpGVqPR0b+z3mzk/1JG0GvIVRPK7/JTC
 udGTCLhE3GXRD9kOy++ZaHsIew3PKjIWaSsFEhTkD9b9vpkrZc8pCx6s0VUrODWT56FMg5
 q6VrNseJ+soVmDTKo0VWvF2/RWKaqio=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-H5WyZE7tPdu0Kba45UoRBg-1; Thu,
 05 Sep 2024 14:13:39 -0400
X-MC-Unique: H5WyZE7tPdu0Kba45UoRBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEAE51955D4B; Thu,  5 Sep 2024 18:13:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C64D19560AA; Thu,  5 Sep 2024 18:13:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] hw/net: fix typo s/epbf/ebpf/ in virtio-net
Date: Thu,  5 Sep 2024 19:13:24 +0100
Message-ID: <20240905181330.3657590-2-berrange@redhat.com>
In-Reply-To: <20240905181330.3657590-1-berrange@redhat.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/virtio-net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ed33a32877..055fce1d78 100644
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
2.45.2


