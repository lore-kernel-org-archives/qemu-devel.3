Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E57C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl3-0004Jc-Mm; Wed, 14 May 2025 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD8G-0007Cp-2C; Wed, 14 May 2025 10:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD8E-0006bT-2a; Wed, 14 May 2025 10:30:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8pQ1V029642;
 Wed, 14 May 2025 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LYlj+G
 xl3PUtNqxmfgUkiwiAWE53yU+qD+qG687tCa0=; b=SFyZD0Bv1JhrsvyntUlt9y
 NbjMrGiX7Gl4S+4B9vcKBmYYmccSxE3FtzE1/+RoJUod/4ZRV/mIiKzrOO4GcY+o
 2k/e28lQGyT7d8iKTKuAnuRDtEGwBwUQqY9iWXGZfD706YJe8KhL8gxd+ZuOJset
 96/LeTqYUuHZs/4SREmGvTZUzWB3+x09zlBnfVaNGNLuSvJEh5sOiQYJ1E8gi+y1
 68wrxbH4z7YxsJFQZvP6z0JRR1Xlsm+8UY0uEPnzsZ+nts7g8bcteUaM23OLIORo
 cDkWGAmpeabEK7fqfscklMaOKpzoyAx6P2xVZ8ALYcJpm707TJbKzTBJlN9a9BJw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghnp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EETScd007032;
 Wed, 14 May 2025 14:30:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghnp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDKKLK021806;
 Wed, 14 May 2025 14:30:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpmntk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEUiBO7995674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:30:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 814815805A;
 Wed, 14 May 2025 14:30:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25E0658052;
 Wed, 14 May 2025 14:30:44 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:30:44 +0000 (GMT)
Message-ID: <f06e57b8-7a41-42f6-bafb-e8f6decfedc9@linux.ibm.com>
Date: Wed, 14 May 2025 09:30:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] ppc/xive2: Reset Generation Flipped bit on END
 Cache Watch
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-8-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZ7U1uvyPa2wxnAev5aNnP_ag7GlIvw2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX0qV4X37bB04B
 Hy62r5QWZ3QIupfsqhidHonWxboJT5a8Ovovhhp+gKfYwvwb+NDX2AT8d2qPxsnUop8QzNYg42Y
 xG80CG690oK24703YBLnKePRWsUVWqLp+2J5FwaBX5xjKbzJhOZLj9qhwHNZKizjnOgwohMBWlc
 cOY1KhMR9lqpVw6dhmWdX7vZ0EAo3T9il0RkQ97/C2tW9bAm6j0kf0fJS8hiB5P9olh2XzS/+vo
 H5DzOwoMgwvJbIml9DScgh2flJM+/99H/TJHwxJ2LM9MIyk4MLn92jhO2y5IXavYF6GvkyywaYG
 H6yaqH4m/HNw0rsBHdzEwhxtS1EVPbnZM45z2J+XG234tzrWVcWSz0RCNzb2Jr5zdj8CxOem9mw
 37qwWbIX9myBysdE2JpbbZ66benVT3K/g/dfnRJ6II2BH3sEQL/fK7jxeC4Zy9q8VWRy3pI5
X-Proofpoint-GUID: W3YpUSRAetK9eEu-YX9ps01NVLCMiqlr
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824a917 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=u5XRYQ9GfIdERzJa8uoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:34 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> When the END Event Queue wraps the END EQ Generation bit is flipped and the
> Generation Flipped bit is set to one.  On a END cache Watch read operation,
> the Generation Flipped bit needs to be reset.
> 
> While debugging an error modified END not valid error messages to include
> the method since all were the same.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 3 ++-
>  hw/intc/xive2.c     | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 30b4ab2efe..72cdf0f20c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>      case VC_ENDC_WATCH3_DATA0:
>          /*
>           * Load DATA registers from cache with data requested by the
> -         * SPEC register
> +         * SPEC register.  Clear gen_flipped bit in word 1.
>           */
>          watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>          pnv_xive2_end_cache_load(xive, watch_engine);
> +        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
>          val = xive->vc_regs[reg];
>          break;
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4dd04a0398..453fe37f18 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>          qgen ^= 1;
>          end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
> 
> -        /* TODO(PowerNV): reset GF bit on a cache watch operation */
> -        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
> +        /* Set gen flipped to 1, it gets reset on a cache watch operation */
> +        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
>      }
>      end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>  }


