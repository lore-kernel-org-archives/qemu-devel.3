Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF78FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRr8-0000up-6m; Mon, 27 Apr 2026 15:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRr5-0000uO-RJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRr2-0007jz-3J
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6/s7+wbN+K4kjVcPjREQTdrbnwvUrhPZpIX3sPM1qs=;
 b=E5u1o/nBGYoLx+Wz/KQMbmec15V5HXq8AhBa+lPOSqq7Vdna58BDel6km4yh0y/9AAAcvB
 RG7Z9zzOeDcBHzCcWp3kX8XkcysF3o5+wCDvaqbAbEipmssGWVjJU+ybr+WG9o3JpCggBj
 0iUnQ+SUMT2nPH4V/x0IYAoyV7PQBVo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-QLneicrQOvehu5TPtD6kpw-1; Mon,
 27 Apr 2026 15:42:49 -0400
X-MC-Unique: QLneicrQOvehu5TPtD6kpw-1
X-Mimecast-MFC-AGG-ID: QLneicrQOvehu5TPtD6kpw_1777318968
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B1D918004AD
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:42:48 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D754619560B7; Mon, 27 Apr 2026 19:42:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:03 +0400
Subject: [PATCH 04/41] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-4-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RxT0UeQOktv5seL6iNPTJqxIzApIk7GMQLzeeYc8LL0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUev64TFRUjOwIkRbb907noV5mDEkWj0PCw
 vosv/MzszeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5bYpD/91JphflRw5SJCK2kJxxj2l0f5q2z9fW1/QsjCE6QiUuwZgT2msMkDFKAkY6kxYp4VxsnW
 1NwBcTM87zTo98anvr8Id4eHEnWDRNUXah7CWEWrbshZh9o5LWfNtsDPQRiKgjcUJ5fwTaEGXja
 HONgHMv3cUrefKCrfyUcewZBE3pr/eC1qpc6QfNUQmvyqVfxJ8AKzKzYu+tK4dH6CUBTIXP2Ac+
 BR91a5sQb/JCMVwiPadpyCyg8tTA+snwqgAHTXLKC1kb7wJUgXiFXqMHJ+xBpE4sHoBW//tEmt+
 9zY0/Uh0fuku6ffCJ76m95O/D6Ysw0GNmh7VR6gVc/C9JK9xEm/1Lm38IBzQ5tjvuVoGTvlWCF/
 LwRe1gcd7dIo1ptU9lMegZCJwcWyXM1UCtAcf9PyPf/lklHaML9MksUrTZ5qg7As0TwvFb3iL0a
 0vvdYz+LnEzy2AJBoURLVztDOtP1IGuYv2A0+cmfwxDQJFdeYbrwtoax3jm5i2st4HkSBBNYRoS
 3tiaw7fSNhVmV4BQw/Q5MO3h8tMWPHk+/+uAfig2aX+acT4lVgWUUoR+maJr60Gow1dVZAxdt2o
 VXlb7SkvGJZG6tgmPXIy+l8sD1JpOdUKBTnSW9bG1JH5uGcS+wl991klxzUkCK/y5SLAcWAODaC
 MyAYDnuU3dIXkug==
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

When called on an unrealized i440FX host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both
pci_hole64_start and pci_hole64_end getters, reporting an error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/i440fx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e7d638b296c..6952094510d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -189,8 +189,14 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
                                                 const char *name,
                                                 void *opaque, Error **errp)
 {
-    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start;
 
+    if (!h->bus) {
+        error_setg(errp, "bus not realized");
+        return;
+    }
+    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     visit_type_uint64(v, name, &hole64_start, errp);
 }
 
@@ -206,10 +212,15 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
+    uint64_t hole64_start;
     Range w64;
     uint64_t value, hole64_end;
 
+    if (!h->bus) {
+        error_setg(errp, "bus not realized");
+        return;
+    }
+    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);

-- 
2.53.0


