Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDEC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOMo-0007wm-G5; Thu, 16 Jan 2025 06:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYOMm-0007wM-I5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:48:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYOMk-0000iy-Lx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:48:52 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G3qPR5005689;
 Thu, 16 Jan 2025 11:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6hFx6o
 YfSqmBWKmtmEZCPTfCe5xmrKxSoOyZbWG+KP4=; b=NBqxemcSPfEUrCFMStluwx
 TtftgW4Z5ZT9HFtcIuNlOImVAArpBi/IukZrrld2y6EAFTOkHunTL/xiwN3y934B
 CZE1W7kXgpDVL31p9BMBu9MVu93g/yYbWKFt9CRNR6g1HHPIbAdnsXTJ4KsUFO0M
 8kwaA3DQ1C41uBBKcNk+qAGGy7slupmuSSa4xSrZlVfh7z+z0W2tK3A5Ic3DLjrx
 UfxK1NP0ZyBv6T3X6Z66DEHsu0l9MPKLv7/NeVq08kx+yvs4I5qXQxavg+gm54+h
 4MpY9T0bIIeb8mFxG6v+AkWSGftdEfHlhm/cDjGE+HNdopNG3Zs94iwEa/rKsczA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcj2d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 11:48:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAun3l016571;
 Thu, 16 Jan 2025 11:48:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1w975-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 11:48:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GBmjcw20840718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 11:48:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CF1120049;
 Thu, 16 Jan 2025 11:48:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C26C120040;
 Thu, 16 Jan 2025 11:48:44 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 11:48:44 +0000 (GMT)
Message-ID: <65e146746377bc307affc627f47c4700aaaac4ba.camel@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>
Date: Thu, 16 Jan 2025 12:48:44 +0100
In-Reply-To: <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 <87frljhvzk.fsf@draig.linaro.org>
 <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rC2kuS86THexQP5fzObpVtJoXzyYSxUP
X-Proofpoint-GUID: rC2kuS86THexQP5fzObpVtJoXzyYSxUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=776 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2025-01-16 at 11:06 +0000, Peter Maydell wrote:
> On Thu, 16 Jan 2025 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
> >=20
> > Ilya Leoshkevich <iii@linux.ibm.com> writes:
> >=20
> > > On Wed, 2025-01-15 at 16:08 -0800, Richard Henderson wrote:
> > > > On 1/15/25 15:20, Ilya Leoshkevich wrote:
> > > > > Currently single-insn TBs created from I/O memory are not
> > > > > added to
> > > > > region_trees. Therefore, when they generate exceptions, they
> > > > > are
> > > > > not
> > > > > handled by cpu_restore_state_from_tb(). For x86 this is not a
> > > > > problem,
> > > > > because x86_restore_state_to_opc() only restores pc and cc,
> > > > > which
> > > > > are
> > > > > already correct. However, on several other architectures,
> > > > > restore_state_to_opc() restores more registers, and guests
> > > > > can
> > > > > notice
> > > > > incorrect values.
> > > > >=20
> > > > > Fix by always calling tcg_tb_insert(). This may increase the
> > > > > size
> > > > > of
> > > > > region_trees, but tcg_region_reset_all() clears it once
> > > > > code_gen_buffer
> > > > > fills up, so it will not grow uncontrollably.
> > > > >=20
> > > > > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > >=20
> > > > This needs something else.=C2=A0 The reason why they're not
> > > > insertted is
> > > > that they're not valid
> > > > for a second execution.=C2=A0 We need to not find them in the searc=
h
> > > > tree.
> > >=20
> > > I have the impression that code_gen_buffer is append-only, so
> > > after we
> > > create a new TB for the second execution, the first TB should not
> > > be deleted - is this correct? At least I haven't found
> > > code_gen_ptr
> > > decrements, besides the rollback at the end of tb_gen_code().
> > > Then,
> > > since region_trees are indexed by code_gen_buffer pointers, and
> > > not
> > > guest pointers, this should not introduce any stale entries.
> >=20
> > We used to generate a temporary TB, execute it and then wind
> > codeptr
> > back. We simplified the code to generate the TB but then not add it
> > to
> > QHT - I think the original reasoning was saving on scarce CF_ flags
> > and
> > not over complicating the tb_gen_code function. See around
> > 873d64ac30
> > (accel/tcg: re-factor non-RAM execution code).
> >=20
> > This does have the effect of potentially regenerating the same TB
> > over and over again but usually there only a few insns executed out
> > of
> > IO space.
>=20
> You can't avoid regenerating the TB unless you somehow put the
> entire bytes of the instruction into the hash you look up,
> because you must re-read the MMIO region, and when you do the
> second read you might read a different value than the first
> time you read and created the TB.
>=20
> The original reported problem here seems to me like it's a
> problem with whatever target's frontend code this is.
> This is a single instruction TB, so either:
> =C2=A0* the generated code for it completes the insn without
> =C2=A0=C2=A0 raising an exception (no problem)
> =C2=A0* the generated code for it should raise an exception
> =C2=A0=C2=A0 without having modified the CPU state (so there would
> =C2=A0=C2=A0 be nothing to do for restore_state_to_opc)
>=20
> It sounds like the target is generating code which does
> something like:
> =C2=A0* do part of the instruction, including updating some of
> =C2=A0=C2=A0 the CPU state
> =C2=A0* then decide it needs to raise an exception, and rely on
> =C2=A0=C2=A0 the restore_state_to_opc handling to undo the state updates
> =C2=A0=C2=A0 it did previously
>=20
> The assumption of the "throwaway single insn TB" is that
> you don't do that (i.e. that restore_state_to_opc is only
> there for the benefit of multi-insn TBs).
>=20
> thanks
> -- PMM

The problem is not a partial state update in an instruction, but rather
that on some targets restore_state_to_opc is more than just a
"restore" - it is also "prepare for handling an exception", i.e.:

- arm: exception.syndrome
- hppa: unwind_breg, psw_n
- mips: btarget
- openrisc: ppc
- riscv: excp_uw2
- s390x: int_pgm_ilen

Some of these may be wrong due to unfamiliarity with the respective
architectures, sorry - but this illustrates the idea.

