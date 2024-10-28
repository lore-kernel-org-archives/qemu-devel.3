Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07137D339A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5TK1-0004l1-Pp; Mon, 28 Oct 2024 13:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5TK0-0004kd-1I
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:14:28 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5TJy-0004TP-3S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:14:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso5645315a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730135660; x=1730740460; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NT/W8+XS1o8vdJgjgTnk3e2WX5NTY76VytvXA/yxizM=;
 b=s2HAd3dgWGdPcCcHwxUPBa5pffq6Ic+HdYq91x5NK3IypUKiOK3dz4SWSU9ufnnRc+
 uAAoMmE3MHp59Riw12Jhk6xH4zYleOdl8JU0L1DrZoD5T8oV5K8rVXn6icLLhZal/d7f
 dU1NYy6la/xnMt+qLHgY4ejZOI7coGxN1tIVeZn7GAI83t7KJ4BPWAf+kxLk2RfRgRDo
 DwHEGoKOZW7xVUI5Letj7VLC7wGloECRLDQ0Ag0TJoaHsIaOP+14R/x88DO2/CflmS3k
 209rwzzqZmRYo66fiEyEQN71yzpsxcMTZ3fZguRAVZ9MUpzBNqjtftB+b57++N/N8AcS
 jPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135660; x=1730740460;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NT/W8+XS1o8vdJgjgTnk3e2WX5NTY76VytvXA/yxizM=;
 b=Obg7G9G/xVIbG0Nxb31cuoV+jLlMYvfksr1TAinWwnkQ3vJ7/5XBMW8RbLE9ubgGwe
 uViz3N5KJOHruQCqNCPPV6g/XgKmo3E5utkIw1VwMwece0qTEDhTydLWighOL75NCfCY
 EeT2Dy2G37ieoVtvNHUEaBRlKMz85CI2KNUA7tspDBg30STgRONqhnpl3lEIa/+TBY7a
 eiTIOCX/QZn1Gf+XBOvhK4bFbSQaI2amPtbTc312zoZefG90eZWHYvS0djTarZSr3c3K
 NaJpyqwga/ElB7Z4LQOttzksGYK73GgnhIeS3b3Xjl16LPtQQ6gRP7VevvFWAzi5SxZ7
 g7XQ==
X-Gm-Message-State: AOJu0YxeNEYjkm/SyUTNVY00kjArcMeJ1i06itamqPt69D47eRcH6ogZ
 X9T6Qg9cirKns/sMcXbezWDLHgyLjmqq7tVd5lwh3TRRtk23iz/XutMUSbH+LbOpk8PRbT183Ft
 ZOSKv5f2yeYmruOGqFEjL+TSftC/wLgIgVbWISsfoqNCd4Hhy
X-Google-Smtp-Source: AGHT+IG7WuHluoMmpjWd1kVITats3wzQaNMSPGEWTYwHH17I/1LaG+pINeV9pFvfwYaQbi0Sp66dYaLO1EsluioIIDQ=
X-Received: by 2002:a05:6402:42ce:b0:5cb:687a:1abc with SMTP id
 4fb4d7f45d1cf-5cbbf892404mr6582266a12.1.1730135659740; Mon, 28 Oct 2024
 10:14:19 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 17:14:08 +0000
Message-ID: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
Subject: check-function failing on func-arm-arm_aspeed
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

Trying a "make check-functional" I find that the func-arm-arm_aspeed
test seems to hit a timeout:

18/18 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
signal 15 SIGTERM

This is with commit cea8ac78545a.

Does anybody else see this, or is it some oddity happening only
on my local dev machine?

The "full log" in testlog-thorough.txt doesn't seem to be
very full. All it has for this test is:

=================================== 18/18 ====================================
test:         qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_aspeed
start time:   16:54:50
duration:     600.08s
result:       killed by signal 15 SIGTERM
command:      G_TEST_SLOW=1
PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
MALLOC_PERTURB_=238
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
MESON_TEST_ITERATION=1
QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
----------------------------------- stdout -----------------------------------
TAP version 13
ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
==============================================================================

Is it possible to get the log to include a pointer to the
actual log for the test (including the guest console output)?
It's hard to debug tests if they don't report what they're doing.

thanks
-- PMM

