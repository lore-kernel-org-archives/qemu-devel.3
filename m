Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE6C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaw7-00040x-PA; Thu, 15 May 2025 11:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFavT-0003PV-2m; Thu, 15 May 2025 11:55:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFavP-0007VA-7M; Thu, 15 May 2025 11:55:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4q0002206;
 Thu, 15 May 2025 15:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=QwMOv+uFWdOgLZJ74lPnSVHDBpS1xTm0xX6o36CoWhY=; b=TZU7kAvIZ6V1
 1PIFRmuFGhJj1pIO3qpT8JPlPBOZCEzMJkYbmum/oJFfkCPV9GFbjkxsjRsx6prR
 ChbFFlpBpruOr6BOTkYGe4IG+NfPhPdg1urRqafjBQo6mYLQ9UR7l85WFAilM3dt
 HGSklsoHfJihTBjCVZQ85R/KHu4R46QcelqTN0HMUjLIFO8AeyzEE3tlL05JkZl3
 gcH/v8B38Pgoq4Ya16HkefEXrh97qzliOhkWTL2IbodoJbOJlWchM7Jc490tnoMQ
 BksYaMM2i7R4E940VF+/VhlzN1pBSUvOd8jPdgr/altRmQEGosZg8lA+1gOW3klo
 R4BtKrIxoQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nfau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFplBf031581;
 Thu, 15 May 2025 15:55:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nfar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEDhDV021797;
 Thu, 15 May 2025 15:55:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu2uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFt6cN26018468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:55:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EDD55804B;
 Thu, 15 May 2025 15:55:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8116D58067;
 Thu, 15 May 2025 15:55:05 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:55:05 +0000 (GMT)
Message-ID: <fe6a147f21b64736a4ff99f239b1c11cae440c8f.camel@linux.ibm.com>
Subject: Re: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present
 new interrupt
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:55:05 -0500
In-Reply-To: <20250512031100.439842-31-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-31-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260e5c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=MpkC5fjVok2ZSxuvMYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SpYhKmFY7MlTz0Uv46b8whzO3DHFvKS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX7ON1DfYY1Amb
 STFB7kVMahRZKoorttzzxu9TSIXFHO8O0c695xflfNYeAWAVF+wCXVyU+eR38A8ZgNpnOA/XQnF
 A7H5siqaB43enuYOvGwTxY64Wb3U99H+Z/zC/4DqX6CqAXMm+nJxnTpkWB34EM92V5ObiWOyTvr
 MtvT5icK+MDP2iQ3xi1VudLVQiLLkE6yGiOInPou1ZX7w7cgisg7SNDzoRl3CZF/NepgvPvSHm3
 60cTnm+Y3kKh0pYUN+XDy7umUqqiLNHRNjFxqQaoFzamQpTU38EbsOuctmL+KezXd2HyVyahPxk
 gK/hOd9r9AWOEsF8WOQt6Hb37Y59iUQP3mqS99zWJCBjgWzzr4eSni3dIbfBqMNT8N5pMkca+PE
 vKEjxEYQubkh3r+yjXyZAHJR5n30IgNyl6lDosZFO49Ty/7AD8YTSLs89abB2GUl4AjTxPyz
X-Proofpoint-GUID: qIXQt6aKphtlXnqQd0-ibY43Qh2Jh5Mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=860 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> xive_tctx_pipr_update() is used for multiple things. In an effort
> to make things simpler and less overloaded, split out the function
> that is used to present a new interrupt to the tctx.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c        | 8 +++++++-
>  hw/intc/xive2.c       | 2 +-
>  include/hw/ppc/xive.h | 2 ++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 27b5a21371..bf4c0634ca 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>      xive_tctx_notify(tctx, ring, group_level);
>   }
>  
> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> +                            uint8_t group_level)
> +{
> +    xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +}
> +
>  /*
>   * XIVE Thread Interrupt Management Area (TIMA)
>   */
> @@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>                               xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
>                               &match)) {
>          trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
> +        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
>          return;
>      }
>  
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index cae4092198..f91109b84a 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>  
>          group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
>          trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
> -        xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +        xive_tctx_pipr_present(tctx, ring, priority, group_level);
>          return;
>      }
>  
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 8152a9df3d..0d6b11e818 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
>  void xive_tctx_destroy(XiveTCTX *tctx);
>  void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                             uint8_t group_level);
> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> +                            uint8_t group_level);
>  void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>  void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
>  uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);


