Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A21FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRrX-00015j-M2; Mon, 27 Apr 2026 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrD-0000vT-08
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRr9-0007lJ-Mu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SNI1+7ODP9d4wGo3twIW0HT5Ncz2Zi9RbkwAn71yk4=;
 b=U3luQWN0dldfJXlciHpgZYlubIEbOu5uFkpdDg2xC7jYkJ2qBmSMfMXCKViIx0uH07KcWr
 xx9DI30F29LHLM3Uqlc8OdUIEpz6a9bZK8VnYMqGm/gYS6bN4O8G9boaM6f3BA/OANBNsd
 tejjomjVbsCjt+cusuMTN/3nBMdfVkQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-iRs8dY4ANxiqQ6iN1C1KvQ-1; Mon,
 27 Apr 2026 15:42:55 -0400
X-MC-Unique: iRs8dY4ANxiqQ6iN1C1KvQ-1
X-Mimecast-MFC-AGG-ID: iRs8dY4ANxiqQ6iN1C1KvQ_1777318974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB4F6195609F
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:42:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C44619560B1; Mon, 27 Apr 2026 19:42:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:04 +0400
Subject: [PATCH 05/41] hw/pci-host/q35: handle NULL bus in pci-hole64 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-5-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8e76537D5foz+/YCdH5/+xzv4nxJP353Lst5euJM2Tk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUpdJX9/qeaPQuc7r/VS2SBxeRwFhSvpzXn
 v9AnGks56GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5cfzD/4twr3PbCkYodwlk2w7Z0fmNWOyK7bC9ESXDQVCUhzTka1DAMyqfj1CLK87TxyVE5tV0Eh
 cWf+5PXzmahDXqvxoV6J5F92nZSt5/uA01CSznlKszwBdJDliiWEBy0J3OjRoijoXFsfnMniOjA
 ovExHDbNQdMyv8fC13ImVQqlye/YFcGUvMOCz9p3hM9Lpy4FOQaslu3sF3QHn/JaEfGueD1VaEf
 UdGTmycNRgpupOwRzmUFCnVp4GJ/oK2ffAHdKNuDC8v21kjdkw8EzkgigJqK2kTkBpe7kNbcoWP
 IwOUKk8dJtjDlnIQBQBcFXOSsJv1PkaSvQWSYBvXrxlKNvbRSysqveRhxwFyc4o3s1j5/gNO4Uk
 uk3AngOVu7bY78APJIbH/nVKpZSKJN8SBlsVbU56NH+X4spOTb52f20aA0TqJ4MD9Cj2L3aCd/p
 ZDDdrWMUdn3LRhLOu8t9qD7p9MTXqi3ejlFwMb3TzD0Hu2R/TUY50vDFE+tV33vGKvE+fNBCJto
 CDxYAP8xOBCAhrPoo3UCKU+4+ERGQytbNkjcy5KaSVeQ++R4kc8IoZHYlWmGo3xlZWMBpZQrbR/
 JgHCk7LrCXIfrTt2qrjEaZFCFayPelzVdSKg9ii+5kmerRtSgXsu9yzCgt/lN/WzWqgWcbGXe/t
 IEWi1pW/TH9jaoA==
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

When called on an unrealized Q35 host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both the
pci_hole64_start and pci_hole64_end getters.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/q35.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b37..149c32b4b0e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -132,8 +132,14 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start;
 
+    if (!h->bus) {
+        error_setg(errp, "bus not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     visit_type_uint64(v, name, &hole64_start, errp);
 }
 
@@ -149,10 +155,15 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    uint64_t hole64_start;
     Range w64;
     uint64_t value, hole64_end;
 
+    if (!h->bus) {
+        error_setg(errp, "bus not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);

-- 
2.53.0


