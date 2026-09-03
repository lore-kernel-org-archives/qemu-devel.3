Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA65EC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24IU-0000z6-F5; Thu, 03 Sep 2026 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x24IS-0000yv-9K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x24IQ-0007iQ-1h
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788429828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
 b=dAq4w+p9ukRr+TzfKPNZIARV0Uj6ZIB65c99v5lkpCJlpc/P5yUyWTPDHgF9G5XFgZs+Yj
 4x6n5dSjm/Z02PCBmYVIWTKON+rpHHYjExZHkOGrolxyWsfcAYjFKpMIdEVEy0t1kV9+uB
 GscXFd61qbBvP4b9pWHUndeH1p9fHtk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-nFwFJ1mTOWWu30jMzNzzkg-1; Thu, 03 Sep 2026 06:03:47 -0400
X-MC-Unique: nFwFJ1mTOWWu30jMzNzzkg-1
X-Mimecast-MFC-AGG-ID: nFwFJ1mTOWWu30jMzNzzkg_1788429826
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4659128a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788429826; x=1789034626; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
 b=Az1TiIZbzvDASK8oevYeeCT49W+A/RiUYirs2m3oazeLXszrlsJy1wFcsd7Nyhg0k3
 jTpWmF7WeoTt1j5Q5FJ6+nrfbxPLtVe+O1ck2OKEF+YnBzWvfFaZeQ/ABz1yxpiKxIKI
 pOe4oAMDyis/dNnne7BFAJeuxwbXYiaicVjDu5/yhp3bdkdKNu5CoIHmIfJOLPc39c2Y
 ktahAsFl+WDAoDCX3vJzoomDFjbggDmMnYbw1e9IhitscCIupIMYwXVwPwCxU3ckwfGC
 wLX0KzIfnQAKLGNK7HrnR2Ad5AiWrptNxl5hk/v6gLMFiPkj096NX3i3geB2jESrANhb
 IH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429826; x=1789034626;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
 b=dCTVJJZ8O1pgL6w4Fk0jKeQl3ooS9zVl3vMuWuPW4Wg/GiQBcfs4jSKKaXf5GsPXq7
 IangKUgTidr7juKxC9+sg18w6t3pvdpthefTC4c02Cr98AJK7oaNK5VgZujKnwfyvDkL
 gkesYrai2JY8uNMCcvYJ0dN+mpfERu76r8lb4/uAgAf6jJo6cBfN/XrKVa+uEdDEq+FL
 7xOeCthXv/MmL1dH1T1OLcQuOJgEE2RwPlhrQ0F9JemhaWQqWZ24q7CN2p93otS+yDvy
 oYRyxVrYUhxxGYGNCQHpVg9bPKiwvwfZYlrTGHrlBbknYIUPQrB1DxuZapo/Eu4waeKL
 vJrA==
X-Gm-Message-State: AFuF++nMtx2OQTmtco+q6nxhOoBKDEl/6cIs9o5vwGhUQ6ezhbSQorzL
 5DJ24TdM2ayNGB5kIv4oVnSnTrzh7uuMSISZHhYF2a0mCklBj/6D11eqo9HLIebyw7/LbCQx+Bs
 4i1fQLsthtX7tT0C7hPiUPM25GCG5xzYBnolzrr30McoW5w5IeiQqhPOn
X-Gm-Gg: AYBFou1dpPsM1pq44JaS38+HglF3EenPl3rhq3tpboGa/hkAHkDCR687cJWl6Z+z1SE
 qvfilYdie0DLCR0sB40Yw+0fFn8FBjjmXKhs8oP8lNK5yc4Y3ZzyqpaMu6EncpfETRtc4lD25Iz
 xRP/lcFasNYJV91LjJj1SEDEuvJQHLhuoT7jqCLD4MOEdAEsTaUHwUoH19syjZowChD49LB1zlR
 ucFnykMcr3avMnSKF4sI6EsNo9k1BtKQqkJVQTsarus1e2tqaCKccJENy+D7T5YibbF/ReSKFBn
 Zq22/W7d8DRZ3VKeeLByrq0fPc2SMbl2Grg5Os0L41CUohm8IScd42/gK3LJM7ROgozU+plnqik
 9oYFDOG6q8XdsWRm293XM9/z7EaTOx4qM0c76e70an1EFuTwcCYzrE/8=
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39aee04acdamr18816783a91.14.1788429826030; 
 Thu, 03 Sep 2026 03:03:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39aee04acdamr18816675a91.14.1788429825547; 
 Thu, 03 Sep 2026 03:03:45 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3325621af3bsm5020819eec.21.2026.09.03.03.03.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:03:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <apk1djopa9z3tfYR@leonardi-redhat>
Date: Thu, 3 Sep 2026 15:33:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
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



> On 3 Sep 2026, at 2:31=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Hi Ani,
>=20
> On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>=20
>>> The guest policy carried in the IGVM guest-policy initialization =
header
>>> was parsed into QIgvm but never forwarded to the confidential guest
>>> platform: the previous callback ran at the end of =
qigvm_process_file,
>>> after LAUNCH_START had already been issued, so writing the policy =
had
>>> no effect.
>>>=20
>>> Add a set_guest_policy callback and invoke it from the guest-policy
>>> initialization handler, so the policy reaches the platform before
>>> LAUNCH_START.
>>>=20
>>> The guest policy can also be set on the command line. As it is part =
of
>>> the attestation report, silently overriding it would cause =
attestation
>>> to fail, so return an error if the command-line value differs from =
the
>>> one supplied by the IGVM file.
>>>=20
>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>> ---
>>> backends/confidential-guest-support.c |  9 ++++++++
>>> backends/igvm.c                       |  4 ++++
>>> target/i386/sev.c                     | 39 =
+++++++++++++++++++++++++++++++++++
>>> 3 files changed, 52 insertions(+)
>>>=20
>>> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
>>> index a0b36d2da5..c0d15b4a76 100644
>>> --- a/backends/confidential-guest-support.c
>>> +++ b/backends/confidential-guest-support.c
>>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>>>    return -1;
>>> }
>>>=20
>>> +static int set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>> +                            uint64_t policy, Error **errp)
>>> +{
>>> +    error_setg(errp,
>>> +               "Setting guest policy is not supported for this =
platform");
>>> +    return -1;
>>> +}
>>> +
>>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>>                        void *id_auth, uint32_t id_auth_size,
>>>                        Error **errp)
>>> @@ -62,6 +70,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>>>    ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>    cgsc->check_support =3D check_support;
>>>    cgsc->set_guest_state =3D set_guest_state;
>>> +    cgsc->set_guest_policy =3D set_guest_policy;
>>>    cgsc->set_id_block =3D set_id_block;
>>>    cgsc->get_mem_map_entry =3D get_mem_map_entry;
>>> }
>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>> index 6545382546..5131ee7829 100644
>>> --- a/backends/igvm.c
>>> +++ b/backends/igvm.c
>>> @@ -868,6 +868,10 @@ static int =
qigvm_initialization_guest_policy(QIgvm *ctx,
>>>=20
>>>    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>        ctx->sev_policy =3D guest->policy;
>>> +        if (ctx->cgsc) {
>>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>> +                                               guest->policy, =
errp);
>>> +        }
>>>    }
>>>    return 0;
>>> }
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index c76cdba8d2..533ea4b54e 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>>    bool kernel_hashes;
>>>    uint64_t sev_features;
>>>    uint64_t supported_sev_features;
>>> +    /* whether the guest policy was explicitly set on the command =
line */
>>> +    bool policy_set;
>>>=20
>>>    /* runtime state */
>>>    uint8_t api_major;
>>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>    return 0;
>>> }
>>>=20
>>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>> +                                uint64_t policy, Error **errp)
>>> +{
>>> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>> +
>>> +    if (policy_type !=3D GUEST_POLICY_SEV) {
>>> +        error_setg(errp, "SEV: Invalid guest policy type provided =
for SEV: %d",
>>> +                   policy_type);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (sev_snp_enabled()) {
>>> +        SevSnpGuestState *sev_snp_guest =3D =
SEV_SNP_GUEST(sev_common);
>>> +
>>> +        if (sev_common->policy_set &&
>>> +            sev_snp_guest->kvm_start_conf.policy !=3D policy) {
>>> +            error_setg(errp, "SNP: policy mismatch between IGVM and =
CLI");
>>> +            return -1;
>>> +        }
>>> +
>>> +        sev_snp_guest->kvm_start_conf.policy =3D policy;
>=20
> Thanks for you review!
>=20
>>=20
>> I had fixed a bug initially here where we need to check if the policy =
passed is not 0. I am not sure if that fix is still needed here.
>> Please test this scenario:
>> a) Generate an IGVM file with policy set to 0.
>=20
> 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be =
1.
> It's a valid sev/sev-es policy though.
>=20
>> b) Start a confidential SEV-SNP guest with policy set in command line =
and with this IGVM.
>> I think with your patch this will fail as the policies won=E2=80=99t =
match.
>=20
> Correct: this was suggested by Gerd, as this is something unexpected. =
I
> think it would break launch measurement.

Yes I think the right thing to do is that if the policy is correctly set =
by IGVM, override the one set in the cli with the one in IGVM. Otherwise =
ignore IGVM policy.

>=20
>> This potentially breaks some tests. For example, with your patch, =
does my FUKI confidential tests still pass?
>=20
> To be fair, guest policy set via igvm _never_ worked. Only the =
policies
> set from CLI worked.
>=20
> That said, I'll try to run your tests.
>=20
> Luigi



