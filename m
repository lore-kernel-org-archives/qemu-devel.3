Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7B9CFB43F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxBUv-00082r-CC; Sat, 05 Oct 2024 16:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sxBUt-00080t-EH
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:35:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sxBUr-0004je-Gj
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:35:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495KKiiu008235;
 Sat, 5 Oct 2024 20:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 zjTa8bgRI8bMveUvzdumQzMvmtWxIZTg+ZfCxdresX4=; b=UVUeRJZqEjUhL9pL
 qJG4piMwSwB5eKCqGNcTNjIC9qQlKWE8KHkSCUMMFJ8IyS1jXprKd1UffOSb6ALQ
 Qs+vWsyecnH/S6MRvcCI62gGC7WdRuyMhMiU5oVbSsRTAtefA46IxUIA2d79+Ylk
 wPckBIY01fHGQUbL35buIRk7ERzzDOI/Ja7RatsvO1fbAZiuXguRigflvKPT6nd4
 IPFpBb7ipQsglMgRnW7fydY3wJCzjhyEwVG6aMPEZEXaAESdBmsP5+p1If4fM48e
 hj+yYUoSjlMH4PCOdkTyyqjLLSQHk8zisLe0ynVSBwXVFBLy6U6/QOj/+siGlmdg
 vE0Zhw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 423cd9r0ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Oct 2024 20:35:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 495KZMV7002910;
 Sat, 5 Oct 2024 20:35:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 423cd9r0wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Oct 2024 20:35:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 495GGsRx009434;
 Sat, 5 Oct 2024 20:35:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42207hthta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Oct 2024 20:35:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 495KZKBE15008122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 5 Oct 2024 20:35:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4358520040;
 Sat,  5 Oct 2024 20:35:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D928620043;
 Sat,  5 Oct 2024 20:35:19 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  5 Oct 2024 20:35:19 +0000 (GMT)
Message-ID: <7531a0890a2f804b9e5e89e80d019ea53c738eab.camel@linux.ibm.com>
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Sat, 05 Oct 2024 22:35:19 +0200
In-Reply-To: <7cf5d0a94cc52ac9f8144eb5d1cc83811755ea98.camel@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
 <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
 <6d820efe-7f0b-4b6b-946d-e1815934e4e9@linaro.org>
 <7cf5d0a94cc52ac9f8144eb5d1cc83811755ea98.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RVvVWdakh2kZ69R7RQ4OKASzDhprkD1a
X-Proofpoint-GUID: y_2qGMv4ZKzDjHtCbHc8x-z2L5vlNzn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_20,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxlogscore=884 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 2024-10-05 at 22:26 +0200, Ilya Leoshkevich wrote:
> On Sat, 2024-10-05 at 12:51 -0700, Richard Henderson wrote:
> > On 9/25/24 00:43, Ilya Leoshkevich wrote:
> > > On Tue, 2024-09-24 at 13:46 +0200, Richard Henderson wrote:
> > > > On 9/23/24 18:12, Ilya Leoshkevich wrote:
> > > > > Hi,
> > > > >=20
> > > > > On reporting a breakpoint in a non-non-stop mode, GDB remotes
> > > > > must
> > > > > stop
> > > > > all threads. Currently qemu-user doesn't do that, breaking
> > > > > the
> > > > > debugging session for at least two reasons: concurrent access
> > > > > to
> > > > > the
> > > > > GDB socket, and an assertion within GDB [1].
> > > > >=20
> > > > > This series fixes this by importing pause_all_vcpus() from
> > > > > qemu-
> > > > > system.
> > > > > This in turn requires introducing BQL and a few stubs to
> > > > > qemu-
> > > > > user.
> > > >=20
> > > > I would have expected you to reuse (some portion of)
> > > > start_exclusive,
> > > > which is already
> > > > part of qemu-user.=C2=A0 Is there a reason you chose a solution
> > > > which
> > > > requires...
> > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 replay: Add replay_mutex_{lock,unlock}() stubs=
 for qemu-
> > > > > user
> > > > > =C2=A0=C2=A0=C2=A0 qemu-timer: Provide qemu_clock_enable() stub f=
or qemu-
> > > > > user
> > > > > =C2=A0=C2=A0=C2=A0 cpu: Use BQL in qemu-user
> > > >=20
> > > > all sorts of other infrastructure?
> > > >=20
> > > >=20
> > > > r~
> > >=20
> > > I don't think start_exclusive() would protect the gdb socket from
> > > concurrent accesses (e.g., if two threads are simultaneously
> > > stopped).
> >=20
> > Of course it would, otherwise "exclusive" has no meaning.
> > All other cpus are blocked in exclusive_idle().
> >=20
> > Importantly, no cpus are blocked in syscalls, where the kernel can
> > modify memory behind=20
> > gdbstub's back (e.g. read).=C2=A0 I think considering "in_syscall" to b=
e
> > "paused" a mistake.
> >=20
> >=20
> > r~
>=20
> How can we handle the long-running syscalls?
> Just waiting sounds unsatisfying.
> Sending a reserved host signal may alter the guest's behaviour if a
> syscall like pause() is interrupted.
> What do you think about SIGSTOP-ping the "in_syscall" threads?
> A quick experiment shows that it should be completely invisible to
> the
> guest - the following program continues to run after SIGSTOP/SIGCONT:
>=20
> #include <sys/syscall.h>
> #include <unistd.h>
> int main(void) { syscall(__NR_pause); };

Hmm, no, that won't work: SIGSTOP would stop all threads.

So I wonder if reserving a host signal for interrupting "in_syscall"
threads would be an acceptable tradeoff?

