Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACC9CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlfQ-0005d5-JJ; Mon, 20 Oct 2025 04:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAlfO-0005bz-BK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAlfI-0002m0-1n
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760950488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O1N9QInq52Rbjr0nA9tnuHakpsGPPATamIrihiZF08w=;
 b=c456EXYU2anVFC29li2MaiIr4kdvwixuCnm+x5FJr92KIh6lxlMYuxSffO//bLVS44w4dy
 QYzRbOXgJxZGWOnRzR93z2zW1DIH1b0zQU7TntTJv/ij1K4HBcNyjGJPv4YlF08BZmuMRs
 0IVVqZDof/dFgmJmsfqR4C5axxdFRcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-iChkPPDiOdCetpC1j7ZCAw-1; Mon,
 20 Oct 2025 04:54:38 -0400
X-MC-Unique: iChkPPDiOdCetpC1j7ZCAw-1
X-Mimecast-MFC-AGG-ID: iChkPPDiOdCetpC1j7ZCAw_1760950477
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C431805C04; Mon, 20 Oct 2025 08:54:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CE8C1800589; Mon, 20 Oct 2025 08:54:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab-ci: Decrease the size of the compiler cache
Date: Mon, 20 Oct 2025 10:54:31 +0200
Message-ID: <20251020085431.23968-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Uploading the cache from the runner takes a long time in the MSYS2
job, mostly due to the size of the compiler cache.
However, looking at runs with a non-initialized cache, and by doing
a "du -sh ." in the build directory, it seems like a build only
takes about 236 MiB of data, so the compiler cache with 500 MiB
certainly contains a lot of stale files. Thus decrease the size of
the ccache to a more reasonable value to speed up the MSYS2 job in
our CI (and add a "du -sh" at the end to have a reference for the
required cache size in the future).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Looking at the latest runs in the CI, our recent attempt to decrease
 the cache size by cleaning the pacman cache did not help much:
 https://gitlab.com/qemu-project/qemu/-/jobs/11747329283
 ... that run contains the "pacman -Sc" command, but the "Saving cache
 for successful job" step at the end still takes close to 20 minutes.
 So we likely have to shrink the compiler cache, too. In this run here:
 https://gitlab.com/thuth/qemu/-/jobs/11770708859#L1769
 I added a "du -sh" and you can see that the build directory only
 takes 236 MB there. So a ccache with the size of 250M should be
 sufficient for the MSYS2 job.

 .gitlab-ci.d/windows.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 6e1135d8b86..e2fef543899 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -94,7 +94,7 @@ msys2-64bit:
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
   - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
-  - $env:CCACHE_MAXSIZE = "500M"
+  - $env:CCACHE_MAXSIZE = "250M"
   - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
   - $env:CC = "ccache gcc"
   - mkdir build
@@ -103,5 +103,6 @@ msys2-64bit:
   - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
   - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
+  - ..\msys64\usr\bin\bash -lc "du -sh ."
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
-- 
2.51.0


