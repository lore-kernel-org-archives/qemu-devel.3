Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB435CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnJ-00074V-3u; Tue, 02 Sep 2025 03:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnD-00073t-MF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnB-0001uZ-F4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso4453972b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799456; x=1757404256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1KDPIcfYEhsmrwuz9WFplpLUjFQgTVEe3sUb2KPSJuI=;
 b=qy11qxmea3ky0NMonO/LGsVfBmN6d2CNYQcFlzhBx6BgswVqhKV0+sza283aUACWcK
 UOBVoH7dc6tJmyA8kxDRQGRWUK448rTThFjLurr1+xz30BUwbRdnWPViNqB5LFDTeEV2
 6sgMUxwjreK0shq0RvVudX6bS5AyEwtcVyqMol/9DV0nf2VBB47um73aU4omEheaRQkN
 obovdLJcYWnrEonZNzTUPWIHmXz2NZEyS9ejPsBKsfNusak/TPSKVb6JO9/rLLAUeKAw
 2hHlQFfyXoJycNe7QUV2cmUQCWmKE1OkdhXFkzmRHCN+YrSEGgdVN/eOVFczrTjfU44t
 AueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799456; x=1757404256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KDPIcfYEhsmrwuz9WFplpLUjFQgTVEe3sUb2KPSJuI=;
 b=kR7flTjDUqoWlZmT48Lq/P6ju8LTmd6Po5TrYYMasCN2ZYRUIXeKNNfvo7WnJtfuF/
 /odkX57ELxSPawejyXrzGqAlJbLC2Sa/Hx35a7ggKQdfKjDBz2/j4/R70AQSlFXe98ja
 sdXE/fy+G6XF2KYDlmQOB/MMM8jSykJqhcJa+RJOx28wXprGofGHCqp9qqrn0+qJ4Q09
 0mv3d5U76EIQCl9D9OPXxQ5aWYPlthCndbKySqO8c6RlObwg+PyHAUecjnp8SNy6pmqP
 1oMnYrHH2adUGwdr/XjZs2s12DcI3MKzvW7x6NMSYi4HUqcBdWxWoN3PjYESFUYrkaw/
 crrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDEi36YlzYVVZUld89S9tuwp0axhcGs++LXYaMzb9EhwuXtp32BgtnHsC4tZkERJyuvHOd9rEcm3gi@nongnu.org
X-Gm-Message-State: AOJu0YyXTsDuz/igyv899ms4ekI7FhZZ6h70PyvXsUsf/Q5QggbVnyLV
 A5Mfbo5VBVqIszK8px2oSrWpA9Co8aI7ukdsqpGxiwOjn4AfStSSJ1xm9EIeY03PLq8=
X-Gm-Gg: ASbGncth8E6G7x2D3/4/MfBFP5oNeyWLVoqp94gqMXVNKR3f1H6fGRdgdvLTtNzaGId
 NEedWmsyxZ0IX/VcvVzY63sejjr5hrT3nUBnJZ7fAH7ys01lfqIhId61eURI4lRNtbD3NTPMqIy
 3CuixIspWH9mT7Ze88M+mBppVC+Y8muNvVhCDGaLjEuQimdO5yXxm7+6KmGeWHM0BThnZ9AtzfW
 12xMp8Vnhd5OtvL1bR+bf5JTF2DIicvZKmzDZBQme3RHVE9tZzQh+mMDHS4w3KmaL6JJKu9aiYo
 t2HOk+Hy8iq3jFjO59mfWB33ocrV3ZaIV812wvNiBe4kLG44yQvXRUuzgDICsIr9hY9pbe61pcq
 48zmCa/pj3ebcRjkmH5fPNYNG6PUaQH28rKHScpaarVRMKYewVDnqxQ==
X-Google-Smtp-Source: AGHT+IEJjWyhALbMEB7bfGM6gSpkGBlun+b+lA0P2ALKG/bH8JF61j2QQj2UrSTezbQf9dnb68hUPw==
X-Received: by 2002:a05:6a00:1398:b0:770:4eff:a300 with SMTP id
 d2e1a72fcca58-7723e224647mr11041049b3a.8.1756799456162; 
 Tue, 02 Sep 2025 00:50:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:50:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 0/9] contrib/plugins: uftrace
Date: Tue,  2 Sep 2025 00:50:33 -0700
Message-ID: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
this. It's implemented for aarch64 and x86_64.

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

Overhead is around x5-x15, and long traces can be directly filtered with uftrace
if needed.

I hope this plugin can help people trying to understand what happens out of the
user space, and get a better grasp of how firmwares, bootloader, and kernel
interact behind the curtain.

v7
--

- Constants for TRACE_FLUSH_SIZE and TRACE_ID_SCALE
- nits (add () and ,)

v6
--

- fix types and spelling mistakes
- use _MAX for privilege level enums
- uftrace info file: use empty strings
- trace flush: assert we wrote all data
- doc: added style for keyboard keys
- added URL to document uftrace entry format
- updated comment in vcpu_tb_trans to explain why we always instrument the first
  instruction in tb

v5
--

- addressed Alex comments
- split plugin implementation in several commits
- removed instruction based timestamps (only use time based timestamps)
- removed sampling implementation

v4
--

- add support for x64

v3
--

- fix missing include unistd.h (build failed on MacOS only)

v2
--

- trace active stacks on exit
- do not erase map generated in system_emulation
- add documentation to generate restricted visual traces around specific events
  of execution

Pierrick Bouvier (9):
  contrib/plugins/uftrace: skeleton file
  contrib/plugins/uftrace: define cpu operations and implement aarch64
  contrib/plugins/uftrace: track callstack
  contrib/plugins/uftrace: implement tracing
  contrib/plugins/uftrace: implement privilege level tracing
  contrib/plugins/uftrace: generate additional files for uftrace
  contrib/plugins/uftrace: implement x64 support
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 199 +++++++
 contrib/plugins/uftrace.c          | 878 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1231 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


