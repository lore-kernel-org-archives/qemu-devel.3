Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D2FE65D00
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 22:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEG6w-0005jV-Uu; Thu, 21 Nov 2024 17:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tEG6m-0005j5-GL; Thu, 21 Nov 2024 17:57:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tEG6h-0006Zu-Ud; Thu, 21 Nov 2024 17:57:06 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIuott013445;
 Thu, 21 Nov 2024 22:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+BhIXp
 DgyL2LRmBwlm3vnzmKeRsZ381aX4qoy3xXNZU=; b=EyhGEWsYCphC/ov7cXVBXB
 fBR2ECgqFKv2HZHCyckJ4ytCOsz5k8XhfRbmykVIHLLGbr4ufPN4re08OSb54Pns
 K8QE+LiSHzPpQVG5vYj2u284ZYXeQTylQBB2+lNevKJxMmyVpS86Dj/IMabRlDIz
 /CKOTjvcgS7uoAuUIBv5kr5/7YZi1IdKzAZ0W6n/AXWWZOzR47LV/Wi9P8C+Sxje
 bUASu2yTPxWIkK4gf11uuStQfos8oOM2ad53qKimjeLCB8fVQi61x9KyD5cf6i6A
 DN6uH3R8GYJVD4XJIzXTIsts4yoiMwJHgu+wN2bLlacrzKIKlFizjt5pzbWgiJLg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gsv09f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 22:56:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALMulAn019693;
 Thu, 21 Nov 2024 22:56:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gsv09d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 22:56:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGCW1T031179;
 Thu, 21 Nov 2024 22:56:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y5qshqmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 22:56:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ALMujLO46596516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 22:56:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B02958051;
 Thu, 21 Nov 2024 22:56:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E39C15805A;
 Thu, 21 Nov 2024 22:56:44 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2024 22:56:44 +0000 (GMT)
Message-ID: <27562c7a-7b3f-45dc-8bc6-ae61b0eddb3e@linux.ibm.com>
Date: Thu, 21 Nov 2024 16:56:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] ppc/xive2: Support group-matching when looking for
 target
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-4-kowal@linux.ibm.com>
 <D5PTZRBYLRCS.11N2JP4F1R772@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <D5PTZRBYLRCS.11N2JP4F1R772@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kPFXLxU0iZyZRfViCUHvRfckLr-6bHcd
X-Proofpoint-ORIG-GUID: YI2tpMxeNe155aU1fm_fN4j_CkTl-_IL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 11/18/2024 9:22 PM, Nicholas Piggin wrote:
> On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>> If an END has the 'i' bit set (ignore), then it targets a group of
>> VPs. The size of the group depends on the VP index of the target
>> (first 0 found when looking at the least significant bits of the
>> index) so a mask is applied on the VP index of a running thread to
>> know if we have a match.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   include/hw/ppc/xive.h  |  5 +++-
>>   include/hw/ppc/xive2.h |  1 +
>>   hw/intc/pnv_xive2.c    | 33 ++++++++++++++-------
>>   hw/intc/xive.c         | 56 +++++++++++++++++++++++++-----------
>>   hw/intc/xive2.c        | 65 ++++++++++++++++++++++++++++++------------
>>   5 files changed, 114 insertions(+), 46 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 27ef6c1a17..a177b75723 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -424,6 +424,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
>>   typedef struct XiveTCTXMatch {
>>       XiveTCTX *tctx;
>>       uint8_t ring;
>> +    bool precluded;
>>   } XiveTCTXMatch;
>>   
>>   #define TYPE_XIVE_PRESENTER "xive-presenter"
>> @@ -452,7 +453,9 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>>   bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>>                              uint8_t nvt_blk, uint32_t nvt_idx,
>>                              bool cam_ignore, uint8_t priority,
>> -                           uint32_t logic_serv);
>> +                           uint32_t logic_serv, bool *precluded);
>> +
>> +uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
>>   
>>   /*
>>    * XIVE Fabric (Interface between Interrupt Controller and Machine)
>> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
>> index 5bccf41159..17c31fcb4b 100644
>> --- a/include/hw/ppc/xive2.h
>> +++ b/include/hw/ppc/xive2.h
>> @@ -121,6 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>>                                  hwaddr offset, unsigned size);
>>   void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>>                                hwaddr offset, uint64_t value, unsigned size);
>> +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
>>   void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>>                               hwaddr offset, uint64_t value, unsigned size);
>>   void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index 834d32287b..3fb466bb2c 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -660,21 +660,34 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>>                                                      logic_serv);
>>               }
>>   
>> -            /*
>> -             * Save the context and follow on to catch duplicates,
>> -             * that we don't support yet.
>> -             */
>>               if (ring != -1) {
>> -                if (match->tctx) {
>> +                /*
>> +                 * For VP-specific match, finding more than one is a
>> +                 * problem. For group notification, it's possible.
>> +                 */
>> +                if (!cam_ignore && match->tctx) {
>>                       qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
>>                                     "thread context NVT %x/%x\n",
>>                                     nvt_blk, nvt_idx);
>> -                    return false;
>> +                    /* Should set a FIR if we ever model it */
>> +                    return -1;
>> +                }
>> +                /*
>> +                 * For a group notification, we need to know if the
>> +                 * match is precluded first by checking the current
>> +                 * thread priority. If the interrupt can be delivered,
>> +                 * we always notify the first match (for now).
>> +                 */
>> +                if (cam_ignore &&
>> +                    xive2_tm_irq_precluded(tctx, ring, priority)) {
>> +                        match->precluded = true;
>> +                } else {
>> +                    if (!match->tctx) {
>> +                        match->ring = ring;
>> +                        match->tctx = tctx;
>> +                    }
>> +                    count++;
> Multiple matches logic is a bit shoehorned into the match code here.
>
> "Return any best match" would be okay, but match->precluded could be set
> to true for a non-precluded match if a different match was precluded.
> And for VP directed interrupts, we can get a match from here which
> *is* precluded, but has precluded = false!
>
> It's a bit confusing.
>
> typedef struct XiveTCTXMatch {
>      XiveTCTX *tctx;
>      uint8_t ring;
>      bool precluded;
> } XiveTCTXMatch;
>
> What if this was changed to be more clear it doesn't refer to a single
> tctx? Something like -
>
> XiveNVTMatches {
>      XiveTCTX *best_tctx;
>      uint8_t best_ring;
>      int match_count;
>      int precluded_group_match_count;
> }


I'll have to wrap my head around this one... 😳   If I can not figure it 
out, I will et back to you.


>>                   }
>> -
>> -                match->ring = ring;
>> -                match->tctx = tctx;
>> -                count++;
>>               }
>>           }
>>       }
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index bacf518fa6..8ffcac4f65 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1671,6 +1671,16 @@ static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>>       return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
>>   }
>>   
>> +uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
>> +{
>> +    /*
>> +     * Group size is a power of 2. The position of the first 0
>> +     * (starting with the least significant bits) in the NVP index
>> +     * gives the size of the group.
>> +     */
>> +    return 1 << (ctz32(~nvp_index) + 1);
>> +}
>> +
>>   static uint8_t xive_get_group_level(uint32_t nvp_index)
>>   {
>>       /* FIXME add crowd encoding */
>> @@ -1743,30 +1753,39 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>>   /*
>>    * This is our simple Xive Presenter Engine model. It is merged in the
>>    * Router as it does not require an extra object.
>> - *
>> - * It receives notification requests sent by the IVRE to find one
>> - * matching NVT (or more) dispatched on the processor threads. In case
>> - * of a single NVT notification, the process is abbreviated and the
>> - * thread is signaled if a match is found. In case of a logical server
>> - * notification (bits ignored at the end of the NVT identifier), the
>> - * IVPE and IVRE select a winning thread using different filters. This
>> - * involves 2 or 3 exchanges on the PowerBus that the model does not
>> - * support.
>> - *
>> - * The parameters represent what is sent on the PowerBus
>>    */
>>   bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>>                              uint8_t nvt_blk, uint32_t nvt_idx,
>>                              bool cam_ignore, uint8_t priority,
>> -                           uint32_t logic_serv)
>> +                           uint32_t logic_serv, bool *precluded)
>>   {
>>       XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
>> -    XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
>> +    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = false };
>>       uint8_t group_level;
>>       int count;
>>   
>>       /*
>> -     * Ask the machine to scan the interrupt controllers for a match
>> +     * Ask the machine to scan the interrupt controllers for a match.
>> +     *
>> +     * For VP-specific notification, we expect at most one match and
>> +     * one call to the presenters is all we need (abbreviated notify
>> +     * sequence documented by the architecture).
>> +     *
>> +     * For VP-group notification, match_nvt() is the equivalent of the
>> +     * "histogram" and "poll" commands sent to the power bus to the
>> +     * presenters. 'count' could be more than one, but we always
>> +     * select the first match for now. 'precluded' tells if (at least)
>> +     * one thread matches but can't take the interrupt now because
>> +     * it's running at a more favored priority. We return the
>> +     * information to the router so that it can take appropriate
>> +     * actions (backlog, escalation, broadcast, etc...)
>> +     *
>> +     * If we were to implement a better way of dispatching the
>> +     * interrupt in case of multiple matches (instead of the first
>> +     * match), we would need a heuristic to elect a thread (for
>> +     * example, the hardware keeps track of an 'age' in the TIMA) and
>> +     * a new command to the presenters (the equivalent of the "assign"
>> +     * power bus command in the documented full notify sequence.
>>        */
>>       count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
>>                              priority, logic_serv, &match);
>> @@ -1779,6 +1798,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>>           group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
>>           trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
>>           xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
>> +    } else {
>> +        *precluded = match.precluded;
>>       }
>>   
>>       return !!count;
>> @@ -1818,7 +1839,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>>       uint8_t nvt_blk;
>>       uint32_t nvt_idx;
>>       XiveNVT nvt;
>> -    bool found;
>> +    bool found, precluded;
>>   
>>       uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
>>       uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
>> @@ -1901,8 +1922,9 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>>       found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
>>                             xive_get_field32(END_W7_F0_IGNORE, end.w7),
>>                             priority,
>> -                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7));
>> -
>> +                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
>> +                          &precluded);
>> +    /* we don't support VP-group notification on P9, so precluded is not used */
>>       /* TODO: Auto EOI. */
>>   
>>       if (found) {
>> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index db372f4b30..2cb03c758e 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
>>      return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
>>   }
>>   
>> +static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
>> +                                uint32_t vp_mask)
>> +{
>> +    return (cam1 & vp_mask) == (cam2 & vp_mask);
>> +}
>> +
>>   /*
>>    * The thread context register words are in big-endian format.
>>    */
>> @@ -753,44 +759,50 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>>       uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>>       uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
>>   
>> -    /*
>> -     * TODO (PowerNV): ignore mode. The low order bits of the NVT
>> -     * identifier are ignored in the "CAM" match.
>> -     */
>> +    uint32_t vp_mask = 0xFFFFFFFF;
>>   
>>       if (format == 0) {
>> -        if (cam_ignore == true) {
>> -            /*
>> -             * F=0 & i=1: Logical server notification (bits ignored at
>> -             * the end of the NVT identifier)
>> -             */
>> -            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\n",
>> -                          nvt_blk, nvt_idx);
>> -            return -1;
>> +        /*
>> +         * i=0: Specific NVT notification
>> +         * i=1: VP-group notification (bits ignored at the end of the
>> +         *      NVT identifier)
>> +         */
>> +        if (cam_ignore) {
>> +            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
>>           }
>>   
>> -        /* F=0 & i=0: Specific NVT notification */
>> +        /* For VP-group notifications, threads with LGS=0 are excluded */
>>   
>>           /* PHYS ring */
>>           if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
>> -            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
>> +            !(cam_ignore && tctx->regs[TM_QW3_HV_PHYS + TM_LGS] == 0) &&
>> +            xive2_vp_match_mask(cam,
>> +                                xive2_tctx_hw_cam_line(xptr, tctx),
>> +                                vp_mask)) {
>>               return TM_QW3_HV_PHYS;
>>           }
>>   
>>           /* HV POOL ring */
>>           if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
>> -            cam == xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
>> +            !(cam_ignore && tctx->regs[TM_QW2_HV_POOL + TM_LGS] == 0) &&
>> +            xive2_vp_match_mask(cam,
>> +                                xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2),
>> +                                vp_mask)) {
>>               return TM_QW2_HV_POOL;
>>           }
>>   
>>           /* OS ring */
>>           if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>> -            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
>> +            !(cam_ignore && tctx->regs[TM_QW1_OS + TM_LGS] == 0) &&
>> +            xive2_vp_match_mask(cam,
>> +                                xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2),
>> +                                vp_mask)) {
>>               return TM_QW1_OS;
>>           }
>>       } else {
>>           /* F=1 : User level Event-Based Branch (EBB) notification */
>>   
>> +        /* FIXME: what if cam_ignore and LGS = 0 ? */
>>           /* USER ring */
>>           if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>>                (cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
>> @@ -802,6 +814,22 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>>       return -1;
>>   }
>>   
>> +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>> +{
>> +    uint8_t *regs = &tctx->regs[ring];
>> +
>> +    /*
>> +     * The xive2_presenter_tctx_match() above tells if there's a match
>> +     * but for VP-group notification, we still need to look at the
>> +     * priority to know if the thread can take the interrupt now or if
>> +     * it is precluded.
>> +     */
>> +    if (priority < regs[TM_CPPR]) {
> Should this also test PIPR?
>
> I'm not sure about CPPR and PIPR relationship exactly. Does hardware
> set PIPR for pending IPB interrupts even if they are not < CPPR? Or
> does it always reflect the presented interrupt


I am not sure.  I will dig into the simulation models, and the 
architecture process flows which they followed, and find out.


>
> Thanks,
> Nick

