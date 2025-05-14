Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08CEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDkz-0004Gp-EF; Wed, 14 May 2025 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9J-0007V6-Gs; Wed, 14 May 2025 10:31:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9H-0006hA-JO; Wed, 14 May 2025 10:31:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8pIw8029370;
 Wed, 14 May 2025 14:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vLIHod
 VcfeMG0Tn6VPJazCdEuKozL+72zJ9xvhGykQs=; b=QmAs87kSYetczi9dwxyzkN
 PJCicqSlvmIfoRAFwBz+zIflnp/+lQtAxUUDGc7Ar8+7aNNcQHlGSTx8xP9xFBm6
 kvfdgBelZeybm8am+nDBIYq/1cDVIuQI31A6VpDIWuxMJ9OQuxRiAzGn9VrGSVNb
 B1NZ+0DtClBMjxEaWfmft95tV8EN1ilOC2rAep7reGrrWCpxeLqpmPUPIhy3CKVX
 7clReybgSys8aB+IKIKSBDLp1Z2Ln2tc7B33Svqgm5qQvfCOFiwK47OUmDTBAHZW
 2VQxS2+m8LpAWCyvNttDgSyK8Xe9G3DGWkZr7QnVP/F8X2GegI5hu+7YVxTw97dw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghnwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEUBqG008664;
 Wed, 14 May 2025 14:31:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghnwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDg3Zt024449;
 Wed, 14 May 2025 14:31:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4nfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:51 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEVnxi25494054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:31:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC3B858052;
 Wed, 14 May 2025 14:31:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 550AC58063;
 Wed, 14 May 2025 14:31:49 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:31:49 +0000 (GMT)
Message-ID: <b01f9b5b-c9c1-4b8a-b188-5057b5d31af8@linux.ibm.com>
Date: Wed, 14 May 2025 09:31:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/50] ppc/xive2: Fix irq preempted by lower priority
 group irq
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-10-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-10-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a0kh48kbZA8IO6RfnQ14AQ5UZpabja_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfXy7uktjzAgPev
 Ab++CHqKK3j1mj+yojgf+ilzn2XXqJSaadTM6zfD2NtGCcWHdjf0JVK2TEm6RQaaM05ckEBbBNO
 isD6a7Q8N4mNeIwmrPLNyrRMR2VZu/WF3tI5rrHzzyEY9kHqNwgnlcILeNh5UE0W6EuX4C5BINe
 NJftjI+uGKxn7zoB3yfdH0p1osfhqP51DXdcSMDEVEzMukldJZE1T8AjKTGJBIWyxoBJiRnuTJ5
 AH5gb7Gt03DyKYLZMOaSSAsVkBHi7X6/dnchI8MerFAaOww43XHJ2iRkSoxND8SYTAuq6OxJuna
 eSDow7+dKP+eIHh7B2nx9HqQn8bp/5gXholOyxgWuUQLDkSFUg1ka1NcP94UiRpWu0fuLuYa2em
 3fBhrEk5oGx+6lTbZM34K4MyHJwjj47ErR8dwFlFz95PAL0g4n+iqCWv8GHdr4ta3SpLwKLU
X-Proofpoint-GUID: n0iQiIZT2kDo7nDVGBYd1TCay-C5zLGD
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824a959 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=rvxr7Vxs7MPorNA6K-4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=858
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
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> A problem was seen where uart interrupts would be lost resulting in the
> console hanging. Traces showed that a lower priority interrupt was
> preempting a higher priority interrupt, which would result in the higher
> priority interrupt never being handled.
> 
> The new interrupt's priority was being compared against the CPPR
> (Current Processor Priority Register) instead of the PIPR (Post
> Interrupt Priority Register), as was required by the XIVE spec.
> This allowed for a window between raising an interrupt and ACK'ing
> the interrupt where a lower priority interrupt could slip in.
> 
> Fixes: 26c55b99418 ("ppc/xive2: Process group backlog when updating the CPPR")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 453fe37f18..2b4d0f51be 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1283,7 +1283,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>       * priority to know if the thread can take the interrupt now or if
>       * it is precluded.
>       */
> -    if (priority < alt_regs[TM_CPPR]) {
> +    if (priority < alt_regs[TM_PIPR]) {
>          return false;
>      }
>      return true;


