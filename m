Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C34E81BD6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSsf-0007od-Ho; Mon, 09 Feb 2026 10:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpSse-0007o1-63
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:08:52 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpSsa-0001u1-Q5
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:08:51 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65815ec51d3so4655448a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770649719; x=1771254519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PX08CHnEJ8USaYgv8kIkLvhsydNvCRgjkfojIIkI+Y=;
 b=KnIP0OOYv3RIBmxXoqnsgvAEKzmeNBH9I9TI82XJUBAvIaQ/cRw1aVkEsupcMaEvWS
 61GftdmlenjkeaBz5HQn5aKIbJgoCBel8ItquPB5+UNV4w9L9+41pC15saPwO8tQ6rT6
 F/lrdxgwv+Ic0GpDHXilGUu5eWtq/PrkAPG/idmFMwfv9IytlImtCmOGAlBoyMwgYXSa
 vYDv36B0tfOExu1PjeN7h0o42UxsakuiWQhJfoXkkd8Ee2W2+UVzcTWzlIrpcOrXobSh
 yA/b+6uE01xZfSvRfVSEaoWyX1MGHAho3l/CGDHc7JC8oX+DmQVocYgnsbpCnnkJ6eJv
 M9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770649719; x=1771254519;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5PX08CHnEJ8USaYgv8kIkLvhsydNvCRgjkfojIIkI+Y=;
 b=W+Umw4dFS74IbhNESjDeiTZj5wVW880KljNaS5AhvuZgLN8RFa6SYUTqilod0J68St
 8kTso1LedU0N2yHie4Ge98KMFj3n+uSd26vk3l0oDTHB0TpSP3aPYrqHTZfnbj8XGiIX
 28+FnejKZoe8eERGvmy2BDvwaf+2kxgvRFaF8c2G5nE0TFWsMfkRrzHzxZmyu4B8xCXR
 p/M+oRJfPTyoaOpkUF61DZqeueGN28mFrZfFGS4uDOUwpWS72pu1SjJkil0ilEqXtx49
 u7kWK3/Rmfx13lAVzjSfJb5byAVabnMt5aGJixCi5MeKCBkrEwn6udGgx1Zc23skdvK7
 pp/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqSMJH320ag115WrzgoZcBT9LU/zPqlmQoRxMO+Z314i95WODnpYA7h8AjhTqCXz8mO6Q0hGvYAHbV@nongnu.org
X-Gm-Message-State: AOJu0YxHaQTy4QY2tvWZTE3zkUpZ6y9DqifIgdkM25ObenwOm3FWRJpf
 TFVWf+8qq618cyGPk0GVSFf9p+2nt7+WbOxaaM+0mAwNHWn6y5kGdi6l/h94zJSbgPBzlJpEWlT
 Gd6asdno=
X-Gm-Gg: AZuq6aJ3uXHG6ihUop/bzOJK+Rt5iutmFLmSW3k8OxJFwTuTjAAbpDjOjO/PRkdb7gk
 WJm3x8gM1qo2ATRz9ow0nwg+oyK4XQyPvc6TQv+/MiuwyZomgeBPNoKYFQv1uKF7H7hPsiiufXx
 tNyxgHvj9QWXRpMw9fBl7xd0ySFJemNK2oXWyjh/Ygv1+x5AvMOFHf+mde8vJb3iQ4fjWcpUDjz
 XPxdBJUxnrI2jv92xJBoi4U8q2DlIcQVK+5H0HodB0Pu9V/hGvvXQc6uNLFLzAUiskVUSfwkDMn
 2NLr1x7s0EjJYd1ur6+1IoxBjZ5EyylBbusdD42KkBrTG2tSQ6aMm32//rtt2r52hCA1qMjqm7r
 uUVECteESPDkHBYlWbkQT/37SsDhFScOzIBggjMB4dT80+Rd1JjV7LMeoxA8PWQuLOXFyIt+LcW
 8gSC0YDq67N+k=
X-Received: by 2002:a17:907:3d45:b0:b88:4ddf:d6f0 with SMTP id
 a640c23a62f3a-b8edf3a908cmr682272766b.61.1770649719193; 
 Mon, 09 Feb 2026 07:08:39 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda74a652sm402226366b.3.2026.02.09.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 07:08:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC28C5F80A;
 Mon, 09 Feb 2026 15:08:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 peter.maydell@linaro.org,  cohuck@redhat.com,  maz@kernel.org,
 oliver.upton@linux.dev,  sebott@redhat.com,  gshan@redhat.com,
 ddutile@redhat.com,  peterx@redhat.com,  philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH v6 02/11] target/arm/machine: Improve traces on register
 mismatch during migration
In-Reply-To: <20260126165445.3033335-3-eric.auger@redhat.com> (Eric Auger's
 message of "Mon, 26 Jan 2026 17:53:01 +0100")
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-3-eric.auger@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 09 Feb 2026 15:08:37 +0000
Message-ID: <87bjhyymx6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Eric Auger <eric.auger@redhat.com> writes:

> Currently when the number of KVM registers exposed by the source is
> larger than the one exposed on the destination, the migration fails
> with: "failed to load cpu:cpreg_vmstate_array_len"
>
> This gives no information about which registers are causing the trouble.
>
> This patch reworks the target/arm/machine code so that it becomes
> able to handle an input stream with a larger set of registers than
> the destination and print useful information about which registers
> are causing the trouble. The migration outcome is unchanged:
> - unexpected registers still will fail the migration
> - missing ones are printed but will not fail the migration, as done today.
>
> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
> registers compared to what exists on the target.
>
> If there are more registers we will still hit the previous
> "load cpu:cpreg_vmstate_array_len" error.
>
> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.
>
> Example:
>
> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stre=
am: 0 0x6030000000160003 fw feat reg 3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input s=
tream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input s=
tream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input s=
tream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
> qemu-system-aarch64: error while loading state for instance 0x0 of device=
 'cpu'
> qemu-system-aarch64: load of migration failed: Operation not permitted
>
> With TCG there is no user friendly formatting of the faulting
> register indexes as with KVM. However the 2 added trace points
> help to identify the culprit indexes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>
> ---
>
> v2 -> v3:
> - some extra typos (Connie)
> - collected Connie's R-b
>
> v1 -> v2:
> - fixed some type in the commit msg
> ---
>  target/arm/cpu.h        |  6 +++++
>  target/arm/kvm.c        | 23 ++++++++++++++++
>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/trace-events |  7 +++++
>  4 files changed, 88 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1eaf5a3fddf..e900ef7937b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -939,6 +939,12 @@ struct ArchCPU {
>      uint64_t *cpreg_vmstate_values;
>      int32_t cpreg_vmstate_array_len;
>=20=20
> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
> +    int32_t cpreg_vmstate_missing_indexes_array_len;
> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIE=
S];
> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
> +

This seems a bit old school when we have GArray.

>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>      DynamicGDBFeatureInfo dyn_svereg_feature;
>      DynamicGDBFeatureInfo dyn_smereg_feature;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 48f853fff80..c6f0d0fc4e1 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1024,6 +1024,29 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
>=20=20
>  bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>  {
> +    int i;
> +
> +    for (i =3D 0; i < cpu->cpreg_vmstate_missing_indexes_array_len; i++)=
 {
> +        gchar *name;
> +
> +        name =3D kvm_print_register_name(cpu->cpreg_vmstate_missing_inde=
xes[i]);
> +        trace_kvm_arm_cpu_post_load_missing_reg(name);
> +        g_free(name);
> +    }
> +
> +    for (i =3D 0; i < cpu->cpreg_vmstate_unexpected_indexes_array_len; i=
++) {
> +        gchar *name;
> +
> +        name =3D kvm_print_register_name(cpu->cpreg_vmstate_unexpected_i=
ndexes[i]);
> +        error_report("%s Unexpected register in input stream: %i 0x%"PRI=
x64" %s",
> +                     __func__, i, cpu->cpreg_vmstate_unexpected_indexes[=
i], name);
> +        g_free(name);
> +    }
> +    /* Fail the migration if we detect unexpected registers */
> +    if (cpu->cpreg_vmstate_unexpected_indexes_array_len) {
> +        return false;
> +    }
> +
>      if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
>          return false;
>      }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 0befdb0b28a..f06a920aba1 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -10,6 +10,7 @@
>  #include "migration/vmstate.h"
>  #include "target/arm/gtimer.h"
>  #include "hw/arm/machines-qom.h"
> +#include "trace.h"
>=20=20
>  static bool vfp_needed(void *opaque)
>  {
> @@ -990,7 +991,13 @@ static int cpu_pre_load(void *opaque)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> +    int arraylen =3D cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_AN=
OMALIES;
>=20=20
> +    cpu->cpreg_vmstate_indexes =3D g_renew(uint64_t, cpu->cpreg_vmstate_=
indexes,
> +                                         arraylen);
> +    cpu->cpreg_vmstate_values =3D g_renew(uint64_t, cpu->cpreg_vmstate_v=
alues,
> +                                        arraylen);
> +    cpu->cpreg_vmstate_array_len =3D arraylen;

I wonder if these would be candidates for fixing up as well.

>      /*
>       * In an inbound migration where on the source FPSCR/FPSR/FPCR are 0,
>       * there will be no fpcr_fpsr subsection so we won't call vfp_set_fp=
cr()
> @@ -1023,7 +1030,7 @@ static int cpu_post_load(void *opaque, int version_=
id)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> -    int i, v;
> +    int i =3D 0, j =3D 0, k =3D 0, v =3D 0;
>=20=20
>      /*
>       * Handle migration compatibility from old QEMU which didn't
> @@ -1051,27 +1058,66 @@ static int cpu_post_load(void *opaque, int versio=
n_id)
>       * entries with the right slots in our own values array.
>       */
>=20=20
> -    for (i =3D 0, v =3D 0; i < cpu->cpreg_array_len
> -             && v < cpu->cpreg_vmstate_array_len; i++) {
> +    trace_cpu_post_load_len(cpu->cpreg_array_len, cpu->cpreg_vmstate_arr=
ay_len);
> +    for (; i < cpu->cpreg_array_len && v < cpu->cpreg_vmstate_array_len;=
) {
> +        trace_cpu_post_load(i, v , cpu->cpreg_indexes[i]);
>          if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
>              /* register in our list but not incoming : skip it */
> +            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
> +            if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
> +                cpu->cpreg_vmstate_missing_indexes[j++] =3D cpu->cpreg_i=
ndexes[i];
> +            }
> +            i++;
>              continue;
>          }
>          if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
> -            /* register in their list but not ours: fail migration */
> -            return -1;
> +            /* register in their list but not ours: those will fail migr=
ation */
> +            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes=
[v], i);
> +            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
> +                cpu->cpreg_vmstate_unexpected_indexes[k++] =3D
> +                    cpu->cpreg_vmstate_indexes[v];
> +            }
> +            v++;
> +            continue;
>          }
>          /* matching register, copy the value over */
>          cpu->cpreg_values[i] =3D cpu->cpreg_vmstate_values[v];
>          v++;
> +        i++;
>      }
> +    /*
> +     * if we have reached the end of the incoming array but there are
> +     * still regs in cpreg, continue parsing the regs which are missing
> +     * in the input stream
> +     */
> +    for ( ; i < cpu->cpreg_array_len; i++) {
> +        if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
> +            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
> +            cpu->cpreg_vmstate_missing_indexes[j++] =3D cpu->cpreg_index=
es[i];
> +        }
> +    }
> +    /*
> +     * if we have reached the end of the cpreg array but there are
> +     * still regs in the input stream, continue parsing the vmstate array
> +     */
> +    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
> +        if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
> +            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes=
[v], i);
> +            cpu->cpreg_vmstate_unexpected_indexes[k++] =3D
> +                cpu->cpreg_vmstate_indexes[v];
> +        }
> +    }
> +
> +    cpu->cpreg_vmstate_missing_indexes_array_len =3D j;
> +    cpu->cpreg_vmstate_unexpected_indexes_array_len =3D k;
>=20=20
>      if (kvm_enabled()) {
>          if (!kvm_arm_cpu_post_load(cpu)) {
>              return -1;
>          }
>      } else {
> -        if (!write_list_to_cpustate(cpu)) {
> +        if (cpu->cpreg_vmstate_unexpected_indexes_array_len ||
> +            !write_list_to_cpustate(cpu)) {
>              return -1;
>          }
>      }
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 676d29fe516..0a5ed3e69d5 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -13,6 +13,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_i=
rq: timer %d irqstate %d"
>=20=20
>  # kvm.c
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova =3D 0x%"P=
RIx64" is translated into 0x%"PRIx64
> +kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input=
 stream: %s"
>=20=20
>  # cpu.c
>  arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
> @@ -26,3 +27,9 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
>=20=20
>  # tcg/psci.c and hvf/hvf.c
>  arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32=
_t cpuid) "PSCI Call x0=3D0x%016"PRIx64" x1=3D0x%016"PRIx64" x2=3D0x%016"PR=
Ix64" x3=3D0x%016"PRIx64" cpuid=3D0x%x"
> +
> +# machine.c
> +cpu_post_load_len(int cpreg_array_len, int cpreg_vmstate_array_len) "cpr=
eg_array_len=3D%d cpreg_vmstate_array_len=3D%d"
> +cpu_post_load(int i, int v, uint64_t regidx) "i=3D%d v=3D%d regidx=3D0x%=
"PRIx64
> +cpu_post_load_missing(int i, uint64_t regidx, int v) "missing register i=
n input stream: i=3D%d index=3D0x%"PRIx64" (v=3D%d)"
> +cpu_post_load_unexpected(int v, uint64_t regidx, int i) "unexpected regi=
ster in input stream: v=3D%d index=3D0x%"PRIx64" (i=3D%d)"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

