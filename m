Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A507C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRez-0008L2-Dy; Wed, 12 Mar 2025 15:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsReo-0008KH-K7
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:22:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsRem-0002Uu-BA
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:22:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so968755e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741807338; x=1742412138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UHMiH010S4aan6Gt1Wj1vvKZFHwFsnIHu+Ji39csrbU=;
 b=Mf7ol72zZ0iqvx0hKVN0EpPmmbF/nmeg0wdRFz07JYbazfha16B7mnquliHwIjBqbZ
 gKy2p13+5z9Z3DEPUClIP/jWhCB8i1FuUxMLLEcoU1PdWOuMuIf35nRsvAq7Ryn4Pzmn
 be/BzexpFM6CFbEUKUBynH7zYnWlujDemODFbHw8kcVTRchQrsQMJy83Zkd2NQzNaoC1
 gRP/Ep5TV887od1O+ZbgIZ9BBfZp2tBrvoswGc5PwOju4ATrvZnDeleuHu8PgjJkqMyc
 icck+l6rsPtd0LxH6G6T0Oq8ZQOFkWav+Rh1qdfjbO6bGbkEp7hC+pRervTskHCwjYpo
 7iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741807338; x=1742412138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHMiH010S4aan6Gt1Wj1vvKZFHwFsnIHu+Ji39csrbU=;
 b=QJ+mJN3tpeR4h99rufn/ks3Ckx+3ue+8P7azfoR6cOWADmdCZdzkoiuC1LmhbJnYnr
 NURZVrEge4I5r0KU9UHrglLNkRkK6pdrt3p5UVH8wJHwUE2HIza7rnht4CAXd8cMakG5
 xavAHxvMTAB0XEOqgaYwQtIF7xNWVHpaNR6VjJPqpyEa2G7SpiIJRXFwYE9xVuJb0aDE
 kDsN32ZCNH+Fica+L4CbGxTtjWzYmBvQADLSotZZKEyV57O8PICAFe3l7J1IMxQDUC8q
 deSRjxBIfRtO5IPXsrSWSDRqB1no5oCp3RMvIgKSXEd8xMdLUNFa+pjXURuKcKorzZ4F
 EcEw==
X-Gm-Message-State: AOJu0YzBaQAPLn0+Fak3+ha07rzE0i62Rbf6LrM9D+rJUAEvPxfE1aND
 G77xXM28OlLOVnVvk2WZmfoeOgh6N9a/wAi59tuCnT+P0d/Li9CE82jl76JKsyRaw6dghJRIowa
 NZPgCqg==
X-Gm-Gg: ASbGncvMGHF3rbP6pWmp3U3Z6LOW+WRK1S+NYA1aArUdHM0rCaNh9iVwI+5IyVtcVXx
 HUi4Xtg/gxHLrO/P7BryHyfn6z81Y5RDvesGLDG5bJAA0jgRlUEcAG2cugLNC+AoZzisf8Gng0V
 Kib9o508C4eGBSGNuX3IoSzIYucU07P9QYz4NXUtJvUYox3RKgzHNR9WCmDLnIZ5n/jhVwjWgzt
 BljE4V99fIBUCCRNZwg8gfeak6KrOT9vGfMnugy9PSN6Sg/e3ZOsgg5tAB71HNykPnPaTGWP3Ws
 O4i8L0sRiXpmGQ+rCM0QYJfbeLFyxEOME/7R9pAmRPqUzttJauS4Ets++6KJHes=
X-Google-Smtp-Source: AGHT+IGznpOyP091qVaQkFRrlM4lddX/xtiWB0apWHnXssKXOkONI7RnwPFBOEAGRhopTFqUD4tJBg==
X-Received: by 2002:a5d:5f84:0:b0:391:300f:749e with SMTP id
 ffacd0b85a97d-39263affb8bmr8761091f8f.11.1741807338187; 
 Wed, 12 Mar 2025 12:22:18 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:3f9b:7278:8381:286b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba686sm22331645f8f.19.2025.03.12.12.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:22:17 -0700 (PDT)
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
Subject: [PATCH 0/1 v3] [RISC-V/RVV] optimize the memory probing for vector
 fault-only-first loads.
Date: Wed, 12 Mar 2025 19:22:14 +0000
Message-ID: <20250312192215.318565-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x331.google.com
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

Adding reviewer information to the patch and rebasing on top of master.

Previous versions:

- v1: https://lore.kernel.org/all/20250129144435.82451-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20250221155320.59159-1-paolo.savini@embecosm.com/

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
  target/riscv: optimize the memory probing for vector fault-only-first
    loads.

 target/riscv/vector_helper.c | 103 ++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 45 deletions(-)

-- 
2.34.1

