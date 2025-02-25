Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7978C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmskv-0000I6-1c; Tue, 25 Feb 2025 06:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmsks-0000H4-CR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmskp-000742-1t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740481532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LoaMERf8SxvE5HXDzgAZo7ed44gFtlIyuBdEBbTa6O4=;
 b=OfnazSx7/kNA4yWqP0Yi5T/0kdqSYjVaGFo/jTNyci9MnMJK6a3INDmJ2UptXfXjroAOpZ
 JzRpwzk3ABZ9wv+0EjJ8yFrf4eVLDHx/fUJ00V/ZmISUCSK7BLLtu6R2roZBuLz16X/Jh1
 5NLCQ93zX1LixxkO69qwprFMoyVbsT0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-1uTLgOS2Prmho7cYdyub8g-1; Tue,
 25 Feb 2025 06:05:31 -0500
X-MC-Unique: 1uTLgOS2Prmho7cYdyub8g-1
X-Mimecast-MFC-AGG-ID: 1uTLgOS2Prmho7cYdyub8g_1740481530
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D8BD180036F; Tue, 25 Feb 2025 11:05:30 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCD001955BD4; Tue, 25 Feb 2025 11:05:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: use --refetch in check-patch/check-dco jobs
Date: Tue, 25 Feb 2025 11:05:25 +0000
Message-ID: <20250225110525.2209854-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When gitlab initializes the repo checkout for a CI job, it will have
done a shallow clone with only partial history. Periodically the objects
that are omitted cause trouble with the check-patch/check-dco jobs. This
is exhibited as reporting strange errors being unable to fetch certain
objects that are known to exist.

Passing the --refetch flag to 'git fetch' causes it to not assume the
local checkout has all common objects and thus re-fetch everything that
is needed. This appears to solve the check-patch/check-dco job failures.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/check-dco.py   | 2 +-
 .gitlab-ci.d/check-patch.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index 70dec7d6ee..2fd56683dc 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -21,7 +21,7 @@
 
 print(f"adding upstream git repo @ {repourl}")
 subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
-subprocess.check_call(["git", "fetch", "check-dco", "master"])
+subprocess.check_call(["git", "fetch", "--refetch", "check-dco", "master"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-dco/master", "HEAD"],
diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 68c549a146..be13e6f77d 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -24,7 +24,7 @@
 # base for the user's branch. We thus need to figure out a common
 # ancestor between the user's branch and current git master.
 subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
-subprocess.check_call(["git", "fetch", "check-patch", "master"])
+subprocess.check_call(["git", "fetch", "--refetch", "check-patch", "master"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-patch/master", "HEAD"],
-- 
2.47.1


