Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81D6E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW2Bm-0003p7-Pe; Thu, 09 Jan 2025 18:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tW2Bl-0003oh-7i
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:43:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tW2Bj-00058j-J5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:43:45 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509ElPf4005236;
 Thu, 9 Jan 2025 23:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kFyNMv
 mf/kNnG24Gc/GIgnN5b6RBKoKcYlXh4WtHEiM=; b=oR6qDap+HO185PT4qkAP66
 OrwFuNPvEtR4EwMmi5oWg02VALzC8rSg4Ecc0/qJD0OBVqA6CSsQxWV4bIeMH5+z
 c4dd/f+Cx/ANQcj1WSo42He1kO8gqGIma37smvTiSVlia6gDRNlZ08oi2lBl6iaq
 p2ygsvLeWIWJ6iiQAJzZ1354XO0qsjaW2JqtL3SL6rKjSI6X9ypz1Et7QCYoS7RI
 Mh2YeIlR9y+kcCctTXhyRqpmqQZZM0VKTEHQ4GO+41hkxMRmDsmIHwutlDT+0wgo
 qBtn8yzwreTDDIBdvIMwO3bolUStcRJTj5u69196D6qA29dMb39557BNFzTI44pw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xccurn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 23:43:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509LC1kH027997;
 Thu, 9 Jan 2025 23:43:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhkfce5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 23:43:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 509NhZwO51642728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 23:43:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F6FE20043;
 Thu,  9 Jan 2025 23:43:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFE3420040;
 Thu,  9 Jan 2025 23:43:34 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jan 2025 23:43:34 +0000 (GMT)
Message-ID: <6d1171d8debb462f468bb47ff875e0e9db253b4e.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] accel/tcg: Implement cpu_exec_reset_hold() on user
 emulation
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Riku
 Voipio <riku.voipio@iki.fi>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Date: Fri, 10 Jan 2025 00:43:34 +0100
In-Reply-To: <20250102182521.65428-4-philmd@linaro.org>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-4-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4i3ly2FCDDuKgdUyocD00sEzSXiRVH_4
X-Proofpoint-ORIG-GUID: 4i3ly2FCDDuKgdUyocD00sEzSXiRVH_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=861 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090185
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

On Thu, 2025-01-02 at 19:25 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold()
> out") wanted to restrict tlb_flush() to system emulation,
> but inadvertently also restricted tcg_flush_jmp_cache(),
> which was before called on user emulation via:
>=20
> =C2=A0 Realize -> Reset -> cpu_common_reset_hold()
>=20
> Since threads (vCPUs) use a common CPUJumpCache, when many
> threads are created / joined, they eventually end re-using
> a CPUJumpCache entry, which was cleared when the first vCPU
> was allocated (via Realize) but then stayed dirty, leading to:

How are jump caches shared between qemu-user vCPUs?
I found the following, but this looks private and zeroed out
during initialization:

bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
[...]
    cpu->tb_jmp_cache =3D g_new0(CPUJumpCache, 1);

I was also wondering whether vCPUs themselves may be recycled, but
it doesn't seem to be the case, since do_fork() -> cpu_copy() ->
cpu_create() -> object_new() -> object_new_with_type() calls
g_malloc().



Btw, I tried to reproduce the original issue, but bumped into something
seemingly unrelated. To make matters worse, debugging seems to be
broken, so it may take some time before I can properly test this
change.

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 37607.37622]
0x000002aa00a6a64c in cs_option (ud=3D140251083477344,
type=3DCS_OPT_SYNTAX, value=3D2) at capstone/cs.c:782
782             return arch_configs[handle->arch].arch_option(handle,
type, value);
(gdb) info threads
Ignoring packet error, continuing...



