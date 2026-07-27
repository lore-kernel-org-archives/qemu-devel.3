Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B99C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGea-0008R4-GO; Mon, 27 Jul 2026 04:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1woGeZ-0008Qq-82; Mon, 27 Jul 2026 04:25:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1woGeX-00041p-Nh; Mon, 27 Jul 2026 04:25:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7m8BN1633043; Mon, 27 Jul 2026 08:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ULXUt2
 yI7wva5oY28LiMI9igmMCQh0iwFI9qtds8Ezc=; b=KnkrPeVXqBxMOZ/VKZQCLJ
 pHoDHnbIVTNBRJHAwyy8VLQEsJOUOlcXICMSulj7LkMSRkk16zrTknnBEhdOdW/R
 84OOC+D8QqStPs6+E0pS8H87FzfBTaDWO9zCNIixfWWt5gBFjQ8apCWInuu8i7EO
 WpCRDkzsv3gGTZ3dZKo0QqYX59W+sIDgn6oDi0WCNFW0JHunjbkgHsklwi6AkdSx
 SuyV81Ojg6MJi8OSW/49cvg4bGWbYsmp5wPE64yByb34TtnuvA5Qjsrm4N7FB0Xj
 Oth9Hd/WPDkyLJiY0tNS22QPDXhGIgy6EtoPd01WovBaHzXXDqYXTA8KcxVj9fcQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xf03u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 08:25:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8BIWo028251;
 Mon, 27 Jul 2026 08:25:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4bd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 08:25:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66R8PS6240042886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 08:25:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C870A20095;
 Mon, 27 Jul 2026 08:25:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54107200A2;
 Mon, 27 Jul 2026 08:25:27 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 08:25:27 +0000 (GMT)
Message-ID: <07ef3c9c6910c8076a563d90b537d0dcf83065c7.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tests/functional/ppc: skip remote interrupts test if
 -net user not built
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, thuth@redhat.com,
 adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com
Date: Mon, 27 Jul 2026 13:55:24 +0530
In-Reply-To: <20260727110516.c62eed78-ec-amachhiw@linux.ibm.com>
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <20260725174600.17683-1-shivangu@linux.ibm.com>
 <20260727110516.c62eed78-ec-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: o4Z64zYdm_9kDHFn_gspVtcZJO-iud8_
X-Proofpoint-ORIG-GUID: 2W3QdtvtFKKECBl__96HxF8PhZ6X-KHF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX9Al2Iq3dkWT5
 709ZMwjeX5sdyAI651Ifo2gULJn5p+LMMdlhXtJlbUK4Uvon1SL7LvYLiHxmfKGSBJ61x5Cdmow
 HM/keZgudZIW4fe9CUB+u1wBp1QrWCg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6715fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EqrdExaTOsCVLBqOS-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX+JtQQTfh4XOR
 eRtpBnDsuxqAl8kVTB2PwsK0ctbdh2mhXpfjE30ndx3P9OanDTENkNE5IkVV5JNU+j+UHJ7iCpM
 HLuJZCZzKwDokbdDL3ogzX1mRR41hINTIebzPEX1XhQFnK5fBKzeW6YOGwh6ZwlSzkGCZO4Chyl
 uysi0EFuJdTa7amhX1QNn8aPOq5j8nth+ttYaMGYo1J5BaCS9Fqz2hY3dBllHDxNi98wly8Frjk
 cmZAkYGuM4OlC59IG2CwrpJtZeK7ChG6I29ThzOo9IC2a+pq3IiEad9Rha/mDen/c4y23l0jxV5
 msmwYJUqcxUHJumdz+6uOFL9XuyZY4lyfYJ66g+qYF5xLWFOCRodisai3QjHH/JDBrsWYLGWXV2
 AwqKJvHYNamH2A7tLCJdbnCQL+Mje2GVPCxGxkO+XZ8As9ufXUF5pIRjMAwKCeV8SSyk2ZL2GgA
 Wz4eSLRkrG50iAh8v7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270082
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-07-27 at 11:18 +0530, Amit Machhiwal wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_acc=
elerator("tcg")
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.set_machine=
('powernv')
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_netdev('user')
>=20
> One minor nit: require_netdev('user') is placed after set_machine().
> Though it's not necessary, I would prefer to group all require_*
> guards
> together at the top before any setup, so it's immediately clear what
> preconditions the test has. Either way:
>=20
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>=20
> ~Amit

Sure Amit, I'll send v3 with the suggested change, and Keep your review
tag.

Thanks
~Shivang.

