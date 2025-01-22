Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B73DC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taduo-0002PA-VA; Wed, 22 Jan 2025 11:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tadul-0002ME-54
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1taduh-000593-Me
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so50080945e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1737564549; x=1738169349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7RZEi63Yghe+1zjwvkle+S0lf9Q+BfLQyYedLPb4N2Q=;
 b=Zck8f9KAUfRd8xHZ6zyyECX/dLBqid6y4YwG5HKiJwjVnvewiCpBG6Nrr55bpsnHFy
 A/nr/GwrpyMVico7m9ONzxYjOXRuZ94d6VrNHjZXBbj4HBD07JXEE+0SmTifqTfAXdCP
 vsc8GtrvWWcFzaYb48sSKR3JTeKH6TfMnEosgdizI3NM3DcqPEtQ027l62xt4GQN1d6e
 B4NXS7zME+TqnDVHAcGofH7H2Dhd9Juzfrh/Vz1RN2Z6MP79XgKAF269Ca2OCX11zLRW
 knAvoCSt5b9pSIRPgaVYiYcgdnAJoZZhK8o5zoH936loKQbeRzgcPeSntGQ1G3VHe/ln
 R68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564549; x=1738169349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RZEi63Yghe+1zjwvkle+S0lf9Q+BfLQyYedLPb4N2Q=;
 b=Vso1LBFDRQauHdAVRMHztTaVsAKXjyJlNepJ9rI9sz1G/Uv1P5BCgYLTh9taBUr1zJ
 ymvwk0r1iO87IWssEOlIU2gaq9RC+Q+evtZD7j1pCk7FtQaI8lf90FHe+0FFBG9PjrQy
 phd1JCSswFh1l/92Wbq7X/CfSD0RKBn7Y/LGqy6a1MR6rp3dPk4M+xVwsgQWCEB++J2q
 qVXmPArT4PlJv80Edhid6rj754eo+HrPsCwDrqNqeHrG1C3wJYzVwBEwa1qz4Zmv1Gfw
 RzG7itiqLN/mDNbejDSMWgAqiTh5TzkzNy9x2WGY1srpe7Hb+SdrdJplzVOK4fAx9QTo
 CrIw==
X-Gm-Message-State: AOJu0YypYcOSZZ2ic1N5S/ZVu9e8P0z8Kr94UUbHEohSGpN7kEd7Wq1A
 YRdiy61pAvx4gfbIjzRq9KMSsSoIJwfc36ovMHTw7H57++hZQt1AfMf0W9jF9kSVQUNahEHeHdB
 BN3U=
X-Gm-Gg: ASbGncuYyCJzuOqPxI5dmffMZseMB4csKFwsL/bwzSkLovT6z0IYUoCxgZT98fsC9gk
 AhAKvM8STc6IsBs3zc6BMSFitncUdHQLau1OBNI1pOQBCd37Pqf3+YOFy1pcWPaQE4efihQgJXQ
 PtbPabhjhkqHkGd8xcZ/u39ljQQY64Pd5XS6xkYkylORoiDjaJ1JRhvzYZO10/AFkb2V5ra9X4j
 c362mdg0hb67GkTskINjlNt+m5dfb6a6rQboHNxCChaMz5yS/Uv2UGgoSEzr/Se44KtaOW0tdqM
 cvsg9J8Mgk32xIpO1e7o0HIzhgTElXebMxI=
X-Google-Smtp-Source: AGHT+IFUSOVLjfnxrmmGmdVz28djxt8HcPnRSH+bM/OfJRn7fMTyVEe7Bbz23IyP96DK7KZmc6iEOQ==
X-Received: by 2002:a05:600c:3c82:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-438913e024emr236827035e9.16.1737564548230; 
 Wed, 22 Jan 2025 08:49:08 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c059sm32095105e9.8.2025.01.22.08.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:49:07 -0800 (PST)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [RFC 0/1 v3] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
Date: Wed, 22 Jan 2025 16:49:04 +0000
Message-ID: <20250122164905.13615-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x330.google.com
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

Previous versions:

- RFC v1: https://lore.kernel.org/all/20241218170840.1090473-1-paolo.savini@embecosm.com/
- RFC v2: https://lore.kernel.org/all/20241220153834.16302-1-paolo.savini@embecosm.com/

Thanks Max for the feedback here: https://lore.kernel.org/all/258795e9-4e97-4cd7-949f-24e88d24f25e@sifive.com/

The previous version had the issue that calls to tcg_gen_qemu_[ld/st]_i128 and
tcg_gen_[ld/st]_i128 would not generate 128 bits loads and stores but generated
64-bit pairs of loads/stores. This meant that with a trap on the second load/store
we weren't able to increment vstart in ldst_whole_trans by the number of elements
processed by the first 64 bits load/store.

I propose here the following fixes:

- Split the emulation of whole register loads/stores into smaller sizes:
  we generate at best pairs of 64 bits loads/stores anyway so we'd rather call
  directly for the generation of 64 bits load/store operations and update vstart
  accordingly, instead of calling for 128 bits loads and store that under the
  hood will be split.
- Emulate whole register loads/stores by 32 bits blocks for hosts with 32 bits
  registers: this is done again to avoid a splitting of the load or store that
  we want to generate without us being able to set vstart correctly in case a
  trap happens.
- Don't generate 32 bits loads/stores but fall back to the helper function
  if the host has 32 bits registers and we are loading/storing vector elements
  of 64 bits. This is done in order to avoid that a trap stops the execution
  mid-element.

The patch also adds a set of conditions for the use of tcg nodes or helper
function that is host architecture specific.
We observed a performance gain on all the combinations of vector length,
element size and number of fields in the emulation of the whole register loads
and stores apart from a few cases where the helper function pefroms better.
We add a set of condition that cover those cases and future strings can be added
if other architectures require them.

The commit message changed to better reflect the new behaviour of the patch.

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>
Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
Cc: Craig Blackmore <craig.blackmore@embecosm.com>


Paolo Savini (1):
  target/riscv: use tcg ops generation to emulate whole reg rvv
    loads/stores.

 target/riscv/insn_trans/trans_rvv.c.inc | 164 +++++++++++++++++-------
 1 file changed, 119 insertions(+), 45 deletions(-)

-- 
2.34.1

