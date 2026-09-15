Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF86C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbN-0007Z2-CH; Tue, 15 Sep 2026 16:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZe-0006sS-05
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:22 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZZ-0003IE-QQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:13 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so1517575e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503368; x=1790108168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fckjvkn7unttlgUnvhFoPtFBnYywFxwoNxy67Zrv6pY=;
 b=J5ffZsfKuwsn1F/QQ2FzcwyiZVLzoMBIILibkeTAPsoFnmytOdPm8i/QOnaZk8ksXJ
 wotXpQL1lmBoTbydJPvizpi5HmKzq2DV1gUulIAQ07sSZ9G2MRzR0cA0nS6MJdIZ88Hz
 1Ochdo+fCq7bAbwscUXKnel6Ay5NePMy3QifbNoPlojxzo1F1Y9uR/eu1P7jisdkJg2h
 YYkGqoq9Q2A52krVNx4TOSdAQNbuHLsEHJCknR3cDU5e6IRATVTZ5MGyPu8qhpDLcHi1
 b5bT2XTs4TpehHRHycD+I4o3uEM1iazBeoMSe4IoszjpoLI1IXZw8pZghNzRGO2FZgLw
 olXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503368; x=1790108168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fckjvkn7unttlgUnvhFoPtFBnYywFxwoNxy67Zrv6pY=;
 b=JGIvBmm6Lco/RAhWnahqC0ORFi/qULiLCdS35udgrha2WORm0s9tubs5i67sYq8yK+
 gnieAlSHi81ci4BSdtM5b5aqobKay7xH9tMOUy1s96QjZXnSb9xWu0Fb/hwry9Sf5/SO
 SF3bSsIpPebC7RPr0vfRBXm8+ZNl62+Yyiqngcu+VbtKPKGL5Oo6xlPxky9vSE31Jv5R
 5x1imd5R4JKWHQeqvRaRU3hrEOzjxlPB5jjEd0pjnpJ9NBFJWGOdA9gHq63P39zsL+Pw
 DbO5XVMs8Q/Dfi5YmrTBOfbJZtMPMJW604fbNaYSI41e+A7Pp8PKhFYBhn/UYpT8EKjh
 uIEQ==
X-Gm-Message-State: AFuF++kjRD6p1S/q6PwAyCXqdBJvDtloWdWJIyeu27iVhXGWjK3Kt9TP
 sI7/LFFQrEnj1ymyNyzexYHudaL8LNQWtnBDnzblSQlFm2sutvp99djI8u27d8KFeZc=
X-Gm-Gg: AYBFou0mpRa9Q1fyw/yEEpNmm8aNA9Ch86dzZ3UCDdTBoMSGJnsEjcd0J3KAtDV2v0C
 RG/p283HBth8IXcoowzO9WPUaWUdsXvSqrtcV+6l49pT65nXygoce9+vjxTUKsC5CvCiyLjCVzD
 ueBClseJOj/Z8LolGwpgUXrRZMJ7U1lwXnNhcfUAemSx+zlSijS48TsooNKpav1zZ8jL4rFoY+C
 AToqX+g1eG5W1nzGp96nISk9GZFRAPmTAd1Cp5WG4K1st53VCkwS3K1HZz3C1dRadeCCBcigbcv
 uickrnWNJleSu3waTEcTMZ0lFbb4eNF/j4HOV3C31pMebZyjX80Sl3DK9vl2EvsobObG4/c6PaP
 avlmAdwOmsAbEKWzPhlYl4NtL/m7XCapYp11vxtvfTN8pNNfMRvAczzH+IPwo73lUW8Stg96pv7
 eUAC5OaAOmfPDOhj9D7w2KndCjRk4SBrCZW3s4i/Ehk9q1TYk0/EYgodmjMSo4+Wr6tVfUa4TJk
 A0A5CCiUw==
X-Received: by 2002:a05:600c:4743:b0:49e:7cfc:a9b7 with SMTP id
 5b1f17b1804b1-49e82257f4bmr35173665e9.18.1789503368369; 
 Tue, 15 Sep 2026 13:16:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e84202028sm8631125e9.0.2026.09.15.13.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46B00618BA;
 Tue, 15 Sep 2026 21:16:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 06/15] tests/tcg: improve check for working cross compilers
Date: Tue, 15 Sep 2026 21:15:51 +0100
Message-ID: <20260915201601.1207839-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/test_cc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
index d3614a01fe6..fafee055b40 100644
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
2.47.3


