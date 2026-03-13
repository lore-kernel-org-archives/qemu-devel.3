Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E71106FD85
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vtW-0000av-DT; Fri, 13 Mar 2026 02:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtU-0000aI-Cr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtS-0006jE-TB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so9927935e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382864; x=1773987664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4Eq2da1mX65X0fDndMs9h70LqgOJkk8YBwrK9/ZPlI=;
 b=b21ckhmaSh7s8Qd8ProWLBwnOE8j37A8AmJvQZ+S5hD4ylVQqHdF+oxc0bcBDQ/8T+
 5K0ZqXKejf65aIkGGL6WArQw8CS5F5CrTAmPpVE0HD6KRWfWme02Nl297Cq83B5rUsdB
 9Q4fZhMLnwWDkanuBgM2CPXgz0H6XYtIZVWqxXt4e168xcEaDLh0DqFgBNaNuWqrbu1l
 4lQtzG7Hy8FWB8Nrj2S3VqjZPcdrhXsfRg3/EDmsQQC++JtLAQxDDYBTcjQxACoJVwX/
 jVpBETJXX9lX0p7hJO0ZlYQGyawZeRF/uj2IfuvzVKIRASeY5YA4WmPR/zG3/aLcr2Ur
 6lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382864; x=1773987664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4Eq2da1mX65X0fDndMs9h70LqgOJkk8YBwrK9/ZPlI=;
 b=l39z3sgthuBVc9qxkIuTRAcgY23TBgEwrEU9z5fei6bJEsDqiEF5VyZtsROILIiCFZ
 gNHIndG4I3rnEM0y60QaVhleOtaCyjMuiKCMD40QZFAhoqyj3m7LVIm+TKDXlAqlztkK
 WH75jXvwnMYJHw/ydGtM4Hf3L1VA4R3NXUYRmx1UneONWU/gSVEJR7Rr2hgGwkMkjnD6
 +rBxsiw2VvCH/QhS/qTF+X7MKb7vaapBBkRsZpnYtY8u1CcHiUbqqQsZU4LvwvBEjlt2
 xVDh5nQ3FEsR1iZXqcqJXJs7gkyOh6zJE5510fktxvPqj4hhM46EtpxqpIyW1XRxGNvA
 n+/g==
X-Gm-Message-State: AOJu0YzQhvdYmAHMp1N/yzNklFhK0hoqeEa1G0KzVYo+sxxhle2d6aZm
 kHUJOUI3Dh17NGUpYrMwu1WQmXJOEmPo+IqrgSSmFrO9DdNqsqCtj9wd0ENZ2Jrr0pRsB7P8VjN
 aTtiy40Y=
X-Gm-Gg: ATEYQzxEgI7XWXZnCZxyhVfk8/pA22I26NX6IW7TmgKUie4+3YwH/xS7XTKcVavf0x6
 UbN6TGmU6z6F9mrkwxeMfZjpentgENDvY3MNSLr1zwEiGzpXcI+hEt1L1wdYaPYN/VZN1CKhMNr
 /t9D/jGKfIVCmSqk0j0btAKSORgfr7JQKD7+GVXmYyOMh67LZTs/sX9+eNgr2eDaM1dF/dxecIo
 WlXRRTYOeozIo3WZUkviGQ94/ARAJfbZZ1VXr2qQRmYZcv5yl49HuPYgY4ZOeZbt+hpk1EvfgYJ
 U2oPF99jRhrP8JNTQQ2hVnkhdG5hDW885zOH0bt6bmwOGHOGGhmbLb5MdiYAtRo0lW9J3LMEjIs
 BMlPYJW05kdKwmoLn/xSKb0ULz61Aa0dtKYOpzMhp6dLs97zLMt9YBCukP9SwM4a0OQ+tp5Lno6
 rD0E2v9GrJH9wiVPh9gpLVgNt29yoOvv3BkhQZxMoTQNydgCjdLsrs/Mf8E+42Te6o7ax45dTsN
 3DmCH2RWya3Jltc
X-Received: by 2002:a05:600c:45d3:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-48556705301mr30354735e9.29.1773382864261; 
 Thu, 12 Mar 2026 23:21:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6756e4sm214191305e9.15.2026.03.12.23.21.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 01/38] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
Date: Fri, 13 Mar 2026 07:20:17 +0100
Message-ID: <20260313062055.2188-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..678afe5c8e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.53.0


