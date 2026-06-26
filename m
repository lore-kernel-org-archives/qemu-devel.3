Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C187CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcum1-0005tI-06; Thu, 25 Jun 2026 20:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wcum0-0005t9-3K
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:50:24 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wculy-00073h-7C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:50:23 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5bd745cf7c7so172512e0c.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435021; cv=none;
 d=google.com; s=arc-20260327;
 b=IqVHNSmsHJuKrO/ith58Ktl5q7O2A7U6mQuSpcVtIO4dej6EUARf1JkkOt3XfVc3Dj
 KIcCLp8BuJPFTPgjqFYi+nqMKbkrN7tAvOsfg1LbEJhivlILUgCO9w6fJZGnfMx+ILyY
 aZ9vaHx1Y8EwPQ/IZcv2FiJ6/XEGi1coRt18k3YrXwY902iFLOQWwoYAV2hujCe1/cRu
 sFXcSAnrTohY559joosaydzf/bRmrhy9HWhVui/cH5f+MpngTuqZczwMN66UEZqBSuFz
 k6WnEMgn/bsuHL3ElHEBHf5rFYmHzJxM2BZciHRkQsAzHked3vCqRKaRfsDy/ksPod8Y
 GMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
 fh=dv8mTi9+qPmyO1fqk2LagI0qj6Vd/IYVckCgPdJ8JxM=;
 b=A6rZiN/p/feq1FfAmTPeP55SuIv/ouhcJxqvuycBp+owFYvrs2CN0JmJHMuzic7OAG
 A0LdsOnhcywYpqOk/MGLgHys6n/gcW0JRf1q2XDc9oDVsroq98EjUmxRjQuQYrti/oxK
 tm+4zreyVU3gO9u6B6guCO+bAb/XzF3j66sPHkDNcq7pwdxRnu4JumSeGYXzkssgBMqt
 eIXWpS0m021Oyl3O9W1uCYIyDtTLFnpbXtlNzTjkTpycy3BWn3BQq3+WhPH6d7+3vwSD
 RkATI8DS3bdr9FAmmn5Noo9/91gOIiV+ScCQwLLQlGOoDt7soO5ZEqABMBGiGgtEd2Fq
 gFDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1782435021; x=1783039821; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
 b=M/efzXyGSPrlBXQlrD9tDms1Jsju6MzQ/8X6uSWC5OC3t4jZ0K4JkrXTyIGVqml+3n
 2m9zYNebSmAp//mhceVTJLU8V09um/emQlPXd7S9UBWO7+csxrBaI2NtrtkicE44B4Th
 Z+oXP7nAzxK2e5g2sd0h7rMc5LLNqxQYv0X8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435021; x=1783039821;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
 b=M3jElCvGIv2vg/nv7H5+wiLYgBBbmhEHeForknDnwhaAnBtM74d1xWT5FiirykPoTR
 FEH/Qwgd75bbdymxgO5ToMdg7y/cwp9rU6X03Hga3Wlo3TRK64zNC2HHL5Oww6BZ00V4
 DfwOojKjsSeRRH7beA1FSbcjxlRP3+8GKtW6qQiJRXqe2+WHX+cpIdDDr3GHwFTjBYH6
 6vIm+mouWCAcK0veFUx9uAb5k4sZY/kQdvvrCi2NuesEHklBv1Iz+1/VcoJHweODxMgJ
 3gooMruzzEgxGCXBpOTmBCbIiI5m8tlISyEAi+oYklQKegONW7GsShmlBESW5eLrpJrn
 L2xg==
X-Gm-Message-State: AOJu0YyfotljFhpLKVQtQvDi1VDndNg9gt6aivbjGEVHUFs0gUG3rqAY
 BeqLSGtI/aPfIZEPG5GqA5edDk3WAx4xyoyuWSeDU1h0HSA0Ap0kbBHPhiCirLuvtcunC3cWCE0
 vgSaEA8qgpV7FiEQxKflyGHGuV/yC2BrmOOElP4hwx8pxE2ZWDHe/F2P2mQ==
X-Gm-Gg: AfdE7clK6CncN6t00NtUor9UXbbNLkanbkmNq6RFuro8VW9tAJvMo+kOxdgnNO1nsKe
 tTPM7KBXCA66OnR7+KsvEOYuPtzaUxkHOJqfhSYBMUhdEV/VxnX64patQjuuYZafcBQbbrGq75u
 qk6NQw23ijpBFpDGKsd4YP2brgVoWIxG7y7zhqzD56lmxflLZDWRoMZafzsaKuXqCsq1fE++UC3
 EMP6AWULYwBI3GjIfPh88nRvGTzG35GaegR8d1rCt8fKkSjFfYp5EcpyUIxMxmwMtdCBsW7QQ==
X-Received: by 2002:a05:6122:7d0:b0:56a:fff5:b4d6 with SMTP id
 71dfb90a1353d-5bd69dc5b2fmr2355161e0c.4.1782435020693; Thu, 25 Jun 2026
 17:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com>
In-Reply-To: <20260602140348.774203-2-anderson@allelesecurity.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 25 Jun 2026 21:50:05 -0300
X-Gm-Features: AVVi8CeJehDJerDlbCkjrru-3HwZDmENMGLl3AYEjyWjtgkFiQESrM4n-Vq5pNI
Message-ID: <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
 zhao1.liu@intel.com, mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=anderson@allelesecurity.com; helo=mail-vk1-xa29.google.com
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

On Tue, Jun 2, 2026 at 11:05=E2=80=AFAM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> Introduce support for exposing and enabling APERF/MPERF MSR passthrough
> for x86 QEMU guests when running under KVM.
>
> The Linux kernel supports a KVM capability allowing the hypervisor to
> disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
> guests to track effective frequency directly without VM-exits. QEMU
> currently lacks a native way to request this capability or expose the
> corresponding feature bit to the guest.
>
> This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
> (CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
> the flag ties into QEMU's existing host power management framework.
> When host CPU power management is explicitly requested by the user
> (via `-overcommit cpu-pm=3Don`) and the `+aperfmperf` flag is provided
> to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
> MSR read intercepts.
>
> This implementation allows guest operating systems (such as FreeBSD
> or Linux) to dynamically calculate CPU utilization and turbo-boost
> metrics without incurring performance overhead from hypervisor trap-and-
> emulate loops.
>
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---
> Changes in v2
> - Added migration flags
> - Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderso=
n@allelesecurity.com/
>
>  target/i386/cpu.c     | 18 +++++++++++++++++-
>  target/i386/cpu.h     |  2 ++
>  target/i386/kvm/kvm.c |  5 ++++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8929a75c7c..544738d406 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =
=3D {
>          .cpuid =3D { .eax =3D 6, .reg =3D R_EAX, },
>          .tcg_features =3D TCG_6_EAX_FEATURES,
>      },
> +    [FEAT_6_ECX] =3D {
> +        .type =3D CPUID_FEATURE_WORD,
> +        .feat_names =3D {
> +            "aperfmperf", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid =3D { .eax =3D 6, .reg =3D R_ECX, },
> +        .tcg_features =3D 0,
> +        .unmigratable_flags =3D CPUID_6_ECX_APERFMPERF,
> +    },
>      [FEAT_XSAVE_XCR0_LO] =3D {
>          .type =3D CPUID_FEATURE_WORD,
>          .cpuid =3D {
> @@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>          /* Thermal and Power Leaf */
>          *eax =3D env->features[FEAT_6_EAX];
>          *ebx =3D 0;
> -        *ecx =3D 0;
> +        *ecx =3D env->features[FEAT_6_ECX];
>          *edx =3D 0;
>          break;
>      case 7:
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 67e2ecf325..87864969c7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -700,6 +700,7 @@ typedef enum FeatureWord {
>      FEAT_SVM,           /* CPUID[8000_000A].EDX */
>      FEAT_XSAVE,         /* CPUID[EAX=3D0xd,ECX=3D1].EAX */
>      FEAT_6_EAX,         /* CPUID[6].EAX */
> +    FEAT_6_ECX,         /* CPUID[6].ECX */
>      FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=3D0xd,ECX=3D0].EAX */
>      FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=3D0xd,ECX=3D0].EDX */
>      FEAT_ARCH_CAPABILITIES,
> @@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU =
*cpu, FeatureWord w);
>  #define CPUID_XSAVE_XFD        (1U << 4)
>
>  #define CPUID_6_EAX_ARAT       (1U << 2)
> +#define CPUID_6_ECX_APERFMPERF (1U << 0)
>
>  /* CPUID[0x80000007].EDX flags: */
>  #define CPUID_APM_INVTSC       (1U << 8)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e352882c8..ca722ff9e9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, ui=
nt32_t function,
>          }
>      } else if (function =3D=3D 6 && reg =3D=3D R_EAX) {
>          ret |=3D CPUID_6_EAX_ARAT; /* safe to allow because of emulated =
APIC */
> +    } else if (function =3D=3D 6 && reg =3D=3D R_ECX) {
> +        ret |=3D CPUID_6_ECX_APERFMPERF;
>      } else if (function =3D=3D 7 && index =3D=3D 0 && reg =3D=3D R_EBX) =
{
>          /* Not new instructions, just an optimization.  */
>          uint32_t ebx;
> @@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *s)
>          disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
>                            KVM_X86_DISABLE_EXITS_HLT |
>                            KVM_X86_DISABLE_EXITS_PAUSE |
> -                          KVM_X86_DISABLE_EXITS_CSTATE);
> +                          KVM_X86_DISABLE_EXITS_CSTATE |
> +                          KVM_X86_DISABLE_EXITS_APERFMPERF);
>      }
>
>      return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> --
> 2.54.0
>

ping

Is there anything I should do to get this patch applied?

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

