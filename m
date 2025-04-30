Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E979C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACW7-0003Mc-Vf; Wed, 30 Apr 2025 14:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACW5-0003Lk-I2
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACW3-0008HK-9F
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3FfK8u08oVV8pviIgKJKmYZYnSq6V3WDTwB072H8SUI=;
 b=LEdJ/rjHVAsofx5Njt6NN4/iFXNH3rHU86ErxXZhguNwxJv2V3xU5makhyYF90Nn6WLEv8
 qWEXhljtCa2vF6jk+IxP1mx9NAM9vBSXdKUJBiTpuUHC0PF6EqBkYp5afjF0JvHZ58exUD
 Drpja0lcGe+AMRb8ZE2+Zv1G2xkY2VE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-QoPPYL_6N46hWzukkxJvqA-1; Wed,
 30 Apr 2025 14:50:39 -0400
X-MC-Unique: QoPPYL_6N46hWzukkxJvqA-1
X-Mimecast-MFC-AGG-ID: QoPPYL_6N46hWzukkxJvqA_1746039039
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBD991800261
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 18:50:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5E7019560A3; Wed, 30 Apr 2025 18:50:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] Misc patches (s390x, build env, clean-ups)
Date: Wed, 30 Apr 2025 20:50:26 +0200
Message-ID: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 73d29ea2417b58ca55fba1aa468ba38e3607b583:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-04-27 12:47:23 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-04-30

for you to fetch changes up to dce324fa06b358ccb01bf35611b6fc53b1f56b96:

  docs/devel/build-environment: enhance MSYS2 instructions (2025-04-30 20:44:20 +0200)

----------------------------------------------------------------
* Extend s390x diagnose call 308 subcode 10 to return more information
* Make valgrind support configurable
* Drop support for Python 3.8
* Some other misc cosmetic changes

----------------------------------------------------------------
Daniel P. Berrangé (1):
      meson/configure: add 'valgrind' option & --{en, dis}able-valgrind flag

Gautam Gala (3):
      target/s390x: Introduce constant when checking if PV header couldn't be decrypted
      target/s390x: Introduce function when exiting PV
      target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308 Subcode 10 fails to enter secure mode

Philippe Mathieu-Daudé (1):
      hw/rtc/mc146818rtc: Drop pre-v3 migration stream support

Pierrick Bouvier (1):
      docs/devel/build-environment: enhance MSYS2 instructions

Thomas Huth (3):
      Drop support for Python 3.8
      tests/functional/test_ppc64_pseries: Skip test_ppc64_linux_smt_boot if necessary
      meson.build: Put the D-Bus summary into the UI section

 docs/about/build-platforms.rst         |  2 +-
 docs/devel/build-environment.rst       |  4 +--
 configure                              | 14 ++++----
 meson.build                            | 15 ++++++--
 hw/s390x/ipl.h                         |  6 ++--
 target/s390x/kvm/pv.h                  | 26 ++++++++++----
 hw/rtc/mc146818rtc.c                   | 18 +++++-----
 hw/s390x/ipl.c                         | 11 +++---
 hw/s390x/s390-virtio-ccw.c             | 14 ++++----
 target/s390x/kvm/pv.c                  | 66 ++++++++++++++++++++++------------
 meson_options.txt                      |  2 ++
 python/Makefile                        |  8 ++---
 python/setup.cfg                       |  7 ++--
 python/tests/minreqs.txt               |  2 +-
 scripts/meson-buildoptions.sh          |  3 ++
 scripts/qapi/mypy.ini                  |  2 +-
 tests/docker/dockerfiles/python.docker |  1 -
 tests/functional/test_ppc64_pseries.py |  1 +
 18 files changed, 126 insertions(+), 76 deletions(-)


