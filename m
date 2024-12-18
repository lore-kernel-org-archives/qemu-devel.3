Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E76E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxXm-0000Q1-6h; Wed, 18 Dec 2024 12:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tNxXZ-0000NF-Vi
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:08:56 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tNxXW-0003nD-6k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:08:53 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso1010322366b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734541726; x=1735146526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wj53VmaKWxtGgzq29nXWsC+lzS5katF9PdJGMMTxpAc=;
 b=grQBPboRSACIsWoTONAYVnpza1PtzwZCkmDHa5v3Ox99iZkAebLtoiZNesSL46x1iP
 lO9epXgORzDLLW4+iwDEVZx+TaxQTK7HFovWamWzmmxqInkLmxrrkcG7v2Gdozn3DaQY
 92piRtTMvLB8l0e24jX6QRpxEw7y8WYvaGggcL6R0xcX0M94xyleKejjO01v1iHiDHei
 jZqrVICLTiLdYmiIlTZKX90WKvP9vpimH6qbNeUBUTvK9S8W2U6JpyS51ZiuoYdC4gC5
 LR/0PE10OhRV1zrHoBdgnfrnENqTI01g29G+p4Dm7MgVKxan6m6BS3uuUnoD8Q/YK4vm
 Pjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541726; x=1735146526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wj53VmaKWxtGgzq29nXWsC+lzS5katF9PdJGMMTxpAc=;
 b=p/b+fl23TyMfNkTGsIZTVihyARWxOV8Cdx4bHjzXg1w3Pdv8oaueTJ5sSpzSDAVlK6
 iwcwT9wv2tcLgY1jzTtAtHzuGe0WHhigbYc9pF2HAc8zP07kdG5q7y00OLm5vnbTEzF3
 CkkIbZ/ILtCOonqPfVG7lTleEnIoUYUBMB3lG/BHK81HnqGM3ciOGf3mVzUjL800LoGl
 i9enwzo6c9hyh/3CjzMoOLr2t4vowU5660yEV4zRwYmH8VAgjElP+p82rIQClpEkJ6Ab
 O/xxM37lm+50b8Q900y0FmNaioBAwLG3HAQQrIJO/c6B/U/jLqY5HQqBQkPYbsbgoE7u
 3mOQ==
X-Gm-Message-State: AOJu0Yyojedp7uxmeqqZxUnq9OhvH4BMlvFJuAfTStk2EhJbDQRX3duR
 YK4Avnl68KcjULCmqsA2M75zcM5ncxV+O89mcpQvH71wB7RaSKoErDZlK2OKbao5lrvaC1bpr4P
 GBeZ4Yw==
X-Gm-Gg: ASbGncv2oPOqnkBfjX2dyDVLdZRFgNq68vTzq5hJ48gPYiWN+e0ercJZpaF2X2KcTiI
 J2equAcYx51fVoHGdKz8tTWuuxDq8j+6ITrsS652ObQlbd/DtH9KX2/u6TdjS8Qq0ak3pakQaVK
 8k7XiL8j29v3Rxqzp0FoagfJt31SRs5vU3QzsvHQ3+n7eTGYCiUgcUN3X6K006JFsZD2hfVDFi+
 E68x9nOix4Bhbo4c+7y6Q7oYPtkVjOT2GN0bHLW0vLUfxoyqKnDGQJEQUorwNFRVkiiXIhN4xoA
 TeIKp1S0DjW6XhF87xvqBlKjpmHXG+Mcytdmjmr8P1M=
X-Google-Smtp-Source: AGHT+IES+IWWI8qu/Mln9BUyghDPHIMOGCPG5B75R/ta+SI+35ifI6BWGI+FYCKE43WWkEYNrO4Q+Q==
X-Received: by 2002:a17:907:9409:b0:aab:cce0:f8b4 with SMTP id
 a640c23a62f3a-aabf4956d7bmr312897966b.52.1734541726471; 
 Wed, 18 Dec 2024 09:08:46 -0800 (PST)
Received: from paolo-laptop-amd.station (mob-109-118-46-116.net.vodafone.it.
 [109.118.46.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aabfbbb7a52sm70403966b.58.2024.12.18.09.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:08:44 -0800 (PST)
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
Subject: [RFC 0/1] target/riscv: use tcg ops generation to emulate whole reg
 rvv loads/stores.
Date: Wed, 18 Dec 2024 17:08:39 +0000
Message-ID: <20241218170840.1090473-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x636.google.com
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

The following patch aims at speeding up the emulation of whole register loads/stores by generating tcg operations rather then going through the call of a helper function.
The proposed implementation aims at using atomic 16 byte loads and store when possible and it updates the value of vstart in order to keep the state of the cpu consistent.
This kind of precaution doesn't seem to be followed by other vector operations that use tcg ops generation so this might be redundant.
Also the atomicity requirements of qemu loads and stores get removed if we are running in serial mode (!CF_PARALLEL).
In light of this I wonder whether exceptions could be a concern or not in the context of tcg ops generation, above all when it comes to updating the state of the cpu consistently (vstart).
Any feedback welcome.

The proposed implementation aims at replacing the correspondent helper function, that will be removed in the final version of the patch, unless there are corner cases where it is still necessary to use it. 

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

 target/riscv/insn_trans/trans_rvv.c.inc | 104 +++++++++++++-----------
 1 file changed, 56 insertions(+), 48 deletions(-)

-- 
2.34.1

