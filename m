Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499C3D2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5U-0000Zh-8j; Wed, 23 Oct 2024 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5R-0000YA-VU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5Q-0007tl-GM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG/EDr2i6N99N/lyixLAYWZhnmRTOBjYTzh2WT/Wqk0=;
 b=KzUwHKEd1gwggxekAWT+iH06mdx1ED02ZeNIeBAeA3vUXgTf40wR/4S2kA8+HgL5+HgW+T
 fnjkGxtxlc8dBFM33JH6IzHevApAljay1TaPbmermUI9CBAaxzATEyfc5MeF6+2300aTLX
 892fkebTxBOcw3MX91waaUTdrg+SKOE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-hkgWxFaKMfW3ks89UY8ETA-1; Wed,
 23 Oct 2024 04:51:20 -0400
X-MC-Unique: hkgWxFaKMfW3ks89UY8ETA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CCE1955D45; Wed, 23 Oct 2024 08:51:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EEE31955EA3; Wed, 23 Oct 2024 08:51:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 3/8] ebpf: drop redundant parameter checks in static methods
Date: Wed, 23 Oct 2024 09:50:58 +0100
Message-ID: <20241023085103.1980072-4-berrange@redhat.com>
In-Reply-To: <20241023085103.1980072-1-berrange@redhat.com>
References: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Various static methods have checks on their parameters which were
already checked immediately before the method was invoked. Drop
these redundat checks to simplify the following commit which adds
formal error reporting.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ebpf/ebpf_rss.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index dcaa80f380..0c42355a93 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -49,10 +49,6 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 
 static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
 {
-    if (!ebpf_rss_is_loaded(ctx)) {
-        return false;
-    }
-
     ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_configuration, 0);
@@ -90,10 +86,6 @@ toeplitz_fail:
 
 static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
 {
-    if (!ebpf_rss_is_loaded(ctx)) {
-        return;
-    }
-
     munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
     munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
     munmap(ctx->mmap_configuration, qemu_real_host_page_size());
@@ -177,15 +169,10 @@ bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
     return true;
 }
 
-static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
+static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
-    if (!ebpf_rss_is_loaded(ctx)) {
-        return false;
-    }
-
     memcpy(ctx->mmap_configuration, config, sizeof(*config));
-    return true;
 }
 
 static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
@@ -194,8 +181,7 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
 {
     char *cursor = ctx->mmap_indirections_table;
 
-    if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
-       len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+    if (len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
@@ -207,20 +193,16 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
     return true;
 }
 
-static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
+static void ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
-    if (!ebpf_rss_is_loaded(ctx) || toeplitz_key == NULL) {
-        return false;
-    }
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
     memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
-    return true;
 }
 
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
@@ -231,18 +213,14 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
         return false;
     }
 
-    if (!ebpf_rss_set_config(ctx, config)) {
-        return false;
-    }
+    ebpf_rss_set_config(ctx, config);
 
     if (!ebpf_rss_set_indirections_table(ctx, indirections_table,
                                       config->indirections_len)) {
         return false;
     }
 
-    if (!ebpf_rss_set_toepliz_key(ctx, toeplitz_key)) {
-        return false;
-    }
+    ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
 
     return true;
 }
-- 
2.46.0


