Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7FFC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d59-0007lA-HZ; Tue, 29 Apr 2025 01:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4v-0007UX-87
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:23 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4s-0005yG-K0
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af50f56b862so3805637a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902816; x=1746507616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E7e6flwrW0Xr7srdLRTYqMhF0r9DLRZRxyW/leVX1gE=;
 b=iXg0ppm5WGp+tF+ixLxEYz2yX44EFR6mQOoblqNJ6UIzHzkTff288+R4IRjW/lrJN+
 +dA0GS0vjPylcKn1D/9rqf43eCHAtvAQT/yiaXalqFUpxUmw2pWqWPOyr4SFlb7nlmjG
 I9k3XZTvyH/WLRM715E/gsuhZWJ6mFATg1EKPoSGEqi7IHZ/plblilmQCM2Xdv6EP6/t
 cnkUqL7Am7Bwuf4iJYaa9mXiaE5BVu72OwwL+HvmGyCCBtt23j2Aiy7fE/sO7PD7hS9U
 PkWBdwtt5blTuXf1N608woOrIYjyq8Kc7u9ppV5yXDDNWkDFkCv3QMbSdPQ0WI/vnjzA
 vN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902816; x=1746507616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7e6flwrW0Xr7srdLRTYqMhF0r9DLRZRxyW/leVX1gE=;
 b=qYIYRisPH/8GTNLrl84oeUkkTM793xznLjRh3fBKRYjo77H7D8m7WEYwHbnlilgeH0
 xKxbkjxqsV+04CtTgyQrt1bLDgnA3ZB1iSRULvCv911Sa94iWQHBiAiJaN+kL4rhCl2F
 /S7BKP1ZCdsSKRS8fgU/H4ovYjhJUIlR+j0r3FLSn0lLINxDCqxlwoWV4tA/vEoGPN9i
 fsF0C0d5a46b0v1QUgoCXrPG/8aFGeWcb/oKLI9W6XW+v3meGznFg1Pa9AWPQn6LZKZ8
 SDAv+ufs+5gKDihskm3b52PXqeOjWshFGM7cAM2qdK3Oj/o0qMZwYWXA0PDtkSMx3NBf
 Ahbw==
X-Gm-Message-State: AOJu0Yz+cNx2piTEVHDR8NhPZqSX2VBKidQHPPwJ8yqPOv4Eg0cUJxUH
 psodePZUymSacbtwk3xeKDQKKeZc7zvOwNJGsmBZgV5KtSbrug2opfzkWXXY6g6i97ndPtefR8K
 1
X-Gm-Gg: ASbGncsld3pGXu6V54Y4N5eRzpSVs4LZSVJkxlHb8gWKTH3ye0PBFqiQaU+ncoOWcC4
 I3LvHeZmaav3b85nqXChSNihxym5rqbZP4BzJRjZ+YVz4qtoCLU8qDA8QbEyDB5zuDqCO+YSAqS
 kRUvrm82n5Pykl8zc9JQZ117M/ko8rWVbAmTZkoeoQWoF9Hziz6aDSjpNBLT2viF5uWPKm2u78H
 sUcLumq1AsmF3j40AHl8ngKHebPZQw3qijYbkJKuJwaI3oqOwtLhdsSl0/ZcYFxi/vDRGDDVZcE
 iW1gyHFlzhQZBGMoO2P3i2YRnDDpNOxyp4k/2fgP
X-Google-Smtp-Source: AGHT+IGtTYums0vJIYUAxvrHOiwYyUcioYLnqAFsCGQIOBOAUh+3sHRwCcQhNBYfSH9HQfYcsvlOJQ==
X-Received: by 2002:a17:903:2ec8:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22dc69ffb69mr175276195ad.15.1745902816496; 
 Mon, 28 Apr 2025 22:00:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/13] single-binary: compile target/arm twice
Date: Mon, 28 Apr 2025 21:59:57 -0700
Message-ID: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

More work toward single-binary.
This series convert target/arm/cpu.c.

Built on {linux, windows, macos} x {x86_64, aarch64}
Fully tested on linux-x86_64
https://github.com/pbo-linaro/qemu/actions/runs/14722101993

Philippe Mathieu-Daudé (1):
  target/arm: Replace target_ulong -> uint64_t for HWBreakpoint

Pierrick Bouvier (12):
  include/system/hvf: missing vaddr include
  meson: add common libs for target and target_system
  target/arm: move kvm stubs and remove CONFIG_KVM from kvm_arm.h
  target/arm/kvm_arm: copy definitions from kvm headers
  target/arm/kvm-stub: add missing stubs
  target/arm/cpu: remove CONFIG_KVM from arm_cpu_kvm_set_irq
  accel/hvf: add hvf_enabled() for common code
  target/arm/cpu: get endianness from cpu state
  target/arm/cpu: remove TARGET_AARCH64 around aarch64_cpu_dump_state
    common
  target/arm/cpu: remove TARGET_AARCH64 in arm_cpu_finalize_features
  target/arm/cpu: compile file twice (user, system) only
  target/arm/cpu32-stubs.c: compile file twice (user, system)

 meson.build              | 78 ++++++++++++++++++++++++-------
 include/system/hvf.h     | 15 ++++--
 target/arm/internals.h   |  6 +--
 target/arm/kvm_arm.h     | 99 +++++++---------------------------------
 accel/hvf/hvf-stub.c     |  3 ++
 target/arm/cpu.c         | 37 +++++----------
 target/arm/cpu32-stubs.c | 24 ++++++++++
 target/arm/hyp_gdbstub.c |  6 +--
 target/arm/kvm-stub.c    | 87 +++++++++++++++++++++++++++++++++++
 accel/hvf/meson.build    |  1 +
 target/arm/meson.build   | 15 ++++--
 11 files changed, 233 insertions(+), 138 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c
 create mode 100644 target/arm/cpu32-stubs.c

-- 
2.47.2


