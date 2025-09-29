Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A175CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F5r-0004ip-HG; Mon, 29 Sep 2025 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5i-0004eI-Ep
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:43:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5N-0001kA-6d
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:42:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so48655855e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156951; x=1759761751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hAzyKK2avmxJErsVwK5KjZxJGok1xSdKxfjGTCv72nQ=;
 b=tP6Z1wRV5alFbhh/Ok7wfOFir6CtMjcZ9t0QwdyqE7RC5wEBBkjEyrmDu8SJV9tmuL
 ilzbLeEZG/fBPuXwdxdxZBFEYiv9zltg/GvFhLr3zknW0JHF0Ftz/1rVMzREVm34DeSL
 kXR1T2c4CiQvVd8+jS+k5cSmo0CRqFI/goLto88il5ttv0+hQmpZZ3HDvAyEq3hZIG4F
 GlxFZQi1wwmr595ZVypKjIernL9Nd5FYEs4iuql9yBEdbtJZDC//9Tk3e3amf8JUcBdr
 AJQgtLRqse9hTuPsPBa3OyaSdGWS4vr4re0tjloKHwOzfOVkRQV9Ke+S+EKn3F8moNXm
 6ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156951; x=1759761751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hAzyKK2avmxJErsVwK5KjZxJGok1xSdKxfjGTCv72nQ=;
 b=vy8K3wUL1BGK6aiVonY87YNwsceSAE1Rfnha+Ep03ha/kZ3kalaid0kizGrh5Xwg6d
 AtUCapsBRz4fuuTierbmTVPTvPSAUxy3D4P6uQAG3RwgDl/lsDWcDC+tRwqaF/vp5Tgk
 WNVBE0RZRZytymMhRnKFhuCUbb23oBoPjoN3R/SgHuLIX2A3Iru5XNbrK0MjweTUwquP
 tlFxkw0j5c7pVoX5nlYHOY7euG5y+c+CH2Q91aA6dbnI8bH/OMSKkBx0csKhGLNOeCdV
 viZE0H10bKiTW6Bc+tG1qQ7oQQtgTLIkyYbhworOdbOja4bXWzfj796WFRQ37e7ym8+o
 X0hw==
X-Gm-Message-State: AOJu0YxQn4hOcrnTF9cic8L9gcF9ZQYDTCE6sh7d+aJgL8/DeRtH0YSd
 bHbXEw4p/6VALKeV4Yj9P+SD0Dyss70jV6cclL2mjIXc+XHy3KfOGW7F1nMl8UTg4TO1xXy8xWF
 kYkKx
X-Gm-Gg: ASbGncvhEIZD3SIPwxkJAEErOzjzBDdqKedF6lF00CcX5DB2AkJX2cvjJKKAEKZzljo
 zmup3e7KwTvdu9X4p1rGAJYm2a2phMCYRF8DCeRpurGIkKg2yZ2kaGlpsbISAl7qyc5y8MT4diX
 E2YW5ps20xTHDObcmsnv2nbNtWK5EiKj6abWABk1tzrK+s8OMeGo0l3Lr1l+OJB3gEtgR9R3vHI
 SoE/L1S1zViDIjVz89bx7vkxR/j/uOpaD151s/Q/3jGgL/1o3HZ0xT2mIX1SKTslC70u+KYyB+e
 GbMeYebGkYqn37Zb1f/KB4rcucTzxQP81XzUewUBZrKkt3J5SNBPFQU0fOYgbnHBPTIjPY3V0rz
 d+s6+xJFbRaSv61zc8ETh3UDOls+uLcaeGjHDqnY=
X-Google-Smtp-Source: AGHT+IEn9+EqLhqnXDgCbSR5/hiXJpJAcqtGfpglMlne8UfNbOwx7tEb+VcqcXOcBB1I7LGULvPM2A==
X-Received: by 2002:a05:600c:3145:b0:46c:d6ed:2311 with SMTP id
 5b1f17b1804b1-46e329f9d06mr136195605e9.19.1759156951104; 
 Mon, 29 Sep 2025 07:42:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64849sm15893885e9.11.2025.09.29.07.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:42:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/3] system: Don't leak CPU AddressSpaces
Date: Mon, 29 Sep 2025 15:42:25 +0100
Message-ID: <20250929144228.1994037-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

When a vCPU is created, it typically calls cpu_address_space_init()
one or more times to set up its address spaces. We don't currently
do anything to destroy these address spaces, which means that we
will leak them on a vcpu hot-plug -> hot-unplug cycle.

This patchset fixes the leak by replacing the current
cpu_address_space_destroy() (which has an awkward API, includes
a bug, and is never called from anywhere) with a new
cpu_destroy_address_spaces() which cleans up all the ASes a CPU
has and is called from generic unrealize code.

Patch 1 is just a comment improvement to clarify that
address_space_destroy() defers most of its work to RCU and you
can't free the memory for the AS struct itself until it's done.

Patch 2 is from Peter Xu; we need to be able to do "destroy and
free an AS" via RCU, and at the moment you can't do that.

Patch 3 is the bugfix proper.

thanks
-- PMM

Peter Maydell (2):
  include/system/memory.h: Clarify address_space_destroy() behaviour
  physmem: Destroy all CPU AddressSpaces on unrealize

Peter Xu (1):
  memory: New AS helper to serialize destroy+free

 include/exec/cpu-common.h          | 10 ++++-----
 include/hw/core/cpu.h              |  1 -
 include/system/memory.h            | 24 ++++++++++++++++++---
 hw/core/cpu-common.c               |  1 +
 stubs/cpu-destroy-address-spaces.c | 15 +++++++++++++
 system/memory.c                    | 20 +++++++++++++++++-
 system/physmem.c                   | 34 ++++++++++++++----------------
 stubs/meson.build                  |  1 +
 8 files changed, 78 insertions(+), 28 deletions(-)
 create mode 100644 stubs/cpu-destroy-address-spaces.c

-- 
2.43.0


