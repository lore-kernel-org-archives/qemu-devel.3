Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B76C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x236u-0000CY-60; Thu, 03 Sep 2026 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x236s-0000Bf-NC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x236q-0007Hq-Jr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788425267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
 b=Zgwir//o4a3JrlxMFCOjhumJt79YObDIrj1dOHFKen66N7jXzXBDtO0k3ESj4JZs5mD00i
 m11l9sRYz7mZyGbUT2nqMT3yeqGL9GceYWf+ymyl+d5O0Rf92C7Nl841NKl0uLdctmYPkv
 kNeASf8QgmcA4fUExIQdJNWV2/uesXs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_okjqb2EPcyCVgv8MMQ9Hg-1; Thu, 03 Sep 2026 04:47:44 -0400
X-MC-Unique: _okjqb2EPcyCVgv8MMQ9Hg-1
X-Mimecast-MFC-AGG-ID: _okjqb2EPcyCVgv8MMQ9Hg_1788425263
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4509379a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788425263; x=1789030063; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
 b=GWPx9CFYEkknGXFKBLi5LWa9GNljDnmRy42gu6NIMJ+Pde5HLN2veVRtewQqUST4Fv
 f4XaIzKWPOj6ylPwgUOxrnxl1m0xI9vSwHlQvkNjAvbe+Tn/D/14sMtNw62Mv6WNiICd
 Ki7JILVkymR/KDQwote457ZdNF6f5b+bUdqIy/F0Grb/isM7cmQv+bIDXBlft77Ut82p
 wJoARWZ+Itib+SguYn6pt1f0W019x2oKWZfwK8aTGEVEWhej97QZdstkmuJlrQsQtS/R
 MFaoC67yze5Ea3Ok41IOTwSIN5ffwyg9QUXoe+LpZ3Hr4kb6tuBRMAq0KO53NVcAPlxU
 gFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788425263; x=1789030063;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
 b=O7PnD0iADlHM0V+SVh/bRCv4Y5LvvNUVTaMbBYfGx9n9X0s30Bv11NKBaaEGREmFco
 h9GXhNsrop+o6QzfhQEvvQ9zwrFzxXVGGQdhFX8Mg8JdDsohVxHVQc9ssmRU9SXIB+bG
 VbHxigpdaIqLGxQ9JXxHCs5qo4ke9raHpLo88nAd1PXQ+goMujEAxES23pk267Fxz73D
 kcjMFNgQ5MmQlO58ZbhqB7Pd8iVgeso3CcIobhsOsIC4IrCMZ1rUTg5ySbOWpWivllZN
 VF59SinWsH6KYHtr5fvsWty6Jz5sNPiamXxV0jFlzRUbPAGRm+4RHysJIxPz8JhmyuS4
 K/xQ==
X-Gm-Message-State: AFuF++mtDAfctA1wQHQgyWJ2ldjsmXVGhFZ5upB3ZT+SnfEjby/FipGw
 HG4Dfe7rimzO8ZWnZBj+UxHwjG72UQOuNE73jDSeDXH7cZEmBnXey8pqa0hjJTqOcs0KFScRtyo
 o5XFklQI1AFNeESomfbhp4jjzRuIc2QSrAf2aLZybV9941Tq+tKKTmx8X
X-Gm-Gg: AYBFou3KLYVmEIa239/NDD4PM+bzvnnfnSpoPprYfa0c8rl/SAgwuaatqWj2xKOhksO
 dqyBvtWRHMxiP0GhfjqXBuHLjb1ZHhdtcX2qocAcVY+SbMrUCmFtwpaTrXfZy/YkTY3ti6PKl/Z
 S8//cNUJzZeP5I4J6TVHPjrAr2J+4q930uM/qTT0RbMg8xr2UTbhRv/1faWY8VCBz0HliPUfw0p
 RIdhURl25L3zMYFD0rQZuZWW+Zr57E8ar2wm+UpS7BbzCWKogIGIneOfIQcBDJkU1x692VRF0go
 /zH72u3/pmpJIlNek6UD/BZRecfLawhPMU+wZrPKsIA5KacoWbwVTQ+zbG507Jx1ngxY6KhtcCC
 hcWoegskTNme71N36ndecLMRNPsB8xqwLmbAhGa6HNEbvaa5jAyou9kE=
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39aedbfe60amr17561147a91.0.1788425262600; 
 Thu, 03 Sep 2026 01:47:42 -0700 (PDT)
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39aedbfe60amr17561067a91.0.1788425261959; 
 Thu, 03 Sep 2026 01:47:41 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.47.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 01:47:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:17:28 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7F97AAC-1ABD-4AD6-9793-2DBB6B5E4C2C@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The guest policy must be provided at guest launch start: LAUNCH_START =
for
> SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
> specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
> specification, section 4.3 (Guest Policy).
>=20
> The policy parameter in set_guest_policy was never effective: by the
> time this callback runs, LAUNCH_START has already been issued for both
> SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
> sev_guest->policy has no effect. In practice the only thing this
> callback actually does is set the ID block and ID auth for SNP's
> LAUNCH_FINISH, so rename it to set_id_block to reflect its real
> purpose, remove the unused policy parameter, and drop the non-SNP code
> path which was entirely dead.
>=20
> This is preliminary work: actually forwarding the guest policy to the
> platform before LAUNCH_START is added in a later commit.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/confidential-guest-support.c       |  12 ++-
> backends/igvm.c                             |   6 +-
> include/system/confidential-guest-support.h |  28 ++++---
> target/i386/sev.c                           | 118 =
+++++++++++-----------------
> 4 files changed, 67 insertions(+), 97 deletions(-)
>=20
> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
> index 156dd15e66..a0b36d2da5 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>     return -1;
> }
>=20
> -static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> -                            uint64_t policy,
> -                            void *policy_data1, uint32_t =
policy_data1_size,
> -                            void *policy_data2, uint32_t =
policy_data2_size,
> -                            Error **errp)
> +static int set_id_block(void *id_block, uint32_t id_block_size,
> +                        void *id_auth, uint32_t id_auth_size,
> +                        Error **errp)
> {
>     error_setg(errp,
> -               "Setting confidential guest policy is not supported =
for this platform");
> +               "Setting ID block is not supported for this =
platform");
>     return -1;
> }
>=20
> @@ -64,7 +62,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support =3D check_support;
>     cgsc->set_guest_state =3D set_guest_state;
> -    cgsc->set_guest_policy =3D set_guest_policy;
> +    cgsc->set_id_block =3D set_id_block;
>     cgsc->get_mem_map_entry =3D get_mem_map_entry;
> }
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 7b7bdc72b7..85de0d54ec 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error =
**errp)
>             id_block_len =3D sizeof(struct sev_id_block);
>             id_auth_len =3D sizeof(struct sev_id_authentication);
>         }
> -        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, =
ctx->sev_policy,
> -                                          ctx->id_block, =
id_block_len,
> -                                          ctx->id_auth, id_auth_len, =
errp);
> +
> +        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
> +                                       ctx->id_auth, id_auth_len, =
errp);
>     }
>     return 0;
> }
> diff --git a/include/system/confidential-guest-support.h =
b/include/system/confidential-guest-support.h
> index 5dca717308..6d35ddb97a 100644
> --- a/include/system/confidential-guest-support.h
> +++ b/include/system/confidential-guest-support.h
> @@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>                            uint16_t cpu_index, Error **errp);
>=20
>     /*
> -     * Set the guest policy. The policy can be used to configure the
> -     * confidential platform, such as if debug is enabled or not and =
can contain
> -     * information about expected launch measurements, signed =
verification of
> -     * guest configuration and other platform data.
> -     *
> -     * The format of the policy data is specific to each platform. =
For example,
> -     * SEV-SNP uses a policy bitfield in the 'policy' argument and =
provides an
> -     * ID block and ID authentication in the 'policy_data' =
parameters. The type
> -     * of policy data is identified by the 'policy_type' argument.
> +     * Set the guest policy for the confidential platform. The policy
> +     * configures properties of the guest, such as whether debug is
> +     * enabled. Its format is platform-specific; for SEV/SEV-ES and
> +     * SEV-SNP it is a policy bitfield. Must be called before =
LAUNCH_START
> +     * so the policy is in effect for launch.
>      */
>     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
> -                            uint64_t policy,
> -                            void *policy_data1, uint32_t =
policy_data1_size,
> -                            void *policy_data2, uint32_t =
policy_data2_size,
> -                            Error **errp);
> +                            uint64_t policy, Error **errp);
> +
> +    /*
> +     * Set the SEV-SNP ID block and ID authentication block. These =
are
> +     * passed to SNP_LAUNCH_FINISH to provide signed verification of =
the
> +     * guest configuration.
> +     */
> +    int (*set_id_block)(void *id_block, uint32_t id_block_size,
> +                        void *id_auth, uint32_t id_auth_size,
> +                        Error **errp);
>=20
>     /*
>      * Iterate the system memory map, getting the entry with the given =
index
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 4d875d10ff..465415c535 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2723,10 +2723,9 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>=20
> -static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> -                                uint64_t policy, void *policy_data1,
> -                                uint32_t policy_data1_size, void =
*policy_data2,
> -                                uint32_t policy_data2_size, Error =
**errp)
> +static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
> +                            void *id_auth, uint32_t id_auth_size,
> +                            Error **errp)
> {
>     SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>     if (sev_common->state =3D=3D SEV_STATE_UNINIT) {
> @@ -2734,86 +2733,57 @@ static int =
cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>         return 0;
>     }
>=20
> -    if (policy_type !=3D GUEST_POLICY_SEV) {
> -        error_setg(errp, "SEV: Invalid guest policy type provided for =
SEV: %d",
> -                   policy_type);
> +    if (!sev_snp_enabled()) {
> +        error_setg(errp, "SEV: ID block is only supported for =
SEV-SNP");
>         return -1;
>     }
> -    /*
> -     * SEV-SNP handles policy differently. The policy flags are =
defined in
> -     * kvm_start_conf.policy and an ID block and ID auth can be =
provided.
> -     */
> -    if (sev_snp_enabled()) {
> -        SevSnpGuestState *sev_snp_guest =3D
> -            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> -        struct kvm_sev_snp_launch_finish *finish =3D
> -            &sev_snp_guest->kvm_finish_conf;
>=20
> -        /*
> -         * The policy consists of flags in 'policy' and optionally an =
ID block
> -         * and ID auth in policy_data1 and policy_data2 respectively. =
The ID
> -         * block and auth are optional so clear any previous ID block =
and auth
> -         * and set them if provided, but always set the policy flags.
> -         */
> -        g_free(sev_snp_guest->id_block);
> -        g_free((guchar *)finish->id_block_uaddr);
> -        g_free(sev_snp_guest->id_auth);
> -        g_free((guchar *)finish->id_auth_uaddr);
> -        sev_snp_guest->id_block =3D NULL;
> -        finish->id_block_uaddr =3D 0;
> -        sev_snp_guest->id_auth =3D NULL;
> -        finish->id_auth_uaddr =3D 0;
> -
> -        if (policy_data1_size > 0) {
> -            struct sev_snp_id_authentication *id_auth =3D
> -                (struct sev_snp_id_authentication *)policy_data2;
> -
> -            if (policy_data1_size !=3D KVM_SEV_SNP_ID_BLOCK_SIZE) {
> -                error_setg(errp, "SEV: Invalid SEV-SNP ID block: =
incorrect size");
> -                return -1;
> -            }
> -            if (policy_data2_size !=3D KVM_SEV_SNP_ID_AUTH_SIZE) {
> -                error_setg(errp,
> -                           "SEV: Invalid SEV-SNP ID auth block: =
incorrect size");
> -                return -1;
> -            }
> -            assert(policy_data1 !=3D NULL);
> -            assert(policy_data2 !=3D NULL);
> +    SevSnpGuestState *sev_snp_guest =3D
> +        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    struct kvm_sev_snp_launch_finish *finish =3D
> +        &sev_snp_guest->kvm_finish_conf;
>=20
> -            finish->id_block_uaddr =3D
> -                (__u64)g_memdup2(policy_data1, =
KVM_SEV_SNP_ID_BLOCK_SIZE);
> -            finish->id_auth_uaddr =3D
> -                (__u64)g_memdup2(policy_data2, =
KVM_SEV_SNP_ID_AUTH_SIZE);
> +    g_free(sev_snp_guest->id_block);
> +    g_free((guchar *)finish->id_block_uaddr);
> +    g_free(sev_snp_guest->id_auth);
> +    g_free((guchar *)finish->id_auth_uaddr);
> +    sev_snp_guest->id_block =3D NULL;
> +    finish->id_block_uaddr =3D 0;
> +    sev_snp_guest->id_auth =3D NULL;
> +    finish->id_auth_uaddr =3D 0;
>=20
> -            /*
> -             * Check if an author key has been provided and use that =
to flag
> -             * whether the author key is enabled. The first of the =
author key
> -             * must be non-zero to indicate the key type, which will =
currently
> -             * always be 2.
> -             */
> -            sev_snp_guest->kvm_finish_conf.auth_key_en =3D
> -                id_auth->author_key[0] ? 1 : 0;
> -            finish->id_block_en =3D 1;
> -        }
> +    if (id_block_size > 0) {
> +        struct sev_snp_id_authentication *auth =3D
> +            (struct sev_snp_id_authentication *)id_auth;
>=20
> -        /* do not reset existing policy if policy was not set in IGVM =
 */
> -        if (policy !=3D 0) {
> -            sev_snp_guest->kvm_start_conf.policy =3D policy;
> +        if (id_block_size !=3D KVM_SEV_SNP_ID_BLOCK_SIZE) {
> +            error_setg(errp, "SEV: Invalid SEV-SNP ID block: =
incorrect size");
> +            return -1;
>         }
> -    } else {
> -        SevGuestState *sev_guest =3D =
SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> -        /* Only the policy flags are supported for SEV and SEV-ES */
> -        if ((policy_data1_size > 0) || (policy_data2_size > 0) || =
!sev_guest) {
> -            error_setg(errp, "SEV: An ID block/ID auth block has been =
provided "
> -                             "but SEV-SNP is not enabled");
> +        if (id_auth_size !=3D KVM_SEV_SNP_ID_AUTH_SIZE) {
> +            error_setg(errp,
> +                       "SEV: Invalid SEV-SNP ID auth block: incorrect =
size");
>             return -1;
>         }
> +        assert(id_block !=3D NULL);
> +        assert(id_auth !=3D NULL);
>=20
> -        /* do not reset existing policy if policy was not set in IGVM =
 */
> -        if (policy !=3D 0) {
> -            sev_guest->policy =3D policy;
> -        }
> +        finish->id_block_uaddr =3D
> +            (__u64)g_memdup2(id_block, KVM_SEV_SNP_ID_BLOCK_SIZE);
> +        finish->id_auth_uaddr =3D
> +            (__u64)g_memdup2(id_auth, KVM_SEV_SNP_ID_AUTH_SIZE);
> +
> +        /*
> +         * Check if an author key has been provided and use that to =
flag
> +         * whether the author key is enabled. The first of the author =
key
> +         * must be non-zero to indicate the key type, which will =
currently
> +         * always be 2.
> +         */
> +        sev_snp_guest->kvm_finish_conf.auth_key_en =3D
> +            auth->author_key[0] ? 1 : 0;
> +        finish->id_block_en =3D 1;
>     }
> +
>     return 0;
> }
>=20
> @@ -2878,7 +2848,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support =3D cgs_check_support;
>     cgs->set_guest_state =3D cgs_set_guest_state;
>     cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
> -    cgs->set_guest_policy =3D cgs_set_guest_policy;
> +    cgs->set_id_block =3D cgs_set_id_block;
>     cgs->can_rebuild_guest_state =3D true;
>=20
>     QTAILQ_INIT(&sev_common->launch_vmsa);
>=20
> --=20
> 2.55.0
>=20


