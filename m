Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC3C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4jzo-00009e-Qt; Tue, 15 Apr 2025 13:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4jzn-00009P-Uc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:22:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4jzm-0006tS-8k
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:22:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso40026105e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744737768; x=1745342568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hS+7/17IBPmUQ+Gu0uNPn+nwDnXuvADVLBeVN8JzcoE=;
 b=D23g3F4BeDRbyttiUCCEpHleFxkG6SYbTW5Me7L6a/V+Bedv+ZQq4E2nPEY1KnLFr4
 GUlL4aYafEDGUB9SYbGp/7XmyMVxjA/i3AZTsIGdLQP1dxX5XDtKnrVy3fa2mglZVzqj
 /wMoyHenwMezSQHA9DoMTlrL+11lob0ItnLTQWFDIBDLG4ES4AJ/+u4aPS7bPHfw7l3J
 Vrf3LCmoSKX2gba9WAefEr88wMnJif2bqRiNcQXGF1kv41Z4bvtjIy7UyJB4zHZGkvcI
 0+8u39qB/RJfylirlnzNbkN2qi6hRt+W9/VreiLSbGu8FsoI9Wbu7h1SoXpbSyjHPNif
 UUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744737768; x=1745342568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hS+7/17IBPmUQ+Gu0uNPn+nwDnXuvADVLBeVN8JzcoE=;
 b=NodeMefzBfnHQ2EPe5mYkZI4ElvreiiHvnA5k0TwQpd3uM3en2q0v8g+5XINm4jiLq
 84btT9uIjyJJa12CsGJlLe+gF9bQ70itszdin/QVoLLoEb3d7hw3txPT0wiLeWKspL0a
 I181XHX4fGEaNWo4GBEjtyxT7erH3cuVh0qWfhQtyi6PPrnPjkk5lnsfCS1GqlQfaAVU
 J9tHnBw2cSDtURjTELjpLsIbm0lv8kgQCu9N25TIMVft3b6eQ0sTg+Af2VYEzA/y9/DX
 5lI1hn82BXwYJRB/Zxcb2oydAhIXwnLTIEtErH3e/lGffyrbUPV5sx9lOnwt7tTk29aO
 JlaA==
X-Gm-Message-State: AOJu0YwGitVgNZcMNib6SFeDJSvHh7MtwSS+pKc6Yp7WtalhuuL/MipA
 BtWW8v2A6yxa7u7dG0r/RVsnPaUOl1gDDQKMpre+FrWzJTIRv/UQwLVD1ga++ZlHXvOAlMwvacd
 A
X-Gm-Gg: ASbGnctmvjj/dARsM2bnbmU7D1WbmJgDyeZ1eoGc4YRJP9lXZB0Cy7ngAiqWYOtwyLk
 5mF8ok4XFiXvfcN48FBE2VlQOe5NlEZKaWEP2waUn+W8MjWaVRPspXn3hrfry7ORCSkIexlDOGR
 TM4zGHMXPGwvBRKgzBfxeoS0XntjXAJD8hBKT9UIbS1AxwAhrKsahhzlRaBVrtzWZeSq8U8F6MA
 i2T+6P3IN4ckRjNvbqzqXxkEVg71riNJA4nNi/QsWsiflYE7GfVIOkDwnAq3D6OxTR360lC6qj2
 GXPwlPPOKzl6Xd1BkH4bly2Z8HcRUGkBdQ0N0zkalEsoW5zQmXKFbxccOLfbIRKH6OcX6oOaWXr
 0MW6kTbd0yXJvta7D9tdg
X-Google-Smtp-Source: AGHT+IGzezxYftR+FUNM4y+radbSKiGslL4/CJvwGsZZrgk9m3X2OH4sIHKdHXWyL+OpHxy6N25gPA==
X-Received: by 2002:a05:600c:3b23:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-440597a14f3mr2394725e9.5.1744737767962; 
 Tue, 15 Apr 2025 10:22:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ce3bsm15185340f8f.66.2025.04.15.10.22.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Apr 2025 10:22:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/3] target/arm/internals: Replace some target_ulong uses
Date: Tue, 15 Apr 2025 19:22:43 +0200
Message-ID: <20250415172246.79470-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi

This series replace some target_ulong types in ARMMMUFaultInfo
and some methods by appropriate target agnostic type.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  target/arm: Replace target_ulong -> hwaddr in ARMMMUFaultInfo
  target/arm: Replace target_ulong -> uint64_t for HWBreakpoint
  target/arm: Replace target_ulong -> vaddr for CPUWatchpoint

 target/arm/internals.h   | 20 +++++++++++---------
 target/arm/hyp_gdbstub.c | 14 +++++++-------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.47.1


