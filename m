Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F0ECEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNwF-0004dd-Je; Tue, 18 Nov 2025 10:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNve-0004Vh-W0
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvc-0001tw-Ra
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763480856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xAQ0x3UW4OaFKZn1LvadB0ZOTZUsbhjbxY8dFgQ31k=;
 b=R24wB9eWmpq7rVA6Msp754B8yhS7lPpm8n90Bg4frK2dBsTXTFWbZ1TspTEzInMcYxcAL+
 tRaypGJltQ9WLVrNK4bP1wvYKhBQKsqcGITaNoZWU3fSa1jsE01s+7Mv+aK+t52dgi0PWK
 7Rhcw9VL85cbOgryuOS0cvwELTTy+yM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-3bGyPJIOMLyDVe2Y-HhKrQ-1; Tue,
 18 Nov 2025 10:47:34 -0500
X-MC-Unique: 3bGyPJIOMLyDVe2Y-HhKrQ-1
X-Mimecast-MFC-AGG-ID: 3bGyPJIOMLyDVe2Y-HhKrQ_1763480853
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48D49180AE2C
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3AE2180049F
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C8FA21E6935; Tue, 18 Nov 2025 16:47:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	berrange@redhat.com
Subject: [PATCH 1/3] ebpf: Fix stubs to set an error when they return failure
Date: Tue, 18 Nov 2025 16:47:16 +0100
Message-ID: <20251118154718.3969982-2-armbru@redhat.com>
In-Reply-To: <20251118154718.3969982-1-armbru@redhat.com>
References: <20251118154718.3969982-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Stubs in ebpf_rss-stub.c return false for failure without setting an
Error.  This is wrong.  Callers may assume that the functions set an
error when they fail, and crash when they try to examine or report the
error.  Callers may also check the error instead of the return value,
and misinterpret the failure as success.

ebpf_rss_load() and ebpf_rss_load() are reachable via
virtio_net_load_ebpf().  Fix them to set an error.

ebpf_rss_set_all() is unreachable: it can only be called when the
context has an eBPF program loaded, which is impossible with eBPF
support compiled out.  Call abort() there to make that clear, and to
get rid of the latent bug.

Fixes: 00b69f1d867d (ebpf: add formal error reporting to all APIs)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ebpf/ebpf_rss-stub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index d0e7f99fb9..11729f3d8f 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -25,6 +25,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
+    error_setg(errp, "eBPF support is not compiled in");
     return false;
 }
 
@@ -32,6 +33,7 @@ bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
                        int config_fd, int toeplitz_fd, int table_fd,
                        Error **errp)
 {
+    error_setg(errp, "eBPF support is not compiled in");
     return false;
 }
 
@@ -39,7 +41,7 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key,
                       Error **errp)
 {
-    return false;
+    abort();
 }
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx)
-- 
2.49.0


