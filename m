Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB06CEE356
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syeks-0002ia-IF; Wed, 09 Oct 2024 18:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1syekq-0002iG-BB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:02:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1syeko-0006mO-Cu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:02:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499M0LNd020749;
 Wed, 9 Oct 2024 22:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 C6CWbYpf9gcVNeuL6I1K7yXuLQYXYo48bEP1QkGXzsw=; b=BFrgChc5ZPwywdiO
 KB0EsAFpGuPg0eF9EY3LIII5hpkhPTDUpO976gFo2mLg9hQEpuR+XWNzeuIWdCyv
 e4DXxKQrLa9Y2unXL1Ign5rw23igSwiElU8M3VzdmqU3YMxJ5630C+a7AgHeNUpU
 r2tmETjMQMZ+J1/NwjXMtAvJbYmD77oSw6xU9rM1gmD5v/BibkODwW5MffxDhAx+
 rlBEL/p1cEggzmiT309prn60BKtH5hYrmPr4ZBsVB7U1D9lDKih04dRHKXXF6LGs
 L26SvXcD0QznJNgmDXztsfSXiEV7vrL1cKXs6fD3LMEtFrnMLzaiJ4lbj8F6OKvG
 FzKnDQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42627yr081-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Oct 2024 22:01:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 499M1q1H022678;
 Wed, 9 Oct 2024 22:01:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42627yr07w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Oct 2024 22:01:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499LfE54013838;
 Wed, 9 Oct 2024 22:01:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssccf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Oct 2024 22:01:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 499M1nGl50528700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2024 22:01:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8567C20067;
 Wed,  9 Oct 2024 22:01:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 356D22006C;
 Wed,  9 Oct 2024 22:01:49 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2024 22:01:49 +0000 (GMT)
Message-ID: <991185a8191694b489cf7d2374ffa99fc6a5ee82.camel@linux.ibm.com>
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Thu, 10 Oct 2024 00:01:48 +0200
In-Reply-To: <94ebebf2-e775-4fd2-8fcf-921610261a7e@linaro.org>
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
 <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
 <6d820efe-7f0b-4b6b-946d-e1815934e4e9@linaro.org>
 <7cf5d0a94cc52ac9f8144eb5d1cc83811755ea98.camel@linux.ibm.com>
 <7531a0890a2f804b9e5e89e80d019ea53c738eab.camel@linux.ibm.com>
 <94ebebf2-e775-4fd2-8fcf-921610261a7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pi4Ex1u_KwkFGu4F-PcWPB5EF8M07tSv
X-Proofpoint-ORIG-GUID: bkp9TDUSI7q5ybfbFNoKqe3ewZd7CKaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_20,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410090135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2024-10-08 at 11:17 -0700, Richard Henderson wrote:
> On 10/5/24 13:35, Ilya Leoshkevich wrote:
> > > How can we handle the long-running syscalls?
> > > Just waiting sounds unsatisfying.
> > > Sending a reserved host signal may alter the guest's behaviour if
> > > a
> > > syscall like pause() is interrupted.
> > > What do you think about SIGSTOP-ping the "in_syscall" threads?
> > > A quick experiment shows that it should be completely invisible
> > > to
> > > the
> > > guest - the following program continues to run after
> > > SIGSTOP/SIGCONT:
> > >=20
> > > #include <sys/syscall.h>
> > > #include <unistd.h>
> > > int main(void) { syscall(__NR_pause); };
> >=20
> > Hmm, no, that won't work: SIGSTOP would stop all threads.
> >=20
> > So I wonder if reserving a host signal for interrupting
> > "in_syscall"
> > threads would be an acceptable tradeoff?
>=20
> Could work, yes.=C2=A0 We already steal SIGRTMIN for guest abort (to
> distinguish from host=20
> abort), and remap guest __SIGRTMIN to host SIGRTMIN+1.=C2=A0 Grabbing
> SIGRTMIN+1 should work=20
> ok, modulo the existing problem of presenting the guest with an
> incomplete set of signals.
>=20
> I've wondered from time to time about multiplexing signals in this
> space, but I think that=20
> runs afoul of having a consistent mapping for interprocess signaling.
>=20
>=20
> r~

I tried to think through how this would work in conjunction with
start_exclusive(), and there is one problem I don't see a good solution
for. Maybe you will have an idea.

The way I'm thinking of implementing this is as follows:

- Reserve the host's SIGRTMIN+1 and tweak host_signal_handler() to do
  nothing for this signal.

- In gdb_try_stop(), call start_exclusive(). After it returns, some
  threads will be parked in exclusive_idle(). Some other threads will
  be on their way to getting parked, and this needs to actually happen
  before gdb_try_stop() can proceed. For example, the ones that are
  executing handle_pending_signal() may change memory and CPU state.
  IIUC start_exclusive() will not wait for them, because they are not
  "running". I think a global counter protected by qemu_cpu_list_lock
  and paired with a new condition variable should be enough for this.

- Threads executing long-running syscalls will need to be interrupted
  by SIGRTMIN+1. These syscalls will return -EINTR and will need
  to be manually restarted so as not to disturb poorly written guests.
  This needs to happen only if there are no pending guest signals.

- Here is a minor problem: how to identify threads which need to be
  signalled? in_syscall may not be enough. But maybe signalling all
  threads won't hurt too much. The parked ones won't notice anyway.

- But here is the major problem: what if we signal a thread just before
  it starts executing a long-running syscall? Such thread will be stuck
  and we'll need to signal it again. But how to determine that this
  needs to be done?

  An obvious solution is to signal all threads in a loop with a 0.1s
  delay until the counter reaches n_threads. But it's quite ugly.

  Ideally SIGRTMIN+1 should be blocked most of the time. Then we should
  identify all places where long-running syscalls may be invoked and
  unblock SIGRTMIN+1 atomically with executing them. But I'm not aware
  of such mechanism (I have an extremely vague recollection that
  someone managed to abuse rseq for this, but we shouldn't be relying
  on rseq being available anyway).

