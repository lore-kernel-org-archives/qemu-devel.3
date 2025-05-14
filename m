Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1889BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIRN-0001tj-Sb; Wed, 14 May 2025 16:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFIRC-0001l4-Sn; Wed, 14 May 2025 16:10:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFIRA-0004o5-Fg; Wed, 14 May 2025 16:10:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoPuF031302;
 Wed, 14 May 2025 20:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wcguke
 vfjojovwa4tl0SWAC6WPU5fHF30KVYOMfZSxc=; b=VO22XPQRvyOY7Dm1HJNnD1
 th4izkMHgrUDQrSSkOllMRgHpakyvdWxDkmg/USrBYSsrOtPhS8qPuMTBGu5VP9T
 HexGB/D4G6DzsB/nbMljyLaQ4wPRifQVaiSmsKU0CpgzMOAlT0Xf6Ioxk5YFxSMy
 tx5NTFXiFsVTT8j9vOtjxG1spXkVQeValaYP8AxSft+PtqBsuBh4rmtlGbcE4pVv
 BNQQkZqkl3rgGwuRPTpirNG0bwE7TJ1mDyuXP1wW0w9ct2RvcZQ2gdsRlgP8nC6+
 Wh9HH5djkMx2gVSil5KTH7WgrVy5PgCt4rwhMVmOuzGPUovYPLV4j7poI0T/C1Iw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98es5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:10:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EK08FU022412;
 Wed, 14 May 2025 20:10:39 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98es2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:10:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJWQRV015484;
 Wed, 14 May 2025 20:10:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpxarh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:10:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EKAb1U19530354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 20:10:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56F7E5804E;
 Wed, 14 May 2025 20:10:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0E175803F;
 Wed, 14 May 2025 20:10:36 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 20:10:36 +0000 (GMT)
Message-ID: <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
Date: Wed, 14 May 2025 15:10:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present
 new interrupt
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-31-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-31-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824f8c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=AG6QrMBwpTDLHSJwIVYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4NSBTYWx0ZWRfX+SxBNQlJm7I9
 Ykuei+ym6hcd8sxnp1R3lK/dxmpMM17cen9FDKbm0icS/UxMFHR9+/cHqNSvD3DiLHmwF1fopwc
 zZvhouhsQ94obfcUekm8o9uwbhYHSZEALXo9b6PwLGIYVIGQzOqBgqplnhRTn9kcAZ1fxYGxqHu
 3y2/9NIMZwx3zLqk6LKVFmRvxDbdSzdlpWzZDbmq6WdAPy8CEsAUJOGAwo4iw3OiB4udb1748Gw
 yfQFmqjk+LHQJrO/ls28d7EXsJUWY72wVHFbpCq8cwkdzFypsau4Bis52E5d/35NOzpR7dTQiPe
 cuj3OWbOdPZ/QVJCwLfMcwW+SJUT+23UkxyMf3g1X9xEHlbyG9Bj8OoZiXdU3b/3+fM8XHdquG2
 QEDUPP5CYzmaRrU+osR2PtvTZIBKQifMYLNFVwxuqjL/7yLvX2BKOAyajZTioW7E/dvwKmvW
X-Proofpoint-ORIG-GUID: 9goAHLcJkcuh-j2jmxZ76cZTPV2yQHks
X-Proofpoint-GUID: VCSJDGTpFEb4vw3l4VHu3A1EZbzm3Hee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=964 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140185
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
> xive_tctx_pipr_update() is used for multiple things. In an effort
> to make things simpler and less overloaded, split out the function
> that is used to present a new interrupt to the tctx.


Why is this a separate commit fro 30?   The change here does not do 
anything different.
Regardless, taken this patch set as a whole, it's good by me.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c        | 8 +++++++-
>   hw/intc/xive2.c       | 2 +-
>   include/hw/ppc/xive.h | 2 ++
>   3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 27b5a21371..bf4c0634ca 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>       xive_tctx_notify(tctx, ring, group_level);
>    }
>   
> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> +                            uint8_t group_level)
> +{
> +    xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +}
> +
>   /*
>    * XIVE Thread Interrupt Management Area (TIMA)
>    */
> @@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>                                xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
>                                &match)) {
>           trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
> +        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
>           return;
>       }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index cae4092198..f91109b84a 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>   
>           group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
>           trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
> -        xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +        xive_tctx_pipr_present(tctx, ring, priority, group_level);
>           return;
>       }
>   
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 8152a9df3d..0d6b11e818 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
>   void xive_tctx_destroy(XiveTCTX *tctx);
>   void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                              uint8_t group_level);
> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> +                            uint8_t group_level);
>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>   void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
>   uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);

