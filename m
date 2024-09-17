Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B7C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXnX-0005wx-LP; Tue, 17 Sep 2024 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqXnV-0005v4-7I; Tue, 17 Sep 2024 08:59:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqXnT-0004VI-31; Tue, 17 Sep 2024 08:59:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8UitY007593;
 Tue, 17 Sep 2024 12:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 z8fa52+K54AH6tJEQ9o+ADFH2MOvSqM2pc83Gn5LaOg=; b=pYNnSARXvO0OtlI8
 X/kQKZymWUtUUM+ekzXZ28tau2uFJD2fay43Uxvf0CUX6iD/89h0zUBzJ4qqV2Vq
 ogrP/ow4UadNYwUfRYnRh9n56RgW7fsgFZpR08bW/KLtcgyOzy+fw7wEaK91+45R
 7zGjzLtxQlDnkRpB/MDV8IOYcb0wAV44Cqo/N+iX+rwMAGSltgFP/jKCyi+JJ0DO
 jA2op+OLSqbq6NTqBmhmUWDLFtswAwa+0Pc12cZF1J515GcVq93dayNC6KnHqGln
 2zfzvpMlF7YBh2pwVQS9kF5W/3j8U+HQW03mfKAvBnx805OdYUtlPkbks9UcoX4Q
 C7L0MQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdg9vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:59:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48HCvheI015282;
 Tue, 17 Sep 2024 12:59:07 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdg9vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:59:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HBsaU9002338;
 Tue, 17 Sep 2024 12:59:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtunhrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:59:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48HCx2XM52953388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 12:59:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8EBE20043;
 Tue, 17 Sep 2024 12:59:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40EB220040;
 Tue, 17 Sep 2024 12:59:02 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.35.187]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2024 12:59:02 +0000 (GMT)
Message-ID: <d6225802dc18d42cef55c63d83dfb97bc5bcc6ba.camel@linux.ibm.com>
Subject: Re: [PATCH v1 03/14] s390x/s390-virtio-hcall: prepare for more
 diag500 hypercalls
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>
Date: Tue, 17 Sep 2024 14:59:01 +0200
In-Reply-To: <f9353ec2-8589-4889-9a44-bd7cca30036d@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-4-david@redhat.com>
 <98b3faa73073829bbe964bec21803657f7f19846.camel@linux.ibm.com>
 <9a4fedc5-d142-4b3d-90c3-2f03d628003e@redhat.com>
 <32ed2987-6243-4137-9526-d1ce059eb5aa@redhat.com>
 <f9353ec2-8589-4889-9a44-bd7cca30036d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HrutqrbmTAPHEjlRWexShuiMY-7QsUkQ
X-Proofpoint-GUID: s03EXUjMI__X7GMtC90L2af_aWbT-ZV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=881 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-09-17 at 13:02 +0200, David Hildenbrand wrote:
> On 17.09.24 12:50, David Hildenbrand wrote:
> > On 17.09.24 12:45, David Hildenbrand wrote:
> > > On 12.09.24 15:22, Nina Schoetterl-Glausch wrote:
> > > > On Tue, 2024-09-10 at 19:57 +0200, David Hildenbrand wrote:
> > > > > Let's generalize, abstracting the virtio bits. diag500 is now a g=
eneric
> > > > > hypercall to handle QEMU/KVM specific things. Explicitly specify =
all
> > > > > already defined subcodes, including legacy ones (so we know what =
we can
> > > > > use for new hypercalls).
> > > > >=20
> > > > > We'll rename the files separately, so git properly detects the re=
name.
> > > > >=20
> > > > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > > ---
> > > > >     hw/s390x/s390-virtio-hcall.c   |  8 ++++----
> > > > >     hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
> > > > >     target/s390x/kvm/kvm.c         | 10 ++--------
> > > > >     target/s390x/tcg/misc_helper.c |  4 ++--
> > > > >     4 files changed, 14 insertions(+), 19 deletions(-)
> > > > >=20
> > > > [...]
> > > > >=20
> > > > > diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> > > > > index 94181d9281..ac292b184a 100644
> > > > > --- a/target/s390x/kvm/kvm.c
> > > > > +++ b/target/s390x/kvm/kvm.c
> > > > > @@ -1493,16 +1493,10 @@ static int handle_e3(S390CPU *cpu, struct=
 kvm_run *run, uint8_t ipbl)
> > > > >    =20
> > > > >     static int handle_hypercall(S390CPU *cpu, struct kvm_run *run=
)
> > > >=20
> > > > Might as well make the return type void then.
> > >=20
> > > Agreed.
> > >=20
> > > > More importantly, are you changing the behavior?
> > > > If I'm reading the code right, previously handle_instruction would =
inject an
> > > > additional PGM_OPERATION due to the negative return value, which do=
es seem off to me.
> > > > If so, IMO this change should go into a separate patch.
> > >=20
> > > You are right, agreed.
> >=20
> > Ah, reading again, we have a "return 0;" after the
> > "kvm_s390_program_interrupt", so it should work as expected.
> >=20
>=20
> The following in should be what you suggest:

Yup, looks good.
>=20
> diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
> index 4cddf69fbb..5fb78a719e 100644
> --- a/hw/s390x/s390-virtio-hcall.c
> +++ b/hw/s390x/s390-virtio-hcall.c
> @@ -57,18 +57,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id=
, uint64_t data)
>       return 0;
>   }
>  =20
> -int handle_diag_500(CPUS390XState *env)
> +void handle_diag_500(S390CPU *cpu, uintptr_t ra)

I don't see a point to passing a cpu when we only need the env, but it does=
n't matter.

>   {
> +    CPUS390XState *env =3D &cpu->env;
>       const uint64_t subcode =3D env->regs[1];
>  =20
>       switch (subcode) {
>       case DIAG500_VIRTIO_NOTIFY:
>           env->regs[2] =3D handle_virtio_notify(env->regs[2]);
> -        return 0;
> +        break;
>       case DIAG500_VIRTIO_CCW_NOTIFY:
>           env->regs[2] =3D handle_virtio_ccw_notify(env->regs[2], env->re=
gs[3]);
> -        return 0;
> +        break;
>       default:
> -        return -EINVAL;
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>       }
>   }
> diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
> index e4f76aca82..dca456b926 100644
> --- a/hw/s390x/s390-virtio-hcall.h
> +++ b/hw/s390x/s390-virtio-hcall.h
> @@ -19,6 +19,6 @@
>   #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
>   #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY=
 */
>  =20
> -int handle_diag_500(CPUS390XState *env);
> +void handle_diag_500(S390CPU *cpu, uintptr_t ra);
>  =20
>   #endif /* HW_S390_VIRTIO_HCALL_H */
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index ac292b184a..2f9a54fe04 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1491,14 +1491,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run =
*run, uint8_t ipbl)
>       return r;
>   }
>  =20
> -static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
> -{
> -    if (handle_diag_500(&cpu->env)) {
> -        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> -    }
> -    return 0;
> -}
> -
>   static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
>   {
>       uint64_t r1, r3;
> @@ -1595,7 +1587,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run=
 *run, uint32_t ipb)
>           handle_diag_318(cpu, run);
>           break;
>       case DIAG_KVM_HYPERCALL:
> -        r =3D handle_hypercall(cpu, run);
> +        handle_diag_500(cpu, RA_IGNORED)
>           break;
>       case DIAG_KVM_BREAKPOINT:
>           r =3D handle_sw_breakpoint(cpu, run);
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helpe=
r.c
> index 58757585a2..170fe00629 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -119,7 +119,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, ui=
nt32_t r3, uint32_t num)
>       case 0x500:
>           /* QEMU/KVM hypercall */
>           bql_lock();
> -        r =3D handle_diag_500(env);
> +        handle_diag_500(env_archcpu(env), GETPC());
>           bql_unlock();
>           break;
>       case 0x44:
>=20
>=20


