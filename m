Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB70CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGxZ-0008Ed-D5; Mon, 12 Oct 2026 10:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGGxU-0008EI-NZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGGxS-0000GY-I8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791815092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uYRcGFVZkmu0VNiOiRLHaQQxEggzFQTZ+2VnK3h9yck=;
 b=A5AWzSF3iA6BN5RTAs4npYrw3u56G3Nbnr8erSmvR9s8g29ozQCDTqpYEPH9zDp8SDVm42
 v5uSyWfDnnWHNFb5PoQeWELIso3KZrR1uhO0xfBECabxNr2A11AvGjAtya3yPzKGPicmni
 CNWhjnIwtXalD1u/hqnT7bIOCZ4C9Tk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-4citZWetM_et1XzqI1qtcA-1; Mon,
 12 Oct 2026 14:24:51 +0000
X-MC-Unique: 4citZWetM_et1XzqI1qtcA-1
X-Mimecast-MFC-AGG-ID: 4citZWetM_et1XzqI1qtcA_1791815090
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E34021954B0D
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:24:49 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32404472; Mon, 12 Oct 2026 14:24:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] seccomp: drop redundant match for clone() flags == 0
Date: Mon, 12 Oct 2026 15:24:47 +0100
Message-ID: <20261012142447.446500-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

We have seccomp matches for clone() which mandate the presence of
several flags, in order to permit pthreads_create:

  REQUIRE_CLONE_FLAG(CLONE_VM);
  REQUIRE_CLONE_FLAG(CLONE_FS);
  ...

Given those mandatory matches, it is impossible for flags == 0 to
pass the filter. This is fortunate, since the explicit match on
flags == 0 is in fact broken, as it has a silent size extension
from 32-bits to 64-bits.

This results in seccomp generating psuedo code of:

    if ($arch == 3221225534)
      # filter for syscall "clone" (56) [priority: 65531]
      if ($syscall == 56)
        if ($a0.hi32 & 0xffffffff == 0)
          if ($a0.lo32 & 0xffffff00 == 0)
            action ERRNO(1);
      # default action
      action ALLOW;
    # invalid architecture action
    action KILL;

Since the clone() flag is passed as a 32-bit value in the syscall,
the high 32-bits are liable to be undefined/uninitialized garbage

The desired match for flags == 0 was

    if ($arch == 3221225534)
      # filter for syscall "clone" (56) [priority: 65532]
      if ($syscall == 56)
        if ($a0.hi32 & 0x00000000 == 0)
          if ($a0.lo32 & 0xffffff00 == 0)
            action ERRNO(1);
      # default action
      action ALLOW;
    # invalid architecture action
    action KILL;

That is redundant, however, as can be seen if we look at the
(fixed) program with the CLONE_THREAD rule also present:

    if ($arch == 3221225534)
      # filter for syscall "clone" (56) [priority: 65532]
      if ($syscall == 56)
        if ($a0.hi32 & 0x00000000 == 0)
          if ($a0.lo32 & 0xffffff00 == 0)
            action ERRNO(1);
          if ($a0.lo32 & 0x00010000 == 0)
            action ERRNO(1);
      # default action
      action ALLOW;
    # invalid architecture action
    action KILL;

That "($a0.lo32 & 0x00010000 == 0)" match will catch the case
of flags == 0 and do the right thing.

Reported-by: Ricardo Branco (https://gitlab.com/ricardobranco777)
Related: https://gitlab.com/qemu-project/qemu/-/work_items/4671
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/qemu-seccomp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 3889d48b4f2..8f8f8d3cf00 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -76,13 +76,6 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
     { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN, \
       ARRAY_SIZE(clone_arg ## flag), clone_arg ## flag, SCMP_ACT_ERRNO(EPERM) }
 
-/* If no CLONE_* flags are set, except CSIGNAL, deny */
-const struct scmp_arg_cmp clone_arg_none[] = {
-    { .arg = CLONE_FLAGS_ARG,
-      .op = SCMP_CMP_MASKED_EQ,
-      .datum_a = ~(CSIGNAL), .datum_b = 0 }
-};
-
 /*
  * pthread_create should always set all of these.
  */
@@ -219,8 +212,6 @@ static const struct QemuSeccompSyscall denylist[] = {
       0, NULL, SCMP_ACT_ERRNO(EPERM) },
     { SCMP_SYS(execve),                 QEMU_SECCOMP_SET_SPAWN,
       0, NULL, SCMP_ACT_ERRNO(EPERM) },
-    { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN,
-      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) },
     RULE_CLONE_FLAG(CLONE_VM),
     RULE_CLONE_FLAG(CLONE_FS),
     RULE_CLONE_FLAG(CLONE_FILES),
-- 
2.56.0


