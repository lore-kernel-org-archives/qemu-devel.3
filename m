Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FBDCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 18:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOgIb-0001Rg-G2; Thu, 27 Nov 2025 13:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vOgIO-0001Pp-3v; Thu, 27 Nov 2025 13:00:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vOgIL-0006H1-RE; Thu, 27 Nov 2025 13:00:43 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARFfDYa024334;
 Thu, 27 Nov 2025 18:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=waD35K
 ZP5y3hJ0BzBLXz5JQ2bPiCCWN/XgWTyXAG6fo=; b=DMUuxFV9gJeqd4gdo7NngJ
 dufAkhX0K5OqqWyHmpYkoT29/k7w5ZR5pMdN55h8XJK+HHRnw5uFFNKsMW02yeut
 tPuFZoKnhLCa4/OPoLfMo/Q1GlwX22xosMOkPJY+9PdVgOOHl2pw7dd/KJW/wNA0
 4TyNPQGxeyYoKGzjzfIpZHtunOjV3mtZgtkV0lW7Hp2fxvteNLAHE8DIQuIelIUB
 R1C2QLOT5cqdqrb8XZ49fwQCQh9khNoGsz563ZuCZ97wYgQAQwjFTDAF2Sf1rWZj
 GE0Aylk0/gzN2TXj/oiSoCEudOuFiVuHjaBtayDFdfQajLFVBaccKJSxczNxu7Xg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjb3a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 18:00:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARGXCTX027389;
 Thu, 27 Nov 2025 18:00:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4ha7ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 18:00:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ARI0XwM34734458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 18:00:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 934522004E;
 Thu, 27 Nov 2025 18:00:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D54120040;
 Thu, 27 Nov 2025 18:00:33 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 18:00:33 +0000 (GMT)
Message-ID: <115d74c6536473d1a3ec8d9431f186b0d09c2aff.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] target/s390x: Fix missing interrupts for small
 CKC values
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Thu, 27 Nov 2025 19:00:32 +0100
In-Reply-To: <a0accce9-6042-4a7b-a7c7-218212818891@redhat.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
 <20251016175954.41153-2-iii@linux.ibm.com>
 <a0accce9-6042-4a7b-a7c7-218212818891@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX/9fT7tOHjat5
 xLwLOZwBi6QkT/e8g35wm67QVf63OJ/IsEGMBoOTQ56o2oUPmdM9zN3w6Jmba7t87lkoFD1Q+Fm
 X+sBZL2/waf+lxIdge9PhZhcSC2VoxK38K+r324Y7O9inON/hF3EI01Orbbmv7RVMhzuY4Ersso
 Nhj4SE5ua52JNvlWhZMo5IWEU1UKC/x5Z9rD9R8286UjRi5cl33nIdeHeKYm6hV1N1LUOpXfip5
 RAtXcYaTUvRD2h6Twu6dgwN1LTzP0MfjRQeV8fTEFTPTDphsLitZtjcYfHjIpvFW4aJ5UvIqSUr
 2CRkVx0KDu/54cxomwE0A4MbZNqC2MMhvLP2hs18+3wVfYjxz8N6kX1tpeYo7z7PM/vHng7f7Z3
 BaFhiAfUX4QjQN2pBO57Ek5U5N7+6g==
X-Proofpoint-ORIG-GUID: d9rXJ4fu8xdNsnLrT3UAeidYe67UcmXA
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=692891c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=63-1EPlPogbjb9DX-foA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: d9rXJ4fu8xdNsnLrT3UAeidYe67UcmXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 2025-11-27 at 17:43 +0100, Thomas Huth wrote:
> On 16/10/2025 19.58, Ilya Leoshkevich wrote:
> > Suppose TOD clock value is 0x1111111111111111 and clock-comparator
> > value is 0, in which case clock-comparator interruption should
> > occur
> > immediately.
> >=20
> > With the current code, tod2time(env->ckc - td->base.low) ends up
> > being
> > a very large number, so this interruption never happens.
> >=20
> > Fix by firing the timer immediately if env->ckc < td->base.low.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
>=20
> =C2=A0 Hi Ilya,
>=20
> this patch unfortunately broke reverse debugging on the s390x target.
> Something like this used to work before:
>=20
> =C2=A0 qemu-img create -f qcow2 /tmp/disk.qcow2 2G
> =C2=A0 ./qemu-system-s390x -nographic \
> =C2=A0=C2=A0=C2=A0 -icount shift=3D6,rr=3Drecord,rrfile=3Dreplay.bin,rrsn=
apshot=3Dinit \
> =C2=A0=C2=A0=C2=A0 -net none -drive file=3D/tmp/disk.qcow2,if=3Dnone
> =C2=A0 ./qemu-system-s390x -nographic \
> =C2=A0=C2=A0=C2=A0 -icount shift=3D6,rr=3Dreplay,rrfile=3Dreplay.bin,rrsn=
apshot=3Dinit \
> =C2=A0=C2=A0=C2=A0 -net none -drive file=3D/tmp/disk.qcow2,if=3Dnone
>=20
> With this commit and later, the replay hangs somewhere in an endless
> loop.
> Do you have any ideas what could go wrong here?
>=20
> =C2=A0 Thanks,
> =C2=A0=C2=A0 Thomas

[...]

Hi Thomas,

Thanks for letting me know, I will look at this ASAP.

Best regards,
Ilya

