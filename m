Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5EBCF58F5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZsQ-0007AG-Ig; Fri, 20 Sep 2024 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1srZsP-00071k-7H; Fri, 20 Sep 2024 05:24:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1srZsM-0005r8-JS; Fri, 20 Sep 2024 05:24:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K597cX007575;
 Fri, 20 Sep 2024 09:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 OXLo01Q6QlTjqvClIqMJ3ynBMhJ9G35lqem6Y0ZQkHg=; b=eBhifdmaWykCcCr+
 yaiLAVVxkPxhTqPiq2BRaqFl8Zzk5t/UI6HDMpoVtbYGi4ZyXXb4MiQBm2tA3M5l
 NXFaQA7DD41IW0eLU1I1M66uz5baIgt4EoLh5MBuGLgCN5rQZXiDuYHFB7uMUD95
 PKiF8io3DvzSUWJ/zJV6c8eTllpt+jbkwD9UylSNRQeM5Q7/Zx8ZVH6gvVd3DBiy
 ogfQVnxvNFHoljDzdQv7eF1prNF0fKTujwmmYdi6X+7ediJ4N7vsAP957YDSp1+H
 /f7gY6druPZf5efoFrjnE5ftM8yoPuw1MYjkEOeb4mz/sqdGuFLL/lrc3fsdSHry
 siiRVQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht91vnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Sep 2024 09:24:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48K9ORUq022766;
 Fri, 20 Sep 2024 09:24:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht91vnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Sep 2024 09:24:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7wWgS000762;
 Fri, 20 Sep 2024 09:24:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntqpbxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Sep 2024 09:24:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48K9OOCq55902550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 09:24:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DD3D20043;
 Fri, 20 Sep 2024 09:24:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6A4A20040;
 Fri, 20 Sep 2024 09:24:23 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Sep 2024 09:24:23 +0000 (GMT)
Message-ID: <d0c4fff589298c113d1eb43de87e7f1fb0fb18c9.camel@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Fix lxvx/stxvx facility check
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>
Date: Fri, 20 Sep 2024 11:24:23 +0200
In-Reply-To: <b9231ac0-d4b7-4565-b2aa-5ceff3a7e672@suse.de>
References: <20240911141651.6914-1-farosas@suse.de>
 <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
 <bcdc7a95-09de-4a2e-a45c-aa4a539afc06@suse.de>
 <b9231ac0-d4b7-4565-b2aa-5ceff3a7e672@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FuYetwBzBNMTFG9MEe9kmBYksJ41KO-s
X-Proofpoint-ORIG-GUID: jkDDeCZ0hSSW_DObsB2I0Lp1o8biFUdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 2024-09-19 at 13:36 +0200, Claudio Fontana wrote:
> ping, adding Richard.
>=20
> We will need to include this downstream because of the breakage its
> lack causes.
> It is already reviewed by me, but some TCG maintainer indicating it
> will be included in some queue would help,
>=20
> Thanks,
>=20
> Claudio
>=20
> On 9/18/24 17:11, Claudio Fontana wrote:
> > Adding Ilya FYI.
> >=20
> > Ciao,
> >=20
> > Claudio
> >=20
> > On 9/11/24 18:19, Claudio Fontana wrote:
> > > On 9/11/24 16:16, Fabiano Rosas wrote:
> > > > The XT check for the lxvx/stxvx instructions is currently
> > > > inverted. This was introduced during the move to decodetree.
> > > >=20
> > > > From the ISA:
> > > > =C2=A0 Chapter 7. Vector-Scalar Extension Facility
> > > > =C2=A0 Load VSX Vector Indexed X-form
> > > >=20
> > > > =C2=A0 lxvx XT,RA,RB
> > > > =C2=A0 if TX=3D0 & MSR.VSX=3D0 then VSX_Unavailable()
> > > > =C2=A0 if TX=3D1 & MSR.VEC=3D0 then Vector_Unavailable()
> > > > =C2=A0 ...
> > > > =C2=A0 Let XT be the value 32=C3=97TX + T.
> > > >=20
> > > > The code currently does the opposite:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 if (paired || a->rt >=3D 32) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_VSX(ctx);
> > > > =C2=A0=C2=A0=C2=A0 } else {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_VECTOR(ctx);
> > > > =C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > This was already fixed for lxv/stxv at commit "2cc0e449d1
> > > > (target/ppc:
> > > > Fix lxv/stxv MSR facility check)", but the indexed forms were
> > > > missed.
> > > >=20
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from
> > > > legacy to decodtree")
> > > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > > ---
> > > > =C2=A0target/ppc/translate/vsx-impl.c.inc | 2 +-
> > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/target/ppc/translate/vsx-impl.c.inc
> > > > b/target/ppc/translate/vsx-impl.c.inc
> > > > index 40a87ddc4a..a869f30e86 100644
> > > > --- a/target/ppc/translate/vsx-impl.c.inc
> > > > +++ b/target/ppc/translate/vsx-impl.c.inc
> > > > @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext
> > > > *ctx, arg_PLS_D *a,
> > > > =C2=A0
> > > > =C2=A0static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool
> > > > store, bool paired)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0 if (paired || a->rt >=3D 32) {
> > > > +=C2=A0=C2=A0=C2=A0 if (paired || a->rt < 32) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_VSX(ctx);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_VECTOR(ctx=
);
> > >=20
> > > Reviewed-by: Claudio Fontana <cfontana@suse.de>

FWIW

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

But I'm not a maintainer, I guess Richard will need to pick it up.

