Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276ADEF48DD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnKU-0002aq-LV; Fri, 13 Feb 2026 02:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKS-0002aZ-RH
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKR-0005bw-CC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6tgYpf+/FYgfC1vv57KmxBOSXnI9Crz3Q86VSJhAq4=;
 b=ZDKGknM0HtEYQsG0Aa3y/NkimJtM9VGUWanbbYuI+1GgkBo4tRC8qtx5KdzuP+z5YddLn9
 bwCz2INbtwh84rTnOgEJ62a+EnUqCEK039nC2r2dFUKMhhJEuh2O9JhE4Yi5EbJLez7P4J
 kxsRIm05pqPJJ1AOdStvq0HgtktnMwA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-gHJW0tTyOAOYOtOdCW75lA-1; Fri,
 13 Feb 2026 02:10:58 -0500
X-MC-Unique: gHJW0tTyOAOYOtOdCW75lA-1
X-Mimecast-MFC-AGG-ID: gHJW0tTyOAOYOtOdCW75lA_1770966658
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC5F11955D8D; Fri, 13 Feb 2026 07:10:57 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C931930001BE; Fri, 13 Feb 2026 07:10:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 2/5] net/filter-redirector: add in/out_netdev properties
Date: Fri, 13 Feb 2026 15:08:02 +0800
Message-ID: <20260213071042.3733239-3-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
References: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce two new optional properties for filter-redirector:
- in_netdev: specifies a TAP netdev to capture packets from using
  AF_PACKET sockets
- out_netdev: specifies a netdev to inject packets into using
  AF_PACKET sockets

These properties enable filter-redirector to work with vhost-net
backends by bypassing the QEMU network stack entirely. Instead of
relying on chardev sockets (indev/outdev), the redirector can
directly capture/inject packets at the host TAP interface level.

The in_netdev and out_netdev are mutually exclusive with each other
and with their chardev counterparts (indev/outdev) on the same
direction.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index ab711e8835..37035f3892 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -40,6 +40,8 @@ struct MirrorState {
     NetFilterState parent_obj;
     char *indev;
     char *outdev;
+    char *in_netdev;
+    char *out_netdev;
     CharFrontend chr_in;
     CharFrontend chr_out;
     SocketReadState rs;
@@ -510,6 +512,40 @@ static void filter_redirector_set_outdev(Object *obj,
     s->outdev = g_strdup(value);
 }
 
+static char *filter_redirector_get_in_netdev(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    return g_strdup(s->in_netdev);
+}
+
+static void filter_redirector_set_in_netdev(Object *obj,
+                                            const char *value,
+                                            Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    g_free(s->in_netdev);
+    s->in_netdev = g_strdup(value);
+}
+
+static char *filter_redirector_get_out_netdev(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    return g_strdup(s->out_netdev);
+}
+
+static void filter_redirector_set_out_netdev(Object *obj,
+                                             const char *value,
+                                             Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    g_free(s->out_netdev);
+    s->out_netdev = g_strdup(value);
+}
+
 static bool filter_redirector_get_vnet_hdr(Object *obj, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
@@ -597,6 +633,12 @@ static void filter_redirector_class_init(ObjectClass *oc, const void *data)
                                   filter_redirector_set_indev);
     object_class_property_add_str(oc, "outdev", filter_redirector_get_outdev,
                                   filter_redirector_set_outdev);
+    object_class_property_add_str(oc, "in_netdev",
+                                  filter_redirector_get_in_netdev,
+                                  filter_redirector_set_in_netdev);
+    object_class_property_add_str(oc, "out_netdev",
+                                  filter_redirector_get_out_netdev,
+                                  filter_redirector_set_out_netdev);
     object_class_property_add_bool(oc, "vnet_hdr_support",
                                    filter_redirector_get_vnet_hdr,
                                    filter_redirector_set_vnet_hdr);
@@ -638,6 +680,8 @@ static void filter_redirector_fini(Object *obj)
 
     g_free(s->indev);
     g_free(s->outdev);
+    g_free(s->in_netdev);
+    g_free(s->out_netdev);
 }
 
 static const TypeInfo filter_redirector_info = {
-- 
2.52.0


