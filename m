Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AECCFA45F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hKu-0000H1-7I; Wed, 23 Oct 2024 15:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3hKs-0000G8-2i
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:48:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3hKp-0002VV-S4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:48:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE1IDE014753;
 Wed, 23 Oct 2024 19:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4L513a
 BJ3wJ4Hjjo3qAoV3wYzkDJ5ny9xKM92Xqz0N8=; b=qcUO+3yuSmg9n/au+5myGo
 6L9lfh8OJlpu3EeO4Ie0hbcAb7rQigtbg09qzslcovHgvqF/WYIBqHq8tcRLMMY8
 ypLt3hTx4Zef1IcppWx7y6m3ZJXRObwg1TGkTGljXG/rkpe55DzD9Ufviy7TMzxe
 d1qUUhzZr13LHcmOd9gd5RQmXGNdQ7+AHse9bkNUyF619lGzhml1+GCivewt//4U
 f3kkpk0NgCrF3X0ETpA82HCCmnSg0CBO7BejBnOne1w9HEZ7hdDMbfF8vygru9HR
 O0sOdnnrNtdx3n91Uu3x2E6Qh/j4Mi6UTIj0x/J/ZjSMeyZ0Ackok0mCOTdzcRDg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadvwa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 19:47:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NIbshW012599;
 Wed, 23 Oct 2024 19:47:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfcnqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 19:47:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NJlpXM48300468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 19:47:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 979982004D;
 Wed, 23 Oct 2024 19:47:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0348820040;
 Wed, 23 Oct 2024 19:47:51 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 19:47:50 +0000 (GMT)
Message-ID: <063c0c70df2d1a4b2c209bdf9fa8c451dfa7693a.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Fix GDB complaining about system-supplied
 DSO string table index
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 21:47:50 +0200
In-Reply-To: <d847f246-1772-4c9a-97f7-05118a311286@linaro.org>
References: <20241023144744.50440-1-iii@linux.ibm.com>
 <d847f246-1772-4c9a-97f7-05118a311286@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E41jNCycku4_S5T881wgWGdVi5eDXRQ8
X-Proofpoint-GUID: E41jNCycku4_S5T881wgWGdVi5eDXRQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2024-10-23 at 12:03 -0700, Richard Henderson wrote:
> On 10/23/24 07:46, Ilya Leoshkevich wrote:
> >=20
[...]

>=20
> > - Fix up VDSO's PHDR size in gen-vdso. This is the simplest
> > solution,
> > =C2=A0=C2=A0 so do it. The only tricky part is byte-swaps: they need to=
 be
> > either
> > =C2=A0=C2=A0 done on local copies or in-place, and then reverted in the=
 end.
> > To
> > =C2=A0=C2=A0 preserve the existing code structure, do the former for Sy=
m and
> > Dyn,
> > =C2=A0=C2=A0 and the latter for Ehdr, Phdr, and Shdr.
>=20
> Or adjust the linker script, to mark those sections loaded.
> This may or may not be easier, considering the rest of the changes.

I forgot to mention that I investigated this too. The problem, as I see
it, is that there appears to be no way to place section headers inside
a section, and, therefore, no way to refer to them in a linker
script. I guess someone could add the ability to do this by defining
SHDRS keyword in addition to the existing FILEHDR and PHDRS. Also, ld
hardcodes section headers to be non-loadable:

static bool
_bfd_elf_assign_file_positions_for_non_load (bfd *abfd)
{
[...]
  /* Place the section headers.  */
  i_ehdrp =3D elf_elfheader (abfd);
  off =3D BFD_ALIGN (off, 1u << bed->s->log_file_align);
  i_ehdrp->e_shoff =3D off;
  off +=3D i_ehdrp->e_shnum * i_ehdrp->e_shentsize;
  elf_next_file_pos (abfd) =3D off;

So I figured it would be better to stay as close as possible to what
the kernel is doing without changing the existing loader design too
much.

> > @@ -154,6 +161,16 @@ static void elfN(process)(FILE *outf, void
> > *buf, bool need_bswap)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fprintf(stderr, "LOAD segment not loaded at address
> > 0\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 errors++;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Extend the program =
header to cover the entire VDSO, so
> > that
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * load_elf_vdso() loa=
ds everything, including section
> > headers.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len > phdr[i].p_filesz)=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phd=
r[i].p_filesz =3D len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len > phdr[i].p_memsz) =
{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phd=
r[i].p_memsz =3D len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> There should be no .bss, so these two numbers had better be
> identical.=C2=A0 Certainly this=20
> adjustment *requires* that there be no .bss.=C2=A0 I think we should erro=
r
> out if the two=20
> numbers differ.

Sounds reasonable, I'll send a v2 with the check.

[...]

