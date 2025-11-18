Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC72CEE327
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNww-00052y-VO; Tue, 18 Nov 2025 10:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvu-0004au-8n
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvs-0001us-S2
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763480872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbGOVueTX9DUaLsVj+a+6vgmHY+pg2JzMr0b9qjbJCQ=;
 b=hYvjEXQ9nvuhH1M3D9bMvaZgOLj0fhIRGORFmYz7D2VWhX9scezo7rhXMysxhVifPIsWY7
 hcgeWvk3iOMvIWjxgxBmeQWiI8GkPfmVClEa+18Jn/qW9N1ncmuv8KJ3sqrs2PMIz7hVbS
 0c815vB4zXUt1S7l86SlX2AGS7oysy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-_a8yZfZCP2e3bNwc3JZeTA-1; Tue,
 18 Nov 2025 10:47:44 -0500
X-MC-Unique: _a8yZfZCP2e3bNwc3JZeTA-1
X-Mimecast-MFC-AGG-ID: _a8yZfZCP2e3bNwc3JZeTA_1763480863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CD111977017
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2064B3003777
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2451E21E66EF; Tue, 18 Nov 2025 16:47:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	berrange@redhat.com
Subject: [PATCH 3/3] ebpf: Make ebpf_rss_load() return value consistent with
 @errp
Date: Tue, 18 Nov 2025 16:47:18 +0100
Message-ID: <20251118154718.3969982-4-armbru@redhat.com>
In-Reply-To: <20251118154718.3969982-1-armbru@redhat.com>
References: <20251118154718.3969982-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ebpf_rss_load() returns false for failure without setting an Error
when its @ctx argument already has an eBPF program loaded.  This is
wrong.  Fortunately, it is only called @ctx has a program.  Replace
the incorrect error check by an assertion.

The return value is now obviously reliable.  Change the caller to use
it, because it's more concise.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ebpf/ebpf_rss.c     | 4 +---
 hw/net/virtio-net.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index b64e9da3e3..926392b3c5 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -106,9 +106,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ebpf_rss_is_loaded(ctx)) {
-        return false;
-    }
+    g_assert(!ebpf_rss_is_loaded(ctx));
 
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3b85560f6f..f5d93eb400 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1363,9 +1363,7 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
         return virtio_net_load_ebpf_fds(n, errp);
     }
 
-    ebpf_rss_load(&n->ebpf_rss, &err);
-    /* Beware, ebpf_rss_load() can return false with @err unset */
-    if (err) {
+    if (!ebpf_rss_load(&n->ebpf_rss, &err)) {
         warn_report_err(err);
     }
     return true;
-- 
2.49.0


