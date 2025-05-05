Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119AEC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl0Y-0003pi-9X; Sun, 04 May 2025 21:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0X-0003pE-6A
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0Q-0002Td-5y
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so3406976b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409949; x=1747014749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=DA67N/G1lH1RyVtwa7WUQaqF3lGNSG3b3jPHxk6HyJUZadAC4ZY5ojAPtpXCtFEx+3
 mKUFxRk2KAEez0t56hmmdX65rwyRNn+JoTdNbVMpY2FTo0JNslrDiInV9D/VXMaLPcII
 TM1xGunEa/Qs/y8b8af5l/Rq+Hi/j1LUiganUEW3Zq6m78AXuh+Rzi9tnMvJHf9cKF31
 QdT/GccIzf9VINcjUg6EdJQnBc20PrfCHjv/7oQshPSei2hnYIVYOP7Ty2svHJaGMIeV
 EH3ckMv1a31/sWkNpJi4I8yAR0VFGFViTNvndvL2am6TkZMV+qNriUZtytylkSzZ65iX
 YbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409949; x=1747014749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=rbfifRr3fugeEyKryC7Fn3n6PXGGlppAveBxao8gv3n5esyXzKiXPu8mHPOlhGEsOV
 mihFhDFRnNJOfFf/JxbjSO+of+xGmei5urRlgi9pZMRYflqCphg53f97nHgBCaK/p1Ty
 mj73+adMgkp0X6S2vpTXyU9Wt0YugrwEVBhZ4uHT7z5k4XENZ1u3D54EozMHMzqx/H7G
 XdPQvP5h+lBua/QiqZY9FzvYpf2enEGD5iBSY9NCFd9UPbpkBqHvF96bzKvuveJHtHog
 3XHeASidn5BeQ/kiizrtMzLOGQl7apwPR+esfm2EpQzybOO5D1dZCYcYuFCN8ve6iuRw
 svZg==
X-Gm-Message-State: AOJu0YwcInAhmdekv234xEtKKLKxvBG4+mDiyDfldS0zdK4NMpEqGjFm
 mV41ubrPBbMudUaGsk3VLq5unB8CgAI1IdBqL7Q1+6HBdGe1CfIj3ddUwgEON5/AB1XOPvvIQPF
 mo7E=
X-Gm-Gg: ASbGncsXRQIM6yh0DRy2YSp8sxS2Y3sVeeeS+ljyfrit4h/OPiCN0zcC4luUQBoFIcZ
 b/4FM6057oYkKKM/N42u3tXATE7k05j8p2tWM0V8ugRaFFxZ3gxlzTi/ccDQqbLC9fGxguP+29l
 Lc49zmPy0gi6eYa9d7dm6gKOZDw6ddmzXYfBsdU2yoWVL5Ipu3Wmw6ZZlBDiqji2M+UVZbcxdHI
 jAGCi3evnlP/aMLzeruK5LBWZLbuht4Np8kLi2iCyhZ47gwRvUKX/rUo4DYlWUcK/RqF2fprJBA
 hjCgHIpqzBuZzm8CxPdAk2GAegtBx+tEONHwj5ON
X-Google-Smtp-Source: AGHT+IFC1SHa+o2dht0iDyRVFrIxZhJ91FqkHDCIfZcHBadorNJvzlHZJmoxbvRhIrg0G0wVvQGeMg==
X-Received: by 2002:a05:6a21:399:b0:1f5:8e94:2e83 with SMTP id
 adf61e73a8af0-20e96206067mr8026628637.8.1746409948979; 
 Sun, 04 May 2025 18:52:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 02/48] include/system/hvf: missing vaddr include
Date: Sun,  4 May 2025 18:51:37 -0700
Message-ID: <20250505015223.3895275-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


