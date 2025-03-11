Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9138C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvQy-0005vo-MN; Tue, 11 Mar 2025 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvQt-0005vL-B0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:57:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvQr-0001Ft-AU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:57:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso25448165e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683467; x=1742288267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h6alyYtdLKDsUflUeX8mht8DVdorJ/ZaZDzmwZTDERA=;
 b=QemytMrDT+GNOQcEkw57rBgvT/ZYjbfPHBYYYJJTIxN9ESOwnBjhrQl8O8iJ7nhu2N
 T5x0oaE5JQXQt/2TTjbpHqIwXfkBV0DX1tY0Z4UCVYlnu/ZEFCPlkCjXYVFThIVNuDQm
 V4Nz/BOixenYbTaE2+Cx4mrWNp73oZ2eA01gn8ZU86YD8ZcBdJrDUf+uXwfowwGUYwuA
 yvMujcOqTI2K9IZiQmATqa0JRzfsbyHcl3FAvGH8EgwwV6lCKNpJ9qGt3NFgt7nGu2C/
 1VHPTjHoevRwUE/o0YF0/XP4BeIKjWmE3GHkFe5AjXtJwjoUpTFHoWKQQi3UKvBCD856
 LUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683467; x=1742288267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6alyYtdLKDsUflUeX8mht8DVdorJ/ZaZDzmwZTDERA=;
 b=cC0GCbV9bOJ2RG+7QukN1A713zdnqzBz57fNTpUQeAdQpXdUDHsevIW4MbtOaoRwLX
 tW/OurcNCZmSeuoatkMxSZyLm9szKSKOA1/C9Wx9JOnRdnq5RaR2ofkXkVp2t/PNqkUa
 FaqiO0Vky6OsEEnePaBiMenfJkO5h9JPjb+FquvnWJIx2AODKAK7uPTbBSFL49vY00G1
 Ccqplo9bRuk+Iv6SoB7ok6IyCuGpt5igyChgBvcIEE9ANVU5hfSFLzik34+HS/BYPG6G
 xCgg6mP4D5cCXjHkQwKeF0w8wWooGdWQQQqiTQegYeEZkTIYefTBJW0lJrlucBJEgZmF
 r7nw==
X-Gm-Message-State: AOJu0YygPsoitJ2qucuMfDm04onBcK0Hq4XeqDInQMQTuTWZ02Ifr6yS
 nnhpkbyHs3YKbdkV+occHfrIn6agmVlteXb9JzvESduWHrnn/7RO/pt6vuWahRz/8ymc8TYXyHw
 O2mM=
X-Gm-Gg: ASbGnct/Qav7FRpClxLSuKDsOehPVsAreu8TpqdmUmYFywZ7G4P+SoO+P4s6k0LKyKv
 NifbrpeckM5vqgbKTqc2LGyBx9N9kq5o+yxQZdL+GRJhvezgyVdOCsB5ibPaBopJP4FtKKnb4Qc
 JSzRp4ZBztvA2LPVbdhbLmxQTzfsqoIwJAL4OSQWzRwZ3aWnyfEs9ybirEMiQCZmwcM3+jFfit4
 gIQAf9u3WCuH3EOKAP+58zRNwgqlK1rZCB1PbexANgQDdfp7+YiQl3Rse7djvI/iG1EvpaI671J
 ukapAOjs2Z/X71AMkY4e0hqVQRt8urqSsGDde7VksZ8oqw5QbdaVn0S0oOXP8NUDRtwGv1DxYky
 7sqIjaRhp85HHssuSBv8=
X-Google-Smtp-Source: AGHT+IH2bhfUFWK9PIFiRJ2qTB3e1C/DifObbFrGDPwTmIjjKwP+CXeTFa/kO/pCKYqX6JCOb7O1vw==
X-Received: by 2002:a05:6000:1448:b0:391:487f:280b with SMTP id
 ffacd0b85a97d-391487f29camr7394086f8f.10.1741683466594; 
 Tue, 11 Mar 2025 01:57:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf3bf0e48sm74752635e9.20.2025.03.11.01.57.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:57:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-10.0 v3 0/8] hw/vfio: Build various objects once
Date: Tue, 11 Mar 2025 09:57:35 +0100
Message-ID: <20250311085743.21724-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Cédric,

Here are the VFIO cleanup patches ready enough for 10.0,
with Richard and Eric comments from v2 addressed.

I'd prefer the rest (of v2) to wait for 10.1.

Thanks,

Phil.

Philippe Mathieu-Daudé (8):
  system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
  hw/vfio/spapr: Do not include <linux/kvm.h>
  hw/vfio/common: Include missing 'system/tcg.h' header
  hw/vfio/common: Get target page size using runtime helpers
  hw/vfio: Compile some common objects once
  hw/vfio: Compile more objects once
  hw/vfio: Compile iommufd.c once
  hw/vfio: Compile display.c once

 include/exec/ram_addr.h    |  3 ---
 include/system/hostmem.h   |  3 +++
 hw/ppc/spapr_caps.c        |  1 +
 hw/s390x/s390-virtio-ccw.c |  1 +
 hw/vfio/common.c           |  9 ++++++---
 hw/vfio/iommufd.c          |  1 -
 hw/vfio/migration.c        |  1 -
 hw/vfio/spapr.c            |  4 +---
 hw/vfio/meson.build        | 27 ++++++++++++++++-----------
 9 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.47.1


