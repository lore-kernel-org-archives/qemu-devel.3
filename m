Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95664C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYjs-0007iJ-RU; Wed, 24 Jul 2024 05:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYjb-0006nE-3S
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYjZ-0005gq-K5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NmlrT9p1OarQciUqlPTWev6rybL20qP61D21X1ruIRM=;
 b=NM0DkPA4SIhWElw2ni/mMHTLLOCmzZmH0nM85IYQe8tM1o21hbjXMPQw/JtqV78gSLFzBu
 C9zEXVa/Xv0pBSCTP0dgVArv4EzRmJjx4ibcVzvybvDJW+BQje8Z/yTW1Vm16mJPRthv1K
 ekdZAQOD7b+TAPJGWxsw24zykdrC3f4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-CNInXTOMNs2Qk09zJNU55w-1; Wed,
 24 Jul 2024 05:55:13 -0400
X-MC-Unique: CNInXTOMNs2Qk09zJNU55w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C957D1955F41; Wed, 24 Jul 2024 09:55:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E69F619560B2; Wed, 24 Jul 2024 09:55:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] gitlab: expose installed package info in build logs
Date: Wed, 24 Jul 2024 10:55:02 +0100
Message-ID: <20240724095505.33544-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Many times we see a build job start failing, we wonder if the installed
packages have changed since the last passing build. We can rarely
diagnose this, however, since we only have the new container image, not
the old one.

The lcitool generated containers create a /packages.txt file whose
content is intended to be output in the build phase, so record the
packages associated with the build.

This adds packages.txt to the manually written containers, and modifies
the build jobs to display this content. This will improve our future
debuggability of CI problems.

Daniel P. Berrangé (2):
  gitlab: record installed packages in /packages.txt in containers
  gitlab: display /packages.txt in build jobs

 .gitlab-ci.d/buildtest-template.yml                      | 1 +
 .gitlab-ci.d/crossbuild-template.yml                     | 2 ++
 tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
 tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
 8 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.45.2


