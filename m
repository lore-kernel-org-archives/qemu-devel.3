Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E479CFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 19:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMA6x-0006iy-5W; Thu, 20 Nov 2025 14:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6e-0005xe-0p
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6T-00079E-AI
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763666039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDP8FM9QFpX4om5r6DeJVNNuFVvQYDlKs2mHtRlqAfQ=;
 b=iBKaHYl9EhWpKrlSbIIN9VxaGkkgijw7PfF8Ju1jw8nhHSJRS9DasXhKZWNPwtuFCMPlTT
 Ibt/oRT9pHaa0qAfYS/1EidVnhYClPL0ARj241vkX9CacwtpuhQUpxX70RwJ4RWMZc8V15
 iGrBKO3UvED2x4f21KGx0h6NDifgNOA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-b5T3lBd2OV2uCxy3edrDZw-1; Thu,
 20 Nov 2025 14:13:55 -0500
X-MC-Unique: b5T3lBd2OV2uCxy3edrDZw-1
X-Mimecast-MFC-AGG-ID: b5T3lBd2OV2uCxy3edrDZw_1763666026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F73195422D; Thu, 20 Nov 2025 19:13:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D535A1800984; Thu, 20 Nov 2025 19:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87A9C21EC344; Thu, 20 Nov 2025 20:13:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, pizhenwei@bytedance.com, alistair.francis@wdc.com,
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
Subject: [PATCH 13/14] qga/commands-win32: Use error_setg_win32() for better
 error messages
Date: Thu, 20 Nov 2025 20:13:38 +0100
Message-ID: <20251120191339.756429-14-armbru@redhat.com>
In-Reply-To: <20251120191339.756429-1-armbru@redhat.com>
References: <20251120191339.756429-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


