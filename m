Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D38C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 04:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txf8j-0003Y9-Ue; Thu, 27 Mar 2025 00:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mizhang@google.com>)
 id 1txcnF-0000a1-B9
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:16:30 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mizhang@google.com>)
 id 1txcnB-0002Ol-Q9
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:16:28 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6df83fd01cbso1841926d6.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1743041784; x=1743646584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFojVxnar/uxzYA1kxiB9eF4fkInOSop8hkfFvUJi3Q=;
 b=stExfba0fs0sXx4+UECsBOVQUxhUGm1C2fYx9pHDJaU4YQPan60dMS7rqVtBomKXnG
 RQo6owFQyVdrfsPVWj45DkfcbTQpYFb0w4JyMiwqFeYqAaACvLWfEUzZ0df1WPBM/OFc
 injT++bYKxN3lxrYB60lVk1sB03HpPQ8UsczwO+Nh0D/QbPLDId5H9H8s9q/y6skdVEV
 SuKfn/X3XbbeBOXF5cX6c+rBKnS8D0967bIVTUALF/i5XtPXtEcm/2RirMFIZoigMBhI
 wvGMNMfWx0racwF2gxdGp+UgzQUqJNU4vpm60wWIOLMPV/FY1SHjOFtf+ot217nfePht
 dlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743041784; x=1743646584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFojVxnar/uxzYA1kxiB9eF4fkInOSop8hkfFvUJi3Q=;
 b=PVpKiEgQvs3YsJ3/XKHD62MXW0fFgXS21yeB9v6qD4emNy5AE/eTpcTLQOvdCy5TuG
 P1R+dwxIDf1wSuYvK15ArQEvBZKAKzEkIQ4f0LARgbHOYtE1x9oHu2Mtcz+tY/Qyo46w
 AFNBi+E7QKgw3OcWxahcZGiuaOVuQn6V+bZEBKcmavSzqx1cGu5fFQJYLMjVfviWXFYJ
 a66GZTYfbXcof6t+stFaiuAk5Vfu1fjiVxI+ebxstpwLOYzKNcbzoPf2s0s8v28Jyim9
 FTw5L7/dakCF4mhYax//A4nDa3rcnMdh2ymzAkY0u3PXzkybcC1FKeVAptXgYVV0n9bt
 gLeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViWtzboPQOKuVYRVFjNO1YxwO9XCii55gMUiH0wO60JZPG0lpD1nPbtpVrmCCE/YcttVTHKJDPJwGm@nongnu.org
X-Gm-Message-State: AOJu0YyUPGUIiINLj53+JqwPlYS1DV9NMrszIFf8z3CIns2lTsr9EaDu
 Tja3tU9qUAswWjlAx9k9J48QAKaMncHd47WYKC3A1+6iva7a0cV3NGA2Zv96d+xnoK2JjVLZQkG
 ftfOCtJgzVOaelfy9ODpBVKLaRLO7xLHOxr8R
X-Gm-Gg: ASbGncv9pw0WUsqIbR9e//A0y6J6C/P5U5AFfHRcqTnvhoI+DZIu+tE1BYwflrarroH
 sSRFJSbp0c3Y+TfTCozNotcNLqJN5969jaw38NA3EntA+rcFj4w53NPaEg1p1qg3Kcgr1wlNRrD
 Nboq1yhnDIKTS4DwOyhrdecUipTs3J47RpXpnX/oM=
X-Google-Smtp-Source: AGHT+IF8FdzDd8QYN1oGjSj1k/pQSI+TUyF/Huds9n2UQhF8YZjJCRcMIq8dCcFMF3ZyAp9c2hAJaZ9SAxg6EMeDIE0=
X-Received: by 2002:a05:6214:2488:b0:6e4:442c:288b with SMTP id
 6a1803df08f44-6ed23872a9bmr22896936d6.11.1743041783448; Wed, 26 Mar 2025
 19:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
 <20250324123712.34096-3-dapeng1.mi@linux.intel.com>
 <3a01b0d8-8f0b-4068-8176-37f61295f87f@oracle.com>
 <a8e4649d-5402-4c3a-bc86-1d1b76122541@linux.intel.com>
In-Reply-To: <a8e4649d-5402-4c3a-bc86-1d1b76122541@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 26 Mar 2025 19:15:46 -0700
X-Gm-Features: AQ5f1JpZQI9JO5cpCg75fYJaq8-zHvkOAlgHiqURK5hDPWIaWsG2AA_tls52R2g
Message-ID: <CAL715WJmj=7wO_HTSendCLAs6TAPbUyKM9gMFKLhiSKqgr1s4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/i386: Call KVM_CAP_PMU_CAPABILITY iotcl to
 enable/disable PMU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, 
 Zhao Liu <zhao1.liu@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>, 
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
 Dapeng Mi <dapeng1.mi@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=mizhang@google.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, LONG_TERM_PRICE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Mar 2025 00:46:48 -0400
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

On Wed, Mar 26, 2025 at 5:44=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 3/26/2025 2:46 PM, Dongli Zhang wrote:
> > Hi Dapeng,
> >
> > PATCH 1-4 from the below patchset are already reviewed. (PATCH 5-10 are=
 for PMU
> > registers reset).
> >
> > https://lore.kernel.org/all/20250302220112.17653-1-dongli.zhang@oracle.=
com/
> >
> > They require only trivial modification. i.e.:
> >
> > https://github.com/finallyjustice/patchset/tree/master/qemu-amd-pmu-mid=
/v03
> >
> > Therefore, since PATCH 5-10 are for another topic, any chance if I re-s=
end 1-4
> > as a prerequisite for the patch to explicitly call KVM_CAP_PMU_CAPABILI=
TY?
>
> any option is fine for me, spiting it into two separated ones or still ke=
ep
> in a whole patch series. I would rebase this this patchset on top of your
> v3 patches.
>
>
> >
> > In addition, I have a silly question. Can mediated vPMU coexist with le=
gacy
> > perf-based vPMU, that is, something like tdp and tdp_mmu? Or the legacy
> > perf-based vPMU is going to be purged from the most recent kernel?
>
> No, they can't. As long as mediated vPMU is enabled, it would totally
> replace the legacy perf-based vPMU. The legacy perf-based vPMU code would
> still be kept in the kernel in near future, but the long-term target is t=
o
> totally remove the perf-based vPMU once mediated vPMU is mature.

mediated vPMU will co-exist with legacy vPMU right? Mediated vPMU
currently was constrained to SPR+ on Intel and Genoa+ on AMD. So
legacy CPUs will have no choice but legacy vPMU.

In the future, to fully replace legacy vPMU we need to solve the
performance issue due to PMU context switching being located at VM
enter/exit boundary. Once those limitations are resolved, and older
x86 CPUs fade away, mediated vPMU can fully take over.

Thanks.
-Mingwei
>
>
> >
> > If they can coexist, how about add property to QEMU control between
> > legacy/modern? i.e. by default use legacy and change to modern as defau=
lt in the
> > future once the feature is stable.
> >
> > Thank you very much!
> >
> > Dongli Zhang
> >
> > On 3/24/25 5:37 AM, Dapeng Mi wrote:
> >> After introducing mediated vPMU, mediated vPMU must be enabled by
> >> explicitly calling KVM_CAP_PMU_CAPABILITY to enable. Thus call
> >> KVM_CAP_PMU_CAPABILITY to enable/disable PMU base on user configuratio=
n.
> >>
> >> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  target/i386/kvm/kvm.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> >> index f41e190fb8..d3e6984844 100644
> >> --- a/target/i386/kvm/kvm.c
> >> +++ b/target/i386/kvm/kvm.c
> >> @@ -2051,8 +2051,25 @@ full:
> >>      abort();
> >>  }
> >>
> >> +static bool pmu_cap_set =3D false;
> >>  int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
> >>  {
> >> +    KVMState *s =3D kvm_state;
> >> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
> >> +
> >> +    if (!pmu_cap_set && kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY=
)) {
> >> +        int r =3D kvm_vm_enable_cap(s, KVM_CAP_PMU_CAPABILITY, 0,
> >> +                                  KVM_PMU_CAP_DISABLE & !x86_cpu->ena=
ble_pmu);
> >> +        if (r < 0) {
> >> +            error_report("kvm: Failed to %s pmu cap: %s",
> >> +                         x86_cpu->enable_pmu ? "enable" : "disable",
> >> +                         strerror(-r));
> >> +            return r;
> >> +        }
> >> +
> >> +        pmu_cap_set =3D true;
> >> +    }
> >> +
> >>      return 0;
> >>  }
> >>

