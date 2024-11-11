Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124DAD2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 13:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAU4t-0006fu-QQ; Mon, 11 Nov 2024 08:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAU4r-0006fH-Ok
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:03:34 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAU4q-0006Hi-0n
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:03:33 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so2677549f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1731330208; x=1731935008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1+3Y9fA88Q5SrhGJAp9HbCVKGDgvbtPbKpfCsaMsFD4=;
 b=bL1OlQ32hNG/Atef9wmjccXXr6DKdDHkvXWVYbHA9XnRfesQwmPQJ0D44xPE6I27Hg
 7XHzBL6Qb1MdDRLcaejaAJp640jKO/jV2dtA+orIf5RjyrgiYJbWJZ8qOm42zQcxaoQP
 AHeJl6k8aOLpinrKLl9AzDZ4GnOTmp0BekuZsgTqbJj60nm9fFeTNZYsYJMubPXHRghq
 Io/Gty6ZY0FX5HhXBiDRzPebsDiBn5ToRtYn+SojGXZg8dmygntGkxVVZ/rBvkbRWDJP
 3cYV3bb/skYTTsKN6UK63Tz0IPdhHrzCRFLf4tBCDpIIku3WYuzz2sLp9WkaV92EPySO
 X7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330208; x=1731935008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+3Y9fA88Q5SrhGJAp9HbCVKGDgvbtPbKpfCsaMsFD4=;
 b=LxeesVHElroAygsB8n3PJikC0haEkHC/CdfL5v50QNGBUpzGvY9lG4TQZyW2iQOeIE
 yfeObZJDQHRScgoWQwbAr7wvbzQd+4nn1p/PZ0Bf8+Y20dSHPo1dhNWwr3C2U2Mm8oB2
 KD/X/OP82rD4N0angZIlAnqUYk4MRm5BcPYVua4xrzpIxhJMxAw8caUfhmoGxvwNDRrY
 Ez7/ssiPMJ9nk02VsF+oiRpkL/6RDDXDU6fPhrrdHWwixQ0pndl3Cc74BdSORGH1TMxf
 iKeQX9j3idy616NVbrMBGvMg1aH4KTldqErOsMd5/RSfiTssunx0tWH67awh7BcfqBzu
 AddA==
X-Gm-Message-State: AOJu0YxeYIvUZjKcEBfzdkdPcZrXZhCBD5ZvvjO/1MVOBCtnnXZ2uTqB
 rX05hOrRkVenD87wmgVAHyU7DM8XBbTsG7iPSWd1J/1i8eoL4VagKBoYCFe8Y1H9RX/fUFLc8/C
 qsqI=
X-Google-Smtp-Source: AGHT+IG0MwqmB9PXLjra61lAlD/iSuRTxgek4uOmOTyWbdJaTksHotIYM7PaKDUf4oCaLMDKtuHkMw==
X-Received: by 2002:a05:6000:18a8:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-381f188130bmr10161172f8f.39.1731330208327; 
 Mon, 11 Nov 2024 05:03:28 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5d1bsm178611505e9.40.2024.11.11.05.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:03:27 -0800 (PST)
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
 Max Chou <max.chou@sifive.com>
Subject: [RFC v5 0/1] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector.
Date: Mon, 11 Nov 2024 13:03:23 +0000
Message-ID: <20241111130324.32487-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x431.google.com
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

The version 5 of the patch set splits the patches into independent submissions
so to simplify the review process.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/

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

Helene CHELIN (1):
  target/riscv: rvv: reduce the overhead for simple RISC-V vector
    unit-stride loads and stores

 target/riscv/vector_helper.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.34.1

