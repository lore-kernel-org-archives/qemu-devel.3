Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7A3C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl4-0004Jx-4y; Wed, 14 May 2025 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDC5-0000A4-2y; Wed, 14 May 2025 10:34:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDC1-0006uk-Hg; Wed, 14 May 2025 10:34:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E70Axl018288;
 Wed, 14 May 2025 14:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=llVUqi
 mV5WZoAjum166nvVQTCqY4FkPx5zldDBTnpg8=; b=c5jxmU6Eq/e1ykMFYYhUo8
 Q2n5sTEzw7hu3JdoUmNhh3xgxJQqvUjmkfhi+pudURic2rfilvE1NWQXGnD6j15a
 Dm2SSDOPHw0T2F6L4ujzLR/N7L7gzu54/rgb6Q99iLOtoSfGEfxZm9vgGJnjiv32
 EJOZ3mGd0ITwp9wulRbfI7RiNCtqrGW+wo1T3u7YFNxc2r90VnL1qbJUHkORevy/
 uffQ5OZJouEkLhWVBMjDcCpsbLqjoQNsITHKY6OQpqkLqV1l6ZjbYhwTOVKzZkgW
 mfMq5GC7fYT7Sh0zng3nqCnEF3uaZ2F9KqoQo2n4E7oYsiHfSxy4x3H/UUWp+/2Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8mvw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:34:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEVXHM008552;
 Wed, 14 May 2025 14:34:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8mvvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:34:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDSdM5019466;
 Wed, 14 May 2025 14:34:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmp0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:34:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEYfIE16188028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:34:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EBAA5805E;
 Wed, 14 May 2025 14:34:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A74FC58064;
 Wed, 14 May 2025 14:34:40 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:34:40 +0000 (GMT)
Message-ID: <18fbf0cb-a60c-4c41-90ca-e24a040a05dc@linux.ibm.com>
Date: Wed, 14 May 2025 09:34:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/50] ppc/xive: Explicitly zero NSR after accepting
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-15-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-15-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vnmcVBrqwKLBCzCQ1M1GBtfYoi14Cezt
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6824aa03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=pEHLqOCy1T54nkr0MDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyMCBTYWx0ZWRfX3i18lVW8h1W2
 CEKf0SdzpeW8hJSpY2Ma2i8AnIigsmtDuP+4Ze+0sQ0CmJPlFPSLFELSr3FFCTXKFOxeJhtIYE7
 7LKvyUCFXwKlLTxiGUPAnzkDs2C2KABC+Y344KUhzyHsG7YNXxAI3GSNPg8UJGRKlS/CS05/qDt
 arSPBfqS2MQWJ5y5iES+SYWGrbO6vquc3SG/TGedMhYbRuaywhEjb0Q6Z8ehTSennuiIF3CEZ9j
 sD2sdyswzPKRF/XkoTzSPFXl0mXNzo19/KL/BR8U1MsRNvLA0yWCpylvjrZswdaBazOBAuHoi/y
 /Gsz3za+jG2meijBLBeoZWMjiU7g3L3jXp7aUHRGpQ0PVAKXIOa6TJ1tSYeQaJkR5p7iguipKVS
 /8cwzAOnwG87Eg6bc+bmEhR7n44qOMx217YrMNftgfRhN5CByWaoNMk79Lzb04ujHRUprD1R
X-Proofpoint-GUID: ybTe4ldk_lG7_oApsskaCBFCwbtVmrH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=560 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140120
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:35 -0400
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
> Have xive_tctx_accept clear NSR in one shot rather than masking out bits
> as they are tested, which makes it clear it's reset to 0, and does not
> have a partial NSR value in the register.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6293ea4361..bb40a69c5b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -68,13 +68,11 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>           * If the interrupt was for a specific VP, reset the pending
>           * buffer bit, otherwise clear the logical server indicator
>           */
> -        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
> -            regs[TM_NSR] &= ~TM_NSR_GRP_LVL;
> -        } else {
> +        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
>              alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>          }
> 
> -        /* Drop the exception bit and any group/crowd */
> +        /* Clear the exception from NSR */
>          regs[TM_NSR] = 0;
> 
>          trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,


