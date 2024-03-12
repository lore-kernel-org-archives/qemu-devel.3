Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E28CC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VN-0004jO-Uf; Tue, 12 Mar 2024 08:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Ux-0004Gr-56
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Uv-0000UL-Ki
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vUYNd9Ki6M5gdhRX2pkPt/a9p+YgJkGpstm7/35MA=;
 b=IDv5z9zEOTmMQWdeYclDmuZ+W53PP7wwl5b5zhjFLBAzVlV0yNWkH1oOJDKxRrmJbmW4Uv
 wIyh3m8iFpgqU23/aDrNG7ePubwvBM8CHuUUVrASi3AeSAH85ppKe9YSYEoqzBczFa6iD4
 C//smO+QR8mMZWdakluf/J4nLO5+2Pg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-u5vgfWMhMqWPuYYeYpWAag-1; Tue,
 12 Mar 2024 08:44:44 -0400
X-MC-Unique: u5vgfWMhMqWPuYYeYpWAag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65A18386A0C9;
 Tue, 12 Mar 2024 12:44:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E813492BD7;
 Tue, 12 Mar 2024 12:44:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 31/55] net/vhost-vdpa: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Tue, 12 Mar 2024 13:43:15 +0100
Message-ID: <20240312124339.761630-32-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The net_init_vhost_vdpa() passes @errp to error_prepend(), and as a
member of net_client_init_fun[], it's called in net_client_init1() and
gets @errp from this caller.

But because netdev_init_modern() passes &error_fatal to
net_client_init1(), then @errp parameter of net_init_vhost_vdpa() would
point to @error_fatal. This causes the error message in error_prepend()
to be lost because of the above issue.

To fix this, add missing ERRP_GUARD() at the beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240311033822.3142585-29-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6bdb4562d..d81baecbc1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1751,6 +1751,7 @@ static int vhost_vdpa_get_max_queue_pairs(int fd, uint64_t features,
 int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp)
 {
+    ERRP_GUARD();
     const NetdevVhostVDPAOptions *opts;
     uint64_t features;
     int vdpa_device_fd;
-- 
2.44.0


