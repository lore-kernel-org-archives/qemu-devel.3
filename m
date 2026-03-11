Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF01125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lq2-0003NX-BG; Wed, 11 Mar 2026 11:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpf-00039s-Is; Wed, 11 Mar 2026 11:50:50 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpb-0001Zk-TA; Wed, 11 Mar 2026 11:50:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3jUVNj7FpI3HJAA--.50916S2;
 Wed, 11 Mar 2026 23:50:37 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwW5JGj7Fpf8UAAA--.812S3;
 Wed, 11 Mar 2026 23:50:31 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v2 0/2] tests/qtest: Add memory-access attributes (secure/space)
Date: Wed, 11 Mar 2026 23:49:32 +0800
Message-Id: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwW5JGj7Fpf8UAAA--.812S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWmwb-oGOwAAs+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWrW8Zr17WF13Xw48KF45ZFb_yoW5CF4rpF
 W3AasIkr48AF1xJr1fGa1kXFy5Kws3G3W7Jr9Fqw18urWYyFyxXry2kFyFqr9xCrWUXr1Y
 9w1DtFs8urn8t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is v2 of the patch series, which adds support for memory access attributes
(secure/space) in qtest framework.

Thanks to everyone who reviewed the previous version and provided valuable
feedback.

The major changes from v1 include:

- rework the qtest protocol to use an optional attrs argument and replace with
 the related libqtest APIs
- use ARMSS_* and arm_space_is_secure() for ARM security-space handling
- switch AddressSpace lookup to cpu_asidx_from_attrs()


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
a bigger issue for Secure SMMU work, which is RFCing in [2] and for future Arm
RME-DA enablement.

[2] https://lore.kernel.org/qemu-devel/20260221100250.2976287-1-tangtao1634@phytium.com.cn/

This series therefore adds qtest protocol/libqtest helpers to drive memory
transactions and introduces qtest-attrs-test to validate the new APIs on Arm
virt(Secure/NonSecure/Root/Realm spaces) and on x86 pc (SMM AddressSpace).


Compatibility
-------------

This series is strictly additive:
- Existing qtest protocol commands remain unchanged.
- The new *_attrs commands are optional extensions.
- The implementation is confined to qtest.c + libqtest, plus the new test case.

Testing
-------

The new qtest-attrs-test is registered for both x86 and aarch64 qtest lists.
# test command
meson test -C build \
    "qtest-aarch64/qtest-attrs-test" \
    "qtest-i386/qtest-attrs-test" \
    "qtest-x86_64/qtest-attrs-test"


Future work
-----------

Once the Secure SMMU series lands, I plan to build on this qtest API to extend
iommu-testdev-based tests to cover more security contexts (Secure state and,
later, RME-DA-related paths) while still avoiding a full guest software stack.
The branch below [4] demonstrates a modified iommu-testdev using the new qtest
interfaces to exercise Secure SMMU behaviour.

[4] https://gitlab.com/TaoTang/qemu/-/tree/integration/qtest-secure-api-v2

Tao Tang (2):
  tests/qtest: Add attrs argument support to memory access commands
  tests/qtest: Add qtest-attrs-test for memory access with attrs

 system/qtest.c                 | 266 +++++++++++++++++++++++++++------
 tests/qtest/libqtest-single.h  |  61 ++++++++
 tests/qtest/libqtest.c         | 148 ++++++++++++++++++
 tests/qtest/libqtest.h         |  25 ++++
 tests/qtest/meson.build        |   4 +-
 tests/qtest/qtest-attrs-test.c | 229 ++++++++++++++++++++++++++++
 6 files changed, 685 insertions(+), 48 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

-- 
2.34.1


