Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3367C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHg1-0006Fc-8J; Wed, 14 May 2025 15:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHTh-0004uL-0c; Wed, 14 May 2025 15:09:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHTe-00017H-MD; Wed, 14 May 2025 15:09:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EFPJZs026383;
 Wed, 14 May 2025 19:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WURQYX
 2txaiiIYb+FkpdD9xYKn0Q9Sr4SaE1aNhxzcQ=; b=pKdcNM3tMUmVSEtY4GdWPj
 t1+XSs/if72S6Zm8nGxE1HCXdfyOUMoma0RD7YXpHH+PyQ6O/3PFAJBznQO61PD1
 8TrHI1sN8rWY9cxDSNpbQXCDa/sIpuS6qhromvNbO0V4/vT+f7t1/Conk0VwitLj
 bLDAcRjgGS0YwfUgANr1UFszZtPrlPeCORKKeWW58TkJKPqp26y31kFBfIfEwfZO
 FI4BMP4NM1LBXqRuRfOPeSu+aH+zDAQTqLy00LTzFr+ZRuWB9fq4YqbCnbIK5K1o
 tSbBo8/Z1CfgMPRt5iVOEKypbxFK6+DtLCK+SN+CLAXHJP43pj044E7hFGCsEL5w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3upg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:09:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJ7sV4001182;
 Wed, 14 May 2025 19:09:10 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3upa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:09:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGkbJ2026912;
 Wed, 14 May 2025 19:09:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdyyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:09:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJ98kE32703056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:09:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56A2C5804E;
 Wed, 14 May 2025 19:09:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7C1C5803F;
 Wed, 14 May 2025 19:09:07 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:09:07 +0000 (GMT)
Message-ID: <eb6dc853-fa9c-4490-8354-7613b10bedd6@linux.ibm.com>
Date: Wed, 14 May 2025 14:09:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/50] pnv/xive2: Print value in invalid register write
 logging
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-19-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-19-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BWNLtCB89iOGuMWlslInE9QVnwj-bQ6B
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824ea57 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=AkBiSlDtaiLAz8i-hrYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lcRlrq7_0joPerGE_Ng9MoI9ds9TSI68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE3NCBTYWx0ZWRfX8Jpo+Kcva5S2
 zzPFcEFdKw2Sjla/GvwNaQLq3JG3h6JN8kdqAWDFFl8LX+9o9E5Mv5yjR3hRV5bPzGi3MekAn7N
 ynCctxngG8bbKpnWamHX/zYb+NNmBgI0EnnBqAL2WVbZ3fquf6C6yTC6PLOd+c1MBAJ8z9zwxbm
 RLX7GiZW3cUfwIuI9Zvbs6LNMuovo9XlXF1mCTUHnkyPYt5FtA66mY96X2evAzumnD9wQJJx2Jh
 xb3xe3E2rCUJkIvOd76x2IUaZ8MfRaJ9LLn19cpyFQqrJPtu++B0qghOu9ee2dolkF9z3p1q9c+
 e96KoGdzz78X/Q/q+O8lLmddWnnHhr46HBZBtPu5byhkqekphBsDG2LKmqMPbJBclA36E08HdMs
 uhh6eoxfpQsYB8xPIs1Ga5Db0OkMt1h+hvhAZiB0EpiwQ47y2Skv9jorGolGsX2XD9x1zEUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
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
> From: Michael Kowal <kowal@linux.ibm.com>
>
> This can make it easier to see what the target system is trying to
> do.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> [npiggin: split from larger patch]
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d7ca97ecbb..fcf5b2e75c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1197,7 +1197,8 @@ static void pnv_xive2_ic_cq_write(void *opaque, hwaddr offset,
>       case CQ_FIRMASK_OR: /* FIR error reporting */
>           break;
>       default:
> -        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>           return;
>       }
>   
> @@ -1495,7 +1496,8 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>           break;
>   
>       default:
> -        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "VC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>           return;
>       }
>   
> @@ -1703,7 +1705,8 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>           break;
>   
>       default:
> -        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "PC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>           return;
>       }
>   
> @@ -1790,7 +1793,8 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>           xive->tctxt_regs[reg] = val;
>           break;
>       default:
> -        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "TCTXT: invalid write @0x%"HWADDR_PRIx
> +                    " data 0x%"PRIx64, offset, val);
>           return;
>       }
>   }
> @@ -1861,7 +1865,8 @@ static void pnv_xive2_xscom_write(void *opaque, hwaddr offset,
>           pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
>           break;
>       default:
> -        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>       }
>   }
>   
> @@ -1929,7 +1934,8 @@ static void pnv_xive2_ic_notify_write(void *opaque, hwaddr offset,
>           break;
>   
>       default:
> -        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>       }
>   }
>   
> @@ -1971,7 +1977,8 @@ static void pnv_xive2_ic_lsi_write(void *opaque, hwaddr offset,
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
>   
> -    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
> +    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
> +                offset, val);
>   }
>   
>   static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
> @@ -2074,7 +2081,8 @@ static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
>           inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
>           break;
>       default:
> -        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>           return;
>       }
>   

