Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F58DC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHEd-0006Up-IY; Wed, 14 May 2025 14:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHEa-0006No-4l; Wed, 14 May 2025 14:53:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHEY-0005pk-86; Wed, 14 May 2025 14:53:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoRqq031431;
 Wed, 14 May 2025 18:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=koKUXM
 oBfM9e9LZi4CRf7JTHT6pDUnJ2aFTEcyS8agA=; b=EW/l1lr8XN7ZaMgc7mEFZr
 dm+yXE+7up3AZxVAddpxHSUiAbj+12f1i2GDGUGN3YeXbxhHKpLA6lo0fwEa8sWE
 Pd+DTwVhDaS3H+fVbjYRF2f1H9nnP0K/FRFUapZcwsPcd2QGn4a+xqnIaYWyZEIf
 bkRtslaOzQlAa1HFfqiS0uj/YGGkS4XA3EhUwanVwDoDoUBtJP/jzTSPgM+PyEvt
 9m4Rqg/AdwWI0slsp3slsw+qidD4WZtaY3qfkrlc6j/OZ//fDlXUOy0sRGIeaO4T
 gGqnROWKvhudwCWMy8oq83FdUJ6QL2aY8YSXyKER/WSymSLudATGcKaUs/5k5OBQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t980wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIphVF002120;
 Wed, 14 May 2025 18:53:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t980wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGam8s026939;
 Wed, 14 May 2025 18:53:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdwn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIrXR227525782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:53:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C36D5804E;
 Wed, 14 May 2025 18:53:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92F9D5803F;
 Wed, 14 May 2025 18:53:32 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:53:32 +0000 (GMT)
Message-ID: <e2f9b1fa-1dc5-47b9-b0c9-bd045ec3faa1@linux.ibm.com>
Date: Wed, 14 May 2025 13:53:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/50] ppc/xive2: Fix treatment of PIPR in CPPR update
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-11-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824e6b0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=s4-vMrlk4BzfF5juaZgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfXwCkOK/vxjz4V
 /l5OaxBNjHCLLfg5dBVPDgTxwj5jS9UaqCnHAgzthDpUN61rNLnbNUVxlNeGNbbm32/3YOHZoD+
 frH2QGioeo4nmZ01EDRjY7X/K2oa/STmycBu3pF7oJzr8uJvu7PZ8i4X1CYZaNjQGuPWE1XGKLs
 gpZMWooqiUjs6xt2vORizNv/HwB8ZmNcZSqfJeM+gowIAPPOgGWls/6gG4oLB576MTwlr+e3GFv
 u/p6HPc/AYhfSyqkZuBEp99Hiki+Q5leI3aQ/ayHRb3vP5H0/pCmVl0R+bDx9xydojoLqu+CkL7
 kSpbWfzKJjlkgRGToWyQPhIZmc21704dpZhUWlPJSLCJAG+/+0+u/RXn56ND5nQRZ1j4HSBpHAB
 rHZdyPXyn4wLbcWpyy8XNkEZPqabiZzTLbay6uUChqOEOoxt3L4rNLX1YoZRIE0miMmXCONk
X-Proofpoint-ORIG-GUID: I9ReoO-J-hqTKglnx9JlKW69xajMhpaG
X-Proofpoint-GUID: wUVAunogSJY-8-WpN64ZQWZbQ-3cSmy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=902 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> According to the XIVE spec, updating the CPPR should also update the
> PIPR. The final value of the PIPR depends on other factors, but it
> should never be set to a value that is above the CPPR.
>
> Also added support for redistributing an active group interrupt when it
> is precluded as a result of changing the CPPR value.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 2b4d0f51be..1971c05fa1 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -995,7 +995,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>               }
>           }
>       }
> -    regs[TM_PIPR] = pipr_min;
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
>   
>       rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
>       if (rc) {

