Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2F6CF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtyW-0004oV-JV; Wed, 02 Oct 2024 03:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svtyR-0004nd-FN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:40:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svtyO-0008GO-E3
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:40:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927PDvb029117;
 Wed, 2 Oct 2024 07:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 sR5irwpddhEU9Hu3cPlkj04RG+gkX+vQjXpzee9rl64=; b=i1ivXCPiLgrTa8kQ
 XqOl4mJLAnPP/SHxaHCjKVWmzv8BL9VibW1uvXe3cK6IhvyLTni+nuTFM/cMwvM0
 5/oPcuIVRmwB6G7LJ1lmlZL4JP6u3fCEk1GXE5Z+qhsTMen3PJaWnOPYwVbxAkUv
 MTuyDfYDdia2pNhPV/cJM40A16y0QPPL47ItibjgONcapSoFglNEgRDfIdOqcvAx
 ypj4AwRFxgKr9p2D40KA5tWHYnMIpJ+pYCh+XSgsGt1v7XQubD6ks0sL8blRQ172
 dulJ+Zww9q47R989pjpqcxsN4bConGkI5eGtVpyEEfViKQEf0KXJrR+L4SkE1Nhh
 poXYPw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4211s0026a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 07:40:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4927Vm3P014098;
 Wed, 2 Oct 2024 07:40:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk8r3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 07:40:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4927eWxi56688942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 07:40:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F3D320043;
 Wed,  2 Oct 2024 07:40:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAF1B2004B;
 Wed,  2 Oct 2024 07:40:31 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 07:40:31 +0000 (GMT)
Message-ID: <c9af55f74798b23dd68201ba580e23c60d2182c1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] linux-user: Add strace for sendto()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Date: Wed, 02 Oct 2024 09:40:31 +0200
In-Reply-To: <20240807124306.52903-5-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
 <20240807124306.52903-5-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fl21bH7rKkcrz933OaghYF0v69pZFZMK
X-Proofpoint-ORIG-GUID: Fl21bH7rKkcrz933OaghYF0v69pZFZMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=916 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020055
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> =C2=A0linux-user/strace.c=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++++
> =C2=A0linux-user/strace.list |=C2=A0 2 +-
> =C2=A02 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 210ff86afc..98ef26b917 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -3127,6 +3127,21 @@ print_bind(CPUArchState *cpu_env, const struct
> syscallname *name,
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +#ifdef TARGET_NR_sendto
> +static void
> +print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 abi_long arg0, abi_long arg1, abi_long arg2,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +=C2=A0=C2=A0=C2=A0 print_syscall_prologue(name);
> +=C2=A0=C2=A0=C2=A0 print_sockfd(arg0, 0);
> +=C2=A0=C2=A0=C2=A0 print_buf_len(arg1, arg2, 0);
> +=C2=A0=C2=A0=C2=A0 print_flags(msg_flags, arg3, 0);
> +=C2=A0=C2=A0=C2=A0 print_sockaddr(arg4, arg5, 1);
> +=C2=A0=C2=A0=C2=A0 print_syscall_epilogue(name);
> +}
> +#endif
> +
> =C2=A0#if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
> =C2=A0=C2=A0=C2=A0=C2=A0 defined(TARGET_NR_lstat) || defined(TARGET_NR_ls=
tat64)
> =C2=A0static void
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index dfd4237d14..5a86419e7d 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1285,7 +1285,7 @@
> =C2=A0{ TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
> =C2=A0#endif
> =C2=A0#ifdef TARGET_NR_sendto
> -{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
> +{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
> =C2=A0#endif
> =C2=A0#ifdef TARGET_NR_setdomainname
> =C2=A0{ TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },

The output looks reasonable:

607813
sendto(9,"\24\0\0\0\26\0\1\3\242\370\374f\0\0\0\0\0\0\0\0",20,0,{nl_fam
ily=3DAF_NETLINK,nl_pid=3D0,nl_groups=3D0},12) =3D 20

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

