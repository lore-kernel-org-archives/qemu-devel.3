Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434B4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXoEN-0002Xi-Hv; Tue, 14 Jan 2025 16:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXoEI-0002XI-1o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:13:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXoEF-0006j6-JY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:13:41 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EE6kFg014295;
 Tue, 14 Jan 2025 21:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y4cbnm
 gBC1NCTW85pwlQG8wzFbKC80KndlsHT+uzQWI=; b=SDrWpKHDZZcfqQOQOVHuDr
 PdtO6r/+hGpKHkKuPyl99RP5mEP/PF/2dxIS8pMcGf2YMPWjvxcxWOzXLRoJx8wF
 T0+pRSgN82GSWa2/DUu0t05Dy2LOxOrbVcQ6tOT1PE09ESBaOzXtGOava1Ej7Jlq
 WE9ta1logcc+54n0Yb7bTsdFBfXp+bd9dH2EibNgY8wonHRwQrTmpgeboDUtlEF8
 i91YxAzP79RVtsdwxNw3RWMTdFammTPGuEv8C8iS0DqSoG3DITUltL2ofZUVhSYd
 V4JxcuriIDNtzj/zl5goMsMbZarDeMni7Sgq4xzfa3hvdBctC3tF67GxG0tY9M/g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445sd61u5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 21:13:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EKnxSx002738;
 Tue, 14 Jan 2025 21:13:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by57rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 21:13:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50ELDRro43385254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 21:13:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF50520A96;
 Tue, 14 Jan 2025 20:52:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FAEC20A94;
 Tue, 14 Jan 2025 20:52:04 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2025 20:52:04 +0000 (GMT)
Message-ID: <a049262b76fadb8fe0a3cd6968709b5cd1e0ec6b.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] accel/tcg: Implement cpu_exec_reset_hold() on user
 emulation
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Riku
 Voipio <riku.voipio@iki.fi>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Date: Tue, 14 Jan 2025 21:52:03 +0100
In-Reply-To: <6d1171d8debb462f468bb47ff875e0e9db253b4e.camel@linux.ibm.com>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-4-philmd@linaro.org>
 <6d1171d8debb462f468bb47ff875e0e9db253b4e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uzXlJDpvvqLNSwq6D2dh0tNm63EPMXnR
X-Proofpoint-ORIG-GUID: uzXlJDpvvqLNSwq6D2dh0tNm63EPMXnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=963 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2025-01-10 at 00:43 +0100, Ilya Leoshkevich wrote:
> On Thu, 2025-01-02 at 19:25 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> > Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold()
> > out") wanted to restrict tlb_flush() to system emulation,
> > but inadvertently also restricted tcg_flush_jmp_cache(),
> > which was before called on user emulation via:
> >=20
> > =C2=A0 Realize -> Reset -> cpu_common_reset_hold()
> >=20
> > Since threads (vCPUs) use a common CPUJumpCache, when many
> > threads are created / joined, they eventually end re-using
> > a CPUJumpCache entry, which was cleared when the first vCPU
> > was allocated (via Realize) but then stayed dirty, leading to:
>=20
> How are jump caches shared between qemu-user vCPUs?
> I found the following, but this looks private and zeroed out
> during initialization:
>=20
> bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
> [...]
> =C2=A0=C2=A0=C2=A0 cpu->tb_jmp_cache =3D g_new0(CPUJumpCache, 1);
>=20
> I was also wondering whether vCPUs themselves may be recycled, but
> it doesn't seem to be the case, since do_fork() -> cpu_copy() ->
> cpu_create() -> object_new() -> object_new_with_type() calls
> g_malloc().
>=20
>=20
>=20
> Btw, I tried to reproduce the original issue, but bumped into
> something
> seemingly unrelated. To make matters worse, debugging seems to be
> broken, so it may take some time before I can properly test this
> change.
>=20
> Thread 2 received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 37607.37622]
> 0x000002aa00a6a64c in cs_option (ud=3D140251083477344,
> type=3DCS_OPT_SYNTAX, value=3D2) at capstone/cs.c:782
> 782=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return arch_configs[handle->arch].arch_option(handle,
> type, value);
> (gdb) info threads
> Ignoring packet error, continuing...

With a small debugger fix [1] I finally managed to investigate and fix
the crash, which turned out to be not caused by QEMU [2], and with that
the testsuite ran without further issues. So I don't seem to be able to
reproduce the original issue to verify this series.

[1]
https://lore.kernel.org/qemu-devel/20250113134658.68376-1-iii@linux.ibm.com=
/
[2] https://github.com/capstone-rust/capstone-rs/pull/166

