Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434EAC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHys-0003bW-2L; Wed, 14 May 2025 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHye-0003PX-U8; Wed, 14 May 2025 15:41:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHyc-0000DU-NU; Wed, 14 May 2025 15:41:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHhDal012980;
 Wed, 14 May 2025 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SgFj8J
 ZhsJ5RgfIiga7jMzgq7gmADL85Ruk1xwOdvds=; b=aYHe0txhevqY1yvT6kTvxd
 sPQOYLXb2vw8ZNhyUgOJhXx+MP1uhf5SvNJSfrAlW4JcWmDWr4sSyygKbszuHVe5
 zJMZ7VOpwbG3zFcXyKuK3fvTF8w2DKrDvqSqkxWkM8bEtHZ5qEdNUwhDuoATwnag
 KKuQGMsfnHM4+dkhPxGHZtpyBdDII2hWLk55vVmBrhZA4cEwA+UAhqCis4CdnCrt
 duU+LnzdPFu67KZg3yaemhws2X78n+U4tuja28O408a00REG+VCh9zQJLf5Ud9lY
 dRtUJFfE+9/eadOpkhsmVq0HnvL831QdvTW1LPwSSwoptBak3Pcu8nWsl08OLIXg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb7md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:41:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJdNV7030033;
 Wed, 14 May 2025 19:41:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb7mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:41:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGamOm026939;
 Wed, 14 May 2025 19:41:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpe4wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:41:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJf9gZ13042204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:41:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6B5D5804E;
 Wed, 14 May 2025 19:41:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69B6D5803F;
 Wed, 14 May 2025 19:41:08 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:41:08 +0000 (GMT)
Message-ID: <0547da44-39cb-4e89-b765-f8a0666dfe1a@linux.ibm.com>
Date: Wed, 14 May 2025 14:41:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/50] ppc/xive2: add interrupt priority configuration
 flags
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-22-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-22-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824f1d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=9maZL9_ULP1nituExRAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yQgE7C1GJiZr4P7O_glSbJQDFZp8JduT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX43HYwOhns/3N
 qUVkE5uWerPu3e3pskmCBqwUlBz/LTn7lELOAAtarN7MHxieCQtf2kbajEzi0nWwL/dc6TGGW6m
 pyugUNygrh3Sw0h3U+BMpeRJIZMymTJSH/HmQYEuBT0qNnrurkHssQ8dIYr1ZAr5lWZi/tIFf2x
 qsz4bJhBFVuzREyJNedeicKzdaWsG2NsmN1k1bRCln/9WnBAnRD9NccdR6ome1kO9yuBIuJcBEs
 wUq+IUGpTRk91FFJ7dgG5ypg8QqLaxQYlCoxa0StOw0rXdsK0G1sZR+aazKxHQg+awGPp55iVE0
 kW0ED+GAuQfu6e3Mxh2hBgrXmcagDN855+KUok1Zy+s14i1lcA0CJ6EZW9SdnpiDrvr0nZAMODT
 Ax7he6VhyloXwYjHKUzd500ylZVQ0IxWhObJzZdyWd5yYJA6x7CW2r1bVYTOQ+FNcauPCd9C
X-Proofpoint-GUID: 8EdcuwedMv0NxXTd5-HCDr2NKyrHi6Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Adds support for extracting additional configuration flags from
> the XIVE configuration register that are needed for redistribution
> of group interrupts.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK


>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c      | 16 ++++++++++++----
>   hw/intc/pnv_xive2_regs.h |  1 +
>   include/hw/ppc/xive2.h   |  8 +++++---
>   3 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index c9374f0eee..96b8851b7e 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -605,20 +605,28 @@ static uint32_t pnv_xive2_get_config(Xive2Router *xrtr)
>   {
>       PnvXive2 *xive = PNV_XIVE2(xrtr);
>       uint32_t cfg = 0;
> +    uint64_t reg = xive->cq_regs[CQ_XIVE_CFG >> 3];
>   
> -    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
> +    if (reg & CQ_XIVE_CFG_GEN1_TIMA_OS) {
>           cfg |= XIVE2_GEN1_TIMA_OS;
>       }
>   
> -    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
> +    if (reg & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
>           cfg |= XIVE2_VP_SAVE_RESTORE;
>       }
>   
> -    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE,
> -              xive->cq_regs[CQ_XIVE_CFG >> 3]) == CQ_XIVE_CFG_THREADID_8BITS) {
> +    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE, reg) ==
> +                      CQ_XIVE_CFG_THREADID_8BITS) {
>           cfg |= XIVE2_THREADID_8BITS;
>       }
>   
> +    if (reg & CQ_XIVE_CFG_EN_VP_GRP_PRIORITY) {
> +        cfg |= XIVE2_EN_VP_GRP_PRIORITY;
> +    }
> +
> +    cfg = SETFIELD(XIVE2_VP_INT_PRIO, cfg,
> +                   GETFIELD(CQ_XIVE_CFG_VP_INT_PRIO, reg));
> +
>       return cfg;
>   }
>   
> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
> index e8b87b3d2c..d53300f709 100644
> --- a/hw/intc/pnv_xive2_regs.h
> +++ b/hw/intc/pnv_xive2_regs.h
> @@ -66,6 +66,7 @@
>   #define    CQ_XIVE_CFG_GEN1_TIMA_HYP_BLK0       PPC_BIT(26) /* 0 if bit[25]=0 */
>   #define    CQ_XIVE_CFG_GEN1_TIMA_CROWD_DIS      PPC_BIT(27) /* 0 if bit[25]=0 */
>   #define    CQ_XIVE_CFG_GEN1_END_ESX             PPC_BIT(28)
> +#define    CQ_XIVE_CFG_EN_VP_GRP_PRIORITY       PPC_BIT(32) /* 0 if bit[25]=1 */
>   #define    CQ_XIVE_CFG_EN_VP_SAVE_RESTORE       PPC_BIT(38) /* 0 if bit[25]=1 */
>   #define    CQ_XIVE_CFG_EN_VP_SAVE_REST_STRICT   PPC_BIT(39) /* 0 if bit[25]=1 */
>   
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 2436ddb5e5..760b94a962 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -29,9 +29,11 @@ OBJECT_DECLARE_TYPE(Xive2Router, Xive2RouterClass, XIVE2_ROUTER);
>    * Configuration flags
>    */
>   
> -#define XIVE2_GEN1_TIMA_OS      0x00000001
> -#define XIVE2_VP_SAVE_RESTORE   0x00000002
> -#define XIVE2_THREADID_8BITS    0x00000004
> +#define XIVE2_GEN1_TIMA_OS          0x00000001
> +#define XIVE2_VP_SAVE_RESTORE       0x00000002
> +#define XIVE2_THREADID_8BITS        0x00000004
> +#define XIVE2_EN_VP_GRP_PRIORITY    0x00000008
> +#define XIVE2_VP_INT_PRIO           0x00000030
>   
>   typedef struct Xive2RouterClass {
>       SysBusDeviceClass parent;

