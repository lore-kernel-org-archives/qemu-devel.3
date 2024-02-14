Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BBBC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raGBv-0005xk-Vf; Wed, 14 Feb 2024 09:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raGBt-0005vb-VA
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:24:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raGBr-0003sR-It
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:24:49 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EEFwNj020759; Wed, 14 Feb 2024 14:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LasRQeCmntDXXt4fmJUHeblmFqBdFyyiPJcbvCqt2yc=;
 b=d0USP+SU0JwgOPof6bHRyJizGcaL3S6DvjuJzMJSboh4SyhCGrYEHZe4NUW1QkfyXAaY
 mvpUEswhrEsHU7TuOrmqqrrgJ+Y6Oeh4SHARkYWk9owTBy4fzFaKvWpd7neSUQAs7F2f
 bHGfhlsutRCZBtux0zhoNi6/pEGEoVE84CSeclqybqCBg2jUoS+j65+W5RfyVs+T9rSg
 /L5wlrXEMNF+7M8I/6HjFkIy3vDoLGxbgTNyE4sHFLybCN5g4Al61GuKlBCrcfY4mobn
 BPZuLRX90JnJP3hrsbod6rpEf2nK99iW5Hs2Bdc2YtjTus6FIF8e3mIx/FSf/fk17TBW Qg== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8wk4u67a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Feb 2024 14:24:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41ECqMGd032578; Wed, 14 Feb 2024 14:24:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftpkmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Feb 2024 14:24:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41EEOcoZ18875092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 14:24:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98B912004B;
 Wed, 14 Feb 2024 14:24:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E7A220040;
 Wed, 14 Feb 2024 14:24:38 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Feb 2024 14:24:38 +0000 (GMT)
Message-ID: <85455ef16f33a521e7436ee33ba37371c917cdd3.camel@linux.ibm.com>
Subject: Re: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 14 Feb 2024 15:24:38 +0100
In-Reply-To: <c959eb04-a929-4fa6-bdf8-f97cebc4d3f3@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-23-richard.henderson@linaro.org>
 <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
 <c959eb04-a929-4fa6-bdf8-f97cebc4d3f3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h5MokO4x7gVMgJbsXZDu7JWsRHvcwGZe
X-Proofpoint-GUID: h5MokO4x7gVMgJbsXZDu7JWsRHvcwGZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=809 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 2024-02-13 at 09:54 -1000, Richard Henderson wrote:
> On 1/29/24 05:26, Ilya Leoshkevich wrote:
> > On Tue, Jan 02, 2024 at 12:57:57PM +1100, Richard Henderson wrote:
> > > Work much harder to get alignment and mapping beyond the end
> > > of the file correct.=C2=A0 Both of which are excercised by our
> > > test-mmap for alpha (8k pages) on any 4k page host.
> > >=20
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > ---
> > > =C2=A0 linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++-=
-
> > > -------
> > > =C2=A0 1 file changed, 125 insertions(+), 31 deletions(-)
> >=20
> > [...]
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fileend_adj) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
oid *t =3D mmap(p, len - fileend_adj, host_prot,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (flags & ~MAP_FIXED_NOREPLACE) |
> > > MAP_FIXED,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fd, offset);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ssert(t !=3D MAP_FAILED);
> >=20
> > Is it possible to recover here? Of course, we are remapping the
> > memory
> > we've mapped a few lines earlier, but asserting the syscall result
> > looks a bit odd.
> >=20
>=20
> Can you think of a failure mode?=C2=A0 I couldn't.
> That's why I added the assert.
>=20
> I suppose there's the always present threat of running out of vmas...

Right, and this should be easy to trigger by using ulimit -v.

>=20
>=20
> r~
>=20


