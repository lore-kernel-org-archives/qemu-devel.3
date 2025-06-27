Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D4BC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV90t-0003Jx-PZ; Fri, 27 Jun 2025 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90c-00037m-OH
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90W-0003NL-II
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so2208161b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751030442; x=1751635242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhEwdbXEy5NwBx8sO1ZDvg4qPAxKxqK/ec7o1GfsOJk=;
 b=Y5iESqo8oG4v6jWC9JeMhX9hWwHFRaLs+tCcT3tZ758OCfE7qgG1Qvv5hwqDb+U5VY
 KNtcV3AMosPhfrTJ/Hv+m50FqeTNM5IT0txwLrT0Y+Wsyc9Wd7VAxUAP51b3+1EJxs2f
 i1xbzKiPNLjOV+aJlnqnjfnLvUc874uY4+MLpQCmHXIyOU8s7N9T7KB8u6nt3SXldx9F
 M/RJL71WfSBHgBI/aKDIhl34gqt/vC3Ll0IWDUVwt/FvxVHr7t9DFhB1YVZgIFriHIY6
 8mhS+dA+RWaPa8fBB9eKhR+JUyvcAPmGUg6VKwoxwn6AOZQqIQktQAhykEIMdfoMxlkT
 207Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751030442; x=1751635242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhEwdbXEy5NwBx8sO1ZDvg4qPAxKxqK/ec7o1GfsOJk=;
 b=ItQDwjdWVWiKem06wl5QxyRIePe+5V39MGPfpn6uFGTFCTcpBfnzXwm1oWeC7tjdgS
 YDxxdOm6x1ZZcCSWLObkMgg4f8HgyPbj+lSfUoNAXl6p9dK84anap3vULl1d+QejIAYj
 s2XObU7FAAciSyBE+yJIyPmZNmfjCl5qmtdJYiSaFcOXFnK0PHTUuNtRTWTenatY9dnf
 4kpqxoZ9Mea4nefmYdHJg2JESM+AMOt00WAO0zeMRUhgTv6irAr15JBu5BVTadQNUDks
 V27Cjh5UrfH87gEjANcNAooato+Aignmjz/sMYEZU5eFnCI07aT7OEiz26UhjJtJfjBt
 9DXw==
X-Gm-Message-State: AOJu0Yz2V5BoYSR85P9v7h1PxX1N5gRzNpUNOr2I7qa3w3hD0yhqKTzM
 CVDwjJJiN8YPSUqqawZOKWx8f0Sh5gEsrq/Q9uWg2bpe5RnDL3ukL/K+Bozaftm9xFInl28GfGG
 4KjaXTuEmwVhuNwVCmBBvUJu9MIepsR0rrrCW20UvayHcxEEPNJpDsAuj/iOzH+AM4X1HMPVbyG
 cq422fbydeUEcYvHEKU8cGQMenI8l5Q/ngQkgong9T0w==
X-Gm-Gg: ASbGncsHijfJQeZpg1Veg9wGPwfP/ulIMPn42RlR+SGEgybliEhuEQKfOTEMvzNi/9T
 k0nYcvi+R+9XLHXRAppZyteFGBcN3QjtJ3LSBSaFxWrnKc8jUd81KP8D+UAfs/q8RhOgomCdAYg
 TrFRMDuChDnrF7aujAjapqlz42E3XLEpZqtBWN8mx43/y29SkASscKGzAz6vlDI0RisqBHKGsCd
 pxMYJOAA+/NQ3fEKsQtsSf9sbM1BvbMOXgPwXNJZSMw9MJq+roT9xO67Uj2DA9gTV2h19dAZ0V6
 V7aM9djaBIuxq7ngD4YSh28LtiC82VO+/7UutSJPbaQ37bS4ZxNtoFyvC8sjO5+w3XCJ5UVo/y4
 HX/rlh3mXtvRA2PYXZmZV2fCXPHwqf6U=
X-Google-Smtp-Source: AGHT+IEPQcZueH4f7d7aHs2ifwYEYl7r8mam6U6rZ54pVxXwlcDOjfFuOZcVeI1le3cHOtDsjkPAGw==
X-Received: by 2002:a05:6a20:430f:b0:220:37a7:578f with SMTP id
 adf61e73a8af0-220a1142ce8mr5569938637.2.1751030442536; 
 Fri, 27 Jun 2025 06:20:42 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5573e71sm2393162b3a.98.2025.06.27.06.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:20:42 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 3/3] target/riscv: vadc and vsbc are vm=0 instructions
Date: Fri, 27 Jun 2025 21:20:22 +0800
Message-ID: <20250627132022.439315-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627132022.439315-1-max.chou@sifive.com>
References: <20250627132022.439315-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

We were marking vadc and vsbc as vm=1 instructions, which meant
vext_check_input_eew wouldn't detect mask vs source register
overlaps.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9b..5442203ecaa 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -451,14 +451,14 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
-vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
-vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
-vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
+vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_0
+vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_0
 vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
 vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
 vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
-vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
-vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_0
 vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
 vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
-- 
2.43.0


