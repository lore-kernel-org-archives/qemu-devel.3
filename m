Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7CBFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtB-00056y-0s; Mon, 27 Apr 2026 15:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsy-0004hg-9f
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsw-00082U-Or
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQRjqUoc7vncI0l+hyaSVFOjsbZOyeIpqu/UWPsxqd8=;
 b=jKi/P6MUcDd1GFKwkS14DjExy5xHoLD03NSdpSJRalRMVVBEurgrBUTiSykilT8GXxaDBo
 rIa7ZspPLHWLB8WzytZdohd+FMO81u5/5cYVhLPe9wq/DqJvcS9Pmxeu7UsQh1a37FIu6A
 Ac6nEzaBUkZIsr61pRza4Zj+h4Vzuyw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-scGLjG0uPeGo4vpIL5PzDg-1; Mon,
 27 Apr 2026 15:44:45 -0400
X-MC-Unique: scGLjG0uPeGo4vpIL5PzDg-1
X-Mimecast-MFC-AGG-ID: scGLjG0uPeGo4vpIL5PzDg_1777319084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE501800282; Mon, 27 Apr 2026 19:44:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 508DC19560AB; Mon, 27 Apr 2026 19:44:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:22 +0400
Subject: [PATCH 23/41] net/can: free ifname on socketcan finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-23-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T+85e7xuXg9EayFeuwtfh/5N5bXTovQE7UAq/AO7gww=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVrFjRixhuNCY+Q+nnAmVzh1gFmLm0rQZAa
 okmszpZ5kaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5YJ+D/wJYhK5np4MRUDtWxcOCulAj+2vUx4Llktz765wYx+7LQEVGHj2/ejeM+MwLGE2WE9jjRy
 8f5CVktT+9nodqQlnzRXqI0h8aolM2tnoUtZQGtQ6oqPEgDwzbY//8fLZUUQ3cZ0nJ8kxXSKg17
 6v6KutTP6MQUNYqCoT3fLOLJyNuJDHGQCuT7VmkKBCAjWT0aSsqi889FnkMIuhEy16V50jXXU0e
 UtdE7L2XJnANmuCVIUZq3M23vFm/UVg+SAgnM4ZhtHFHuqC4FkFK7egu81+MTrLCMW2NmWKLnDZ
 Szpyp9HpyxzRnviqrSsiHFUfTFBfAGrJjF2UkjnZLqW5Gmp5mypYC20+Ocdwmn77w5X0yh2BASF
 uq0VhGMciP1DugO65bOcth1gA/v6RihqTJpOjBFa1mgDLcT86J7a2tQ2BgxSFIK2i5auBi/wqwe
 GG5lwp2D9KbSRabiN7mQT5od4hVg5Pm48ZDyAJsp7wwFFgx8OQ9CrHLXtv9PyhVF0CcciShgYD2
 1ODKQEPsLupfKaOD+JreJQUTJn1JeefRQBwlW8wBdJ1cYTJx+YZhenuALrzVA0J5HXZrxEum/J+
 3R1MvR6YRFRlirx/G7/KEcyGCocsOhGPBUaIW7l0SHgZ2R4CmoRV9cfHxBv/5m5mrJBUAHm2Rd6
 yJo+lpNFz3wDvbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

can_host_socketcan_set_if allocates ifname via g_strdup, but no
instance_finalize existed to free it.

Fixes: ea15ea8a7c67 ("net/can: support for connecting to Linux host SocketCAN interface.")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/can/can_socketcan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 8a57ae07178..be67ed7f5a9 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -319,11 +319,19 @@ static void can_host_socketcan_class_init(ObjectClass *klass,
     chc->disconnect = can_host_socketcan_disconnect;
 }
 
+static void can_host_socketcan_finalize(Object *obj)
+{
+    CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(obj);
+
+    g_free(c->ifname);
+}
+
 static const TypeInfo can_host_socketcan_info = {
     .parent = TYPE_CAN_HOST,
     .name = TYPE_CAN_HOST_SOCKETCAN,
     .instance_size = sizeof(CanHostSocketCAN),
     .instance_init = can_host_socketcan_instance_init,
+    .instance_finalize = can_host_socketcan_finalize,
     .class_init = can_host_socketcan_class_init,
 };
 

-- 
2.53.0


