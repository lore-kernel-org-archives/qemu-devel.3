Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB5C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNvZ-000365-As; Wed, 08 Jul 2026 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1whNvV-00034h-Sc; Wed, 08 Jul 2026 04:46:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1whNvT-0001JC-Ed; Wed, 08 Jul 2026 04:46:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6688IY4H2880550; Wed, 8 Jul 2026 08:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2ke4Q3
 WbMHklc7JDfG+8oAzI3gutqIKEjhrgbnIX19k=; b=QpigcV88Bt8C0Qko566vX2
 hhcSC1nIpW4yf08lWh38IN1nzrukC4vlBA7A6uYRAVVCjiwlvpUAkp3OBiUB3JUC
 /aehFMYSaIwzwUrGYU4amuEgL3I9TVPj0EojTr24G+3VJoL70Sq+6afbMTcgHcHT
 qkASJLFmvMHMEHzGKElKXHXE+RVEMRHGHP2cGbSmCm7OaLfaKZfbm4PmlXBHjAEK
 1YIq6Z+QtVrUJoYVpYe1Mridu7RtmuMpbET7In5mMLWo66D39UzehUEtmGKl8EPI
 W2Brq0ZoehD8H7YrnG44dXz0zhhAK+X6anMwhG83rIENrNE9LH7UCSu21Kpe0EAw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknk32s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:46:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6688YZJd021118;
 Wed, 8 Jul 2026 08:46:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq736m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:46:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6688kWjE24117630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 08:46:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E811A20043;
 Wed,  8 Jul 2026 08:46:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71D5720040;
 Wed,  8 Jul 2026 08:46:30 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 08:46:30 +0000 (GMT)
Message-ID: <43f35076d8e87139aba333819f99b25954084169.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store
 String instructions to decodetree.
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, Nikhil Kumar Singh
 <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: milesg@linux.ibm.com, harshpb@linux.ibm.com
Date: Wed, 08 Jul 2026 14:16:29 +0530
In-Reply-To: <642080ce-c950-4746-895f-216115c82ceb@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
 <85806173-0fb8-46d2-a69b-6743de12b2c5@linux.ibm.com>
 <593b59c90b8f0351ff992cc087dcf44ebd06d114.camel@linux.ibm.com>
 <642080ce-c950-4746-895f-216115c82ceb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e0e6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=m30KQOjwblEDFkyYEPYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Faq75BxTkoQNrfRAg1CsC-wXgz3FDBFz
X-Proofpoint-ORIG-GUID: Faq75BxTkoQNrfRAg1CsC-wXgz3FDBFz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX1FVdZSqJyI1q
 LBiXfeZCT6Drsn5GGnbk+hIKbiQ4M5K1iYyPzITsI1bAYTSUv/+bjKIUIpQ5z6iXxp+fSaGuOCK
 aER5WLbKWXGZoeR1BC+ScoN7dxufamI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX3E3pBPcvc3oQ
 XT2abLAPZk762sZXV+QrLDCroqKO0IN6tVSGIbYE10v6ZHdoLFXe3uVCn8hS7p5apWtPvbU329B
 rEIJxJuFAfVr0SOwpt1tkrT/pfWhHoYoE/J1ksydMtr5n1YvzqRpox4mFMGK79cZTEnbY3jWbiR
 tWL9jR+DruTiBpsBt0I7kRvM9C57D1RdF5I4M8L8ey/d6jPht+fBaha/7QgpZaCj0rpwCu1HeyO
 Y4syONEFfDijxVZaEyOddi6kLrDbDD2h2MVrht4b0oN51kMEwNyMrLE70QhN70+HJwXPWVi/AG9
 /HCacZboqQ/DZY12xop6qgr6TgH9QGRgS39Z/orL7R2B0PDoNa/5k0/I6B2KSGPZYZdwRutEC2x
 iWepbzL+mo+20g/PW0CH3qR114wb/h0rYzvbDWSNV8/TKw+Q3Izpkxm//ombFjeRzNBdZcGwCb8
 axoUW9EXVZ0/zPURqqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080079
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

On Wed, 2026-07-08 at 13:11 +0530, Chinmay Rath wrote:
> > > > +}
> > > > +
> > > You are using gen_addr_register and gen_addr_reg_index,
> > > do_ea_calc
> > > instead.
> > >=20
> > Hi,
> > =C2=A0=C2=A0 Seems like these functions are refactor-able. I can send i=
n
> > another
> > patch to clean it across all usages.
> I agree with Nikhil. This should be done as part of the original=20
> movement patch.
> Thanks for catching this Nikhil.
>=20

Sure. ill send a revision.

~Shivang.

