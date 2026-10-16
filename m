Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FBCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeU6-0000yI-8A; Fri, 16 Oct 2026 05:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTo-0000wZ-MJ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTl-0007Jr-Sw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRqvfgUWhLyxQpiPtjyjWEdAIvBy4L6WpKV4Q7LUpBA=;
 b=EZz9PM0AbOMzDU186kbHmouJ3RJbtzPNd7FyIavPEqt851RB7/o+DtBYpzTe5lATCzYulT
 oi5Lgpz8rorGOr1HqPyArZJ/Ud7aTJC44aavY4/KldidA1hvvT+qr/a4/Mrgp5YKH3/5Dv
 bvlw0b/JcM6BMflpm7GiPXTzZs7ONBU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-9z3MAvURPIKxU-asUMgqvQ-1; Fri,
 16 Oct 2026 09:43:54 +0000
X-MC-Unique: 9z3MAvURPIKxU-asUMgqvQ-1
X-Mimecast-MFC-AGG-ID: 9z3MAvURPIKxU-asUMgqvQ_1792143833
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59814180067D
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:43:53 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E98153000B78; Fri, 16 Oct 2026 09:43:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/8] seccomp: really fix blocking of setns/execveat/unshare
Date: Fri, 16 Oct 2026 10:43:41 +0100
Message-ID: <20261016094348.2616374-2-berrange@redhat.com>
In-Reply-To: <20261016094348.2616374-1-berrange@redhat.com>
References: <20261016094348.2616374-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


