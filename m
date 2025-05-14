Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DBC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl7-0004Mp-PN; Wed, 14 May 2025 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDAy-0007jn-B3; Wed, 14 May 2025 10:33:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDAw-0006oz-En; Wed, 14 May 2025 10:33:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDn7WO003596;
 Wed, 14 May 2025 14:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yY0Qjt
 1g/WmXbyRMJgLHhMX6fCea0Xi0+le6XTDe3/g=; b=sIF1A1UpGaJNeoM29Hp2mv
 MUzuswQgMwATqE9ROmnZRvRQSJPhwJAK2AdJTDnIdX2mVhz3sI0cznU+Dg3O32Ng
 H7w36j0mJrh7rwXm/7xBIOocRxPB472aZ6eSfzTUqYP63rQvqu7M1OlJ1pN1duHB
 K+7iaIkW3jW65xXNkygoaLpoVdOJJFWDgLSXp3ZhErVNCJI5BuhSle/HAUtXwMQj
 ah8vgEI2j57J9Sc9FChN7f09TXSAH9BLniTfyr8YSyYBjvnLlF6OGRZahm2o51ff
 WZqNrJXL0bsmDHsY6LhsxZ/if6ORFvhxPoy1VEkLuB1eOLmviEfAxQFhoXVn2QIg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd388bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EE77h6012238;
 Wed, 14 May 2025 14:33:36 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd388bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDURvM019381;
 Wed, 14 May 2025 14:33:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmnva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEXYN25571308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:33:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1A5058056;
 Wed, 14 May 2025 14:33:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8814258052;
 Wed, 14 May 2025 14:33:33 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:33:33 +0000 (GMT)
Message-ID: <e99ecc7d-b127-442c-82f5-15f7ff7457c4@linux.ibm.com>
Date: Wed, 14 May 2025 09:33:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/50] ppc/xive2: Set CPPR delivery should account for
 group priority
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-13-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-13-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e7-DgOZPpigWcS9EZFcBnRCXqqPwYiqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfXyPI4MIdOQSAm
 TjdzoMXMJUytn/e81v12kUAVfox9672rjX+NvQbRdKzCjURp8zVW13TKnK8NSD9yi7bkt0ejTX+
 IQS4ZjJ0A5nAHG+KkIj5+sF2l+50TXJPf5ume8YcKGQTqSh6QZy3dDsiA0AJV7X04vaLlHFbeG7
 1zjTZxEsrGGQiwzZmCYweOk2TvtBCju4Zb6mj57lw2p8Zfn/uVH0qMEEBCcw24BYtweuFk5Ecj/
 v1l+pY5+ZEaD+qSLcElhoiY2Nxszkpp7mDRizyp11jbmjDk9eX++6diwf3sALbBLpRirVUDYLUC
 M2qMM6bFdRL4HdH1R0YzfJZSnb+H49HwgLTc2wUFYM8TPW5Q0vGjDFaqWHPOqZG9D+kVb/NuiEC
 txJT8Rsmj6plGQUNblY+euqbgKcgPD7OPpKIcPQf7yi30Pl3WRgOF1nVAzd0NbNdFRU4VwEu
X-Proofpoint-ORIG-GUID: dvAvgDPdxPjDE6ClXjcY_fqdWFJIE60Z
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824a9c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=zSV6phptauE46_GIRisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
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
> The group interrupt delivery flow selects the group backlog scan if
> LSMFB < IPB, but that scan may find an interrupt with a priority >=
> IPB. In that case, the VP-direct interrupt should be chosen. This
> extends to selecting the lowest prio between POOL and PHYS rings.
> 
> Implement this just by re-starting the selection logic if the
> backlog irq was not found or priority did not match LSMFB (LSMFB
> is updated so next time around it would see the right value and
> not loop infinitely).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 8ede95b671..de139dcfbf 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -939,7 +939,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>  {
>      uint8_t *regs = &tctx->regs[ring];
>      Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
> +    uint8_t old_cppr, backlog_prio, first_group, group_level;
>      uint8_t pipr_min, lsmfb_min, ring_min;
>      bool group_enabled;
>      uint32_t nvp_blk, nvp_idx;
> @@ -961,10 +961,12 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       * Recompute the PIPR based on local pending interrupts. It will
>       * be adjusted below if needed in case of pending group interrupts.
>       */
> +again:
>      pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
>      group_enabled = !!regs[TM_LGS];
> -    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
> +    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
>      ring_min = ring;
> +    group_level = 0;
> 
>      /* PHYS updates also depend on POOL values */
>      if (ring == TM_QW3_HV_PHYS) {
> @@ -998,9 +1000,6 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>          }
>      }
> 
> -    /* PIPR should not be set to a value greater than CPPR */
> -    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> -
>      rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
>      if (rc) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
> @@ -1019,7 +1018,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
> 
>      if (group_enabled &&
>          lsmfb_min < cppr &&
> -        lsmfb_min < regs[TM_PIPR]) {
> +        lsmfb_min < pipr_min) {
>          /*
>           * Thread has seen a group interrupt with a higher priority
>           * than the new cppr or pending local interrupt. Check the
> @@ -1048,12 +1047,25 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>                                                      nvp_blk, nvp_idx,
>                                                      first_group, &group_level);
>          tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
> -        if (backlog_prio != 0xFF) {
> -            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> -                                         backlog_prio, group_level);
> -            regs[TM_PIPR] = backlog_prio;
> +        if (backlog_prio != lsmfb_min) {
> +            /*
> +             * If the group backlog scan finds a less favored or no interrupt,
> +             * then re-do the processing which may turn up a more favored
> +             * interrupt from IPB or the other pool. Backlog should not
> +             * find a priority < LSMFB.
> +             */
> +            g_assert(backlog_prio >= lsmfb_min);
> +            goto again;
>          }
> +
> +        xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> +                                     backlog_prio, group_level);
> +        pipr_min = backlog_prio;
>      }
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> +
>      /* CPPR has changed, check if we need to raise a pending exception */
>      xive_tctx_notify(tctx, ring_min, group_level);
>  }


