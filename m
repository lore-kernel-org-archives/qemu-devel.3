Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE1FED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGL8v-0007Wq-S5; Fri, 24 Apr 2026 14:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGL8t-0007W7-8Z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:20:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGL8p-0003pv-7h
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:20:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso4054515f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777054837; x=1777659637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJ3ffUmyrezSY/rh/pt0nrkBPeHVspjmLRhtqz3CZrg=;
 b=qiDKeuLsXzd6amP1/atSU6UUn7+7zdxSSA8Q4kstQdgk3GTKvCSe2hOgWsOra2cizO
 IYvDH0t19IdLzokY100fjZLCpkFkgrFKJYY4glRcwcx1wbHEAX7nVlomfHs/Wx/DAxD8
 VukvwYrLvoy7sGsGmSjAZ82/t+erZ8zk/oZzloAuiuvRuCld4hg9Ar5wFs9+YCsBQxF/
 3kEqNrGiUUJXIPYfixvxEHXC+IcGvuTdsCOCFnojdVVbxGjmjVy03Y7myQpXceOmkcTg
 8C8th61DvOLxcGLLr8JkUM3empUhMZgm2HE6hV5lJTpwWoVD5BchKpVDBTbZ5F8via/z
 f+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777054837; x=1777659637;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJ3ffUmyrezSY/rh/pt0nrkBPeHVspjmLRhtqz3CZrg=;
 b=gxzQVh+owk8QOfSCmjaCHzHJOlTGqxa/M6aggbwWW88hSzXPkQoGYXcHMz6iCsbhQt
 d4i+X8qlVw9YKG9MhOhNUUxiO7KwNQudAm0kvwpFcKtanrCCVNYNkZE421lj6yo5XlGE
 4LIC5sQB4Kr91TEPhDpKX9nGAsPDU0FE/fgaa9F4UwPvEzL/WnIJUXVIXVup1UXGxDU5
 duDG9bDpIQko61JFFk8AoE+aeX2si8YuJNFgu2f1fdVeL6RRDwo03PKj9EC+7vSTZwXf
 5XwYeuGMjq6dSfCOE8q2J1cDnMujjDrE3D3J5vMrBKQDHoEKn1gJ2l4HJYs0ixRNgEcx
 F7xw==
X-Gm-Message-State: AOJu0YyWxrlkFS89zpx8su6+PW3f9c6t0a7mZaogUgg2xNKvhCfNa7Yw
 yBL+pYnsJJuGcpwuXjGlo6vqXac3Xdg/4RFPhNmXw6e38IpT+VJwteK4S+PNondLiFQ=
X-Gm-Gg: AeBDiev/5NaaburA2YJ0l8AgO4iMUyaCUREN8k7344TfBjAX4OIzjC+azrgFepq5ukp
 5dsM22mSMbPLWpWRx6ozgHyuuF32NvjwKlU/j0svG5Tc2wg/fMmXr7l0Ao2pcg+TL2CRB4eFvXB
 0fvajgbg/iKG+5yb6kp9hR2zx+C17mBvekUJlYbtLyRsBwXfiLrhXz0e1Xp/tRon5pWvq2oqC65
 G9ohSyZWWO10Zx8TKXQhkqZlpC+c6fgQtKZ9XcCucyDY52VgPqqlAArIpTkZMoAQMIsvu1rm2uh
 K319vertFXC5D2gYpjIeH8yh1mTYNO895/jFwgg1V1hQO8OfT5eHxL0i09dcukAWLOmrf4DfO95
 GqZafISq4hblr889+f+RMtncFiVNhg4OZRPFN5iXHTkUFyRNgn9G0wXI3HnH88Qk6AUN4zB99p1
 +dr/tqNqruLUqi2nwzrAK1owbBELbzTCyybg==
X-Received: by 2002:a05:6000:1889:b0:43d:21a:9a3e with SMTP id
 ffacd0b85a97d-43fe3e0bd8dmr49822275f8f.32.1777054836694; 
 Fri, 24 Apr 2026 11:20:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm57497836f8f.22.2026.04.24.11.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:20:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E1EF5F7C7;
 Fri, 24 Apr 2026 19:20:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,  Alexander Graf
 <agraf@csgraf.de>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v3 00/32] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 22 Apr 2026 13:52:17 +0100")
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 24 Apr 2026 19:20:34 +0100
Message-ID: <87y0ic43v1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The series starts with some refactoring of the syndrome register
> helpers to use registerfields. We then expand the WFIT trap handling
> to report the register used. We then implement the event stream events
> for SEV, global monitor and the timer related ones before enabling WFE
> for A-profile and then finally WFET.
>
> Note on AI usage. As an experiment I previously posted an RFC series
> with the help of Gemini. This series however is a ground up
> re-implementation which takes some different approaches on modelling
> the event stream. In particular rather than running multiple timers we
> use the same wxft timer and just compute if the timeout or timer event
> will come first.
>
> v2
>   - I've kept the tests separate, see:
>
>     Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
>     Date: Fri, 17 Apr 2026 17:43:20 +0100
>     Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu=
 tests
>     From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
>
>   - tweaks to global monitor behaviour
>   - STLR/STL will also trigger events to avoid deadlocks
>   - see under the --- in the patches for details
>
> v3
>   - fixed the WFE exception handling
>
> Alex.
>
> Alex Benn=C3=A9e (32):
>   target/arm: migrate basic syndrome helpers to registerfields
>   target/arm: migrate system/cp trap syndromes to registerfields
>   target/arm: migrate FP/SIMD trap syndromes to registerfields
>   target/arm: migrate eret trap syndromes to registerfields
>   target/arm: migrate SME trap syndromes to registerfields
>   target/arm: migrate PAC trap syndromes to registerfields
>   target/arm: migrate BTI trap syndromes to registerfields
>   target/arm: migrate BXJ trap syndromes to registerfields
>   target/arm: migrate Granule Protection traps to registerfields
>   target/arm: migrate fault syndromes to registerfields
>   target/arm: migrate debug syndromes to registerfields
>   target/arm: migrate wfx syndromes to registerfields
>   target/arm: migrate gcs syndromes to registerfields
>   target/arm: migrate memory op syndromes to registerfields
>   target/arm: migrate check_hcr_el2_trap to use syndrome helper
>   target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
>   target/arm: use syndrome helpers to set SAME_EL EC bit
>   target/arm: make whpx use syndrome helpers for decode
>   target/arm: make hvf use syndrome helpers for decode
>   target/arm: use syndrome helpers in merge_syn_data_abort
>   target/arm: use syndrome helpers to query VNCR bit
>   target/arm: remove old syndrome defines
>   target/arm: report register in WFIT syndromes

Peter,

Do you think you could take the patches up to here so I don't need to
hold the re-factoring patches in the tree?

>   target/arm: teach arm_cpu_has_work about halting reasons
>   target/arm: redefine event stream fields
>   target/arm: ensure aarch64 DISAS_WFE will exit
>   target/arm: implements SEV/SEVL for all modes
>   target/arm: hoist event broadcast code into a helper
>   target/arm: implement global monitor events
>   target/arm: enable event stream on WFE instructions
>   target/arm: handle the WFE trap case
>   target/arm: implement WFET
>
>  target/arm/cpu.h               |  27 ++
>  target/arm/internals.h         |  31 +-
>  target/arm/syndrome.h          | 595 +++++++++++++++++++++++++++------
>  target/arm/tcg/helper-defs.h   |   5 +-
>  target/arm/tcg/translate.h     |  32 ++
>  target/arm/tcg/a32.decode      |   5 +-
>  target/arm/tcg/a64.decode      |   5 +-
>  target/arm/tcg/t16.decode      |   4 +-
>  target/arm/tcg/t32.decode      |   4 +-
>  target/arm/arm-powerctl.c      |   4 +-
>  target/arm/cpu.c               |  53 ++-
>  target/arm/helper.c            |  12 +-
>  target/arm/hvf/hvf.c           |  14 +-
>  target/arm/kvm.c               |   5 +-
>  target/arm/machine.c           |   2 +-
>  target/arm/tcg/debug.c         |   2 +-
>  target/arm/tcg/op_helper.c     | 231 +++++++++++--
>  target/arm/tcg/tlb_helper.c    |   6 +-
>  target/arm/tcg/translate-a64.c |  60 +++-
>  target/arm/tcg/translate.c     |  35 +-
>  target/arm/tcg/vfp_helper.c    |   5 +-
>  target/arm/whpx/whpx-all.c     |  13 +-
>  22 files changed, 946 insertions(+), 204 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

