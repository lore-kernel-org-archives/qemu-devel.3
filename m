Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F368AC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXB-0005yz-B9; Mon, 13 Jan 2025 14:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQX7-0005yf-19
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQX5-0007Qp-AH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso33078075e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798128; x=1737402928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XU9SV1yi8mdrwIsHPJ6L3udCAs6NfuzN032vLWCnjUM=;
 b=tAuu8n3VvxjN7i6q/YHa25jHB1h1pfNuLzxk6L80glBuBMM6qsYdbUDiHREyfQUtDU
 To4C4ShKhP+gYZabNoqNq4hTb7JiEOCs1GomS0EsPrrLmKiRzEYbSvfkxIKuByzHAzYi
 y0G5wYQ/FzRduBVozllQM1mgh6/b2uv7KFRyT81/D0TmvdaZqVK00y+mQQxSti/eddkK
 2tTJbutF4xDQUgkViOyHxB+fnOBKCpgTDlj7OF7+AIX73dxvSF0v6EUpWTkYo9F927BW
 l5rV1ejdlDw/Tw0yy2MM1IVXj+OkSlJqKdx2+CnZAIpQIzUTzS2jYC5HLwoupuo5okKv
 jDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798128; x=1737402928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XU9SV1yi8mdrwIsHPJ6L3udCAs6NfuzN032vLWCnjUM=;
 b=IHvxYmkf/cvldniT3sugQjJ61aclto714ob6XPKAwa2nOmm+0+zINkBovI+HPD627R
 68is5y4lhq86GVTCqkYl0jBTJdr89ldv+vrLLi4Zo9EkhQzqhTre9bXr6I0+dlkp4LBv
 eAkNBdJ77q2XpJ2F7415alpOAOcUdbhc5rTp/wIr92ZCGRX9xBVcc1qRHGUh17qUNsI5
 19QTmSnSIMZs+pmtgwrL/OyJCh4DUDGEve0hXZr8NGbg7fr8XhOXf31ZI8hKmBDC5Vb0
 gzpFg/8VP/+kHNcd00+e4vyOf6QlI1FBWlTL0Cj8BswMtkXyRAl/0MkU6A7x0Xg2v9PM
 sKag==
X-Gm-Message-State: AOJu0YzCl6gVexbJoYg1r5HiM9lONT4jU8dE57dK0HUpdcDu8LFY7zfh
 HYoEOsvwvcp4h1zeMBp1/ywN2iLSjFZQ+7H9gwo7a3iVZj4qBJQgc18PqC5Jkmey3FgWvb3PXXe
 lkPc=
X-Gm-Gg: ASbGnctr6nG49DIH/4r7n8LUQl1y9nSXwYa6Dwuz4g0t4ZhoQYHb6AZc2Ku6rWTQSws
 8zv4ox74F1rxpJ/uAPqYhLFLxzs/N570rFldBBiCi2R6ZfpSZtlfweEJZzzcjcf4j/rWSfJOvRI
 KVGjCUT/xMUtW++DMiaGDWHPPIRr+kd+Gi7I7IxWV9d+ruK4Tw/3lQM1HEFmbyAZHMLBokwvW25
 TVuY9iXW3yzP2VDQnfckP8/UriAvMRh1Cpckn/QtTNLri61ZS3g33sjG0MhiYMIjxiIkKz2Ox5+
 jr4I0l/icXZ1AYk6t5h7fM9ydgJ1Te4=
X-Google-Smtp-Source: AGHT+IHH1oGl5neQcq+I/vLn403T1oKVRQnFE44XBHg6z+XfkodAkSSGW+uzmys/rBQxfYdWx7D2ew==
X-Received: by 2002:a05:600c:808:b0:436:488f:4f3 with SMTP id
 5b1f17b1804b1-436e26a1b3dmr215149065e9.17.1736798128461; 
 Mon, 13 Jan 2025 11:55:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f49sm150973435e9.19.2025.01.13.11.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 00/19] hw/mips: Remove all uses of &first_cpu
Date: Mon, 13 Jan 2025 20:55:06 +0100
Message-ID: <20250113195525.57150-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

v2:
- Add documentation
- Reorder propagation to reduce code churn around &first_cpu

v1:
- Keep references to vCPUs in CPS and MaltaState,
- Refactor the MIPS Bootloader API to take CPU argument
- Access first CPU propagate from machine_init()

Based-on: <20250112215835.29320-1-philmd@linaro.org>
"hw/mips/loongson3: Remove uses of &first_cpu global"

Philippe Mathieu-Daudé (19):
  hw/mips/cps: Keep reference of vCPUs in MIPSCPSState
  hw/mips/malta: Check CPU index instead of using &first_cpu
  hw/mips/malta: Keep reference of vCPUs in MaltaState
  hw/mips/malta: Propagate MaltaState to write_bootloader()
  hw/mips/malta: Propagate MaltaState to bl_setup_gt64120_jump_kernel()
  hw/mips/boston: Replace bl_gen_write_ulong() -> bl_gen_write_u64()
  hw/mips/boston: Propagate CPU to gen_firmware()
  hw/mips/fuloong: Propagate CPU to write_bootloader()
  hw/mips/bootloader: Document public API
  hw/mips/bootloader: Propagate CPU to bl_gen_write_u[32,64,long]()
  hw/mips/bootloader: Propagate CPU to bl_gen_jump_[to,kernel]()
  hw/mips/bootloader: Propagate CPU env to bl_gen_load_ulong()
  hw/mips/bootloader: Propagate CPU env to bl_gen_[d]li()
  hw/mips/bootloader: Propagate CPU env to bl_gen_s[w,d]()
  hw/mips/bootloader: Propagate CPU env to bl_gen_jalr()
  hw/mips/bootloader: Propagate CPU env to bl_gen_dsll()
  hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
  hw/mips/bootloader: Propagate CPU env to bootcpu_supports_isa()
  hw/mips/bootloader: Remove use of &first_cpu in bootcpu_supports_isa()

 include/hw/mips/bootloader.h |  69 +++++++++++++++++++--
 include/hw/mips/cps.h        |   1 +
 hw/mips/bootloader.c         | 113 ++++++++++++++++++++---------------
 hw/mips/boston.c             |  21 ++++---
 hw/mips/cps.c                |   4 +-
 hw/mips/fuloong2e.c          |   6 +-
 hw/mips/malta.c              |  60 +++++++++++--------
 7 files changed, 184 insertions(+), 90 deletions(-)

-- 
2.47.1


