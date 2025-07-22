Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C27AC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue52h-0005b9-Ng; Tue, 22 Jul 2025 00:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52S-0005Y1-KM
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52Q-0004Ft-AJ
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-311e2cc157bso4275785a91.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753160136; x=1753764936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgE++xvexUseTINqBHq6gQeS3k49ucX5EMn4UZFtaoA=;
 b=NXN+ORUAwUJbUvS4pOpRuFxsQhVfoqN409EC4gf4ghS7U8WJAvd9ZjTxZX6FfbX+rn
 HPQ2M9IzVI2GJ1pcJZEOAceIyjHo4Rmcl3iZeamrv0jKA8ewlt39tCFSWegvyHZnA/+P
 n/rjbjdFc0cGiDyTZYrKG7gYMnCG+rWM6AjI7o6XnGah3FsV4X9euLLQ80L0zi//+/TY
 ErKZWquh2IaG6n974856m4XfWkmdIfk+B3B3SFF/Ph5MpGpghg6tRLAD9PGAwLva3WC1
 06z+BB8aq5iCqA6O1yzlpRxJegjeRYJqkq08yRf2XpZvGG/M/oeTm5HiwN/z2LokMSon
 p4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753160136; x=1753764936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgE++xvexUseTINqBHq6gQeS3k49ucX5EMn4UZFtaoA=;
 b=puMHdFDW5eM63DZFpHUESKyTwybbc+7MnHeUI4luC/kqJviope3Fc/gAfbr77NiiJF
 igKDFnrZf3euhRgbriIWoqW5uBf0vE+nKsRUYv9pg18u4payU1pFXWqtqAu0P5yG+5fa
 6KWsYHkv0h8+DdwPgTYX3fKojagqpGAZ+/zaw3QeyA79y5NTs35sFuKP1NFUtrWrEfvU
 oxH8GV0NBc1qXhjYBlu+5anf9aLgQT50GCZmFC2+R95S90lPE1WH/XVRaE5w1TTfhy2Z
 6c49p1/vw/Gzm+qTIciAHrcosM+NZOjRrhHSraLAEr/tdkefHGsRsi4dOnRuNyaQ88t7
 1MQg==
X-Gm-Message-State: AOJu0YyGkYs5CSFRtBxXSKIwgUccKxSWj2ximrxry8n27LGILnamy1Mw
 3p6f2waZC5QjGa/sZnyAGBsZ+9fDYbT4OcDL+Ev2mTy3umKP329pMiY7wVSGgam6KlfcgcaWD63
 YkUUk
X-Gm-Gg: ASbGncvMo/jPbdiMYfA7puhGDytEu7iWNkO3edxyc/Ta+MAM4bqvNooRPqF15wRFTFn
 Ge1hPsVHHKOpbtJ740Q+44uWwWLTmOh2ZwIBnjPzwm6pdelxya8hG54nyxg/z/n2IzdR63k1eva
 82fJDxkC1afmijUq9JXWhK1nGBsPmZKQ6aj7SfAOQHJEYMvi5g5+Ndz0o9/PvEGfiOuH2tKOtTc
 KZyJvLMeoQfkqHjyh4eIjsBnfqnRu/haHr75eZUCcOlhOP50/4cvsFfdutzcdkaowDis+p1NkF1
 9ra7n5hijvWzf61bXQOo2jYPImWov/ZLEoeCSjzU7zVV34r4iWWANcnK4vAz5C3FkzvR9KKDuHG
 pbrcoCKVwrEPxKHSVhc0SFQ==
X-Google-Smtp-Source: AGHT+IHuymRnNx96K0cVHXkKQrM7BpKhCPd2QYtD01R7jm48C6FoNtK/mShnTAUAR4bmy0niqoifAA==
X-Received: by 2002:a17:90b:5281:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-31c9e6e52e8mr28060569a91.5.1753160135793; 
 Mon, 21 Jul 2025 21:55:35 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cc3e5b038sm7065311a91.10.2025.07.21.21.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 21:55:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/6] contrib/plugins: uftrace
Date: Mon, 21 Jul 2025 21:55:21 -0700
Message-ID: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

Pierrick Bouvier (6):
  contrib/plugins/uftrace: new uftrace plugin
  contrib/plugins/uftrace: add trace-sample option
  contrib/plugins/uftrace: add trace-privilege-level option
  contrib/plugins/uftrace: add timestamp-based-on-real-time option
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 207 +++++++
 contrib/plugins/uftrace.c          | 920 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1281 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


