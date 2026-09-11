Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0952C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54JB-0006pJ-17; Fri, 11 Sep 2026 12:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Ir-0006cB-Og
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Iq-00079h-A8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8o3TdsDmTmZflSq3Tpd/g79z8JVPD27QnuhbFbpfBc=;
 b=GDrV+cmOVKDzhJhwy4PP5EUHZyYF2vihj8QxBWbXbGwM5mdUP++RsWZhw9gFu+OlszffE3
 G66VhAT6tcRTm1RkKWN8CfpcHNkNS1rVEwOytERFOMd5tZ1Hu9QQpbiR+O0bikotvIEvhM
 DB83SkYWDTLdAilx4lJlFP0QXIFr3WQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-j60Js6rEMiWHwJLMuE9jPw-1; Fri,
 11 Sep 2026 12:40:34 -0400
X-MC-Unique: j60Js6rEMiWHwJLMuE9jPw-1
X-Mimecast-MFC-AGG-ID: j60Js6rEMiWHwJLMuE9jPw_1789144833
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 078DF19539BF; Fri, 11 Sep 2026 16:40:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39762195608F; Fri, 11 Sep 2026 16:40:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:24 +0400
Subject: [PATCH v5 50/62] qdev: adjust PciDevfn declared type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-50-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27VvnlmdnC2sK0BLdK63bEClVNS2CicZkjr
 kBqPIcKJVGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5cAGD/40nO9HqdUxEXPAwQGHyO0qt49CZcgln3EpS0MBi78lLdjXaLW8xs/iQROIcgTpgmVRlAy
 z0ZOfXGbEBXulIDbGjz4d5u4lpqiD0XSaOdJjqtQtPo+A0Og7+NZVadkdvbVPINrE3gNtmAEQHz
 PYtYT86V2h9o4u/fO9ztlrS3KCHcyZHsyHH5oi1obJ6RP8ULEPnoBKWOuAWulG6wSWW/7jBRO0R
 esVTnl64SaN/3iCz9Qvvt/NCPjXnJhAnWGf/R7xaJttgTBxbsYKq0UrtbBt1zoDvmxJp4P9kdtO
 O8iwk5mslbVXq8wVuZ/UtRGbe9YhW7iyHoLBvCxRA4ka6U28K8Y96WQI48lCVZEbXXVwtFt7rP7
 oOQxKjkpVhlwrgSVeoi9D0167aX1jjtlPXwHTvCqLORTDxxWPKYfw6h5n4+CUk7x0BuGOknkwcG
 IrGPmCYje6nf7vbOlkB6LtCFIHYU04XmPHp5Xs/Kgr18geldR49XjiQIG25e9/7AtsRKZPgde/p
 yM1Jr1k5Y3hXqqLIabTxOBxF5fkvKzLKGpUNWdKqKpk9+BfHePuyQojiGtGzQu992flzHybZeET
 k3+twniW6W20J9QyQN+TJ7hsEH1UFlVgQA0nhVCv2gmpNtPQxsS1OHEFJXftF3y117OFRrsK9S+
 Sa2WHwmuwOxOBhw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


