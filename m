Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D2C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYA-0005Ng-El; Wed, 24 Apr 2024 18:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY7-0005Mc-LO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY4-0001lc-RX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so321529a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999427; x=1714604227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w21pcEbv3KZfM/OcgeAu4UL167cnBeylLbvFPmblREA=;
 b=yC8OuspVEZ++lZbIb2MwYUUAoK7sl3bjHDyCSJpKnRy8aJiC8KJEn1tO2ddiLxd60K
 N3juFieYMjL/ctiV7E2lmqjZSA9EsnhDP/2r+81YLC9Fyy0FOBpAXq16sb15/lG3ppWu
 Z3PU7gCMb7ENEHbedpJLAuLCu6TT2eRtEsjMSGK/to73C8VrgqQbp0a2Wp0i0m04TrFO
 ZWnd9AR4SjMMXEX6lpCrtM6N9cmZVQGBoZdnre+kyhpxp7XTZAmB+gdxXpnSB1Uj+5QH
 Qxc1xsuqsVczfEBIR9q/MgMa/WP+Mllro3leQvgLh3r2Loqm+3tE6LgiOPcvz96PXs08
 oyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999427; x=1714604227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w21pcEbv3KZfM/OcgeAu4UL167cnBeylLbvFPmblREA=;
 b=LjyjQvI8oOoWxYwA2rONx6ovh+B6DMW55UOyHe5NjTLnoLKMBoFSUv/EEKN5ivXyu5
 /7wHR0hVWuHKzO+XT/s3+d9FnYyuVmTogKQzUyQf/YA0+Caaxm6fMmAGm+tNwHbK5ExJ
 oGB881mnS4gmGuzX71ZpdHCPjFcdCVoxkKnZAHtaG+ljMYepsPoZ3yKN4bb+EKqZhMUE
 KM3vXYOmPx0cT8UOWYEgCkg0D6iWU6iGyc78jGbeAwY6mFBX3z//lzTuS3198SdT0bKs
 AS79O6MpAjf4QfPzYcrjeM1fk3smPcpDgF1FkPOl0JPeCAYgxuMX4euGz9DHpLTiPD94
 F4ag==
X-Gm-Message-State: AOJu0Ywroi/u2DOxE61/l8H8bEZzBKFwegiUfTdGXnAJS8TwNlrsPfHQ
 Tcl1W2uVJOVta3rxNdiDIgPIMIg+MNRnIDJunKc9itCBTiROUWId/m5na0SyfeMZ05wSE/j+N67
 Q
X-Google-Smtp-Source: AGHT+IGG2iwJwhHA2P7iU5Ud5oxZ8dVnpKeWQNrFsGcUg9MIxOMa4RzmbjkwaO3VowfLawCByCd2tg==
X-Received: by 2002:a05:6a20:158c:b0:1a9:40a1:a4e9 with SMTP id
 h12-20020a056a20158c00b001a940a1a4e9mr4867759pzj.3.1713999427111; 
 Wed, 24 Apr 2024 15:57:07 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/10] Optimize buffer_is_zero
Date: Wed, 24 Apr 2024 15:56:55 -0700
Message-Id: <20240424225705.929812-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
v4: https://patchew.org/QEMU/20240215081449.848220-1-richard.henderson@linaro.org/
v5: https://patchew.org/QEMU/20240217003918.52229-1-richard.henderson@linaro.org/

Changes for v6:
  - Fixes for bufferiszero-bench


r~


Alexander Monakov (5):
  util/bufferiszero: Remove SSE4.1 variant
  util/bufferiszero: Remove AVX512 variant
  util/bufferiszero: Reorganize for early test for acceleration
  util/bufferiszero: Remove useless prefetches
  util/bufferiszero: Optimize SSE2 and AVX2 variants

Richard Henderson (5):
  util/bufferiszero: Improve scalar variant
  util/bufferiszero: Introduce biz_accel_fn typedef
  util/bufferiszero: Simplify test_buffer_is_zero_next_accel
  util/bufferiszero: Add simd acceleration for aarch64
  tests/bench: Add bufferiszero-bench

 include/qemu/cutils.h            |  32 ++-
 tests/bench/bufferiszero-bench.c |  47 ++++
 util/bufferiszero.c              | 448 +++++++++++++++++--------------
 tests/bench/meson.build          |   1 +
 4 files changed, 321 insertions(+), 207 deletions(-)
 create mode 100644 tests/bench/bufferiszero-bench.c

-- 
2.34.1


