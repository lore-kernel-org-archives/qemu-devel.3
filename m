Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAD9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYD4Z-0006PU-W5; Wed, 15 Jan 2025 18:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYD4W-0006OA-Ts
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:45:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYD4U-0006p1-VD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:45:16 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX4Zx019771;
 Wed, 15 Jan 2025 23:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zwKp+L
 oxzrYO/2GpKZ10jp1cGwqyll6wkgWrImD7gKM=; b=Mhb0i0LSuRCCuTI53EQYzX
 5uLES8SSJ/Qv0TepGvudCX/u843I5hLKU/fFfl6lMxNjNl08rsYwLA3/OyqXjm64
 hWcU2mHflUHoOY1bfWs7ymJxCuv5VAB1onQT5KfP4dRPVLHFGpgEkzNut5z4KzCg
 7v1NzerBgLeVuKwj56DcoaeRylH/ycffaQ0FIThjLUxUSy9soG+1J+XQHtG+0cZx
 FbQFyp0RY1qK4ADKXpWDk6TupAlO//3r3XNAJuxEp8JTgkd7smrXje7zAG96BN8A
 0XSjMRdt4Vu3kAlRCtboGmHpBZzFs5Nz2LboZ1mdB5mNAcnshd1/yID5we+qFeGQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446eg5tj2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 23:45:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FKkNFW007462;
 Wed, 15 Jan 2025 23:45:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynb01s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 23:45:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FNj24u55837156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 23:45:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31E3D20040;
 Wed, 15 Jan 2025 23:45:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECCB820043;
 Wed, 15 Jan 2025 23:45:01 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jan 2025 23:45:01 +0000 (GMT)
Message-ID: <83530c56378f850d1908d12e50dcc40b214c35f7.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Add syscall dispatch support
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arusekk <floss@arusekk.pl>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Jan 2025 00:45:01 +0100
In-Reply-To: <20250115143623.8257-1-floss@arusekk.pl>
References: <20250115143623.8257-1-floss@arusekk.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1lonxTiqmtcDFuyoD5oHJTinlByGv3PL
X-Proofpoint-ORIG-GUID: 1lonxTiqmtcDFuyoD5oHJTinlByGv3PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_10,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=305
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 2025-01-15 at 15:36 +0100, Arusekk via wrote:
> This commit adds support for the `prctl(PR_SET_SYSCALL_DISPATCH)`
> function in the Linux userspace emulator.

Typo: this should be PR_SET_SYSCALL_USER_DISPATCH.

> It is implemented as a fully host-independent function, by forcing a
> SIGSYS early during syscall handling, if the PC is outside the
> allowed
> range.
>=20
> Tested on [uglendix][1], will probably also apply to recent versions
> of
> Wine that use syscall dispatch.
>=20
> [1]: https://sr.ht/~arusekk/uglendix
>=20
> Signed-off-by: Arusekk <floss@arusekk.pl>
> ---
> =C2=A0linux-user/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> =C2=A0linux-user/qemu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 +++
> =C2=A0linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 64
> ++++++++++++++++++++++++++++++++++++++-
> =C2=A0linux-user/syscall_defs.h |=C2=A0 6 ++++
> =C2=A04 files changed, 76 insertions(+), 1 deletion(-)

[...]

> @@ -13852,12 +13886,34 @@ static abi_long do_syscall1(CPUArchState
> *cpu_env, int num, abi_long arg1,
> =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0}
> =C2=A0
> +static bool sys_dispatch(abi_ulong pc, TaskState *ts)
> +{

What about this line from the kernel implementation?

        if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
                return false;

I think qemu's vdso implements sigreturn, e.g., in
linux-user/arm/vdso.S.

[...]


