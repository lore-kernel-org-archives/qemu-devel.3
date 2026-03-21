Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C9A1094482
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3xak-0006yD-47; Sat, 21 Mar 2026 10:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xah-0006xq-NR
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:15 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xag-00013I-2X
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:15 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so1890941a91.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774104373; x=1774709173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DC/92mQROGokmocD9i48NnoFb4+LLsoIAOSWd43L804=;
 b=T2Fjt8G2R78wStMXLKm/e03app3bYTS//Hnmhy4CT0HIBRd2Ud2GbXXmRyDEgSIk0c
 TUCuyA/MLHWI9rqHkFwQg4PitLLc4EXZ3Slb9AYO1O8feOo6U9hQywi6wSNN5F1Of1pQ
 prOeT8CI49m2j23NfFUlUYNsFccdpqDVtwKO8qW5bQAt0Oh1pTKoYMROaB6yDxyrtkRZ
 F/wxA0N/O8zhTRdLUlHg58AFvBOYfjbMANQ0tTtX+/iQehPuwCoVGXxx+hrpYeYefSJM
 gfXufdOymyhnfxUUE7o+/vJ3u4mJRDTYLSo2CUEVCeyadRaqg904+E7GQP/dbZeD1OyL
 rqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774104373; x=1774709173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC/92mQROGokmocD9i48NnoFb4+LLsoIAOSWd43L804=;
 b=KYIiA+Ot1+VuRuvMP+V2vuG+xImbqk1JuP/yV6uDuNw6jxXWfJwRW8KCai64uS8goe
 kT+G5ibZ63zr1EcPdNVYjZZnRYf1mT4TZGjrDP4miZlvVLULJ2kHF7ATsS/LjlmlxnfR
 teZdEIhAduGJYQ3Si/g3pY2u9nReZB0oJs+tpjw96jaIRW4zr02eXGtQIFq6JUQj3Q7v
 W4sVQRS/XV+zNkNjOIQHhMhHDNMhmygFzZJG7aBTF3vT/kJSDSfjK4vKgca47HLE3tJW
 QgCLvu7mIWqUA8SMjP8w7Vc19jEsV5ulXeRXIJGHdnbV8WHm7mxNHuXkRHRLbKn9Vmk0
 TbOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFY5M4FMcT2j7QkFmgaDQCscJlkM8OJqzpsQwOUq3ltUiO6B7mBtlpX8OU6h0D4a2NbecgsX1oT9tO@nongnu.org
X-Gm-Message-State: AOJu0YxL4ikdQZovXyuJVQk0M+BT8RzXAPn/rNlYzej1KOl/wCTLZPro
 wluM/0ttNJ4KsQUugAin0rTscy3qP3ocxZAjSMP5pLogw+q3/+Kd04z2
X-Gm-Gg: ATEYQzwZmOLtlqdEohuACylHGpxOgIGoHR6tN1g45WfTkexBcr19xMyon3BO3gdKS34
 noiAhZxA6or1C0feDt01o7Uv7MYkYsoSxcgUXO+hAthPsScDuACYB6ou8c3k1H+LFSwVBKlWlRf
 2gh7bHcIhTo9fcLjApwsWDqVT83P5IfzI4KZGqlW0EnrR1Stt5VJndKeAhW5Kq8gPi2PcR0ZLAd
 dqM2bggvmp4Z+RUEzKChMW4V1CI5p0eUiQhebgbPutcugYXpKzut/KyZGbS0MxTUDTBLQMSCV59
 3g7X6PfxEkVwnVKD5Xku5BYtgC/lanCWHxD7KbM40BGrGaEQ/0fTvupyB7ND4CgGAnmMMA/uy7W
 AIqqR3XeTIJLzSXrsq31tvP0smtzzG5avbiJqiMjcaEFGfHw7ciaUbOItpNycoJ2YF5E6s9e8Dn
 GTblNOnJrSKZDSOgBuCGwBE9ghBATZg0hnXLUUt2B0Yt9Om3eAPiBGA/8yyOoTima1ANTA
X-Received: by 2002:a17:90b:17cd:b0:35b:9255:47ef with SMTP id
 98e67ed59e1d1-35bd2d1ba03mr5697763a91.27.1774104372699; 
 Sat, 21 Mar 2026 07:46:12 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd24f1b9csm2283060a91.0.2026.03.21.07.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:46:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 0/3] target/riscv: corner case fixes
Date: Sun, 22 Mar 2026 00:45:51 +1000
Message-ID: <20260321144554.606417-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes:
v3:
* Added vloxei8.v to overflow test.
* Added store variants of interrupted vector ops tests.

v2:
* Added a tcg tests build-time check for vector intrinsics support
  in target compiler before building new tests that require it.
  ci images may not support these yet unfortunately, but upgrading
  those will be a separate effort.

Thanks,
Nick


Nicholas Piggin (3):
  target/riscv: Fix IALIGN check in misa write
  target/riscv: Fix vector whole ldst vstart check
  tests/tcg: Add riscv test for interrupted vector ops

 target/riscv/csr.c                        |  16 +-
 target/riscv/vector_helper.c              |   2 +
 tests/tcg/riscv64/Makefile.softmmu-target |   5 +
 tests/tcg/riscv64/Makefile.target         |  16 ++
 tests/tcg/riscv64/misa-ialign.S           |  88 ++++++
 tests/tcg/riscv64/test-interrupted-v.c    | 329 ++++++++++++++++++++++
 tests/tcg/riscv64/test-vstart-overflow.c  |  78 +++++
 7 files changed, 531 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/misa-ialign.S
 create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
 create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c

-- 
2.51.0


