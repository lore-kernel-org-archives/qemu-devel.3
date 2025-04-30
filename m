Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409F1C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tl-00028z-3u; Wed, 30 Apr 2025 10:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8ti-00027J-Sm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tg-0002dq-VY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:54 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-aee773df955so1030644a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025131; x=1746629931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2+JbLMiiUYaemZWDCUtTt3O9Oj1MSI0kp/U5wwWhSE=;
 b=i6z+mE+Q11rzyoVogFPoNK5MbOkDNPGfz09NvIlUcCH/wHBquWuGC7iQAmHpq0oDga
 F4aJ1yOzYG4gmMU6y2pWcpPr6YHfsKvj5hV80DWNhtiCYQNb5hGRvwZke2MsbCpucD7W
 WQFyaTq1jBvJOi2Y2XO9RD+vw84gfj5V4bTZ8ujIdh/jFP3fAndyG5mnvvdTYxMpsROB
 N1BB52b0a16HlRjRL2WJz3s9B+dPnNnLGbr3mybfGbDR5lxoUzOsfDun5Xox+tyiuQXa
 VItcEE0kG8gg0o/gk37mfKH+ikPLm9LE4kxrqHIoThcRJRFmQw7yewi3G/EvCxCOASQI
 UqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025131; x=1746629931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2+JbLMiiUYaemZWDCUtTt3O9Oj1MSI0kp/U5wwWhSE=;
 b=F4kxjlnHEIXxXqEjqZwPiz7UrMafUlLAVfUUzMWUW6yILP7+SVA2hVTB5f1y0ydn2/
 A+A1/uVdlokq2GNrdbc7S/5wWpyAOoEqaAZAEUaYCMlB3GUp4jscfvh2UJiwPUfCYR+Q
 2FY91DXsA03XpjGlQ/7FNAVEJSZUn/rsDy440guYGTZPx5nXUSeTA77UQv7m2w/wyeqR
 9C2N0KzeBaO9FOPWy6hgd9iZwdUoiy9FmidNoBn8feFEN/RR6eMeUc5Xquj6g+obeTJl
 s4PUxjwVqtwh+se2I4XgBOmWK1F919SD+4orfy/cbvsjZX2YeJtcDj0UpW4lbX4pXo65
 EpRg==
X-Gm-Message-State: AOJu0YxKW1QZql7vXFyzU088SvntLkRgYXzx9rVmwy0wtJLUlH1U83uP
 8x76K3dK/puqsSJkN2V5j27Ou53CLjWm3ZPrwYY1Xqa92ajEocasbFRAnskbOL+oYNLgc+MLTkO
 M
X-Gm-Gg: ASbGncub57uGsFdo4yiY+jeFSGhqX+0GXt2E8GwytHAfv4S9rO7R5DZoNv+dQd2qYy8
 vqrINyel3ZmdyVL1PvbcISDqHYRzReOVIF6YZtdTGjKxYiyzPfCnWR6Tpv01jfyrk0Gol2lrLWE
 hHT2pBkztUG/8gAQQ0Eb/NpASdm+OVkN/TGYVxOgtDRIbqHLgQUfZfwNRDRFyKiENWRj/qUUrHR
 jKUNT0LxBAQoDm0tGzW2ANpF7ufXLUsAjpSQaOXGmf4zeCxQCb2b6J109w21JoLy3MhI3XUWyve
 rEMukILFjpUNgWdXBS0blEvEqFEsdOPJRGfu4DdP
X-Google-Smtp-Source: AGHT+IGVJzpOY1sOKyELald78Uh/X55cVaOwtQ3xJcxUF7oIJGgGU4BQTL1AHVt8pNiGxX22IiuDXQ==
X-Received: by 2002:a17:903:2ecb:b0:215:9eac:1857 with SMTP id
 d9443c01a7336-22df4747f3emr44018045ad.5.1746025130724; 
 Wed, 30 Apr 2025 07:58:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/12] single-binary: compile target/arm twice
Date: Wed, 30 Apr 2025 07:58:25 -0700
Message-ID: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

v2
--

- Remove duplication of kvm struct and constant (Alex)
- Use target_big_endian() (Anton)

Philippe Mathieu-Daudé (1):
  target/arm: Replace target_ulong -> uint64_t for HWBreakpoint

Pierrick Bouvier (11):
  include/system/hvf: missing vaddr include
  meson: add common libs for target and target_system
  target/arm: move kvm stubs and remove CONFIG_KVM from kvm_arm.h
  target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
  target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
  accel/hvf: add hvf_enabled() for common code
  target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
  target/arm/cpu: remove TARGET_AARCH64 around aarch64_cpu_dump_state
    common
  target/arm/cpu: remove TARGET_AARCH64 in arm_cpu_finalize_features
  target/arm/cpu: compile file twice (user, system) only
  target/arm/cpu32-stubs.c: compile file twice (user, system)

 meson.build              | 78 +++++++++++++++++++++++++++--------
 include/system/hvf.h     | 15 ++++---
 target/arm/internals.h   |  6 +--
 target/arm/kvm_arm.h     | 83 +-------------------------------------
 accel/hvf/hvf-stub.c     |  3 ++
 target/arm/cpu.c         | 47 +---------------------
 target/arm/cpu32-stubs.c | 24 +++++++++++
 target/arm/hyp_gdbstub.c |  6 +--
 target/arm/kvm-stub.c    | 87 ++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c         | 29 ++++++++++++++
 accel/hvf/meson.build    |  1 +
 target/arm/meson.build   | 15 +++++--
 12 files changed, 237 insertions(+), 157 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c
 create mode 100644 target/arm/cpu32-stubs.c

-- 
2.47.2


