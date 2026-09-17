Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F2FC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Rv-0001yL-WC; Thu, 17 Sep 2026 04:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Rr-0001xo-OK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:29 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Ro-0002va-0B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:26 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso552778a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633581; x=1790238381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=difu3tNp1WFr+WMKW3psTQsOOfX0wTv8VvOf7h772T4=;
 b=ugmWxGs57e4biDIVhCglriyMYQ/+oMqQ7YtO9KRcb+xcq21suwWdIJYvbbAFPb1wPC
 yhYbtD7LEP3HkuiD69Lj3322Eicg23gUD+t3c4eXjMUfbPvKS+M1AbGwrdsjGVJZAGn2
 MZONiafKW75d11/LcXOnzv/bfZYj0Imtjk23nS5Nm9t2jHGPBINMMO+/TNt3ey/Qs0Oo
 yuIbs2Rq3E2U0goF9fJFMhxqLdiiEJ2QakOBKFto7NAql20Sc6sLB3FnBCl3Gr2Nl/Sb
 tH+oo3mQT27V9V1+CgXxLlQ0fASIGUsGFTvX/xQIqHvD2WwLRJ9rZubwtbPLAqytaojs
 8ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633581; x=1790238381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=difu3tNp1WFr+WMKW3psTQsOOfX0wTv8VvOf7h772T4=;
 b=1mzVacfgqD4h9kWBk+dddTUbTeUjHarLQhAxq79SIKJP3FAPoOtlm8e7D+lBIkdXvt
 T3QVTVqzzULZh7fa47Gg943PKX0H00ZFe0T+IOcFdZfI/KmBv+DKlfb8bVrDB5CTbip8
 QWPIpzMxGaZYsHkAk1dCaGqtUv225qEqWLv96brLC6bMYytdQCxRNgNEF9H0hvOTTeNk
 iTucdPTkfhDEOEzQEKJZGUlean3/NSR8FCbaPmSdWfDUFYzq/+dg5K8spdnrC0bFmWYc
 KXzEyWDFJ/TJw+RH+pAPkNN5bIFnRc+WfaeNmxFXggrK6x0kIn8hI/ynjWHRsUteyil3
 JYFw==
X-Gm-Message-State: AFuF++mkBn9PtZ9psaZnPl32akybBJ7/0NG/bzSaOtbxX4b6muW4DqOH
 nofBwHUcblK0BQOdFr5soKb2Kakob571bgEZzytg7T1p0/B63I20bOfyezM7wPDeZM5/+OL11OI
 1wx85Als=
X-Gm-Gg: AYBFou0dchaFSNgH+wprfHgAAH3JiJAsNo/mUAcOWp5OiWiq/SBQTgZdaic07iHYdeS
 lZICRULm7o6U9nIqpVSOMc1LQfTGFXHUgWLUG8AT4886CX8ZaLfPSFzL+vxgXv7Swe3vmWz32wt
 AEVmFvIW1FAMB6YAmMuaysTaGj+FYQzvqlglGrlVCPySiziMu1PQSISvW5zIt4rR/bHKHH7SBjI
 tQEa6iKvrdH9HvlTfhMmreSSvDEF6/P9KOZZvXSI0PS2O3FjccTEqhSUbExJYrTXT81zDROY6Nx
 Czyfpjf02BucLdDxTnIJFzv3D+bzKiEDhg/5F4ci32dCfu5CE49YyVyXoNapJXdOpBxYx4n7J1W
 HYKpH42ZUvQ40bvtptjMFeknmtpLYihzYw/8PvNbfbOv7E6kw/ENhvPMHzqEbdx8V42PDrWjaA2
 f097biuf/U9m7UuUIvwowPRaO2PHnhZXMc3hgauECxCP2eEVUhIDHjeGin/x7O04DQTjDpxhNtn
 Ff1TwA=
X-Received: by 2002:a17:90b:5388:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39e1e55f7c8mr13835009a91.8.1789633580960; 
 Thu, 17 Sep 2026 01:26:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac978esm13484357eec.18.2026.09.17.01.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 0/2] accel/tcg: cut per-block dispatch overhead (part 1)
Date: Wed, 16 Sep 2026 22:26:16 -1000
Message-ID: <20260917082618.1076988-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Splitting Matt's larger patch set:

> 1  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
>
>    curr_cflags() recomputed three unlikely tests on every one of the run's
>    8.4 billion dispatches, from state that changes only when gdb enables
>    single-step, when one-insn-per-tb is toggled, or when the log mask
>    moves. Fold each into tcg_cflags where it changes.          -5.15%

Changes in v6:
  - Use update_guest_debug in system mode, rather than a tcg-specific hack
    in cpu_single_step.  This would also be required for split-accel, if
    and when that project gets regoing.

    Unfortunately, cpus_get_accel() can't be used in user mode, so
    fix things with an ifdef.

  - Hide other cflags updates behind tcg_enabled(), so that even if
    tcg is built in, we don't use it when using virtualization.
    This also means we don't need stubs, because tcg_enabled() will
    reduce to constant false with --disable-tcg.


r~


Matt Turner (1):
  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags

Richard Henderson (1):
  accel: Change AccelOpsClass.update_guest_debug to void

 accel/tcg/internal-common.h   | 11 +++++++++--
 include/accel/accel-cpu-ops.h |  2 +-
 include/system/hvf_int.h      |  2 +-
 include/system/tcg.h          | 12 ++++++++++++
 accel/hvf/hvf-accel-ops.c     |  3 +--
 accel/kvm/kvm-accel-ops.c     |  4 ++--
 accel/tcg/cpu-exec-common.c   | 33 ++++++++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c          |  3 +++
 accel/tcg/tcg-accel-ops.c     |  2 ++
 cpu-target.c                  |  5 ++++-
 monitor/hmp-cmds.c            |  7 +++++++
 system/runstate-hmp-cmds.c    | 18 ++++++++++++------
 12 files changed, 84 insertions(+), 18 deletions(-)

-- 
2.53.0


