Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D653FA375F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8ZQ-0004Hz-0I; Fri, 13 Sep 2024 11:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8ZN-0004F1-9P; Fri, 13 Sep 2024 11:50:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8ZL-0003cF-3R; Fri, 13 Sep 2024 11:50:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D8HwNY032547;
 Fri, 13 Sep 2024 15:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Y
 I+cNmB51Im7A9WfI+0x59j+33ZyPVK1YR4VpQJzDQk=; b=qXhmNfKvc5g0SNpys
 h6DBGOnsV/2JZQQ6d8nwQ4rTLz2Hf81KjsP6RTgzE+4aMowMLso93KqQjEmxULqo
 6TZpKYq81eIZ/u4VCI7NBYQl05edUg27ccDIJ0/zKUcUqc4Ufw1+hhV+eOuocZIv
 wkk4KhcGc2TATQQ2l71jM/L5jybqocpU204CrQ1NdbWy1eg23uk9eyPFPYU6ljwL
 zCvY3aVXdrEZctflOCz1VT5kSDnxVROytaqAElUXR+5aI0V/hbnS/pw2pSyXr7VD
 4FPdAxokuIOGvUeD2gOuXXrr605ormhSyJzcBLRL3Ta86xUA1/7/qqdhIGTiTar+
 FC+1Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb46q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 15:50:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DFoZRa007475;
 Fri, 13 Sep 2024 15:50:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb46j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 15:50:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DF0Ue8019899;
 Fri, 13 Sep 2024 15:50:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25qf578-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 15:50:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DFoXWu66388298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 15:50:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A26C658054;
 Fri, 13 Sep 2024 15:50:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D83458045;
 Fri, 13 Sep 2024 15:50:33 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 15:50:33 +0000 (GMT)
Message-ID: <efe8dcbd-9565-404e-b957-2de7ddfb6f90@linux.ibm.com>
Date: Fri, 13 Sep 2024 10:50:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] ppc/xive2: Change context/ring specific
 functions to be generic
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240912205028.15854-1-kowal@linux.ibm.com>
 <20240912205028.15854-10-kowal@linux.ibm.com>
 <121cb7c6-bd37-44fe-8d69-d33d1efa1643@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <121cb7c6-bd37-44fe-8d69-d33d1efa1643@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fMoczegM_8UtpX9eDrkrr2oykWnAlNFs
X-Proofpoint-ORIG-GUID: t4m8e_QxHs2hookSJfuChsfCh1PIxsnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/13/2024 8:10 AM, Cédric Le Goater wrote:
> On 9/12/24 22:50, Michael Kowal wrote:
>> Some the functions that have been created are specific to a ring or 
>> context. Some
>> of these same functions are being changed to operate on any 
>> ring/context. This  will
>> simplify the next patch sets that are adding additional ring/context 
>> operations.
>>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   include/hw/ppc/xive.h |  2 +-
>>   hw/intc/xive.c        |  6 +++---
>>   hw/intc/xive2.c       | 23 ++++++++++++-----------
>>   3 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 28c181faa2..31242f0406 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -533,7 +533,7 @@ Object *xive_tctx_create(Object *cpu, 
>> XivePresenter *xptr, Error **errp);
>>   void xive_tctx_reset(XiveTCTX *tctx);
>>   void xive_tctx_destroy(XiveTCTX *tctx);
>>   void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
>> -void xive_tctx_reset_os_signal(XiveTCTX *tctx);
>> +void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>>     /*
>>    * KVM XIVE device helpers
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 5b66a3aec5..f1d007d9a6 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -114,7 +114,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, 
>> uint8_t ring)
>>       }
>>   }
>>   -void xive_tctx_reset_os_signal(XiveTCTX *tctx)
>> +void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
>>   {
>>       /*
>>        * Lower the External interrupt. Used when pulling an OS
>> @@ -122,7 +122,7 @@ void xive_tctx_reset_os_signal(XiveTCTX *tctx)
>>        * context. It should be raised again when re-pushing the OS
>>        * context.
>>        */
>> -    qemu_irq_lower(xive_tctx_output(tctx, TM_QW1_OS));
>> +    qemu_irq_lower(xive_tctx_output(tctx, ring));
>>   }
>>     static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, 
>> uint8_t cppr)
>> @@ -424,7 +424,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter 
>> *xptr, XiveTCTX *tctx,
>>       qw1w2_new = xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
>>       xive_tctx_set_os_cam(tctx, qw1w2_new);
>>   -    xive_tctx_reset_os_signal(tctx);
>> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
>>       return qw1w2;
>>   }
>>   diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index 8d3d69a0db..ad8b8729ed 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -270,13 +270,14 @@ static void xive2_end_enqueue(Xive2End *end, 
>> uint32_t data)
>>    *     the NVP by changing the H bit while the context is enabled
>>    */
>>   -static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>> -                                   uint8_t nvp_blk, uint32_t nvp_idx)
>> +static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>> +                                uint8_t nvp_blk, uint32_t nvp_idx,
>> +                                uint8_t ring)
>>   {
>>       CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>>       uint32_t pir = env->spr_cb[SPR_PIR].default_value;
>>       Xive2Nvp nvp;
>> -    uint8_t *regs = &tctx->regs[TM_QW1_OS];
>> +    uint8_t *regs = &tctx->regs[ring];
>>         if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
>> @@ -321,13 +322,13 @@ static void xive2_tctx_save_os_ctx(Xive2Router 
>> *xrtr, XiveTCTX *tctx,
>>       xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
>>   }
>>   -static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
>> -                                uint32_t *nvp_idx, bool *vo, bool *ho)
>> +static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
>> +                             uint32_t *nvp_idx, bool *valid, bool *hw)
>>   {
>>       *nvp_blk = xive2_nvp_blk(cam);
>>       *nvp_idx = xive2_nvp_idx(cam);
>> -    *vo = !!(cam & TM2_QW1W2_VO);
>> -    *ho = !!(cam & TM2_QW1W2_HO);
>> +    *valid = !!(cam & TM2_QW1W2_VO);
>> +    *hw = !!(cam & TM2_QW1W2_HO);
>
> This change belongs to another patch. Anyhow,
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>

Shoot, sorry about that.  I must have messed up the rebase.   The 
changes are in patch set 10.

MAK


>
>
>>   }
>>     @@ -363,7 +364,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter 
>> *xptr, XiveTCTX *tctx,
>>       bool vo;
>>       bool do_save;
>>   -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
>> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
>>         if (!vo) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP 
>> %x/%x !?\n",
>> @@ -375,10 +376,10 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter 
>> *xptr, XiveTCTX *tctx,
>>       memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
>>         if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && 
>> do_save) {
>> -        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
>> +        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
>>       }
>>   -    xive_tctx_reset_os_signal(tctx);
>> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
>>       return qw1w2;
>>   }
>>   @@ -573,7 +574,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, 
>> XiveTCTX *tctx,
>>       bool vo;
>>       bool do_restore;
>>   -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
>> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
>>         /* First update the thead context */
>>       memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
>

