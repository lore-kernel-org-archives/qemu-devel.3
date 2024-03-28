Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F8C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqOz-0004FK-BL; Thu, 28 Mar 2024 10:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqOy-0004Eh-2G
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqOv-0004JO-EZ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711634798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IU0zAqJx2YRbCREEzLSl4PhjliFqcfa5vo/U2YXRPtE=;
 b=SFna1B2E8PUqqek/uqchg2wBsbitvWkxZJqyPXc0sgYcsDJp87KjkNT8P7FEH5NFaArutH
 D98q120XhEWu7C8b5dmV4CYhX38sVXm9cLMttArUa9W0JKOnDExXJPhrSpTECkpSQa1I1a
 pnGtonji68oSryVGxloUTCQL5AwBmiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-MoVVxzqOOZinhrFWgo5okw-1; Thu, 28 Mar 2024 10:06:35 -0400
X-MC-Unique: MoVVxzqOOZinhrFWgo5okw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B8B6801907;
 Thu, 28 Mar 2024 14:06:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F1FD40C6CB1;
 Thu, 28 Mar 2024 14:06:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH for-9.1 0/9] Switch to glib URI parsing code
Date: Thu, 28 Mar 2024 15:05:57 +0100
Message-ID: <20240328140607.2433889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

Thomas Huth (9):
  tests: Remove Ubuntu 20.04 container
  tests/lcitool/libvirt-ci: Update to the latest master branch
  tests: Update our CI to use CentOS Stream 9 instead of 8
  Bump minimum glib version to v2.66
  block/gluster: Use URI parsing code from glib
  block/nbd: Use URI parsing code from glib
  block/nfs: Use URI parsing code from glib
  block/ssh: Use URI parsing code from glib
  util/uri: Remove the old URI parsing code

 meson.build                                   |   16 +-
 include/glib-compat.h                         |   27 +-
 include/qemu/uri.h                            |   99 --
 block/gluster.c                               |   63 +-
 block/nbd.c                                   |   66 +-
 block/nfs.c                                   |  102 +-
 block/ssh.c                                   |   69 +-
 qga/commands-posix-ssh.c                      |    4 +-
 util/uri.c                                    | 1466 -----------------
 .gitlab-ci.d/buildtest.yml                    |   16 +-
 .gitlab-ci.d/container-core.yml               |    4 +-
 .../{centos8.docker => centos9.docker}        |   34 +-
 tests/docker/dockerfiles/ubuntu2004.docker    |  157 --
 tests/lcitool/libvirt-ci                      |    2 +-
 tests/lcitool/mappings.yml                    |   20 -
 tests/lcitool/refresh                         |    3 +-
 tests/vm/centos                               |    4 +-
 util/meson.build                              |    2 +-
 18 files changed, 200 insertions(+), 1954 deletions(-)
 delete mode 100644 include/qemu/uri.h
 delete mode 100644 util/uri.c
 rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker

-- 
2.44.0


