Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A2BCF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtH9-0001ZO-VT; Wed, 02 Oct 2024 02:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svtH8-0001YW-Dl
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 02:55:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svtH5-0003XF-VA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 02:55:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4926MoKh028865;
 Wed, 2 Oct 2024 06:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 /UF2Cd0FkfS8Z1dAZ739LwzvAmqlrtJ0ksopKJrCm10=; b=GnqTA6lYQhAYJyzP
 W7hKT/joT/eRSVU28+qO49wuWFEuMUGF8nRwW/Z6bwCv2NxvCqaNCtXv6zQUu3r0
 IdLO7tsMVkpHBUXH+nKT/MapToKagglVywJG4/svkj2aa3M8vDabH7teCIanKNbU
 GRbtCs5nCGxAAOfjYrirOwl64KqQbbyKsLxk5t/TsuovA4H4e/3eQR4B1ruQOmXf
 ZCpmyx7CXoq0LctV/3B2mQmAw36pkgsslopBw7KG/HdGeOxypo9yZZS69WkAytCl
 +XfTnnINZYIRHMOd5555cST2gYWmrhzVpgkonDfqmJyREkbcrnhxO8vP8RO4J855
 wkG8pg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4210u0r4a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 06:55:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49246IhM013007;
 Wed, 2 Oct 2024 06:55:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjgemr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 06:55:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4926tEMU57868724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 06:55:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6528720040;
 Wed,  2 Oct 2024 06:55:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F21CD2004B;
 Wed,  2 Oct 2024 06:55:13 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 06:55:13 +0000 (GMT)
Message-ID: <d6e29a8aeb083bc937e77233a61f988de6b63eab.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] linux-user: Add strace for recvfrom()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Date: Wed, 02 Oct 2024 08:55:13 +0200
In-Reply-To: <20240807124306.52903-6-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
 <20240807124306.52903-6-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SQVX7YR20pQbGeYtoLCjVN3_gVGDcbWa
X-Proofpoint-ORIG-GUID: SQVX7YR20pQbGeYtoLCjVN3_gVGDcbWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_06,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=752
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020049
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

On Wed, 2024-08-07 at 14:43 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> =C2=A0linux-user/strace.c=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++++++
> =C2=A0linux-user/strace.list |=C2=A0 2 +-
> =C2=A02 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 98ef26b917..d76907fdc9 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -3127,6 +3127,25 @@ print_bind(CPUArchState *cpu_env, const struct
> syscallname *name,
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +#ifdef TARGET_NR_recvfrom
> +static void
> +print_recvfrom(CPUArchState *cpu_env, const struct syscallname
> *name,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 abi_long arg0, abi_long arg1, abi_long arg2,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +=C2=A0=C2=A0=C2=A0 abi_ulong addrlen;
> +
> +=C2=A0=C2=A0=C2=A0 get_user_ualx(addrlen, arg5, 0);
> +
> +=C2=A0=C2=A0=C2=A0 print_syscall_prologue(name);
> +=C2=A0=C2=A0=C2=A0 print_sockfd(arg0, 0);
> +=C2=A0=C2=A0=C2=A0 print_buf_len(arg1, arg2, 0);
> +=C2=A0=C2=A0=C2=A0 print_flags(msg_flags, arg3, 0);
> +=C2=A0=C2=A0=C2=A0 print_sockaddr(arg4, addrlen, 1);
> +=C2=A0=C2=A0=C2=A0 print_syscall_epilogue(name);
> +}
> +#endif
> +
> =C2=A0#ifdef TARGET_NR_sendto
> =C2=A0static void
> =C2=A0print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 5a86419e7d..77ca824f9c 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1135,7 +1135,7 @@
> =C2=A0{ TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
> =C2=A0#endif
> =C2=A0#ifdef TARGET_NR_recvfrom
> -{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
> +{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
> =C2=A0#endif
> =C2=A0#ifdef TARGET_NR_recvmmsg
> =C2=A0{ TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },

I needed to implement read()/write() tracing and stumbled upon this
series, which overall looks like a good thing to have. I spotted a few
issues though.


I get the following build error:

qemu/linux-user/strace.c:3138:5: error: implicit declaration of
function =E2=80=98get_user_ualx=E2=80=99; did you mean =E2=80=98get_user_ua=
l=E2=80=99? [-Wimplicit-
function-declaration]
 3138 |     get_user_ualx(addrlen, arg5, 0);
      |     ^~~~~~~~~~~~~
      |     get_user_ual


The following helps:

--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2666,11 +2666,15 @@ static void print_sockfd(abi_long sockfd, int
last)
=20
 #endif
=20
-#if defined(TARGET_NR_socketcall)
+#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_recvfrom)
=20
 #define get_user_ualx(x, gaddr, idx) \
         get_user_ual(x, (gaddr) + (idx) * sizeof(abi_long))
=20
+#endif
+
+#if defined(TARGET_NR_socketcall)
+
 static void do_print_socket(const char *name, abi_long arg1)
 {
     abi_ulong domain, type, protocol;


With this I get the following output, which w.r.t. its shape looks
good:

598730 recvfrom(3,"HTTP/1.1 400 Bad request\15\12Connection:
Cl"...,8192,0,{sa_family=3D0, sa_data=3D{00, 00, 00, 00, 00, 00, 00, 00,
00, 00, 00, 00, 00, 00}},128) =3D 0

However: aren't we printing the contents of the buffer before the
syscall returns? Same with sockaddr. This would make the output not
very useful.

