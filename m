Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFagu-0002UW-86; Thu, 15 May 2025 11:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFagr-0002SO-0p; Thu, 15 May 2025 11:40:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFagl-0005YU-Iz; Thu, 15 May 2025 11:40:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg89e004991;
 Thu, 15 May 2025 15:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=LcoNaYTpuMV9H15R7ctdVqcVYl1x0rMgO/4U2WWgfZ8=; b=drelQbX6ubfL
 YnAnm9J1QuqpUojOzvfLnxkU3W3tM/J7ZyY6IEyIXr2k6TaA5ivnK9lLspvzngdq
 zSj8nM7pPqg7C99CFOhAq1CoPqV4/OEg5qq4j65QTRHjdTq2aYZBmUR2S3yY7V8w
 XZndtrTwJT1KXXXZGpKQRPPYd6G7YBRs5iwFplk0AfrPq6fqiMLQDml6aLUgq1WG
 Fh+lpvTU+/naFXIorwF2B3lL2ipLSaS1JDt6zgBqHx20VWNwNlktIpn6DSCHRNvF
 PY2uUJvyfCJAf5X49ePaKRTCqAB+sfbtyQt4SJ6k6xVvoa15k7tJ/oIl9yhNaGJ9
 ZTKE41wNdw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2uxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:39:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFbOun004980;
 Thu, 15 May 2025 15:39:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2uxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:39:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEGBP9021861;
 Thu, 15 May 2025 15:39:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu0p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:39:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFdtjf32506468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:39:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFAFF58066;
 Thu, 15 May 2025 15:39:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 784FF5805D;
 Thu, 15 May 2025 15:39:55 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:39:55 +0000 (GMT)
Message-ID: <f5eef7962718078d28789bda421eddbb625640cc.camel@linux.ibm.com>
Subject: Re: [PATCH 06/50] ppc/xive: Fix PHYS NSR ring matching
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:39:55 -0500
In-Reply-To: <20250512031100.439842-7-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-7-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SxIbw6yIYzGQ0dt81Tht6vyUof45k6r0
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260acf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=cvhWS9GGLzrGVX_1QB8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OG1CJLfI_91pl_rLZnoDuK7T_X-VDtWf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX+u6A7wWiQQ47
 VgTO6z1L2aT0POpjgMFlRdKwUJGC4t/KOceepI/LR/VJkOCrXXvrM3PYU9NfGJnmx2nFHuEbOx5
 TaJTOyiZ6UJaP9ZeV3AuoEdctff8A3qK/tXbfzrN2e2gbNqNqr1MQmvNZVb2SqjlD4oS3bh+VbZ
 yaHjiYNbR3KbRaHvxUX7tatFr1tEWSyCw71FzxcIU/HJsjU9rYqABHfv6bczb9H7vyNdHEF5xBE
 AYQQVNdYGnDtW89CdwkgDAQuCNN8b/Ug9/mppnODLPi2tYWGH5Dc9wz9eyUxf8ZKXeLjgNsypA9
 vEgFz6Ky3RC6iqlQB5odYE6tEBR94joKkjVW96ilt2pYz79rxJgF25PWECBODhiqesyLtSu+jAV
 TN0mcs45oDvx0zFV3ePy6qaEcC48XeXFzjp/sZaj7DzKiPRLjEd7rIfY9tPDyeK6tcdVzTcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=941 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Test that the NSR exception bit field is equal to the pool ring value,
> rather than any common bits set, which is more correct (although there
> is no practical bug because the LSI NSR type is not implemented and
> POOL/PHYS NSR are encoded with exclusive bits).
> 
> Fixes: 4c3ccac636 ("pnv/xive: Add special handling for pool targets")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 80b07a0afe..cebe409a1a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -54,7 +54,8 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>          uint8_t *alt_regs;
>  
>          /* POOL interrupt uses IPB in QW2, POOL ring */
> -        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
> +        if ((ring == TM_QW3_HV_PHYS) &&
> +            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
>              alt_ring = TM_QW2_HV_POOL;
>          } else {
>              alt_ring = ring;


