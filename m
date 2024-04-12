Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C725C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 13:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGtP-0002vU-Eh; Fri, 12 Apr 2024 09:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtN-0002ut-P1
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtK-00076x-JE
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712928268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fi84kRaz7h99oBfhODi8u2Fa4iXGQNDWIt/C1FT1Ue4=;
 b=IHIVYP/LfmuFU3lpzHNaHFvX+7+4q88wKKnLLEM/RS+yDUW1aEtr+6a79HfogcHtXT/Ctv
 w9UOX7BtGvzqMyjBqSanx+pdNA7pBN5xl9sBdby9o4ldQzQoKJavqKuR4g9RsL01FOUTA9
 QdFLs0SZl0v9hsGXofkeBjBm9mXmi9o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-lySKy0kKOWW6NsPvnY2eBw-1; Fri,
 12 Apr 2024 09:24:25 -0400
X-MC-Unique: lySKy0kKOWW6NsPvnY2eBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A4E838035B5;
 Fri, 12 Apr 2024 13:24:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BFB92166B31;
 Fri, 12 Apr 2024 13:24:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 00/13] Drop old distros,
 bump glib and switch to glib URI parsing code
Date: Fri, 12 Apr 2024 15:24:02 +0200
Message-ID: <20240412132415.282354-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the QEMU 9.1 development cycle, we can drop the support for
Ubuntu 20.04 and CentOS 8 since the following major versions of
these distributions are available since 2 years already.

This allows us to bump the minimum version of glib to 2.66 which
comes with a nice set of URI parsing functions. By switching to
these parsing functions, we can finally drop our own URI parsing
code in util/uri.c.

NB: We also need to update some of the custom runners in our CI
environment first (since they still use Ubuntu 20.04).

v2:
- Added Paolo's patch to bump the external CI runners
- Added patch to drop more glib compatibility hunks
- Use g_autoptr() in the URI patches for simplification
- Don't allow port 0 in the URIs

Paolo Bonzini (1):
  ci: move external build environment setups to CentOS Stream 9

Thomas Huth (12):
  tests: Remove Ubuntu 20.04 container
  tests/lcitool/libvirt-ci: Update to the latest master branch
  tests/docker/dockerfiles: Run lcitool-refresh after the lcitool update
  tests: Update our CI to use CentOS Stream 9 instead of 8
  .travis.yml: Update the jobs to Ubuntu 22.04
  Bump minimum glib version to v2.66
  Remove glib compatibility code that is not required anymore
  block/gluster: Use URI parsing code from glib
  block/nbd: Use URI parsing code from glib
  block/nfs: Use URI parsing code from glib
  block/ssh: Use URI parsing code from glib
  util/uri: Remove the old URI parsing code

 meson.build                                   |   16 +-
 include/glib-compat.h                         |   27 +-
 include/qemu/uri.h                            |   99 --
 block/gluster.c                               |   71 +-
 block/nbd.c                                   |   76 +-
 block/nfs.c                                   |  110 +-
 block/ssh.c                                   |   75 +-
 qga/commands-posix-ssh.c                      |   12 +-
 util/error-report.c                           |   10 -
 util/uri.c                                    | 1466 -----------------
 .gitlab-ci.d/buildtest.yml                    |   16 +-
 .gitlab-ci.d/container-core.yml               |    4 +-
 .travis.yml                                   |   13 +-
 .../stream/{8 => 9}/build-environment.yml     |   31 +-
 .../stream/{8 => 9}/x86_64/configure          |    4 +-
 .../stream/{8 => 9}/x86_64/test-avocado       |    0
 scripts/ci/setup/build-environment.yml        |   44 +-
 tests/docker/dockerfiles/alpine.docker        |    3 +-
 .../{centos8.docker => centos9.docker}        |   35 +-
 .../dockerfiles/debian-amd64-cross.docker     |    3 +-
 .../dockerfiles/debian-arm64-cross.docker     |    3 +-
 .../dockerfiles/debian-armel-cross.docker     |    3 +-
 .../dockerfiles/debian-armhf-cross.docker     |    3 +-
 .../dockerfiles/debian-i686-cross.docker      |    3 +-
 .../dockerfiles/debian-mips64el-cross.docker  |    3 +-
 .../dockerfiles/debian-mipsel-cross.docker    |    3 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |    3 +-
 .../dockerfiles/debian-riscv64-cross.docker   |    3 +-
 .../dockerfiles/debian-s390x-cross.docker     |    3 +-
 tests/docker/dockerfiles/debian.docker        |    1 +
 .../dockerfiles/fedora-win64-cross.docker     |    3 +-
 tests/docker/dockerfiles/fedora.docker        |    1 +
 tests/docker/dockerfiles/opensuse-leap.docker |    1 +
 tests/docker/dockerfiles/ubuntu2004.docker    |  157 --
 tests/docker/dockerfiles/ubuntu2204.docker    |    1 +
 tests/lcitool/libvirt-ci                      |    2 +-
 tests/lcitool/mappings.yml                    |   20 -
 tests/lcitool/refresh                         |    3 +-
 tests/vm/centos                               |    4 +-
 util/meson.build                              |    2 +-
 40 files changed, 265 insertions(+), 2072 deletions(-)
 delete mode 100644 include/qemu/uri.h
 delete mode 100644 util/uri.c
 rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)
 rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker

-- 
2.44.0


