Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5691AFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrag-0007Za-2v; Mon, 04 May 2026 07:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrab-0007Z2-Pw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraa-0000oh-Ea
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twbR98+azl1FkvcOd/wUh0yeF3jLiWAv75fxdQ2s+E0=;
 b=cJ5YWN/uv/NDTE902JpusIHpB86pGDVhr/IeqCf6noUxQnEhIBruKvOIvcoAGniCzFZKyF
 GhQ/11jkdRAm25zlDJD3wEqj9CHjEb2DDGqYJUIt6OFBjw+S+lCuDkNMoQXDu1AqVVNc3F
 TxGq94Czwx1n7WAe1WR+0T1I3w89NWE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-pXubjQhIOfuLO3lkGMdDaw-1; Mon,
 04 May 2026 07:35:50 -0400
X-MC-Unique: pXubjQhIOfuLO3lkGMdDaw-1
X-Mimecast-MFC-AGG-ID: pXubjQhIOfuLO3lkGMdDaw_1777894549
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B701956095; Mon,  4 May 2026 11:35:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C36E30001A1; Mon,  4 May 2026 11:35:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:54 +0400
Subject: [PATCH v2 06/46] hw/remote: check visit return in
 vfu_object_set_socket
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-6-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=L2BEfE5R8VEhm76+lymFWMxq2H9P0VB/u9ntt4F1tss=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsLkMZf8r3xhP0bfbc05+BzOHRnHn7t3ZXL
 FmhOPNUK2+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5ZQRD/9Lo+ATGQUt2vIinMLlnZOTrsTKCzFMPUY77jtpgij+dOTK4WyVHbcPm79ZfOzQtRVHKwH
 4ZxDjjfiFWYi2yBvdea80HLx8vuWEMumK6jYXSU962t95jANkcRGJKNAiYyGH8YkHOSRGRsWl7X
 5yjAoX8N75x6kXob8u3j97zRv49V1T9b2B/F1C09Z+QPsNNg2CE1M5b0vzvqe+ynvOg5sjUtDa5
 Dko6N8hlY7f2K2UL7dOi+jpyGjSHzeOGg3PIA7+QC/Aj29O+eQo2FwavDMMaUPiCj0v+3AKHiE/
 j4QjN5DFwCUwYPA2b65+u66yY1q0r/lVAtb//ORabmUoyHtWg/vg9HF+ZjxDFZHdmShqUjHZ0QB
 jzU9BokxziTmfsD9fcTIkoBkhKwE0zmbIQrUcsU8HPGwMAreaWMPH1K9DBczcBPKU/tK+GCu9zS
 I4oKogWt4HvgI0zTmWBm5OFvouffr+lASENQMrSawmHZu3St3gxmae9lg7BjMOHIU9+4G4mVvP1
 ZWH1ImuElCodouNQqQj7rS12jqyN2qaa9DjZjB3DJRJ0DZnNHphGaQLQxtXOSbxyO3VxvL5fvg1
 R4v7WOqgni3+mcNzcvoYrJz3vVRDTUPHNG4SJzY7NLYa4pKPPM+WOw4IAF2QFzOHC6TU3xZ5EaC
 A67h4NLf98aFlJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

vfu_object_set_socket() dereferences o->socket without checking if
visit_type_SocketAddress() succeeded. On failure, o->socket remains
NULL, leading to a NULL dereference. Check the return value.

Fixes: 8f9a9259d32c ("vfio-user: define vfio-user-server object")
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
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
2.54.0


