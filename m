Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFC1C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n3O-0006ca-Rq; Tue, 29 Apr 2025 11:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3F-0006aC-V3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3D-0007bY-Hk
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso4298375f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941153; x=1746545953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/dF9ePSe8e/Wos3Lfb/d8anPOw/xvpQ5gn6BfEi2A0=;
 b=NqVkwhbPE22isy/hBqQ10SsUqGu7BCoTaRiVFD1vrixdhUg+IHk30EV1NOMFGLAqzF
 /+3i/RScZutfTvCodUNYsyTEXJrkyKvw9hP4pjnwjqiewAjGQnrTVJ9mNDoBVeEMdRf6
 nQLvSZLX1RWbMlBIZRqkfZuh+l3AbMYzYA67vThkXK5BoHR6LLW6uy0UIjFX1p/je36q
 Ub+6FNETUE2kqBTie0BiuF3TvgeVKOy1NDxmZANGfZilW4jGVwE+1Nh6bhLaCPmRzyMi
 6VEntG09IIiRoyENbpgmXHRRsWhXdo2OcBYFlC8FccUgpiswLyvM7OCj3TFc63MIr5gp
 2hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941153; x=1746545953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/dF9ePSe8e/Wos3Lfb/d8anPOw/xvpQ5gn6BfEi2A0=;
 b=UQ+6YgRRkqTMatFLObNbSTfMNH3BuUHeaaGFW2FMFbDicAzpR5pDBjVyeEO8ULQhZF
 JHrOL69J+MD1c0afEfB+U8z68CB9fZ64qxRYH+7NMHEUszL/urK8WK2+34Em1NHHGeYe
 xvvPADK1XjYH3qFKRAZyProBNjn6lHCq6y4mZQHNpqOlktKtOnV7UwMOdhyLxPIbCA/Y
 NuXsE48m50e307ASHqwp7HY5WCVMXgdqAltDfoFiEN94VQ6Zxpm6yZVwni8esikGgG3H
 n1RhwljnbleCq8OuUU4hnOUokJHYHRNs9ZlqRV6V8cBcQs3o2+ALWXb0bw2pDrKd/h7n
 jj+Q==
X-Gm-Message-State: AOJu0YzV7XiEpXWg3ir6wGTZZy/iHXj6pw9nbvJIDrJzQOFOlC5jWJrk
 mj5yiNw+naa7RRa1D7XjesSc0uFVZuvrWSvATdcrftcyZ0v2744xUP8hwVOo5Oai91AKqT++M2b
 M
X-Gm-Gg: ASbGncv3tv5A7zcW/FMQSyY43JyTISn/6PvFQl7bZOA0OXTbXJq8P3UDuxkvrslOZm8
 ozFYoOQE1Q0qEEjvt3c3GswXTNF7ci9t//jhjav36NWgZv24WshXVlKdph0lY9rsl1DbOS/KtcP
 1gLV7wzg8JYfUKZ3eFWK5qt+672DOnBrefDd1HxwiQr4Cwx588X69UX3NqYd5jk/KFWkIWX7QX3
 P9qiZMLPGvfWvijUWJ4tAMu3/XqO0epLdByT4rajCw0lGB1q9FYR1IvCKpRN705ITinygOAz1Wy
 Wp187isa0g9SqMLWAmGwSrwDr+1d7xjIC+Wf4tPa6eensJ/baaq3pQBiOGg24X3LbdhmrxXLUJq
 TYZsRE1PcK0uF4QkdZNX8aTHgLnx3DdA=
X-Google-Smtp-Source: AGHT+IE5d/9HdfksCoM4dGmCnfGqn1mQQ28gZ4b0eRZwNXa/6Mt7GKKRDdl6Y+YEPFUG9Zj91uNLGQ==
X-Received: by 2002:a5d:444e:0:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a07ab9bce2mr8812412f8f.40.1745941153506; 
 Tue, 29 Apr 2025 08:39:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d60asm14560685f8f.18.2025.04.29.08.39.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 08:39:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 1/4] hw/arm/virt: Update comment about Multiprocessor Affinity
 Register
Date: Tue, 29 Apr 2025 17:39:04 +0200
Message-ID: <20250429153907.31866-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
References: <20250429153907.31866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Support on ARMv7 has been dropped in commit 82bf7ae84ce
("target/arm: Remove KVM support for 32-bit Arm hosts").
Update the comment in virt_cpu_mp_affinity() to avoid
mentioning it.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7e3933066f2..83bd1152804 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1767,12 +1767,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /*
-     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-     * GIC's target-list limitations. 32-bit KVM hosts currently
-     * always create clusters of 4 CPUs, but that is expected to
-     * change when they gain support for gicv3. When KVM is enabled
-     * it will override the changes we make here, therefore our
-     * purposes are to make TCG consistent (with 64-bit KVM hosts)
+     * Adjust MPIDR to make TCG consistent (with 64-bit KVM hosts)
      * and to improve SGI efficiency.
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
-- 
2.47.1


