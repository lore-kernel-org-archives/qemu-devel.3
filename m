Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgepn-0001bV-25; Mon, 06 Jul 2026 04:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wgepM-0001Xc-GG; Mon, 06 Jul 2026 04:37:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wgepJ-0002Q5-CS; Mon, 06 Jul 2026 04:37:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6667M1Id1497686; Mon, 6 Jul 2026 08:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ejIZgP
 BH5jc4yIQXVtPYBu8jSdyspTvLVBb3CI2Rb6A=; b=p01CWW/iZUZKhQXx0GiEmC
 qwWBSAP+DMA1s+4IGs83bmcxaK2yIpjD8PPucrEM7vvuZs1wbuyKCT7dvRjzAX2H
 alOIO4fjRpx3ibGc+tvqklsevVE7N6Rb4w+Hb3mzm5d8SwJv4QOedu6fAUBf68Wf
 qmKvf7Xc+9XoFd6Inbo8/cwRHTPl7EjHLHY0KdHvo7BOJDG6vVXR4TCVDzMS+fOu
 MLI8jcx8psmclkdMtY35ceyXkSTVJKiG3rs6z5xflPL3105Dduq0eApP06RsrKqN
 PkAnlGrO30ahoURlTeslNMKISnh6/0mK9uZosXj3Ne68hkAw4V2hN0lcp8iLSLUg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh0mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:37:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Yk7p032686;
 Mon, 6 Jul 2026 08:37:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvefm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:37:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668b0kw16384306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:37:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C9A120043;
 Mon,  6 Jul 2026 08:37:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0352004E;
 Mon,  6 Jul 2026 08:36:58 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:36:57 +0000 (GMT)
Message-ID: <01f03069db4b48499c0f138e8afa9b0971e863b4.camel@linux.ibm.com>
Subject: Re: [PATCH v3] powernv: boot OpenBSD on POWER9
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: adityag@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, brad@comstyle.com, "Kirill A.Korinsky"
 <kirill@korins.ky>
Date: Mon, 06 Jul 2026 14:06:57 +0530
In-Reply-To: <871pdkmdd3.wl-kirill@korins.ky>
References: <20260702130152.89334-2-kirill@korins.ky>
 <a52771d5-0179-48de-a0e3-eac95192b789@linux.ibm.com>
 <871pdkmdd3.wl-kirill@korins.ky>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: emCCSy-2dpNeGOrvYsz6QvaXhXHc_lfr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX/yWKKNloAJqf
 AQlC5OyYdcA5uszpk+F5D8/von8/kbCgM22lkcIaTc4kHrZmXdePYvCLonqM5RQQsXoHkx5TdiN
 EFDYuIgqxrFx8Vzn1fVgi5hVBUt7ReA=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b6931 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=TbeAMaP54blmARleNrcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y6HaNC4MIAYMJ78kFSsg6Hny6RGQdMVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX9VmQG12hPVba
 cuCh/XsR2pcVKTE/T+33vsK18+VkZ1szu3Rhw3LQPhGTKavcNQzakggcFDM3xOnGdQKtDCHo9Lj
 IBeONyPd219ldsaZdRq46q4Np7hoCWltG4y0Gufr1GgAOAyT4nDONuEDm4ivGmSUDhbsVJr0gfg
 q8OKTFkpuHtkRbm2pwGBu1WY/KDYK4h8y3GBFtWkc2nEwXypjObWvgVrmmqh/0KRETrXaj3IAU4
 JqORjolpnBp5ff2pn4HscV6mo6g/hcUUC52Zl3SyukwbXxRJRWFsKTDHPqs1kEMUlCmoYas4rmn
 GwhbR9UbbqLgVXROU4QtodTxbiiNPJCrwGwD6d9kWVqz2ER/Dq0RkiW0W1VSYQpnekVrdufLVT4
 pnmappC6g0HZuBto5hTQFd52QAO1RcSju8qQv0mgPRlX4PXcBmRsp6v2QlfcX44P+ajPw7fRh2Y
 gTo9VSw/M81h0wkxpog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060083
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

On Fri, 2026-07-03 at 15:06 +0200, Kirill A.Korinsky wrote:
> I have no idea why OpenBSD does it but I see in powerpc64's pmap.c:
>=20
> #define PATMEMSZ	(64 * 1024)
> #define PATSIZE		(ffs(PATMEMSZ) - 12)
Hi,

This seems like a bug in openbsd to me.
PowerISAv3.1 under PTCR says,
=09

	4:51 PATB  | Partition Table Base
	59:63 PATS | Partition Table Size=3D2^12+PATS , PATS=E2=89=A424

I think the developer was perhaps wanted a LOG2 functions instead of
ffs (which is just LOG2, but 1-indexed). IMO, this should better
handled on OS side.

Thanks.

>=20
> which was introduced by this commit:
> https://github.com/openbsd/src/commit/dfe2a24332fd6769a7f9bb5806753189dae=
4d9c9
>=20
> --


