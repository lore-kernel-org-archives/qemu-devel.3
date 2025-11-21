Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A605ACF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 05:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcqs-0005XI-UQ; Fri, 21 Nov 2025 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbcU-0003jL-5r
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbcI-0005yJ-JI
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDP8FM9QFpX4om5r6DeJVNNuFVvQYDlKs2mHtRlqAfQ=;
 b=Y+u+eiBUl9XsQJ2owHgeEyDPTInfnutdaa18LJdLfFFw8bCUGG6K2ULBdoP+ayE0ahXzMI
 DAT0KOlDjy4OXa4U79bXDicMHUeNYk7G1s1UMbaF+Rj4xN7ELjX9lc4RY8HR+MJ8zS6Raw
 M7yNZU4oAvJEdGKVhU3qYsxu3hSRCe8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-5hh7LVJnPmWjjIuQzCm6LQ-1; Fri,
 21 Nov 2025 07:14:50 -0500
X-MC-Unique: 5hh7LVJnPmWjjIuQzCm6LQ-1
X-Mimecast-MFC-AGG-ID: 5hh7LVJnPmWjjIuQzCm6LQ_1763727286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 439A7195605B; Fri, 21 Nov 2025 12:14:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C40981940E82; Fri, 21 Nov 2025 12:14:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D147221EC346; Fri, 21 Nov 2025 13:14:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 philmd@linaro.org, alex@shazbot.org, clg@redhat.com, peterx@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, dave@treblig.org,
 jasowang@redhat.com, samuel.thibault@ens-lyon.org, michael.roth@amd.com,
 kkostiuk@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 rathc@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 marcandre.lureau@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: [PATCH v2 14/15] qga/commands-win32: Use error_setg_win32() for
 better error messages
Date: Fri, 21 Nov 2025 13:14:37 +0100
Message-ID: <20251121121438.1249498-15-armbru@redhat.com>
In-Reply-To: <20251121121438.1249498-1-armbru@redhat.com>
References: <20251121121438.1249498-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

We include numeric GetLastError() codes in error messages in a few
places, like this:

    error_setg(errp, "GRIPE: %d", (int)GetLastError());

Show text instead, like this:

    error_setg_win32(errp, GetLastError(), "GRIPE");

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-win32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index acc2c11589..0fd0c966e4 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1798,8 +1798,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     tf.dwHighDateTime = (DWORD) (time >> 32);
 
     if (!FileTimeToSystemTime(&tf, &ts)) {
-        error_setg(errp, "Failed to convert system time %d",
-                   (int)GetLastError());
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to convert system time");
         return;
     }
 
@@ -1810,7 +1810,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     }
 
     if (!SetSystemTime(&ts)) {
-        error_setg(errp, "Failed to set time to guest: %d", (int)GetLastError());
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to set time to guest");
         return;
     }
 }
@@ -1834,13 +1835,12 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
         (length > sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION))) {
         ptr = pslpi = g_malloc0(length);
         if (GetLogicalProcessorInformation(pslpi, &length) == FALSE) {
-            error_setg(&local_err, "Failed to get processor information: %d",
-                       (int)GetLastError());
+            error_setg_win32(&local_err, GetLastError(),
+                             "Failed to get processor information");
         }
     } else {
-        error_setg(&local_err,
-                   "Failed to get processor information buffer length: %d",
-                   (int)GetLastError());
+        error_setg_win32(&local_err, GetLastError(),
+                         "Failed to get processor information buffer length");
     }
 
     while ((local_err == NULL) && (length > 0)) {
-- 
2.49.0


