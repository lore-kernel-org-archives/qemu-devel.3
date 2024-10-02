Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C19CF31A0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuPX-0006ki-64; Wed, 02 Oct 2024 04:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svuPT-0006jc-By
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svuPR-0002bT-AM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49284i7q012248;
 Wed, 2 Oct 2024 08:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 C3wkXVEnJJToyLZInQR0lVnJ4vl+x4k4gnBBFJ5X6gw=; b=oTk7Jo+OUf9hbPYy
 uNOHyp2L6qHeUd+bVLS7iAy9XMgMdXsblsm6AOal4NTcWHCljrICA3t522TnZMBY
 ha211U6saD/TUsovL3WfT6rMfbV7euSJSVvz+sJ0QwzU2IUZjdoNs9bZHrE4gdgN
 77dy1ik85OM5DeUUAwniqtPQcbmm576FoG5zmHVA8860/3zpx3JvgNDFtjE4D1ls
 KiRqGvnT1AD8ZD69Mx8+KS2MqZAZ1unbRBLkquZI2w/AXPR06NIIHjT+GZPoA4Xz
 aw2ixxTr8QWyr+AIPZ60ONLZYilBk3OWKizSsbKaz3RCfilUT2fE1ipmUc4tNHzV
 ocn68w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4212bmr0ng-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 08:08:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4927PHce014145;
 Wed, 2 Oct 2024 07:54:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk8tmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 07:54:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4927s8Kk50331976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 07:54:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AFCA20043;
 Wed,  2 Oct 2024 07:54:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 142DF20040;
 Wed,  2 Oct 2024 07:54:08 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 07:54:07 +0000 (GMT)
Message-ID: <476e5647ed10327c955809de9a4bafd45e8c2c1f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/5] linux-user: Correct print_sockaddr() format
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Date: Wed, 02 Oct 2024 09:54:07 +0200
In-Reply-To: <20240807124306.52903-2-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
 <20240807124306.52903-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q9ZEgbyBPkrE8aTw4vb2mKvPTFxSGfce
X-Proofpoint-ORIG-GUID: q9ZEgbyBPkrE8aTw4vb2mKvPTFxSGfce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020059
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Wed, 2024-08-07 at 14:43 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> When the %addr argument can not be accessed, a double comma
> is logged (the final qemu_log call prepend a comma). Call
> print_raw_param with last=3D1 to avoid the extra comma.
> Remove spurious space.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> =C2=A0linux-user/strace.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b4d1098170..73f81e66fc 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -434,9 +434,9 @@ print_sockaddr(abi_ulong addr, abi_long addrlen,
> int last)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_user(sa, addr, 0)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_raw_param("0x"TARGET_AB=
I_FMT_lx, addr, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_raw_param("0x"TARGET_AB=
I_FMT_lx, addr, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comm=
a(last));
> +=C2=A0=C2=A0=C2=A0 qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma=
(last));
> =C2=A0}
> =C2=A0
> =C2=A0static void

I see why this works, but it feels a bit wrong semantically: addr is
not the last argument.
Wouldn't it be better to add commas to the preceding switch's cases?

Anyhow:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

