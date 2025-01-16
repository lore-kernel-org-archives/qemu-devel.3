Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DBFC02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSQW-0004o3-Ap; Thu, 16 Jan 2025 11:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYSQK-0004aI-04
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:08:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYSQF-0003Ld-IA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:08:47 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE6JE5024324;
 Thu, 16 Jan 2025 16:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B78XKd
 1YydWwtzqAuJH14QkikYV+twQKDAQd5xpF1e0=; b=QoUYeGi/5OqCIcw4FaIRNV
 vL9Z4iKNvTDV0t/qeWOwnXpZQPdhY527A96ipvpP2bV3KdQkRBkjRwsEqGY+q6dN
 049DadBGGwTlUw2xEncDSkOgoSeAT6C3bKPTFIh1TsT2NyPOfU7aPlx5wpwGmjTJ
 OuawIZ5M3GMHNyp6pky0niT9CjVG1n/ZaquY1m0gJI+AIaD1EYhZVKb82SF/2xig
 3AxkOz7r8GKb9zeoAG4AE7CAavvFXIngsBzVGYtdYWVI6yBkWnPyaZwN4CCZEkIn
 YXJHlZO+kMpblOCUZ73+LDhogsTTYAlMHeB/R2CTZXSUDOKVoiuo0wldBPwnMTzw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k58mcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 16:08:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GFIT2N016491;
 Thu, 16 Jan 2025 16:08:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1x77f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 16:08:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GG8dSN34472244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 16:08:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96C4A2004D;
 Thu, 16 Jan 2025 16:08:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D01E20049;
 Thu, 16 Jan 2025 16:08:39 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 16:08:39 +0000 (GMT)
Message-ID: <42e8b64f104ab347e562e962a363f8c379b2dffe.camel@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>
Date: Thu, 16 Jan 2025 17:08:38 +0100
In-Reply-To: <CAFEAcA9zpD6oO6fU-yq+MsSj-WGh5p7Zvaz=VtdvCykrzJW+ww@mail.gmail.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
 <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
 <e344e8da-8460-42da-850d-79623daffa06@linaro.org>
 <87sepihinf.fsf@draig.linaro.org>
 <CAFEAcA9zpD6oO6fU-yq+MsSj-WGh5p7Zvaz=VtdvCykrzJW+ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fFLv7jWU1JNN6-pVmbgy8a321SALGhpO
X-Proofpoint-ORIG-GUID: fFLv7jWU1JNN6-pVmbgy8a321SALGhpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=978 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Thu, 2025-01-16 at 15:41 +0000, Peter Maydell wrote:
> On Thu, 16 Jan 2025 at 15:40, Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
> >=20
> > Richard Henderson <richard.henderson@linaro.org> writes:
> >=20
> > > On 1/16/25 07:06, Ilya Leoshkevich wrote:
> > > > On Thu, 2025-01-16 at 06:54 -0800, Richard Henderson wrote:
> > > > > On 1/15/25 15:20, Ilya Leoshkevich wrote:
> > > > > > Currently single-insn TBs created from I/O memory are not
> > > > > > added to
> > > > > > region_trees. Therefore, when they generate exceptions,
> > > > > > they are
> > > > > > not
> > > > > > handled by cpu_restore_state_from_tb(). For x86 this is not
> > > > > > a
> > > > > > problem,
> > > > > > because x86_restore_state_to_opc() only restores pc and cc,
> > > > > > which
> > > > > > are
> > > > > > already correct. However, on several other architectures,
> > > > > > restore_state_to_opc() restores more registers, and guests
> > > > > > can
> > > > > > notice
> > > > > > incorrect values.
> > > > > >=20
> > > > > > Fix by always calling tcg_tb_insert(). This may increase
> > > > > > the size
> > > > > > of
> > > > > > region_trees, but tcg_region_reset_all() clears it once
> > > > > > code_gen_buffer
> > > > > > fills up, so it will not grow uncontrollably.
> > > > > >=20
> > > > > > Co-developed-by: Nina Schoetterl-Glausch
> > > > > > <nsg@linux.ibm.com>
> > > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 accel/tcg/translate-all.c | 16 ++++++++--------
> > > > > > =C2=A0=C2=A0 1 file changed, 8 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/accel/tcg/translate-all.c
> > > > > > b/accel/tcg/translate-all.c
> > > > > > index 453eb20ec95..6333302813e 100644
> > > > > > --- a/accel/tcg/translate-all.c
> > > > > > +++ b/accel/tcg/translate-all.c
> > > > > > @@ -531,23 +531,23 @@ TranslationBlock
> > > > > > *tb_gen_code(CPUState *cpu,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb=
_reset_jump(tb, 1);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 /*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Insert TB into the corresponding re=
gion tree before
> > > > > > publishing it
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * through QHT. Otherwise rewinding ha=
ppened in the TB
> > > > > > might
> > > > > > fail to
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * lookup itself using host PC.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0 tcg_tb_insert(tb);
> > > > >=20
> > > > > I think what we need is to mark the tb CF_INVALID before
> > > > > inserting
> > > > > it. That way we'll
> > > > > never match in tb_lookup (comparing guest state, including
> > > > > cflags),
> > > > > but *will* find it in
> > > > > tcg_tb_lookup (comparing host_pc).
> > > > >=20
> > > > >=20
> > > > > r~
> > > > How can tb_lookup() find it? With this change, it is inserted
> > > > into
> > > > region_trees, but not into tb_ctx.htable - this is done by
> > > > tb_link_page(), which is not called. And because it's not in
> > > > tb_ctx.htable, it can't end up in tb_jmp_cache either.
> > >=20
> > > You're absolutely right.
> > >=20
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >=20
> > It would still be nice to update the docstrings on the two lookup
> > functions to make it clear what they are for though.
>=20
> Given this thread, perhaps also consider briefly mentioning some
> of the details in the commit message and/or the comment?
>=20
> -- PMM

Ok. I will send a v2 with docstring additions in a separate patch.

