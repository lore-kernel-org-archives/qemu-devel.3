Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA91EC5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCEX-0005XT-LP; Wed, 28 Aug 2024 02:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjCEV-0005WD-1G
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:32:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjCER-0005nF-QM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:32:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-714114be925so5392559b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 23:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724826746; x=1725431546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jsx+cwgu8fs+nLb4Ziojd8zXuqxJUbfZPN3AFpOJDg4=;
 b=E2ctaFkY2XBuiXzP7TeNSB/UgCwccrjvAVMxWau/lUMJAPeU4FQZRVeYRyQGT9pric
 Gjq4SSxPm9V1YKTywriTY0N2l3YOipDrcpMzQWg48KzZesNJ091xX256zFdt20V1G+g5
 sKBZ7L66Cua2U7y/0EabmvIo7o6SPY0f4DQy+QT6GOvF1Qnz4DSPWe13bngUaz3+T/iJ
 VpdslSF4FG35HDg0QnFDmm2R5SRhNattoxhhKprUOTElhgUNCzan7iscCq0x82g1wdSN
 w7pL7YRhPc9hzmYjaFK8d1n/JFBv4o94SKPHtzwxFeCdZwjSQ8Uw/u220zOnD0cpSdXm
 qJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724826746; x=1725431546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsx+cwgu8fs+nLb4Ziojd8zXuqxJUbfZPN3AFpOJDg4=;
 b=ZSvp80Gg5GHtF1ItSdWZ3n5F+Ulj3GqU4Q8aBd4C/xf4vdME2N+UJLXASHeNz3vIG8
 wRFVLFk9vtzoHftkeGV3KAzbEec7xLQ0rCSHFP6fHc/AdImm+L76XJk5xkd+qfFRqgqP
 1EVuho0SfYKjNGikw+mYinNwp2PRBENEMcdsZr1U3cWgifxbvjycCkozU0f4K64MJzAT
 z70PQ/QrM2T/4NXRH3aMPsRVUdlPqcIom6lSMzd5r3ymDalaZWZTAkvzwIfJ/JTY4a31
 Hu/DZDal/x1r+fpHE9PDDei9056zNFXs8vL111BRW1gJOzemFrNhzWy062/+NblVoTiO
 444A==
X-Gm-Message-State: AOJu0Ywu3trcXWk5I7UvGwqV7393uCJ6PzOYffZpx7yCH9JBER9fpvo8
 5z6XqSYW8V/GHgksL0AQXEzcD2HvRx+aQcDJk5E7BHt+laxE+kKNBTD9onZG/tJwvA==
X-Google-Smtp-Source: AGHT+IEhsutwuxlzOfsyi4D49eTO7B5keO4c/68kt1+qHYXEwHk/VpYUlNPIrwTs5eOrT7EgCCpzMw==
X-Received: by 2002:a05:6a20:9f8f:b0:1c8:92ed:7c5a with SMTP id
 adf61e73a8af0-1ccd287c16dmr1101048637.22.1724826746292; 
 Tue, 27 Aug 2024 23:32:26 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d84461411asm763970a91.24.2024.08.27.23.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 23:32:25 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 0/1] plugins: add API to read guest CPU memory from hwaddr
Date: Tue, 27 Aug 2024 23:32:23 -0700
Message-ID: <20240828063224.291503-1-rowanbhart@gmail.com>
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

Rowan Hart (1):
  plugins: add API to read guest CPU memory from hwaddr

 include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
 plugins/api.c                | 17 +++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 41 insertions(+)

-- 
2.46.0


