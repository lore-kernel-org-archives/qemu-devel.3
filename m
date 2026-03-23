Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2692DF4610F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fOX-0000Xy-Bv; Mon, 23 Mar 2026 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w4fOP-0000Ui-U1; Mon, 23 Mar 2026 09:32:29 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w4fOM-00028q-Pi; Mon, 23 Mar 2026 09:32:29 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3KYXeQMFpg09sCA--.1129S2;
 Mon, 23 Mar 2026 21:32:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwwZLcQMFp0nsEAA--.10052S3;
 Mon, 23 Mar 2026 21:32:12 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 0/4] tests/qtest: Add memory-access attributes (secure/space)
Date: Mon, 23 Mar 2026 21:32:06 +0800
Message-Id: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwwZLcQMFp0nsEAA--.10052S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQADBWnAQfgOwgAJsS
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gryrur1fXr4kJr1xWrykKrg_yoW7Xr4rpF
 ZxA3W3Kr48JF1xAw4fJa10qFyYka97C3W7XFnFyr18CFWYyFy7Zry2k34Fqr9xGrZ5Xr1Y
 93WqyFs3Wrn8taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is v3 of the patch series adding support for memory access attributes
(secure / security-space selection) in the qtest framework.

Thanks to everyone who reviewed the previous version and provided valuable
feedback.

The main change from v2 is that the series is now structured around verifying
that attrs select the intended AddressSpace, rather than only extending the
qtest syntax. To make that explicit, v3 splits the implementation by layer and
strengthens the tests around real address-space differences on both Arm and x86.

The major changes from v2 include:

- split the old combined protocol/libqtest change into separate qtest server
  and libqtest helper patches
- refactor libqtest response parsing and add qtest_raw_cmd(), so tests can
  inspect non-OK replies directly
- make qtest memory access failures return ERR via qtest_send_memtx_error(),
  enabling negative testing of address-space mismatches
- rework qtest-attrs-test on Arm to target the virt secure-only RAM window,
  and add negative coverage for space=realm and for non-secure accesses into
  secure-only RAM
- switch x86 coverage to q35,smm=on and add a NOT-MERGE q35-only SMM test RAM
  path plus a dedicated qtest-x86-attrs-test, so secure accesses can be
  cross-checked against an address visible only in the SMM address space


Motivation
----------

IOMMU functional testing is always stack-heavy: for example, even for the
Non-secure Arm SMMU model, end-to-end validation can require a fairly involved
software stack. To keep the testing loop tight and reproducible, I previously
proposed using iommu-testdev + QTest to validate IOMMU/SMMU behaviour without
booting a guest [1].

[1] https://www.qemu.org/docs/master/specs/iommu-testdev.html

However, the current QTest interface cannot tag memory accesses with MemTxAttrs,
so it is hard to write targeted tests for security-sensitive paths. This becomes
a bigger issue for Secure SMMU work, which is RFCing in [2], and for future Arm
RME-DA enablement.

[2] https://lore.kernel.org/qemu-devel/20260221100250.2976287-1-tangtao1634@phytium.com.cn/

This series therefore extends qtest memory access commands with an optional
attrs argument, adds matching libqtest helpers, and introduces tests that
exercise the new APIs against address spaces that actually differ by security
context.

In particular:
- on Arm virt,secure=on, the test now uses the secure-only RAM window so the
  requested attrs must select the correct AddressSpace
- on x86 q35,smm=on, the API series covers normal RAM, and an extra NOT-MERGE
  validation patch adds an SMM-only RAM window so the secure path can be
  cross-checked against a location not visible from the default address space


Compatibility
-------------

This series is additive for existing qtest users:
- Existing qtest memory commands keep their current forms; attrs is an optional
  extra argument
- Existing libqtest memory helpers remain available and are kept as wrappers
  passing NULL attrs
- The first three patches are the upstreamable API and test additions
- The fourth patch is explicitly marked NOT-MERGE and only provides extra x86
  RFC coverage by wiring in a q35 test-only SMM RAM window

One behavioural improvement is that memory access failures on the new paths are
now reported consistently as ERR, which lets tests validate address-space
selection failures directly.


Testing
-------

The API series was exercised with:

  meson test -C build \
      "qtest-aarch64/qtest-attrs-test" \
      "qtest-i386/qtest-attrs-test" \
      "qtest-x86_64/qtest-attrs-test"

The extra x86 cross-check from the NOT-MERGE patch was exercised with:

  meson test -C build \
      "qtest-i386/qtest-x86-attrs-test" \
      "qtest-x86_64/qtest-x86-attrs-test"


Future work
-----------

Once the Secure SMMU series lands, I plan to build on this qtest API to extend
iommu-testdev-based tests to cover more security contexts while still avoiding
a full guest software stack.

This series is also available in a branch below [3]:
[3] https://gitlab.com/TaoTang/qemu/-/tree/series/qtest-secure-api-v3-6

CI is all green [4]:
[4] https://gitlab.com/TaoTang/qemu/-/pipelines/2399350916


Tao Tang (4):
  tests/qtest: Add attrs support to qtest server memory commands
  tests/qtest: Add libqtest attrs helpers for memory accesses
  tests/qtest: Add qtest-attrs-test for memory access attrs
  [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs coverage

 hw/pci-host/q35.c                  |  24 ++
 include/hw/pci-host/q35.h          |   8 +
 system/qtest.c                     | 517 ++++++++++++++++++++++++++---
 tests/qtest/libqtest-single.h      | 156 +++++++++
 tests/qtest/libqtest.c             | 246 +++++++++++---
 tests/qtest/libqtest.h             | 177 ++++++++++
 tests/qtest/meson.build            |   8 +-
 tests/qtest/qtest-attrs-test.c     | 305 +++++++++++++++++
 tests/qtest/qtest-x86-attrs-test.c | 109 ++++++
 9 files changed, 1439 insertions(+), 111 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

-- 
2.34.1


