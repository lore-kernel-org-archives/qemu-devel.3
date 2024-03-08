Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A1CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 12:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZEi-0001BG-4z; Fri, 08 Mar 2024 07:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1riZEb-0001AS-IZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1riZES-0008BE-Hl
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709900507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEhRrgn7jhef1qjl5d34NM0T+BDoeV1Zh9D6DKBAsDI=;
 b=FmtMbwVwN7Yw//0zGLQOUrrFTFC/+k4EB8HLDgRieTlhYKkt1cdAJQz/7eyjCaaAvsSLP2
 XX7byxnlTNPpEeR060/hhWy5SRXxPFFDy8u2l2Ggz4JGKVtO6WZ98fBEjLBHGIuAqUDdEX
 +kZ8pItUwqd6t1celOVBhcvlX4kxUWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-05lebbXNOMq7C-PR0w7vKw-1; Fri,
 08 Mar 2024 07:21:44 -0500
X-MC-Unique: 05lebbXNOMq7C-PR0w7vKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A90723C000B0;
 Fri,  8 Mar 2024 12:21:43 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67ED5C35C2D;
 Fri,  8 Mar 2024 12:21:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 14/20] smbios: extend smbios-entry-point-type with 'auto'
 value
Date: Fri,  8 Mar 2024 13:21:39 +0100
Message-Id: <20240308122139.2082097-1-imammedo@redhat.com>
In-Reply-To: <20240305155724.2047069-15-imammedo@redhat.com>
References: <20240305155724.2047069-15-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

later patches will use it to pick SMBIOS version at runtime
depending on configuration.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
v3:
    - make sure i2nd line of comment is indented on 4 spaces only
---
 qapi/machine.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index bb5a178909..0840c91e70 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1797,10 +1797,13 @@
 #
 # @64: SMBIOS version 3.0 (64-bit) Entry Point
 #
+# @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be
+#     described by it and 3.x otherwise (since: 9.0)
+#
 # Since: 7.0
 ##
 { 'enum': 'SmbiosEntryPointType',
-  'data': [ '32', '64' ] }
+  'data': [ '32', '64', 'auto' ] }
 
 ##
 # @MemorySizeConfiguration:
-- 
2.39.3


