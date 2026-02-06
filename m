Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72578EE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3e-0001TE-0X; Fri, 06 Feb 2026 05:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3P-0001Rp-Qw
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3O-0007Sg-2T
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so20865825ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373629; x=1770978429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOoNS+A0pRm92QNLedN5+q4NoV4t+NHh2EAOES94IVE=;
 b=tetvgEYTvtc41GU00ZOEZoLCsz9gBG2xfYsUXj1Za51ul8OsrzatFFL6McA3ETZTy4
 5U8DtGT+vCqEnCLKy5kzvqtP27t5eAhyQHvqkxbbDkCoNFGeWkUREo3ciJponyJI50G0
 cI6ore0xE9U3cJoozkbK7EK6nf2viyg+XlMwJBpBWaNtQ75mw0woNzlAZVW8dcZFZ3im
 g2dm2zjYSYpC4P2RR4dmxot+zKD4ruJRgjZ+2GwI+Ui5zjdauEAOtru6WaKSA9H6vaQf
 K59gmCs9oDFmD27GJsqxrluCuvaNoumPo7HV5rfe44DSkS1L9QbB/SQLpM91QsDC1+Yg
 fJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373629; x=1770978429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lOoNS+A0pRm92QNLedN5+q4NoV4t+NHh2EAOES94IVE=;
 b=CWT7R89kTJBN8cbiTLj+v+lXIUjVrJDVbrOVTEaiUECBP2SWPl2XfSo9uBSKwTE8iW
 58tWFXfNixtG5nyo00wVok8k25b1zkBCBNycISgtj3RWUoRjjbj8TYOk8z957re3iF3A
 XMskda2Fzt5OIxniA3qOXGud6zUBP9mGx5paSi3/Z4B9UaXZE6R1lCwDiOfUQ0JxClI3
 G37G8mpR4hJU9rTxYKQJacnuIJKH3EffGjIrigUgz8YzJ3P6JNPKwkqMTEQVhqcUrsGU
 GqNVdICYclv33pb1CWQYJ8uFweX0f/P676i+qhnyG6qfIWdQEX/AkC0Plc1sh+D+1t+A
 VroQ==
X-Gm-Message-State: AOJu0YyR8xkFen/gVGCnp/5BfjPdLNzT5s9sFumxbYk4Nd8V1fcXEX0n
 +c1k6VtnRwaRHtsozq75Lpg0FFfy+yl3/aQm+UD8eNcR/uaMa2DH/Oj/D31eVv9ORAn8udmqNBn
 L+XrJnSiBGQ==
X-Gm-Gg: AZuq6aJyMGEzoG7rE0TvQ+LY8fBNTE58/Hn+36uyZx+ZoNkztgj6cdUsm6rnZZdOCxd
 +TXT/9VEFx8EreoBdyDe7uHXS1JdHU9a/e9lU7jZbCkkBszLuAncK1tHsH6JaHDGY3o9zWtp2nB
 n++5tlNywStzIMK1c5MvckHyk7BSHk4GaFtTrFb3vekoDC8Jx3ICNDI1mR3kYxIUIetobRg0fgG
 Hr/PtTKHdCP2u0zt1/S3Xd6W5oUHRPPUM2FhFpXwYGrfZT5ntWVl0G7h9RGhB8AoV1OGrmeMuy+
 /vHzEP6REAxVQM4LOAbaaZjZjSSWp785hWHqMKldLPbVpmRNn89fCm/KHVroKQ8Ei1Zk9GVdTgo
 22vWlXzJSWpn5ujNX2zj36dMqhcaKkqQrvdbg494pKb4JJrHHcG/jUVKoAk9EEYA2qellvEv8W5
 2dTpcLdDd33f7vQ9q/GLl3i8A78syi928SGWWoepsz0D0wRLucUU2aiJ2RwvyiVwY=
X-Received: by 2002:a17:90a:f947:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-354b3e264e3mr1930895a91.20.1770373628647; 
 Fri, 06 Feb 2026 02:27:08 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:27:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Andreas Schwab <schwab@suse.de>
Subject: [PULL 4/5] Revert "tcg/user: do not set exit_request gratuitously"
Date: Fri,  6 Feb 2026 20:26:51 +1000
Message-ID: <20260206102652.164018-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
References: <20260206102652.164018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

This reverts commit b422a7bff64eaf55b8250225533ca1df42c3777e.

The reporter says "The commit breaks go; if you run go build in a loop,
it eventually hangs uninterruptible (except -9) with a couple of zombie
children left over".

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202091753.28459-1-pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7c20d9db12..ad94f96b25 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,7 +751,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -759,7 +758,6 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
-#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.43.0


