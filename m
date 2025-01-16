Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8916C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYM2P-0006E9-6h; Thu, 16 Jan 2025 04:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYM2M-0006Dc-RS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:19:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYM2K-0006Ma-Oc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:19:38 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FNwFCL028423;
 Thu, 16 Jan 2025 09:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eNFNgO
 9/nHaba1RdKFDNMKi56d4BQ94JMBIC4qd0VaQ=; b=dEAmodwvzU3zPAVu6E/C2p
 0MKpg1IhvmWtwaLwXyOUmew8KqrV8sTeztKedtU999BFu4Edr+kBGIOicy8LGWhY
 i+hwHscPy4U7wLKu9AOfSoQlQa9PNOiU5+Efvj+6JHAOltPLB/a/VIu6Atd+kmcp
 HHXat6ipEnNedvHBMrieQYOhgOewTr5JuFtcQ9O3C1Rm2uzLcLg2Qazz3WE4DZ+t
 3RIfj6yAFSODSz/NTrwr5tC+HTocPVxO7jxzb1nqpizaUHUhNho1n7iDW+GjJjZV
 wd7pPj2rUZVVJ4ONpyXTTcQeAi95e/P4aoFrkQc4s4BIMfvBG+MIJQ7lCX+fMWLw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446q5ht2t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 09:19:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50G5qbRP007364;
 Thu, 16 Jan 2025 09:19:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynd0uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 09:19:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50G9JVE651642694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 09:19:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EA262015E;
 Thu, 16 Jan 2025 09:19:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D95C42015D;
 Thu, 16 Jan 2025 09:19:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 09:19:30 +0000 (GMT)
Message-ID: <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Date: Thu, 16 Jan 2025 10:19:30 +0100
In-Reply-To: <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hk2hPUl25K_fld1RPVs2KJqTjzHfR5G0
X-Proofpoint-GUID: hk2hPUl25K_fld1RPVs2KJqTjzHfR5G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=866 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160065
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

On Wed, 2025-01-15 at 16:08 -0800, Richard Henderson wrote:
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
>=20
> This needs something else.=C2=A0 The reason why they're not insertted is
> that they're not valid=20
> for a second execution.=C2=A0 We need to not find them in the search tree=
.

I have the impression that code_gen_buffer is=C2=A0append-only, so after we
create a new TB for the second execution, the first TB should not
be deleted - is this correct? At least I haven't found=C2=A0code_gen_ptr
decrements, besides the rollback at the end of tb_gen_code(). Then,
since region_trees are indexed by code_gen_buffer pointers, and not
guest pointers, this should not introduce any stale entries.

While we might not need to find the ones created for the first
execution, we still need to find the ones for executions that fail -
and there is no way to tell in advance, which ones these are going to
be, so the idea here is to register all of them.

Am I missing something?

> r~


