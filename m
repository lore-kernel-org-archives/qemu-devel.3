Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69A5C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 18:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thut8-00061D-Fy; Tue, 11 Feb 2025 13:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1thusc-0005IV-Ii
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:21:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1thusY-0006W8-9S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:21:06 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283d48so41395765e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1739298059; x=1739902859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YgfxaiZlhhfQCJXHl6JlVr79q7s3hhX9ubzEA2dV8TU=;
 b=II3I27xMN+tGolhzpAZ+ql46w0ZT4V4TBPEvA8V11TAL+rjBTelOrbAH7bhBrstmeq
 VSqCetU2Ck5GGP1SSP0qhNRUVqo1SK4A3NB+H58ILBIpV96VU1LSeNzvwfgf0qxkBuAO
 Zo00JfMRL35fg9cCh10xsD6oqZjpRL/l1g5yAdIBYxPQGS69OhG8sFWrjtbIXhfEupB2
 UvIUA9dJ2xdQW0ciZ7aJ1y4V1HOB2pZpxwXBPmD8INzXPhpETC0kwwo3LJBMI+YtLuKn
 Nzv6Lgp5Qor5iMNGNEn8IofxqaJnJzIQvrI9fZ4k3rgpPxUHX8p6obnvvh7353X8ngKf
 wG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739298059; x=1739902859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YgfxaiZlhhfQCJXHl6JlVr79q7s3hhX9ubzEA2dV8TU=;
 b=Y3aFBGAr0NoGEp2/UnR6u0b96fSwwyaycG6VIL1bbmscHdZW+Wn3LpC+YVaXdxLT66
 Gb+TP0rVo6J/D+Cogkm9hkfueq/qm4diVQ4HBh6MVKvg0DyXA7m2e3H2IY22qynJRi0K
 0Qcwtpm40EuR00CLCO4nWJsfF7qDEBAB7hwEdOkflBvfFEy6fAUWc6duy2fD4b0UCS6g
 H9YqwicX2wFMxPOwTaEO578D3yLe8OVrfN9d9Fcvd3VOg21fRpjlC+om7RPCJFcy8RgU
 8B7fdkkj4siGAA0UMA05E47tf5wU1PIghavuo6xzVYBlAQXNeFgAikLuMzgEn3HbiDqt
 qc/w==
X-Gm-Message-State: AOJu0YwM7f4O8Q4ZsB/bGhuldrXSKojap52P8PUmI/l4WYrWtSJFCGjw
 43M47/uvz43tRfmDfcXKW2N3H4wJvSi5LgyUhupY19JER98dZaHAw/QHyE+X/oH8g2ad5XqjbqU
 bWAtwPA==
X-Gm-Gg: ASbGncs3S7h4+kBOteOvYuKXA80c7hTVktuqRY5EfearVUwoygNUiAE5y1TdWEh3lC3
 zx9OyFxiJynKkuPeOkH0R7Ju4nDLHauSE4szkblkf4BRaQr5Um8iU15wWzO3CayaQxgjQFiU0U6
 beAbbRhUUs2ucL5kdKyF92nT79ew2useNc1DurMS7i4ciLpucWzIMIeoSfxZVFwM2Z+szo/4CQk
 V8s/tDeHeV5KCCFMoGUI2VHgEbBf9wwcdyjqhZm9L4KwRf6zlQARjAJ1gTForEygR3NRsb1zThq
 LN3d5gosWQNTW8q3eVkel4OQFYjFsfzeyPgtZGXRU6HyaVF59dw6cP1V
X-Google-Smtp-Source: AGHT+IFKuWjC3QloGLJPw+vYjcKDk3OCQXqtj+bTkYhiyCAwBFOndTa5GVV1rpBMkcDMhQ9LgkJVyg==
X-Received: by 2002:a05:6000:1f85:b0:38d:de34:32ed with SMTP id
 ffacd0b85a97d-38dea2d91a6mr7006f8f.34.1739298059339; 
 Tue, 11 Feb 2025 10:20:59 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dccc1f531sm12158749f8f.87.2025.02.11.10.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 10:20:59 -0800 (PST)
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
Subject: [PATCH 0/1] [RISCV/RVV] Generate strided vector loads/stores with tcg
 nodes.
Date: Tue, 11 Feb 2025 18:20:55 +0000
Message-ID: <20250211182056.412867-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32e.google.com
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

The value of the stride of the strided vector loads and stores is known only
at execution time and this value determines the location of each vector element
to load/store.
It is then not possible to improve the performance of the emulation of such
instructions by attempting to load/store multiple element at once while leaving
the interleaved memory areas untouched.
The previous implementation of the helper function then is a simple loop that
calculates the address of each element before fetching it.
This patch proposes an implementation of such loop in TCG nodes so to both
preserve the correct functionality and to speed up the emulation time by
removing the need to call for a helper function.

The former helper function remains as it is used also by other instructions.

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
  [RISC-V/RVV] Generate strided vector loads/stores with tcg nodes.

 target/riscv/insn_trans/trans_rvv.c.inc | 294 ++++++++++++++++++++----
 1 file changed, 244 insertions(+), 50 deletions(-)

-- 
2.34.1

