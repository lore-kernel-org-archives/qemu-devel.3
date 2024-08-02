Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0560C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsK8-0007FN-Bh; Fri, 02 Aug 2024 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZsK7-0007Ba-9Q; Fri, 02 Aug 2024 09:27:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZsK2-0007ug-NF; Fri, 02 Aug 2024 09:27:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DRqUV008552;
 Fri, 2 Aug 2024 13:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 IvrB9Ccqt1pTPILYOl0cMaldxpQBJogiZfGNaM8jO8A=; b=TKbgqpXrOvZLhiiD
 kt9crzZrwP7IrD1bcEidNHzW/xMr0vwSGfL4VRGZz8lwmq9q+b5H4aHDPKbTdFcw
 H+0lt5b7cHgxuy3V9DM0deWtUFxreOx2NwOfTa1FD3R47iklDgdE6zOU1rGcxEcB
 mR1YDZsjh6zf5UrlO3wrv48pQSYdbEAHAcN2o9Kv+H2Bay9eA67tRRCIRZMwuO4P
 7njRMa/puNDbcWoEotDyrbL1zNbCasU63i8aGM1rukWDLWD3peutyTtkp3iHL4H5
 oXOY/9zb0aBnaVnamatfNrUkSJbE7LOts8TlSJORKUjHp44nPA4WgEpyck1MGkjg
 gsuT7g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ryx881uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 13:27:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 472D0oiS007462; Fri, 2 Aug 2024 13:23:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7uqmxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 13:23:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472DNU6Z50135500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 13:23:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E77A2004B;
 Fri,  2 Aug 2024 13:23:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11C5A20043;
 Fri,  2 Aug 2024 13:23:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2024 13:23:29 +0000 (GMT)
Message-ID: <c1ce916ad55ea8f6260fbc3beaea340dce4ca0bb.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user/elfload: Fix pr_pid values in core files
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Laurent
 Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Fri, 02 Aug 2024 15:23:29 +0200
In-Reply-To: <a218c0ba-3527-4e31-b8a7-e34b6f2bad1f@linaro.org>
References: <20240801202340.21845-1-iii@linux.ibm.com>
 <a218c0ba-3527-4e31-b8a7-e34b6f2bad1f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kh08WhJ4Ho8qQOHUZ4ZtNytakkxwQ1eU
X-Proofpoint-ORIG-GUID: Kh08WhJ4Ho8qQOHUZ4ZtNytakkxwQ1eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_09,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2024-08-02 at 15:20 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/8/24 22:23, Ilya Leoshkevich wrote:
> > Analyzing qemu-produced core dumps of multi-threaded apps runs
> > into:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 (gdb) info threads
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 21=C2=A0=C2=A0 Thread 0x3ff83cc074=
0 (LWP 9295) warning: Couldn't find
> > general-purpose registers in core file.
> > =C2=A0=C2=A0=C2=A0=C2=A0 <unavailable> in ?? ()
> >=20
> > The reason is that all pr_pid values are the same, because the same
> > TaskState is used for all CPUs when generating NT_PRSTATUS notes.
> >=20
> > Fix by using TaskStates associated with individual CPUs.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header
> > in one block")
>=20
> Isn't it
>=20
> Fixes: edf8e2af14 ("linux-user: implemented ELF coredump")
>=20
> ?

I haven't tested it, but this looks correct:

static void fill_thread_info(struct elf_note_info *info, const CPUState
*env)
{
    TaskState *ts =3D (TaskState *)env->opaque;

> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 linux-user/elfload.c | 8 +++-----
> > =C2=A0 1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20


