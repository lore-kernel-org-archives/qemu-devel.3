Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB8C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjDK-0002vW-Sz; Tue, 28 Jan 2025 05:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcjDA-0002u3-EE; Tue, 28 Jan 2025 05:52:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcjD8-0005k1-JK; Tue, 28 Jan 2025 05:52:52 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLISWS009891;
 Tue, 28 Jan 2025 10:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a5xbIJ
 oxctM/EpTOE90pzJTkv+04nrN9+8ORprdwcEU=; b=p2NF53WqqBINOZHwznfgpu
 W7hfcQNgx/NqThowYvcQVz9fo8d1ashbQDgvFvUOqE4zdOcVQXzRePklXoOloAtG
 kS5viwCOQuEc4v9g/6hiiV4zNp/suOGuXe3rvYQcpIzceQ8iuUHxIS6k91qm95+c
 o9xvTEIGWzlGZG922tEow/8KmbDKwhTAqo9qVi0QG07vC4gA+cIVdNeQ/xaduMXS
 H++wBTKCB7k5ki8CRF+libGFJB8n4V5/zmwcPofQtqgH7kbMKjNwnY49wDhZXHBX
 FGtxWF70shKI3FGbsxtMOlynOj08ZF8tUkCi47TxW6jd8lajTsadx8wWZhn8uk7g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycujj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 10:52:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SAqkIM026057;
 Tue, 28 Jan 2025 10:52:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycujf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 10:52:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9ZMr0028045;
 Tue, 28 Jan 2025 10:52:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskashy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 10:52:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50SAqhN636176356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 10:52:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 465E92004E;
 Tue, 28 Jan 2025 10:52:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8D9B20043;
 Tue, 28 Jan 2025 10:52:42 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 10:52:42 +0000 (GMT)
Message-ID: <9851753c85bcf31890e41fb5cdb29375a7095f87.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] target/s390x: Fix MVC not always invalidating
 translation blocks
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Berthold Gunreben
 <azouhr@opensuse.org>,
 Sarah Kriesch <ada.lovelace@gmx.de>, qemu-stable@nongnu.org
Date: Tue, 28 Jan 2025 11:52:42 +0100
In-Reply-To: <a26d7e7a-27c2-4d36-82cb-35012f72d446@redhat.com>
References: <20250128001338.11474-1-iii@linux.ibm.com>
 <a26d7e7a-27c2-4d36-82cb-35012f72d446@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zn6HGiwr-HCGEosimUfSC0gNZk5oUPUK
X-Proofpoint-ORIG-GUID: NpNx181pNzh_xWslNrbtb7gwwZBmeKqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2025-01-28 at 10:56 +0100, David Hildenbrand wrote:
> On 28.01.25 01:12, Ilya Leoshkevich wrote:
> > Node.js crashes in qemu-system-s390x with random SIGSEGVs /
> > SIGILLs.
> >=20
> > The v8 JIT used by Node.js can garbage collect and overwrite unused
> > code. Overwriting is performed by
> > WritableJitAllocation::CopyCode(),
> > which ultimately calls memcpy(). For certain sizes, memcpy() uses
> > the
> > MVC instruction.
> >=20
> > QEMU implements MVC and other similar instructions using helpers.
> > While
> > TCG store ops invalidate affected translation blocks automatically,
> > helpers must do this manually by calling probe_access_flags(). The
> > MVC
> > helper does this using the access_prepare() -> access_prepare_nf()
> > ->
> > s390_probe_access() -> probe_access_flags() call chain.
> >=20
> > At the last step of this chain, the store size is replaced with 0.
> > This
> > causes the probe_access_flags() -> notdirty_write() ->
> > tb_invalidate_phys_range_fast() chain to miss some translation
> > blocks.
>=20
> We added the size parameter in:
>=20
> commit 1770b2f2d3d6fe8f1e2d61692692264cac44340d
> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Date:=C2=A0=C2=A0 Thu Feb 23 20:44:24 2023 -0300
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Add 'size' param to probe_access_flag=
s()
> =C2=A0=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0 probe_access_flags() as it is today uses probe_a=
ccess_full(),
> which in
> =C2=A0=C2=A0=C2=A0=C2=A0 turn uses probe_access_internal() with size =3D =
0.
> probe_access_internal()
> =C2=A0=C2=A0=C2=A0=C2=A0 then uses the size to call the tlb_fill() callba=
ck for the given
> CPU.
> =C2=A0=C2=A0=C2=A0=C2=A0 This size param ('fault_size' as probe_access_in=
ternal() calls
> it) is
> =C2=A0=C2=A0=C2=A0=C2=A0 ignored by most existing .tlb_fill callback impl=
ementations,
> e.g.
> =C2=A0=C2=A0=C2=A0=C2=A0 arm_cpu_tlb_fill(), ppc_cpu_tlb_fill(), x86_cpu_=
tlb_fill() and
> =C2=A0=C2=A0=C2=A0=C2=A0 mips_cpu_tlb_fill() to name a few.
>=20
>=20
> And added support for more than one byte for the notdirty case in
>=20
> commit e2faabee78ff127848f59892747d4c07c56de033
> Author: Jessica Clarke <jrtc27@jrtc27.com>
> Date:=C2=A0=C2=A0 Fri Nov 10 21:43:03 2023 -0800
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Forward probe size on to notdirty_wri=
te
> =C2=A0=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Without this, we just dirty a single byte, and s=
o if the caller
> writes
> =C2=A0=C2=A0=C2=A0=C2=A0 more than one byte to the host memory then we wo=
n't have
> invalidated any
> =C2=A0=C2=A0=C2=A0=C2=A0 translation blocks that start after the first by=
te and overlap
> those
> =C2=A0=C2=A0=C2=A0=C2=A0 writes.
>=20
> So I guess it's rather hard to find a "Fixes:" tag, because likely
> it's been
> broken forever?

Yes, I thought about this too and gave up.
However, I now wonder if we still need one for non-philosophical, but
rather practical backporting reasons? Then

Fixes: e2faabee78ff ("accel/tcg: Forward probe size on to
notdirty_write")

(v8.2.0+) should be the right one I think?

> > When this happens, QEMU executes a mix of old and new code. This
> > quickly leads to either a SIGSEGV or a SIGILL in case the old code
> > ends in the middle of a new instruction.
> >=20
> > Fix by passing the true size.
>=20
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>


