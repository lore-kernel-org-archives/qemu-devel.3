Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED5CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vyv-0007J0-PD; Wed, 15 Oct 2025 03:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8vyi-0007GT-MT; Wed, 15 Oct 2025 03:31:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8vyX-0002qA-Mi; Wed, 15 Oct 2025 03:31:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F3lbMA026012;
 Wed, 15 Oct 2025 07:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xsIJc+
 jtoiFf+VqBJVS/ayLvbllekIHDdnrrkpVH+VM=; b=ZNam3QMNRBlQbcLfCMQVGE
 spXcU8iPJ7gpw6WFCXfXa+14++HlkCwYxsPTmq3QYJaleE7VE5pip+wbjkWUvsam
 utCibIuqXsLofaoQkKAX40aIQPUqTlfp43Wohq5xLSyZio7wJ0ZhN6T53tbjfH0g
 mZJwavAAmC+xm71WHWcdKufJ5LN979kH24u4B0kQ7AU022023oa1VB49b4D0dzoi
 rAk4babmRKWGY96hrfCVADypazko89rK3BUdUkZ1j7f4xiwlfVNcZqIubDu2Zi5p
 a3MqYuCFPo9cfZ9ZNa5nTgn/ERwAhWNjWem6EhlPLD5DmPMXyY02xgSLJVh2lVuQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu34wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 07:30:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F3fkrv018362;
 Wed, 15 Oct 2025 07:30:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf8qt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 07:30:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59F7UvQ330802178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 07:30:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 204FF20082;
 Wed, 15 Oct 2025 07:30:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF81C20081;
 Wed, 15 Oct 2025 07:30:56 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.38.145])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 07:30:56 +0000 (GMT)
Message-ID: <a0e889041a6b3859f4a836267eec6cbb684f9141.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test SET CLOCK COMPARATOR
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 15 Oct 2025 09:30:56 +0200
In-Reply-To: <20251014160743.398093-4-iii@linux.ibm.com>
References: <20251014160743.398093-1-iii@linux.ibm.com>
 <20251014160743.398093-4-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eNsRje0hyoJpMKah5VsRmizExaZ5YHwa
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ef4db3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=i63yiTcfY29hF2XPRv4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: eNsRje0hyoJpMKah5VsRmizExaZ5YHwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX2VdbqaUUUEkA
 tkjHLWMkklUWCriyZ9xCh0544tMFzin6rn2fmZe+CjLxxsXfHO0pGYmKV5Qh8VRIPGM5K4JZLND
 qTBPyyXeq0hGCk9z/JBUAjg9YUZhPVKxvLmEwCzttyaSuPFba80Kn97oQcBQMm7F5bf+IT1bFz1
 f96BBvuiqogdUdpI88QWwmpuDU2OhNx4ekqQWLY4eSH976oT1zaAehHK3+ikCzgGYexNp3l+SUd
 y+n0q2DmUbY//T2fm03GInGEPsTzkkPneIh21NowAtGBMHnnhpktBPfzeFgH4AZ3z6Jrsq3uRnK
 uL4lM4NtJz48XQ0yXtP7aKEQKv9BBfFxvftUu4BQ2E4fWU8Ahz/mhg4/+5qaeVaOGo2nLholowk
 x8DkMc/KOVCS5ltduyF1PDqZD05sww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
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

On Tue, 2025-10-14 at 18:05 +0200, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0tests/tcg/s390x/Makefile.softmmu-target |=C2=A0 1 +
> =C2=A0tests/tcg/s390x/sckc.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53
> +++++++++++++++++++++++++
> =C2=A02 files changed, 54 insertions(+)
> =C2=A0create mode 100644 tests/tcg/s390x/sckc.S

[...]

> diff --git a/tests/tcg/s390x/sckc.S b/tests/tcg/s390x/sckc.S
> new file mode 100644
> index 00000000000..0fadec0dd65
> --- /dev/null
> +++ b/tests/tcg/s390x/sckc.S
> @@ -0,0 +1,53 @@
> +/*
> + * Test clock comparator.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +=C2=A0=C2=A0=C2=A0 .org 0x130
> +ext_old_psw:
> +=C2=A0=C2=A0=C2=A0 .org 0x1b0
> +ext_new_psw:
> +=C2=A0=C2=A0=C2=A0 .quad 0x180000000, _ext=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 64-bit mode */
> +=C2=A0=C2=A0=C2=A0 .org 0x200=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* lowcore padding */
> +
> +=C2=A0=C2=A0=C2=A0 .globl _start
> +_start:
> +=C2=A0=C2=A0=C2=A0 lpswe start31_psw
> +_start31:
> +=C2=A0=C2=A0=C2=A0 stctg %c0,%c0,c0
> +=C2=A0=C2=A0=C2=A0 oi c0+6,8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* set clock-comparator
> subclass mask */
> +=C2=A0=C2=A0=C2=A0 lctlg %c0,%c0,c0
> +0:
> +=C2=A0=C2=A0=C2=A0 cghsi ext_counter,0x1000
> +=C2=A0=C2=A0=C2=A0 jnz 0b

It's better to move this check to the interrupt handler, otherwise
there is a risk we get two interrupts and the counter moves from
0xfff to 0x1001, causing an infinite loop. I will fix this in v2.

> +=C2=A0=C2=A0=C2=A0 lpswe success_psw
> +
> +_ext:
> +=C2=A0=C2=A0=C2=A0 stg %r0,ext_saved_r0
> +
> +=C2=A0=C2=A0=C2=A0 lg %r0,ext_counter
> +=C2=A0=C2=A0=C2=A0 aghi %r0,1
> +=C2=A0=C2=A0=C2=A0 stg %r0,ext_counter

[...]

