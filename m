Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D8C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI0E-000520-Mz; Wed, 14 May 2025 15:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI09-0004s7-1M; Wed, 14 May 2025 15:42:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI06-0000Lh-Fv; Wed, 14 May 2025 15:42:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EELUuJ026363;
 Wed, 14 May 2025 19:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LiRzfs
 +MdSOnpmYdtEcLt19MsdCJWAcpLlS1GWQL5Qg=; b=rBzLUmNSXMkyE+2kqBLYf7
 kFi0dmjHQ91ApLyj8Im1P7CR4bLpVEKA4H/G6ZD9tFYDQqLjcjYgnm3kc7ekYex6
 /ww5MvBd6KZzc0Kgp9cuMjCPElXGmJrcTSFIkxI0mP0ZjCrOrlGHR5vZde8kI9vc
 d2/bEYG50AB2Z2P2QKGXf8kiupVIIZvgzFDZdMzSBevA/u2K+wYx45lT4WBP90SX
 9ZI55tzbQmMIAZT0VN75t65IUNt2UfhiJ/4AwrDVjt7NeWOkITtFHQzXXT5bjyjM
 I9cjhIx/4suw/mgc5VFj2NfQz4pCAbi2gVfbQW+2mnbuAHxfVw0Ub3YS68PB1QcQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst41af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:42:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJghDj012468;
 Wed, 14 May 2025 19:42:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst41ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:42:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJZdrc015330;
 Wed, 14 May 2025 19:42:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpx5hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:42:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJgbLW26804946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:42:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D78258054;
 Wed, 14 May 2025 19:42:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 816175803F;
 Wed, 14 May 2025 19:42:40 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:42:40 +0000 (GMT)
Message-ID: <3308dd0d-82d5-4df0-a87d-d075049231be@linux.ibm.com>
Date: Wed, 14 May 2025 14:42:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/50] ppc/xive2: Support redistribution of group
 interrupts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-23-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-23-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UvgnHRlvlPmlbMN_D1iIQaKCorEmEH3V
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824f234 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=uwEPBR_WYrQSYEFh4vEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _mLF7Up8kswnTUcF5eZE_FGWXvQp9z_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX5IESl/EOpsOd
 oE8oTpJ4TY1xGgC6fuVBOxmsLeGQPnec4rQUDH1fRsgs4LvfHq+/EG5Mo9QfGFofwQyLRjaQzLA
 3Z6L8zXbELLQactLvEISjsOFp/46rG6SHOY1Gx9WGS7ZOrfFA1tLg1bAZFTgwDylTbz5PCLHRFD
 Z7+UhxtRdGzC6ioKopfJ1Jjj2KBh0RpOXMZ3X5dnrHRJ2NPZerWV92aVN5vptSybQ6AB/k1ciQp
 9oVOrF5h7SoLEadDTFQp0Lpm5KWiKQGrJYCemgPSOaKVhVQajKl79L+s6owKm3MuU2vsLh9lgkp
 fnJvf0M/QrhZsj0z/YacoAz77XR+m+We1dN3DTEKb99oUgqdov4LrnQlVbzyUGIZQquHDl5x6Qi
 uGRrtvHYZfaYMpiS6AsZNCmZyc/YcgSPAsjLGqtthI+aNt9LUJTHJV1TA0wPS5faWzTyNcKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
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
> When an XIVE context is pulled while it has an active, unacknowledged
> group interrupt, XIVE will check to see if a context on another thread
> can handle the interrupt and, if so, notify that context.  If there
> are no contexts that can handle the interrupt, then the interrupt is
> added to a backlog and XIVE will attempt to escalate the interrupt,
> if configured to do so, allowing the higher privileged handler to
> activate a context that can handle the original interrupt.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive2.c             | 84 +++++++++++++++++++++++++++++++++++--
>   include/hw/ppc/xive2_regs.h |  3 ++
>   2 files changed, 83 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 0993e792cc..34fc561c9c 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -19,6 +19,10 @@
>   #include "hw/ppc/xive2_regs.h"
>   #include "trace.h"
>   
> +static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
> +                                    uint32_t end_idx, uint32_t end_data,
> +                                    bool redistribute);
> +
>   uint32_t xive2_router_get_config(Xive2Router *xrtr)
>   {
>       Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
> @@ -597,6 +601,68 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>       return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
>   }
>   
> +static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
> +                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
> +{
> +    uint8_t nsr = tctx->regs[ring + TM_NSR];
> +    uint8_t crowd = NVx_CROWD_LVL(nsr);
> +    uint8_t group = NVx_GROUP_LVL(nsr);
> +    uint8_t nvgc_blk;
> +    uint8_t nvgc_idx;
> +    uint8_t end_blk;
> +    uint32_t end_idx;
> +    uint8_t pipr = tctx->regs[ring + TM_PIPR];
> +    Xive2Nvgc nvgc;
> +    uint8_t prio_limit;
> +    uint32_t cfg;
> +
> +    /* convert crowd/group to blk/idx */
> +    if (group > 0) {
> +        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
> +                   ((1 << (group - 1)) - 1);
> +    } else {
> +        nvgc_idx = nvp_idx;
> +    }
> +
> +    if (crowd > 0) {
> +        crowd = (crowd == 3) ? 4 : crowd;
> +        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
> +                   ((1 << (crowd - 1)) - 1);
> +    } else {
> +        nvgc_blk = nvp_blk;
> +    }
> +
> +    /* Use blk/idx to retrieve the NVGC */
> +    if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
> +                      crowd ? "NVC" : "NVG", nvgc_blk, nvgc_idx);
> +        return;
> +    }
> +
> +    /* retrieve the END blk/idx from the NVGC */
> +    end_blk = xive_get_field32(NVGC2_W1_END_BLK, nvgc.w1);
> +    end_idx = xive_get_field32(NVGC2_W1_END_IDX, nvgc.w1);
> +
> +    /* determine number of priorities being used */
> +    cfg = xive2_router_get_config(xrtr);
> +    if (cfg & XIVE2_EN_VP_GRP_PRIORITY) {
> +        prio_limit = 1 << GETFIELD(NVGC2_W1_PSIZE, nvgc.w1);
> +    } else {
> +        prio_limit = 1 << GETFIELD(XIVE2_VP_INT_PRIO, cfg);
> +    }
> +
> +    /* add priority offset to end index */
> +    end_idx += pipr % prio_limit;
> +
> +    /* trigger the group END */
> +    xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
> +
> +    /* clear interrupt indication for the context */
> +    tctx->regs[ring + TM_NSR] = 0;
> +    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
> +    xive_tctx_reset_signal(tctx, ring);
> +}
> +
>   static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, unsigned size, uint8_t ring)
>   {
> @@ -608,6 +674,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       uint8_t cur_ring;
>       bool valid;
>       bool do_save;
> +    uint8_t nsr;
>   
>       xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
>   
> @@ -624,6 +691,12 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>           memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
>       }
>   
> +    /* Active group/crowd interrupts need to be redistributed */
> +    nsr = tctx->regs[ring + TM_NSR];
> +    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +    }
> +
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
>           xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
>       }
> @@ -1352,7 +1425,8 @@ static bool xive2_router_end_es_notify(Xive2Router *xrtr, uint8_t end_blk,
>    * message has the same parameters than in the function below.
>    */
>   static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
> -                                    uint32_t end_idx, uint32_t end_data)
> +                                    uint32_t end_idx, uint32_t end_data,
> +                                    bool redistribute)
>   {
>       Xive2End end;
>       uint8_t priority;
> @@ -1380,7 +1454,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>           return;
>       }
>   
> -    if (xive2_end_is_enqueue(&end)) {
> +    if (!redistribute && xive2_end_is_enqueue(&end)) {
>           xive2_end_enqueue(&end, end_data);
>           /* Enqueuing event data modifies the EQ toggle and index */
>           xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
> @@ -1560,7 +1634,8 @@ do_escalation:
>           xive2_router_end_notify(xrtr,
>                                  xive_get_field32(END2_W4_END_BLOCK,     end.w4),
>                                  xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> -                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
> +                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
> +                               false);
>       } /* end END adaptive escalation */
>   
>       else {
> @@ -1641,7 +1716,8 @@ void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
>       xive2_router_end_notify(xrtr,
>                               xive_get_field64(EAS2_END_BLOCK, eas.w),
>                               xive_get_field64(EAS2_END_INDEX, eas.w),
> -                            xive_get_field64(EAS2_END_DATA,  eas.w));
> +                            xive_get_field64(EAS2_END_DATA,  eas.w),
> +                            false);
>       return;
>   }
>   
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 2c535ec0d0..e222038143 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -224,6 +224,9 @@ typedef struct Xive2Nvgc {
>   #define NVGC2_W0_VALID             PPC_BIT32(0)
>   #define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
>           uint32_t        w1;
> +#define NVGC2_W1_PSIZE             PPC_BITMASK32(0, 1)
> +#define NVGC2_W1_END_BLK           PPC_BITMASK32(4, 7)
> +#define NVGC2_W1_END_IDX           PPC_BITMASK32(8, 31)
>           uint32_t        w2;
>           uint32_t        w3;
>           uint32_t        w4;

