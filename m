Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459E8C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7RZ-000581-9S; Thu, 22 Feb 2024 06:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rd7RX-00057m-Qa
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rd7RV-0007Ob-Qn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708602044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p7g2eXheqTj3RZmVQplKMlOMB7UA11moCYxCP+wOg1o=;
 b=Hl70PmgGkrBC+J1yjDKmg9O+S17qFJqmvv2MVHeuZbVxjjbx7oWSfxNaYiGBt8rMHg5jFK
 +vITaI/DCRL473i3/UNuZgW5IjD6BIdQEP4LddXKe4aD1To3c8InyJJecoqOkFWrpnn+NM
 FSa8oYyHRhsHRZ8NtXqSBj4EX8vDjLg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-WK5WMDraOpSmzNgJFqf0sA-1; Thu,
 22 Feb 2024 06:40:41 -0500
X-MC-Unique: WK5WMDraOpSmzNgJFqf0sA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B054038117EB;
 Thu, 22 Feb 2024 11:40:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50FDE492BC6;
 Thu, 22 Feb 2024 11:40:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: force allow use of pip in Cirrus jobs
Date: Thu, 22 Feb 2024 11:40:38 +0000
Message-ID: <20240222114038.2348718-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Python is transitioning to a world where you're not allowed to use 'pip
install' outside of a virutal env by default. The rationale is to stop
use of pip clashing with distro provided python packages, which creates
a major headache on distro upgrades.

All our CI environments, however, are 100% disposable so the upgrade
headaches don't exist. Thus we can undo the python defaults to allow
pip to work.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

FYI lcitool recently added logic that purges the EXTERNALLY-MANAGED
marker in all the dockerfiles. QEMU will pick that up on the next
refresh, so Linux containers won't have trouble in future.

The macos/FreeBSD build env isn't fully managed by lcitool though,
so we need this manual addition to purge the marker that prevents
use of 'pip'.

This fixes the CI regression that just started hitting on Cirrus
CI macOS images, likely from homebrew python updates.

diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index 29d55c4aa3..43dd52dd19 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -21,7 +21,7 @@ build_task:
   install_script:
     - @UPDATE_COMMAND@
     - @INSTALL_COMMAND@ @PKGS@
-    - if test -n "@PYPI_PKGS@" ; then @PIP3@ install @PYPI_PKGS@ ; fi
+    - if test -n "@PYPI_PKGS@" ; then PYLIB=$(@PYTHON@ -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi
   clone_script:
     - git clone --depth 100 "$CI_REPOSITORY_URL" .
     - git fetch origin "$CI_COMMIT_REF_NAME"
-- 
2.43.0


