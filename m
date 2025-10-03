Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0BDCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4ftn-0008Dc-VS; Fri, 03 Oct 2025 09:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4ftj-0008D2-7S
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4ftQ-0003Uk-PB
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759498328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffnceRZ7rV95xa/MV6lxyYMry3LeO+gaVnixEcvnp+k=;
 b=aKrDgW49h1u7+T7fH1woUUtrmMVuQoziIcVOs/hR/8csCIRKbGR4BiUyoK0FExPiaDSpr1
 jpHxPBj7WLH4zJbMQFcWfcy4f/XMNbIA0axVCOm4Vwzlgbu2UiPc09g7YxbiBbyywVE8eX
 nMxnlfMlI1jmK1PWDiuBNTSXNEqIUXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-IjDb4fugPRavl-Srxx13Nw-1; Fri,
 03 Oct 2025 09:32:06 -0400
X-MC-Unique: IjDb4fugPRavl-Srxx13Nw-1
X-Mimecast-MFC-AGG-ID: IjDb4fugPRavl-Srxx13Nw_1759498325
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C73BD1955F45
 for <qemu-devel@nongnu.org>; Fri,  3 Oct 2025 13:32:05 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 710CD195419F; Fri,  3 Oct 2025 13:32:04 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v1 2/2] tests/qtest: Use exit-with-parent=on in qtest
 invocations
Date: Fri,  3 Oct 2025 14:24:38 +0100
Message-ID: <20251003133158.3978333-3-rjones@redhat.com>
In-Reply-To: <20251003133158.3978333-1-rjones@redhat.com>
References: <20251003133158.3978333-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Previously libqtest.c set PR_SET_PDEATHSIG (or the equivalent on
FreeBSD) after forking the qemu subprocess.  However we can get the
same behaviour now by using the new -run-with exit-with-parent=on
flag, on platforms that support it.
---
 tests/qtest/libqtest.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 933d085869..12f865b805 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -433,24 +433,6 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args,
 #ifndef _WIN32
     pid = fork();
     if (pid == 0) {
-#ifdef __linux__
-        /*
-         * Although we register a ABRT handler to kill off QEMU
-         * when g_assert() triggers, we want an extra safety
-         * net. The QEMU process might be non-functional and
-         * thus not have responded to SIGTERM. The test script
-         * might also have crashed with SEGV, in which case the
-         * cleanup handlers won't ever run.
-         *
-         * This PR_SET_PDEATHSIG setup will ensure any remaining
-         * QEMU will get terminated with SIGKILL in these cases.
-         */
-        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
-#endif /* __linux__ */
-#ifdef __FreeBSD__
-        int sig = SIGKILL;
-        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
-#endif /* __FreeBSD__ */
         execlp("/bin/sh", "sh", "-c", command->str, NULL);
         exit(1);
     }
@@ -481,6 +463,9 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-mon chardev=char0,mode=control "
                       "-display none "
                       "-audio none "
+#if defined(__linux__) || defined(__FreeBSD__) || defined(__APPLE__)
+                      "-run-with exit-with-parent=on "
+#endif
                       "%s"
                       " -accel qtest",
 
-- 
2.50.1


