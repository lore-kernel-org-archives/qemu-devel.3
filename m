Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D0DC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6gC-0007dl-K2; Mon, 17 Mar 2025 05:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tu6fx-0007SJ-T8
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tu6fu-0004HP-NL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742203341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhuRtfn92kG4Im5Jrhj99U+SsewYQ7ePZzod5uuoe8I=;
 b=CVFm7fgauR8FP+j+NN21TmtSvnPJtqfB5wbAo4TQ9bFUBsq50pYcNw+UwFy1T88EA5nyqv
 OpEpFk4f28CQeNK1z0qcWa80lQHY9UM/3wXsGusDbe0mmq5QynEN0pZItyqYHMUFZneHMI
 jmOFklnnMjuCNc5EH0v6yMNlzZzO1m4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-fHPcKUj9NR-fiqpSurhCxg-1; Mon,
 17 Mar 2025 05:21:12 -0400
X-MC-Unique: fHPcKUj9NR-fiqpSurhCxg-1
X-Mimecast-MFC-AGG-ID: fHPcKUj9NR-fiqpSurhCxg_1742203271
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC42C180899B; Mon, 17 Mar 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 447431828A92; Mon, 17 Mar 2025 09:21:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/1] vdpa: Allow vDPA to work on big-endian machine
Date: Mon, 17 Mar 2025 17:21:02 +0800
Message-ID: <20250317092102.4381-2-jasowang@redhat.com>
In-Reply-To: <20250317092102.4381-1-jasowang@redhat.com>
References: <20250317092102.4381-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

Add .set_vnet_le() function that always returns success, assuming that
vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
outputs the message:
"backend does not support LE vnet headers; falling back on userspace virtio"

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f7a54f46aa..7ca8b46eee 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -262,6 +262,18 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
 
 }
 
+/*
+ * FIXME: vhost_vdpa doesn't have an API to "set h/w endianness". But it's
+ * reasonable to assume that h/w is LE by default, because LE is what
+ * virtio 1.0 and later ask for. So, this function just says "yes, the h/w is
+ * LE". Otherwise, on a BE machine, higher-level code would mistakely think
+ * the h/w is BE and can't support VDPA for a virtio 1.0 client.
+ */
+static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool enable)
+{
+    return 0;
+}
+
 static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
                                        Error **errp)
 {
@@ -429,6 +441,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
+        .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
-- 
2.42.0


