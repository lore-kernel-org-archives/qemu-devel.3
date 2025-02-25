Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F12C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyab-0000hR-DL; Tue, 25 Feb 2025 12:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmyaX-0000gJ-Ir
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmyaT-0004cQ-SO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740503954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1wjH3iDqInf/l4UjmbMBSLofTwgBY4zvD65h79ELRc=;
 b=Af+Wia50/iadmPTPA8/7o1Uow9TjKJeSWBHYme3jJg4zBvD4evZfrM0avt1Zaww9x+6hl9
 o4mABl3xLLbxgH8vrPO9y2+dSMo95NKx1ht9d6Id00XJ7sueIKHA3umb/JvMHlewnZNxcq
 5pdXVGJdkiIcFH+7tj2vPP7k5QS/rI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-CyBoK-ZsOUyeC1TMImjvwA-1; Tue, 25 Feb 2025 12:19:07 -0500
X-MC-Unique: CyBoK-ZsOUyeC1TMImjvwA-1
X-Mimecast-MFC-AGG-ID: CyBoK-ZsOUyeC1TMImjvwA_1740503946
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso32485435e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740503945; x=1741108745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1wjH3iDqInf/l4UjmbMBSLofTwgBY4zvD65h79ELRc=;
 b=gL99iN4kArpKzwfdirQJz5s0VmciAi1urn9bYeWKdO0GwGbofQPNpSyTnn2l8ZP694
 8+h/IYYrigS+HYgk1ulzQFm4tuSXkI6Q43xw4hQscu1cMIIkyrAYkCbNz+S++dTQfmy/
 2MZ2bUTmI/mx2ejivbHHeL3AQ2YHKcmMcg2EG659Mowktv2jhHSgoC4FoG2fmmyrnKzp
 ue9WaDr0dk8GgrSsxNHdikxhiBSpwBHY1l484pocKzqLWpjPXqshAH1wOfvOnY+Fd2lT
 ABBlBCnN1IkZ7tgDjcIDLq+qwUknw+92phv3NCYT3um6zstPgnnpoJfaVhmu8gaRBIeX
 SdSQ==
X-Gm-Message-State: AOJu0YznPr2p2vuNlJzSSur7XbWy2AZ2COWWmAeqxwQ0AApVw0ly8QEL
 Ca07E0rnJE/oZ7IDsB9QDXthZtTs2yxkfsn1mBX3o+mshzDT0DsdcbMJNKQJwEdqEmcm9gLlxLA
 GpI4kLp/5Y8LQohI4+j5VcQNBOBPmSUG48v3CL7cmtpB7Njh8Fbt1
X-Gm-Gg: ASbGncu5e3nm6u+e8h5oWP4N/Ox6m9vP0bhEHPQJrIdCWTXxqAra7X74lhTyMm2uqoM
 03BDrQnHGxPO6NVtDR5VNZ7LUxCkiC7mDZ0I9AfCXWWPcU+7xZMGpJK8PCtNdKQVNm4ttBUIJmO
 bjxTdZW1IUCuWNxDCIM7f4fPMgnwf30JF4cRG8KdFsLUEBMNDnHDCL0UoCotHo+Cu669dGOjxyr
 GOq46tpF+M6BhEYbNSQDw0YX3xRCKqUHkmB2QauGKtZR3Jqa0AneuXd7URf0axZkFdnASVXlyGJ
 H6v5F3S/pg2UVlN3q82GwRIwBRPCO1VpcYpr2drDYuLvM98K+kJGJwnhocrAEnE=
X-Received: by 2002:a05:600c:4ecf:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-43ab0f28895mr31340885e9.1.1740503945524; 
 Tue, 25 Feb 2025 09:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcx7bVDB1LclP1+wAYI3hNE/ATbR/NfJ4omcsh7wTtVG67S77yz1c6M5hbyVD+a6qrZOBECg==
X-Received: by 2002:a05:600c:4ecf:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-43ab0f28895mr31340715e9.1.1740503945145; 
 Tue, 25 Feb 2025 09:19:05 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab153dba2sm32663865e9.16.2025.02.25.09.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:19:04 -0800 (PST)
Date: Tue, 25 Feb 2025 18:19:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, npiggin@gmail.com, BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 05/10] Revert "tcg/cputlb: remove other-cpu
 capability from TLB flushing"
Message-ID: <20250225181903.444729fe@imammedo.users.ipa.redhat.com>
In-Reply-To: <87seo25h73.fsf@draig.linaro.org>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-6-imammedo@redhat.com>
 <87seo25h73.fsf@draig.linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 25 Feb 2025 12:42:24 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > 1)
> > This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
> >   ("tcg/cputlb: remove other-cpu capability from TLB flushing")
> >
> > The commit caused a regression which went unnoticed due to
> > affected being disabled by default (DEBUG_TLB_GATE 0)
> > Previous patch switched to using tcg_debug_assert() so that
> > at least on debug builds assert_cpu_is_self() path would be exercised.
> >
> > And that lead to exposing regression introduced by [1] with abort durin=
g tests.
> > to reproduce:
> >   $ configure  --target-list=3Dx86_64-softmmu --enable-debug
> >   $ make && ./qemu-system-x86_64
> >
> >   accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
> >     Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.
> >
> > which is triggered by usage outside of cpu thread:
> >     x86_cpu_new -> ... ->
> >       x86_cpu_realizefn -> cpu_reset -> ... ->
> >           tcg_cpu_reset_hold =20
>=20
> If the reset case is the only one I don't think we need to revert the
> rest of the changes as only tlb_flush needs calling. How about something
> like:
>=20
> --8<---------------cut here---------------start------------->8---
> cputlb: introduce tlb_flush_other_cpu for reset use

while that works for my reproducer it's not sufficient,
'make check' is some tests fails anyway

ex:

10/378 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test ERROR 13.47s killed=
 by signal 6 SIGABRT
stderr:
qemu-system-x86_64: qemu/accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx: Asser=
tion `qemu_cpu_is_self(cpu)' failed.
Broken pipe
qemu/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signa=
l 6 (Aborted) (core dumped)



>=20
> The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
> TLB flushing) introduced a regression that only shows up when
> --enable-debug-tcg is used. The main use case of tlb_flush outside of
> the current_cpu context is for handling reset and CPU creation. Rather
> than revert the commit introduce a new helper and tweak the
> documentation to make it clear where it should be used.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> 3 files changed, 26 insertions(+), 5 deletions(-)
> include/exec/exec-all.h   | 20 ++++++++++++++++----
> accel/tcg/cputlb.c        |  9 +++++++++
> accel/tcg/tcg-accel-ops.c |  2 +-
>=20
> modified   include/exec/exec-all.h
> @@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, va=
ddr addr);
>   * tlb_flush:
>   * @cpu: CPU whose TLB should be flushed
>   *
> - * Flush the entire TLB for the specified CPU. Most CPU architectures
> - * allow the implementation to drop entries from the TLB at any time
> - * so this is generally safe. If more selective flushing is required
> - * use one of the other functions for efficiency.
> + * Flush the entire TLB for the specified current CPU.
> + *
> + * Most CPU architectures allow the implementation to drop entries
> + * from the TLB at any time so this is generally safe. If more
> + * selective flushing is required use one of the other functions for
> + * efficiency.
>   */
>  void tlb_flush(CPUState *cpu);
> +/**
> + * tlb_flush_other_cpu:
> + * @cpu: CPU whose TLB should be flushed
> + *
> + * Flush the entire TLB for a specified CPU. For cross vCPU flushes
> + * you shuld be using a more selective function. This is really only
> + * used for flushing CPUs being reset from outside their current
> + * context.
> + */
> +void tlb_flush_other_cpu(CPUState *cpu);
>  /**
>   * tlb_flush_all_cpus_synced:
>   * @cpu: src CPU of the flush
> modified   accel/tcg/cputlb.c
> @@ -414,6 +414,15 @@ void tlb_flush(CPUState *cpu)
>      tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
>  }
> =20
> +void tlb_flush_other_cpu(CPUState *cpu)
> +{
> +    g_assert(!qemu_cpu_is_self(cpu));
> +
> +    async_run_on_cpu(cpu,
> +                     tlb_flush_by_mmuidx_async_work,
> +                     RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
> +}
> +
>  void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idx=
map)
>  {
>      const run_on_cpu_func fn =3D tlb_flush_by_mmuidx_async_work;
> modified   accel/tcg/tcg-accel-ops.c
> @@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>  {
>      tcg_flush_jmp_cache(cpu);
> =20
> -    tlb_flush(cpu);
> +    tlb_flush_other_cpu(cpu);
>  }
> =20
> --8<---------------cut here---------------end--------------->8---
>=20


