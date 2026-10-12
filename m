Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E3CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGD12-0004cs-UG; Mon, 12 Oct 2026 06:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGD0e-0004aE-Ef
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGD0Z-00030F-7k
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ZBjrXnt7O3rGxeMvln+JI2KQkcDn982QMSpt3d7j5g=;
 b=May4TJE8iM1GdmQLluz40J6hsQz5n3uzeJv9dx4Mc/mZSAPpvq3MrdZrG0lTZo2QEMyu41
 MBiasu1FfL+xbjS7bpB5IbKH6/8Ebg9PDYdhMuNW8vgowlPMMqlPj7EY5a2hwv/uTnxQjK
 NF8EfOxkztkOnRoc2SoWg5fHeauaOpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-RhV86F72O9mPz_BL3T4TJQ-1; Mon,
 12 Oct 2026 10:11:47 +0000
X-MC-Unique: RhV86F72O9mPz_BL3T4TJQ-1
X-Mimecast-MFC-AGG-ID: RhV86F72O9mPz_BL3T4TJQ_1791799906
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5DFC18000A3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:11:46 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2459A472; Mon, 12 Oct 2026 10:11:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] seccomp: really fix blocking of setns/execveat/unshare
Date: Mon, 12 Oct 2026 11:11:44 +0100
Message-ID: <20261012101144.58085-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The previous fix for setns/execveat/unshare mistakenly copy and
pasted the clone_args filter, which is inappropriate for these
syscalls and had the effect of weakening the seccomp filter.

Fixes: f33fb19cab (seccomp: fix blocking of setns/execveat/unshare)
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4671
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/qemu-seccomp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 3889d48b4f2..cd2c1b0b747 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -250,12 +250,12 @@ static const struct QemuSeccompSyscall denylist[] = {
 #endif
 #ifdef __SNR_execveat
     { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN,
-      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
 #endif
     { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN,
-      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
     { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN,
-      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
     /* resource control */
     { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL,
       0, NULL, SCMP_ACT_ERRNO(EPERM) },
-- 
2.56.0


