Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E9CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP0HQ-0005eA-4Z; Fri, 28 Nov 2025 10:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vP0HO-0005dc-D7
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 10:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vP0HL-0001FF-Pt
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 10:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764343255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3+nXCSQCD4CyRuWI2IklWjDkfAFE8zVF5dLRe+1dRUs=;
 b=h1UWVeqTPwWLgY/xvVgPlo85Fg5LEjCGJB9jZBpDkqpy+Z4LunpDvIU7+E9Ae06zQ9mSZd
 dJGAel4vZsEb0YbIumwKlNcNYHqtfT2SgJlNa0YkfngCb9JcjkKE6WmF1VPTiVD54Kgtrn
 rXNUt2NydHlhJmJnVFhVfFspCdvMgo8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-RmNxGP5EOw2_rgU9h7lEvw-1; Fri,
 28 Nov 2025 10:20:54 -0500
X-MC-Unique: RmNxGP5EOw2_rgU9h7lEvw-1
X-Mimecast-MFC-AGG-ID: RmNxGP5EOw2_rgU9h7lEvw_1764343253
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03F2E1800447; Fri, 28 Nov 2025 15:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A74091956095; Fri, 28 Nov 2025 15:20:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AA2D21E6A27; Fri, 28 Nov 2025 16:20:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, eesposit@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2] kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value
Date: Fri, 28 Nov 2025 16:20:50 +0100
Message-ID: <20251128152050.3417834-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

These functions wrap ioctl().  When ioctl() fails, it sets @errno.
The wrappers then return that @errno negated.

Except they call accel_ioctl_end() between calling ioctl() and reading
@errno.  accel_ioctl_end() can clobber @errno, e.g. when a futex()
system call fails.  Seems unlikely, but it's a bug all the same.

Fix by retrieving @errno before calling accel_ioctl_end().

Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


