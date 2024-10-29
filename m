Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18430D7494D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 23:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5veo-0006Cr-Jt; Tue, 29 Oct 2024 19:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5ven-0006Cj-JU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:29:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vel-0004dx-O8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:29:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLKBtw031393;
 Tue, 29 Oct 2024 23:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Qgp8xA
 Xg3gN6oIBDJgJgZkQL+D/I7T0l6HX1fajGDOg=; b=oDrlxSofdwHtR7mJ4yQMnF
 /GXv9bc8kPg0AsFGRf5cL+H9wJ1JFKpThCuul7LUjl4u2JE5i6/ZyIe7nniU1Jrs
 856L4TodeDximL3Dc4TahdvKSaOP+wAkeUn/Adap6JcLmGddrtwjLU8GLSwTkyqa
 IbJ24zxq+OXVRmlrecFuDxgMccjaWbxkmxN+XbaKDfirVQrbo9DAdo5eI9g2e6qs
 wMzfywZcnRGFcEAJded0ym73UFUQXBwL9Ff4zSQx86q5NpB9h7mERzQZ+tj0BKCU
 UEaZdczXY2+dQ+XzNuk7AKyZ53hTVHcRoFN60jpfSrIEHlqei68de+sGwhMdm/QA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsut9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:29:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMEBIe013585;
 Tue, 29 Oct 2024 23:29:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hbrmwdu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:29:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49TNTfIt53543390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2024 23:29:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BBA42004B;
 Tue, 29 Oct 2024 23:29:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30E7620049;
 Tue, 29 Oct 2024 23:29:41 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Oct 2024 23:29:41 +0000 (GMT)
Message-ID: <4f0cab2f2d564037e1a36a75ad1fb9d350c0f0e1.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Wed, 30 Oct 2024 00:29:40 +0100
In-Reply-To: <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
References: <20241010085906.226249-1-iii@linux.ibm.com>
 <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s6X2BsEs1VJ0TYQM-daL4m3EsdtFjExg
X-Proofpoint-GUID: s6X2BsEs1VJ0TYQM-daL4m3EsdtFjExg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=957 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 2024-10-10 at 11:20 +0200, Paolo Bonzini wrote:
> On 10/10/24 10:58, Ilya Leoshkevich wrote:
> > make check-tcg fails on Fedora with the following error message:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 alpha-linux-gnu-gcc [...]
> > qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu/tests/tcg/multiarch/system/memory.c:17:10=
: fatal error:
> > inttypes.h: No such file or directory
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17 | #include <inttypes.h>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~
> > =C2=A0=C2=A0=C2=A0=C2=A0 compilation terminated.
> >=20
> > The reason is that Fedora has cross-compilers, but no cross-glibc
> > headers. Fix by hardcoding the format specifiers and dropping the
> > include.
> >=20
> > An alternative fix would be to introduce a configure check for
> > inttypes.h. But this would make it impossible to use Fedora
> > cross-compilers for softmmu tests, which used to work so far.
> >=20
> > Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check memory
> > instrumentation")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

Thanks for the review!

Could someone please pick this one and also [1] up?
Both patches are aimed at improving the situation with the test builds.

[1]
https://lore.kernel.org/qemu-devel/20241023131250.48510-1-iii@linux.ibm.com/

