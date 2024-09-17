Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC96AC3601A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXdX-0000Ql-4r; Tue, 17 Sep 2024 08:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqXdQ-0000Q5-Vh; Tue, 17 Sep 2024 08:48:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqXdO-0003NF-Vp; Tue, 17 Sep 2024 08:48:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8APsh006402;
 Tue, 17 Sep 2024 12:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 kUNkkvPGvlFKI5FXYnt3BX0hDE6hsebFmzWXJcqJNs4=; b=UmAHYYgBezYq5F5u
 z/+UrOOfXojWKYgNloMXas1pp+5mfxg0HyaqezRrHsFj35kQMEkQ0Mbm7jMT1xvb
 teRY/9us1B3ZFARYDZ+BbUfmRN52uxltLrHjTLZ3JmhdzofCllzNbS1e15tJEUoT
 9jyEs+Dkh0Qt7mlmIMjT1Z6aRbBCd9Wj2a/96MC141Nj/4rZdCd4slRoKGdb+jHg
 iAaps3IHsA+doXJ2h8thmQtkaupycImPckEPAOadycT7OjTms1zrhBUFrIeoeRH9
 XuIcXp5jvcJUYdIA8km+hZ6oyqLUq3eAPcqT79HtzGC3puRqAozo9caPKRYfl5yd
 +A6aPg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41afk2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:48:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48HCiNLR027006;
 Tue, 17 Sep 2024 12:48:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41afk26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:48:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HC0HRE000637;
 Tue, 17 Sep 2024 12:48:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn715e0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 12:48:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48HCmccD40239402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 12:48:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF64120043;
 Tue, 17 Sep 2024 12:48:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 146C92004B;
 Tue, 17 Sep 2024 12:48:38 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.35.187]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2024 12:48:37 +0000 (GMT)
Message-ID: <229425cd92897e4ff3b5f4456c1c75215668358e.camel@linux.ibm.com>
Subject: Re: [PATCH v1 06/14] s390x: introduce s390_get_memory_limit()
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>
Date: Tue, 17 Sep 2024 14:48:37 +0200
In-Reply-To: <e91fa726-2a72-486a-a687-ec3a29100cc0@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-7-david@redhat.com>
 <a2cb5304c1bf326455030f7d370155ecba3cd7d2.camel@linux.ibm.com>
 <e91fa726-2a72-486a-a687-ec3a29100cc0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dm9G_oANKqKs6y_Pm-CLMYSbwMyhw5WS
X-Proofpoint-ORIG-GUID: ug74sKDaIOwvNhTfzna36maP7MXnuyBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_05,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=874 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2024-09-17 at 13:23 +0200, David Hildenbrand wrote:
> On 16.09.24 15:20, Nina Schoetterl-Glausch wrote:
> > On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
> > > Let's add s390_get_memory_limit(), to query what has been successfull=
y
> > > set via s390_set_memory_limit(). Allow setting the limit only once.
> > >=20
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >=20
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> >=20
> > Comment below.
> > > ---
> > >   target/s390x/cpu-sysemu.c | 19 +++++++++++++++++--
> > >   target/s390x/cpu.h        |  1 +
> > >   2 files changed, 18 insertions(+), 2 deletions(-)

[...]

> > > +
> > > +uint64_t s390_get_memory_limit(void)
> > > +{
> >=20
> > Might be nice to guard/warn against s390_set_memory_limit not having be=
en called before.
> >=20
>=20
> What about the following on top:
>=20
> diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
> index 1915567b3a..07cb85103a 100644
> --- a/target/s390x/cpu-sysemu.c
> +++ b/target/s390x/cpu-sysemu.c
> @@ -263,6 +263,8 @@ int s390_set_memory_limit(uint64_t new_limit, uint64_=
t *hw_limit)
>  =20
>       if (memory_limit) {
>           return -EBUSY;
> +    } else if (!new_limit) {
> +        return -EINVAL;
>       }
>       if (kvm_enabled()) {
>           ret =3D kvm_s390_set_mem_limit(new_limit, hw_limit);
> @@ -275,6 +277,8 @@ int s390_set_memory_limit(uint64_t new_limit, uint64_=
t *hw_limit)
>  =20
>   uint64_t s390_get_memory_limit(void)
>   {
> +    /* We expect to be called after s390_set_memory_limit(). */
> +    assert(memory_limit);
>       return memory_limit;
>   }

Looks good.

Looking at the patch again I'm wondering if using globals in qemu is still =
encouraged.
I know it's a common pattern today, but seeing efforts like the multiarch b=
inary or Unicorn
I'm wondering if there is aspirations to do things more "cleanly", in gener=
al, for far out benefits?
I.e. memory_limit could be a machine property instead.

