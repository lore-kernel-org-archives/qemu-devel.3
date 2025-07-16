Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779ADC83F34
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubumX-0006nN-Mc; Wed, 16 Jul 2025 01:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumW-0006jv-Df
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumU-0007r3-6T
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so4447769b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644052; x=1753248852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yZCQ4bzQghNDcU+7Tmq4rQb/bgKjDogLdHliCi6xu7M=;
 b=PZw8sn0oIAgFstaT0STZGmPakRvRKnsi5I4aym52XvfQrkFHwLPojenny0oH4qoxXS
 MBTi/NfcBQaHSrWDZYZp66yTZUdNjDLP7MXAFicgaJt88kZULgrqo2OYiD2Gp9t3wUC2
 ghUBaNgqHEIfPifEL3qypiZgL9kIQeSjaAOPrGKbdSpTeTIGXgQuma7PwEhGgETyLrec
 HQX5JLu07x7DV7FcqGdIPgA8tU5lybM2X9pu6rIOO9GtZdDJwZy+qI0c9un8Sv06O+vy
 XDQIxa4ROidfLKfn/VT02xApmZAFa0QGWWxaUgY+PKl4cWnMHDpJm5zpz2VDTxZDA0h9
 A/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644052; x=1753248852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZCQ4bzQghNDcU+7Tmq4rQb/bgKjDogLdHliCi6xu7M=;
 b=uBTOzgL5JYJ2dTxmwsoDR9ma3zAAYlATvDu0UZOCeOWyw0JYmgvbXaNOujVvq+0xwH
 jgyvXTgqIl60OHjr8tOTVfwV+iX+1PGHnwfDjfTviqAbm0pWR3D95J07cxGKBzrFDOAG
 YfRHYHfxvvdbDjcJlbe8L+hpYhlTJzYeZu/eXHZHaABXiGPV22d5HWImMAgMI0lX5lIL
 j3bTOw6h5D4KOfSoWfCOupnGJEBGaKfwzKgK+4QhUc0lSo8rTSp2/zgm43KHdf3mGinw
 xCPMoZMivhJ/waWcDJnnu3ONrnq52LxP0h7kQf1vHzvzzfnmGyamfEfuF3wUZZ61QnVr
 t8sA==
X-Gm-Message-State: AOJu0Yz+ZELrxJd4KOkBHjPCKn/p3txe6eqQvjwiSI3fNwhmg8n4VICp
 eHGLr3oVjM3CEss338Wqw9P+nkxpgeqtEBcsJE6H/Y9w/0LPcdgpCkeuyVtR3CgULMVAxfIlMcr
 WHkpW
X-Gm-Gg: ASbGncvSCzjpBBl409+rOa3E8feRJy5ItdGCTR3lF3/4J13yoIptGiuvSfAAM8lrXmj
 wnTN2Pv4NA9tHjGzikjdOYPV6hDdppWDQuu2zjqwN1VSxRUJSS95+vnfDeuMbdGADrT3uHMKvNX
 n0BnKm67JoVuZJW5s68jJSNTjbvTClT3ZDU2XhefpU5d6lGZG3JtmqglXeh/JQYq7ursG6pud/t
 HDcfdp6grfUbvYrW8s4deJI2UdvEpvhYofD28dpBVq0YFI+E1Slm7yTXdCfmwGadKLoeANhPtoG
 HX284QR5ocxWu0L30I/jivyN4GDXY7vmpPw3L220TLT1QWFu324BQLyaiA68KQFr71yYoMFLzOU
 ZJSbAsV8Ys57+63IIZAxKiA==
X-Google-Smtp-Source: AGHT+IE7HHVrZmoq9v3kNdZF9GCVz6+uPMYgRnpNM7cOekr5ahXVMqnk6Ef89LIKFIau4EdX/Q4Z+w==
X-Received: by 2002:a05:6a00:c90:b0:757:51d:9af9 with SMTP id
 d2e1a72fcca58-7571f716dcemr1906415b3a.0.1752644052260; 
 Tue, 15 Jul 2025 22:34:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06aa6sm13790162b3a.62.2025.07.15.22.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 22:34:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] contrib/plugins: uftrace
Date: Tue, 15 Jul 2025 22:34:01 -0700
Message-ID: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Pierrick Bouvier (6):
  contrib/plugins/uftrace: new uftrace plugin
  contrib/plugins/uftrace: add trace-sample option
  contrib/plugins/uftrace: add trace-privilege-level option
  contrib/plugins/uftrace: add timestamp-based-on-real-time option
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 184 ++++++
 contrib/plugins/uftrace.c          | 899 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1237 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


