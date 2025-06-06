Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD635C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBD-0004b1-Qy; Fri, 06 Jun 2025 12:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaB9-0004aj-2W
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaB7-00037I-C2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso19715765e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228263; x=1749833063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f99san66YFagTqIC7OqZvIusnhlUQQcbSXLoefUnFLY=;
 b=e17iw59N22eGMHAQgfcGry6f5F5SKK5ZDiFPhDCPlDce7KifPA7T/YFlPHSiP1Y3yu
 vOr64Ao3KsOgVJG471ns5OXQnb4zKqKfxrawuT/867h+hWYbXwfni+270Uahfn17BLaM
 uMEX1OGPqhGdZ63zQV0410H7mv4bBcZpSAMqqmVYgNUv7oy8LaDm3uwjyBhancxzlQP1
 YBLZigEDYmcsmnoFF75zitSLz/VsP62j7u8ovpkg5ZOmRYG5/NM2fJTVTkjAioZPlx/r
 BtpQm4xUEMIl4kGOSw0SuNwbHkQRNB+NzJSAD1u6YAoAwNbL4r5eWL1UnJy7WLgh+irD
 x3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228263; x=1749833063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f99san66YFagTqIC7OqZvIusnhlUQQcbSXLoefUnFLY=;
 b=Rn2L0xMTDrwooaqcxAzuE0Fn3w8HRw7QdA2rmnbY5YBF1BgFjz//UtgB94mxa1xT+O
 UgK2njs3z2l7je1ga6ok/k9ONlwxBorhjScEBVKuVEkWng/u+BVmgIi4gPBdYcfUvldL
 KJEI/vyGarkmSP2eeXqSQ2yqhUFV9cpDiu/cv5oEp0vAzCy5wsCuYm+VooZ3fLmiZ3NU
 SXs6QWIZcPUsvTYrxBrCUw3n05XnrnZTXWaGmsHYFFTJ0VlqFEFiQ2CYoSWbLa6zv3v2
 C3hAlvhW1AmD9bw2Sib3Xau6d3McCd0N6EMGpLi5yug0267SIQSB9q6KxRn7UQRFRKMW
 WJwQ==
X-Gm-Message-State: AOJu0YzLVeH9ogp31r5DgyA6zhPq8eDRWlQQNuwYEKf/ij0dnYW1e0sz
 ekpsUbrBFEK3glWiTOCxaB8/2aJlpEFwfaZFBD+eH+/DVgL7Nab/0D+j3TPBqc3IHOibL8ikteK
 7xSIn+oc=
X-Gm-Gg: ASbGnctg8pv463dhMSqF5YWhnG6F1g1ab0ota0RXwD9d4s3TudwRvGlaTCy8EabYbar
 ovhD0r/Vtc6i5kdUsMZLhwXxxQjiWsDJJA+UuH9z6m4aJ4y89LCzYuQENoowVXuYyO1G2xBge5O
 +nrebjk7GsqUuikrl1EoddeG8uV4Jw1AUAU2zIohmqMSVOU+h1bWKc4aNUXh8+FaKIA2UaCNBgr
 04BYAWTHiEg6NiH8VynVP9BcQlkWKbeljmt0ddL6b6gpsmZxdJ9qHYxh1ImSUUtkXG8PVIcaCv8
 ZGgVm0ucfeM5gmuc/ddbOXk7Ocg2HGFObTQVd7iwTEhKSZTCtwNehYjzW7in9p3NTxMgaFYIi1Q
 8k9calTF3XfwakU06TR2hMUvTAN+rL13YsMlK/Q==
X-Google-Smtp-Source: AGHT+IHqMk5BL9pnjMTJIx2sprGZAdK/9b/5D9lCFP4HnHsgUUjMkGMtfxfulEvxhiCYtLl5ySNsgA==
X-Received: by 2002:a05:600c:5253:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-4520138ec40mr47640335e9.9.1749228262928; 
 Fri, 06 Jun 2025 09:44:22 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137258bdsm30620735e9.27.2025.06.06.09.44.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 00/19] accel: Preparatory cleanups for split-accel
Date: Fri,  6 Jun 2025 18:43:59 +0200
Message-ID: <20250606164418.98655-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Few changes needed before being able to add the
split acceleration. Mostly adapting few prototypes
so callees have all necessary information.

Philippe Mathieu-Daudé (19):
  hw/arm/virt: Only require TCG || QTest to use virtualization extension
  system/cpus: Only kick running vCPUs
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/hvf: Fix TYPE_HVF_ACCEL instance size
  accel/hvf: Re-use QOM allocated state
  accel/tcg: Prefer local AccelState over global current_accel()
  accel: Factor accel_cpu_realize() out
  accel/dummy: Factor dummy_thread_precreate() out
  accel/dummy: Factor tcg_vcpu_thread_precreate() out
  accel: Factor accel_create_vcpu_thread() out
  accel: Introduce AccelOpsClass::cpu_thread_routine handler
  accel/dummy: Convert to AccelOpsClass::cpu_thread_routine
  accel/tcg: Convert to AccelOpsClass::cpu_thread_routine
  accel/hvf: Convert to AccelOpsClass::cpu_thread_routine
  accel/kvm: Convert to AccelOpsClass::cpu_thread_routine
  accel/nvmm: Convert to AccelOpsClass::cpu_thread_routine
  accel/whpx: Convert to AccelOpsClass::cpu_thread_routine

 accel/accel-internal.h            |  2 ++
 accel/tcg/tcg-accel-ops-mttcg.h   |  3 +-
 accel/tcg/tcg-accel-ops.h         |  1 +
 include/qemu/accel.h              |  8 ++++-
 include/system/accel-ops.h        |  5 +++-
 include/system/cpus.h             |  5 ++--
 include/system/hvf_int.h          |  1 +
 accel/accel-common.c              | 49 +++++++++++++++++++++++++++++--
 accel/accel-system.c              |  5 ++--
 accel/dummy-cpus.c                | 10 ++-----
 accel/hvf/hvf-accel-ops.c         | 25 +++-------------
 accel/kvm/kvm-accel-ops.c         | 12 +-------
 accel/kvm/kvm-all.c               |  6 ++--
 accel/qtest/qtest.c               |  5 ++--
 accel/tcg/tcg-accel-ops-mttcg.c   | 17 +----------
 accel/tcg/tcg-accel-ops-rr.c      |  3 +-
 accel/tcg/tcg-accel-ops.c         | 14 +++++++--
 accel/tcg/tcg-all.c               |  4 +--
 accel/xen/xen-all.c               |  3 +-
 bsd-user/main.c                   |  2 +-
 hw/arm/virt.c                     |  2 +-
 linux-user/main.c                 |  2 +-
 system/cpus.c                     |  9 ++++--
 target/i386/nvmm/nvmm-accel-ops.c | 12 +-------
 target/i386/nvmm/nvmm-all.c       |  2 +-
 target/i386/whpx/whpx-accel-ops.c | 12 +-------
 target/i386/whpx/whpx-all.c       |  2 +-
 27 files changed, 110 insertions(+), 111 deletions(-)

-- 
2.49.0


