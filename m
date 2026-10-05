Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E90CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeZK-0004KW-18; Mon, 05 Oct 2026 05:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDeZE-0004Hj-H8
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDeZC-0002tC-CR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8Ii/QJ6KPBIiEXM2Z7QkM0sKPKqXro3Ygrkhx86hw/Y=;
 b=CZI79Pugt82UHg2IxBGVsSFHbMuCNXDNvxTihT1IcECIcsB0VwXCTFlftMKqlWZR8UbNmj
 fUpQMa0fyTNz1GvE+DCUS1Xgo1RGUVIz0wrzCyhNSK4hAgPX2fxCCZtvP/Gj0Y8LCTiDWI
 opT9CeUCGJ4IWFGdpVjKNI8DZ7lCn0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-ZZNCaPONPu6JpNyhc4UMSA-1; Mon,
 05 Oct 2026 05:00:59 -0400
X-MC-Unique: ZZNCaPONPu6JpNyhc4UMSA-1
X-Mimecast-MFC-AGG-ID: ZZNCaPONPu6JpNyhc4UMSA_1791190858
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F604197907E
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 09:00:58 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D34C13001D28; Mon,  5 Oct 2026 09:00:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] seccomp: fix blocking of setns/execveat/unshare
Date: Mon,  5 Oct 2026 10:00:56 +0100
Message-ID: <20261005090056.32064-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


