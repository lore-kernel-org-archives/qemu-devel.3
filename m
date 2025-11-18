Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F4CEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNwJ-0004e8-OK; Tue, 18 Nov 2025 10:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvg-0004W2-0o
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvd-0001uB-SG
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763480857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uqw3HqGdH++UQPELejZOYrOapoU2gE2nE+8Z40B6YpA=;
 b=dhA4h7eSkIoo8kLs558YIq7n/uF6sxbYjtd0tiiMf+6GafoAC/iw91Gi3XqDJhYtO4uuRI
 PrLTBJZT7R0Qf9CTp6qkMA2y8pqRw5R0Ox/eNg9UnPtx21AdoNwSgJgDsF94iqVX6cX1EB
 aMZlOxsnf2kgu+t9fv83Mx+qUf66mxg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-wl0wwq5BNcm8WvZC-K7k4w-1; Tue,
 18 Nov 2025 10:47:34 -0500
X-MC-Unique: wl0wwq5BNcm8WvZC-K7k4w-1
X-Mimecast-MFC-AGG-ID: wl0wwq5BNcm8WvZC-K7k4w_1763480854
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A0D180048E
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31FF7180047F
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2048821E676A; Tue, 18 Nov 2025 16:47:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	berrange@redhat.com
Subject: [PATCH 2/3] ebpf: Clean up useless error check in ebpf_rss_set_all()
Date: Tue, 18 Nov 2025 16:47:17 +0100
Message-ID: <20251118154718.3969982-3-armbru@redhat.com>
In-Reply-To: <20251118154718.3969982-1-armbru@redhat.com>
References: <20251118154718.3969982-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

ebpf_rss_set_all() is only called when the context has an eBPF program
loaded.  Replace the dead error check with an assertion.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ebpf/ebpf_rss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index e793786c17..b64e9da3e3 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -247,10 +247,8 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key,
                       Error **errp)
 {
-    if (!ebpf_rss_is_loaded(ctx)) {
-        error_setg(errp, "eBPF program is not loaded");
-        return false;
-    }
+    g_assert(ebpf_rss_is_loaded(ctx));
+
     if (config == NULL) {
         error_setg(errp, "eBPF config table is NULL");
         return false;
-- 
2.49.0


