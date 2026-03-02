Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C067EE9B36F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2U8-00052k-7a; Mon, 02 Mar 2026 07:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2U5-0004z1-O8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2U3-00060n-Jq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772454885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orAezxq1mnLlnAnmCIcZ9aVODhjrcyN47jsUnRxWekc=;
 b=R+bZwSkcjR1yy2cBJVWel20ZcHyba8ubtI6KIhplRrPH+eLlimQ1YJglnAgYGP49GRBekw
 fGQPtmhlmSlCPnaRDdx6i49l9x9/Vuh5faeVUawgixfWKmrIIKjWrPE1OdyyZ3t+RQwmRQ
 YVm6Tk8YVzcTFF9946nA0RbpmKk5a80=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-V0gWeVVMM82FR1-7vkvf2w-1; Mon,
 02 Mar 2026 07:34:41 -0500
X-MC-Unique: V0gWeVVMM82FR1-7vkvf2w-1
X-Mimecast-MFC-AGG-ID: V0gWeVVMM82FR1-7vkvf2w_1772454880
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF0FA19560B5; Mon,  2 Mar 2026 12:34:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41FC01955F22; Mon,  2 Mar 2026 12:34:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/10] tests/docker: add support for podman remote access
Date: Mon,  2 Mar 2026 13:34:11 +0100
Message-ID: <20260302123413.274700-9-thuth@redhat.com>
In-Reply-To: <20260302123413.274700-1-thuth@redhat.com>
References: <20260302123413.274700-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When a developer's environment is already within a podman container it
is not possible to use 'podman' again to create containers. It will
usually result in wierd errors such as:

  Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover

Podman offers the ability to talk to a daemon outside the container,
however, which could be leveraged by QEMU.

This can be used by invoking "podman --remote", or equivalently the
separate "podman-remote" binary:

  https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md

The current 'podman version' check is insufficient to detect the
inability to launch containers, so it is replaced with the stronger
'podman info' check.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260210163556.713841-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/docker.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ff68c7bf6f2..9e18b984f45 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -76,14 +76,16 @@ def _guess_engine_command():
     commands = []
 
     if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
-        commands += [["podman"]]
+        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
     if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
         commands += [["docker"], ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
-            # docker version will return the client details in stdout
-            # but still report a status of 1 if it can't contact the daemon
-            if subprocess.call(cmd + ["version"],
+            # 'version' is not sufficient to prove a working binary
+            # for podman. 'info' is a stronger check that is more
+            # likely to correlate with ability to create containers,
+            # and required to detect the need for podman remote
+            if subprocess.call(cmd + ["info"],
                                stdout=DEVNULL, stderr=DEVNULL) == 0:
                 return cmd
         except OSError:
-- 
2.53.0


