Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F7C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHQm-0001S9-QO; Mon, 01 Jul 2024 09:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOHQc-0001Rj-IE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:50:47 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOHQV-0001K9-Jl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:50:45 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ec58040f39so29237441fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719841836; x=1720446636; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fc1h+ByQnf26OQypPhylAde6YdCq9nsD7Cw/vqhEq5o=;
 b=L0y5ZEZgsVYEF6qPAZYOVkvD/DcdcP13rS7cjB9AbxAtIQzpIUozT5jqrtFx/TMZCw
 AX8g5al2zXA1wjSwAM9qSxfg76U0308M2POnoeMT2UfxpGYdsoAy1ynWQWgxu5si64Tk
 27bGERify4jdTfcY1LfJvWK0P2g2K5NasK0evTqcMih0lrcuXvNdN68Ingiy0HmJjVp5
 ohLcmU0SkQ/HfNQnG6qnm07EMPW8RW5aRwgxMgH05jUNFQAPc7ylFZplj4rQZKtpMtkq
 Zz3M4YmVRuXCNSaTNuLdKZCJ+YQBXA6kA0YnXjVmP3vApV5t2oRmSf4KFOFGYuZpJOT+
 IQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719841836; x=1720446636;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fc1h+ByQnf26OQypPhylAde6YdCq9nsD7Cw/vqhEq5o=;
 b=YjeF5OOKULeHB9n1pLZ+XalID/zSF8wXzuX5jXwrOPeuiYLejfxPwlxaf2NCanhcdh
 ENdyKo4lIpZTuoX8Royt5VqWfgZiBqrgCqj3kqBI6gL/OEa9Z/XA85irX3cCKsbZVuCX
 GcNjuseUFDLPR+6EY430v6dG/ikwVuztDO2vPBJR3X5t82wTkAIz9e1Te+aUXjwNzWNG
 MwVdbhABNbhBODYnvuo25TZbYifpaZ0YIcCUt50o6XMBgZGKwM5wrICBWEJhmP4czXrj
 g417IUAqQULfTCf9azbSQSorElOUYf+CvgAzQC4tFT+3JCzu9sPT+VYPnEvkO2mUHPY+
 YWxg==
X-Gm-Message-State: AOJu0Yy8TrzLRwugkrYSm8LeSpDOPQCs7jHZyyLxu9ElBvkbAhnr+sRu
 ed5znxCpMKeDjZFc6KA+TJL6ig9NLpWNVV2TW8djxxFyqwmzKfiWzY1HCWS2H+o=
X-Google-Smtp-Source: AGHT+IHlBaEoL5w/hBXdlDnKjGpm9OlQWwFQyMiMJk3xwu/q7wNu9vlIIFqUf7MqkcZpU5mMTt7RXw==
X-Received: by 2002:a05:651c:2223:b0:2ea:7d8f:8d12 with SMTP id
 38308e7fff4ca-2ee5e6e7c03mr43115011fa.48.1719841836327; 
 Mon, 01 Jul 2024 06:50:36 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecf74bsm6507143b3a.117.2024.07.01.06.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:50:35 -0700 (PDT)
Message-ID: <d6405bc34e4392bf9ed09c84c81ebd49e1dbded8.camel@suse.com>
Subject: Re: [PATCH v3 15/15] sev: Provide sev_features flags from IGVM VMSA
 to KVM_SEV_INIT2
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Mon, 01 Jul 2024 14:50:26 +0100
In-Reply-To: <Znl_VyXoV30-Cgob@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <8e49a1aed06d4f98c13a98fbbe3a48cdeb6e0070.1718979106.git.roy.hopkins@suse.com>
 <Znl_VyXoV30-Cgob@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::230;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 2024-06-24 at 15:14 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 21, 2024 at 03:29:18PM +0100, Roy Hopkins wrote:
> > IGVM files can contain an initial VMSA that should be applied to each
> > vcpu as part of the initial guest state. The sev_features flags are
> > provided as part of the VMSA structure. However, KVM only allows
> > sev_features to be set during initialization and not as the guest is
> > being prepared for launch.
> >=20
> > This patch queries KVM for the supported set of sev_features flags and
> > processes the IGVM file during kvm_init to determine any sev_features
> > flags set in the IGVM file. These are then provided in the call to
> > KVM_SEV_INIT2 to ensure the guest state matches that specified in the
> > IGVM file.
> >=20
> > This does cause the IGVM file to be processed twice. Firstly to extract
> > the sev_features then secondly to actually configure the guest. However=
,
> > the first pass is largely ignored meaning the overhead is minimal.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0target/i386/sev.c | 145 ++++++++++++++++++++++++++++++++++++++++-=
-----
> > =C2=A01 file changed, 126 insertions(+), 19 deletions(-)
> >=20
>=20
> > =C2=A0static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Err=
or **errp)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 char *devname;
> > @@ -1743,6 +1783,10 @@ static int
> > sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 if (sev_init_supported_features(sev_common, errp) <=
 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 trace_kvm_sev_init();
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST=
(sev_common)) =3D=3D
> > KVM_X86_DEFAULT_VM) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D sev_es_enabled=
() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
> > @@ -1750,6 +1794,38 @@ static int
> > sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sev_ioctl(sev_=
common->sev_fd, cmd, NULL, &fw_error);
> > =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_sev_init ar=
gs =3D { 0 };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineState *machine =3D M=
ACHINE(qdev_get_machine());
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If configuration is=
 provided via an IGVM file then the IGVM file
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * might contain confi=
guration of the initial vcpu context. For SEV
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the vcpu context in=
cludes the sev_features which should be
> > applied
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the vcpu.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * KVM does not synchr=
onize sev_features from CPU state. Instead it
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requires sev_featur=
es to be provided as part of this
> > initialization
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * call which is subse=
quently automatically applied to the VMSA of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * each vcpu.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The IGVM file is no=
rmally processed after initialization.
> > Therefore
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we need to pre-proc=
ess it here to extract sev_features in order
> > to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * provide it to KVM_S=
EV_INIT2. Each cgs_* function that is called
> > by
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the IGVM processor =
detects this pre-process by observing the
> > state
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as SEV_STATE_UNINIT=
.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (machine->igvm) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(IGVM_CFG_GET_CLASS(machine->igvm)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->process(machine->igvm, mach=
ine->cgs, errp) =3D=3D -1) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * KVM maintains a bitmask of allowed sev_features. This does
> > not
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by
> > KVM
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * itself. Therefore we need to clear this flag.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg=
s.vmsa_features =3D sev_common->sev_features &
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~SVM_SEV_FEAT_SNP_ACTIVE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sev_ioctl(sev_=
common->sev_fd, KVM_SEV_INIT2, &args,
> > &fw_error);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> What happens if the code path takes us down the KVM_SEV_INIT
> route, rather than KVM_SEV_INIT2 ?=C2=A0 Should we be reporting an
> error indicating that IGVM usage is incompatible with the legacy
> KVM_SEV_INIT path ?
>=20
>=20
> With regards,
> Daniel

The idea is that sev_common->supported_sev_features is initialised to 0 for=
 the
legacy path meaning that the call to check_sev_features() that occurs when =
the
IGVM file is parsed will flag an error stating 'VMSA contains unsupported
sev_features' if any features are set. This should ensure the IGVM file mat=
ches
the settings in the legacy kernel.

However, I've just run this against an older kernel and found an error: the
kvm_ioctl in sev_init_supported_features() is only supported in newer kerne=
ls
meaning that the launch is aborted on older kernels. I'll update this patch=
 to
fix this and ensure supported_sev_features is 0 for the KVM_SEV_INIT case.

Regards,
Roy


