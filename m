Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D11FC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6y-00037w-BE; Fri, 04 Sep 2026 16:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6u-0002hR-VS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6t-00006a-5W
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8o3TdsDmTmZflSq3Tpd/g79z8JVPD27QnuhbFbpfBc=;
 b=WwDkBdksp7kO/d/BOsRfmbkQQz05I18K3RVC9hZ6/MjwT+4k7CivSmigVbDUqYb/uZObUL
 FW6kbtYlhWCSlN2pGD4DNi6WQeobiQTujaI0wYlYNlxf69Yp85COfHNlqRfQ9nGWzVWRnM
 VBfHTkH7I0Q/rWRg0KiZoPYMWgqyNkU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-EY1sutotOGOjZ9DS4LogVA-1; Fri,
 04 Sep 2026 16:02:00 -0400
X-MC-Unique: EY1sutotOGOjZ9DS4LogVA-1
X-Mimecast-MFC-AGG-ID: EY1sutotOGOjZ9DS4LogVA_1788552119
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A17A518D726A; Fri,  4 Sep 2026 20:01:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D34791955F03; Fri,  4 Sep 2026 20:01:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:45 +0400
Subject: [PATCH v4 62/75] qdev: adjust PciDevfn declared type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-62-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KhDByEWBnxUC3W2CWL4f0/aEPfmWCB/L9BLd30y2XBI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLLWbPAS23pVMbSlH+dXWiydT0u71JJQ5Ex4
 nYSo1iSHkqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5fXqEACWwM53Bs6YUYaFbbWmDiswK3O0Ju31yjBhsWD6/hgMwCUa4c6WOqcI3OKy+E3e91iKIKC
 W8RQUsvVAJahh3pG+Tu/wYNvbFK+qwqyRIk7tLNrxxZQcPUpIx6s0Z4B/oeOFb35Yz7/4DV06lx
 aKamAm1rqDWU5cpsMCVjzqFUVcjjzEcEff8WtbWMpBS/0hp17kmfHYjYQTI1xjPbpL15rau0Il0
 D7/7ZCh5U2jIukSYVqvycJiLiNvQ4aT/Dq08Vd21R1PEpcDCx+/tgE7fhwJSWoTpPxe/YT8NlsD
 +e5JPzfhLFEg5mnnqAvnth9DueoAAJb8QeHFS++C/ONURWssxnHiI7Z1GFsuBonHouMGWVwnGWR
 Yc5cNU0FS4KLVd7HpMOkb4/7VO+dwYdiBTKurLExa9VFWI89hgpIWhiG41S2a6UELVw9AWLWkGz
 FyHi6Jn5NQzSlmofq+uxK6hlLutpdqS53JI4g4hZkHDcpZQYNVepfDoTmGM5vQG64DBkYznIqyB
 WWv0FR+2UYsIN417ElcVqeEeXcE1yUMhXAsISU2vQd94eHgwk26dwEO5qzK+DSb+QQpG8GebUGW
 RYRkQVyIHMEf0R7a8VQuMaYICmG49hJKfchR5Cb6F7uYNC80bJcBiDqTDPxLYh+avY+pvJB69mY
 bA/9Ro+jkXHEPCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PciDevfn is a bit special, since it accepts integer and string as
setter, but only output integer as getter.

Unfortunately, we can't declare an alternate str|int QAPI type for it,
since: branch 'string' can't be distinguished from 'integer'

Rather than declaring it as "str", use the common type instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties-system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 5bfdfe1ab9d9..3381de1144d6 100644
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
2.55.0.543.g5ebe2ebe4ea8


