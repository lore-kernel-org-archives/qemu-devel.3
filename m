Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082E4C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuGm-0004Ns-8B; Tue, 25 Feb 2025 07:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmuGg-0004NT-CI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:42:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmuGc-0003RL-Ss
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:42:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43989226283so37879305e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740487346; x=1741092146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIDhUxYsRPxggjX3/jskG7TR522mRA/5YzVFSljUKbc=;
 b=bcTAKxBUzmw2lp0hX63nWgTgK+0o7B1/CZITkDWTuNPksGv50voETjPUfkMWZ8OtJP
 tXN5zm4FrE/1WlWVzm6epZWdyyOZqq8nmjCHU+exJ4Ank7s6aPz0DEe4PedYfaRII5N5
 nKJZ9f+rM+Hidct70LxzZp1m4Q/3HBEd5VrkSAnxleEMLgntgH9hSwDXXz+XIHeIi+qt
 Ct5DqCaDCJ1Llhyo4w1phwKwHW8YkPl4wWZE/UCBfdH1cBNp3uvTyoAtYT7A0+9eQJgO
 vKDPQyHysHN5v4nZwd4c3ELaC+59Q/Xf+DX7ES+fRht2Wqg4Bt06EyziV18qf001S7d7
 ECtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740487346; x=1741092146;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yIDhUxYsRPxggjX3/jskG7TR522mRA/5YzVFSljUKbc=;
 b=JLcFeiHmSdCeZNPMCC5LbEvrO7wRMM7XNS5TMIlABV5ya3j+hsvjf57eLNKs/UMkBT
 M4MkABPw6d4mKvXEkrH4LJM8pHsIad/uqr2F0dSB+BswqnyaopfRxGDcZTSU9FhlMoHG
 jo02d/ZS/WMRj97WMsneFjcKa40DUkjiMsh1v2UeT1BusTn/88BiG5HCyNvR/s7dIpuQ
 hCBX8hvSYwS7ywBrGFbFUABU9ThEFVvwkcPAPjWWJc7sCh8xmvZk78E46c1d3aGCEVQI
 H4kDBSiS4nB4DxysmnHIiJHD7aBEqAEqYL6HgE5cqBUj3DbXCtlVaQfRxqZsDChkBXQL
 sK3g==
X-Gm-Message-State: AOJu0YwIt3M6rL5C42n6FswHV6wcTCdXXNtHBiPCjLeQ5LAJMudWcp4L
 xivD2mNt5WZ6SsbdOzvBJjCsmZLp1tMeZOKEbpa8f6CgEI7kSe80e0IfghJsvjU=
X-Gm-Gg: ASbGnctbP4+n1ahAjVdsFvPvCJkIWMgzakpz5dX1dMb67hsFSWBvH/OFcMTKd7Ltr8n
 RNUpLObekPJIt6sBU+qI+C3GhrwrrpVlIzMBP8MH5gfcPL1pbZ8VXdt2fvsE+NatVau3dt5crAY
 zb26KHvJTWK16ZhOAA/pdEpxKPBcia/UIr9aTFfZ3yc47lh/DOdeCcMm1NhOCodrRT4SbFEcp2d
 LQwSey8SpbiWMyDJrB5sHjuOqLIMY3mnZiGdoYU19B5d2JkvqIWi6H3kJ4ZsFSAsGYeYPRhwywF
 vqzaLyRDwhj01uw4BhcVNRm7mV0H
X-Google-Smtp-Source: AGHT+IGDDdaSG291rGFtcwjyICfV+ZSkMGz5+HpO8XV3j8RwRjewi6qaiE4i6J1/IP1NIQAiQiLSHA==
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id
 5b1f17b1804b1-439ae1eacfdmr149578345e9.12.1740487346501; 
 Tue, 25 Feb 2025 04:42:26 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc005sm2143685f8f.89.2025.02.25.04.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 04:42:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F21575F7DC;
 Tue, 25 Feb 2025 12:42:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  npiggin@gmail.com,  BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 05/10] Revert "tcg/cputlb: remove other-cpu
 capability from TLB flushing"
In-Reply-To: <20250207162048.1890669-6-imammedo@redhat.com> (Igor Mammedov's
 message of "Fri, 7 Feb 2025 17:20:43 +0100")
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-6-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 12:42:24 +0000
Message-ID: <87seo25h73.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> 1)
> This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
>   ("tcg/cputlb: remove other-cpu capability from TLB flushing")
>
> The commit caused a regression which went unnoticed due to
> affected being disabled by default (DEBUG_TLB_GATE 0)
> Previous patch switched to using tcg_debug_assert() so that
> at least on debug builds assert_cpu_is_self() path would be exercised.
>
> And that lead to exposing regression introduced by [1] with abort during =
tests.
> to reproduce:
>   $ configure  --target-list=3Dx86_64-softmmu --enable-debug
>   $ make && ./qemu-system-x86_64
>
>   accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
>     Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.
>
> which is triggered by usage outside of cpu thread:
>     x86_cpu_new -> ... ->
>       x86_cpu_realizefn -> cpu_reset -> ... ->
>           tcg_cpu_reset_hold

If the reset case is the only one I don't think we need to revert the
rest of the changes as only tlb_flush needs calling. How about something
like:

--8<---------------cut here---------------start------------->8---
cputlb: introduce tlb_flush_other_cpu for reset use

The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
TLB flushing) introduced a regression that only shows up when
--enable-debug-tcg is used. The main use case of tlb_flush outside of
the current_cpu context is for handling reset and CPU creation. Rather
than revert the commit introduce a new helper and tweak the
documentation to make it clear where it should be used.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

3 files changed, 26 insertions(+), 5 deletions(-)
include/exec/exec-all.h   | 20 ++++++++++++++++----
accel/tcg/cputlb.c        |  9 +++++++++
accel/tcg/tcg-accel-ops.c |  2 +-

modified   include/exec/exec-all.h
@@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vadd=
r addr);
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
  *
- * Flush the entire TLB for the specified CPU. Most CPU architectures
- * allow the implementation to drop entries from the TLB at any time
- * so this is generally safe. If more selective flushing is required
- * use one of the other functions for efficiency.
+ * Flush the entire TLB for the specified current CPU.
+ *
+ * Most CPU architectures allow the implementation to drop entries
+ * from the TLB at any time so this is generally safe. If more
+ * selective flushing is required use one of the other functions for
+ * efficiency.
  */
 void tlb_flush(CPUState *cpu);
+/**
+ * tlb_flush_other_cpu:
+ * @cpu: CPU whose TLB should be flushed
+ *
+ * Flush the entire TLB for a specified CPU. For cross vCPU flushes
+ * you shuld be using a more selective function. This is really only
+ * used for flushing CPUs being reset from outside their current
+ * context.
+ */
+void tlb_flush_other_cpu(CPUState *cpu);
 /**
  * tlb_flush_all_cpus_synced:
  * @cpu: src CPU of the flush
modified   accel/tcg/cputlb.c
@@ -414,6 +414,15 @@ void tlb_flush(CPUState *cpu)
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }
=20
+void tlb_flush_other_cpu(CPUState *cpu)
+{
+    g_assert(!qemu_cpu_is_self(cpu));
+
+    async_run_on_cpu(cpu,
+                     tlb_flush_by_mmuidx_async_work,
+                     RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
+}
+
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxma=
p)
 {
     const run_on_cpu_func fn =3D tlb_flush_by_mmuidx_async_work;
modified   accel/tcg/tcg-accel-ops.c
@@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 {
     tcg_flush_jmp_cache(cpu);
=20
-    tlb_flush(cpu);
+    tlb_flush_other_cpu(cpu);
 }
=20
--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

