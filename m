Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB63CF259B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdWm-0003Ax-Fu; Wed, 19 Nov 2025 03:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdWl-0003Aa-5Y
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdWi-0000t0-Rx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wnb7eLGvb9UG6YkQCYyYCXgbmsY4/TeY3PBESQ85Ksw=;
 b=ibWOK90kYIDzL8ZKf0m9+o2qK9EWtKWEg0rh1VcNXr22uu6a06GsyiF7DjZVEKyGP4d8zz
 acLIu1SLuYZzS+IGExYtJpd3ZrF4fiWSi5BAmEHlg7d4Puqp8hPCi0j2RF5Ih2M2iYKM1/
 PNeqrTUL8TsIMH8gNiNmZqA4HAYCRGg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-Vz13GTCqM8Of8tG_GgPrag-1; Wed,
 19 Nov 2025 03:26:49 -0500
X-MC-Unique: Vz13GTCqM8Of8tG_GgPrag-1
X-Mimecast-MFC-AGG-ID: Vz13GTCqM8Of8tG_GgPrag_1763540806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 131CF19560A7; Wed, 19 Nov 2025 08:26:45 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E564180047F; Wed, 19 Nov 2025 08:26:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 00/15] tests/functional: Check Python code with pylint
Date: Wed, 19 Nov 2025 09:26:21 +0100
Message-ID: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apart from style issues, Pylint can help to detect real bugs in Python
code, so this patch series first introduces a pylintrc file that is
suitable for the code that we have in tests/functional, then cleans
up all current issues and finally introduces a test that checks the
files in the target folders automatically during each run (I still
need to ponder on where to best check for the generic code, but I had
a discussion with John S about pylint yesterday, so I wanted to get this
series on the list for discussion ... the generic part can also be added
later).

Note that patch 2 - 4 have already been reviewed, I just included them
for completeness here so that the linters check does not fail if anybody
wants to try it.

Thomas Huth (15):
  tests/functional: Add a pylintrc file
  tests/functional/riscv64/test_sifive_u: Remove unused import statement
  tests/functional/arm/test_aspeed_ast2600_buildroot: Fix pylint
    warnings
  tests/functional/x86_64/test_virtio_gpu: Fix various issues reported
    by pylint
  tests/functional/mips/test_malta: Silence warnings reported by pylint
  tests/functional/ppc64/test_hv: Silence warnings reported by pylint
  tests/functional/x86_64/test_reverse_debug: Silence pylint warning
  tests/functional/x86_64/test_memlock: Silence pylint warnings
  tests/functional/ppc/test_amiga: Fix issues reported by pylint and
    flake8
  tests/functional/ppc/test_ppe42: Fix style issues reported by pylint
  tests/functional/aarch64/test_virt_gpu: Fix style issues
  tests/functional/aarch64/test_reverse_debug: Fix issues reported by
    pylint
  tests/functional/aarch64/test_smmu: Silence warning from pylint
  tests/functional/aarch64/test_rme_sbsaref: Silence issues reported by
    pylint
  tests/functional: Add a generic test that checks the files with pylint

 MAINTAINERS                                   |  1 +
 .../functional/aarch64/test_reverse_debug.py  |  4 +-
 tests/functional/aarch64/test_rme_sbsaref.py  |  3 +-
 tests/functional/aarch64/test_smmu.py         |  1 +
 tests/functional/aarch64/test_virt_gpu.py     | 20 ++---
 .../arm/test_aspeed_ast2600_buildroot.py      | 21 ++---
 tests/functional/generic/meson.build          |  1 +
 tests/functional/generic/test_linters.py      | 41 ++++++++++
 tests/functional/mips/test_malta.py           |  8 +-
 tests/functional/ppc/test_amiga.py            |  6 +-
 tests/functional/ppc/test_ppe42.py            | 14 ++--
 tests/functional/ppc64/test_hv.py             | 10 +--
 tests/functional/pylintrc                     | 80 +++++++++++++++++++
 tests/functional/riscv64/test_sifive_u.py     |  1 -
 tests/functional/x86_64/test_memlock.py       |  6 +-
 tests/functional/x86_64/test_reverse_debug.py |  2 +-
 tests/functional/x86_64/test_virtio_gpu.py    | 56 ++++++-------
 17 files changed, 199 insertions(+), 76 deletions(-)
 create mode 100755 tests/functional/generic/test_linters.py
 create mode 100644 tests/functional/pylintrc

-- 
2.51.1


