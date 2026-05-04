Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4236ECD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraU-0007Wb-8R; Mon, 04 May 2026 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraT-0007WT-1M
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraR-0000nP-Dg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwxIXFRqNOFwSXEkTBL3lUfI3qRxviZUG2ZP9ptJKDg=;
 b=JOXTFxOQODdG82ja4wEc1S0LBCsxuh8+ASUozoChvw9ns5HSWJjt0OBkha54LpC8G4v1BA
 85JjpOtrEfuRLdnIMrnIUQ6U+MssPu/BQkg63whxWaLIa2ZbDJNtwCe4XcSssrY181AqE/
 gkPdTSbl03G5aL/qEkfN6Wk8EgXmmfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-CUP8HtSzOquIerD66Dd8vA-1; Mon,
 04 May 2026 07:35:39 -0400
X-MC-Unique: CUP8HtSzOquIerD66Dd8vA-1
X-Mimecast-MFC-AGG-ID: CUP8HtSzOquIerD66Dd8vA_1777894538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D9761956088
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2372F1800480; Mon,  4 May 2026 11:35:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:52 +0400
Subject: [PATCH v2 04/46] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-4-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Vp9y54qI7ZUxlsGcdaDjRbl1VRjgkXVwo0pQvUFYFlU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRssfLPKs8rqp0fsRHkHmnUx86WnnRfRwN9f
 bXOVqUaXyKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5YYCD/9Q/zcoQSSHK4vK62Q3/QmID+/EXvrcdFy6HiQpHPyh7uxwT0UWNC2FuZewCnd6ODd6UWd
 EnJxmhs2wX47UOnp82q3UBDQwQUZuhEp7nz390K9c/PaC1Bq4nvlpgtfHIY9WUneWPkEGtaH2G+
 CIB9YvRqGzPwmIPwNeJlSDeyoieytoXnMiVI5ASVk42HHWb9l8eX4ysxdOtt1N8JIsi6OganlTm
 fPSaS/gI2N1IcTaiXIs1ya8lGB2J9rvfQ7m7rf9LoYCXiBQMd4do8zcf7xsZ2nq4+cAG0s54q76
 TEB1ltEXWU9n2gbpakZs2YLahoSenR3QrfCspA6iPu2aC2JcWiFDjwUQwGYizx32VSb375RNnHT
 vhyOArvBVjTwYjSys/vxUWxfs/OMhW2Am4bQ4WnMqZk9Fgq8cVHCWBxf7egTdhbzUGs7vVorEE2
 ZpAzNNVsNe/fqJGwSScK8hxG25KTSgeaTqrbs9BfdPpZEMrDzGzsU8eMrxCrMadSu83M3coOYrr
 W+36IPf1EF0rfarT4EZTXdKtrPS2QPnN+5sj6/1bnDJR4Z3kXoG+gv1F2kRsSzszQ0SkuRXfltl
 1Cz3BbpRP/iXuhQd3lNP0bH/wH/0wWenIu8Pes+lr5n5f46bwzQDX22DTJw+1eVYRQqG9DeOe3m
 N+6Y/rrzNHQYgQg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

When called on an unrealized i440FX host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both
pci_hole64_start and pci_hole64_end getters, reporting an error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/i440fx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e7d638b296c..c1982f7962a 100644
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
+        error_setg(errp, "PCI host bridge not realized");
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
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);

-- 
2.54.0


