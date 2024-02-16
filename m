Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB84C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 12:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxS7-0006Le-89; Fri, 16 Feb 2024 07:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1raxS2-0006LJ-Rv; Fri, 16 Feb 2024 07:36:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1raxS1-0003BL-15; Fri, 16 Feb 2024 07:36:22 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GBa2Ns022388; Fri, 16 Feb 2024 12:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cnToKUixDXBsx8pdHKHq+fKg5kdlvPefxVeDI6EEP/0=;
 b=bmCeEGEJPafkfEIG1XBTkf3Ju/mmiVNUnyJdvY5os9C6xz0jMS+Y6U0J2+7PrQ+WJ+3j
 kre6aYXmB0PkRlqnYC+loNeBlFHhZAQxgyFGsb5VCjYbIguoM35nitgjkGcvRYJJlNki
 ZGOEIH3ULeW6wSBKek/Mbk+YBB6SY631t2Esfp1HBcDfFmIpd1DLdvcfa0DCFqofYrA5
 5VZsjN0Qq6lOAVj0tAJw526t8mVQHpAgr3x7B3JS4cy9p/jyFWOzpV73qMO41w9SWmpd
 lZ5riY1VyoaEHHF9VZb8zJmf+2/Zx3Urxt85etjcFVdm/2DZEhs4NxiGZAFMfFaoDm7s /A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa5f7twcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 12:36:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GCaAFu029473;
 Fri, 16 Feb 2024 12:36:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa5f7twch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 12:36:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GB0xAj010045; Fri, 16 Feb 2024 12:36:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmauw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 12:36:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GCa6Hm61538582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 12:36:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03DBE2004B;
 Fri, 16 Feb 2024 12:36:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAF6820040;
 Fri, 16 Feb 2024 12:36:05 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Feb 2024 12:36:05 +0000 (GMT)
Message-ID: <a403dda185d7830f048aed8740bcf6c7ffeb3ac0.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/3] linux-user: Allow gdbstub to ignore page protection
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Date: Fri, 16 Feb 2024 13:36:05 +0100
In-Reply-To: <87h6i84os9.fsf@draig.linaro.org>
References: <20240131114817.288027-1-iii@linux.ibm.com>
 <87h6i84os9.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Y4vNd83BWWKkH25fCyedmRDg8GMLhdr
X-Proofpoint-GUID: fknAwRMq22oLu4VUdL5ni3_-mSaKFhuZ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_09,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1011 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2024-02-16 at 11:44 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > v4:
> > https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05857.html
> > v4 -> v5: Fix the probe_proc_self_mem vs probe_proc_self_mem()
> > typo.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add Alex's R-b a=
nd A-b.
>=20
> I was going to pull this and realised it already went in via
> Richard's
> tcg-next. Did this fix get merged?
>=20

Hi, yes, I submitted it separately and it was merged as:

commit da4038d2da6d3a3d5f86665bd51b2ba49df5d652
Author: Ilya Leoshkevich <iii@linux.ibm.com>
Date:   Wed Jan 31 23:02:18 2024 +0100

    tests/tcg: Fix the /proc/self/mem probing in the PROT_NONE gdbstub
test



