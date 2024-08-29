Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E2DC87FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjiJU-0003HB-Ok; Thu, 29 Aug 2024 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjiJR-0003Fo-1N
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:47:57 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjiJP-0000Pd-AL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:47:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-715e64ea7d1so687144b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724950073; x=1725554873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u373siCOzcC/sO40JoW2Mvq9WFmho5CpIIgm8XnxVOQ=;
 b=BD6T05a2PY+rL/9BlvAFe7EK9a2ZlTe+mKNa2/19M4eJFOI0cl3aKgNw8MIlsmgwVD
 pIpw/wo82ujKpmFpx3p8kOBvpLCVZIR3CBxWaWBM0wx7EEoBipy4EPZL2Ron7jCmB/IX
 xo9tk1vfQb7pZvXHyRSgAhD+MDq4tnMkC6xsVYHPrkGt6kTI5t+s0LsKE9LyqBBJEwAN
 7CNCRt6nE0t1okWOKbf5Y7kOyWD2wU4zZ5nLXFU7ORSsb5mNi/HmsftlvORdkfSRY+DZ
 hZZlYwkg95dvATobKumdSHay6U/1753/iY4QH/zEOKRFWcMG43Z2Iso2fgczZS+WicwP
 XyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950073; x=1725554873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u373siCOzcC/sO40JoW2Mvq9WFmho5CpIIgm8XnxVOQ=;
 b=nXv2qXcZIWHftji50azVbcsROQTQCe62ZLTRS2AA49XAw7Z252QOr9o0HWtjuB9i0H
 Y/bo4jUi4O2QJboR9L6VinDepL5OB53vXcA62QlClHXXR9T1ztvuZ2yw1JJwHT0FAA/i
 JssvUEahL1mzfFYBC3uoCVVOt8I5DcX7LyJhVTAwohVrr4FAmD53d8gzHrbKNnUIz3eR
 S5yxuIthexyqMI4W5SrOQV0faMx0gfLr1yTIkiEO5uCJp9LKh0V67LFWsFIWzLEdW/UA
 BiTB6NFQC6apiTbp+g3ZfDN76jUryb5eZ2uXkirVWCDJUDSyH5zg9Gij/ehb+bYC1hDd
 tELg==
X-Gm-Message-State: AOJu0YxhPv02RpgVJxV7dz1tREpSmTdMILoU7hNISfnDT5GXMuouC6js
 oS6fbeO+TrsXw07YpsBKzaPThYML3T15DoTfIMZZzpLkFJKHiovq7NXZ4uSoanJJdQ==
X-Google-Smtp-Source: AGHT+IEtFmvL/srDgbfxlgQj8hKPUCCbq+DGmxxuM29gK6DZEA2GsgGb+4axYejBSmHXha/7RkyqtQ==
X-Received: by 2002:a05:6a00:3911:b0:70d:2693:d215 with SMTP id
 d2e1a72fcca58-715dfb77efdmr4534781b3a.16.1724950073006; 
 Thu, 29 Aug 2024 09:47:53 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e55a4630sm1349061b3a.62.2024.08.29.09.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 09:47:52 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 0/1] plugins: add API to read guest CPU memory from hwaddr
Date: Thu, 29 Aug 2024 09:47:50 -0700
Message-ID: <20240829164751.9504-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds a single API function which allows reading from a guest
CPU physical address.

I don't know of a good way to add a self-contained test for this feature
to tests/tcg/plugins, but I did come up with a small test case to
demonstrate the functionality using peiyuanix/riscv-os:

First, grab and build the firmware code:

curl -o firmware.S https://raw.githubusercontent.com/peiyuanix/riscv-os/main/03-Bare-Metal-Hello-RISC-V/firmware.s
curl -o firmware.x https://raw.githubusercontent.com/peiyuanix/riscv-os/main/03-Bare-Metal-Hello-RISC-V/firmware.ld
riscv64-linux-gnu-as firmware.S -o firmware.o
riscv64-linux-gnu-ld -T firmware.x -o firmare firmware.o
riscv64-linux-gnu-objcopy -O binary -S firmware firmware.bin

Next, grab and build the plugin (just dumps from phys address on first
instruction executed):

curl -o dump-riscv-firmware.c https://gist.githubusercontent.com/novafacing/5abc08052fab671a0fb26547810b4c55/raw/33772d614d6e36eae30e3405af34f149d7cc608b/dump-riscv-firmware.c
gcc -rdynamic -shared -fPIC -Iinclude/qemu $(pkg-config --cflags --libs glib-2.0) -o libdump-riscv-firmware.so dump-riscv-firmware.c

Finally, run the plugin:

qemu-system-riscv64 -display none -machine virt -serial stdio -bios firmware.bin -plugin $(pwd)libdump-riscv-firmware.so -d plugin

This outputs as expected -- the hexdump of the running firmware:

b7 01 00 10 a3 80 01 00 93 02 00 08 a3 81 51 00  | ..............Q.
93 02 50 00 23 80 51 00 93 02 00 00 a3 80 51 00  | ..P.#.Q.......Q.
93 02 30 00 a3 81 51 00 93 02 10 00 23 81 51 00  | ..0...Q.....#.Q.
23 82 01 00 83 82 51 00 83 82 01 00 a3 83 01 00  | #.....Q.........
93 02 80 04 23 80 51 00 93 02 50 06 23 80 51 00  | ....#.Q...P.#.Q.
93 02 c0 06 23 80 51 00 93 02 c0 06 23 80 51 00  | ....#.Q.....#.Q.
93 02 f0 06 23 80 51 00 93 02 c0 02 23 80 51 00  | ....#.Q.....#.Q.
93 02 00 02 23 80 51 00 93 02 20 05 23 80 51 00  | ....#.Q.....#.Q.
93 02 90 04 23 80 51 00 93 02 30 05 23 80 51 00  | ....#.Q...0.#.Q.
93 02 30 04 23 80 51 00 93 02 d0 02 23 80 51 00  | ..0.#.Q.....#.Q.
93 02 60 05 23 80 51 00 93 02 10 02 23 80 51 00  | ..`.#.Q.....#.Q.
93 02 a0 00 23 80 51 00 6f 00 00 00 00 00 00 00  | ....#.Q.o.......
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  | ................
Hello, RISC-V!

For v2, removes a symbol left in qemu-plugins.symbols accidentally.

Rowan Hart (1):
  plugins: add API to read guest CPU memory from hwaddr

 include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
 plugins/api.c                | 17 +++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 40 insertions(+)

-- 
2.46.0


