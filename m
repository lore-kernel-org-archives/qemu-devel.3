Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgY-0000fs-Is; Tue, 30 Apr 2024 03:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgV-0000d6-GW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgR-0008Ip-G5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qGDoqtPDuTiTw5GE87oBotEpJp7zqaj/pWfh+naH+kA=;
 b=evysNtPIeBlR9hEhCMQK4j01JICNIUEtwuVUDbJRSt8krJmbl77pP2CI+Cnwd8rpGeYnfF
 Wa0Vb0o7Vz8J5a9E7agoR7zJNN8F6qHtwTRXwKOoxmmEE9tKnhABdvv9snj2DT3ntzUHwQ
 Hx4DuDRVeRC4YrjN4xqeyrxT/ZWBZZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-q1BfkuTtMLetKDCNfOWQeg-1; Tue,
 30 Apr 2024 03:13:43 -0400
X-MC-Unique: q1BfkuTtMLetKDCNfOWQeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00B8C29AB425;
 Tue, 30 Apr 2024 07:13:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC4D40C6CC0;
 Tue, 30 Apr 2024 07:13:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/19] Misc patches (s390x clean-ups, fixes for crashes, ...)
Date: Tue, 30 Apr 2024 09:13:21 +0200
Message-ID: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

 Hi Richard!

The following changes since commit 5fee33d97a7f2e95716417bd164f2f5264acd976:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2024-04-29 14:34:25 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-30

for you to fetch changes up to cc6cb422e09592158586279fddeef107df05ecbb:

  .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs (2024-04-30 07:09:22 +0200)

----------------------------------------------------------------
* Clean-ups for "errp" handling in s390x cpu_model code
* Fix a possible abort in the "edu" device
* Add missing qga stubs for stand-alone qga builds and re-enable qga-ssh-test
* Fix memory corruption caused by the stm32l4x5 uart device
* Update the s390x custom runner to Ubuntu 22.04
* Fix READ NATIVE MAX ADDRESS IDE commands to avoid a possible crash
* Shorten the runtime of Cirrus-CI jobs

----------------------------------------------------------------
Alex Bennée (3):
      build-environment: make some packages optional
      gitlab: migrate the s390x custom machine to 22.04
      gitlab: remove stale s390x-all-linux-static conf hacks

Chris Friedt (3):
      hw: misc: edu: fix 2 off-by-one errors
      hw: misc: edu: rename local vars in edu_check_range
      hw: misc: edu: use qemu_log_mask instead of hw_error

Konstantin Kostiuk (1):
      stubs: Add missing qga stubs

Lev Kujawski (2):
      hw/ide/core.c (cmd_read_native_max): Avoid limited device parameters
      tests/qtest/ide-test: Verify READ NATIVE MAX ADDRESS is not limited

Thomas Huth (4):
      qga: Re-enable the qga-ssh-test when running without fuzzing
      hw/char/stm32l4x5_usart: Fix memory corruption by adding correct class_size
      .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
      .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs

Zhao Liu (6):
      target/s390x/cpu_model: Make check_compatibility() return boolean
      target/s390x/cpu_model: Drop local @err in s390_realize_cpu_model()
      target/s390x/cpu_models: Make kvm_s390_get_host_cpu_model() return boolean
      target/s390x/cpu_models: Drop local @err in get_max_cpu_model()
      target/s390x/cpu_models: Make kvm_s390_apply_cpu_model() return boolean
      target/s390x/cpu_models_sysemu: Drop local @err in apply_cpu_model()

 target/s390x/cpu_models.h                          |  4 +-
 hw/char/stm32l4x5_usart.c                          |  1 +
 hw/ide/core.c                                      | 21 ++++++++--
 hw/misc/edu.c                                      | 35 ++++++++--------
 target/s390x/cpu_models.c                          | 25 +++++-------
 target/s390x/cpu_models_sysemu.c                   |  5 +--
 target/s390x/kvm/kvm.c                             | 28 +++++++------
 tests/qtest/ide-test.c                             | 47 +++++++++++++++++++++-
 .gitlab-ci.d/cirrus.yml                            | 39 +-----------------
 .gitlab-ci.d/cirrus/kvm-build.yml                  | 31 --------------
 .gitlab-ci.d/custom-runners.yml                    |  2 +-
 ...untu-20.04-s390x.yml => ubuntu-22.04-s390x.yml} | 32 +++++++--------
 qga/meson.build                                    |  5 +--
 scripts/ci/setup/build-environment.yml             | 16 ++++++--
 stubs/meson.build                                  |  6 ++-
 15 files changed, 149 insertions(+), 148 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/kvm-build.yml
 rename .gitlab-ci.d/custom-runners/{ubuntu-20.04-s390x.yml => ubuntu-22.04-s390x.yml} (80%)


