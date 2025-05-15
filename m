Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B54CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFauP-000204-Vp; Thu, 15 May 2025 11:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFauI-0001eZ-PS; Thu, 15 May 2025 11:54:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFauF-0007ET-F1; Thu, 15 May 2025 11:54:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgOx7013030;
 Thu, 15 May 2025 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=u7Ecf2DwoqLL1nI87QG7c2jLZxK5/we3lVFZWzi4Ul0=; b=NJK7hgmLxoKb
 XMv1o25SR+6YiLpBcp/adQJyiAEjAcoodRhDnHyansHciOc2tqGFeI3hfBi4yylV
 Ayeb42YdSqgetbVH2qOR5QUBpcMdNyfI6YUM2zNCKMrDELbZRpec+6bbvNZS/zJ+
 SEXrtZqL1e9vAw7ZnkeCLUUoBNUul8gNB/KbMvT2FS7vbN8ndIvhdRo6cSb/7sZb
 /hM44qRHK6CReaoxen6/YXGMNDDxgvstJwHjnYanJ2Fr4uxiWzyl81jM+r1el2Ms
 RTs+cB8+uYVh2FhfuPZ/BwRWWEjvjo2Pxa0H7H09VZKxxWGO1EaoLBDnz9uPxLsj
 zPqfqZSOiw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dk6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:53:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFruOg021687;
 Thu, 15 May 2025 15:53:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dk6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:53:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEHtU2019451;
 Thu, 15 May 2025 15:53:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru2nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:53:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFrrqq49545686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:53:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AA9A5805A;
 Thu, 15 May 2025 15:53:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C5B95805C;
 Thu, 15 May 2025 15:53:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:53:52 +0000 (GMT)
Message-ID: <6d301946daf6a554af50bbbf67c4ceacf69a8dbe.camel@linux.ibm.com>
Subject: Re: [PATCH 28/50] ppc/xive: Change presenter .match_nvt to match
 not present
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:53:52 -0500
In-Reply-To: <20250512031100.439842-29-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-29-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68260e15 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=su2U19PQI6u5Dp8BlYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXzgimTU6bOtno
 Ff8FQftvu7usgn2s1W4ENoxB2BTfxqLIY5O4kiR6DoEI+0f2FQTT3ucmyNVywJEtBUXtm3vxtHZ
 nfcEn0ldJuTfFDJObtpODnun9yGqipQOenvbqB9t1duzrOkuTgExG9pb9wF5/2N08AtrEGLBffE
 sfGtAFq+wBd8KYnzCjtB0HUgLa4M54fk8/nT982NJETlDAfsP5f/W0hSmPBjshZ3SVqcPCNqPmg
 nzaQM9teS8mgnHrKqkrxNMaWeJOsGLA6Uu7wUPiIHR/Nqhfw3LTpVZBgy9KT/y/lAosNGT0Nq2R
 FNvPOx0kpTakhfiuSd8GrMgEMJpJnTJAr6rL/azSOvEUrVrEe2N1mCP7j78EUHsuCDY+TACgldH
 Ia3SyZi80wmen+fZAYl10p/e0fiucRyMUbWSgvcUprJeUAJHLsboG4LfbqZgQ28K2oJeXwcW
X-Proofpoint-ORIG-GUID: WOkxdWl22lFs-Npq8Cq-_g9wFm0cPVd3
X-Proofpoint-GUID: NvhbFs_3mnB7utbCHw4z-ZL_nX0YJMvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Have the match_nvt method only perform a TCTX match but don't present
> the interrupt, the caller presents. This has no functional change, but
> allows for more complicated presentation logic after matching.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/pnv_xive.c    | 16 +++++++-------
>  hw/intc/pnv_xive2.c   | 16 +++++++-------
>  hw/intc/spapr_xive.c  | 18 +++++++--------
>  hw/intc/xive.c        | 51 +++++++++++++++----------------------------
>  hw/intc/xive2.c       | 31 +++++++++++++-------------
>  hw/ppc/pnv.c          | 48 ++++++++++++++--------------------------
>  hw/ppc/spapr.c        | 21 +++++++-----------
>  include/hw/ppc/xive.h | 27 +++++++++++++----------
>  8 files changed, 97 insertions(+), 131 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index ccbe95a58e..cdde8d0814 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -470,14 +470,13 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
>      return xive->regs[reg >> 3] & PPC_BIT(bit);
>  }
>  
> -static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> -                              uint8_t nvt_blk, uint32_t nvt_idx,
> -                              bool crowd, bool cam_ignore, uint8_t priority,
> -                              uint32_t logic_serv, XiveTCTXMatch *match)
> +static bool pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> +                               uint8_t nvt_blk, uint32_t nvt_idx,
> +                               bool crowd, bool cam_ignore, uint8_t priority,
> +                               uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      PnvXive *xive = PNV_XIVE(xptr);
>      PnvChip *chip = xive->chip;
> -    int count = 0;
>      int i, j;
>  
>      for (i = 0; i < chip->nr_cores; i++) {
> @@ -510,17 +509,18 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                      qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
>                                    "thread context NVT %x/%x\n",
>                                    nvt_blk, nvt_idx);
> -                    return -1;
> +                    match->count++;
> +                    continue;
>                  }
>  
>                  match->ring = ring;
>                  match->tctx = tctx;
> -                count++;
> +                match->count++;
>              }
>          }
>      }
>  
> -    return count;
> +    return !!match->count;
>  }
>  
>  static uint32_t pnv_xive_presenter_get_config(XivePresenter *xptr)
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 96b8851b7e..59b95e5219 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -640,14 +640,13 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
>      return xive->tctxt_regs[reg >> 3] & PPC_BIT(bit);
>  }
>  
> -static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
> -                               uint8_t nvt_blk, uint32_t nvt_idx,
> -                               bool crowd, bool cam_ignore, uint8_t priority,
> -                               uint32_t logic_serv, XiveTCTXMatch *match)
> +static bool pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool crowd, bool cam_ignore, uint8_t priority,
> +                                uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      PnvXive2 *xive = PNV_XIVE2(xptr);
>      PnvChip *chip = xive->chip;
> -    int count = 0;
>      int i, j;
>      bool gen1_tima_os =
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> @@ -692,7 +691,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                                    "thread context NVT %x/%x\n",
>                                    nvt_blk, nvt_idx);
>                      /* Should set a FIR if we ever model it */
> -                    return -1;
> +                    match->count++;
> +                    continue;
>                  }
>                  /*
>                   * For a group notification, we need to know if the
> @@ -717,13 +717,13 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                              }
>                          }
>                      }
> -                    count++;
> +                    match->count++;
>                  }
>              }
>          }
>      }
>  
> -    return count;
> +    return !!match->count;
>  }
>  
>  static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index ce734b03ab..a7475d2f21 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -428,14 +428,13 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
>      g_assert_not_reached();
>  }
>  
> -static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> -                                uint8_t nvt_blk, uint32_t nvt_idx,
> -                                bool crowd, bool cam_ignore,
> -                                uint8_t priority,
> -                                uint32_t logic_serv, XiveTCTXMatch *match)
> +static bool spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> +                                 bool crowd, bool cam_ignore,
> +                                 uint8_t priority,
> +                                 uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      CPUState *cs;
> -    int count = 0;
>  
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -463,16 +462,17 @@ static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>              if (match->tctx) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thread "
>                                "context NVT %x/%x\n", nvt_blk, nvt_idx);
> -                return -1;
> +                match->count++;
> +                continue;
>              }
>  
>              match->ring = ring;
>              match->tctx = tctx;
> -            count++;
> +            match->count++;
>          }
>      }
>  
> -    return count;
> +    return !!match->count;
>  }
>  
>  static uint32_t spapr_xive_presenter_get_config(XivePresenter *xptr)
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index ad30476c17..27b5a21371 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1762,8 +1762,8 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
>      return 1U << (first_zero + 1);
>  }
>  
> -static uint8_t xive_get_group_level(bool crowd, bool ignore,
> -                                    uint32_t nvp_blk, uint32_t nvp_index)
> +uint8_t xive_get_group_level(bool crowd, bool ignore,
> +                             uint32_t nvp_blk, uint32_t nvp_index)
>  {
>      int first_zero;
>      uint8_t level;
> @@ -1881,15 +1881,14 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>   * This is our simple Xive Presenter Engine model. It is merged in the
>   * Router as it does not require an extra object.
>   */
> -bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
> +bool xive_presenter_match(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
>                             bool crowd, bool cam_ignore, uint8_t priority,
> -                           uint32_t logic_serv, bool *precluded)
> +                           uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
> -    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = false };
> -    uint8_t group_level;
> -    int count;
> +
> +    memset(match, 0, sizeof(*match));
>  
>      /*
>       * Ask the machine to scan the interrupt controllers for a match.
> @@ -1914,22 +1913,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>       * a new command to the presenters (the equivalent of the "assign"
>       * power bus command in the documented full notify sequence.
>       */
> -    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
> -                           priority, logic_serv, &match);
> -    if (count < 0) {
> -        return false;
> -    }
> -
> -    /* handle CPU exception delivery */
> -    if (count) {
> -        group_level = xive_get_group_level(crowd, cam_ignore, nvt_blk, nvt_idx);
> -        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
> -    } else {
> -        *precluded = match.precluded;
> -    }
> -
> -    return !!count;
> +    return xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
> +                          priority, logic_serv, match);
>  }
>  
>  /*
> @@ -1966,7 +1951,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>      uint8_t nvt_blk;
>      uint32_t nvt_idx;
>      XiveNVT nvt;
> -    bool found, precluded;
> +    XiveTCTXMatch match;
>  
>      uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
>      uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
> @@ -2046,16 +2031,16 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>          return;
>      }
>  
> -    found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
> -                          false /* crowd */,
> -                          xive_get_field32(END_W7_F0_IGNORE, end.w7),
> -                          priority,
> -                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
> -                          &precluded);
> -    /* we don't support VP-group notification on P9, so precluded is not used */
>      /* TODO: Auto EOI. */
> -
> -    if (found) {
> +    /* we don't support VP-group notification on P9, so precluded is not used */
> +    if (xive_presenter_match(xrtr->xfb, format, nvt_blk, nvt_idx,
> +                             false /* crowd */,
> +                             xive_get_field32(END_W7_F0_IGNORE, end.w7),
> +                             priority,
> +                             xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
> +                             &match)) {
> +        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
> +        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
>          return;
>      }
>  
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ac94193464..6e136ad2e2 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1559,7 +1559,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>      Xive2End end;
>      uint8_t priority;
>      uint8_t format;
> -    bool found, precluded;
> +    XiveTCTXMatch match;
> +    bool crowd, cam_ignore;
>      uint8_t nvx_blk;
>      uint32_t nvx_idx;
>  
> @@ -1629,16 +1630,19 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>       */
>      nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
>      nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
> -
> -    found = xive_presenter_notify(xrtr->xfb, format, nvx_blk, nvx_idx,
> -                          xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
> -                          priority,
> -                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
> -                          &precluded);
> +    crowd = xive2_end_is_crowd(&end);
> +    cam_ignore = xive2_end_is_ignore(&end);
>  
>      /* TODO: Auto EOI. */
> -
> -    if (found) {
> +    if (xive_presenter_match(xrtr->xfb, format, nvx_blk, nvx_idx,
> +                             crowd, cam_ignore, priority,
> +                             xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
> +                             &match)) {
> +        uint8_t group_level;
> +
> +        group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
> +        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
> +        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
>          return;
>      }
>  
> @@ -1656,7 +1660,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>              return;
>          }
>  
> -        if (!xive2_end_is_ignore(&end)) {
> +        if (!cam_ignore) {
>              uint8_t ipb;
>              Xive2Nvp nvp;
>  
> @@ -1685,9 +1689,6 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>          } else {
>              Xive2Nvgc nvgc;
>              uint32_t backlog;
> -            bool crowd;
> -
> -            crowd = xive2_end_is_crowd(&end);
>  
>              /*
>               * For groups and crowds, the per-priority backlog
> @@ -1719,9 +1720,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>              if (backlog == 1) {
>                  XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
>                  xfc->broadcast(xrtr->xfb, nvx_blk, nvx_idx,
> -                               xive2_end_is_crowd(&end),
> -                               xive2_end_is_ignore(&end),
> -                               priority);
> +                               crowd, cam_ignore, priority);
>  
>                  if (!xive2_end_is_precluded_escalation(&end)) {
>                      /*
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index deb29a6389..0c17846b38 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2619,62 +2619,46 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
>      }
>  }
>  
> -static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
> -                         uint8_t nvt_blk, uint32_t nvt_idx,
> -                         bool crowd, bool cam_ignore, uint8_t priority,
> -                         uint32_t logic_serv,
> -                         XiveTCTXMatch *match)
> +static bool pnv_match_nvt(XiveFabric *xfb, uint8_t format,
> +                          uint8_t nvt_blk, uint32_t nvt_idx,
> +                          bool crowd, bool cam_ignore, uint8_t priority,
> +                          uint32_t logic_serv,
> +                          XiveTCTXMatch *match)
>  {
>      PnvMachineState *pnv = PNV_MACHINE(xfb);
> -    int total_count = 0;
>      int i;
>  
>      for (i = 0; i < pnv->num_chips; i++) {
>          Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
>          XivePresenter *xptr = XIVE_PRESENTER(&chip9->xive);
>          XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> -        int count;
>  
> -        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> -                               cam_ignore, priority, logic_serv, match);
> -
> -        if (count < 0) {
> -            return count;
> -        }
> -
> -        total_count += count;
> +        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> +                       cam_ignore, priority, logic_serv, match);
>      }
>  
> -    return total_count;
> +    return !!match->count;
>  }
>  
> -static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> -                                uint8_t nvt_blk, uint32_t nvt_idx,
> -                                bool crowd, bool cam_ignore, uint8_t priority,
> -                                uint32_t logic_serv,
> -                                XiveTCTXMatch *match)
> +static bool pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> +                                 bool crowd, bool cam_ignore, uint8_t priority,
> +                                 uint32_t logic_serv,
> +                                 XiveTCTXMatch *match)
>  {
>      PnvMachineState *pnv = PNV_MACHINE(xfb);
> -    int total_count = 0;
>      int i;
>  
>      for (i = 0; i < pnv->num_chips; i++) {
>          Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>          XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
>          XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> -        int count;
> -
> -        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> -                               cam_ignore, priority, logic_serv, match);
> -
> -        if (count < 0) {
> -            return count;
> -        }
>  
> -        total_count += count;
> +        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> +                       cam_ignore, priority, logic_serv, match);
>      }
>  
> -    return total_count;
> +    return !!match->count;
>  }
>  
>  static int pnv10_xive_broadcast(XiveFabric *xfb,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b0a0f8c689..93574d2a63 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4468,21 +4468,14 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
>  /*
>   * This is a XIVE only operation
>   */
> -static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
> -                           uint8_t nvt_blk, uint32_t nvt_idx,
> -                           bool crowd, bool cam_ignore, uint8_t priority,
> -                           uint32_t logic_serv, XiveTCTXMatch *match)
> +static bool spapr_match_nvt(XiveFabric *xfb, uint8_t format,
> +                            uint8_t nvt_blk, uint32_t nvt_idx,
> +                            bool crowd, bool cam_ignore, uint8_t priority,
> +                            uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(xfb);
>      XivePresenter *xptr = XIVE_PRESENTER(spapr->active_intc);
>      XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> -    int count;
> -
> -    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
> -                           priority, logic_serv, match);
> -    if (count < 0) {
> -        return count;
> -    }
>  
>      /*
>       * When we implement the save and restore of the thread interrupt
> @@ -4493,12 +4486,14 @@ static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
>       * Until this is done, the sPAPR machine should find at least one
>       * matching context always.
>       */
> -    if (count == 0) {
> +    if (!xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
> +                           priority, logic_serv, match)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatched\n",
>                        nvt_blk, nvt_idx);
> +        return false;
>      }
>  
> -    return count;
> +    return true;
>  }
>  
>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 46d05d74fb..8152a9df3d 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -425,6 +425,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
>  
>  typedef struct XiveTCTXMatch {
>      XiveTCTX *tctx;
> +    int count;
>      uint8_t ring;
>      bool precluded;
>  } XiveTCTXMatch;
> @@ -440,10 +441,10 @@ DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
>  
>  struct XivePresenterClass {
>      InterfaceClass parent;
> -    int (*match_nvt)(XivePresenter *xptr, uint8_t format,
> -                     uint8_t nvt_blk, uint32_t nvt_idx,
> -                     bool crowd, bool cam_ignore, uint8_t priority,
> -                     uint32_t logic_serv, XiveTCTXMatch *match);
> +    bool (*match_nvt)(XivePresenter *xptr, uint8_t format,
> +                      uint8_t nvt_blk, uint32_t nvt_idx,
> +                      bool crowd, bool cam_ignore, uint8_t priority,
> +                      uint32_t logic_serv, XiveTCTXMatch *match);
>      bool (*in_kernel)(const XivePresenter *xptr);
>      uint32_t (*get_config)(XivePresenter *xptr);
>      int (*broadcast)(XivePresenter *xptr,
> @@ -455,12 +456,14 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>                                uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint32_t logic_serv);
> -bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
> -                           uint8_t nvt_blk, uint32_t nvt_idx,
> -                           bool crowd, bool cam_ignore, uint8_t priority,
> -                           uint32_t logic_serv, bool *precluded);
> +bool xive_presenter_match(XiveFabric *xfb, uint8_t format,
> +                          uint8_t nvt_blk, uint32_t nvt_idx,
> +                          bool crowd, bool cam_ignore, uint8_t priority,
> +                          uint32_t logic_serv, XiveTCTXMatch *match);
>  
>  uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
> +uint8_t xive_get_group_level(bool crowd, bool ignore,
> +                             uint32_t nvp_blk, uint32_t nvp_index);
>  
>  /*
>   * XIVE Fabric (Interface between Interrupt Controller and Machine)
> @@ -475,10 +478,10 @@ DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
>  
>  struct XiveFabricClass {
>      InterfaceClass parent;
> -    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
> -                     uint8_t nvt_blk, uint32_t nvt_idx,
> -                     bool crowd, bool cam_ignore, uint8_t priority,
> -                     uint32_t logic_serv, XiveTCTXMatch *match);
> +    bool (*match_nvt)(XiveFabric *xfb, uint8_t format,
> +                      uint8_t nvt_blk, uint32_t nvt_idx,
> +                      bool crowd, bool cam_ignore, uint8_t priority,
> +                      uint32_t logic_serv, XiveTCTXMatch *match);
>      int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
>                       bool crowd, bool cam_ignore, uint8_t priority);
>  };


