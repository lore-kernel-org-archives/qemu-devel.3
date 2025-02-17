Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08C2C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwK4-0001xQ-5a; Mon, 17 Feb 2025 03:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwK1-0001wt-Tw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:17:45 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwK0-0000yi-D9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:17:45 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so55294585a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780263; x=1740385063; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca383jZ9H/7hPjftb6ykvA59uZ+joaH9NqOxjYmz17w=;
 b=lw4quyXZg1GxyxL/XGGyiGmOubyU1XPxlGwT2n31yAngq3P44BBb2GSbNcZDzzqGMe
 B7A8eaBKfwyN04Mq+2dpDKjijjbkh93QNIAdSD7iS0HjqF4b2I227Vbw4LHooEcpuW56
 p4M8PVooTiugXvyJHWIGZm8IHNrtO8cIALyrlnd62ZQ6trELamggD5H+up70JpVq2+BS
 vaR0HkA3mWGVxTdXtes9W3t1eGm17auiRs3DUnx4meslvIop0Im/dh93pE1l58502cuB
 ycf/s2St6Utz+rKPhPX+DWg9hAkq1j22WQdWrrBzXp6kYgJLR3scETDKQzWgf0tmLAEN
 l8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780263; x=1740385063;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca383jZ9H/7hPjftb6ykvA59uZ+joaH9NqOxjYmz17w=;
 b=Sl6dXe35AHpzaOBf49gZUaUKYkjrI4HkUH37QQgRf/1C5MVDDJMerl/+DZ769pNK9P
 o1IkhSImDbtBmNO+JjZnkj7BDSAlscNaoK2RbIxLnbGo9WHYpEnLGu2smmm+yY140Vnc
 klqrUW8un03fOsz9zD2LFMPd0eK19f1WWbSX06OnbOFj/UedaxdQBepjY43si8x1ofwb
 xTK3dCTikCEHzq9RTOvfG5xTgXh4BJ/BZCHjLTThhaZSSs3rvkEsjSwJ907UDlOrYfhG
 pCNpGjPjI44QZ73xlFT7tRWhCPjQQAULqcVIElt1hfPT0g2R+IcbtN6crHQ2fz86FNu/
 av6g==
X-Gm-Message-State: AOJu0YzoUz2fnZlTN/ZIYTqC6msgr09VdCmIeHJaKbEtTrvCJf+SpKgY
 9AtJaYdu7RTvzsWBc45pBnegKDoO15XyZ0uWkntK++3RHg0tlJYoiYFFJGGSEB3hCmkbOX7Sil3
 N70B4x3on8y/013Nf4Q0eCgUY8vVqAY+8+U+CHRuYwim8rHJrJX17aYj3SrSz+CurrRBBhpF2fX
 otuIJJiPfz7Lknb3MVJqIT8SqOt5EhV+EeuyPwmzwh5g==
X-Gm-Gg: ASbGncv44tVzT93Skw+THub/NSpX8DUWwAe2r5GnUIQhBOn4qxNQcmUHnJtt+Y+r5wi
 SHaSt6NrQrHPKPPe7ZSNCLi39i3K0+9IozlwroXrtrc6rffJSyhSv5oE37Xoe25YsLsNLO8fdEA
 r5uu+MbLFLVoUGjA14tsWDXZ5V5YbWxlxc/ySIZtikp95smimRa/3mKOQ4r0HvipBuRzWZha7/Q
 Ty8vcrFMecNTiw2Nabg4fcJ7aUkKi4ij1OoVa5tuwBU149A6Gn55kHOeVmxsqckLIgFNzDV39v7
 8MHCFcERcShqeESFr9gIBR9QrKb7wAC8dHe/j7qU3nTNnA==
X-Google-Smtp-Source: AGHT+IFon/KRqEXx9zUKG3ffSrWw3wcDga3m5+1eOtEvhAiSiK++jGGkL5Vf1Wqvpags1k8e8hZXmg==
X-Received: by 2002:a05:6214:20a6:b0:6e4:3c52:d684 with SMTP id
 6a1803df08f44-6e66cce6bb7mr146057156d6.19.1739780262693; 
 Mon, 17 Feb 2025 00:17:42 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:17:42 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH 0/8] riscv: AIA: kernel-irqchip=off support
Date: Mon, 17 Feb 2025 16:17:20 +0800
Message-Id: <20250217081730.9000-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qk1-x729.google.com
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

This series introduces the user-space AIA MSI emulation when using KVM
acceleration.

After this series, RISC-V QEMU virt machine with KVM acceleration has
3 parameters to control the type of irqchip and its emulation method:
- Machine prop "aia" controls the type of irqchip
  - none: use PLIC and emulated in user-space
  - aplic: use AIA wired and emulated in user-space
  - aplic-imsic: use AIA MSI, emulation mode is determined by
    "kernel-irqchip" and "riscv-imsic"
- Accel prop "kernel-irqchip", effective with AIA MSI
  - on: in-kernel APLIC and in-kernel IMSIC
  - off: user-space APLIC and user-space IMSIC
  - split: user-space APLIC and in-kernel IMSIC
- Accel prop "kernel-irqchip", effective with in-kernel IMSIC
  - emul: use MRIF as in-kernel IMSIC
  - hw: use hardware guest IMSIC file as in-kernel IMSIC
  - auto: use the hardware guest IMSICs whenever available otherwise
    fallback to MRIF

Yong-Xuan Wang (8):
  target/riscv/kvm: rewrite get/set for KVM_REG_RISCV_CSR
  target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
  target/riscv/kvm: add KVM_REG_RISCV_CSR_SMSTATEEN
  target/riscv: add helper to get CSR name
  target/riscv/kvm: rewrite kvm_riscv_handle_csr
  target/riscv/kvm: add CSR_SIREG and CSR_STOPEI emulation
  target/riscv/kvm: rename riscv-aia to riscv-imsic
  docs: update the description about RISC-V AIA

 docs/specs/riscv-aia.rst   |  24 +++-
 docs/system/riscv/virt.rst |  10 +-
 target/riscv/cpu.h         |   8 +-
 target/riscv/csr.c         |  30 ++--
 target/riscv/kvm/kvm-cpu.c | 287 +++++++++++++++++++++++++++++--------
 5 files changed, 266 insertions(+), 93 deletions(-)

-- 
2.17.1


