Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D82F8FA9A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE4S-0004mN-P7; Tue, 21 Apr 2026 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3t-0004Zm-Rw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3q-0007KB-Bk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kYB8vK3HXzfENIO6q5Lq5Tn7QDuCndeJbYpyXiIukk=;
 b=gqaoEUhrjxmVa5lHYx74iHZX75ug3vcK4icwYJvUbzv/tPbHBGmbqvvJJcr+R2neBF2Kep
 yYbHthUp9yepUX1zoCwk9Mu6NNK9lo4VJZ0j8I20UYUEnmP9cxabW+eX9AM+wqefLGop1X
 yNz7ycIvBSGZC7gaTYq/q3k/MBvMXqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519--IVaB97-PWKt81x4tLxPOw-1; Tue,
 21 Apr 2026 12:34:45 -0400
X-MC-Unique: -IVaB97-PWKt81x4tLxPOw-1
X-Mimecast-MFC-AGG-ID: -IVaB97-PWKt81x4tLxPOw_1776789284
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BDE91956080; Tue, 21 Apr 2026 16:34:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F0FB19560AB; Tue, 21 Apr 2026 16:34:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] hw/vfio/listener.c: remove CONFIG_KVM
Date: Tue, 21 Apr 2026 18:34:25 +0200
Message-ID: <20260421163438.3447280-2-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Code concerned is under a kvm_enabled() guard.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-2-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a9341e8123baed7839a32bc3f3acca57..31c3113f8fbe305081ffdd16cb28cf8379926971 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,9 +20,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
 #include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
@@ -303,11 +301,9 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
     if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
-#ifdef CONFIG_KVM
         if (kvm_enabled()) {
             max_memslots = kvm_get_max_memslots();
         }
-#endif
 
         QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
-- 
2.53.0


