Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F220C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYLj-00044R-BP; Fri, 23 Aug 2024 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1shYLc-0003x3-FQ; Fri, 23 Aug 2024 13:45:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1shYLa-0001Dn-6v; Fri, 23 Aug 2024 13:45:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NF20SJ015768;
 Fri, 23 Aug 2024 17:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 1hfGFDSz3nGvlajlYzwrX4NweoxkxBfXKQQC6SwbneE=; b=UpWp+rNL5wNMMhbv
 dpufg8nDYTd8xewP3Ha1YOg9pjMz0G90YVUqSCQwkWJI7vvRC4inSs9QqjuVKXfH
 VrIdPUQ7dwk2V2/2vHjrBBzuus0+ujSc/hXFZdA9nhZqG+GrkRjwMgHfhl+bA0Ad
 0rl+Abb8p94cfc1UIBOl1zYL5ciVLOuD39li+El2uRcmITz8N/8caWAEN6sWUFC+
 /P/bwT7xZbK0fozbWpiy5+WYRU+RTqPiW3P78zqEzh3zpbjQnPQeS27kRvKUDfZK
 CkDFjBxi18QxpGgZ0IRFKjKv3M/gMebxWe2YmWZnHGXmlXqx5/OnFuXtyCdZrYM7
 4EewuQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 416vq30p2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Aug 2024 17:45:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NHj8pm021953;
 Fri, 23 Aug 2024 17:45:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 416vq30p2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Aug 2024 17:45:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NF1dgD002201;
 Fri, 23 Aug 2024 17:45:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k1353e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Aug 2024 17:45:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47NHj06Q21758550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Aug 2024 17:45:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FA052004B;
 Fri, 23 Aug 2024 17:45:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5E9020040;
 Fri, 23 Aug 2024 17:44:59 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.15.174]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Aug 2024 17:44:59 +0000 (GMT)
Message-ID: <a2fcc299abf9cd81a3554244f1574cb9c7f63d70.camel@linux.ibm.com>
Subject: Re: [PATCH for-9.2 02/10] target/s390: Convert CPU to Resettable
 interface
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>
Date: Fri, 23 Aug 2024 19:44:59 +0200
In-Reply-To: <20240813165250.2717650-3-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LVIIVO2z6VImmPm4SvTSM7qYMDxsb56U
X-Proofpoint-GUID: jXtqrz_velvp3NVzgUXRg3QtADKXqOSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_14,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2024-08-13 at 17:52 +0100, Peter Maydell wrote:
> Convert the s390 CPU to the Resettable interface.  This is slightly
> more involved than the other CPU types were (see commits
> 9130cade5fc22..d66e64dd006df) because S390 has its own set of
> different kinds of reset with different behaviours that it needs to
> trigger.
>=20
> We handle this by adding these reset types to the Resettable
> ResetType enum.  Now instead of having an underlying implementation
> of reset that is s390-specific and which might be called either
> directly or via the DeviceClass::reset method, we can implement only
> the Resettable hold phase method, and have the places that need to
> trigger an s390-specific reset type do so by calling
> resettable_reset().
>=20
> The other option would have been to smuggle in the s390 reset
> type via, for instance, a field in the CPU state that we set
> in s390_do_cpu_initial_reset() etc and then examined in the
> reset method, but doing it this way seems cleaner.
>=20
> The motivation for this change is that this is the last caller
> of the legacy device_class_set_parent_reset() function, and
> removing that will let us clean up some glue code that we added
> for the transition to three-phase reset.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with 'make check' and 'make check-avocado' only. The
> descriptions of the reset types are borrowed from the commit
> message of f5ae2a4fd8d573cfeba; please check them as I haven't
> got a clue what s390 does ;-)
> ---

With the already mentioned fix:
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 0fbfcd35d83..4e41a3dff59 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
>=20
[...]

> -/* S390CPUClass::reset() */
> -static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
> +/* S390CPUClass Resettable reset_hold phase method */
> +static void s390_cpu_reset_hold(Object *obj, ResetType type)
>  {

[...]
> =20
>      switch (type) {
> -    case S390_CPU_RESET_CLEAR:
> +    default:
> +        /* RESET_TYPE_COLD: power on or "clear" reset */

I'd prefer
	case RESET_TYPE_COLD:
	case RESET_TYPE_SNAPSHOT_LOAD:

and keeping the default unreachable assert.

>          memset(env, 0, offsetof(CPUS390XState, start_initial_reset_field=
s));
>          /* fall through */
> -    case S390_CPU_RESET_INITIAL:
> +    case RESET_TYPE_S390_CPU_INITIAL:
>          /* initial reset does not clear everything! */
>          memset(&env->start_initial_reset_fields, 0,
>                 offsetof(CPUS390XState, start_normal_reset_fields) -
> @@ -203,7 +206,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_typ=
e type)
>          set_float_detect_tininess(float_tininess_before_rounding,
>                                    &env->fpu_status);
>         /* fall through */
> -    case S390_CPU_RESET_NORMAL:
> +    case RESET_TYPE_S390_CPU_NORMAL:
>          env->psw.mask &=3D ~PSW_MASK_RI;
>          memset(&env->start_normal_reset_fields, 0,
>                 offsetof(CPUS390XState, end_reset_fields) -
> @@ -212,20 +215,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_t=
ype type)
>          env->pfault_token =3D -1UL;
>          env->bpbc =3D false;
>          break;
> -    default:
> -        g_assert_not_reached();
>      }
> =20
>      /* Reset state inside the kernel that we cannot access yet from QEMU=
. */
>      if (kvm_enabled()) {
>          switch (type) {
> -        case S390_CPU_RESET_CLEAR:
> +        default:

And the same here.

>              kvm_s390_reset_vcpu_clear(cpu);
>              break;
> -        case S390_CPU_RESET_INITIAL:
> +        case RESET_TYPE_S390_CPU_INITIAL:
>              kvm_s390_reset_vcpu_initial(cpu);
>              break;
> -        case S390_CPU_RESET_NORMAL:
> +        case RESET_TYPE_S390_CPU_NORMAL:
>              kvm_s390_reset_vcpu_normal(cpu);
>              break;
>          }
> @@ -315,12 +316,6 @@ static Property s390x_cpu_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST()
>  };

[...]


