Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163E0E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW2QE-0007ta-CB; Thu, 09 Jan 2025 18:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tW2QC-0007tM-Hv; Thu, 09 Jan 2025 18:58:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tW2QA-000854-K8; Thu, 09 Jan 2025 18:58:40 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509NwOa0000885;
 Thu, 9 Jan 2025 23:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7hGvMX
 HUFksZznJIkLa/iu1DdXX6JGQBuO+1KdJW5wE=; b=ig6MEew/7D8klItpKXonF+
 Keh4cLlwh4n+MRcR47tZh55hKj97VKXPBh3WPedAT3BesyHJWv9bQbeV7m2vwSqT
 bw1TPcxmNm1vL9qeq6RMn5VJfW5MlPx1klW3vp84mVbFqQUvvu3S0RRjMIGz3GME
 6KNfuS66y7gCmWQuNpGwb+cyAbP5VUWJdJOtDANUgA0xgM40i4NOySgsakw4ynic
 GaQLucbcIUO0zquIYZxCr5S4b3ojVk2WdX+GVHE7iIq3qAOj3PGVOIMNNU4J4EwC
 D8h7OsrWNJ06ur5Ds/FkDpdywfOFdf7yY/mYV/iz8eqvhhCZwoC2ozHtvlyZU1sQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhr015-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 23:58:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509NwYsE000987;
 Thu, 9 Jan 2025 23:58:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhr013-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 23:58:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509K6xg3013659;
 Thu, 9 Jan 2025 23:58:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap7mea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 23:58:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 509NwVY547383002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 23:58:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 438F62004B;
 Thu,  9 Jan 2025 23:58:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFAB820040;
 Thu,  9 Jan 2025 23:58:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jan 2025 23:58:30 +0000 (GMT)
Message-ID: <d49cfe80f72cc06dd43181f64427b75fd3a58007.camel@linux.ibm.com>
Subject: Re: [PATCH] gdbstub/user-target: fix gdbserver int format (%d -> %x)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, qemu-trivial@nongnu.org
Date: Fri, 10 Jan 2025 00:58:30 +0100
In-Reply-To: <20241227170413.72438-1-dominik.b.czarnota@gmail.com>
References: <20241227170413.72438-1-dominik.b.czarnota@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AuTtCYh1Fv94VnKpgEOF2afe1ft_bbdg
X-Proofpoint-GUID: i9uqhxs4pBAAW2hgi6t1dpQrgIO1S991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2024-12-27 at 18:04 +0100, Dominik 'Disconnect3d' Czarnota
wrote:
> From: disconnect3d <dominik.b.czarnota@gmail.com>
>=20
> This commit fixes an incorrect format string for formatting integers
> provided to GDB when debugging a target run in QEMU user mode.
>=20
> The correct format is hexadecimal for both success and errno values,
> some of which can be seen here [0].
>=20

Nice catch, I haven't tested this with a lot of fds. After adding
3</dev/null 4</dev/null [...] 9</dev/null to an emulated program,
I get:

(gdb) info proc mappings
process 37804
warning: unable to open /proc file '/proc/37804/maps'

And with your fix:

(gdb) info proc mappings
process 37816
Mapped address spaces:

          Start Addr           End Addr       Size     Offset  Perms=20
objfile
       0x2aa00000000      0x2aa0123d000  0x123d000        0x0  r-xp =20
/home/iii/myrepos/wasmtime/target/s390x-unknown-linux-
gnu/debug/deps/filetests-fab17457420757a9
[...]

I would recommend the following tags:

Fixes: e282010b2e1e ("gdbstub: Add support for info proc mappings")
Cc: qemu-stable@nongnu.org

In any case:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

> [0]
> https://github.com/bminor/binutils-gdb/blob/e65a355022d0dc6b5707310876a72=
b5693ec0aa5/gdbserver/hostio.cc#L196-L213
> ---
> =C2=A0gdbstub/user-target.c | 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index 22bf4008c0..4bfcf78aaa 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -317,9 +317,9 @@ void gdb_handle_v_file_open(GArray *params, void
> *user_ctx)
> =C2=A0=C2=A0=C2=A0=C2=A0 int fd =3D open(filename, flags, mode);
> =C2=A0#endif
> =C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%d", errno);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%x", errno);
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F%d", fd);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F%x", fd);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_strbuf();
> =C2=A0}
> @@ -329,7 +329,7 @@ void gdb_handle_v_file_close(GArray *params, void
> *user_ctx)
> =C2=A0=C2=A0=C2=A0=C2=A0 int fd =3D gdb_get_cmd_param(params, 0)->val_ul;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (close(fd) =3D=3D -1) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%d", errno);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%x", errno);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_strbuf();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -352,7 +352,7 @@ void gdb_handle_v_file_pread(GArray *params, void
> *user_ctx)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t n =3D pread(fd, buf, bufsiz, offset);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (n < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%d", errno);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%x", errno);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_strbuf();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -375,7 +375,7 @@ void gdb_handle_v_file_readlink(GArray *params,
> void *user_ctx)
> =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t n =3D readlink(filename, buf, BUFSIZ);
> =C2=A0#endif
> =C2=A0=C2=A0=C2=A0=C2=A0 if (n < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%d", errno);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_sta=
te.str_buf, "F-1,%x", errno);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_strbuf();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }


