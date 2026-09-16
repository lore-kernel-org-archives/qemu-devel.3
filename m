Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D7AC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOw-0007rs-2V; Wed, 16 Sep 2026 04:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOr-0007nH-Pl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:53 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOo-0004zb-52
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:53 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so182723f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548829; x=1790153629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fckjvkn7unttlgUnvhFoPtFBnYywFxwoNxy67Zrv6pY=;
 b=D23faq/xB8ChGJ0B12Ma38I/qjFQtZVL6arZ2Ag5anj7zWF0lgmNvSmOgYnHZsZ+pv
 TimIilzGVVvNuTEKwu9jRhGLn/tlm2bVQ9m89pLPtJjXsqSsdhquClF11gZrimpaY0+X
 sYj5IHFlRLnfP23qL8r4Z29e3nd0oIzWvNEToCzHyFvkI+lgNr+JYZq7Vp2YRIEw5Xuk
 RyGKSrRD6/ODvLDlbPrCHKhBHZa/aJNai0gY/43QygMm9I0tWceIvuHcpZlMJFkUxsuG
 h15ooC3zeVL6KZ1D0xE/Xx3xD/FnjL+ibin1b2ne8AWDnInuVlumyrZlQxw6n5fRdc5b
 Nhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548829; x=1790153629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fckjvkn7unttlgUnvhFoPtFBnYywFxwoNxy67Zrv6pY=;
 b=fo06B91ld0K+AGVgTzeACmtQ8xnLJr2Dl6tAqR6cL3cvA1drD0gDARLeNNFb4Z3TMN
 ToF8tdq+jRfh44BYr91gJsrtHaRrfDVqC0KMov90vB2L+vRpFGxb9au8IZ4DamnSyUyw
 qSwUthrBlFiIaX2fzkXDqOzlpxCvjrEpEsvtAoNRNljnEJ0j0OZmTGqS7tXriLwjGjcv
 yTVWWcuoPsNFhW9thc+e+X/M8bFVdEYoEvNrSrIWeWUhcIqFhltjkSkP1nEoZPgXBP76
 Fh24aFo8ebioVyZL8C0vWcMI+5OJcXLSxGM26dBAo+5xzgHrdukEOzeQO+/7ZeMjnkIB
 2caw==
X-Gm-Message-State: AFuF++mn2gfjikiO+LRuJM+ZwzVMEUvx/Z1D4Zg1uSRlH4ny/blfJzTh
 HUTCAv4+5Ce7URn1T7MoTZwMZCKx1nGKbvhgR2xfXw8mMYSddxAM4OJcPHDRdT4Ui8M=
X-Gm-Gg: AYBFou3LIyE0MPRdlAsV4G0rAJc6J4MIiHVsghzZwNaV+AH4OohjLTyZ3ibUSrRW/1A
 SO+mWyMSWkypHYFlCZH8u9Sw8eegfhjAwVR8ZxcpZZA9zxKcISemdD75A/okCqaQTPWslR7ad9s
 hfBDsFkd4VZ5im3NyGmmp+ecdKi7gVzzM+XbUGfsvIIBPbR8QNtUGooDDCiILiXLM8KKihTNiRp
 Q5sU2z4oVYopU7T5KccswpHlEQTlqKXoligbDA2H4E82d0CHcRCIfZ+4O2v/U7mntvSW3Ml/1+O
 GZIaWCvHyfHjwbZx2c27k5mYAwMb1zXD0KRj0YTQ60iZ7l+uaK5Q5KYNhz2V84LPSUdnIQB0hHG
 BftVmX4+aDzDfpPV8/TjcZxzOEJwcGrNiKGY+KaDmZPCOUjBuZiy4BgUCTlzNLJWtyj080Ns/ck
 Il15bh4N1V5xx2qCojpaTKqnLxN2Fdl/uGtkMJggiiebVTLWFhN0/LGXbhoLdee5MQCrmW540=
X-Received: by 2002:a05:6000:24c6:b0:486:e3bf:606 with SMTP id
 ffacd0b85a97d-4870d708145mr1971111f8f.18.1789548828567; 
 Wed, 16 Sep 2026 01:53:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f98csm5065164f8f.11.2026.09.16.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 163B6618BA;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 06/17] tests/tcg: improve check for working cross compilers
Date: Wed, 16 Sep 2026 09:53:29 +0100
Message-ID: <20260916085341.1692742-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


