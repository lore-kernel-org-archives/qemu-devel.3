Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA77D3398D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXa-000470-5H; Fri, 05 Dec 2025 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXY-00046I-29
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:16 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXW-0001Xz-3z
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:15 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-88245cc8c92so15809226d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951613; x=1765556413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0aLHEJAT9L3v/eMNICzQ65Pj7xZRVo0LxOOr9db5/Cs=;
 b=Hw2UL1Rz4v+4J6Mqu5wuUm6s8HWym5ralw2/yqLeky4/BDZWkQpyHko0GXOvwbT4ma
 1JuZXG4m17E6NcBnAth4g9dOUTBBWGYxEgAqn8tK2bMsEzrktXCexeFUYw77sYvCcO7t
 msab/n2cibX9dW/W0ymsJ/NsmqvypqCXj++MckeD5yCqOv0QBp91QW9gGzwf6wdErsT/
 Xvqa11hQhlOqjkSV2FkatnnaKY+9PCp6wVlOpQgN4QHh+sH9/SLsYs240QphziNmEnyf
 Odr3EMJrp1hIbLI6CoJ99NtnsvXjslE2J16i8nS8zADB8WG5gCovOOPANgSsR2t2sGXn
 POKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951613; x=1765556413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0aLHEJAT9L3v/eMNICzQ65Pj7xZRVo0LxOOr9db5/Cs=;
 b=I0mjT5lDsk87CuScRF+I/Dv/fwg562ofyNJmQgek82Vnx3h/jeCZZYdcqg9ibYsyzX
 GdmypwJlgJzo4EIfy3BTFud6WOl0v8jCL1Kkcfy40l+FttqRpjlwEraxzB13Q3vH93jl
 zxgkd+zKApSqzi3zrFWerf/FtvDS0L5qG7OVP8abiFcx+FEwuyhAUgYAZHu0DzDJL7YS
 JtnPFdM0IedUtMQhfyGS5ESrmllSGXv6gr/bo4S3iCR4bcBHWNA4Xu1ljdXrcwZk7ZeG
 QpO5LwX/E9KomiIAtwJLUgC6jLf+lkGC/eicb5Iz7VzOSm6IR4h0YMCJ6LngUeyjuu0i
 eeCg==
X-Gm-Message-State: AOJu0YwTn3EO464yoNO/dk6yVpG4t9zEMtmnaNgvMhey1mTejC/rnGOQ
 pFl9vyDSvpdqQAmaRgBoxlTfVA4SnqXW8cKfDq+EkI05bu8/SrxS+mgR8uKl0GcqPPLugS8ZR7r
 UbF+30/w=
X-Gm-Gg: ASbGncvJ9XdKiS0M8QK8JRWdiI876BOE6rOBxZvmE+eP4H1ICJOyhR6YnrpKRfJtXj1
 qtYz51JUCcN3zJLusqbzy/SyaJrxl2qUr+CdjxvHrdrTkfhcZ+wqrWObBcQ1+pKhsoM1t6l+1Qv
 ExjhfyYKaaB8uJMix5MjjdYmSxrlp1d8Fe/Glp8GlYjE10Y9T/676IVAoANRx9/xt06jWyH1YHq
 3vJommRED+4d2Ii67/d5bOtEFNl6LsfJFWwYdvz7zuNjp/NKfUiOxiEQgfUlHWu6XYOfmd9FSlB
 k8NR4t/8g8Lkrp37tUXBaAQmE8cTTiWQx5QsIfDe1nVLVTT4wB4SZ1313Not0A6UQKslFu3o51y
 3V6KCqQ5Wr4gOqAUaRcoBgvyJnmsj11qDKwX1xToJNJlI3GWOpuR6HPTE3KjOvIL5P1c1GcAnGU
 5CnlZjoSmrBMF4m45vXvgx1EqThJi7b/B5YGPw54bRXl5+OldZBpPnz6DMqygL4bXMmIQ=
X-Google-Smtp-Source: AGHT+IEqVOxD9M7CxcVE5MTEGy0F1JXhji+5E3wsceVLY1UNNrD8SqUgH3Xph0+KplM/1xyguRWlHw==
X-Received: by 2002:a05:6214:2405:b0:880:4b29:d96f with SMTP id
 6a1803df08f44-888248a22d1mr104554186d6.39.1764951612595; 
 Fri, 05 Dec 2025 08:20:12 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] tcg patch queue
Date: Fri,  5 Dec 2025 10:20:01 -0600
Message-ID: <20251205162007.26405-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
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

The following changes since commit 864814f71b4cbb2e65bc83a502e63b3cbdd43b0f:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-12-04 13:37:46 -0600)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251205

for you to fetch changes up to ff633bc5d55a309122d306a83d09a4362de28b65:

  include/aarch64/host: Fix atomic16_fetch_{and,or} (2025-12-05 07:50:15 -0600)

----------------------------------------------------------------
tcg: fixes for tci
host: fixes for 128-bit atomics

----------------------------------------------------------------
Richard Henderson (6):
      tcg: Zero extend 32-bit addresses for TCI
      tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
      tcg: Remove duplicate test from plugin_gen_mem_callbacks
      tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
      include/generic/host: Fix atomic128-cas.h.inc for Int128 structure
      include/aarch64/host: Fix atomic16_fetch_{and,or}

 include/tcg/helper-info.h                     | 12 ++++
 tcg/tcg-op-ldst.c                             | 96 ++++++++++++++++++++-------
 tcg/tci.c                                     | 19 ++++++
 host/include/aarch64/host/atomic128-cas.h.inc | 12 ++--
 host/include/generic/host/atomic128-cas.h.inc | 24 ++++---
 tcg/tci/tcg-target-opc.h.inc                  |  2 +
 tcg/tci/tcg-target.c.inc                      | 14 +++-
 7 files changed, 138 insertions(+), 41 deletions(-)

