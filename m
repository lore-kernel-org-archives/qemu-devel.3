Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DDFCD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wL-00055X-Oo; Sat, 16 May 2026 04:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9w8-00050O-ML
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9w7-00077Q-6B
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwxIXFRqNOFwSXEkTBL3lUfI3qRxviZUG2ZP9ptJKDg=;
 b=WFYJ7Tly/xbYrDNA2pLrFFjlyKcl7CMnj6i5/gOdqJeBmc+GLW7jFbq5+dF/kRu3Q53T7J
 flKtEidkJsLb6JaTTfaiukL6Hixyc1KcbFG6bxBDasDfuKp9daEi5gl5XA3qx/VxCjE+es
 2t7o0vcXGtIxBG/FMaLtBaGIHphVbfo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-TssSJwORMxO_TDZMHSWTvA-1; Sat,
 16 May 2026 03:59:47 -0400
X-MC-Unique: TssSJwORMxO_TDZMHSWTvA-1
X-Mimecast-MFC-AGG-ID: TssSJwORMxO_TDZMHSWTvA_1778918386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C06719560AA
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:46 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50C5D1956053; Sat, 16 May 2026 07:59:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:04 +0400
Subject: [PATCH v3 05/24] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-5-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Vp9y54qI7ZUxlsGcdaDjRbl1VRjgkXVwo0pQvUFYFlU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPP1mSk7lThYLXbz6gMpWnI6sXx4+4e6c5wj
 tJgg+PtvpuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5SYiD/91cUEgd4t+W5pjKVuPacPiP0u6CIXCoUuzWJoe6OCesufhYSWKlGa5JAz2aJhYCx9FYss
 1rJGgmGv/0bvNoA+eTyopb7ScYqbcHJpLM/eh4HjpbI52Ar3qR11ROfMEqcXOOlZLVPMm2sKfit
 lv3twG+lB402ZKQl+VPUHO3PJfJisVuQL0OhqIDyM4bLLR1MiNtHPHTzzoZ9H78cCDgTKxnw5jf
 +LmS6E4kZwziGZOb06s2NGq/SJslfaQRN9P+nIhKcMPCSmCU02KC7F89siQZgNcCpcUHcyVPjH5
 CmQXAnFqtojRMcs9BlP/R2hGpWXro65qmtlTp2gtaOq6dD+fSMQntZ/IhdXXXyRuA0NcfY/3rOt
 /a0Hc8dex/pcn9hxtGRp0a+bA5iOj6IE7bLJmEDUEO0RtcNVWeFM2hQAaXoICD63bOivf0Sb8Rv
 tJRglZszQHpNwG/FnEomSBP4JOjyfCRhDH0dwH7UCxeDi8d644vRFNTp/b4aVZuxfaLRsv5qS99
 jXWUgje4C6PCy8SPrIx+INOHrmNddBjSdOugI3OUiYP6iSTSIioM+y8F5W9oNbuokdgsiU5OylJ
 R6HJF3LnflUvxOHm4sOY+wryEaBnwOxW3EuF0cll8j6WazDlwqniOf9uzlneokR7N8di56Df3K/
 URUY5DiOFlFPPEA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


