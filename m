Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182DC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRSM-0003dM-7B; Thu, 16 Jan 2025 10:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYRSG-0003ck-PC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:06:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYRSF-0001xF-0E
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:06:44 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE84Xm005939;
 Thu, 16 Jan 2025 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pW9x5B
 Dd6vaz8nabMb8fUen0/HUkfXz7tJObKcEOyng=; b=thZjC+M08PwYthPiO1ObT7
 /98nIK7gaLAn5+kn2Mdl9i509rm+vsayTUSF58pxBzU00Xn1lMJoSfZWfKQLCwWJ
 chVQ8l0TssfWMjR7DhtvekU7ayI27wMIwuQR6RnGuevJXJpJkUPcjnT2BS9128db
 Kxi8EukFB9MybfxRzVxNePgyEN7DRdo3wll2vGwQ5gE9e8RHNPhR9BauK9mfOEgl
 ZoN4s2o0Eq6R9hV03iHqFJOfwm1Cw9bVv0tNPsK5KOfyctXajFJ0Kb0DOOK799eA
 9wzbxLBM26WsOrg+qQ51yJK4+HBLSKtzziJCLaLGUJDC5jEs35ua5iUJU6gjcELg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkck3gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 15:06:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDmnLk007386;
 Thu, 16 Jan 2025 15:06:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynecnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 15:06:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GF6b2942795350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 15:06:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C2720043;
 Thu, 16 Jan 2025 15:06:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A51A20040;
 Thu, 16 Jan 2025 15:06:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 15:06:37 +0000 (GMT)
Message-ID: <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Date: Thu, 16 Jan 2025 16:06:37 +0100
In-Reply-To: <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yb4HFs6YjtiYcxjSX-ejqMZb5p97hRQA
X-Proofpoint-GUID: Yb4HFs6YjtiYcxjSX-ejqMZb5p97hRQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=998 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2025-01-16 at 06:54 -0800, Richard Henderson wrote:
> On 1/15/25 15:20, Ilya Leoshkevich wrote:
> > Currently single-insn TBs created from I/O memory are not added to
> > region_trees. Therefore, when they generate exceptions, they are
> > not
> > handled by cpu_restore_state_from_tb(). For x86 this is not a
> > problem,
> > because x86_restore_state_to_opc() only restores pc and cc, which
> > are
> > already correct. However, on several other architectures,
> > restore_state_to_opc() restores more registers, and guests can
> > notice
> > incorrect values.
> >=20
> > Fix by always calling tcg_tb_insert(). This may increase the size
> > of
> > region_trees, but tcg_region_reset_all() clears it once
> > code_gen_buffer
> > fills up, so it will not grow uncontrollably.
> >=20
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 accel/tcg/translate-all.c | 16 ++++++++--------
> > =C2=A0 1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index 453eb20ec95..6333302813e 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_reset_jump(tb=
, 1);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Insert TB into the corresponding region tre=
e before
> > publishing it
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * through QHT. Otherwise rewinding happened i=
n the TB might
> > fail to
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * lookup itself using host PC.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 tcg_tb_insert(tb);
>=20
> I think what we need is to mark the tb CF_INVALID before inserting
> it. That way we'll=20
> never match in tb_lookup (comparing guest state, including cflags),
> but *will* find it in=20
> tcg_tb_lookup (comparing host_pc).
>=20
>=20
> r~

How can tb_lookup() find it? With this change, it is inserted into
region_trees, but not into tb_ctx.htable - this is done by
tb_link_page(), which is not called. And because it's not in
tb_ctx.htable, it can't end up in tb_jmp_cache either.

