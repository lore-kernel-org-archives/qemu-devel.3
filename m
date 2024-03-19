Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4ABC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxn-00013d-UJ; Tue, 19 Mar 2024 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxl-000131-OQ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxk-0007WU-3J
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aq6T9UXAVyqK1byg+KwEREIyiGaZqbP7rHjz9BdyE+s=;
 b=Au3JM+xTOpZH2j0TRwVtjvHW0Ph0JTANRoczJ8eQsHYYzUkxpwtgzU8SizfSvLImlV+6DV
 GkVZqTq6VNasG7TNQY/ZyVvE5aNUheWIptvSczUunuA1JYWTiqCxTe8dMg/oyNBXQ3cd3B
 uXvw8bpUBIaTUBkH3q/4AoE7aL+ck+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aphAvmg4O6GuAbdIlQyPUQ-1; Tue, 19 Mar 2024 16:21:29 -0400
X-MC-Unique: aphAvmg4O6GuAbdIlQyPUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C02800262
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:21:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7574B10E47;
 Tue, 19 Mar 2024 20:21:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/8] seccomp: report EPERM instead of killing process for spawn
 set
Date: Tue, 19 Mar 2024 20:21:14 +0000
Message-ID: <20240319202121.233130-2-berrange@redhat.com>
In-Reply-To: <20240319202121.233130-1-berrange@redhat.com>
References: <20240319202121.233130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When something tries to run one of the spawn syscalls (eg clone),
our seccomp deny filter is set to cause a fatal trap which kills
the process.

This is found to be unhelpful when QEMU has loaded the nvidia
GL library. This tries to spawn a process to modprobe the nvidia
kmod. This is a dubious thing to do, but at the same time, the
code will gracefully continue if this fails. Our seccomp filter
rightly blocks the spawning, but prevent the graceful continue.

Switching to reporting EPERM will make QEMU behave more gracefully
without impacting the level of protect we have.

https://gitlab.com/qemu-project/qemu/-/issues/2116
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/qemu-seccomp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 4d7439e7f7..98ffce075c 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -74,7 +74,7 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
 
 #define RULE_CLONE_FLAG(flag) \
     { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN, \
-      ARRAY_SIZE(clone_arg ## flag), clone_arg ## flag, SCMP_ACT_TRAP }
+      ARRAY_SIZE(clone_arg ## flag), clone_arg ## flag, SCMP_ACT_ERRNO(EPERM) }
 
 /* If no CLONE_* flags are set, except CSIGNAL, deny */
 const struct scmp_arg_cmp clone_arg_none[] = {
@@ -214,13 +214,13 @@ static const struct QemuSeccompSyscall denylist[] = {
       0, NULL, SCMP_ACT_TRAP },
     /* spawn */
     { SCMP_SYS(fork),                   QEMU_SECCOMP_SET_SPAWN,
-      0, NULL, SCMP_ACT_TRAP },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
     { SCMP_SYS(vfork),                  QEMU_SECCOMP_SET_SPAWN,
-      0, NULL, SCMP_ACT_TRAP },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
     { SCMP_SYS(execve),                 QEMU_SECCOMP_SET_SPAWN,
-      0, NULL, SCMP_ACT_TRAP },
+      0, NULL, SCMP_ACT_ERRNO(EPERM) },
     { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN,
-      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_TRAP },
+      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
     RULE_CLONE_FLAG(CLONE_VM),
     RULE_CLONE_FLAG(CLONE_FS),
     RULE_CLONE_FLAG(CLONE_FILES),
-- 
2.43.0


