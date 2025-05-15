Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F8DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaY0-0000Uo-Ct; Thu, 15 May 2025 11:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaXp-0000Qd-JR; Thu, 15 May 2025 11:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaXh-0004Nm-1P; Thu, 15 May 2025 11:30:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgCND002495;
 Thu, 15 May 2025 15:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ghsEmbKCF6VUtya4cBx/xa9ecywKcRG3IRn10Mr7md0=; b=oG1Q4Wo4uAqF
 LWNI965hCnGGzEUw/bySc36gijtFktrK6lJdf8Ze9uhvXGhypRXpKYXT57aJDwT4
 w/Tz8ZJzV2Gpl+H0Cye9uStvBFOiChJOfLu3jPxwiZz3pClrSnVvt4J4u6zsYpHV
 LrwZstwuIRex88nTT6KpXZgGDBADwHE16j0WZ0AHKqsQ1s2e0BYyVeIroC0zA767
 pdt8HbIQ2TETYpEePz7NQnH1sLPaw6vw7KkUy6zIBMAyVjwTgHqLnDLvkN0WydTo
 uO+Zck70nPqCBpcvWaoc0Gwdo9aFtX6oH0Icq+WoKS6WiztVIINNObzOm8nCWQJA
 DKIj1nBR7Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6naw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:30:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFUAjm014053;
 Thu, 15 May 2025 15:30:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6navy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:30:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDtFDW021786;
 Thu, 15 May 2025 15:30:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpty05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:30:34 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFUXKY29164094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:30:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E39058059;
 Thu, 15 May 2025 15:30:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E09958055;
 Thu, 15 May 2025 15:30:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:30:33 +0000 (GMT)
Message-ID: <a5abb3d2038a52e7e6a5cf2fdcd0e45b69ddea08.camel@linux.ibm.com>
Subject: Re: [PATCH 01/50] ppc/xive: Fix xive trace event output
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:30:32 -0500
In-Reply-To: <20250512031100.439842-2-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-2-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=6826089b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=4FzCE8LEWk0O3G0rl0sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MH8_EMY_Lm_L7GabkOEBUdx67U6mAgUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfXw5YZMeIGXcQZ
 9BzrUUnuFbKPCbZ/ue4SlY2Nfqnp4W4+floCDGcP1qqd1gzcyPXV1w2q7sfrB/7l6cJe8KkDLJ8
 6zEAl9ZFAOLOokO5fu/AfbBCb2jKoXMatZ1kI9SaAG/BjQepDiOYxWaZXok/zhnQr27LdNVcZI3
 hhL/eFmxBALGI83zWvF9AQnKpCorAi6QplHpvyM6JJQy1VCWFpZSSBvwDAxM5TeeOVVDBFH3kgc
 OB6d6fl1Cjqpzkb+sfsSdJzpI43JQujK+RUZSSrRyFZnqgNSR9+7KON717PkCo9scGv8QKCvRx1
 W7HafzTQwbhtHem+DvgKAWOUph+oWyKx2Az3hwkiRov9CkyqjsyD/xD4+PP6jr4SFvol8zbAcs3
 3vER4QWSD31jfA8QvUqYY46rPX0yNiJkeUcbEkxVUeBLG6yrxs6UC4bPGs8UW0/s8qYakQXM
X-Proofpoint-GUID: 5Gch3hGQtb-vrUIGqqSPk1ohGuBvjJQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxlogscore=930 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Typo, IBP should be IPB.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/trace-events | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 0ba9a02e73..f77f9733c9 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -274,9 +274,9 @@ kvm_xive_cpu_connect(uint32_t id) "connect CPU%d to KVM device"
>  kvm_xive_source_reset(uint32_t srcno) "IRQ 0x%x"
>  
>  # xive.c
> -xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
> -xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
> -xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
> +xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
> +xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
> +xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
>  xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>  xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>  xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"


