Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52B5E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtJd-0002W6-82; Mon, 06 Jan 2025 15:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJb-0002Va-Bf
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJZ-000395-FC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso106046805e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193783; x=1736798583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVQDyU0aZGqnbGo58WYklNw0MeL8aFrKkG5Vri/XHzI=;
 b=kUQtZ8mmiPkdHTlMB9xdpp65ITppnr/j+WZjxIM5eLAr0oncSaXmdo7H30QnAtUOzx
 gG//LNx4FJRJ2X2uEYupahCpsyBxYVArR4GG6WMPmup6JnyxgiCd795I4AKMqOq1Tl2r
 iSUeJNzRLhot8RuggB37lPQBdBW9oIJkCZauQTSg8h+vwddIdlR/VBbLQ7POM7qb9H2G
 c+70FtlruxCFmA3UOh+yaugrBrm5oKGBHalcZt1DeYn8qKX1u2Gh1B3KCSmnA84MTaPh
 5bLHcCYp6zvcAo9MwLtXgKMdhSj+ZaaNmXJHxHQLC0xA/OHUsvzM5m4pB0S6jaXk8XA1
 aOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193783; x=1736798583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVQDyU0aZGqnbGo58WYklNw0MeL8aFrKkG5Vri/XHzI=;
 b=s3HFWStX/WdlVW4wucaSAVhtC29EczENzma80PqrYRgzuWucWJGUy8YkO5DDoptG58
 dDabavnZh/1ofO8LcCZjFm97a7xobz7BigT9wCUqo3d838xNzc4vidyYJcyO9gpTyJDO
 WXUMXSBIbFszt5msom4uqeWad87rtj/ouWNDS4CbKLrTlBDNKRK8vzn14Mi8DiX4ec1K
 HKo9deDe8Ym3bttkNoHeGIIkXg1F97yVdzUK/EDC6UXCLTAQ5x6e8KoGbtpp6KJg7ipR
 5nX7X1B22KwTC/xViBTvEZFVPDSPTd2CIZqSK6bFXCBz2PEqjt8RVCGX6pembKnSTVP+
 jKSA==
X-Gm-Message-State: AOJu0YwnjQZcOL0i7fQVcbZnRQT62lYjSndcJQP/qNtsos+wmqr+JpdK
 MuyOP09HteaIbCx+IdMJECIYt+tryIndyR4eqKux3fD91boB1O+FToTm1aPe5TkaGc0Q46FBZd0
 8zZM=
X-Gm-Gg: ASbGnct5nkTaiiPpChdbWDYBDTGgYLxSx9IB+O1Ar9BfJorZH+ewpPN9qHip5FF4ov/
 x3vsg7EKGGlQALMHskaeeNjfuhu3+3qbgWruRc4V4Eb6q0eVIb1etj8fz8i1fyhwDkhECGLhcr6
 hCcw5bg/6dUUIi+ufAH7QdpJQwkAUjd41H2QXcWtLgukTNuNhyBKCg0RnhgogUplqifPvPthqqs
 KF/bdGctpMwJ4o/KaTYMWaX1ORhF/wLN6uXECMiBTNXt9SqedZnAuVhJyfM7uC+G6uJGpAAgKSY
 edFHepgQb1GzFU7Cu/pwF1SqrqjAkAg=
X-Google-Smtp-Source: AGHT+IEvY1dOIYQWFga9MrJsSFG0JoKzIh1x57mMzgTfD/hBdAZ0c+WqLtNl81G5solsww92cOjYAA==
X-Received: by 2002:a05:600c:450f:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-436686461cbmr539399575e9.17.1736193783280; 
 Mon, 06 Jan 2025 12:03:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b2a4sm611962245e9.27.2025.01.06.12.02.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 0/7] accel: Add per-accelerator vCPUs queue
Date: Mon,  6 Jan 2025 21:02:51 +0100
Message-ID: <20250106200258.37008-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

Currently we register all vCPUs to the global 'cpus_queue' queue,
however we can not discriminate per accelerator or per target
architecture (which might happen in a soon future).

This series tries to add an accelerator discriminator, so
accelerator specific code can iterate on its own vCPUs. This
is required to run a pair of HW + SW accelerators like the
(HVF, TCG) or (KVM, TCG) combinations. Otherwise, i.e. the
HVF core code could iterate on TCG vCPUs...
To keep it simple and not refactor heavily the code base,
we introduce the CPU_FOREACH_TCG/HVF/KVM() macros, only
defined for each accelerator.

This is just a RFC to get some thoughts whether this is
heading in the correct direction or not ;)

Regards,

Phil.

Philippe Mathieu-Daudé (7):
  cpus: Restrict CPU_FOREACH_SAFE() to user emulation
  cpus: Introduce AccelOpsClass::get_cpus_queue()
  accel/tcg: Implement tcg_get_cpus_queue()
  accel/tcg: Use CPU_FOREACH_TCG()
  accel/hw: Implement hw_accel_get_cpus_queue()
  accel/hvf: Use CPU_FOREACH_HVF()
  accel/kvm: Use CPU_FOREACH_KVM()

 accel/tcg/tcg-accel-ops.h         | 10 ++++++++++
 include/hw/core/cpu.h             | 11 +++++++++++
 include/system/accel-ops.h        |  6 ++++++
 include/system/hvf_int.h          |  4 ++++
 include/system/hw_accel.h         |  9 +++++++++
 include/system/kvm_int.h          |  3 +++
 accel/accel-system.c              |  8 ++++++++
 accel/hvf/hvf-accel-ops.c         |  9 +++++----
 accel/kvm/kvm-accel-ops.c         |  1 +
 accel/kvm/kvm-all.c               | 14 +++++++-------
 accel/tcg/cputlb.c                |  7 ++++---
 accel/tcg/monitor.c               |  3 ++-
 accel/tcg/tb-maint.c              |  7 ++++---
 accel/tcg/tcg-accel-ops-rr.c      | 10 +++++-----
 accel/tcg/tcg-accel-ops.c         | 16 ++++++++++++----
 accel/tcg/user-exec-stub.c        |  5 +++++
 accel/xen/xen-all.c               |  1 +
 cpu-common.c                      | 10 ++++++++++
 hw/i386/kvm/clock.c               |  3 ++-
 hw/intc/spapr_xive_kvm.c          |  5 +++--
 hw/intc/xics_kvm.c                |  5 +++--
 system/cpus.c                     |  5 +++++
 target/arm/hvf/hvf.c              |  4 ++--
 target/i386/kvm/kvm.c             |  4 ++--
 target/i386/kvm/xen-emu.c         |  2 +-
 target/i386/nvmm/nvmm-accel-ops.c |  1 +
 target/i386/whpx/whpx-accel-ops.c |  1 +
 target/s390x/kvm/kvm.c            |  2 +-
 target/s390x/kvm/stsi-topology.c  |  3 ++-
 29 files changed, 130 insertions(+), 39 deletions(-)

-- 
2.47.1


