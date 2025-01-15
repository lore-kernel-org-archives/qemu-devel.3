Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABC6C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uz-0007e0-2a; Wed, 15 Jan 2025 12:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uw-0007d2-9M
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uu-0006bi-NT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so79355525e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961054; x=1737565854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smDhBagDkZwA365xUOcNTdBn7TvA4+hGOXOJbXYQ2tU=;
 b=T6igV5rvFKBzv8pKAGeY5lfzwS0Sy6vpXAJhyWLrfulJdqDMEOIx47WW6TqQD8Cei9
 7FYWtlJE8KY/JWm4KK2V9iw+P4auhMgRWhoVzb7ZHDsvxmCI5MHVaGdt27RLMIphw/bm
 6NLkc4bXNfiZ4LFu9sVJckjHW+Pfi9sbet6wCE5R0T7fdGUNE035zgYOm9lZxN9bgkgx
 aGnW2jTyc/NSFnF52xCRagZDe6yYlHWb4SBuW1lRnj2Vuh5Bdx+CCixZ2ZG+YqgWIiih
 DWcqZ38DauFyCUJIAG/QEm3r4dFP4kMdD78QylqR58VcgPLyrOPX7rn9vnQdtzGWuQRi
 /JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961054; x=1737565854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smDhBagDkZwA365xUOcNTdBn7TvA4+hGOXOJbXYQ2tU=;
 b=ltZ6nw5/069HsYMnCRfKlS1V3D53J7Fg2GMx0K1xh3zJyP1rFjQ6VTWm7XdkGW4ZX1
 NWAxX/heHznU51Q22VyRcKVCyYxj+N+q7GxgLgIDjWG7yo4tQZldfSksftWHdHH0XJhS
 Yijpa075x0CnUX+sfXT02gDMc5dy5zQFeMXNPIhaij4Mq6wUlBnyF386hGViolhI8XJ1
 CF/zRbTs55IRbeSZNMwUVqZi4X4fYacIX4Iy33fxUnRcmIa/Ael5UShLH4oYeajMghSK
 flMfUzzgtpHzRgoGs62yfvMIZudsfifCAPaWJNjRqNACgBcqzxDlEyhsEGZSdy2+kPhR
 6C+Q==
X-Gm-Message-State: AOJu0YzT7+jFW2RYrbHDCNKy6LuCoItbTI8mwxdalH1noXRK+FLmViZS
 P0v3NZ58sL5tDTOGRtMZKUmYLl+X4Gz6N0exeff9wvRy8uaWry3ogReyo7JCz/nnknW8p/stYOF
 fitI=
X-Gm-Gg: ASbGncvMYhkKlfaLzvkJJ+4oP82cePnMy9uf5Mu6RJk+1dOVRvhsgvCSAiGrVgZkoHG
 8DqXt0Fi/QLCZKT4ciJTFJgkBOeUpxYMFH0+R24tUJS48gTCsaC48QuTFPrP7Hqa6yAQWVAK6ss
 CbE7oKFpgLxcphAfv2NNpugxfXoVxd16iNS2DTnYqf9ikV8fzULFO4p4KmQpqtwpVdL1qPp2hnG
 h4opl3ob1Fri7+z4T3oovhncjBXM+A5bX4kyFowdzfWZW5GqERQqig0og16ZlE9PukQgq7SdzT6
 3A2vtXNKX7mbKIWna2GJ3IcoW62zdxlrRwt4
X-Google-Smtp-Source: AGHT+IF4Q/LJ8BeUjR9FiMWcNxihwi+xEDhNoq4229BpUXqc778f60G2Qndphf5C4VII7rl0A+BIYA==
X-Received: by 2002:a05:600c:4751:b0:435:23c:e23e with SMTP id
 5b1f17b1804b1-436e26af4b4mr290255365e9.12.1736961054538; 
 Wed, 15 Jan 2025 09:10:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7540ae7sm29418015e9.33.2025.01.15.09.10.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/13] hw/arm/virt: Remove deprecated virt-2.10 machine
Date: Wed, 15 Jan 2025 18:10:05 +0100
Message-ID: <20250115171009.19302-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 4 ++--
 hw/arm/virt.c                   | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index dbd04b00e4d..7c8b98fcdf9 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,8 +1065,8 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` up to ``virt-2.9`` (removed in 10.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
+Arm ``virt-2.6`` up to ``virt-2.10`` (removed in 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
 These versioned machines have been supported for a period of more than 6 years.
 
 linux-user mode CPUs
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6ba75a91574..dd44fb30773 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3535,12 +3535,3 @@ static void virt_machine_2_11_options(MachineClass *mc)
     vmc->smbios_old_sys_ver = true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
-
-static void virt_machine_2_10_options(MachineClass *mc)
-{
-    virt_machine_2_11_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    /* before 2.11 we never faulted accesses to bad addresses */
-    mc->ignore_memory_transaction_failures = true;
-}
-DEFINE_VIRT_MACHINE(2, 10)
-- 
2.47.1


