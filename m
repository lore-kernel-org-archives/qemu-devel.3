Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36573C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAE-0002z0-GL; Mon, 23 Jun 2025 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgA6-0002js-2s
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgA3-00011D-W2
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so1701035f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681230; x=1751286030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvGV0OwfNAMYe1Mulybvoaq3k7G7T7tR2QdHLx3eR4k=;
 b=n113Z5x9b5s+HlKXxgEvsQRSyAJ8WSfA3sE78/ZtMrJDC+pamWyM3eF7SyUZrxLNHA
 h6UM6TdBqPMzZdSIDxUx8LfwaRQ5YDHRRh1A8kvcAUqZKgpMwyjpmkrjDfOXuV5Gh9gg
 3SB3lgkTRxgKPgMSrLjXXcgcrLcAZapIumngFrdpeYjWTTN6NxovpLFAxnrdq9DV5152
 2S7Z8bc6YOrmgSayZunhi1qJp1R5u5PEURLorR+BHzINLipw8Ed/igbyp4pqYR/QBK/P
 5gzn6KXXJxba8y1+6ouja7S1gcSlVCLZfh3zKnHdy76R8EiyNSoWAUidLQycw56CSBat
 OYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681230; x=1751286030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvGV0OwfNAMYe1Mulybvoaq3k7G7T7tR2QdHLx3eR4k=;
 b=wqbWle9rvwNzp0JzghV4STUB7qDiJmF26NR2nNjMJo1EkDakClFdn4gVIyIJBijm+X
 PwDl2Lmakt5kg/uUGc6Lxok7NWD44+/KpVSnI/sX7AtBnVfZabeGmobwrywyiUsMxBNA
 ZWLLWudwmzyz068T9UYYiPEqQF8/6IwjkhL8gahIIpLLDnI9JzOkd1xgmtG3+N63GGxD
 AlufmnalFvKEjRXxTkbcBmBL8z7HqRkAoc6nMS739Fg5PC3zKDkzzO5ahkeiEanlF+Jc
 +w1fckRwNfzLudTWOvM77YqZSLxgm5IwyyuXXI20MO1gEtoK99oSA0UNbaLNXjBYM7Bc
 vqkQ==
X-Gm-Message-State: AOJu0YwpE58mVrIGdDJQfQGryG6D24J3efRR4BZ+bbDJ6/VSGXeu0z0a
 /GT+CTq8N96/T7p1TgwGbRCF4ObyaYTLrrF4sfxlgK+A3IB/FN8W0GXjtll1XsfORoMlkp5HD8Q
 b7VZA
X-Gm-Gg: ASbGncuwqeQB1OcIq9gH6aLAJCfeNLE/ekTFZ6eWa4oJoCmjW8LYsTNhWQHexEjb1p0
 RiueoMJ4B7eGs8qwNyK+UuLWKmCtrilEBsMUy5Mwbb8a6KOtJhugAAsHKNRCUFA2Nv/yiBJNr31
 Uu/iOYlafC0SfYXMqxQO4bDkt2vNq8VcwvROmDUESCnuJmF0736gu/PmudAi5NyaS3tNhwFRQsG
 Vwg6mVOOU14Bqggyc1LcbhmiqJ/0S9cr4y2iEoNMNSGY+/mwMHp8C+tza4M9gltjD819HzbBy1j
 sjsMhsEO+EwN/S5/6zY4DXos019rM6w9oShDQXfBwYyLTrSIEMNHtB+ws+gspG6T1WTT696QsOM
 cblt8bbUaB+LCzwjzLkxPx4UcL91sbK3JF37I
X-Google-Smtp-Source: AGHT+IFHvPu69hvLV8v46JK3gDouHS/oh+Msk1ox8QgY0quFrYsKcRStqL+fYhN7WRhsh7mvIZOwqg==
X-Received: by 2002:a05:6000:3c5:b0:3a5:2208:41e3 with SMTP id
 ffacd0b85a97d-3a6d11910bdmr10782043f8f.4.1750681229837; 
 Mon, 23 Jun 2025 05:20:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19b30sm9525253f8f.37.2025.06.23.05.20.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 20/26] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
Date: Mon, 23 Jun 2025 14:18:39 +0200
Message-ID: <20250623121845.7214-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

QDev uses _post_init() during instance creation, before being
realized. Since here both vCPUs and GIC are REALIZED, rename
as virt_post_cpus_gic_realized() for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9099570faa..da453768cce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2032,7 +2032,8 @@ static void finalize_gic_version(VirtMachineState *vms)
  * virt_cpu_post_init() must be called after the CPUs have
  * been realized and the GIC has been created.
  */
-static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
+static void virt_post_cpus_gic_realized(VirtMachineState *vms,
+                                        MemoryRegion *sysmem)
 {
     int max_cpus = MACHINE(vms)->smp.max_cpus;
     bool aarch64, pmu, steal_time;
@@ -2349,7 +2350,7 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms, sysmem);
 
-    virt_cpu_post_init(vms, sysmem);
+    virt_post_cpus_gic_realized(vms, sysmem);
 
     fdt_add_pmu_nodes(vms);
 
-- 
2.49.0


