Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E1CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWjF-0004Yg-33; Fri, 05 Jun 2026 11:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjD-0004YC-9n
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjB-00060Y-O4
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfyciCUtj2uYB/fKRwGsx2x9nVw//AMbGAr/gW/I5xs=;
 b=ev+xSb1x4tQYrgPCEp7ClM/7NCIwfBZW9OW6z77B7KLXYqwGpvPT6/1aqkHNRqABy/m/ZN
 2YS4CDQxjcUcpvUk587Ib6+kcFZ2p4yOADHajdGIPgubKwSz+gqh2q2w2iYX9cxZRuFC/x
 lgNO5A431ON1C+fiHbCys0RiLdSuaps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-x3N_fGU3Pz6VT3h0MW_9Cg-1; Fri,
 05 Jun 2026 11:44:54 -0400
X-MC-Unique: x3N_fGU3Pz6VT3h0MW_9Cg-1
X-Mimecast-MFC-AGG-ID: x3N_fGU3Pz6VT3h0MW_9Cg_1780674293
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF94E1800663
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F39C3000239; Fri,  5 Jun 2026 15:44:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:25 +0400
Subject: [GIT PULL 05/23] hw/pci-host/q35: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-5-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XXJqDmEBi6TiRs5PKjbn7IjQSTVVWEFFYwA+j0kMbhI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7U4kBHXy+gwLqi75qV2C5bzDybZKeZ6WpxS
 Im4TK3/mteJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5fUPD/sGb5IF4UZJuaxeDNU7Q9slT9smrqk+NmQqw3jUU7D0I4Tjsu/kgv0b7xji4T6sw7o1WTp
 dnYKrnzU4Sj0HhV37Fae0FxPLXm3hse/0ucKoGidfHl32m8NQX+HTGRqE5RMAeBUff33iEHyo8O
 6Y2rQYAKYcyh0phPNp6Vx0qxnGRgnZT2EVujkIf8kOJHIgFh/F8qPCHfOep00+qToFxYaghPEJF
 CVlgbJUlL5U7djNMR1LZ1AaRQ+4DBwPvJogRXDsRUiKsFn+Bgo2Y2GQyj97yC6+yojd/M4yzxYO
 cB/fdvxksqL0DYH+7qEdY8QRQvMHGwn8chArUlpXRxTh0CiIUOOHrrhhwc7IT00eNBcp2onpH90
 TxXW0MvS+AoYzdlNGn6TEloBMfzJu+bzgJRi5w6ROzfsoC7HaCRVS3YUZMG6CmY4w5edd61V/ws
 HaLBZPQDFROW3h+kYUVBLMxZaTR/Ern0oKJbUHUlGj6ZzIejFaLe8iN/WY3e14QkNUaMxROYSpw
 pQevnWFk3quBl32XFFU0FXKRHICEegO3py1Gvs1EDphlcsh05LZbMQxJ+TEI1fbi2vFPeThAQHE
 kHzDH8gNeTCJlOQT6lAXxD6MZfYLwui/yoyFcj/c3RuHQ4kGfaOXHpGdI2AZxhNZOBMN445cuzb
 7MxzUlkGhBfTJrg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/q35.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b37..355e81bfa20 100644
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
+        error_setg(errp, "PCI host bridge not realized");
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
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);

-- 
2.54.0


