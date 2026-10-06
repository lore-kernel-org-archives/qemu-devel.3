Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5588DCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLC-0004Al-MW; Wed, 07 Oct 2026 04:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0z-00032V-Tv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0r-0006AC-Ux
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791350178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1SEmEFGXTOO8eYndp8ctq8G7E/DAJIG11Mq9r7apRQ=;
 b=gEjraWAZOkNIXnAizTDGnWUGSyH82yclSDoHH3yDJqvL7kPRZF2YJJ5K+ZBsqSemKzeS0y
 rZSEvcwPSYNyiiRDKIpBT9ip/oyQwrai6vmnIShwBOaRWi/uzfgLuz3wAPtU6MPy26xWTu
 wdzCUilBfm6+YuEkGlfbCIxyRz4BDfc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-ap1KMDXNMdO8sXP-XrFlcw-1; Tue,
 06 Oct 2026 04:35:00 -0400
X-MC-Unique: ap1KMDXNMdO8sXP-XrFlcw-1
X-Mimecast-MFC-AGG-ID: ap1KMDXNMdO8sXP-XrFlcw_1791275699
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 509861954211
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 08:34:59 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 678BC180034F; Tue,  6 Oct 2026 08:34:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 4/4] seccomp: fix blocking of setns/execveat/unshare
Date: Tue,  6 Oct 2026 09:34:51 +0100
Message-ID: <20261006083451.956881-5-berrange@redhat.com>
In-Reply-To: <20261006083451.956881-1-berrange@redhat.com>
References: <20261006083451.956881-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The initializer for these syscalls missed the seccomp action
field, so it got the default action which was to kill the calling
thread, instead of returning an errno value, which the other
equivalent syscalls use.

Since we don't ever intend to use a seccomp filter without a
defined action, use an assert to validate that action is always
set to non-zero.

Reported-by: Igor Santos-Grueiro (gitlab:@igorsantosgrueiro)
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4600
Fixes: 4638057110 (seccomp: block setns, unshare and execveat syscalls)
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/qemu-seccomp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index f8e1238b914..3889d48b4f2 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -249,10 +249,13 @@ static const struct QemuSeccompSyscall denylist[] = {
       0, NULL, SCMP_ACT_ERRNO(ENOSYS) },
 #endif
 #ifdef __SNR_execveat
-    { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN },
+    { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN,
+      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
 #endif
-    { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN },
-    { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN },
+    { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN,
+      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
+    { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN,
+      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
     /* resource control */
     { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL,
       0, NULL, SCMP_ACT_ERRNO(EPERM) },
@@ -337,6 +340,12 @@ static int seccomp_start(uint32_t seccomp_opts, Error **errp)
         if (!(seccomp_opts & denylist[i].set)) {
             continue;
         }
+        /*
+         * action == 0 is SCMP_ACT_KILL_THREAD which is not
+         * something we ever want to use. Validate it to protect
+         * against missing struct field initializers
+         */
+        assert(denylist[i].action);
 
         action = qemu_seccomp_update_action(denylist[i].action);
         rc = seccomp_rule_add_array(ctx, action, denylist[i].num,
-- 
2.55.0


