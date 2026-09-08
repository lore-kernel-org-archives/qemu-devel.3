Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BA1C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pG4-0000lw-Eq; Tue, 08 Sep 2026 02:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x3pFy-0000le-14
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x3pFv-0001fl-IZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788848669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMjBPxv8/zBTrCWFA+iqDMuwR8oX9jkhsEYLYqJTcQc=;
 b=a7QEiiSm6pLT2X8zD97SMbiUucgD8N08LYOBx9VxlWJ3vVW0BwpE706izqeexfH5j/WJRJ
 TUinhrN2qnxxNsVbdVIdoz+K8kDbPmRkbTeiVHjs3qdNfZuyldQrvdf49XjNQDpHfvcGPH
 rOozYM2l7FSylbrkRy/2P51dLrxtHbg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-tGaVd8G6N5uYalaDQlti2g-1; Tue, 08 Sep 2026 02:24:28 -0400
X-MC-Unique: tGaVd8G6N5uYalaDQlti2g-1
X-Mimecast-MFC-AGG-ID: tGaVd8G6N5uYalaDQlti2g_1788848667
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso3716225a12.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788848667; x=1789453467; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XMjBPxv8/zBTrCWFA+iqDMuwR8oX9jkhsEYLYqJTcQc=;
 b=jlFubbe8YVSp0ZcdURARjv7FQV5QUe8exmgkSocHdIa91PYiNsXGZqMpbpH+xjeJrD
 KVuj8c77AWEHIupI967hx2M4/O59q/7wemgFKt3igjf1ioaPX4LUHvY/7ruj9mWbsD6F
 ydG/8sMZtoVaOwaALmEqVpY+GchorXDPzethJqLLKoIBKAY/akJ8yJYHqwAW1Sjj8j2o
 jjmEHEcafhzk55tpK7hY/WX83aOfzjp9d6z0+dsNiomNM+/fblidZac3pC8DvaNxN1G9
 vAkH3Tov7GBBp/kHZ3IJlkjNt/eNXPLyGBmWSDsR9EaYiHU86vzoIynPOtOctSbyEl8V
 94sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788848667; x=1789453467;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XMjBPxv8/zBTrCWFA+iqDMuwR8oX9jkhsEYLYqJTcQc=;
 b=EONc55YJNuIOcW8fV+ikOemuR5/kRa/2ciWbeh240vuLYgOn/l/BVIt/YdL5EJg3In
 bmjcfHGovczwEbDIbp57J4JeJfBkr7hl5oR73n53IC6d/lBT+KwrwTdMIzGrWgbw3Qer
 6FESs4l+L1PUd5q88h6DjkjZak6fgaYetyNqFsUAbMbPYIkmTHQdFoNE1bi2UvfEDrhs
 kG+LHYikpZJnLR+T+h/bcbxfsSf5n935sEe/+EVaFdIHfPczsebXInfzJg6CX1M8CY67
 qexB0dvQoEHVArnpPHvi7b0XDgUtei0pPUfXh46I8qOy55pqTPk+eBs749P7icvaH3xm
 9LAQ==
X-Gm-Message-State: AFuF++nvLoTCjtDTApQPok0A1q8f5fJSN796WK9bn0rkh/30Eb0VlOpE
 zDBmW66oEkcE9+B67OAEml04n5z8ZIwyTAX6PUsrfvgqKlLJEJtZSMfR9KPQb4mXEYVFl7GTF7B
 zkZtClDhrzTsQY573CdAyrbD7PxumpsEkB1zphSIiq0lie3nFEbozd+fO
X-Gm-Gg: AYBFou30jkmzTZd7vryhTBlvARiFDT/S4jxl6/uC/5p8JkeTEjqFq+xrKetlxdFivp6
 A7A5iPJNaVWlUItakbhnq4oZ9bnh87eGkNagc/RO+YuccHRwQHf6JLg0d4wnd/qsjygO8wPhL32
 aiUb2OgTZHc973iMj43lXjWicCJugBYaRsFnju0vQJjp2t1Im6378E5GGEWH71cUFjojE87FYtg
 7Qty0BAJi3+phQFbeBhr3HNGALSUnu/Pzs8A8okWjqX1/WktEsvX2mQMxC0OZ1v/eGQAWH4YkwU
 HBlwNauVGE6xrIrQqj5/3MDuRWyV4rdLW+1mmlmk16YN6jD5zZzITnKS6pl5SR1TI2Uo/sVL5dE
 7b+pYEzONlGuY8HJjqhAQtfITFYOlsYd5dKv/O6wG0UOfPVWEYBt9p4I=
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id
 d9443c01a7336-2db1235721dmr379791415ad.4.1788848667251; 
 Mon, 07 Sep 2026 23:24:27 -0700 (PDT)
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id
 d9443c01a7336-2db1235721dmr379790885ad.4.1788848666718; 
 Mon, 07 Sep 2026 23:24:26 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-333959d5f69sm31566202eec.0.2026.09.07.23.24.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Sep 2026 23:24:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 1/5] sev: split set_guest_policy into set_guest_policy
 and set_id_block
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-1-c8c50f1dbfda@redhat.com>
Date: Tue, 8 Sep 2026 11:54:10 +0530
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9D8EB24-B98B-47BE-9BF6-C6786D4EF6EB@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
 <20260907-fix_igvm_policy-v2-1-c8c50f1dbfda@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 7 Sep 2026, at 9:26=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The set_guest_policy callback on ConfidentialGuestSupportClass mixed
> two unrelated jobs: writing the guest policy bits and providing the
> SEV-SNP ID block/ID auth for LAUNCH_FINISH. The two are only related
> because both come from the same 'policy' section of the SEV/SEV-SNP
> launch flow, but they need to be set at different times: the policy
> must be in effect before LAUNCH_START, while the ID block is only
> needed before LAUNCH_FINISH.
>=20
> Split the combined callback into set_guest_policy(policy_type, policy,
> errp) and set_id_block(id_block, id_block_size, id_auth, id_auth_size,
> errp), keeping both call sites exactly where the combined callback =
used
> to be called from. No functional change.

LGTM.

Reviewed-by: Ani Sinha <anisinha@redhat.com>

>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> backends/confidential-guest-support.c       |  15 ++-
> backends/igvm.c                             |  14 ++-
> include/system/confidential-guest-support.h |  28 +++---
> target/i386/sev.c                           | 140 =
+++++++++++++++-------------
> 4 files changed, 111 insertions(+), 86 deletions(-)
>=20
> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
> index 156dd15e66..d60d1f6eaa 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -39,16 +39,22 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
> }
>=20
> static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> -                            uint64_t policy,
> -                            void *policy_data1, uint32_t =
policy_data1_size,
> -                            void *policy_data2, uint32_t =
policy_data2_size,
> -                            Error **errp)
> +                            uint64_t policy, Error **errp)
> {
>     error_setg(errp,
>                "Setting confidential guest policy is not supported for =
this platform");
>     return -1;
> }
>=20
> +static int set_id_block(void *id_block, uint32_t id_block_size,
> +                        void *id_auth, uint32_t id_auth_size,
> +                        Error **errp)
> +{
> +    error_setg(errp,
> +               "Setting ID block is not supported for this =
platform");
> +    return -1;
> +}
> +
> static int get_mem_map_entry(int index, =
ConfidentialGuestMemoryMapEntry *entry,
>                              Error **errp)
> {
> @@ -65,6 +71,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>     cgsc->check_support =3D check_support;
>     cgsc->set_guest_state =3D set_guest_state;
>     cgsc->set_guest_policy =3D set_guest_policy;
> +    cgsc->set_id_block =3D set_id_block;
>     cgsc->get_mem_map_entry =3D get_mem_map_entry;
> }
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 7b7bdc72b7..99304d6467 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -963,14 +963,22 @@ static int qigvm_handle_policy(QIgvm *ctx, Error =
**errp)
>     if (ctx->platform_type =3D=3D IGVM_PLATFORM_TYPE_SEV_SNP) {
>         int id_block_len =3D 0;
>         int id_auth_len =3D 0;
> +        int retval;
> +
>         if (ctx->id_block) {
>             ctx->id_block->policy =3D ctx->sev_policy;
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
> +        retval =3D ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, =
ctx->sev_policy,
> +                                             errp);
> +        if (retval < 0) {
> +            return retval;
> +        }
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
> index cc16c6b071..b53d13e2fa 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2726,9 +2726,7 @@ static int cgs_get_mem_map_entry(int index,
> }
>=20
> static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> -                                uint64_t policy, void *policy_data1,
> -                                uint32_t policy_data1_size, void =
*policy_data2,
> -                                uint32_t policy_data2_size, Error =
**errp)
> +                                uint64_t policy, Error **errp)
> {
>     SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>     if (sev_common->state =3D=3D SEV_STATE_UNINIT) {
> @@ -2741,81 +2739,90 @@ static int =
cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>                    policy_type);
>         return -1;
>     }
> -    /*
> -     * SEV-SNP handles policy differently. The policy flags are =
defined in
> -     * kvm_start_conf.policy and an ID block and ID auth can be =
provided.
> -     */
> +
> +    /* do not reset existing policy if policy was not set in IGVM  */
> +    if (policy =3D=3D 0) {
> +        return 0;
> +    }
> +
>     if (sev_snp_enabled()) {
>         SevSnpGuestState *sev_snp_guest =3D
>             SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
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
> +        sev_snp_guest->kvm_start_conf.policy =3D policy;
> +    } else {
> +        SevGuestState *sev_guest =3D =
SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
>=20
> -            finish->id_block_uaddr =3D
> -                (__u64)g_memdup2(policy_data1, =
KVM_SEV_SNP_ID_BLOCK_SIZE);
> -            finish->id_auth_uaddr =3D
> -                (__u64)g_memdup2(policy_data2, =
KVM_SEV_SNP_ID_AUTH_SIZE);
> +        sev_guest->policy =3D policy;
> +    }
> +    return 0;
> +}
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
> +static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
> +                            void *id_auth, uint32_t id_auth_size,
> +                            Error **errp)
> +{
> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    if (sev_common->state =3D=3D SEV_STATE_UNINIT) {
> +        /* Pre-processing of IGVM file called from =
sev_common_kvm_init() */
> +        return 0;
> +    }
> +
> +    if (!sev_snp_enabled()) {
> +        error_setg(errp, "SEV: ID block is only supported for =
SEV-SNP");
> +        return -1;
> +    }
>=20
> -        /* do not reset existing policy if policy was not set in IGVM =
 */
> -        if (policy !=3D 0) {
> -            sev_snp_guest->kvm_start_conf.policy =3D policy;
> +    SevSnpGuestState *sev_snp_guest =3D
> +        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    struct kvm_sev_snp_launch_finish *finish =3D
> +        &sev_snp_guest->kvm_finish_conf;
> +
> +    /*
> +     * Drop any ID block and ID auth from a previous pass before =
repopulating
> +     * them, then set them only if an ID block was provided.
> +     */
> +    g_free(sev_snp_guest->id_block);
> +    g_free((guchar *)finish->id_block_uaddr);
> +    g_free(sev_snp_guest->id_auth);
> +    g_free((guchar *)finish->id_auth_uaddr);
> +    sev_snp_guest->id_block =3D NULL;
> +    finish->id_block_uaddr =3D 0;
> +    sev_snp_guest->id_auth =3D NULL;
> +    finish->id_auth_uaddr =3D 0;
> +
> +    if (id_block_size > 0) {
> +        struct sev_snp_id_authentication *auth =3D
> +            (struct sev_snp_id_authentication *)id_auth;
> +
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
> @@ -2881,6 +2888,7 @@ sev_common_instance_init(Object *obj)
>     cgs->set_guest_state =3D cgs_set_guest_state;
>     cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
>     cgs->set_guest_policy =3D cgs_set_guest_policy;
> +    cgs->set_id_block =3D cgs_set_id_block;
>     cgs->can_rebuild_guest_state =3D true;
>=20
>     QTAILQ_INIT(&sev_common->launch_vmsa);
>=20
> --=20
> 2.55.0
>=20


