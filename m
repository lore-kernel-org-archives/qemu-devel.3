Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ABAC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuj2H-0006A2-A2; Thu, 13 Aug 2026 23:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2F-00069c-6V; Thu, 13 Aug 2026 23:56:47 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2C-0007r8-OE; Thu, 13 Aug 2026 23:56:46 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwC3qaHxkX5qj3ToAA--.5736S2;
 Fri, 14 Aug 2026 11:56:33 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfXPskX5qW1IjAA--.62931S3;
 Fri, 14 Aug 2026 11:56:29 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 0/5] tests/qtest: Add memory-access attributes (secure/space)
Date: Fri, 14 Aug 2026 11:56:23 +0800
Message-Id: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfXPskX5qW1IjAA--.62931S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWp+G0sCCgAAsP
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFW7AFWfKrWDXryUtrWxtFb_yoWrZry3pa
 y3AF13Kr48JF17Jws3Ja18Xa45Krs3GF17Jr17tryUuFWYyFy7Zry2kryFqr9xGrW8Xr1Y
 934qyrn8Wrn8t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is v5 of the qtest memory-access attributes series. Thanks to everyone who
reviewed v4 and provided feedback.

Since v4:
- server-side attrs handling has been simplified
- raw response handling has been split into a preparatory patch, and reusable
libqtest assertions and typed failure helpers have been added
- raw commands are now used only for malformed protocol forms.

This series is also available in a branch below:
https://gitlab.com/TaoTang/qemu/tree/qtest-secure-v5

CI is all green:
https://gitlab.com/TaoTang/qemu/-/pipelines/2757894685


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

[2] https://lore.kernel.org/qemu-devel/20260813161515.2788900-1-tangtao1634@phytium.com.cn/

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
- The first 4 patches are the upstreamable API and test additions
- The 5th patch is explicitly marked NOT-MERGE and only provides extra x86
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
a full guest software stack. There is an experimental branch that already uses
this API to validate secure/non-secure SMMU behaviour:

https://gitlab.com/TaoTang/qemu/tree/integration/secure-smmu-v5-qtest


Tao Tang (5):
  tests/qtest: Add attrs support to qtest server memory commands
  tests/qtest: Add libqtest attrs helpers for memory accesses
  tests/qtest: Add raw command response helper
  tests/qtest: Add qtest-attrs-test for memory access attrs
  [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs coverage

 hw/pci-host/q35.c                  |  27 ++
 include/hw/pci-host/q35.h          |   8 +
 system/qtest.c                     | 349 +++++++++++++++++++++----
 tests/qtest/libqtest-single.h      | 156 +++++++++++
 tests/qtest/libqtest.c             | 402 +++++++++++++++++++++++++----
 tests/qtest/libqtest.h             | 288 +++++++++++++++++++++
 tests/qtest/meson.build            |   8 +-
 tests/qtest/qtest-attrs-test.c     | 305 ++++++++++++++++++++++
 tests/qtest/qtest-x86-attrs-test.c | 170 ++++++++++++
 9 files changed, 1600 insertions(+), 113 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

--
2.34.1


