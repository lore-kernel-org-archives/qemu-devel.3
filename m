Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547FDC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk21R-0001x6-K0; Wed, 15 Jul 2026 11:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wk21Q-0001ws-DZ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:59:44 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wk21O-000679-6x
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:59:44 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5bf9466412fso1406549e0c.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131180; cv=none;
 d=google.com; s=arc-20260327;
 b=X2nJ1+UO8hGuuTKnGoBzv+SVm3RcxMvVnJ3tBFliNYpCtPrygVH512xd/VMRPmjSMm
 t6zIikH46QBmahxo1dndmC28mcEBfBXCgNCQrH50ERp771CyMCjyD0UnbdqdVhqMd9jd
 WEBn+F/czIToXF0QmlK+J0zpxAnNPFnomCFywTKxQpr0nO0Ld9eTa1RrkPntsF5oQ+hR
 O9kPkKR4rB1s1eQOx0j/K0vMoaV/5bUNAh6/jYHpOzDXBcvtAZV4azyvFcejo31V65jS
 7fWo/QKP0JphAir7UIjo5cYbf9uM4oqWLw/+nolG0xuO9HWYFH2s1oMBWJSsr5IbeWjk
 xkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
 fh=dv8mTi9+qPmyO1fqk2LagI0qj6Vd/IYVckCgPdJ8JxM=;
 b=XWoQ/RNWJpCD3Kx2/ms5hz1CiXImMpaVo5NWSf0iEL2Qf95x7oyjsgX8muME63hHv4
 xKOCRn4fEwLFUq2jSN6B52SMQukhXjm/8jqtray/pQWo4q+ddivQFz98oedDjWSSAK2p
 o+Av+VmTu7/MY1EyvHmnU4ydJwg7Kzw0lCxbTeysWFwhXKY4R5i7nRm5prIwjfB6lPJk
 L1f/h2Pj709IyISuGdxs7ftKxNAv+76Yiv2wDkkrZBnlyM9YuNP/6qm+Ede3lSK60NUe
 Pjs1rRALYTcozbFIY8h3JlYg4Ms+sYmlCmtd2nQV0Ns8f5GdiB9gU6VYGihyDuYyEVMl
 3cdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1784131180; x=1784735980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
 b=KgG4uScoumepABcN0oN0Cslao/4WysNVGjWj88H68rtJZ1jX3dmtgG5mdxfXDzIzwc
 SQfSPCSkloS0w/wAS8h3cSAt/Ek+C9wtYHARFOFyS9uF1u+YE2VwilhMoKKvGtx/ivvK
 kbRfJRDv5f5MVIdZl/kSf33TFr4LwKBgCnYkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131180; x=1784735980;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
 b=BgRrPOcf8JZGhjdodiKQkztj4+jbirj+5o23etbvpyktH+Wqfe14QzQBOEWdDjvA3A
 pfaGpKtulPSN2xbIyRwhmQcdTWTESVe0y5NhpLsxSDqLhzLppQ4h93Dfy212LNQQOLf4
 mCs+m0zbNXu2SWtJqgXeG2LlGf1WmnN9Bi+K2Pr5qoEXDjJX/ZA7iSHua02lU654HVp4
 poPQvkX3L4DKOp2JswDJjb4sqwkPrFsAvZ+OHs59fMhiw4Woj19i72SkKLZOirHYVzoz
 1m4piUq8A9Jvl0L7Ei1k16NuHU0GptUO8gU58q/q+oIBFdUoqw/w/mYY5W8ZCSKxWvm6
 ohYg==
X-Gm-Message-State: AOJu0YzBVOaKY23E1fnlnR6R7SWALR7zNHJCRzqISih4tzYKqoxnTtGD
 8XoNjEG1BSTjVLQF4opE0uOk2t18/EQYTF+PAjgnyrz0ur6ZyXeoJ/A/DyD/mWdlh+3g11KD/yq
 7XSjEHLfdK2eQEWcuCBJ1T05YGHsz1avvgteMaoMLGoi6YLUP8y2smfs=
X-Gm-Gg: AfdE7cl4neSElkJemPhcGlHjalrAuTluaLTI0Kq8v0/FBBZ1+gRlkHV4/Z9H5EoxiEb
 5pXajR724HYXncuLtTRYRtV7WZ/OM2r/fmwVFxKM24mfHcT7caJbi+POWjtVAWXx+uuqZ61bEST
 3hrO0teG7a5Nbp0s4m2yX85Ac6DDwHvVwSrtiT4HM6gWbUyGlmmG3Ke2tAvD2BPCv7eO4XGJw7b
 GER/l7xIQCxPWrwq69Qu4T5ZQfvM6guheUfjBjvmlD/ZEKg9N0mJJXFNNmlfRITrC70IuCFpdw=
X-Received: by 2002:a05:6122:83f2:b0:5bd:ecad:8f9c with SMTP id
 71dfb90a1353d-5bfbf172175mr10635021e0c.6.1784131180332; Wed, 15 Jul 2026
 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com>
 <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
In-Reply-To: <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 15 Jul 2026 12:59:29 -0300
X-Gm-Features: AUfX_mwmwtPYmQoqSteupvHqXSL1ozAcd3PCwNoeSxprkSlYvVt9OGA1dlMAwtA
Message-ID: <CAPhRvkw2xtE2n5q4cA=0CBxMM_CMdw2n_Z_c6ZdtEJMXhwy6BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
 zhao1.liu@intel.com, mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=anderson@allelesecurity.com; helo=mail-vk1-xa2c.google.com
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

ping

On Thu, Jun 25, 2026 at 9:50=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> On Tue, Jun 2, 2026 at 11:05=E2=80=AFAM Anderson Nascimento
> <anderson@allelesecurity.com> wrote:
> >
> > Introduce support for exposing and enabling APERF/MPERF MSR passthrough
> > for x86 QEMU guests when running under KVM.
> >
> > The Linux kernel supports a KVM capability allowing the hypervisor to
> > disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
> > guests to track effective frequency directly without VM-exits. QEMU
> > currently lacks a native way to request this capability or expose the
> > corresponding feature bit to the guest.
> >
> > This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
> > (CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
> > the flag ties into QEMU's existing host power management framework.
> > When host CPU power management is explicitly requested by the user
> > (via `-overcommit cpu-pm=3Don`) and the `+aperfmperf` flag is provided
> > to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
> > MSR read intercepts.
> >
> > This implementation allows guest operating systems (such as FreeBSD
> > or Linux) to dynamically calculate CPU utilization and turbo-boost
> > metrics without incurring performance overhead from hypervisor trap-and=
-
> > emulate loops.
> >
> > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> > ---
> > Changes in v2
> > - Added migration flags
> > - Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-ander=
son@allelesecurity.com/
> >
> >  target/i386/cpu.c     | 18 +++++++++++++++++-
> >  target/i386/cpu.h     |  2 ++
> >  target/i386/kvm/kvm.c |  5 ++++-
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 8929a75c7c..544738d406 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS]=
 =3D {
> >          .cpuid =3D { .eax =3D 6, .reg =3D R_EAX, },
> >          .tcg_features =3D TCG_6_EAX_FEATURES,
> >      },
> > +    [FEAT_6_ECX] =3D {
> > +        .type =3D CPUID_FEATURE_WORD,
> > +        .feat_names =3D {
> > +            "aperfmperf", NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +        },
> > +        .cpuid =3D { .eax =3D 6, .reg =3D R_ECX, },
> > +        .tcg_features =3D 0,
> > +        .unmigratable_flags =3D CPUID_6_ECX_APERFMPERF,
> > +    },
> >      [FEAT_XSAVE_XCR0_LO] =3D {
> >          .type =3D CPUID_FEATURE_WORD,
> >          .cpuid =3D {
> > @@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
> >          /* Thermal and Power Leaf */
> >          *eax =3D env->features[FEAT_6_EAX];
> >          *ebx =3D 0;
> > -        *ecx =3D 0;
> > +        *ecx =3D env->features[FEAT_6_ECX];
> >          *edx =3D 0;
> >          break;
> >      case 7:
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 67e2ecf325..87864969c7 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -700,6 +700,7 @@ typedef enum FeatureWord {
> >      FEAT_SVM,           /* CPUID[8000_000A].EDX */
> >      FEAT_XSAVE,         /* CPUID[EAX=3D0xd,ECX=3D1].EAX */
> >      FEAT_6_EAX,         /* CPUID[6].EAX */
> > +    FEAT_6_ECX,         /* CPUID[6].ECX */
> >      FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=3D0xd,ECX=3D0].EAX */
> >      FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=3D0xd,ECX=3D0].EDX */
> >      FEAT_ARCH_CAPABILITIES,
> > @@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CP=
U *cpu, FeatureWord w);
> >  #define CPUID_XSAVE_XFD        (1U << 4)
> >
> >  #define CPUID_6_EAX_ARAT       (1U << 2)
> > +#define CPUID_6_ECX_APERFMPERF (1U << 0)
> >
> >  /* CPUID[0x80000007].EDX flags: */
> >  #define CPUID_APM_INVTSC       (1U << 8)
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 9e352882c8..ca722ff9e9 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, =
uint32_t function,
> >          }
> >      } else if (function =3D=3D 6 && reg =3D=3D R_EAX) {
> >          ret |=3D CPUID_6_EAX_ARAT; /* safe to allow because of emulate=
d APIC */
> > +    } else if (function =3D=3D 6 && reg =3D=3D R_ECX) {
> > +        ret |=3D CPUID_6_ECX_APERFMPERF;
> >      } else if (function =3D=3D 7 && index =3D=3D 0 && reg =3D=3D R_EBX=
) {
> >          /* Not new instructions, just an optimization.  */
> >          uint32_t ebx;
> > @@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *=
s)
> >          disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> >                            KVM_X86_DISABLE_EXITS_HLT |
> >                            KVM_X86_DISABLE_EXITS_PAUSE |
> > -                          KVM_X86_DISABLE_EXITS_CSTATE);
> > +                          KVM_X86_DISABLE_EXITS_CSTATE |
> > +                          KVM_X86_DISABLE_EXITS_APERFMPERF);
> >      }
> >
> >      return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> > --
> > 2.54.0
> >
>
> ping
>
> Is there anything I should do to get this patch applied?
>
> --
> Anderson Nascimento
> Allele Security Intelligence
> https://www.allelesecurity.com



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

