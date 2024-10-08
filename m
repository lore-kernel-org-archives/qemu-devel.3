Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534CACEFC2A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syD7n-0008S0-2h; Tue, 08 Oct 2024 12:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syD7k-0008RT-T6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:31:48 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syD7j-00013B-61
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:31:48 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so8057427a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728405105; x=1729009905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x3kuQrBW/a9Xs+5IB1zhh+k1QVWjK52nxPRasCvLhko=;
 b=KDiy2CI6Emx3t3W4d2Z1NSk4+jAaCxAEKstdhhpijsFUjWzZsC4IkMsvs94kpc0kGF
 4IR0DXMm+9aY7xzvBBJ9WerT+MRdz2j8a3V091eWnpUqCQ2yldPXXs09V28N2k4YCBQc
 7EdDtjDA9cMhhlpfszGKCUVmxJAec/bJ0nohAlQ/w4zuAPZV+toKbhcOLtpRJmX60IhZ
 shxx/FX7gmJ1j8UZAJPXdCw/f6WBGQctMftBv40qRM9NviyEkCqYy18SgwY5vyRdlmjD
 R6FHTOoERdZKnuoL1bClyKYsY8XIX5SkNzVPw4s0yAMA/ywwCkurGtKbkKt4wZYkWKQ1
 L/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728405105; x=1729009905;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3kuQrBW/a9Xs+5IB1zhh+k1QVWjK52nxPRasCvLhko=;
 b=Rt67mD8YzCnhgx8tqrU0QjhP0R5ENls98IeZvgyxVhZqMqih0L5HwVz91vFuqrA81v
 zTq8Y9lakB/f9elVe+OSsQARF6J/kK01T++x0aaYR7qBVoUF7s/klAwSRFvvb8cgnlcs
 JdjDCEO6rtX1ZMtFvv+keBQ2tihpuWE0YtkefNvAvWQ5RX19a3fU2lTRDtY11R3SbjO8
 22GIbEyVWh7MeVDAf7t68JsIs31OeoiUBNh6pyDJsTDl/GXIFElo8KFRRopWz/c7WzGE
 UjCWG6XH9kiMDFzTv3ZsnHMCf96FCBemtXrx39KyxlU/q0BZmBpL+nPSR4FuIrXq+8jy
 WB5Q==
X-Gm-Message-State: AOJu0Yxh3zIvQasvqywi2araFul4Wxy8+eg7SUSfLur1XGBA9Ialy+Ld
 QrfpWY8yPZlvM7hxkZN0+UovB9zFJsTu6IiQotJZJiotmnZ2Ubj0nl/D9Jzhxg734GbhNxXuC1M
 Lo1/oAzn7K83vYP1UaXe1dQYwptSpH3C0t3PNqV8msY+nI9pV
X-Google-Smtp-Source: AGHT+IHCC0RfjRNbsPGK7WXh/3vXnCUJYVvhZ3s2BX6L2yXJ1mUwjAVUJJfJ5nTPMS44wl++kf8/k23p/sck2IM1syg=
X-Received: by 2002:a05:6402:27d3:b0:5c9:60a:5bc2 with SMTP id
 4fb4d7f45d1cf-5c9060a5c30mr2901921a12.17.1728405104738; Tue, 08 Oct 2024
 09:31:44 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 17:31:33 +0100
Message-ID: <CAFEAcA_y6xYLyK_qEjngtCm+Y5-Yuw-rqK2Qm0UhVAFHtp610w@mail.gmail.com>
Subject: qemu-iotests test 297 tries to run python linters on editor backup
 files
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I made some changes to a block backend so I wanted to run the iotests.
I ran into an unrelated failure of iotest 297. The bulk of this
seems to be because the iotest tries to run on all files
in qemu-iotests, even on editor backups like in this case "040~"
(which is an old editor backup of 040). But there are also
some warnings about files that do exist in the tree and which
I haven't modified:

+tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
(no-self-use)
+tests/mirror-change-copy-mode:109:4: R0201: Method could be a
function (no-self-use)
+fat16.py:239:4: R0201: Method could be a function (no-self-use)

Q1: can we make this test not run the linters on editor backup files?
Q2: why do I see the errors above but they aren't in the reference file
output?


e104462:jammy:qemu-iotests$ ./check 297
QEMU          --
"/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-system-x86_64"
-nodefaults -display none -accel qtest
QEMU_IMG      --
"/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-img"
QEMU_IO       --
"/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-io"
--cache writeback --aio threads -f raw
QEMU_NBD      --
"/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-nbd"
IMGFMT        -- raw
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 e104462 5.15.0-89-generic
TEST_DIR      --
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/qemu-iotests-0c1ft_vw
GDB_OPTIONS   --
VALGRIND_QEMU --
PRINT_QEMU_OUTPUT --

297   fail       [17:26:10] [17:26:23]   13.1s                output
mismatch (see /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iotests/scratch/raw-file-297/297.out.bad)
    [case not run] 'mypy' not found

--- /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297.out
+++ /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iotests/scratch/raw-file-297/297.out.bad
@@ -1,2 +1,74 @@
 === pylint ===
+************* Module migrate-bitmaps-test
+tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
(no-self-use)
+************* Module mirror-change-copy-mode
+tests/mirror-change-copy-mode:109:4: R0201: Method could be a
function (no-self-use)
+************* Module fat16
+fat16.py:239:4: R0201: Method could be a function (no-self-use)
+************* Module 040~
+040~:50:0: C0301: Line too long (85/79) (line-too-long)
+040~:64:0: C0301: Line too long (86/79) (line-too-long)
+040~:91:0: C0301: Line too long (138/79) (line-too-long)
[PMM: deleted a lot more warnings about this editor backup file]
 === mypy ===
Some cases not run in:
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297
Failures: 297
Failed 1 of 1 iotests

thanks
-- PMM

