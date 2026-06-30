Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77109C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUu9-00067g-FV; Tue, 30 Jun 2026 05:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weUu8-00067M-1I; Tue, 30 Jun 2026 05:37:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weUu6-0000CB-I3; Tue, 30 Jun 2026 05:37:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U5mNdh1076043; Tue, 30 Jun 2026 09:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kNSvMX
 kMwqcHG3oWPHQdKBBybsoFSq7+VyXqOOqqjhg=; b=GWeA65YkIlb3QB8hOXIF/V
 Ygb06PAjwa2nYtidg2oenPUKD3R9lbzSWePYeGgEInMdfTbp9Jh2JydVm9Z6FLab
 NSHgdFWl/hp4QmMsUBFStvdp94wG4cdyQ2huDYx/k/lW/B+86aF6y5OPzZFq/PEA
 1wcxn+LOF9NhJK/wqGreE5PRL3C6jvSf/3jp/LXe9+on6TL1KAvr0dn2r+AFI3Ko
 /GZWSZBsV77NRSoAip5SeM+eohoTZFNDqGTDo9HofCiHs0TJctsNziGxbVT9uFPy
 lj8zaZAscQhPZFfDB7zcfxLK3BrUJilAfza0i9upp8TzwTadSfsJjeldiwW8rI6Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9wpgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 09:37:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9Ybp3005987;
 Tue, 30 Jun 2026 09:37:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1kh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 09:37:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65U9bBRo34341204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 09:37:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46DCD20049;
 Tue, 30 Jun 2026 09:37:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D285D2004B;
 Tue, 30 Jun 2026 09:37:09 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 09:37:09 +0000 (GMT)
Message-ID: <dcfa2a3250641cb188a04fa7e46f09abd46c6725.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] ppc/pnv: add test to verify external DTB is honored
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 30 Jun 2026 15:07:08 +0530
In-Reply-To: <akJaUpckzqdnZmHq@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260626112239.177191-1-shivangu@linux.ibm.com>
 <20260626112239.177191-3-shivangu@linux.ibm.com>
 <akJaUpckzqdnZmHq@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfX4pjqoVySXX3Y
 IUiVxjN1UtitUarYZtRuUQnxLipCf4tYUHr8RQvXfE7nEBDcFfvFsmnHHtwa1bVi6kyunc7hZdw
 bwvi1iwDatbnutc73s70vL0QsklxtRdKtCaqNA0ML/f261ITtFA3VmjKirqueqPiYbYDfoa3WfJ
 0gZ1ZkNb9j6O1BEu1GPKI1+hjdeFOxxHiKwv4oX4qjpayvHXKaETkcaWg7GnaG0aCMani1GqdG3
 gYnwj7Tz/POBkPZfJSsCpZEpPmr5P2CEsZDgWxkm3WiG7LL6e/NsvmOlhrDn2Sc1xjbeTTnL4Er
 gVutk/8RDrHfurAXP7aV29kZliK6sZhPxFrVtFxTx6vo3+CM2lEVebAz33HRGXt//3RrDLyvOr4
 UdWsLgIi4OS2OJenFmbCSmenhb20chcNo73/ExRWOLOFyRkGObzocaH0NkRq6VMv1qp/UqxBrIA
 zngP7IMVS8TB/zGswXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXxgBhlX60J/Tu
 9k11x1FiabGiCdidaiZHTBWuD2n0Dr3+8e5XDjoWvYmilnkHbTBlxaF9sAO7Z1FfKNNnVaGuUNu
 mAG0a2EDUwAuunhfRY+z+AdVZ5ek1vQ=
X-Proofpoint-GUID: 6woNYWT5PnSRmaYNPcdY3ZP9NysGxJ9C
X-Proofpoint-ORIG-GUID: k49RIFpIXe9uw05gRrKg7vieQW8zxy3E
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a438e4c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=jrUJX8GpwmtQND6zI7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300083
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2026-06-29 at 17:23 +0530, Aditya Gupta wrote:
> > +=C2=A0=C2=A0=C2=A0 # testdtb for power11, which contains string "hello=
 world" in
> > command line
> > +=C2=A0=C2=A0=C2=A0 ASSET_SAMPLE_DTB =3D Asset(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dt
> > b'),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > 'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')
>=20
> nit: since you are anyways sending a v3, can you rename output.dtb to
> something like qemu-powernv10.dtb, etc so in future you don't modify
> this generic path unknowingly ?

Yeah, Sounds like a good idea.
Ill send the next revision.

~Shivang.

