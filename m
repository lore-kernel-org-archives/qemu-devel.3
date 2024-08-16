Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3071FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serIQ-0005f1-PP; Fri, 16 Aug 2024 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1serIE-0005Lm-WA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1serI8-0003xJ-FJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723792948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f14MeNgd5nDWpMXWRSulFTE1qYJmTLvsoRH24Zu7Bys=;
 b=SxJs6GAAsTNxFyC1L6t9LbDqE1sjoJidD0FEF8TxZdiURGBwS42YZoNKSlZ3b50qqfBu+J
 gM2sF83RGhLwX5YoZf91bNtj57y4zRjw3YrLJEgEO8M8l1sEW4YsI0/jpi6pTjYItqTOTi
 fUU8mslFD8kCKoIjQtFbKNpHmCmfpiE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-YHfeLwJ4MeOPeGt4wuLfmA-1; Fri,
 16 Aug 2024 03:22:24 -0400
X-MC-Unique: YHfeLwJ4MeOPeGt4wuLfmA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3259519560B0; Fri, 16 Aug 2024 07:22:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.75])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D49701956054; Fri, 16 Aug 2024 07:22:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/5] Some small tests and s390x fixes
Date: Fri, 16 Aug 2024 09:22:13 +0200
Message-ID: <20240816072218.27125-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

 Hi Richard!

The following changes since commit b0d6c037ea0a825192285f149af72a73a1baaa04:

  Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-08-16

for you to fetch changes up to b4be15a9f9e73fa2e7c46da559f10afc94018984:

  ci: refresh package lists with lcitool (2024-08-16 09:16:03 +0200)

----------------------------------------------------------------
* Fix a potential build warning in the s390x target code
* Check for the availability of __attribute__((gcc_struct)) on MSYS2
* Fix skipUnless decorators in Avocado tests
* Add missing gtk-vnc package to the CI jobs

----------------------------------------------------------------
Cleber Rosa (1):
      tests/avocado: apply proper skipUnless decorator

Daniel P. Berrangé (2):
      ci: add gtk-vnc to the deps
      ci: refresh package lists with lcitool

Pierrick Bouvier (1):
      target/s390x: fix build warning (gcc-12 -fsanitize=thread)

Thomas Huth (1):
      meson.build: Check for the availability of __attribute__((gcc_struct)) on MSYS2

 meson.build                                           | 5 +++++
 target/s390x/tcg/translate.c                          | 1 -
 .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/avocado/boot_linux_console.py                   | 1 -
 tests/avocado/intel_iommu.py                          | 1 -
 tests/avocado/linux_initrd.py                         | 1 -
 tests/avocado/machine_aspeed.py                       | 2 --
 tests/avocado/machine_mips_malta.py                   | 2 --
 tests/avocado/machine_rx_gdbsim.py                    | 1 -
 tests/avocado/reverse_debugging.py                    | 4 ----
 tests/avocado/smmu.py                                 | 1 -
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 tests/vm/generated/freebsd.json                       | 1 +
 32 files changed, 27 insertions(+), 17 deletions(-)


