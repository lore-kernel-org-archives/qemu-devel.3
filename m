Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6410DC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KGT-0001pB-1F; Thu, 17 Sep 2026 18:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGL-0001oJ-KO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:27 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGJ-0006Gy-UC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:25 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd77300825so1110465ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789682842; x=1790287642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+a/QiGfAH44+xKdZ3VFMKyUFnrdn1sFqvSGXPMkrMxM=;
 b=hZ+HzPC1PSykUMPnQJ23ZuCn0rIOjtJ8toUIW/PchsKtJIFhFfbF42q7agRKiZhTzf
 v5XSCyaNYxsAagC/y++H0jBlQqW2chGdQZEL2xwaHNjjFGbwAzRCXl5TH1xI6kGaR/TV
 eIQ4J9g7BexHUibAXmtjwOTqF/YAO9q9B9yNGoQV9aXJk0TJGyRrHIwwJQnHMPJDbAwq
 NH2Jn1Ys6ciWy+azucTayb2zkOaimyv7swa2mrd7rOTXOWYcAzwWNj33R8UrgFxwZ/E9
 Q1EhDLVScOYBsK0WKaPpHLMpnAus8zQcAB+WGRCc48Rjx/iP5KCpIXgC6Ymq5n7k8SFV
 rEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682842; x=1790287642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+a/QiGfAH44+xKdZ3VFMKyUFnrdn1sFqvSGXPMkrMxM=;
 b=tm6EiG4RfbKRL/vuTeACN+Y/HHjd/kY8CEdrTdJ2F2hcko21vOWm1PV59R5v6u4Nau
 RzKVGrCTZ2cwSg9W1bENftCE40C2aA2akusUp6jR35vGRO4sy5N+Brh//+YMmyNrixpQ
 nK/WxUaePEqoIE/2Q9x/K/t6QmuR+aLLZ9J0SLuh/3lSB6pDt7inyJtwsZAv+/150yb1
 Zl/BnIhAVloq1wtt00mT9QA09XUgszn+GAYiJ0q4/JG4lllnESx05JQ+zxHqLahyoj8K
 grYPbAQ3qnxsC87C0X+YhXvX4vf19McNSzUOs15+vjmGcZGaLE9n3GE8rBHaamIyANlc
 tlhQ==
X-Gm-Message-State: AFuF++kpi2F2pOblyHlDtVe822AGUxZhTXU8UyYc8gs1wLuHmZ0/x+0M
 BY1dz6Fs3ddPLH/z4IP25xyMgrgQClaobbLah0m94dxzdGi4wc2o6cME88v1+WDZwUk9r72F9+k
 b3vCvkl8=
X-Gm-Gg: AYBFou3i4JxG1usZx8Jn+tsdKj7SvbahBD0gIb/gGvuFOhjSypchwhhZkGKQciBCaTC
 BFFCKfF+H9rvwFIlzxznGJ0pxiF/AeWgWVFoC6LTOpCr43YBmvCEoVJhx4UcbhEiO/XL+CsTwu0
 AdjhIVssS44F94sjMMZFQyin8YE1aGFRnskirfLTmuFywvPhMTPCsFQrqhWYZ2MbdfdoM33Mkem
 NglXtayk4sqCr7wLLOPa0z0liDwTd83+P2bkcTib6tzvyfk7LdaDaGwh4UFQpNR8IfkMuPgrAfs
 moZ4MGthbwrQPw7WbK1gRr9TObhSFNCCqHKrZMR0P97Qa7iuUyX6kQYEHBB5JFHTB1Q/dZAueGq
 7JY+UPBN4890Xcj/BegFUmTKelHXYq+LMAk5knzKMXgmj0TDUdfw0w27RcuUkD7piRMNSVIsJWp
 vfQTgqBG+x8oU6itGN4acicmRGfLBHeZ1qfPSp7Mh3MMdkkf3T5Xj09kZ+sBawaEAk78TcYuz3R
 50F7s4=
X-Received: by 2002:a17:90b:17ca:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39e54cb43c7mr991475a91.6.1789682842103; 
 Thu, 17 Sep 2026 15:07:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d3a31asm14558131c88.9.2026.09.17.15.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 0/2] accel/tcg: cut per-block dispatch overhead (part 7)
Date: Thu, 17 Sep 2026 12:07:16 -1000
Message-ID: <20260917220718.60899-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Splitting Matt's larger patch set:

> 7  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
>
>    translator_use_goto_tb() refuses to chain across a page. In user-only
>    builds the invalidation path already covers what that was protecting
>    against: every mmap/mprotect/munmap reaches page_set_flags(), which
>    invalidates and unlinks. Lift it there for runs that can never acquire
>    a breakpoint, keep it for system mode.             -2.75%, -4.84% wall

Changes in v6:
  - Adapt the test to the tcg/tests meson conversion, which requires...
  - Add a mechanism to pass command-line arguments to the guest program.


r~


Matt Turner (1):
  accel/tcg: Allow cross-page goto_tb chaining in user-only builds

Richard Henderson (1):
  tests/guest-debug/run-test: Add --pargs

 include/gdbstub/user.h                  |  11 +
 accel/tcg/translator.c                  |  33 ++-
 gdbstub/user.c                          |  14 +
 tests/tcg/multiarch/test-xpage-chain.c  | 336 ++++++++++++++++++++++++
 tests/guest-debug/run-test.py           |   3 +
 tests/tcg/multiarch/gdbstub/xpage-bp.py |  37 +++
 tests/tcg/multiarch/meson.build         |   6 +
 7 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py

-- 
2.53.0


