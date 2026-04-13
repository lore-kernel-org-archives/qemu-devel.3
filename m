Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B0F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQJ9-0005Il-Az; Mon, 13 Apr 2026 19:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQJ5-0005I4-4T
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:03:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQJ1-0005AC-R5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:03:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso29016845ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121378; x=1776726178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sIfbA9Xm428AoYAJwzWkfIAHFnAZAB7Jc1Vpoczc/W0=;
 b=RUbR/sxfSu7e86gjoH9KRhxr2bHBqsZtHRl4neIjH5h/l+mARHGjVXo0y238qc7eo9
 OqmgPTjALbj1KZBBfRxLfE6/HgN+BRkCHAQBevywpHDSA7vU3HbWfeOhjpkqxH69/MIC
 FgkmPdPR3aoz5nVlrFBJRRffQ41TvAvXMP/l2xLYr/8f7dOr/XxlDvm92N/z6ISCisYV
 5Td/91HdnyUYCtqwZ+IOW5ztphwxXOrMV72d7eNDFE3zF1reWTE9HqDUoSTnay6abXCz
 +NpmE4TGRQPOW32AQXvduaxyqSpnNTdWO/6/1qlleAmkwnAXDWyCjFD1fjWPejsczMli
 DTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121378; x=1776726178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIfbA9Xm428AoYAJwzWkfIAHFnAZAB7Jc1Vpoczc/W0=;
 b=hk4JUKfBqO3ckUM1he8xY+X0ZF/YT3BoCo+OOTVkpKjC/BLC6UI6Bd+Lnd+PW+iWuM
 t7uHhYRwqdDXegcXlY/gFvoN+rcmU8i0X/C8+FSCL66n9sZP3iqMjv3hf5LOnYh7eSLn
 PVxv8QwWL54zOg5vRAPygWGYBWnoKAsX/aOdP9zoLddTMNQoVH/Ead2EHc//gZ2xuyDw
 JhKQYbuyDBxR0Gbz4pJa9bN7lz5ZOTORREpYrLQScQbBkTQsyB9o3SZxQrotOd0TWL51
 geLD35IQnxHtbzDqCdglglI6Loagn3pcKYNLc1RVj2fSpxcClnytHCIxm5XBuUjW4ax6
 Dgvg==
X-Gm-Message-State: AOJu0Yz1kaAFMyDr3ft9f1DoLqcqfo382JGuFh8A5lh6PM2hDMcrI5iP
 beUrURtFDVmQzcmZ+dDs1YDXUk3cCkM4RScoZoFldhDebW4EZPIKg0RJUVxC5LR9hGW6VcQYUKH
 StSjffAA=
X-Gm-Gg: AeBDieto3t84JM2LOUnp/nwwQHDcXfYIQv5ul6xnWSV4nwtTn8fJVPvnlhnubzc7DIr
 4ITraG/ye2dlAFwPGgy057XQFtsucNaGQXs6FyDgGTNOQR8ZdV9FYyD/Wg/9uWpFRwP2yFc4syw
 9LxxJ1kICksCYUU4UnkxFSYZiqgXziRQS1kgSNOAJuu0FYtSwiUygG34KChoSix8L+rx9cxaEUl
 9Hok7gcHsa1yB2WfPOKc0Z1tOGuXoNtcByr970hO9uE2Jvz3QWqnmIDrgI7D0WsgkvVgB8dMhd4
 mOWlwgF79LY9v3oqWzAZSkaL0+Os4Hmdv2x4ckmHnYTv/8TbzXHpulQdh1/8p/RVbVkK3+Y2909
 i2SIbsMbS+Pa+kyphHybTS9mO0XUPt39+qTm0YeRzrLJUxWa+u27GZYBR99xvHgfc+i14Wa/G8C
 UYYRuChESosfXoev7Lf4YAaxMr1MVPI9e3fg==
X-Received: by 2002:a17:902:ffd0:b0:2b0:4f16:22f7 with SMTP id
 d9443c01a7336-2b2c73474b0mr163755095ad.16.1776121377694; 
 Mon, 13 Apr 2026 16:02:57 -0700 (PDT)
Received: from stoup.. ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4db008esm120507675ad.16.2026.04.13.16.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:02:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-11.0? 0/3] linux-user/arm: Deprecate nwfpe
Date: Tue, 14 Apr 2026 09:02:48 +1000
Message-ID: <20260413230251.22537-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Deprecate nwfpe emulation.
But while it still exists, fix thread safety.

r~

Richard Henderson (3):
  docs: Deprecate linux-user/arm/nwfpe
  linux-user/arm/nwfpe: Replace user_registers with current_cpu
  linux-user/arm/nwfpe: Use thread-local storage for qemufpa

 linux-user/arm/nwfpe/fpa11.h | 25 ++++++++-----------------
 linux-user/arm/cpu_loop.c    |  2 +-
 linux-user/arm/nwfpe/fpa11.c | 12 ++----------
 docs/about/deprecated.rst    | 12 ++++++++++++
 4 files changed, 23 insertions(+), 28 deletions(-)

-- 
2.43.0


