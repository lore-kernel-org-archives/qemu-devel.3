Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A4BC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2p6-000561-1v; Thu, 24 Jul 2025 16:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p3-00054w-NL
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2oz-0007MK-HP
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-234b9dfb842so12801435ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389935; x=1753994735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=469MTM4WIrhtrSLiP/c8/OPPWqfBZ+xyrCSPKYWK6j8=;
 b=MOEAD53HEWZ2QQOgQ0vauYB/E5ZJVVWSyatC/Dmx/+oeXthrxYo7ihHjmZtqhSJhiW
 E/dwt0y0DL86Kcmde2mlRHF3r/dWDYrMeSkV53rilY4fKGxb8IIQVD1ufhx+Dnp/PfFR
 J5l7iNMUuKwDykUJN2nv9ELas6Hh0RixF65c8cGF8ZLZWxqZ1HD74chPH8tDhx1UkT07
 PFM1A8TiBLZ9pl4ibysci6krIrs/uob9LDyE7QDe/7HV9Rv6QcaEwR7I2KnOTey+SMjx
 sHBpuEQAnTLT0rWoqbcb1uzZgsuHEgn9fEF0UJ+vetoaq03zXR9xqoqpDWrebn9dojnr
 UcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389935; x=1753994735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=469MTM4WIrhtrSLiP/c8/OPPWqfBZ+xyrCSPKYWK6j8=;
 b=QLaD9mhmyHS+IkegrQUKsNGCtIAWgm03rDV/RZp34m157ZQS5BuL830tGfnlLSEn7o
 v36+kltR7f0a5Cqh0tSDM/joDE+WwoWVEEBPZnSiHU23kmixaFBpkRCJpkYe4imlVDV/
 8q8vl/psgXneSLbuhKbXq8Qml+ZKTrVEW7XN414pYQQzv3yLXSdYYH3zY6nE02fjDWbG
 wokZ0cMExoYiSZb5j+NG9D/a/bwIjMppIS6GbK7oPeM+xqIE/DO5RQ36lp2I5PW9aQ3C
 myOYcDTZChBq+TLk8CNfoCg9+stVHdXr2wzEM0J75kskvI168H/gtBT9bkhq8JKle61w
 XDZA==
X-Gm-Message-State: AOJu0YwtFI9pgYPATVy1Awfk7IZyVPycMIsyfXd/AWOy82LO2B7OscHS
 xDwKMznWIABfGfwl+lPg4yXJrjZoitV5j8pLVhA9E7th50J46hF7w5Z63LvcGUympnE4YhsMOfz
 /AJVg
X-Gm-Gg: ASbGncudv/5LQt41Ap2HUBV+Sns/6KAYSyDZTnjiVqgbjGuoZ/1CLSU+Q0CUEiCHJ5O
 LwD7Z4OmGBWFgg7NQe4hD9a+lS/PQSyca1Dvv7m/QySUUfX8jSPeU/aWaXMzx7PVc4fH3Y4T01v
 VbF4v8YdI06+qYwtpS71Pi0wxA4wulwL7hOwddzuOEJ4oRYGsc2Jr79j7R3A2kJaN5frwe9y0PQ
 U0HSJAPboEHUZvuNzXZMJ5rRJc2UsrwjpR2tnzmlP4uI1ZSipNvPgf1spI0ItXbF+pCcJD6yEfh
 5P33J+dKE6IxZYo4wn6iy007/3MHwUk9GS61dyYkcma33yv8MR4i1FdakaVBKOP43TJNxVcGGIy
 lcTEQlHGq6D08okIvhd/T1aBMHg0t26pB
X-Google-Smtp-Source: AGHT+IEF9+E4sV8Xdvz9OXy8B2VB77C2RTE7OWXjGO7gZcIWCcJqnNw+Kr40QxwN3zl7HSTcobe0tQ==
X-Received: by 2002:a17:902:e887:b0:234:bca7:2920 with SMTP id
 d9443c01a7336-23f981b42c1mr135002485ad.24.1753389934926; 
 Thu, 24 Jul 2025 13:45:34 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 0/7] contrib/plugins: uftrace
Date: Thu, 24 Jul 2025 13:45:19 -0700
Message-ID: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

This plugin generates a binary trace compatible with the excellent uftrace:
https://github.com/namhyung/uftrace

In short, it tracks all function calls performed during execution, based on
frame pointer analysis. A big advantage over "uftrace record" is that it works
in system mode, allowing to trace a full system execution, which was the
original goal. It works as well in user mode, but uftrace itself already does
this. It's implemented for aarch64 only (with the intent to add x86_64 later).

Let's start with concrete examples of the result.

First, in system mode, booting a stack using TF-A + U-boot + Linux:
- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
- Stat and open syscalls in kernel
https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview

Full trace is available here:
https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
You can download and open it on https://ui.perfetto.dev/ to explore it.

Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
- Loading program and its interpreter
https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
- TB creation
https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview

Full trace is available here:
https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz

If you had curiosity and now you're ready to give some attention, most of the
details you want to read are included in the documentation patch (final one).

Overhead is around x2 (sampling only) to x10-x15 (precise), and long traces can
be directly filtered with uftrace if needed.

The series is splitted in:
- implementing the plugin
- adding useful options (especially sampling and privilege level tracing)
- add a companion script to symbolize traces generated
- add documentation with examples

I hope this plugin can help people trying to understand what happens out of the
user space, and get a better grasp of how firmwares, bootloader, and kernel
interact behind the curtain.

v2
--

- trace active stacks on exit
- do not erase map generated in system_emulation
- add documentation to generate restricted visual traces around specific events
  of execution

v3
--

- fix missing include unistd.h (build failed on MacOS only)

v4
--

- add support for x64

Pierrick Bouvier (7):
  contrib/plugins/uftrace: new uftrace plugin
  contrib/plugins/uftrace: add trace-sample option
  contrib/plugins/uftrace: add trace-privilege-level option
  contrib/plugins/uftrace: add timestamp-based-on-real-time option
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation
  contrib/plugins/uftrace: add support for x64

 docs/about/emulation.rst           |  213 ++++++
 contrib/plugins/uftrace.c          | 1014 ++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |    3 +-
 contrib/plugins/uftrace_symbols.py |  152 +++++
 4 files changed, 1381 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


