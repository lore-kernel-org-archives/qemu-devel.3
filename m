Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80CE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRgp-0005zz-VB; Wed, 08 Jan 2025 03:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgo-0005zo-GI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgm-0001jo-Mm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EvOBu5G6a1/HLBB+urgeWLcac3tXhJWb794dLI8+9GU=;
 b=EERnA23KcdhxtR6AMOQ9bowM8B2D3IlFt7RAu++wPsrSMEaWeMsV35v2ukflnj0GRYQMqN
 9ri7493+FFM6+mQSQdUfRjIUo++gajtINOI5LMm2JdeaNczEgvfJfFv4idAF8WKCfCOdKy
 9P9LsH8pT3tBJQtQZ2QowrIK3Utl9mY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-Bb1g1Rp5NEeOfpbgUwwNxQ-1; Wed,
 08 Jan 2025 03:45:16 -0500
X-MC-Unique: Bb1g1Rp5NEeOfpbgUwwNxQ-1
X-Mimecast-MFC-AGG-ID: Bb1g1Rp5NEeOfpbgUwwNxQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3A8F19560B2
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2025 08:45:15 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56A4919560AB; Wed,  8 Jan 2025 08:45:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/14] Fixes for tests and removal of deprecated features
Date: Wed,  8 Jan 2025 09:44:57 +0100
Message-ID: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6528013b5f5ba6bb3934b7f5fe57a3110680530f:

  Merge tag 'qga-pull-2025-01-06' of https://github.com/kostyanf14/qemu into staging (2025-01-06 09:39:02 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-01-08

for you to fetch changes up to f69705f300f487936919359354925395105ec018:

  tests/functional/test_x86_64_hotplug_cpu: Fix race condition during unplug (2025-01-07 15:02:46 +0100)

----------------------------------------------------------------
* Fix compilation problem in s390x tcg tests
* Remove obsolete versioned s390x machine types 2.4 up to 2.8
* Remove deprecated -runas command line option
* Fix the x86_64_hotplug_cpu functional test

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg/s390x: Use the SLOF libc headers for the multiarch tests

Thomas Huth (13):
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4 and 2.5 machine types
      hw/s390x/s390-skeys: Remove the "migration-enabled" property
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.6 machine type
      hw/s390x: Remove the "ri_allowed" switch
      hw/s390x/ipl: Remove the "iplbext_migration" property
      hw/s390x/css-bridge: Remove the "css_dev_path" property
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.7 machine type
      hw/s390x: Remove the cpu_model_allowed flag and related code
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.8 machine type
      hw/s390x: Remove the "adapter_routes_max_batch" property from the flic
      Remove the deprecated "-runas" command line option
      docs/about/deprecated: Remove paragraph about initial deprecation in 2.10
      tests/functional/test_x86_64_hotplug_cpu: Fix race condition during unplug

 docs/about/deprecated.rst                   |  12 ----
 docs/about/removed-features.rst             |   6 ++
 hw/s390x/ipl.h                              |   1 -
 include/hw/s390x/css-bridge.h               |   1 -
 include/hw/s390x/s390-virtio-ccw.h          |   6 --
 include/hw/s390x/s390_flic.h                |   2 -
 include/hw/s390x/storage-keys.h             |   2 -
 hw/intc/s390_flic.c                         |   9 ---
 hw/s390x/css-bridge.c                       |  16 +----
 hw/s390x/ipl.c                              |  10 ---
 hw/s390x/s390-skeys.c                       |  10 +--
 hw/s390x/s390-virtio-ccw.c                  | 108 +---------------------------
 hw/s390x/virtio-ccw.c                       |   5 +-
 system/vl.c                                 |   9 ---
 target/s390x/kvm/kvm.c                      |  16 ++---
 qemu-options.hx                             |  15 +---
 tests/functional/test_x86_64_hotplug_cpu.py |   6 +-
 tests/tcg/s390x/Makefile.softmmu-target     |   3 +-
 18 files changed, 24 insertions(+), 213 deletions(-)


