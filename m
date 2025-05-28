Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE9C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZo-0002dI-2q; Wed, 28 May 2025 14:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZV-0002MD-TU
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZP-00072W-Hg
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9r8Of7xYH1J89v6IaADSjy6QMDkayHuOqdn5lJMJqYk=;
 b=cBzXPO3GV4NPpldvm1ROMUcKQsPWH3vtRcDPHrx6QZFAWk8i3aca/WFU5XodPolTJb5RYi
 uIAPhXVJ+S2gRlM3+G3qGKza609/wrKKmbVwkt2mJPqC1HXrC5cdSkDC/EQDmSGC4TX6Z3
 aDOGTm1cpKyMJvXOSSHDQp8XAA1+Ugc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-N8FDF0atOmiGqxvd5Kjypw-1; Wed,
 28 May 2025 14:31:58 -0400
X-MC-Unique: N8FDF0atOmiGqxvd5Kjypw-1
X-Mimecast-MFC-AGG-ID: N8FDF0atOmiGqxvd5Kjypw_1748457117
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D35301956094; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A24C18001DB; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7D0121E65E0; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/13] qapi: remove the misc-target.json file
Date: Wed, 28 May 2025 20:31:45 +0200
Message-ID: <20250528183151.2839034-8-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This file is now empty and can thus be removed.

Observe the pre-existing bug with s390-skeys.c and target/i386/monitor.c
both including qapi-commands-misc-target.h despite not requiring it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-8-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-target.json | 3 ---
 qapi/qapi-schema.json | 1 -
 hw/s390x/s390-skeys.c | 1 -
 target/i386/monitor.c | 1 -
 qapi/meson.build      | 1 -
 5 files changed, 7 deletions(-)
 delete mode 100644 qapi/misc-target.json

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
deleted file mode 100644
index c9ea1ab23e..0000000000
--- a/qapi/misc-target.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# -*- Mode: Python -*-
-# vim: filetype=python
-#
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index e96bff8d38..d8eb79cfda 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -63,7 +63,6 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-arm.json' }
 { 'include': 'misc-i386.json' }
-{ 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
 { 'include': 'pci.json' }
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index aedb62b2d3..8eeecfd58f 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -17,7 +17,6 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "system/memory_mapping.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3ea92b066e..3c9b6ca62f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -29,7 +29,6 @@
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
 /* Perform linear address sign extension */
diff --git a/qapi/meson.build b/qapi/meson.build
index 5e93e6b8cf..ffe44f9e0b 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -42,7 +42,6 @@ qapi_all_modules = [
   'machine-target',
   'migration',
   'misc',
-  'misc-target',
   'net',
   'pragma',
   'qom',
-- 
2.48.1


