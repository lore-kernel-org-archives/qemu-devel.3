Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5E7C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyY4-0007EY-OY; Tue, 10 Jun 2025 08:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXm-0006q8-Ut
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXg-0002dh-Gs
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so26431465e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560246; x=1750165046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH/UENSCofucK9PKqyMnu0tIqL91/9aKt2x9DQ47tTs=;
 b=LCtbcZyS7gPnY0eirB0f7BWtZ3z3UBPNYqWv9QO1RjcOZmEtZifmOBZrHcR/+17FfS
 /UX1VEmO1fdXgQD7T0ojNRbMELBVcMW+zww07jQ9fSjp4F8Tt1bGuAEAOtqlEOBwvfbO
 mW3VcN47AsmPaKwxarehqUSKElN7YxKqw2kT9EFjtUxoq71zkDDou50LEqwxJYIY6kn0
 6DLEHLyWhF3TSA+001nYN9o0RDyfRvOm+V1ciDiQTMa6WwSYdYk92UpdUYN8Mx/s01Zg
 Kg5S6hPk7My1mZplCMvqx7wLrAENAf8YJERAEThzu4DIF61PLclurRNlWvp2MtnhRy/2
 CL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560246; x=1750165046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZH/UENSCofucK9PKqyMnu0tIqL91/9aKt2x9DQ47tTs=;
 b=OfK88xze9hZiBkpYoQxkj4dZf9jdbxwPlFRzv7dOXPYqWe25acYPt4b9hFRIPHbPor
 MIzAqZRQPiEIPkICLnmv8XEPYvYWTFoVRqzyYC4WO8E+UQY/g85A8Q+hsQvW9GMSzkn6
 4un7gr15leSCNFukLgO9B6FZuvw72ZgWl4ca8WajC0yqXEIxXdniPOiMKhqueoP3kCof
 RfBnXd1C7SIS1Ujgyak4CaXuUrtxHfLLGyUJvn3s+1DJ0HMqLsBVhs2dV2CKmK6Ekgv/
 EkFcEHVWUPlJdJ+X9lSPFcq6sFDVMgx3++tUnk5zMN8O41lzNQMJe3EJiWNT6Yxukf7U
 pJ5Q==
X-Gm-Message-State: AOJu0Yx22V3wjYOiH5IfgBXqSAM7hb3xPcPgdYCnpnzTqUOAd21ydPgs
 xVrpZ0ukGDzvWzh2FieSr8OBAsIdPSuNcRE4UYOYBsP3/DtrsL85MmK7H8ZGEpIg6PbHSrXx8F+
 InzBkH6g=
X-Gm-Gg: ASbGncs6oEgtrjEDXAz72vqSleEyND2jOqBWXbsDuNtZ73NeuorZC5nHdFp6eXmp6nz
 lK8wW+k6Ef8qsS2WCJKS3UuBkzq9Pfh3HQZggGj05TSX0N6yhreV33lvDzdhXhPIypq0L1NIE64
 TLL3zMctIBg7D3Rc13zmdQaQwzvY1T6xtGvRlN8Gs/XfASNESe5AMy+W2JaNToVvwlxngKONAJ5
 3EKIcMyfCx6rup7Y8OGt4G8HMsjHkdaI+88e9A34/eqGjqHwuDpNLxdWtRBqOj3LHCOm98kJwBG
 a7oIQgPhWhcnejUEgkIvuB2BpF6c6MugzIlGPMaxNHwmASxyP/IaDA5gULUAsXK0jSxLcSjWDEX
 r2H38Ff7oa5GcEQEXqz6m7HV3JkvmoOBncXe8qNw6ch9OjqGaH3O/
X-Google-Smtp-Source: AGHT+IFnTVa/MZDVtnmmD/HTuzw58fTQnlJ+uIh9+O8LNjce+ztuLOvknw/e2gBgq6ai8p5Vd9LuXA==
X-Received: by 2002:a05:600c:4e4f:b0:450:d4a6:799e with SMTP id
 5b1f17b1804b1-4520149770fmr131012605e9.20.1749560245896; 
 Tue, 10 Jun 2025 05:57:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213709729sm139681725e9.19.2025.06.10.05.57.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/24] MAINTAINERS: Update Akihiko Odaki's affiliation
Date: Tue, 10 Jun 2025 14:56:20 +0200
Message-ID: <20250610125633.24411-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

My contract with Daynix Computing Ltd. will expire by the end of May,
2025. As I may contribute to QEMU for my research, use my email address
at the lab.

As I'm the only maintainer of igb and no longer financially supported to
maintain it, change its status to Odd Fixes until someone steps up.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 16 ++++++++--------
 .mailmap    |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6763077ea..76399ad1e0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2519,7 +2519,7 @@ F: tests/qtest/fuzz-megasas-test.c
 
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: include/net/eth.h
 F: net/eth.c
@@ -2549,13 +2549,13 @@ F: docs/specs/rocker.rst
 
 e1000x
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: hw/net/e1000x*
 
 e1000e
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: hw/net/e1000e*
 F: tests/qtest/fuzz-e1000e-test.c
@@ -2563,9 +2563,9 @@ F: tests/qtest/e1000e-test.c
 F: tests/qtest/libqos/e1000e.*
 
 igb
-M: Akihiko Odaki <akihiko.odaki@daynix.com>
+M: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
-S: Maintained
+S: Odd Fixes
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
 F: tests/functional/test_netdev_ethtool.py
@@ -2910,7 +2910,7 @@ Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: audio/coreaudio.m
 
@@ -3211,7 +3211,7 @@ F: tests/functional/test_vnc.py
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
 
@@ -3738,7 +3738,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: contrib/elf2dmp/
 
diff --git a/.mailmap b/.mailmap
index 33fe75400fe..e7271852dc6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -67,7 +67,8 @@ Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-blo
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
 
 # Next, replace old addresses by a more recent one.
-Akihiko Odaki <akihiko.odaki@daynix.com> <akihiko.odaki@gmail.com>
+Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>
+Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@gmail.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
-- 
2.49.0


