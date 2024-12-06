Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFEBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVXR-0006Mx-Pk; Fri, 06 Dec 2024 05:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXI-0006Ew-GA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXF-0004RX-PN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215909152c5so21294835ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733480767; x=1734085567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fbtdTYVpjiZom2u6PDj/6kuYKtGHTXtnoaoW3mG0VKw=;
 b=aVmBB9+S4EoGp3upnHIKAldF2i/3ba5j8HheocnXYtmtwOecgzW9ScCakQ1Jq+ljBC
 YJjylVjrujrRHsYUnrA1klAjIsPY4ULSX3y469vZutOkFyaoWNrq4gJomtahVIQFvLWa
 Pxcyad7NuVnbsubuGXw6Cz3X8uqUQ9CUmGzl+uE3ce67MVBVXhJmNGcWNKBEJz5QWxoo
 a85IUyIwUzRkBvAen2WB8sjACdmBN60jdcdBeK7SIfkEYhkiKMPfKYnjyuSsot8hVDs1
 zOuqmNyakehpLsQt2NK8cMzQ2M0wITwmJSZxIN5/rLfNKTTvdrHo9ZB0/7jhTMRnNAKT
 cV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480767; x=1734085567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbtdTYVpjiZom2u6PDj/6kuYKtGHTXtnoaoW3mG0VKw=;
 b=NvAKMhOO2b3KO6uHsgdb43KszUTObMMBcvjfoINwNk7QcgPkIpuqrr2kHvn5Dg/env
 VoJLJ0zTbRZaSHEXy9ftxkAFH/Q/GeyUfP9d2RQVIQnT7VxVRDNLoMKrFpkneTde5xXB
 +bfSRRu73Hlo4EhXKrheQdYr96wlDL9Qbd3EGirCacpLNlRloCJ6rQhpgp7CKrJAowwb
 riYiYJEcFXsDL6RoAZr9Be18cqxKFHrOCqWa3XigzDcjdz9jdl14gR8AID7+xSU7VdR1
 iRMYooJlJn/TdnpFimghZh6ue9W9oOoc3f+QWF8ts79sB2yrK0YrofXyHBJJAS1MsM5B
 EJjg==
X-Gm-Message-State: AOJu0YxhIpPMkD9Jixl2xVbWMdgaeG05XAyI+lxBfp3OmR5BmK9ZH1+M
 py+OZTMC/crEEk24/dPgn0bvE+fTxUbHBGpwjvEu0sVhBJ31IFXrhixNqKmEPWg=
X-Gm-Gg: ASbGnctbtpL52Cat7BngK2RTdDO8nwOV1phsWqfozdBFYiISmYh3xqadcPkKdf7F3SH
 8FjTSJzh50+kk/B9VQKC17OvSIyeB/djQa2VwlDCBIMHEraUMXlcGsh38/4UzfezJS+3hlHlsHb
 XSXVV9sEWEO6R9YeUwct7BtEQbBU1IQPKdU95cTkAsCJraoWaVEBd9OaW4UkhfU0Hi4bwk0n/Ie
 MUivelVJTSP0fIJrIILsEpfW+t/bnTkQ6z4ewRRWl6MTYQ=
X-Google-Smtp-Source: AGHT+IGqkPXb5n4UvAca38HI1MBXjkZNpFJce/uVvA7HxQk8fWufpzYirBrdr90QDsr0oR4WlqHSug==
X-Received: by 2002:a17:903:240a:b0:215:6816:6345 with SMTP id
 d9443c01a7336-21614d74ed8mr40712865ad.16.1733480767016; 
 Fri, 06 Dec 2024 02:26:07 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e3e452sm25934885ad.43.2024.12.06.02.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:26:06 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 0/3] Add additional plugin API functions to read and write
 memory and registers
Date: Fri,  6 Dec 2024 02:26:01 -0800
Message-ID: <20241206102605.961658-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch set follows a previous patch which added the
qemu_plugin_read_memory_vaddr function and adds a set of similar
functions to read and write registers, virtual memory, and
physical memory.

The use case I have in mind is for use of QEMU for program analysis and
testing. For example, a fuzzer which uses QEMU for emulation might wish to
inject test data into a program at runtime using qemu_plugin_write_memory_vaddr
(and likewise if testing an operating system or bare metal application using
qemu_plugin_write_memory_hwaddr). It may also wish to read the initial contents
of memory using qemu_plugin_read_memory_vaddr/hwaddr.

Similarly, a testing framework may wish to fake register values, perhaps to
simulate a device failure, perhaps by using qemu_plugin_write_register to set a
register value to an error code.

I think all this functionality works together to make QEMU
plugins more powerful and versatile, hopefully removing barriers
to using upstream QEMU for these tasks which have historically
required maintaining a QEMU fork downstream (like QEMUAFL
https://github.com/AFLplusplus/qemuafl), which is tedious, error
prone, and results in users missing out on enhancements to QEMU.

A test is provided, compile:

gcc -o tests/tcg/x86_64/inject-target tests/tcg/x86_64/inject-target.c

And run:

./build/qemu-x86_64 -d plugin --plugin build/tests/tcg/plugins/libinject.so tests/tcg/x86_64/inject-target

Hopefully after a number of tries, the inject plugin will inject the right
value into the target program, leading to a victory message. This plugin
handles simple "hypercalls", only one of which is implemented and injects
data into guest memory.

novafacing (3):
  Expose gdb_write_register function to consumers of gdbstub
  Add plugin API functions for register R/W, hwaddr R/W, vaddr W
  Add inject plugin and x86_64 target for the inject plugin

 gdbstub/gdbstub.c                |   2 +-
 include/exec/gdbstub.h           |  14 +++
 include/qemu/qemu-plugin.h       | 116 +++++++++++++++--
 plugins/api.c                    |  66 +++++++++-
 tests/tcg/plugins/inject.c       | 206 +++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build    |   2 +-
 tests/tcg/x86_64/Makefile.target |   1 +
 tests/tcg/x86_64/inject-target.c |  27 ++++
 8 files changed, 418 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/plugins/inject.c
 create mode 100644 tests/tcg/x86_64/inject-target.c

-- 
2.46.1


