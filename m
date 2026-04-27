Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3634FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRre-0001Dh-BO; Mon, 27 Apr 2026 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrM-0000yi-6U
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrE-0007lk-So
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pEn/2hVVxeAUWb0BmkZAfz7mfTs19c+tKrVGD3uLaA=;
 b=HndBesjua9M3q88FNIMiSz7Mf4qOcF6MJjigZaMJaaEXa6vAXQFGkpT4aKrxTi9agaJ01d
 xhgIuVnL4P7nu39nIILORr5Scih/haLfUCJB7BlMRZwHofNwxj6jppkimCXj94cFUXoAlS
 RuLehzr8zlwAGTcPGfCB9BPsmrjpsqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-uY5k2CaGNz6QCrNEUz8r8g-1; Mon,
 27 Apr 2026 15:43:02 -0400
X-MC-Unique: uY5k2CaGNz6QCrNEUz8r8g-1
X-Mimecast-MFC-AGG-ID: uY5k2CaGNz6QCrNEUz8r8g_1777318981
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2410A195608B; Mon, 27 Apr 2026 19:43:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8017A19560B1; Mon, 27 Apr 2026 19:42:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:05 +0400
Subject: [PATCH 06/41] hw/remote: check visit return in vfu_object_set_socket
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-6-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OO0tb8zQyK1Y9je3PseFy7KqoAQ349m+oesD3AFJRzk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wU86khG3YZJuikiYHMH9sfKpSwXyEdq8g2x
 RpYPJHmxPCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5QUdD/0fBGHHHdAkPVR5h0zXL0jd5tdmTxVYBKZh7iydIvp/mgBymlidKHBeDa3RMIO7hagKzRv
 fjh5G6kZOLl0X7Q9WwliRbTmqorCBTIGUqYWCA+d3sQeVZ4/i0OaI8K7nsX0iuY3iLIO78n1Lc5
 8BEgVlVD9vGYYBARzRio9isOKPip48S8BtyJbzn77yaVYggfEgOVhh8bSjNBHwg4DvZy0ugvHAK
 qqr3tz5mtASoCPRRLRPeVvKlEBu64107gxHudvVLJp6uauqLK7phR48/8QlU4masWcymIzkqEol
 MP7TqiDA18jE1kCQKs3G/G+G2MPS9qi9Z9c0Xn9V01O8qimncpLcaC82a/xZv3TGB5qQ1ctIdIz
 ZbhO52ddIevbqpnlMwJUajpjqukuhlRf0fIkUGgBUzUeWDhr1lXW+NMT8PA5BdfO/O5Jqbgpy9a
 gXdg5YUGcddQHQkvSHBtoieZTAwPZA/8DG4GoHkjvITi6+CFn3zVVpP8rdOiZAoO2V2HICz0Yeh
 /2t47gEL68Zm/W6tV5AloRnyhi+QHEr6v2bowce8RBAgNj/2AVt8NSE79lIBYdwnn2HyhrtqHcN
 YpMxgpFSRPAOb7wFKYx0PV4UIkSHr2KeJT8R/MkqPZD57N9+/hwXD921bVeQvqnAFzVcVG8IWZl
 bLZxinbNIQpMl8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

vfu_object_set_socket() dereferences o->socket without checking if
visit_type_SocketAddress() succeeded. On failure, o->socket remains
NULL, leading to a NULL dereference. Check the return value.

Fixes: 8f9a9259d32c ("vfio-user: define vfio-user-server object")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/remote/vfio-user-obj.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 12ecdab6dea..49bf5ecae0c 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -161,7 +161,9 @@ static void vfu_object_set_socket(Object *obj, Visitor *v, const char *name,
 
     o->socket = NULL;
 
-    visit_type_SocketAddress(v, name, &o->socket, errp);
+    if (!visit_type_SocketAddress(v, name, &o->socket, errp)) {
+        return;
+    }
 
     if (o->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfu: Unsupported socket type - %s",

-- 
2.53.0


