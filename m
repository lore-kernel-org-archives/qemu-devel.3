Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB483EED603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojmR-0005wA-HS; Thu, 12 Sep 2024 09:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sojmL-0005v7-N5; Thu, 12 Sep 2024 09:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sojmJ-0006jw-PE; Thu, 12 Sep 2024 09:22:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CATvVr021192;
 Thu, 12 Sep 2024 13:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 6OXllMyXtHTZU1Y5RDc2kdKqb/hrCzlgy2ZyMEEiftg=; b=QzTDQQDObNAXbveB
 aGCWTGC5FZ34zC6GQih549k0Y1q2IQvAJ/UxM81gTh5tp7swiqcU8BJSgNt+dOkj
 JGY188GqnSyT3MhrSSr7mIA1pnE+RGhdrlcBABKkRXHLeUuEuYFrMlnhfF3aEu4+
 rFiae/fYIkSOL4Jdt4Z9u/REoxYsCOD0SEdQUZCoZ08rSAM20eP5cPELW3bSz1Kw
 nZ9B2FgL3wW852ETj0OENngK69kPuG36UdAs3FN8DJoUhjDYMl9zRgoD/d8kdITO
 gW1iQgmoyPO3JWlMbEEsED4zJuUjEvn/rxAQ6PvH5egE9VobgnDC25eNPQVp05KH
 8x5xmA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyum07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 13:22:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CDMQ3x001154;
 Thu, 12 Sep 2024 13:22:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyum03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 13:22:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCNhmo010770;
 Thu, 12 Sep 2024 13:22:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6usvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 13:22:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CDMM0354919664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 13:22:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48C0620049;
 Thu, 12 Sep 2024 13:22:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74CE520040;
 Thu, 12 Sep 2024 13:22:21 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.3.243]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 13:22:21 +0000 (GMT)
Message-ID: <98b3faa73073829bbe964bec21803657f7f19846.camel@linux.ibm.com>
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
Date: Thu, 12 Sep 2024 15:22:21 +0200
In-Reply-To: <20240910175809.2135596-4-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dzkN6S3CzYMYnvl36loBm1zOVdWqbmHd
X-Proofpoint-ORIG-GUID: GPPgwgMNtZrT4nsbmXlS03XaiYN4gyRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_02,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=578 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, 2024-09-10 at 19:57 +0200, David Hildenbrand wrote:
> Let's generalize, abstracting the virtio bits. diag500 is now a generic
> hypercall to handle QEMU/KVM specific things. Explicitly specify all
> already defined subcodes, including legacy ones (so we know what we can
> use for new hypercalls).
>=20
> We'll rename the files separately, so git properly detects the rename.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-hcall.c   |  8 ++++----
>  hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
>  target/s390x/kvm/kvm.c         | 10 ++--------
>  target/s390x/tcg/misc_helper.c |  4 ++--
>  4 files changed, 14 insertions(+), 19 deletions(-)
>=20
[...]
>=20
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 94181d9281..ac292b184a 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1493,16 +1493,10 @@ static int handle_e3(S390CPU *cpu, struct kvm_run=
 *run, uint8_t ipbl)
> =20
>  static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)

Might as well make the return type void then.
More importantly, are you changing the behavior?
If I'm reading the code right, previously handle_instruction would inject a=
n
additional PGM_OPERATION due to the negative return value, which does seem =
off to me.
If so, IMO this change should go into a separate patch.
I'm also wondering if the injection of PGM_SPECIFICATION should just go int=
o
handle_diag_500 and handle_hypercall should just be inlined.

>  {
> -    CPUS390XState *env =3D &cpu->env;
> -    int ret;
> -
> -    ret =3D s390_virtio_hypercall(env);
> -    if (ret =3D=3D -EINVAL) {
> +    if (handle_diag_500(&cpu->env)) {
>          kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> -        return 0;
>      }
> -
> -    return ret;
> +    return 0;
>  }


