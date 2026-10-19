Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31886CCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoFy-0005ag-S0; Mon, 19 Oct 2026 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDa-0002Mi-Qd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDX-0005i2-KZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZFiki9/HnZ5p/klANrLjCce6s7lHYga3PonF0JZPv8=;
 b=VL+XSUVng9CcVMMfePLD7Wr/qIpNllaCWp4oAbSz+stecWyH7K3W/tcCn1in9PVkqZD1lx
 qvMndtLC9gsAz0RJIAFz3MVA7UuBwru85XapR3tvtN+kFr1Hh+2yfQpevb0t0CfRwW/m2h
 3G9BZr7fQ/kIrddQ1QDgvZ43YMsZ1oc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-LnjCKwNiOJKVEOz_5-3_3w-1; Mon,
 19 Oct 2026 14:19:42 +0000
X-MC-Unique: LnjCKwNiOJKVEOz_5-3_3w-1
X-Mimecast-MFC-AGG-ID: LnjCKwNiOJKVEOz_5-3_3w_1792419581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C161800BC7; Mon, 19 Oct 2026 14:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF90118004D2; Mon, 19 Oct 2026 14:19:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76C0121E675A; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 54/65] qdev: adjust PciDevfn declared type
Date: Mon, 19 Oct 2026 16:19:18 +0200
Message-ID: <20261019141929.1594337-55-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

PciDevfn is a bit special, since it accepts integer and string as
setter, but only output integer as getter.

Unfortunately, we can't declare an alternate str|int QAPI type for it,
since: branch 'string' can't be distinguished from 'integer'

Rather than declaring it as "str", use the common type instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 5bfdfe1ab9..3381de1144 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .type  = "str",
+    /* The formatted string accepted by the setter is a CLI convenience. */
+    .type  = "int32",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
-- 
2.55.0


