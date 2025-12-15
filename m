Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00834D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV1la-0000jQ-29; Mon, 15 Dec 2025 01:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vV1lR-0000j5-FI; Mon, 15 Dec 2025 01:08:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vV1lQ-0007ic-06; Mon, 15 Dec 2025 01:08:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BEKF0ol022513;
 Mon, 15 Dec 2025 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=G7XRPLbm5kBlyrnYdVzIe7xO79/6yg
 qEVKPMm8m9RCw=; b=DcA+DUrrfjsqOW+KvuXUIHIMd6uio1LZXoHGfATKjfvBh/
 GsDA2Ch2Ork78Fo/uyoFYIZOoLHBClUh4og+AYDqMAJfdsNHtsb3gE/+tvZ64qVr
 1HQLBn013A3ih10/+bvG/uCfpa022eNPe0NY3tQTIyRAyK6XarxGE37amxW2oBw5
 8YwtAHKc36iNiGbWxIHHvbWhep+7curzuYrGpepc+A3nEXyPkg7X1soJaasfXWGS
 EjCk36gGg1dTSD1pYDj/tXdFfpFdJe8KGHmEwt/v27HSaWM5bdbljHSrOP1mlwXE
 XUj8ozNeAgotie/AkiMWjw0sGOobkJ8W6ckII21Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkqsuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 06:08:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BF68KYK022295;
 Mon, 15 Dec 2025 06:08:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkqsud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 06:08:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF211hm005675;
 Mon, 15 Dec 2025 06:08:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnkea5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 06:08:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BF68jms28967250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 06:08:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62B4E20040;
 Mon, 15 Dec 2025 06:08:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C570320049;
 Mon, 15 Dec 2025 06:08:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.2]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Dec 2025 06:08:41 +0000 (GMT)
Date: Mon, 15 Dec 2025 11:38:39 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Subject: Re: [PATCH 0/6] hw/ppc: Snapshot support for several ppc devices
Message-ID: <2vux3irnfwzssnleomcymy42vgd45bsqtjprhg6ro53koxannx@k3i2yh4dz647>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xr2fTW9iuWeo_b-1WN4E77lsrp1-cw-u
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=693fa5f2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zwWZ8z_C5TZ1uqLLtyIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: QQS4PoX6-VEbsh4fwL1raNoRTA3Xv4BZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX5DUCQ9aGXBl/
 a5mteN4sB1z5OAQH9WI7zXvIH1cHXZons1MTYwo4B66kQvawkbFZcGyY9Vvv7r9p/SWWa68zqXR
 t2O26EsdTAW2bP+MJwNCwRqfCcWOVd8FQqk9fnUblF0eh/3S2LU/QNZEhV7eUCBII6Qwv2SvvK0
 IJMVVq97eRXUNBcf8mvMBRCdKVa2eNs3m+BcKwlhTwXckg49AsmPCON6JTucqdV6lF78sOeZ5Bu
 TK4RzlDEk/KL2pIGSbEGyDTZ0Lh9kB6gs5X3l06jDcLhby7dYSB4+YE5+a5JFP629nG/wxPTR4G
 Cy0mOl2uD1Kkp5GBCAZWB75KYeTPafDzo6QGFhSrDUCT0/lZ6d1k6US4K72240ocqKnjx7TSO2a
 dyCcUbOpCj/O7us0OCBTo1ia/d0byw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Caleb,

On 25/12/11 04:09PM, Caleb Schlossin wrote:
> Add snapshot support for several ppc devices for the powernv machines.
> 
> * Adding LPC, ADU, SPI, I2C, core, and chipTOD
> 
> No specific ordering of the patches as this is ongoing development to
> support the PowerVM team. Additional patches for other (non-ppc) devices
> will be coming in separate patch submissions.

Thanks for the patches, can you tell more background on this ? Because
afaik PowerNV doesn't seem to have vmstate mostly, are these enough to
store/restore full PowerNV context ?

The patches look good overall, though I am yet to review in detail.
Some minor nits, LPC only sets vmstate for Power10's LPC, and many
devices vmstate don't have pre/post load handlers, assuming just the
vmstate info is enough in those cases ?

Thanks,
- Aditya G

> 
> Thanks,
> Caleb
> 
> Michael Kowal (1):
>   hw/ppc: Add VMSTATE information for LPC model
> 
> Caleb Schlossin (2):
>   hw/ppc: Add pnv_spi vmstate support
>   hw/ppc: Add pnv_i2c vmstate support
> 
> Angelo Jaramillo (3):
>   hw/ppc: pnv_adu.c added vmstate support
>   hw/ppc: pnv_core.c add vmstate support
>   hw/ppc: pnv_chiptod.c add vmstate support
>   
> 
>  hw/ppc/pnv_adu.c             | 12 +++++++++++
>  hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_core.c            | 22 ++++++++++++++++++++
>  hw/ppc/pnv_i2c.c             | 11 ++++++++++
>  hw/ppc/pnv_lpc.c             | 39 ++++++++++++++++++++++++++++++++++++
>  hw/ssi/pnv_spi.c             | 27 +++++++++++++++++++++++++
>  include/hw/ppc/pnv_chiptod.h |  2 ++
>  7 files changed, 151 insertions(+)
> 
> -- 
> 2.47.3
> 

