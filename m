Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC04CFD624
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTBH-00053v-97; Wed, 07 Jan 2026 08:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAq-0004xl-2H
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAo-0007Ci-3x
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767790921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4Uz4rRm9B/EE4B8XQ5L8GzOl07s7UZfL8UdwPhSerg=;
 b=jSyp+1PAwcnbxm8nqwlomrveMUgMdeXNwCqvVhxbQWVbx/x/IxHnWAfNpFZvaHJsQgSM/v
 0fCbAom+RUEuPeiqdceo9K4EzprX4vl8an3mRXL9FeCKDad9zON2ac7cUSAGrHrhzHRlYJ
 2XKU+DZS1ZSIkF+M+rlMeBUEWaRN/H4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-1QwNuJ4gM-iumeBsmtQngA-1; Wed,
 07 Jan 2026 08:01:58 -0500
X-MC-Unique: 1QwNuJ4gM-iumeBsmtQngA-1
X-Mimecast-MFC-AGG-ID: 1QwNuJ4gM-iumeBsmtQngA_1767790917
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A8FF1956095; Wed,  7 Jan 2026 13:01:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6092B19560A2; Wed,  7 Jan 2026 13:01:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/4] tests/docker: add support for podman remote access
Date: Wed,  7 Jan 2026 13:01:45 +0000
Message-ID: <20260107130145.1495219-5-berrange@redhat.com>
In-Reply-To: <20260107130145.1495219-1-berrange@redhat.com>
References: <20260107130145.1495219-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 tests/docker/docker.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ff68c7bf6f..9e18b984f4 100755
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
2.52.0


