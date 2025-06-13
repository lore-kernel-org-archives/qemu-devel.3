Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23FFC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3HL-0000MH-Nr; Fri, 13 Jun 2025 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uQ3H5-0000IK-Mh
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uQ3Gr-0000A9-KP
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749816701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fg1H1DuBtar9wkq/WJvNEG9SfQj9gpQbGWmAwl23Jig=;
 b=QGAOyOReG57vsBkq9VpYmiNIe4jrULgWNGNsgdhASseu9Jzh/+WHynsKHzYtNMUWVEyxNB
 ImqlmY3Go6nckTKG60z6B38daKkgKPcbD9PGm/jzr9k9pQDaMRTL/advQrlvV9ps/UESw6
 SaqnI1GsZsV+LIgNErk+MiP9D/536Uw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-pHY_IlqHMMWZbnlUN0zJ1A-1; Fri, 13 Jun 2025 08:11:40 -0400
X-MC-Unique: pHY_IlqHMMWZbnlUN0zJ1A-1
X-Mimecast-MFC-AGG-ID: pHY_IlqHMMWZbnlUN0zJ1A_1749816699
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b2c37558eccso1567977a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 05:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749816699; x=1750421499;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fg1H1DuBtar9wkq/WJvNEG9SfQj9gpQbGWmAwl23Jig=;
 b=hxcah0Q9x8BgeGBvsY+9z0YAzG4+8yPiFGKbhgIi92DU1o6RKK33rLd5xjYXnw6IDN
 2cZfaK84RqH1C0n98KhFrNPKoIu7qNP/UbGQsLUoEuqFiO76Ueh3m0HOlGOCPrOyruQ7
 fNefYtbrgWFEWshTRQ6nRQTXLAgmN8Y74uMt5IWL8jrz41wZHQeevHPN8Jkd3n00aen2
 PIpEFWBvwe1XZfqG+ILVWY4lsr+GjTI+igvQn/zfbwSR55SCApz4GMfKSK6jQBXKpQGF
 ZQU6l5MyRZLkXMiYME/NkvH5eUO6u4kj7tP0YDa0RlQzF0rqByIaXJj9IiXOesE83HBk
 O83A==
X-Gm-Message-State: AOJu0Yx/xfimRH5mvFDpctvbAUzO5ktJbV3DozUGrLwSogoRoWk8JZ3x
 K5P9EJTU5CdiDKZUXQfaaA/yZbpfxsxQV30N98j8PJfEW7MPPyT4/dBqsYfPu/DL7GEmCozJCQS
 hkVVTm0XYvS0zSSLV3PLKe2qzFRv0ZwKT7m+PU4zXLtr3dqYDFAkz9U+S
X-Gm-Gg: ASbGncsX/99/NK5wdeAuvQLY97oQzkCAgNeSgiBYSxywLH0i6FN3KlfvRrpDj7UMada
 CMKYSWSa6/Ta9AlrZnqflTia5HC+t/z8aRNCWBg19KeqEfrGGJkw0YvZfnFDvm/FwKqdbtPIyYg
 UAlCbdvNto9QN6jJGrOrKwjaB7vBPO6Lg7uqsv28Skf1IZbaOkH9Ba2BbiXLUZXc82NlhriMCrZ
 fqlnsnav/i5E87m26h9jTdxvHnJ3blM0Vqsr3D1gZhnsoC3hljiTFqbdRdmjcotKVsMT5svsuVv
 VxbGQH5KdHgNRayUzIrycRKlGszmvb+2+IEzgGVE
X-Received: by 2002:a05:6a21:6f07:b0:1fd:ecfa:b6d7 with SMTP id
 adf61e73a8af0-21fad092193mr4095958637.28.1749816699441; 
 Fri, 13 Jun 2025 05:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEhLVr1RqLbfH7lwIYYRV3QMETgSiG7NbwJh62CWzR8e4JuUQXSMA98zjfuFASLU34f4BDgw==
X-Received: by 2002:a05:6a21:6f07:b0:1fd:ecfa:b6d7 with SMTP id
 adf61e73a8af0-21fad092193mr4095931637.28.1749816699037; 
 Fri, 13 Jun 2025 05:11:39 -0700 (PDT)
Received: from smtpclient.apple ([223.235.162.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7489008301dsm1410883b3a.78.2025.06.13.05.11.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Jun 2025 05:11:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v7 15/16] i386/sev: Add implementation of CGS
 set_guest_policy()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ec4fb8e4.AUUAAGN5T_UAAAAAAAAAA9cBm3AAAYKJZwAAAAAAAC5ATwBnwULW@mailjet.com>
Date: Fri, 13 Jun 2025 17:41:21 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Joerg Roedel <jroedel@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18D52538-820A-44BE-82CB-FF960882A414@redhat.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <ec4fb8e4.AUUAAGN5T_UAAAAAAAAAA9cBm3AAAYKJZwAAAAAAAC5ATwBnwULW@mailjet.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 27 Feb 2025, at 7:59=E2=80=AFPM, Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>=20
> The new cgs_set_guest_policy() function is provided to receive the =
guest
> policy flags, SNP ID block and SNP ID authentication from guest
> configuration such as an IGVM file and apply it to the platform prior =
to
> launching the guest.
>=20
> The policy is used to populate values for the existing 'policy',
> 'id_block' and 'id_auth' parameters. When provided, the guest policy =
is
> applied and the ID block configuration is used to verify the launch
> measurement and signatures. The guest is only successfully started if
> the expected launch measurements match the actual measurements and the
> signatures are valid.
>=20
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> target/i386/sev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
> target/i386/sev.h | 12 +++++++
> 2 files changed, 95 insertions(+)
>=20
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 31b29695bf..fa9b4bcad6 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2526,6 +2526,88 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>=20
> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> +                                uint64_t policy, void *policy_data1,
> +                                uint32_t policy_data1_size, void =
*policy_data2,
> +                                uint32_t policy_data2_size, Error =
**errp)
> +{
> +    if (policy_type !=3D GUEST_POLICY_SEV) {
> +        error_setg(errp, "%s: Invalid guest policy type provided for =
SEV: %d",
> +        __func__, policy_type);
> +        return -1;
> +    }
> +    /*
> +     * SEV-SNP handles policy differently. The policy flags are =
defined in
> +     * kvm_start_conf.policy and an ID block and ID auth can be =
provided.
> +     */
> +    if (sev_snp_enabled()) {
> +        SevSnpGuestState *sev_snp_guest =3D
> +            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +        struct kvm_sev_snp_launch_finish *finish =3D
> +            &sev_snp_guest->kvm_finish_conf;
> +
> +        /*
> +         * The policy consists of flags in 'policy' and optionally an =
ID block
> +         * and ID auth in policy_data1 and policy_data2 respectively. =
The ID
> +         * block and auth are optional so clear any previous ID block =
and auth
> +         * and set them if provided, but always set the policy flags.
> +         */
> +        g_free(sev_snp_guest->id_block);
> +        g_free((guchar *)finish->id_block_uaddr);
> +        g_free(sev_snp_guest->id_auth);
> +        g_free((guchar *)finish->id_auth_uaddr);
> +        sev_snp_guest->id_block =3D NULL;
> +        finish->id_block_uaddr =3D 0;
> +        sev_snp_guest->id_auth =3D NULL;
> +        finish->id_auth_uaddr =3D 0;
> +
> +        if (policy_data1_size > 0) {
> +            struct sev_snp_id_authentication *id_auth =3D
> +                (struct sev_snp_id_authentication *)policy_data2;
> +
> +            if (policy_data1_size !=3D KVM_SEV_SNP_ID_BLOCK_SIZE) {
> +                error_setg(errp, "%s: Invalid SEV-SNP ID block: =
incorrect size",
> +                           __func__);
> +                return -1;
> +            }
> +            if (policy_data2_size !=3D KVM_SEV_SNP_ID_AUTH_SIZE) {
> +                error_setg(errp,
> +                           "%s: Invalid SEV-SNP ID auth block: =
incorrect size",
> +                           __func__);
> +                return -1;
> +            }
> +            assert(policy_data1 !=3D NULL);
> +            assert(policy_data2 !=3D NULL);
> +
> +            finish->id_block_uaddr =3D
> +                (__u64)g_memdup2(policy_data1, =
KVM_SEV_SNP_ID_BLOCK_SIZE);
> +            finish->id_auth_uaddr =3D
> +                (__u64)g_memdup2(policy_data2, =
KVM_SEV_SNP_ID_AUTH_SIZE);
> +
> +            /*
> +             * Check if an author key has been provided and use that =
to flag
> +             * whether the author key is enabled. The first of the =
author key
> +             * must be non-zero to indicate the key type, which will =
currently
> +             * always be 2.
> +             */
> +            sev_snp_guest->kvm_finish_conf.auth_key_en =3D
> +                id_auth->author_key[0] ? 1 : 0;
> +            finish->id_block_en =3D 1;
> +        }
> +        sev_snp_guest->kvm_start_conf.policy =3D policy;
> +    } else {

I do not see how this =E2=80=9Celse=E2=80=9D part (sev and sev-es) will =
ever be executed since qigvm_handle_policy() in patch #14 only calls =
set_guest_policy() if its SEV-SNP.


