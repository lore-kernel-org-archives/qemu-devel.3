Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE1FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDlA-0004Nj-Bn; Wed, 14 May 2025 11:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9o-0007ch-D8; Wed, 14 May 2025 10:32:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9m-0006kQ-P6; Wed, 14 May 2025 10:32:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDnH5D004251;
 Wed, 14 May 2025 14:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Se5qmG
 FYoBxMh8s5eqrLk3B1FUCHc0beiZf75BgiAi8=; b=QhTLV5Jx5cQTOkZZ3rVPQc
 zrj/xRYSSYKsNhMUmQvJ5lJ3G8IoL6n1Ah8aF8akJPkdcHY2oyDzJvBjEz+xQTQQ
 MqNEoM8mPsWACQ7Mak75rVuaOVN4bSmyojvo02ksGDBpKSaItzn/QcMJ/U+6iw/o
 miWQYlEIE6d5t4ZO6ds11jEvi+C+mrJkIwFApB4BXE/O2geqYs/DiNFatxvz4fWD
 isXGyVV9jHGTgqzqd+5Vy+5xyT+rppefVNcCJdCYI5hABf6I/bqBRUptu2ZJa1lm
 9JBng+nZsOQgl4YBDOtQFoaSTDIN7yMG62LzNoWU88ywU7/6BTzAjKPVdBTg1hKQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd38842-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEW2mh009920;
 Wed, 14 May 2025 14:32:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3882u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDPJlh024309;
 Wed, 14 May 2025 14:32:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4nhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEW7Jp28901898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:32:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87F3058052;
 Wed, 14 May 2025 14:32:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2883E5805E;
 Wed, 14 May 2025 14:32:07 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:32:07 +0000 (GMT)
Message-ID: <ec9b7fa9-2305-49f3-b03c-27fe46c52323@linux.ibm.com>
Date: Wed, 14 May 2025 09:32:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/50] ppc/xive2: Fix treatment of PIPR in CPPR update
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-11-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2Vd9yONPkIr-5a9zcxAHx1pfcmuUuRue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX8wB6uFdKMtZK
 DTZjd1JEoC1FNHxV4x7JcuOLV9qvDDHzpX4mDGW18BdXqqmwc+TR9QHs6cVxn6KTpcJvZswA1G1
 O+6ZMKx9UPK7nJK9+CT7YL5NyNesK2T4T9/V05UQmC9oKnOMkpPWP5jXJs1pc3QZBx0YpA7eQy1
 MIE/wnAgi5N+4Y7yVGMR8JQgRwQeEWGtOnmgccWLwSa9NJUye8nmHwlDwSbUljuRKpfHUsnmbLj
 Olx5gI3D+jgjDdXT1XJqG4zNoadR9LXkf2cT1Zwm05EW/8OYCZIiVy05Nz6C+/fNd5P8Qt/SunN
 3etpnqABsaV9V5+vrdQeySaPSkZAb7he1xIzHHfVK9gYwczOFVYtLJ9reD1GCjV59KpgYtkmYkE
 e1bybdnRXN3IvGP/oVYZs3o7Xq3xitjf0HQQ/Os3Z7namwKwj0yjW+gfi5rvYUVgDNrVNgfE
X-Proofpoint-ORIG-GUID: eB49RMkdF-GCQSXT3WooukY2Y5-TX4UF
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824a979 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=s4-vMrlk4BzfF5juaZgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=809 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> According to the XIVE spec, updating the CPPR should also update the
> PIPR. The final value of the PIPR depends on other factors, but it
> should never be set to a value that is above the CPPR.
> 
> Also added support for redistributing an active group interrupt when it
> is precluded as a result of changing the CPPR value.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 2b4d0f51be..1971c05fa1 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -995,7 +995,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>              }
>          }
>      }
> -    regs[TM_PIPR] = pipr_min;
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> 
>      rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
>      if (rc) {


