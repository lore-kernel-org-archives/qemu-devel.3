Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00EC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrGw-0004AL-9b; Wed, 18 Jun 2025 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRrGs-00049s-8f
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:48:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRrGp-0001NO-Ph
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:48:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I3okgX016943;
 Wed, 18 Jun 2025 11:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7mHjmS
 6jVkPgHxgdnDaZdPcQY+SBPZa0/RuWfZukmZA=; b=i1/W1ElzhHQ+b3aEdran6v
 Dp2Fe3rQDeeBv7t/oNN0zSyZPqscif/ELhdZLNZLHuRKiOXGdVTG/Hpjjh+6l6ow
 cBvwLFHNMVLfJ4GSPMZ7DGH1OJDKxS678Hq5fJOIiWv8786WKS05z0I6xcSadeTt
 ZqC1lAa6vYXrkiPjvkB8tiCuuWDXHXS/ylu0hBODtkxLXwjwOXGuVRGvydE+W1ow
 TMZYNqDNrtkDKiwotFE58ubLb4DrNkEvomZWn5q7Of/QRpF71NbgFTExSk1VFbfx
 yEJaQhGNSW0f/+Mxer6RDFecLoQ5q+GQvcKNiyCtY5yhrgW8yU5/ar284ImSL/Yw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktpp75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 11:47:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBgFsg000748;
 Wed, 18 Jun 2025 11:47:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp8qwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 11:47:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55IBlng133227370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Jun 2025 11:47:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8172620049;
 Wed, 18 Jun 2025 11:47:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBE6520040;
 Wed, 18 Jun 2025 11:47:48 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Jun 2025 11:47:48 +0000 (GMT)
Message-ID: <37d635ed8b8f6f1993cd3b32972e6b9bd9d59958.camel@linux.ibm.com>
Subject: Re: [PATCH] tcg: Remove null pointer arithmetic in tcg_malloc()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 13:47:48 +0200
In-Reply-To: <20250618103555.2020-1-iii@linux.ibm.com>
References: <20250618103555.2020-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U1gundytPZwStvfHY2fdsSOleWXr7ep_
X-Proofpoint-ORIG-GUID: U1gundytPZwStvfHY2fdsSOleWXr7ep_
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6852a768 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=M4ceuK-2COoXsQIDCawA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwMCBTYWx0ZWRfX9WTXWlAVc6FP
 nYBZAsIZbGcgTvS42XDRgj1C52rBmRJVDaEz3+h4UKWkyavp+4U+Nc+xXf7pymczdLZPV/H0Z9Q
 2AYrgkeMD6hKCkAgzMnUNBtElwrr12WGp6GtobrTuPoZ0eBV8de5Ka+h22ETpg6A9bNNSpyMC8F
 4197tQh2IoHd3T3ceqV9i7wbZXU5AUk+pLO+Vrt7pzQF/i2oDDjsHu7b9Uc2sR/lapAQzmWE+a1
 65k8GlwvXLv5Zt+foGEke1xNUZSntwGSutXJDifil36rLMWkKs1fctr9sCDHSqahB9H1i2eoboA
 3qK9xx9FcQLW+wkWVgLp8g3x5sIu82FHE9bhEQldeM03E0FCd2/a7L1m3EJZrcVVVZAO9+5pLoE
 vgcyPga6X4YZyx33wtP5Z6BwFyxWyd/SvEAXcE9Y3id3+7mfjD10j/pNYq2D4SRdgng3PKQ/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=930 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 2025-06-18 at 12:35 +0200, Ilya Leoshkevich wrote:
> Clang 20.1.6 (Fedora 20.1.6-1.fc42)'s UBSAN complains:
>=20
> =C2=A0=C2=A0=C2=A0 qemu/include/tcg/tcg.h:715:19: runtime error: applying=
 non-zero
> offset 64 to null pointer
>=20
> The code uses NULL as pool's initial start and end, with the
> intention
> that `pool_cur + size > pool_end` should trigger the allocation.
> Unfortunately C prohibits adding non-zero to NULL, even if the result
> is not dereferenced.
>=20
> Fix by using a dummy pool.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0tcg/tcg.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d714ae2889c..afcc7ec8849 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1358,13 +1358,14 @@ void *tcg_malloc_internal(TCGContext *s, int
> size)
> =C2=A0
> =C2=A0void tcg_pool_reset(TCGContext *s)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 static uint8_t dummy_pool;
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGPool *p, *t;
> =C2=A0=C2=A0=C2=A0=C2=A0 for (p =3D s->pool_first_large; p; p =3D t) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t =3D p->next;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(p);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 s->pool_first_large =3D NULL;
> -=C2=A0=C2=A0=C2=A0 s->pool_cur =3D s->pool_end =3D NULL;
> +=C2=A0=C2=A0=C2=A0 s->pool_cur =3D s->pool_end =3D &dummy_pool;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->pool_current =3D NULL;
> =C2=A0}

Hmm, come to think of it, something like `&dummy_pool + 2` is not
allowed either, it's just that UBSAN doesn't complain about it. I will
send a v2.

