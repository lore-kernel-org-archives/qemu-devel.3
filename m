Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3D5C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wf0-0004tB-7H; Fri, 17 May 2024 08:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wex-0004pt-RL
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7weu-0006GR-Td
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DApQ+nXYtBVZETQJAHEg5UpK8ucf/TgF8ZwZ0VBl8WA=;
 b=Zui+fRPz6+tMCVInH4Kj4/YL7KAyK5NEd7HbLhr9UAeXW/gZx8qDYBwf7or2Q8Au5DYYlI
 acyuAtkoWe3x4ph3EKpYVsvZ3gixCjdra8QInH3aQhFUgh0IxOl72hJokWBRftWcGys4MK
 snrlDgMIz1d/b3tOx88M/Igww2qX4iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-9rcSEtlHOsC4-ZW48IcTAA-1; Fri, 17 May 2024 08:25:55 -0400
X-MC-Unique: 9rcSEtlHOsC4-ZW48IcTAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF95380066E;
 Fri, 17 May 2024 12:25:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4D9A1050173;
 Fri, 17 May 2024 12:25:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/6] Fix s390x crash and clean up container images
Date: Fri, 17 May 2024 14:25:46 +0200
Message-ID: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:

  Merge tag 'pull-maintainer-may24-160524-2' of https://gitlab.com/stsquad/qemu into staging (2024-05-16 10:02:56 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-05-17

for you to fetch changes up to bebe9603fcb072dcdb7fb22005781b3582a4d701:

  hw/intc/s390_flic: Fix crash that occurs when saving the machine state (2024-05-17 11:18:32 +0200)

----------------------------------------------------------------
* Fix s390x crash when doing migration / savevm
* Decrease size of CI containers by removing unnecessary packages

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      tests/lcitool: Remove 'xfsprogs' from QEMU

Thomas Huth (5):
      tests/lcitool/refresh: Treat the output of lcitool as text, not as bytes
      tests/lcitool: Remove g++ from the containers (except for the MinGW one)
      tests/lcitool/projects/qemu.yml: Sort entries alphabetically again
      tests/docker/dockerfiles: Update container files with "lcitool-refresh"
      hw/intc/s390_flic: Fix crash that occurs when saving the machine state

 hw/intc/s390_flic.c                                   |  2 +-
 tests/docker/dockerfiles/alpine.docker                |  4 ----
 tests/docker/dockerfiles/centos9.docker               |  4 ----
 tests/docker/dockerfiles/debian-amd64-cross.docker    |  4 ----
 tests/docker/dockerfiles/debian-arm64-cross.docker    |  4 ----
 tests/docker/dockerfiles/debian-armel-cross.docker    |  4 ----
 tests/docker/dockerfiles/debian-armhf-cross.docker    |  4 ----
 tests/docker/dockerfiles/debian-i686-cross.docker     |  4 ----
 tests/docker/dockerfiles/debian-mips64el-cross.docker |  4 ----
 tests/docker/dockerfiles/debian-mipsel-cross.docker   |  4 ----
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  |  4 ----
 tests/docker/dockerfiles/debian-riscv64-cross.docker  |  3 ---
 tests/docker/dockerfiles/debian-s390x-cross.docker    |  4 ----
 tests/docker/dockerfiles/debian.docker                |  4 ----
 tests/docker/dockerfiles/fedora-win64-cross.docker    |  2 +-
 tests/docker/dockerfiles/fedora.docker                |  4 ----
 tests/docker/dockerfiles/opensuse-leap.docker         |  4 ----
 tests/docker/dockerfiles/ubuntu2204.docker            |  4 ----
 tests/lcitool/projects/qemu-minimal.yml               |  1 -
 tests/lcitool/projects/qemu-win-installer.yml         |  4 ++++
 tests/lcitool/projects/qemu.yml                       | 18 ++++++++----------
 tests/lcitool/refresh                                 |  5 +++--
 22 files changed, 17 insertions(+), 78 deletions(-)
 create mode 100644 tests/lcitool/projects/qemu-win-installer.yml


