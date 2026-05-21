Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3oP-0001mh-9O; Thu, 21 May 2026 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3oL-0001eH-Ce
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3oJ-0006M4-Uo
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRAaGS5MpUdrCe/t5DJ6CS1ipgHcSW4Ebmlp5su3ShA=;
 b=hnVp6e9iw0ox6OVomDcLG9N4u06gGcga3Ku0J5XHy2wwwkaFFKauOKwmSsldiJC4b0ZAqz
 smbe9rQKfE518eosXBVztcYsVCUdEPu+DGhoOt4Y47d3ZZ8UqHh32+DKrrGIWUWu7Oyn9J
 1ejPphnRr3huKknoGieC3X5NDikcjbo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-2Jt7gSMJNbOhvtI3jNmo6g-1; Thu,
 21 May 2026 09:51:28 -0400
X-MC-Unique: 2Jt7gSMJNbOhvtI3jNmo6g-1
X-Mimecast-MFC-AGG-ID: 2Jt7gSMJNbOhvtI3jNmo6g_1779371487
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E01D19560A1; Thu, 21 May 2026 13:51:27 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AB8A1956053; Thu, 21 May 2026 13:51:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 20/29] hw/vfio-user: use a valid object ID for iothread
Date: Thu, 21 May 2026 14:49:34 +0100
Message-ID: <20260521134943.1714527-21-berrange@redhat.com>
In-Reply-To: <20260521134943.1714527-1-berrange@redhat.com>
References: <20260521134943.1714527-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The objectg_new_with_propv/props methods failed to validate that the
QOM "id" was well formed. This allowed the vfio-user code to use an
invalid ID of "VFIO user" (space is not permitted) in its internal
code.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/vfio-user/proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 8b7cc36231..e02a45e997 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -933,7 +933,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     qemu_cond_init(&proxy->close_cv);
 
     if (vfio_user_iothread == NULL) {
-        vfio_user_iothread = iothread_create("VFIO user", errp);
+        vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
-- 
2.54.0


