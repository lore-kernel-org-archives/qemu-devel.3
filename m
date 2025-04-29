Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C14C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kv8-0005BO-UA; Tue, 29 Apr 2025 09:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056j-Fo
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kua-0005bY-VS
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so5488058f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932922; x=1746537722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IoMNbAYXFLaqKD9rC9xntMAc6IoA+MzpMqmKhBJw3ns=;
 b=fUImrGcc73Sh4R4LniSoW6KRJ9+7lg5/52BnnKVwhTE5QfRzmD3MHmccO4miPUypQw
 dBrBGthw2u4/ZAkD9KZyCLOKlg+rOFanDZdBxu1eNpmDqnDtxqkl4bNmmWkhXX//r9A5
 3GCKuzinUdbr4B6hFuhrMXFzIlbu3QjFTJRk+/HbNXRUudJ3kWA/Yr4ndEuIn+vfnXpf
 6lb7XjWk7n+nzwU4S1LYnXFdgnpOrDOb97s3FOqWj6y2DzTuWyN0FyDOCHrvK9klAkAn
 kwGlhJV2LZQ7vLyENKsKftem0n2kO9IZ6c761m+214msaln1UsgPTr2hr1Iy1qAhu8Dy
 6tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932922; x=1746537722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IoMNbAYXFLaqKD9rC9xntMAc6IoA+MzpMqmKhBJw3ns=;
 b=SvLqvcJabKEM9/GOBaz6Dfmzo7SB6CF4NBX5knnWQVyTUnmMi4ReHPBOyvlENXbR+n
 PLhWhrqLezyhjIIQyThU5IySLEmUtAwYUfQ5ZHJwCriWH/MF35BHHQX47NgSUfSOmiDu
 1NC5O/5KjaJBEvNbXdWzQ6QhKajJENNJMM+ffLiGBxIrWP3ibQyRbaiqk8ackUD+r461
 Nzhj1BUbn2jsOKS5W4jF1aaF1AsaJp14+98dTDN1oRl1iYJZ/obk/qBWF8zDrHtjSdRB
 C2BT7JuVhwC6Hu8E2tVj6XhmCxY98O84qwNm0cUhvVZoZ7e8MJl+r6cPtaegyKrB5abZ
 nEPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYdKGuewCNYnl8JX711ykPPy8tz46S2/vOAGImHRhSdkcKcM91iS2Ue2EW3xASsT0vfqcICdzIZlSs@nongnu.org
X-Gm-Message-State: AOJu0YyAqzBtH30tn0vfWm5Ypfzz5beeg/MReI8/2ZtKb628M9wcJiL3
 GLbD12P/X24AITBHWGkKwGizx3US/KxpXZdELCyuRO/SZQpjizhPyxlCEbrPoXg=
X-Gm-Gg: ASbGnctcTcmUMXcuHnsXYCysFqOzQRwx311HP8VGeTrXGvGfIJt2pnVUfTrfBsKqIK4
 aM5GgXM4mrXGAFS879Ju3/YT4vgkh0VEsqj/txsmCq57qRCY4QOQttzZ/4bVPH3yZFoH54kQht5
 dzn5bMj7rQgr7hSp3rJpWcPuj2MSAZ/C8VqloNjtRNt7AbOFHcKanENy508mQR4oe9IjfRxMCVO
 2fkivHfoVKHpnddZx0pePpMusoni5n0m6bO4HwOI8SofuBfmXiDOC9lRfY8K9rJWyK1ajTKLd86
 lSkNNokgBF1XIYMJNgPYFa11fCtc+4bom0oZS2KgY0/yWXs=
X-Google-Smtp-Source: AGHT+IFNyfMYzPvkbKDH9ls/rFRy7J36YXD9LAQK1e45PqX5U49V6E0FFJjuUSn+HtARGrhKjkZViA==
X-Received: by 2002:a05:6000:401e:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a07aa5fd30mr8672886f8f.4.1745932922513; 
 Tue, 29 Apr 2025 06:22:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 0/7] target/arm: Remove TYPE_AARCH64_CPU class
Date: Tue, 29 Apr 2025 14:21:53 +0100
Message-ID: <20250429132200.605611-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently we have a class hierarchy for Arm CPUs where
all the 32-bit CPUs (including M-profile) inherit directly
from TYPE_ARM_CPU, but the 64-bit CPUs inherit from
TYPE_AARCH64_CPU, which is a subclass of TYPE_ARM_CPU.
This subclass does essentially two things:
 * it sets up fields and methods for the gdbstub so that
   the gdbstub presents an AArch64 CPU to gdb rather than
   an AArch32 one
 * it defines the 'aarch64' CPU property which you can use
   with KVM to disable AArch64 and create a 32-bit VM
   (with "-cpu host,aarch64=off")

This is a bit weird, because the 32-bit CPU you create with
KVM and aarch64=off is still a subclass of TYPE_AARCH64_CPU.
It also still presents gdb with an AArch64 CPU, so you
effectively can't use the gdbstub with this kind of VM.

This patchseries removes TYPE_AARCH64_CPU so that all CPUs,
both AArch32 and AArch64, directly inherit from TYPE_ARM_CPU.
This lets us fix the bug with gdbstub and "aarch64=off".

In this version I fix the bug that Philippe found where we
were calling arm_gdbstub_is_aarch64() too early, before the
object had been created and the "is it AArch64 or not?"
question resolved. This is basically moving the gdb_init_cpu()
call into cpu_exec_realizefn(), but we need to do a little
adjustment of microblaze for that to work.

Version 2 of the patchset:
 * patches 1-5 from v1 are already upstream
 * new patches 1-3 here delay the call to gdb_init_cpu()
   so that it is done only after the CPU object is at least
   inited and we definitely know the final value of the
   'aarch64' property
 * patches 4-7 are the old 6-9 and have been reviewed

thanks
-- PMM

Peter Maydell (7):
  target/microblaze: Use 'obj' in DEVICE() casts in mb_cpu_initfn()
  target/microblaze: Delay gdb_register_coprocessor() to realize
  hw/core/cpu-common: Don't init gdbstub until cpu_exec_realizefn()
  target/arm: Present AArch64 gdbstub based on ARM_FEATURE_AARCH64
  target/arm: Move aarch64 CPU property code to TYPE_ARM_CPU
  target/arm/kvm: don't check TYPE_AARCH64_CPU
  target/arm: Remove TYPE_AARCH64_CPU

 target/arm/cpu-qom.h    |  5 ---
 target/arm/cpu.h        |  4 --
 target/arm/internals.h  |  3 +-
 hw/core/cpu-common.c    |  3 +-
 target/arm/cpu.c        | 36 ++++++++++++++++++
 target/arm/cpu64.c      | 82 +----------------------------------------
 target/arm/kvm.c        |  3 +-
 target/arm/tcg/cpu64.c  |  2 +-
 target/microblaze/cpu.c | 22 +++++------
 9 files changed, 52 insertions(+), 108 deletions(-)

-- 
2.43.0


