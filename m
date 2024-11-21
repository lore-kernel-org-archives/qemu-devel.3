Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F04E65D03
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 23:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEGW0-0003WM-5G; Thu, 21 Nov 2024 18:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tEGVy-0003VB-Cz; Thu, 21 Nov 2024 18:23:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tEGVw-00029x-HP; Thu, 21 Nov 2024 18:23:10 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALLtMZ8003815;
 Thu, 21 Nov 2024 23:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F7K2xp
 52VNHc2GIiMAAMHy6cfVuVwS+xhbJ/h7/v65s=; b=dD+8JuKHdl2EvkO67SayS2
 QG3Ob0uPXtdwiTrowAs1HCNbp5ODWya7nFzvWTqKB+zvvAwEYPNpY96RMgxNmVYn
 qYX4p8yYeF6zx3iO/YwJKjn/f1hIdD2mu3JXzyfLqU0bVGYgVPTeIjD+J111xPT0
 aydzN7AtggfhZe98DwHRqXPCG9YgX1OmnjWpGi/VF4GrfPGQA4ALEJNn1VXpUaGr
 4oeRrxVtdmGnGwnFIGdjLYJFv2ZXkEwLcTEk4Pmr4rbl3cH8Spuqvv5gmNmwv2Vt
 Ldvb2oFJfwEegJBvfwRVaV70W/koYu2wm/0yN7AZ0NQRh+X1x4HESQEjjxkl9o3Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk5gy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 23:22:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALNMpih001051;
 Thu, 21 Nov 2024 23:22:51 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk5gy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 23:22:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALH7XqM024618;
 Thu, 21 Nov 2024 23:22:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1hkx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 23:22:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ALNMmcN1770184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 23:22:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A42C95805C;
 Thu, 21 Nov 2024 23:22:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D2C658051;
 Thu, 21 Nov 2024 23:22:48 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2024 23:22:48 +0000 (GMT)
Message-ID: <d2c62c98-913a-4942-b04e-f4d66a4898e6@linux.ibm.com>
Date: Thu, 21 Nov 2024 17:22:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] pnv/xive: Support ESB Escalation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-13-kowal@linux.ibm.com>
 <D5PW2UNAEQY8.3J5OIED7DU3AQ@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <D5PW2UNAEQY8.3J5OIED7DU3AQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YBE6zkWXbZ212fY0DbJzJshOSJYBvU6v
X-Proofpoint-GUID: 9dNDGjGVGVpJ_Zd0CIHCNULja2Kc--to
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411210174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 11/18/2024 11:00 PM, Nicholas Piggin wrote:
> On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
>> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>>
>> END notification processing has an escalation path.  The escalation is
>> not always an END escalation but can be an ESB escalation.
>>
>> Also added a check for 'resume' processing which log a message stating it
>> needs to be implemented.  This is not needed at the time but is part of
>> the END notification processing.
> This patch is orthogonal to group support, right?


Sort of... Yes... When we decided to upstream the commits in 'like' 
groups,  many of the commits are out of order.  And some were too 
difficult to backport to older code.  I thinks was one of those.


>> This change was taken from a patch provided by Michael Kowal
>>
>> Suggested-by: Michael Kowal <kowal@us.ibm.com>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   include/hw/ppc/xive2.h      |  1 +
>>   include/hw/ppc/xive2_regs.h | 13 +++++---
>>   hw/intc/xive2.c             | 61 +++++++++++++++++++++++++++++--------
>>   3 files changed, 58 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
>> index 37aca4d26a..b17cc21ca6 100644
>> --- a/include/hw/ppc/xive2.h
>> +++ b/include/hw/ppc/xive2.h
>> @@ -82,6 +82,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
>>   uint32_t xive2_router_get_config(Xive2Router *xrtr);
>>   
>>   void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
>> +void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
>>   
>>   /*
>>    * XIVE2 Presenter (POWER10)
>> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
>> index 89236b9aaf..42cdc91452 100644
>> --- a/include/hw/ppc/xive2_regs.h
>> +++ b/include/hw/ppc/xive2_regs.h
>> @@ -40,15 +40,18 @@
>>   
>>   typedef struct Xive2Eas {
>>           uint64_t       w;
>> -#define EAS2_VALID                 PPC_BIT(0)
>> -#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ block# */
>> -#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ index */
>> -#define EAS2_MASKED                PPC_BIT(32) /* Masked                 */
>> -#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the EQ */
>> +#define EAS2_VALID         PPC_BIT(0)
>> +#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(unimp) */
>> +#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
>> +#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# */
>> +#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index */
>> +#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
>> +#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
>>   } Xive2Eas;
>>   
>>   #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
>>   #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
>> +#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
>>   
>>   void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
>>   
>> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index 41d689eaab..f812ba9624 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -1511,18 +1511,39 @@ do_escalation:
>>           }
>>       }
>>   
>> -    /*
>> -     * The END trigger becomes an Escalation trigger
>> -     */
>> -    xive2_router_end_notify(xrtr,
>> -                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
>> -                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
>> -                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
>> +    if (xive2_end_is_escalate_end(&end)) {
>> +        /*
>> +         * Perform END Adaptive escalation processing
>> +         * The END trigger becomes an Escalation trigger
>> +         */
>> +        xive2_router_end_notify(xrtr,
>> +                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
>> +                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
>> +                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
>> +    } /* end END adaptive escalation */
>> +
>> +    else {
>> +        uint32_t lisn;              /* Logical Interrupt Source Number */
>> +
>> +        /*
>> +         *  Perform ESB escalation processing
>> +         *      E[N] == 1 --> N
>> +         *      Req[Block] <- E[ESB_Block]
>> +         *      Req[Index] <- E[ESB_Index]
>> +         *      Req[Offset] <- 0x000
>> +         *      Execute <ESB Store> Req command
>> +         */
>> +        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
>> +                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
>> +
>> +        xive2_notify(xrtr, lisn, true /* pq_checked */);
>> +    }
>> +
>> +    return;
> Don't need returns at the end of void functions.


Does it "hurt" anything?  I am old-school and was taught to always put 
in a return at the end of a function.


>
>>   }
>>   
>> -void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>> +void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
> Can it be static?


I think so....


>
> Thanks,
> Nick
>
>>   {
>> -    Xive2Router *xrtr = XIVE2_ROUTER(xn);
>>       uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
>>       uint32_t eas_idx = XIVE_EAS_INDEX(lisn);
>>       Xive2Eas eas;
>> @@ -1565,13 +1586,29 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>>           return;
>>       }
>>   
>> +    /* TODO: add support for EAS resume if ever needed */
>> +    if (xive2_eas_is_resume(&eas)) {
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "XIVE: EAS resume processing unimplemented - LISN %x\n",
>> +                      lisn);
>> +        return;
>> +    }
>> +
>>       /*
>>        * The event trigger becomes an END trigger
>>        */
>>       xive2_router_end_notify(xrtr,
>> -                             xive_get_field64(EAS2_END_BLOCK, eas.w),
>> -                             xive_get_field64(EAS2_END_INDEX, eas.w),
>> -                             xive_get_field64(EAS2_END_DATA,  eas.w));
>> +                            xive_get_field64(EAS2_END_BLOCK, eas.w),
>> +                            xive_get_field64(EAS2_END_INDEX, eas.w),
>> +                            xive_get_field64(EAS2_END_DATA,  eas.w));
>> +}
>> +
>> +void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>> +{
>> +    Xive2Router *xrtr = XIVE2_ROUTER(xn);
>> +
>> +    xive2_notify(xrtr, lisn, pq_checked);
>> +    return;
>>   }
>>   
>>   static Property xive2_router_properties[] = {

