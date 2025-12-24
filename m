Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D325EE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQYx-000252-HV; Wed, 24 Dec 2025 10:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQYs-000246-9u
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:03 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQYq-0002y4-4Z
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:02 -0500
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so76569466b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589238; x=1767194038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kz8kL+YclKcnBgSBGG2+Kbv6UCLSfkrnEN6ow1rTYic=;
 b=bEBLEDWQKR1UAK+dC49TKbTGgFvgxKCIGX2kHsm2P/MeBL6BtIXsueHcPu6dOhCPBz
 aJ5rb0GEV/iTlPuPTHwzpFboGDVEVssUJZhFQYjQLFYSkJQnElarWhag9uJdPpUkQ699
 G/ZNtfIV8NrsUz9o9KPBHDwsC7vAAKzQRKW7lwqgt2KcHFysm61mDiAEHnT+gg6UrLu7
 eSrEQDbrXJK4Wy/hfiu1uvBR173+dajjPTycc6QnANOIuQvxpoYmi6kTHpGoiv7DK1RG
 MRWGNLz7s9r4zlXOklt3xkgzT8tg8K2DWeeD1GmFjWEHDzjabHR9oldlL0Yrr7twqm7B
 tpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589238; x=1767194038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz8kL+YclKcnBgSBGG2+Kbv6UCLSfkrnEN6ow1rTYic=;
 b=cO6AMYa+cCHNUGwDFC7CSmHbKMqdduV6CZJKJKOpulzr/EtyushPfb0myLdVBadgIB
 JXrfV3w8/r3/9NN5NtxLp1chQg4r2h2EazpD7CBhYs7ncpmNTOCvXqSS+C0M/5EG1+Jr
 yzZ9EOZ3h75+18S3mOk+608VaQUo0tVBrxbacovZpDjEPu4b5JG6GiJsxLs4pItepnry
 4JnTZxdayKvPiFCJdr5JQ/YGnQQUHMuDSNKdR0LxOS6BFOYyMUMR9VI34Q9NHm98g3wU
 jUtIzJLoXi8cqBEbR/bVsXip6AIimAJUxLZG3SG6exVnRQuHz604wWBcekWbLFnuujoF
 Y6NA==
X-Gm-Message-State: AOJu0YwXg4P/8hovF11EwQs8odfIx5zVqaDcYJt3q+s8njQdr6jeKMys
 VkNVjC83sIpht4OoP+1/bcljSgt+7i9wfKGvkNv2OnwB/N1eURGw8HGFoUi/7cQMgitZoj/yqA8
 noAxdrVw=
X-Gm-Gg: AY/fxX58GxiMjQExsFx/NiZ1sJ//KYkXhVknCDGHh2NMtAXtA7QRY7TM0WB1qVnQcf/
 ftMrbp0+1MZfXiHQh90c9diQl2djjGWVR45kUm9eCVSJ9Is/bszshQBlZXSMqyFNabXk3CVGrjQ
 5Y3gFi/OCgspbGXyrAhAKln+2fglwuLIgxMOTYYVjY9h23gtiDScV0fwrugjQwXD/bdki3huUIy
 gnXHgwwq+nYTd5XY5M+gcpWonwuP5zIuE3VO5yAsjIXQXtCA1CjvTsRZXxu7o9OEr7jQKPGlJY8
 DImFTzqv102V1IdkqRzALnsb/zbGxVtfyoJwo/SWgNc5qoeuu/bkluzrza5LCHDATX6H68HRkDj
 s92gfonnbY325eTfWHwaXqtKPSGq3ZvfiRcnuuaYn5EBPs7pTQEKL2fjc/bPci6voIlsuhMeSH3
 QbfX7i8+sbLJx/O8SxGhbGKYp38WfN2Nvn05iC+CesZDTaglVYnntH+1A=
X-Google-Smtp-Source: AGHT+IGrvXVa+/0ANINlFhDNU0yeNFGdHXSXsM/pi0xthrHpY4vGX7TNUZ/VSt9qUvd/W6+b8m2/xA==
X-Received: by 2002:a17:907:3e8c:b0:b73:7fc8:a9c9 with SMTP id
 a640c23a62f3a-b8036f5a99emr1669580066b.29.1766589237807; 
 Wed, 24 Dec 2025 07:13:57 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b916b3b35sm17373819a12.30.2025.12.24.07.13.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:13:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] system/memory: Mark ld/st_phys() API as legacy
Date: Wed, 24 Dec 2025 16:13:41 +0100
Message-ID: <20251224151351.86733-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x642.google.com
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

When using the ld/st_phys() API, when an access fail,
no error is reported. Because if that we introduced
the address_space_ld/st() API 10 years ago. There are
few uses of the ld/st_phys() API left in the code base,
time to mark it as legacy.
Allow targets to opt-out for the legacy API, by setting
the TARGET_NOT_USING_LEGACY_LDST_PHYS_API definition.

First drop the _notdirty() variant, mark some targets
clean of the legacy API, then rework virtio core layer
a bit in order to clean more targets.

Targets left missing conversion:

 $ fgrep -L TARGET_NOT_USING_LEGACY_LDST_PHYS_API configs/targets/*softmmu*mak
 configs/targets/aarch64-softmmu.mak
 configs/targets/alpha-softmmu.mak
 configs/targets/arm-softmmu.mak
 configs/targets/hppa-softmmu.mak
 configs/targets/i386-softmmu.mak
 configs/targets/loongarch64-softmmu.mak
 configs/targets/m68k-softmmu.mak
 configs/targets/ppc-softmmu.mak
 configs/targets/ppc64-softmmu.mak
 configs/targets/s390x-softmmu.mak
 configs/targets/sparc-softmmu.mak
 configs/targets/x86_64-softmmu.mak

tag: https://gitlab.com/philmd/qemu/-/tags/legacy_ldst_phys-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (9):
  target/i386: Remove x86_stl_phys_notdirty() leftover
  target/sparc: Update MMU page table using stl_phys()
  hw/arm: Avoid address_space_stl_notdirty() when generating bootloader
  system/memory: Remove address_space_stl_notdirty and stl_phys_notdirty
  system/memory: Allow restricting legacy ldst_phys() API usage
  configs/targets: Mark targets not using legacy ldst_phys() API
  hw/virtio: Remove unused ldst_phys() helpers
  hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
  configs/targets: Mark targets not using legacy ldst_phys() API

 configs/targets/avr-softmmu.mak          |   1 +
 configs/targets/microblaze-softmmu.mak   |   1 +
 configs/targets/microblazeel-softmmu.mak |   1 +
 configs/targets/mips-softmmu.mak         |   1 +
 configs/targets/mips64-softmmu.mak       |   1 +
 configs/targets/mips64el-softmmu.mak     |   1 +
 configs/targets/mipsel-softmmu.mak       |   1 +
 configs/targets/or1k-softmmu.mak         |   1 +
 configs/targets/riscv32-softmmu.mak      |   1 +
 configs/targets/riscv64-softmmu.mak      |   1 +
 configs/targets/rx-softmmu.mak           |   1 +
 configs/targets/sh4-softmmu.mak          |   1 +
 configs/targets/sh4eb-softmmu.mak        |   1 +
 configs/targets/sparc64-softmmu.mak      |   1 +
 configs/targets/tricore-softmmu.mak      |   1 +
 configs/targets/xtensa-softmmu.mak       |   1 +
 configs/targets/xtensaeb-softmmu.mak     |   1 +
 include/hw/virtio/virtio-access.h        | 106 -----------------------
 include/system/memory.h                  |   8 +-
 target/i386/cpu.h                        |   1 -
 include/exec/memory_ldst.h.inc           |   2 -
 hw/arm/aspeed.c                          |   4 +-
 hw/arm/boot.c                            |   8 +-
 hw/virtio/virtio.c                       |  21 +++++
 target/i386/helper.c                     |  10 ---
 target/sparc/mmu_helper.c                |   2 +-
 system/memory_ldst.c.inc                 |  39 ---------
 scripts/make-config-poison.sh            |   1 +
 28 files changed, 48 insertions(+), 171 deletions(-)

-- 
2.52.0


