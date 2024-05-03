Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03288C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2U-0001gB-Ta; Fri, 03 May 2024 05:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2O-0001fK-Ho
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2M-0003U6-Ny
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso47912495e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727820; x=1715332620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yl6x5TNVIiFHXaloR61Gq9ATfnGpsXhp0BH5/fRaU48=;
 b=ySw+uFL/SFgH3WL1/+/frh5YKBL3v0+EDAcsoLUAK0ilWUCXBq5RCseZyZ+tMGfhVl
 uTFV9jl+COZSG964DwT6XPyrVW1VLvuCsan8W+MwHfjccGSQ1nVH8HEwad9Kc8n/MYyj
 zYyTAceXLZs3kSnJGk32A9jpIQpcRqllMpOqMsdUFVGJTsFvj19cm0KGUWHokMFLpcw2
 i5PkEnmJs+4/rXOSGOjkbH74IFCjjLL0f/Wz68hMXEYt++KxPJPGZ/dM1Pk73i+3cQu8
 JkbwKTfiOsrG0yxeWPCJxU4lZTXJgonJ+Q0gZigYnT1LNjqEEZHFzZvirKRNThU3Kp8p
 IP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727820; x=1715332620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yl6x5TNVIiFHXaloR61Gq9ATfnGpsXhp0BH5/fRaU48=;
 b=mDtPcCwRJ3lsfb6/JdBSX0NIcA+9gNXgvG8EAEJgT5tvLs1IMkjJ7992/PY/XHDVrt
 iD7HJan5yj7Jsh0qevIWS9QF8NF8uQ2V1hUp9BOTihSwWRNxL+DH6KxP1CxCKgnd225n
 IZb/zcmFCe/QkKFiK5ix40bNntEUi3vtm5fIoocrVAWS0oyza6aZKP5oESXrOPcf9L1K
 CFx21mNrScDH4v2x7JjcNNuvVnVmIqFwWWPUz7F49jbPf1afgGnfBDbKrszc5ajMtyYM
 +nzOUkvtg2b7vSg/KjKYIVByfsrw8bmL40QcCwVw/+/rrmnVQeqWIr3F1V0t6f50I4SP
 IJIA==
X-Gm-Message-State: AOJu0YwOwFtd3VqVvJ16TJjbc9WfS6jMtUyPdsh0ifYZeKLSP1XEjRCu
 pQ6krD2CyZJQj/E/q6eu2TqUaRYHn+d9rniS+5QAtkfyQR8qzwcjN2UQM2b3qxP8YIQu/8q/I+B
 G
X-Google-Smtp-Source: AGHT+IF6yrS4uyctsYumygqTLo5QaMeaIj/iHhxAEpk9D2shkIEw63bHsft5h7X7z7WxZSGGfGh8iw==
X-Received: by 2002:a05:600c:3b8c:b0:41c:13f6:206a with SMTP id
 n12-20020a05600c3b8c00b0041c13f6206amr1873965wms.7.1714727820376; 
 Fri, 03 May 2024 02:17:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c0a0500b0041bd85cd3f2sm4911131wmp.19.2024.05.03.02.16.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:16:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] accel/tcg: Call tcg_flush_jmp_cache() again when creating
 user-mode cpu
Date: Fri,  3 May 2024 11:16:52 +0200
Message-ID: <20240503091657.26468-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Fix a bug introduced during a refactor in commit bb6cf6f016
("accel/tcg: Factor tcg_cpu_reset_hold() out"), affecting
user emulation. (cpu_reset is called during thread creation,
after cpu_realize).

This issue was noticed by Ilya when running WASM:
https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/

Philippe Mathieu-Daudé (5):
  accel/tcg: Simplify meson.build using subdir_done()
  accel/tcg: Move system emulation files under sysemu/ subdirectory
  accel/tcg: Do not define cpu_exec_reset_hold() as stub
  accel/tcg: Introduce common tcg_exec_cpu_reset_hold() method
  accel/tcg: Always call tcg_flush_jmp_cache() on reset

 accel/tcg/internal-common.h                   |  2 ++
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
 accel/tcg/cpu-exec.c                          |  6 ++++
 accel/tcg/{ => sysemu}/icount-common.c        |  0
 accel/tcg/{ => sysemu}/monitor.c              |  4 +--
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  5 ++--
 accel/tcg/translate-all.c                     |  5 ----
 accel/tcg/user-exec-stub.c                    |  4 ---
 accel/tcg/user-exec.c                         |  5 ++++
 accel/tcg/meson.build                         | 30 +++++++------------
 accel/tcg/sysemu/meson.build                  | 11 +++++++
 17 files changed, 39 insertions(+), 33 deletions(-)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
 rename accel/tcg/{ => sysemu}/icount-common.c (100%)
 rename accel/tcg/{ => sysemu}/monitor.c (99%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (99%)
 create mode 100644 accel/tcg/sysemu/meson.build

-- 
2.41.0


