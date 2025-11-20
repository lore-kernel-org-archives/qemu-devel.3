Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8E0CFA443
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 19:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMA6Y-0005lW-C2; Thu, 20 Nov 2025 14:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6L-0005fG-II
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6J-00071u-Cm
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763666030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx8qN/rQg9K32+B1nXrTKMNVKMJAAYsg2jr2Y0IDjq8=;
 b=AGjoQtCjrDqkjEJU4eNe4MxZdOxTojCeaDQPPejx65n1oaX6TYySgmhVF88Mr9S2btXXok
 QzPDKK5Y6OmTyKPXymIB0dCro68HEcxVdSVGaQ0cEkIAr8iwtUJnaA12xcf1d05Oj4+Pr7
 +TsZ8psu3ctmrk1UGucXBV2FCyz62Qs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-AavvAK_sPLGzx3xXYBncyQ-1; Thu,
 20 Nov 2025 14:13:48 -0500
X-MC-Unique: AavvAK_sPLGzx3xXYBncyQ-1
X-Mimecast-MFC-AGG-ID: AavvAK_sPLGzx3xXYBncyQ_1763666024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72F7B19541AF; Thu, 20 Nov 2025 19:13:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8119818004D8; Thu, 20 Nov 2025 19:13:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5665A21E66F8; Thu, 20 Nov 2025 20:13:39 +0100 (CET)
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
Subject: [PATCH 04/14] qga: Use error_setg_file_open() for better error
 messages
Date: Thu, 20 Nov 2025 20:13:29 +0100
Message-ID: <20251120191339.756429-5-armbru@redhat.com>
In-Reply-To: <20251120191339.756429-1-armbru@redhat.com>
References: <20251120191339.756429-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Error messages change from

    open("FNAME"): REASON

to

    Could not open 'FNAME': REASON

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-linux.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 4a09ddc760..5cf76ca2d9 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1502,14 +1502,15 @@ static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
 
     dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
     if (dirfd == -1) {
-        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        error_setg_file_open(errp, errno, dirpath);
         return;
     }
 
     fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
     if (fd == -1) {
         if (errno != ENOENT) {
-            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
+            error_setg_errno(errp, errno, "could not open %s/%s",
+                             dirpath, fn);
         } else if (sys2vcpu) {
             vcpu->online = true;
             vcpu->can_offline = false;
@@ -1711,7 +1712,7 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
     dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
     if (dirfd == -1) {
         if (sys2memblk) {
-            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+            error_setg_file_open(errp, errno, dirpath);
         } else {
             if (errno == ENOENT) {
                 result->response = GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;
@@ -1936,7 +1937,7 @@ static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
 
     fp = fopen(diskstats, "r");
     if (fp  == NULL) {
-        error_setg_errno(errp, errno, "open(\"%s\")", diskstats);
+        error_setg_file_open(errp, errno, diskstats);
         return NULL;
     }
 
@@ -2047,7 +2048,7 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 
     fp = fopen(cpustats, "r");
     if (fp  == NULL) {
-        error_setg_errno(errp, errno, "open(\"%s\")", cpustats);
+        error_setg_file_open(errp, errno, cpustats);
         return NULL;
     }
 
-- 
2.49.0


