Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F1CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEj8q-0002DT-Kt; Tue, 13 May 2025 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEj8m-0002D8-7U; Tue, 13 May 2025 02:29:24 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEj8j-0001jk-4k; Tue, 13 May 2025 02:29:23 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:02 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:02 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/25] Fix incorrect hash results on AST2700
Date: Tue, 13 May 2025 14:28:30 +0800
Message-ID: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1:
 1. Added support for 64-bit DMA in the HACE model
 2. Refactored the do_hash operation in the HACE model
 3. Fixed a crash caused by out-of-bound memory access in HACE
 4. Added more trace events and implemented dumping of source hash data and
    resulting digests to improve debugging
 5. Refactored the HACE QTest framework to support both AST1030 and AST2700
 6. Added a test case for SHA384

v2:
  1. Create new helper functions
     hash_get_source_addr
     hash_prepare_direct_iov
     hash_prepare_sg_iov
     hash_get_digest_addr
     hash_write_digest_and_unmap_iov
     hash_execute_non_acc_mode
     hash_execute_acc_mode
  2. Refactor do_hash_operation
  3. Fix review issue
  4. Revise trace-events
  5. Move register size to instance class and dynamically allocate regs

This patchset resolves incorrect hash results reported on the AST2700 platform.
This update addresses the following kernel warnings and test failures related to
the crypto self-test framework:

aspeed-hmac-sha512 test failed (incorrect result)
aspeed-hmac-sha384 test failed (incorrect result)
aspeed-sha512 test failed (incorrect result)
aspeed-sha384 test failed (incorrect result)
aspeed-hmac-sha256 test failed (incorrect result)
aspeed-hmac-sha224 test failed (incorrect result)
aspeed-hmac-sha1 test failed (incorrect result)
aspeed-sha224 test failed (incorrect result)
aspeed-sha256 test failed (incorrect result)
aspeed-sha1 test failed (incorrect result)

How to test it

Use the following command to dump information about the supported digest methods
via the ast_crypto_engine hardware engine:

root@ast2700-default:~# openssl engine -pre DUMP_INFO ast_crypto_engine

Digest SHA1, NID=64, AF_ALG info: name=sha1ALG_ERR: , driver=aspeed-sha1 (hw accelerated)
Digest SHA224, NID=675, AF_ALG info: name=sha224ALG_ERR: , driver=aspeed-sha224 (hw accelerated)
Digest SHA256, NID=672, AF_ALG info: name=sha256ALG_ERR: , driver=aspeed-sha256 (hw accelerated)
Digest SHA384, NID=673, AF_ALG info: name=sha384ALG_ERR: , driver=aspeed-sha384 (hw accelerated)
Digest SHA512, NID=674, AF_ALG info: name=sha512ALG_ERR: , driver=aspeed-sha512 (hw accelerated)

The status of SHA1, SHA224, SHA256, SHA384, and SHA512 should be marked as
hw accelerated, indicating that these algorithms are supported by hardware
acceleration via the aspeed drivers.

Create a test file on the host machine and compute its HASH value as the
expected result

Create a 256MB test file

$ dd if=/dev/random of=/tmp/256M bs=1M count=256
Generate Hash Values Using SHA1, SHA224, SHA256, SHA384, and SHA512

Use the following commands to generate HASH values for a 256MB file using
different SHA algorithms:

$ sha1sum /tmp/256M
7fc628811a31ab87b0502dab3ed8d3ef07565885  /tmp/256M

$ sha224sum /tmp/256M
2d261c11ba05b3a62e0efeab51c307d9933426c7e18204683ef3da54  /tmp/256M

$ sha256sum /tmp/256M
5716d1700ee35c92ca5ca5b466639e9c36eed3f1447c1aec27f16d0fe113f94d  /tmp/256M

$ sha384sum /tmp/256M
fb6bc62afa1096dcd3b870e7d2546b7a5a177b5f2bbd5c9759218182454709e0c504a2d9c26404e04aa8010a291b7f1c  /tmp/256M

$ sha512sum /tmp/256M
fbceda7be34836fe857781656318ecd5b457a833a24c8736d5b8ef8d07e1950eebcdb140eebe4f12b5ff59586f7eb1c64fa95869c63dd9e4703d91261093c5c9  /tmp/256M

Generate HASH Values Using the Hardware Engine

Use the following commands to generate HASH values for a 256MB file using
various SHA algorithms with the ast_crypto_engine hardware engine:

root@ast2700-default:~# openssl dgst -sha1 -engine ast_crypto_engine /tmp/256M
Engine "ast_crypto_engine" set.
SHA1(/tmp/256M)= 7fc628811a31ab87b0502dab3ed8d3ef07565885

root@ast2700-default:~# openssl dgst -sha224 -engine ast_crypto_engine /tmp/256M
Engine "ast_crypto_engine" set.
SHA2-224(/tmp/256M)= 2d261c11ba05b3a62e0efeab51c307d9933426c7e18204683ef3da54

root@ast2700-default:~# openssl dgst -sha256 -engine ast_crypto_engine /tmp/256M
Engine "ast_crypto_engine" set.
SHA2-256(/tmp/256M)= 5716d1700ee35c92ca5ca5b466639e9c36eed3f1447c1aec27f16d0fe113f94d

root@ast2700-default:~# openssl dgst -sha384 -engine ast_crypto_engine /tmp/256M
Engine "ast_crypto_engine" set.
SHA2-384(/tmp/256M)= fb6bc62afa1096dcd3b870e7d2546b7a5a177b5f2bbd5c9759218182454709e0c504a2d9c26404e04aa8010a291b7f1c

root@ast2700-default:~# openssl dgst -sha512 -engine ast_crypto_engine /tmp/256M
Engine "ast_crypto_engine" set.
SHA2-512(/tmp/256M)= fbceda7be34836fe857781656318ecd5b457a833a24c8736d5b8ef8d07e1950eebcdb140eebe4f12b5ff59586f7eb1c64fa95869c63dd9e4703d91261093c5c9

The HASH values generated here should exactly match those computed on the host
machine using sha shell commands, verifying both the correctness of the
hardware-accelerated results and the functionality of the ast_crypto_engine.

Jamin Lin (25):
  hw/misc/aspeed_hace: Remove unused code for better readability
  hw/misc/aspeed_hace: Improve readability and consistency in variable
    naming
  hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware
    hang
  hw/misc/aspeed_hace: Refactor hash buffer setup into helper functions
    for clarity
  hw/misc/aspeed_hace: Split hash execution into helper functions for
    clarity
  hw/misc/aspeed_hace: Introduce 64-bit hash source address helper
    function
  hw/misc/aspeed_hace: Rename R_HASH_DEST to R_HASH_DIGEST and introduce
    64-bit hash digest address helper
  hw/misc/aspeed_hace: Support accumulative mode for direct access mode
  hw/misc/aspeed_hace: Move register size to instance class and
    dynamically allocate regs
  hw/misc/aspeed_hace: Add support for source, digest, key buffer 64 bit
    addresses
  hw/misc/aspeed_hace: Support DMA 64 bits dram address
  hw/misc/aspeed_hace: Add trace-events for better debugging
  hw/misc/aspeed_hace: Support to dump plaintext and digest for better
    debugging
  tests/qtest: Reorder aspeed test list
  test/qtest: Introduce a new aspeed-hace-utils.c to place common
    testcases
  test/qtest/hace: Specify explicit array sizes for test vectors and
    hash results
  test/qtest/hace: Adjust test address range for AST1030 due to SRAM
    limitations
  test/qtest/hace: Add SHA-384 test cases for ASPEED HACE model
  test/qtest/hace: Add SHA-384 tests for AST2600
  test/qtest/hace: Add tests for AST1030
  test/qtest/hace: Update source data and digest data type to 64-bit
  test/qtest/hace: Support 64-bit source and digest addresses for
    AST2700
  test/qtest/hace: Support to test upper 32 bits of digest and source
    addresses
  test/qtest/hace: Support to validate 64-bit hmac key buffer addresses
  test/qtest/hace: Add tests for AST2700

 include/hw/misc/aspeed_hace.h   |  11 +-
 tests/qtest/aspeed-hace-utils.h |  84 +++++
 hw/misc/aspeed_hace.c           | 480 ++++++++++++++++--------
 tests/qtest/aspeed-hace-utils.c | 646 ++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_hace-test.c  | 577 +++++-----------------------
 tests/qtest/ast2700-hace-test.c |  98 +++++
 hw/misc/trace-events            |   8 +
 tests/qtest/meson.build         |  13 +-
 8 files changed, 1280 insertions(+), 637 deletions(-)
 create mode 100644 tests/qtest/aspeed-hace-utils.h
 create mode 100644 tests/qtest/aspeed-hace-utils.c
 create mode 100644 tests/qtest/ast2700-hace-test.c

-- 
2.43.0


