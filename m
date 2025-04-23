Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8500EC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uez-00039Q-NO; Wed, 23 Apr 2025 03:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uer-00035i-Sx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uen-0003C9-R5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJOyC9lDbMysueFAZdSuaIrVtPn30IdXqR8iPqB2+sU=;
 b=iYD0rJ0eiLp21z749hYE1VOin7MbzQMGuVSmlMd1sM1nTP+77zFld2pwAOZP36OuRvKhPS
 xmcW8uDl45sQQiRnrexgC0e+vbby1d1XcaEiJ3sGWoMuKYi9oW3zgU4VoOuX+P/Yr+IoKx
 PhgaE5A4AelqIrBenAppzx4Hq+WM3PA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-dt-iXGYHP0KJYRYS5w1Ong-1; Wed,
 23 Apr 2025 03:36:28 -0400
X-MC-Unique: dt-iXGYHP0KJYRYS5w1Ong-1
X-Mimecast-MFC-AGG-ID: dt-iXGYHP0KJYRYS5w1Ong_1745393787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ECE6180048E; Wed, 23 Apr 2025 07:36:27 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D63119560A3; Wed, 23 Apr 2025 07:36:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/29] hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
Date: Wed, 23 Apr 2025 09:35:46 +0200
Message-ID: <20250423073610.271585-7-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The storage keys are part of the machine memory.

Introduce the TYPE_DUMP_SKEYS_INTERFACE type,
allowing machine using storage keys to dump them
when a DumpSKeysInterface::qmp_dump_skeys() callback
is provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250310151414.11550-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/storage-keys.h | 15 +++++++++++++++
 hw/s390x/s390-skeys.c           |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 408d2815d4d..fb766d4631b 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -125,4 +125,19 @@ S390SKeysState *s390_get_skeys_device(void);
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
 void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
+#define TYPE_DUMP_SKEYS_INTERFACE "dump-skeys-interface"
+
+typedef struct DumpSKeysInterface DumpSKeysInterface;
+DECLARE_CLASS_CHECKERS(DumpSKeysInterface, DUMP_SKEYS_INTERFACE,
+                       TYPE_DUMP_SKEYS_INTERFACE)
+
+struct DumpSKeysInterface {
+    InterfaceClass parent_class;
+
+    /**
+     * @qmp_dump_skeys: Callback to dump guest's storage keys to @filename.
+     */
+    void (*qmp_dump_skeys)(const char *filename, Error **errp);
+};
+
 #endif /* S390_STORAGE_KEYS_H */
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d50e71b927a..0d3d4f74b4c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -474,6 +474,11 @@ static void s390_skeys_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo s390_skeys_types[] = {
+    {
+        .name           = TYPE_DUMP_SKEYS_INTERFACE,
+        .parent         = TYPE_INTERFACE,
+        .class_size     = sizeof(DumpSKeysInterface),
+    },
     {
         .name           = TYPE_S390_SKEYS,
         .parent         = TYPE_DEVICE,
-- 
2.49.0


