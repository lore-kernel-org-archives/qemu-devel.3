Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BFACF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEiw-00050r-Bf; Mon, 30 Sep 2024 07:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1svEiu-000506-FW; Mon, 30 Sep 2024 07:37:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1svEis-0005VX-A5; Mon, 30 Sep 2024 07:37:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8nZLW015089;
 Mon, 30 Sep 2024 11:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 Lz4tpttVp4u/YGed44zx34u+ZGyOlM2zE1pRTdGByK4=; b=dqkpFprZS00wGNSa
 E6DGyKjsJxe4nLGM3nN7EO9pYBXnhRZv/ukLNc8FPnSN5VHp0OGOA2iJyjeKIGCG
 YeiopPkUXnTwsApc7dHFE4VrdNbmEAJ9AVDId6SkN6E+lDXESNY7QW2UGW/V5BrG
 VcnTEtP3SjoQwfOzHgS+YHqGowhAd6kXu6NI/wHqfWOKtwCU0esmkiWyMfVRTf4z
 Axae7Q6XOabQGCP2E+hMSP90M6KQqP25RS8e0ANoNhGGm9uZgjAlxPAkj1NQ26bh
 J1lttcw+U3+dVXpl1J6zCic+M5IsFEkXy0SFNH42qXV7hbHU9Lsnn/GyQuA69MZL
 ABNNyw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f8142b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:37:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UBbjBG026849;
 Mon, 30 Sep 2024 11:37:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f81429-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:37:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB5EID017836;
 Mon, 30 Sep 2024 11:37:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mpa85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:37:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UBbf0g52232692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 11:37:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4992A20043;
 Mon, 30 Sep 2024 11:37:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9D1F20040;
 Mon, 30 Sep 2024 11:37:40 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Sep 2024 11:37:40 +0000 (GMT)
Date: Mon, 30 Sep 2024 13:37:39 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 10/14] s390x/pv: check initial, not maximum RAM size
Message-ID: <20240930133739.5fed4790@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <8938437c-dd89-4c9a-bb53-7949c5fc3a67@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-11-david@redhat.com>
 <c6d51e5a0bd3e222a1fb3354e31bf2edcc3a59d2.camel@linux.ibm.com>
 <72e7a377-60ab-45ed-9136-327fa4dd9e4c@redhat.com>
 <8938437c-dd89-4c9a-bb53-7949c5fc3a67@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3auEwaJQtrREthYcYjAVMMaF_sTA6Yk0
X-Proofpoint-ORIG-GUID: XP1u7ieatO3nWRb1Cf65ov_7GG6jf3q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1011 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 30 Sep 2024 13:15:52 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 24.09.24 um 22:17 schrieb David Hildenbrand:
> > On 24.09.24 18:22, Nina Schoetterl-Glausch wrote: =20
> >> On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote: =20
> >>> We actually want to check the available RAM, not the maximum RAM size.
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com> =20
> >>
> >> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> >> Nit below. =20
> >>> ---
> >>> =C2=A0 target/s390x/kvm/pv.c | 2 +-
> >>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> >>> index dde836d21a..424cce75ca 100644
> >>> --- a/target/s390x/kvm/pv.c
> >>> +++ b/target/s390x/kvm/pv.c
> >>> @@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineS=
tate *ms)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the feature is not present =
or if the VM is not larger than 2 GiB,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * KVM_PV_ASYNC_CLEANUP_PREPARE f=
ill fail; no point in attempting it.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>> -=C2=A0=C2=A0=C2=A0 if ((MACHINE(ms)->maxram_size <=3D 2 * GiB) ||
> >>> +=C2=A0=C2=A0=C2=A0 if ((MACHINE(ms)->ram_size <=3D 2 * GiB) ||
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !kvm_check_ext=
ension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >>
> >> If I understood the kernel code right, the decision is made wrt
> >> the size of the gmap address space, which is the same as the
> >> limit set for the VM. So using s390_get_memory_limit would be
> >> semantically cleaner. =20
> >=20
> > I wonder if we should just drop the RAM size check. Not convinced the s=
lightly faster reboot for such small VMs is really relevant? Makes the code=
 more complicated than really necessary. =20
>=20
> IIRC there have been functional issues with small guests and asnyc. Claud=
io, do you remember?

if we are <2G, KVM allocates a segment table as the highest level table
for the gmap ASCE. there are pointers lurking around in the reverse
mapping prefix_tree, which point directly into segment tables.

if the ASCE is region3 or higher, that's not an issue. if it's a
segment table, then it's an issue, because those pointers will end up
pointing into freed memory, once the old asce is freed.

in short, we have to guarantee that we will never set aside a gmap ASCE
if it is a segment table.


