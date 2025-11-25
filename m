Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC864CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNovy-0003Vn-E8; Tue, 25 Nov 2025 04:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNovw-0003Uv-NX
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNovs-0001ZQ-LT
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764061313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gP8zW91eMMdParUS51W1dDdLU/a1x//SHEkUd9rpKx8=;
 b=LF5I/wknK357P6D/Jd05Cd2fzBVlucg6toi9g5tcBFuCIkDzdoOIRaA0xm9QzPm+YkCIxR
 PM6j0ev+4CrUwM1myYfhlY5YL9PrShVG/M6ERVfS/viBPucXNXlWJtFmKKMEiz0mm9NV+H
 Rjci/VAa4Rp58O2VlmR5c77+AXMpF4g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-SHih0t5eOj2vw_T57L6asg-1; Tue,
 25 Nov 2025 04:01:50 -0500
X-MC-Unique: SHih0t5eOj2vw_T57L6asg-1
X-Mimecast-MFC-AGG-ID: SHih0t5eOj2vw_T57L6asg_1764061309
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897AA1954B0B; Tue, 25 Nov 2025 09:01:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4875F1800451; Tue, 25 Nov 2025 09:01:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A78DE21E6A27; Tue, 25 Nov 2025 10:01:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	eesposit@redhat.com
Subject: [PATCH] kvm: Don't assume accel_ioctl_end() preserves @errno
Date: Tue, 25 Nov 2025 10:01:46 +0100
Message-ID: <20251125090146.2370735-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

Retrieve the @errno set by ioctl() before we call accel_ioctl_end()
instead of afterwards, so it works whether accel_ioctl_end() preserves
@errno or not.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae654..28006d73c5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3373,10 +3373,10 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
     trace_kvm_vm_ioctl(type, arg);
     accel_ioctl_begin();
     ret = ioctl(s->vmfd, type, arg);
-    accel_ioctl_end();
     if (ret == -1) {
         ret = -errno;
     }
+    accel_ioctl_end();
     return ret;
 }
 
@@ -3413,10 +3413,10 @@ int kvm_device_ioctl(int fd, unsigned long type, ...)
     trace_kvm_device_ioctl(fd, type, arg);
     accel_ioctl_begin();
     ret = ioctl(fd, type, arg);
-    accel_ioctl_end();
     if (ret == -1) {
         ret = -errno;
     }
+    accel_ioctl_end();
     return ret;
 }
 
-- 
2.49.0


