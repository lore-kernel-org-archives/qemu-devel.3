Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69177C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJz5-00070c-RW; Tue, 18 Aug 2026 09:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wwJyz-0006sP-HW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wwJyx-0000eW-NW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2caed617615so60994375ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787060158; x=1787664958; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rnpSMHdKxpifgB7rbR0f3HT1pfTaEjaN1jkrKszzRJQ=;
 b=iu3Fge/3d3kvMsy319h7GTDeACNH9+afGDcc+DsA8mQnNlExoStPBmsdXEQ7/+NC4c
 x5W3BJ5VijBDC8lpNZ1oCh9vGkXbPtjexDK+Vf2FqC24TUhGErcJoxzgzlVUgMP/aP2R
 YfnvzGq6+hz5ZCqk/20HmT2CAXBRwzVgfmMRdUTQ9OltMvoUhoRoCwTArSOm0bgT3p0e
 eCyDqlhUHKh2f8PJTGnWV3avas3Pd3/Sp4GWGObmRdzo41JfsRjUvo3RBCLLCeebSYqU
 L+4v3NOcdLNmrBcDIvfqOJVx2SGcwxN2yFJRMNcC26mzyBvG/nCVOcQMqQoXAEksBL0H
 SzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060158; x=1787664958;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rnpSMHdKxpifgB7rbR0f3HT1pfTaEjaN1jkrKszzRJQ=;
 b=IdZK7R55KliERIRXOytGM/QXf+HsN/QgnAC2LbHp/M3a/fzAN4i5QIxAscqWQ/kmto
 Byc9k7yQF/1X8A1V26p6Vx7YORV0+dEV7CmLMDZ0C0VOmAsLocP7PYpXJQk62NrjUT/W
 H4WfzwkFrD3AIsmCUIgCrM0pMeRWUQzyZ7Lxd7WWdMbrQIEIGZJMWlleC9m7izRSgwQi
 ErEjY2eiV4Je08dmpFFKgQRhHlcxSPdr4TAIB9tPcxSgfMRR4oGsJgtjUiqJqbIpserQ
 pbdVWpBz4qm5QJ979MSxUePdgFGRUMiX+fvd3QWX/WvpPQP9DzCcdpbU32zJJeY64SNe
 yfPw==
X-Gm-Message-State: AOJu0YxwIa9zEJktmsTVt5FMW74xJ3xhTsgaaCtNNjLq9z9vCbucNHN2
 GXIytmYRYwSJ5eKvDFNEHuV8cee3EDeZqcJjvlx9xdczDw0EDtaZEI1h
X-Gm-Gg: AR+sD11Tdx0Unt3DmYc5rfTBBUmg0pgIZCsWDa63zjEjqrajPBzctweHfpuahZ7nzgI
 wBnnVlx3kRh6amLdLtMzPdSKQOykhbPuWFjIyXheoaBllQOHi1ONjUiUFTNjsOKCnJ0xcF7LkGu
 OcgbmOcgqtwYm7gQWt4oREXzcNmCXRaePFkO7r/9HhpeOVfemPNiFEPTIQUiEyTSNRMIpV8m91c
 vzoUPcNjDoXA1+kZxHbpEYSoAIG4431bZT+DXjtiA1fUD6YV7Gwld0QPu5FKBnHq0KD2sOamJgN
 K7LWjcjW5MlrjKDkN/FN1I+NELznjCPLFkEGGJ/NQHfny76W90/+EielJe5+q39ugJQy60kgQid
 rmYE7GBKFfOGFrnSTuhAG58DXIY4SaAG++GEy892BbfVdBkoarLYsoYOUqcfu5lm4ZJ2iMNAq/S
 Th1wBCXyMBVDoQMfW5+krQ+AWXbQnPt4fySlj9rvhF1l/+e9HwJzDh8xFdYOAOVMeSaI/BsEr48
 4Wz2CsnS+WJvJRvFQ==
X-Received: by 2002:a17:903:4b50:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2d3b0eec2e4mr420338295ad.13.1787060157672; 
 Tue, 18 Aug 2026 06:35:57 -0700 (PDT)
Received: from [172.17.0.5] ([42.193.175.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5d014d965sm8066845ad.35.2026.08.18.06.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:35:57 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
Subject: [PATCH v2 0/4] Kendryte K230 CMU register model
Date: Tue, 18 Aug 2026 21:35:49 +0800
Message-Id: <20260818-feat-k230-cmu-v2-0-57eadb98f40f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVfhGoC/3XMQQ6CMBCF4auQWTumDKRSV97DsMB2ChMFTItEQ
 3p3K3uX/0vet0HkIBzhXGwQeJUo85SDDgXYoZt6RnG5gRRp1SiDnrsF71QptOMLzU0Ta+eo8hX
 kzzOwl/fuXdvcg8RlDp+dX8vf+k9aS1TYnAyZhmxda3vpx04eRzuP0KaUvmvntWqqAAAA
X-Change-ID: 20260809-feat-k230-cmu-9b62e6dd23f3
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Kendryte K230 machine currently lacks the Clock Management Unit (CMU)
register interface required by the K230 SDK U-Boot and the Linux K230 clock
driver. As a result, software probing the PLL and sysclk providers cannot
observe the expected reset values or register update semantics.

This series adds a minimal, deterministic K230 CMU model.

The model covers:

- four PLL register blocks at 0x91102000..0x9110203f;
- the defined sysclk registers in the 0x91100000 window;
- the software-visible SPI2AXI_CLK_DIV register at sysclk offset 0x108;
- reset values and writable/reserved/read-only masks;
- PLL control write-enable semantics;
- write-one-to-trigger update behavior;
- deterministic PLL lock and initialization status;
- VMState for stable PLL and sysclk register state;
- qtest coverage for reset, masks, write-enable, W1T, status, sysclk
updates, unknown offsets, and system reset;
- K230 machine wiring and user-facing documentation.

---
Changes in v2:
- Drop the extra K230 Machines maintainer entry (Chao Liu).
- Consume descriptor w1t_mask on MMIO writes so W1T strobes self-clear
  and are never retained.
- Align wrapped questions fix (Chao Liu).
- Link to v1: https://lore.kernel.org/qemu-devel/20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Chao Liu <chao.liu@processmission.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

---
Simon Law (4):
      hw/misc: model K230 CMU registers
      hw/riscv: connect the K230 CMU
      tests/qtest: add K230 CMU coverage
      docs/system/riscv: document K230 CMU support

 MAINTAINERS                 |   3 +
 docs/system/riscv/k230.rst  |  22 ++
 hw/misc/Kconfig             |   3 +
 hw/misc/k230_cmu.c          | 903 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   9 +
 hw/riscv/Kconfig            |   1 +
 hw/riscv/k230.c             |  14 +-
 include/hw/misc/k230_cmu.h  |  58 +++
 include/hw/riscv/k230.h     |   2 +
 tests/qtest/k230-cmu-test.c | 312 +++++++++++++++
 tests/qtest/meson.build     |   3 +-
 12 files changed, 1325 insertions(+), 6 deletions(-)
---
base-commit: f893c46c3931b3684d235d221bf8b7844ddbf1d7
change-id: 20260809-feat-k230-cmu-9b62e6dd23f3

Best regards,
--  
Simon Law <0860734llx@gmail.com>


