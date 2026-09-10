Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65421C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bb3-0003bS-Ca; Thu, 10 Sep 2026 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4bb1-0003Ym-EZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4bay-0007EX-Iw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789034486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2KBq4SibOTqTSv2CZkqY7kOm3RGdY1j2baN2EiKY9Kc=;
 b=U8tXZ865RWZuxZE9k2CxPojUJb49w5hrlu3HDLnPypZzXbuYx80mLSCSq2aYdxZMgz1enP
 eaE/JstIsCmJBD4SGKsBu/HHunTNqXOZXvJE0JzsvX2FH3+nSI1Pgv8msM/9jN12gHdeRA
 0tXVqXyE/8Lgc89v1gDPBj9lQM9ov/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-D8plx5T5PkenG-0udnViWg-1; Thu,
 10 Sep 2026 06:01:24 -0400
X-MC-Unique: D8plx5T5PkenG-0udnViWg-1
X-Mimecast-MFC-AGG-ID: D8plx5T5PkenG-0udnViWg_1789034483
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C49180062D; Thu, 10 Sep 2026 10:01:23 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18D2C30001BE; Thu, 10 Sep 2026 10:01:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/tcg: improve check for working cross compilers
Date: Thu, 10 Sep 2026 11:01:20 +0100
Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

When it finds a cross compiler, tests/tcg/meson.build tries
building test_cc.c to validate that the compiler works. This
includes "stdint.h" as a witness for working C library, however,
that is not a good choice as it can be provided by the toolchain
alone:

  $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
  /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h

As a result, if you install the s390x GCC cross compiler, but
not any C library, meson decides to use the host compiler instead
of the container:

    cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'debian-loongarch-cross' container)
    cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for s390x-softmmu            : s390x-linux-gnu-gcc
    cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'debian-amd64-cross' container)

Eventually this results in failure to run 'make check':

[33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
/usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/system/../console.c
In file included from ../tests/tcg/s390x/system/../console.c:8:
../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
   11 | #include <string.h>
      |          ^~~~~~~~~~
compilation terminated.

Adding more include files to the test program ensures the
meson probe makes a better decision.

Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is working)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/tcg/test_cc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
index d3614a01fe..fafee055b4 100644
--- a/tests/tcg/test_cc.c
+++ b/tests/tcg/test_cc.c
@@ -1,7 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-/* Include a standard header to make sure cross compiler provides them */
+/* Use some standard headers to ensure the cross compiler provides them */
 #include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
 
 int main(void)
 {
-- 
2.55.0


