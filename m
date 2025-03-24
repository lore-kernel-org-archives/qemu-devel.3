Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747F7C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0Z-0000sR-EN; Mon, 24 Mar 2025 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0W-0000ro-Sg
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0U-0001M0-J6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso33452325e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842720; x=1743447520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a0AwkWHNDJlaUEffINspb+B6dvAVGc13coRiJeXLgEg=;
 b=MlpMJH35BKovBqQkQ7uMkUuWLwIQbzqTYKwS7joE7acgLpNzc19PnRigQkiyjXhuLK
 cDNEt4JpXjRJ9edCI3AJRZpGriCUvjW83K9tdBc+V+zYTUnFx69sJOwVlh/0B7AmPcOD
 YvkUD8rXPWko/ax65NlmbUUP/HOQRDnoSGAUzrE/QkBf44pLCRFBL4MyTU58u2NIqQ/w
 z2z893gXTydAPe3rsOW8vEGuA1p1+S6tuRnlFQGPLv4Xmf7vYON4TB3SOtnCZrTwstCs
 CsA8JGDgsSp+WoDpjBtz5Z2+BBjEjFbg+objrIRz/oKNAguWBRskUy/a7O6qm8S9l2Ru
 2aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842720; x=1743447520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0AwkWHNDJlaUEffINspb+B6dvAVGc13coRiJeXLgEg=;
 b=qY2orXTNwyyVZPyLofeq6PtfGft569U9EHy0DZiR6OuCbJ9n4Jc/H894GPNro22ZUO
 gTM1sxlLp2cXm7/kn80g8NjMeJOee6rwxm6Fth8/ytHzsPjbcoxyVmWlKbj1NxUr70ow
 6LJllIX2wQktGepxslu3UetN02QnKRA/IuaNxToVZDDQJ3CqrmyOY8u/aPIv6HGog1p5
 6vdk7uthy9CC9OkEM9iq24A1juoy3snSMMU0t09hdHzOdtjJn5dz9ovb7yP4gmW42vte
 svCM6SN91m8oUxLAs0h+MlJGlvHRK1nsaA3DO67E5TuwPZyRD+kaGTtTV6ny6Mvv8nsV
 zb+w==
X-Gm-Message-State: AOJu0YzxHc1XJMtGxBslD9c9NuIE1IXNR2E+ZYzgXYBaHmo2BL00M5oB
 ByecGGneZDOAeJikMV7DiwHwl9itfTpkKy+VEqchKaXVa+lS6q4xmBTx4SBT4hYBTTdD9YcLl4v
 H
X-Gm-Gg: ASbGncuUd0vX0X44LFEV/wKpubJKZtFdtIs8YYMsS8/lUh2qbKS9K/UcSUwJ1Bzq1Rw
 cNjUe54dxsipekRLoexwG22E7Gw4bdU7scQuDFpUaHg8Ve4lq1IYoLr8IAklIbyRNxNqdPeSS21
 yfYjALMAAdAloAlWg9SjV+CSZ59bSnlNpaM0GDhNnvr9i5b1NPunZju6plof9mOqdqvmtHtDLyN
 BgUSy1nuziKesTOJILK6GpSTuZQ5LYV+Fl5YU7Z8f5QbuUPVDv+MEyIARiZxP9DsQMNAp3XJXjv
 mG8HTEGW+bs+LbIQ45f9aG8xcAhX/9iWc/XJ8PLd7MhyMXm5lEDcdwln4CDvrtiFTGIj04i7hgI
 Su1Id8zjGfLmNmrahBNtcaqhu
X-Google-Smtp-Source: AGHT+IEchKmevO9CborAblfcQXE7+yItWpXu3QAxqQnAZ1+XcGUC7UuzAa6k8O+eoTJEsfSMy9wGYQ==
X-Received: by 2002:a05:600c:1548:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43d509f4d23mr133217015e9.13.1742842720265; 
 Mon, 24 Mar 2025 11:58:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c3dsm180035005e9.23.2025.03.24.11.58.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:58:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
Date: Mon, 24 Mar 2025 19:58:30 +0100
Message-ID: <20250324185837.46506-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since v2
- Added R-b tags
- Added missing s390x hunk

Since v1 (Thomas review comments)
- Move s390_set_qemu_cpu_model/s390_cpu_list to "cpu_models.h"
- Correct 'target/s390x: Register CPUClass:list_cpus' subject

'cpu_list' might be defined per target, and force code to be
built per-target. We can avoid that by introducing a CPUClass
callback.

This series combined with another which converts CPU_RESOLVING_TYPE
to a runtime helper, allows to move most of cpu-target to common.

Based-on: <20250324165356.39540-1-philmd@linaro.org>

Philippe Mathieu-Daudé (7):
  cpus: Introduce CPUClass::list_cpus() callback
  target/i386: Register CPUClass:list_cpus
  target/ppc: Register CPUClass:list_cpus
  target/sparc: Register CPUClass:list_cpus
  target/s390x: Declare s390_set_qemu_cpu_model/cpu_list in cpu_models.h
  target/s390x: Register CPUClass:list_cpus
  cpus: Remove #ifdef check on cpu_list definition

 include/hw/core/cpu.h      |  2 ++
 target/i386/cpu.h          |  3 ---
 target/ppc/cpu.h           |  4 ----
 target/s390x/cpu.h         |  7 -------
 target/s390x/cpu_models.h  |  3 +++
 target/sparc/cpu.h         |  3 ---
 cpu-target.c               | 25 ++++++++++++-------------
 hw/s390x/s390-virtio-ccw.c |  2 +-
 target/i386/cpu.c          |  3 ++-
 target/ppc/cpu_init.c      |  3 ++-
 target/s390x/cpu.c         |  1 +
 target/sparc/cpu.c         |  3 ++-
 12 files changed, 25 insertions(+), 34 deletions(-)

-- 
2.47.1


