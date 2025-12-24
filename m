Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA69E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRZq-00076U-MK; Wed, 24 Dec 2025 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZX-000741-By
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZV-0002G4-SL
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso5951935e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593124; x=1767197924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBnQYwae27bI5/nQyHViP2jfiR6a49M9gQ7XldWPasM=;
 b=reyeCuVcIRjZbUgi0qqZj2xyvrS9gBtxlx7xCgSnhMXetZudgwfJ5NLGDrKb4IVhLN
 pQGStxjNvCk+jehMX+qL3VUFJnhIPC/EHFGALM+O/TePRtyhbXyUtg7bGxkspbvMqIYe
 FM5wGIF4Efe4X7pzmj07lwH+TuAyyxAnBpMGQE4wDGSvMWsRi58/+u3WIEtNRIkT3k9/
 yaPiYhRA667GdMwd92qWQN08+0dptqTNdQ+6QPdDuKSHVuy7Ry6mhkIyv7Lt3yraTzoK
 +POAg4qVd8BoaKUeQmrCBWtc7zrS6aAB+WRBTeSPgSllEFMyRgoBk9YQjG7h0g66I/JI
 n5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593124; x=1767197924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBnQYwae27bI5/nQyHViP2jfiR6a49M9gQ7XldWPasM=;
 b=UJyJ8oKIR1kHZmCWktXGoxQoRrUHp/WGfQse6Px0QW3BcQIIh6zyXQnKmsumTAl8tQ
 0TvxTqTVw6n1+dV3c9lMIAfgI6IUPKr++Pp8fpiYFL4i+8+qD25lOjUeENISOPsxZxVJ
 gLKOjFANAJCNsNrl++Z3ynoEZ7wlDTeTnHImDVSErBpI6DpXQQG4xyxkDkBHLhnGQq/f
 VmVuUtaX+WrSLi1deJLfLbK3mDf1M2ugh/bgerunULgz7c2wpznoiOKxuj35Wt+lXgpq
 ClspegqrOHeLlKb0NJdWir8+DO9hYfRddOg2WZ7skKYzkuGA4sNpiThuku1Ustf5wiab
 MifA==
X-Gm-Message-State: AOJu0Yzxxrt8O1D/PonZcrsQSd50OgYyjvutbFL0GW4VuJKilsKhXlmN
 GwrUrAQvKE6f65JP37erLzmZX6rd2Df+fKlRxYsosfEdcTl8M3qXHwUAtBYG7EbpSseuhoFfJKH
 8Q4hwwe4=
X-Gm-Gg: AY/fxX4AcoaCTuFaJT4fz+d93ZQ92lII6Z/7XjSClelw7pjsJLDYuqkbqJ39SceBZ6n
 5UT85NOWty8w6/VkHrLCgqU6SWgliiCEi6Pw2odb/jNCyShRDHsbRzLSOf9/9Jd5wIvossc6aLl
 Kiru7NsJjrrzFprazVbPVpbbTbHPKRpGCEAdjXq4rYcTZ1XfIo+0lnpJPGy63QIbiEwScaHiccP
 t87HOye8IC23INTqRGwKHOzZG6dYh0xHfn3hCXMRQ9GUeOFy5z0NKAFQ9AXC06EH6EzMlBp0lMj
 m/0fK/RKTefma3PFmAARc80vU5Cg5Zu3EyiyKbAAUaCAhp/zlGr9DAFqGNJ2dY2qOUfAooeCfp+
 KFvnJLoaxMHN+OKQmbWZ8Bg1s/uzl93EkRr+aVa2nVc6Z50+b/nWQJNRBC5KWfEgFUN0UF5cvwq
 jujMMhspATpPX5S2YgQy/CFOhe8xmk4eesI0hha8/8/qVU+8s5pb0LHS8=
X-Google-Smtp-Source: AGHT+IH0y5OXVd9m3NAc5AT1DAoPtvq3DESBPJMQVlu0WtQ/3X2RaScjpMg6sJO/csHCkB5GbC2inA==
X-Received: by 2002:a05:600c:35cb:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d1959e061mr181240945e9.37.1766593124072; 
 Wed, 24 Dec 2025 08:18:44 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm34517756f8f.33.2025.12.24.08.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:18:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] configs/targets: Forbid OpenRISC to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:18:04 +0100
Message-ID: <20251224161804.90064-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161804.90064-1-philmd@linaro.org>
References: <20251224161804.90064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All OpenRISC-related binaries are buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . 5b67dbf1dc3 target/openrisc: Replace target_ulong -> uint32_t
 . 500708331e3 target/openrisc: Inline tcg_gen_trunc_i64_tl()
 . 4f6c60683f2 target/openrisc: Replace MO_TE -> MO_BE
 . 73cd283e58d target/openrisc: Introduce mo_endian() helper
 . 2f737e19a4d target/openrisc: Conceal MO_TE within do_store()
 . 22c36c0a20c target/openrisc: Conceal MO_TE within do_load()
 . ef797ac0025 target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
 . 81e2fb236b7 target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
 . 9dc4862dc4a target/openrisc: Use vaddr type for $pc jumps
 . 2367c94cbb1 target/openrisc: Remove target_ulong use in raise_mmu_exception()
 . 1843e89bec5 target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
 . a3c4facd395 target/openrisc: Do not use target_ulong for @mr in MTSPR helper
 . 2795bc52af4 target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/or1k-linux-user.mak | 1 +
 configs/targets/or1k-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 810567a98f9..97d7cb10465 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 89f81b75bf7..c53408a2bf5 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


