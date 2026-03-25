Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DD109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5PzG-0004Tt-5Y; Wed, 25 Mar 2026 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzD-0004PB-Is
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzB-0007hL-MV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so49126515e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451851; x=1775056651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uPDUxnutXePrc/HTKjEYwSZo7PAefB6IwoET63e9G6c=;
 b=Bv6tPCApOD/X2PgAeGQa0N/QqWe1I+LuzId3DL8okF07+sju0NOG6wHkgB5neYA/Xl
 9gEQlRJ7ejbCBllB/XuFmHd6ArohsBe/dV8OqzceJkxSecsxa3MxDX9v3Zf2PJgDZJXD
 P5DYoWwAkW2gE73ihkozeG/rx8OMSUfxM+ltz04g2jlbf58VDzb/oZoW/uxdxyW17s9k
 +7J4qgIAHHSICo25RFqnzpOogBLfAQO26XR5eZYydTipeQJzvDO2Nj9R5xmHjocoU019
 uXSI/xrhVQjwM6aX5XE232AmKgg35/G6ROWXvRNnrYBQ6ED08K6t3A5JEvvZoO3NxGsJ
 U+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451851; x=1775056651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPDUxnutXePrc/HTKjEYwSZo7PAefB6IwoET63e9G6c=;
 b=GG4WWk80WfnsgFkjGGzEm9eTaOASDD7gSuRRi6BVqPDRjZJhQ0xn1eGc+Fdpfy329p
 f6PPHnpbeTIj7NUnnilpG7ngY5opsEfTSEkfEIUsCyUc4cRqIM7Ph3QlrfEnOAi0wSIL
 nmWCkaHKfUUgsCYAHidtomWwNsU8ANfZyp1orutc1kH4UeM9kLfOB79LdnO7/X5kpMbO
 0BlGGNpDiF6BftXL4usHQYUC0Hm7xB09UPWvRnAmjY020kn+0jQhWXWPvu35C850gZxQ
 fdltwFXnFUbh0N9666YnBJNARLmcRR87UyCKiHt7xja1y2A4rmUFW4Z044Q/oPHsOkpH
 qmRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Q5u/+MDsNu8BMAAaCubq8SOQjJJqw3G0nMqkJcKeOoohBD8WbamTTEc2FGthbmmc9+c7/kzSPBqc@nongnu.org
X-Gm-Message-State: AOJu0YwW6K2D/bBSllsEsqVPviJtzC0Q4X9QMQDRoMV24/zbjdSyzqXH
 k2k1HTSMxUOIBsto+HvK8ohYumsRrdxTIh7kynCd17VWTkm11xvumSRnyo3tLI/KB54=
X-Gm-Gg: ATEYQzwb+TE8pm1Qe/vGAD/6QRT3DNf/iRxw1fplNT4EMpQxliswjHkySTf7ZKU10uJ
 3GAxk2MOFLFJbmZUl9Jw9bIYjlykptd0dESlZC+Puh6uZvH3wBVNOhbNJlXM0Y4xbhgew73UsT7
 3G+mQ0aGtY/b1/kPFcHmhBxx7q+AoKCjnKng53W9YVam83fMsqrxwGhPKXeyPUnuwMzzsgoOl+B
 K855cp+nhsJP8M14YdwdDHhIGmQuF3Iumc+DVW4OcPyJ6lV68e+pKCjNtMx0HuxiRD95/EsswZd
 FiYCohpK944j96mwlQ1BE6ncIDbjMqQqey3+mBDG++EKEcxTxuUIsg6saQvlZTm73ojClLkdQsB
 ex5apmLBXEFkL0uFuK75Wv41b4pgJg1DnvchEGA9HQ+ivHycnjtI0xHRiyCHRxj7IXkuGLp/Eyf
 A+vhcHxppepcso8KalWWMFrG+NQr6WSSH9f1DrXn7uAy/tF+ju5UqQUflRNikGfsym0kdnBAP/
X-Received: by 2002:a05:600c:8707:b0:486:f8d6:5dea with SMTP id
 5b1f17b1804b1-48716046e04mr64235355e9.19.1774451851290; 
 Wed, 25 Mar 2026 08:17:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487173a8d28sm22153735e9.36.2026.03.25.08.17.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 0/6] qom: Restrict compat properties API to system
 emulation
Date: Wed, 25 Mar 2026 16:17:22 +0100
Message-ID: <20260325151728.45378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Remove QDev uses from QOM to help build the guest-agent
binary without pulling in QDev methods.

After that only util/qsp.c is left (cond/mutex atomics),
see this thread:
https://lore.kernel.org/qemu-devel/a547c29b-3ab7-42fe-889a-19668bc9d090@tls.msk.ru/

Philippe Mathieu-Daudé (6):
  MAINTAINERS: Separate QDev section from QOM one
  hw/core: Move compat_props_add() to 'hw/core/boards.h'
  qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
  qom: Declare compat properties API in 'qom/compat-properties.h'
  qom: Restrict compat properties API to system emulation
  buildsys: Allow building guest-agent on 32-bit hosts

 MAINTAINERS                       |  21 +++---
 configure                         |  64 +++++++++++++----
 meson.build                       |   2 +-
 include/hw/core/boards.h          |  11 +++
 include/hw/core/qdev-properties.h |   1 +
 include/hw/core/qdev.h            |  27 -------
 include/qom/compat-properties.h   |  40 +++++++++++
 include/qom/object.h              |   8 ---
 accel/accel-system.c              |   1 +
 backends/hostmem.c                |   1 +
 hw/core/machine.c                 |   1 +
 hw/core/qdev-properties.c         |   1 +
 hw/core/qdev.c                    |   1 +
 hw/i386/pc_q35.c                  |   1 +
 qom/compat-properties.c           | 116 ++++++++++++++++++++++++++++++
 qom/object.c                      | 102 +-------------------------
 system/rtc.c                      |   1 +
 system/vl.c                       |   1 +
 target/i386/sev.c                 |   1 +
 ui/vdagent.c                      |   1 +
 qom/meson.build                   |   3 +
 21 files changed, 248 insertions(+), 157 deletions(-)
 create mode 100644 include/qom/compat-properties.h
 create mode 100644 qom/compat-properties.c

-- 
2.53.0


