Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1854DC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaso-0003lW-36; Thu, 15 May 2025 11:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFasj-0003Lx-Tx; Thu, 15 May 2025 11:52:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFasg-00079v-4j; Thu, 15 May 2025 11:52:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDn3iL032307;
 Thu, 15 May 2025 15:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=MNNPNpp/8ui31O5BtXqm6Qv2cN1B7cm9jH3wc/AgxP0=; b=OwtN2nbXQ8gG
 mOJjizcR8XbWL7Br+LZbLDHYwVAdj7klclqcO6VNODhL0/IFTEGyTj8OjKNUkXjV
 /lCLtT2ifeObrRrk4MHIwDwB0r/59aEddmBk/gv3HoPYVL71RcWtDlSxyOLPFeE5
 MlF3bEfs+9dm/DqRYPZocfNgYN4/IZM0uNlQh7BJZxyqI79YkL13qxWuYwJaJr69
 xUofbDZs85CR8rb+BLSBUuNhUDCVEKDxh1cLQ6RwrxhfzHWSAzS0J9Vq+cR5i83G
 3IQYbkztRa31EhgnfM2KRIAWLI1JrDMKYfm2DYNyPZN7LP4hfdHE+UUEbdfeX154
 cQ1Uubw7Mw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30pgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:52:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFqIVI030490;
 Thu, 15 May 2025 15:52:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30pgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:52:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDr5v7024273;
 Thu, 15 May 2025 15:52:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb2a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:52:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFqGfK24969974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:52:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 783395805A;
 Thu, 15 May 2025 15:52:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 238E358056;
 Thu, 15 May 2025 15:52:16 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:52:16 +0000 (GMT)
Message-ID: <9a96117a19da549a17c0dc12d232fdbc86b64496.camel@linux.ibm.com>
Subject: Re: [PATCH 20/50] pnv/xive2: Permit valid writes to VC/PC Flush
 Control registers
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:52:15 -0500
In-Reply-To: <20250512031100.439842-21-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-21-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68260db3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=K43VmlK4zf_02HQK-ZgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXybcaOAQwMJUf
 CoTMnnUWjwsU0izEPMdBwBesmFTuKG/8yUquCncPNRu0zzZPO8S+hxc15TatzDdM1BJ72+NefWa
 wbc5t37PEkDps4BEiIfdyguXsKYrkmXpPT5BMq9R2T7pFJl2dqY/3fK0viUN8Dh0P5yKV2zP7Ta
 gDNpcGm/dW7TTjnCUNcPvJSu48ojOqGGl604zVgS03tUJWmYUyZQxIj61ZS0myCIfpc6gw6kdt5
 JOzrmqoVqv/fcVH22K5Hav8NcnF4ccE+xPpOPTyIe2vERZ+g4yyhSmhYMq3uQbqp6QQceuA5Zxz
 BzC82KKiKLdOItTIv8u60gMvRq6Xsc+J8NYqLu2l9J1Gv1s9j/bwLut7NuGqoQgzaHYpjS6M9la
 y1ZY6LMnsQzJ0K5Aq7b5wt9c7h1TgWdD3GDudh3j2GF78eUMorCjUAAG5f9GycexGTJmFzbI
X-Proofpoint-GUID: LoPH5EDcyimy6RiDx2__teYG42tVWg9_
X-Proofpoint-ORIG-GUID: bL2U_lfo47QosROutIpsqzPzd2vFWyrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=773
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> Writes to the Flush Control registers were logged as invalid
> when they are allowed. Clearing the unsupported want_cache_disable
> feature is supported, so don't log an error in that case.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3c26cd6b77..c9374f0eee 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>      /*
>       * ESB cache updates (not modeled)
>       */
> -    /* case VC_ESBC_FLUSH_CTRL: */
> +    case VC_ESBC_FLUSH_CTRL:
> +        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_ESBC_FLUSH_POLL:
>          xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
>          /* ESB update */
> @@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>      /*
>       * EAS cache updates (not modeled)
>       */
> -    /* case VC_EASC_FLUSH_CTRL: */
> +    case VC_EASC_FLUSH_CTRL:
> +        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_EASC_FLUSH_POLL:
>          xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
>          /* EAS update */
> @@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>          break;
>  
>  
> -    /* case VC_ENDC_FLUSH_CTRL: */
> +    case VC_ENDC_FLUSH_CTRL:
> +        if (val & VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_ENDC_FLUSH_POLL:
>          xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
>          break;
> @@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>          pnv_xive2_nxc_update(xive, watch_engine);
>          break;
>  
> -   /* case PC_NXC_FLUSH_CTRL: */
> +    case PC_NXC_FLUSH_CTRL:
> +        if (val & PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case PC_NXC_FLUSH_POLL:
>          xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
>          break;


