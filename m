Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3528BCD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVyv-0002Hh-3v; Fri, 05 Jun 2026 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVys-0002Cg-JT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyq-0005Pt-PR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irnikjkMIeigUjbODCJXw4z7kWUOW7SYpDpm+2y9lvg=;
 b=ejFy15eBthrzoenUt+7bClKVMZiMiel01A0i8UmzgmGtcMMb2rzlznksn8axelUSuaegtI
 pVSWGacTBmG4Vfq0gPVagbHivug+a6Yfscp9U5YVRgBGGrLUfBPrl6ImzwGutbwcbFLPKs
 Y6rn8YBfZdK3FgFIddxN2DUHsIzQhM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-WYBulYjhPXqrO73JhXnPig-1; Fri,
 05 Jun 2026 10:57:00 -0400
X-MC-Unique: WYBulYjhPXqrO73JhXnPig-1
X-Mimecast-MFC-AGG-ID: WYBulYjhPXqrO73JhXnPig_1780671419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BDDE1956096; Fri,  5 Jun 2026 14:56:59 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B80B180049F; Fri,  5 Jun 2026 14:56:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alexandra Winter <wintera@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 2/7] target/s390x: Make container ids in SysIB_15x 1-based
Date: Fri,  5 Jun 2026 16:56:42 +0200
Message-ID: <20260605145647.272621-3-cohuck@redhat.com>
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexandra Winter <wintera@linux.ibm.com>

The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
by starting the container ids at 1 for the lowest numbered container.

The qemu misbehaviour without this patch becomes obvious due to a recently
proposed kernel fix. Older linux kernels pass the container ids from stsi
fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
in off-by-one values when compared to the values from HMC. A Linux kernel
fix is being proposed to correct the sysfs topology ids by -1, so they
start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
fixed kernel runs on a host with a qemu without this fix, this can result
in container ids erroneously being shown as 255.
Example (Fixed guest on unfixed qemu):
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
  1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
After this fix:
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
  1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1

Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Gautam Gala <ggala@linux.ibm.com>
Message-ID: <20260511134909.43802-1-wintera@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm/stsi-topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index 301d41b68d2e..afd00da0e68b 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -90,9 +90,9 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
     int last_drawer = -1;
     int last_book = -1;
     int last_socket = -1;
-    int drawer_id = 0;
-    int book_id = 0;
-    int socket_id = 0;
+    int drawer_id = 1;
+    int book_id = 1;
+    int socket_id = 1;
     int n = sizeof(SysIB_151x);
 
     QTAILQ_FOREACH(entry, topology_list, next) {
@@ -103,12 +103,12 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
         if (level > 3 && drawer_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 3, drawer_id++);
-            book_id = 0;
+            book_id = 1;
         }
         if (level > 2 && book_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 2, book_id++);
-            socket_id = 0;
+            socket_id = 1;
         }
         if (socket_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
-- 
2.54.0


