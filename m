Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2947E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLMCE-0003Ih-MV; Wed, 11 Dec 2024 07:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLMBk-000336-1w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:51:38 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLMBh-0001rY-DO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:51:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so4889026f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 04:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1733921490; x=1734526290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7DRVhbud0qAfrBBeXAkjxxiV64CObQSqSSiJf4H0jTk=;
 b=AgsoBpPJMcSPzacrzQuoBwk3kNoWN5w/MUgQbJ8mIH0/RcD20MKV+u9xQ+cpn839lU
 +t/WStpur8RxuKVXw8PjP6mrMiyrttaPaZ253MHVWjUTCp4J2A0LKjjbl9KMrRVFetgR
 31/kc/23uaFAzYkiJgY7Uv0exhCZgIpUAj3IrIh+R45DUf50Y3e71j2xa+u9G5wxGLUF
 abI+Z7nPzjXHvNS+2hRVumrNVEDERb2rxygujR3NGqRyEmcHI17NYASNGvy1FgjAqbkh
 oroB4aAr9rhEK7s9bSUMIBzXfMMS+zHhTrYcm4mQaBdGg8e8JLXQysG+L/ANJj8bn94F
 DiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733921490; x=1734526290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DRVhbud0qAfrBBeXAkjxxiV64CObQSqSSiJf4H0jTk=;
 b=w2vr3PdYUj+sc7L32Zqqf04GzDvv00Bts4Oa0GdxflhC7+EJmUV91Ot3SQR/9+mo0B
 5SBSVQCT5uDzSfDE3uWuzPTqrhzfrsWa+stReA/NuqqaeF18vXZOY7D1OujiuLEyf52S
 B/DGW2A2CqaLqbgOtxAkJ2CrH4XzBfDINvrhmI3AAHJdNeJ3rX/XbvZBQpL3ff0IGRZg
 18rzTDxTb9fh3dJB43+y0ywBGDXiQv8aqzungvb0bfHLLuRcrPbv/OLNaZmgujdkV6nW
 ChsX+XMrAnrPAnyDaGsYjixNJshUL1C9dYO2PMTFc4rKVFh3VbIOr8ByaCrc37V2vGmm
 M+ow==
X-Gm-Message-State: AOJu0YzGWTRVPPE3wxvkrAkfswfGNxiotevwS55xEP4FTU8DPmvpteYR
 joFfzRq/iFSFlErEQtow3SoXAP6C9sasAv0yC5elnvKcLWxfeJS/3G+ZeiXFBOQj2eN++rQ1xAe
 WeNI=
X-Gm-Gg: ASbGncsKsA85NJ4WJ1RgP/RbzcT0iu2ggq9pxo7+SZim/uKqUKgwWDynaje4Lqe/DI9
 h2qd+vetmWjSp3CIUxRQ6jgdnIkUqEyTgG4Kci0cWiS+Q6WQLmS1845stILEPWs7Wyf1Tuxrkko
 GJG/LY2AdTOvt8xmThdAJhhIy3xGhiVBDmfMRIRgyz6MUF20aGUQB1+IfAVKuXyJ8gxI6u4cRut
 7UXK+AwoM6bXsF3fviI/sDn+LyAOiiD6T+Xnz8hjzCgY6dW0C72KcLzUotfGnFhO4HRBi+KuV5H
 9gi/gtI2FOb3Xdw16geIfz4254rbUK1zUEnmqB3G6CbXlA==
X-Google-Smtp-Source: AGHT+IF9HOlfsbL1zSs+IEVhAyHVqNH5UbsPCVFBjzmDnzVfJqo1t9oVlPxTmruDuzy204sJaybVUw==
X-Received: by 2002:a5d:59a7:0:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-3864cec390bmr2085285f8f.41.1733921490242; 
 Wed, 11 Dec 2024 04:51:30 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f44eaac7sm120542125e9.42.2024.12.11.04.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:51:29 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
Subject: [PATCH v7 0/2] target/riscv: rvv: reduce the overhead for simple
 RISC-V vector unit-stride loads and stores
Date: Wed, 11 Dec 2024 12:51:11 +0000
Message-ID: <20241211125113.583902-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wr1-x434.google.com
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

Changes since v6:
- Limit access size to element size to address Max Chou's review.
- Fix a typo in the name of a function that this patch now calls.

With access size limited to element size this patch still provides a
significant speedup.  The `memcpy` benchmark from:
    
  https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/strmem-benchmarks

shows up to 75% speedup with this patch:
    
  VLEN | Size | ns/inst (ratio)
  -----|------|-----------------
   128 |    1 |            1.50
   128 |    2 |            1.42
   128 |    3 |            1.35
   128 |    4 |            1.29
   128 |    5 |            1.23
   128 |    7 |            1.18
   128 |    8 |            1.09
   128 |    9 |            1.06
   128 |   11 |            1.01
    
  VLEN | Size | ns/inst (ratio)
  -----|------|-----------------
  1024 |    1 |            1.75
  1024 |    2 |            1.62
  1024 |    3 |            1.52
  1024 |    4 |            1.43
  1024 |    5 |            1.35
  1024 |    7 |            1.31
  1024 |    8 |            1.12
  1024 |    9 |            1.12
  1024 |   11 |            1.01

It is not clear to me exactly why the patch is now helping.  At first I
thought it was due to avoiding `vext_continuous_ldst_host` calling out
to `memcpy` for small sizes but trying that directly in
`vext_continuous_ldst_host` was much less beneficial:

  VLEN |  Size | ns/inst (ratio)
  -----|-------|-----------------
   128 |     1 |            1.06
   128 |     2 |            1.14
   128 |     3 |            1.03
   128 |     4 |            1.04
   128 |     5 |            1.02
   128 |     7 |            1.02
   128 |     8 |            0.91
   128 |     9 |            0.92
   128 |    11 |            1.03
  
  VLEN |  Size | ns/inst (ratio)
  -----|-------|-----------------
  1024 |     1 |            1.10
  1024 |     2 |            1.14
  1024 |     3 |            1.04
  1024 |     4 |            1.05
  1024 |     5 |            0.96
  1024 |     7 |            1.07
  1024 |     8 |            0.94
  1024 |     9 |            0.93
  1024 |    11 |            0.90

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5: https://lore.kernel.org/all/20241111130324.32487-1-paolo.savini@embecosm.com/
- v6: https://lore.kernel.org/all/20241204122952.53375-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>
Cc: Paolo Savini <paolo.savini@embecosm.com>

Craig Blackmore (2):
  target/riscv: rvv: fix typo in vext continuous ldst function names
  target/riscv: rvv: speed up small unit-stride loads and stores

 target/riscv/vector_helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.43.0


