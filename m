Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373BEC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x235z-0007wz-5A; Thu, 03 Sep 2026 04:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x235w-0007wn-Tz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x235u-0007B4-Q8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788425209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
 b=VKclnHos0qL4r68O8QJ8OTKuVuhkXbracrl0Rcc7qyzMfRxp3iznCwSPnFv/GS/CT0xrBt
 9m54f9z9rzPXLr9bOW2MVRxvgu2D/GJRlRsIqxEoJdnmDh/2VbD8hiBtDlAjecXvs2okO7
 ztYeFR/dO7AEUoe/AkBrCIq+lVZVJmg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-u5EnujJKNZus35qAE5yNlA-1; Thu, 03 Sep 2026 04:46:48 -0400
X-MC-Unique: u5EnujJKNZus35qAE5yNlA-1
X-Mimecast-MFC-AGG-ID: u5EnujJKNZus35qAE5yNlA_1788425207
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4507035a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788425207; x=1789030007; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
 b=YIp1xmmr4ty/slUftyM5EyKR2/7AV3UYVNbvV3SDy9rRNarXGLyt1MwrB4JstQPJP9
 lHra27QP9W7owJgsl8PFzL0Mpm9drqrMnKn+KYw8iKFk38nqXq+7gLyIyVAO48qhPW07
 e3dGNh3xSapm36P3zm7n2JoyZLozD8oXK2p14APjUVUZD5M/sLLtkkssQVKBJIyWZiVh
 MjbT7nGxiTnof07F10td1gjZicGMA57zV63kZShTpP6+xUnJZdoUXKHhpEFOaPOWS3r0
 /wmeVKQuO16UDiRWREtJRXJ05xYPWNxTrVc67ZeR6LkzQFUcuqFEwii1hbdgBKW81aKi
 Z7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788425207; x=1789030007;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
 b=SOgLaFjIiNINpvJM9bJs2ZJHUdAcrpXVd1EgblGfyA5clh2jJHrHE8uv3LgLd+tJ5s
 clIbjVUlE/Nlp4GIanHB86pQ0jOngFNeUGNNrayDPk16pd2uVRB1xIm7WXGa9bvRGgWU
 cd5/bewjni0SW8aDKSF39NM528HYwLyaO1/bPf9sFWg3ewtF6GEUuTPxyU8ZHoyA90F4
 UiVuI9kE6dU3rcTNpraggXH0kqlBVTlWC94A4mostl5DxncVMjNRrGU2787SnKAkudM8
 OpLHIYq76CRHo9/Fn1pH6xJoToUCnFKfS0Vf6GeAG+buY8K1fhXRMIdMgQybGbyfLzHI
 B35g==
X-Gm-Message-State: AFuF++kcK1xXjuPTblr9R//qWCOOLfaOFay1vPOosPb7m45j9aFNFGQn
 66B2xX/dWGO4Uz6pM1xCaIEzbvPPF+X1XnpnfDVslK1R5+NmvFlM8Y3oqSqWtIyrpsggRNsY3jd
 WurgZaaR1tv7lr9aeWuozLmrtNgAGG1cxuTRHLQkpYhNWBOw9u4sDCU3v
X-Gm-Gg: AYBFou1XtZnu25YaguHetQVUkDqU16CXSmo+NWWLQOX7LgkJfOWHdNm0yw+Z6Ek2MbP
 zZwWdAbdl06O6U8amhHP7h7huwZe6smG49pNU4Jddel4StN5N7Q6FWLdUUJ2ifjYoCyk5oZykXw
 sVaETwSlpkRbPmo4b4oX55oXZDGbJANRyGQlY/QOrsCp99g7L1OrdUNogHo+i1E2zdK9hTNia8B
 fVTCjpXVwuhdZUrcZouvmZXQqRB5NLE3NWLVMfflihRF8w4pdlnW8CsCn3HHutMg+JEl8aJh6F8
 bbL2fqfnmMvyyfVR/mGJ2H3fZSyUzQt/ZXOD4/uis6ewxIpUeKGEtkjToHVCzYQocMfr60rI6LA
 CgYc88hFc3Gs26NSZZGb8lOzUcYgDjPYJ1OFlYs687/hnPwp5xSFR56A=
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39aede9368amr17337782a91.1.1788425206996; 
 Thu, 03 Sep 2026 01:46:46 -0700 (PDT)
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39aede9368amr17337711a91.1.1788425206463; 
 Thu, 03 Sep 2026 01:46:46 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.46.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 01:46:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:16:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The guest policy carried in the IGVM guest-policy initialization =
header
> was parsed into QIgvm but never forwarded to the confidential guest
> platform: the previous callback ran at the end of qigvm_process_file,
> after LAUNCH_START had already been issued, so writing the policy had
> no effect.
>=20
> Add a set_guest_policy callback and invoke it from the guest-policy
> initialization handler, so the policy reaches the platform before
> LAUNCH_START.
>=20
> The guest policy can also be set on the command line. As it is part of
> the attestation report, silently overriding it would cause attestation
> to fail, so return an error if the command-line value differs from the
> one supplied by the IGVM file.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> backends/confidential-guest-support.c |  9 ++++++++
> backends/igvm.c                       |  4 ++++
> target/i386/sev.c                     | 39 =
+++++++++++++++++++++++++++++++++++
> 3 files changed, 52 insertions(+)
>=20
> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
> index a0b36d2da5..c0d15b4a76 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>     return -1;
> }
>=20
> +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> +                            uint64_t policy, Error **errp)
> +{
> +    error_setg(errp,
> +               "Setting guest policy is not supported for this =
platform");
> +    return -1;
> +}
> +
> static int set_id_block(void *id_block, uint32_t id_block_size,
>                         void *id_auth, uint32_t id_auth_size,
>                         Error **errp)
> @@ -62,6 +70,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support =3D check_support;
>     cgsc->set_guest_state =3D set_guest_state;
> +    cgsc->set_guest_policy =3D set_guest_policy;
>     cgsc->set_id_block =3D set_id_block;
>     cgsc->get_mem_map_entry =3D get_mem_map_entry;
> }
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 6545382546..5131ee7829 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -868,6 +868,10 @@ static int =
qigvm_initialization_guest_policy(QIgvm *ctx,
>=20
>     if (guest->compatibility_mask & ctx->compatibility_mask) {
>         ctx->sev_policy =3D guest->policy;
> +        if (ctx->cgsc) {
> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
> +                                               guest->policy, errp);
> +        }
>     }
>     return 0;
> }
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c76cdba8d2..533ea4b54e 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -128,6 +128,8 @@ struct SevCommonState {
>     bool kernel_hashes;
>     uint64_t sev_features;
>     uint64_t supported_sev_features;
> +    /* whether the guest policy was explicitly set on the command =
line */
> +    bool policy_set;
>=20
>     /* runtime state */
>     uint8_t api_major;
> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>=20
> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> +                                uint64_t policy, Error **errp)
> +{
> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +
> +    if (policy_type !=3D GUEST_POLICY_SEV) {
> +        error_setg(errp, "SEV: Invalid guest policy type provided for =
SEV: %d",
> +                   policy_type);
> +        return -1;
> +    }
> +
> +    if (sev_snp_enabled()) {
> +        SevSnpGuestState *sev_snp_guest =3D =
SEV_SNP_GUEST(sev_common);
> +
> +        if (sev_common->policy_set &&
> +            sev_snp_guest->kvm_start_conf.policy !=3D policy) {
> +            error_setg(errp, "SNP: policy mismatch between IGVM and =
CLI");
> +            return -1;
> +        }
> +
> +        sev_snp_guest->kvm_start_conf.policy =3D policy;

I had fixed a bug initially here where we need to check if the policy =
passed is not 0. I am not sure if that fix is still needed here.
Please test this scenario:
a) Generate an IGVM file with policy set to 0.
b) Start a confidential SEV-SNP guest with policy set in command line =
and with this IGVM.
I think with your patch this will fail as the policies won=E2=80=99t =
match. This potentially breaks some tests. For example, with your patch, =
does my FUKI confidential tests still pass?
c) If b) works, reset the guest and check if the guest is still a =
SEV-SNP guest.
=20

> +    } else {
> +        SevGuestState *sev_guest =3D SEV_GUEST(sev_common);
> +
> +        if (sev_common->policy_set && sev_guest->policy !=3D policy) =
{
> +            error_setg(errp, "SEV: policy mismatch between IGVM and =
CLI");
> +            return -1;
> +        }
> +
> +        sev_guest->policy =3D policy;
> +    }
> +    return 0;
> +}
> +
> static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
>                             void *id_auth, uint32_t id_auth_size,
>                             Error **errp)
> @@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support =3D cgs_check_support;
>     cgs->set_guest_state =3D cgs_set_guest_state;
>     cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
> +    cgs->set_guest_policy =3D cgs_set_guest_policy;
>     cgs->set_id_block =3D cgs_set_id_block;
>     cgs->can_rebuild_guest_state =3D true;
>=20
> @@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, =
const char *name,
>     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
>         return;
>     }
> +    SEV_COMMON(obj)->policy_set =3D true;
> }
>=20
> static void
> @@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor =
*v, const char *name,
>                            errp)) {
>         return;
>     }
> +    SEV_COMMON(obj)->policy_set =3D true;
> }
>=20
> static char *
>=20
> --=20
> 2.55.0
>=20


