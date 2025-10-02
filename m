Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC05CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Kkx-0007F9-Qb; Thu, 02 Oct 2025 10:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kkr-0007Cx-EH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kki-0000Ck-6R
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so11825285e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759417064; x=1760021864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoTee1wY/4Z8UrgceMQOy/NZaOImNF83wByOYO4nupE=;
 b=mM0s9g91nzp2DmUZtRCWARsMc1UiH4rDk0ogyS7vsS3xjHMNnLgEOmIKxmPjFpO7Cv
 h+n4E/o6ahIc87sM7Lzk2uN0gs5vCpeQS26npzS9JHMr81Wh6T92/LUmD9URzEgqp3Lp
 56suICfx3RRT4EGmuq35kvMhian/cVuC1cZSb//nRPQ3JGzZr3QXhX7MT1+z8G0pbZHF
 kEJNE9fWYR9V0jb+z44kbIoLFFRQGC73ceVCOXZXSrcYDj/iCkHKp6oE8vnEM775tmUd
 V/jmWhIa6qwG2SVc1GAXlJio7u5BmEkM5aFN9MZH6zEX8slpoCtwC8mOzqTLSNZKZLn8
 179Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417064; x=1760021864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoTee1wY/4Z8UrgceMQOy/NZaOImNF83wByOYO4nupE=;
 b=EkFQ3FENJGFGVHcv8ENPfhm8y6ZfpGXUadzgClpHzw6f5xSPr5yrebJRfmr0kyBlxT
 WPtEq7DY0aUF32/yap9sl+swvefCwELesSAxDcFqfGtRleWFgXw3SCfBs3+wu1hA7Umq
 RGyUq5/zYXU4txalrD3mh2peiWwf/uds8r9xoMaGEUkXyyYvN0L3NJfuHV1GZCQTua9I
 3dT1fuzbZ4HxrITUEo53MSSqvl10Rqf25S9K5YjxAg02mY540advfx2a3V+fPYfwDrOf
 luFE92ICYspw4jBwawkfVkfCFvFFXv9Idg8xpl1m8slF8J1RJdMhK27LAn4LLPjLECyG
 c2ew==
X-Gm-Message-State: AOJu0Yx20+AVWx3IqYGHk3oMnZTSBwGv92D2JU7FYwAsRLvD4sIwYVsL
 uzTk5uf878uyuCO71OsHR37UpwsTuTaXcw7MONXLE+XWTfmJNV85LOQLgjPjPqxgZfFh4Xa2XLu
 DVhsh8szdL9Cv
X-Gm-Gg: ASbGncsHlVPTiJdOyWRGA0G0nWXi9QPrwZ7LpEiJDfJ1LzwajRqcaesfFDHVsr4Gdna
 q6utiEyCk5ooP4UN34xWxFyZTQ4G0mv7Ld3QrpaDXGvFVkUkkA7+AeSggtFwa4EmiLVhvnu6DMD
 spJJ/vRyG6yEaFBwXlh61G90iGDn+u92MXvLnUUARTluvIYUiCCYYt2XwXd4OQR5sGsPg8zKaNU
 leUcrccQizE4qNJsjXOobA7zkoAMUprV2OMqa/kNbzDR1qYvqsfElrE1CNMVQr5bE336VwmBmXt
 3AqIX6Vx4vBimi0GS8QCoKu22th9kDffW6T2z9HND+u2RIb9TaJJO5+VuPitcOL/+NAyRE1ZfXe
 kCowguKrnckQZ2v03LE4PbB4W938Xc6PnA3br79OzrzMj3jSKZn4CQxGoRFxrjL8GRPZXst4CEA
 r+bMclPi9Sj4pyqSPtqvzy/jHq
X-Google-Smtp-Source: AGHT+IHWOX09FU0xZ+bjaszTfnvN7j2gcdt7xzYqHffyTzQkST2hqs52bHwu+grjhQTtk+Hp82G0MQ==
X-Received: by 2002:a05:600c:a404:b0:46e:6339:79d1 with SMTP id
 5b1f17b1804b1-46e63397ae5mr53003735e9.5.1759417063905; 
 Thu, 02 Oct 2025 07:57:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm4121462f8f.31.2025.10.02.07.57.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 07:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target: Remove remnant legacy cpu_physical_memory_*()
 calls
Date: Thu,  2 Oct 2025 16:57:35 +0200
Message-ID: <20251002145742.75624-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The cpu_physical_memory API is legacy (see commit b7ecba0f6f6):

  ``cpu_physical_memory_*``
  ~~~~~~~~~~~~~~~~~~~~~~~~~

  These are convenience functions which are identical to
  ``address_space_*`` but operate specifically on the system address space,
  always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
  ignore whether the memory transaction succeeded or failed.
  For new code they are better avoided:
  ...

After converting the target/s390x [*], this series convert the
remaining targets.

Based-on: <20251001175448.18933-1-philmd@linaro.org>

[*] https://lore.kernel.org/qemu-devel/20251002091132.65703-1-philmd@linaro.org/

Philippe Mathieu-Daudé (6):
  target/i386/monitor: Propagate CPU address space to 'info mem'
    handlers
  target/i386/monitor: Replace legacy cpu_physical_memory_read() calls
  target/riscv/kvm: Replace legacy cpu_physical_memory_read/write()
    calls
  target/riscv/monitor: Replace legacy cpu_physical_memory_read() call
  target/xtensa: Replace legacy cpu_physical_memory_[un]map() calls
  target/sparc: Reduce inclusions of 'exec/cpu-common.h'

 target/sparc/cpu.h          |   1 -
 target/i386/monitor.c       | 134 +++++++++++++++++-------------------
 target/riscv/kvm/kvm-cpu.c  |   6 +-
 target/riscv/monitor.c      |  12 ++--
 target/sparc/helper.c       |   1 +
 target/sparc/int64_helper.c |   1 +
 target/xtensa/xtensa-semi.c |  11 +--
 7 files changed, 86 insertions(+), 80 deletions(-)

-- 
2.51.0


