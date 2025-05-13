Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnyc-0005ac-Me; Tue, 13 May 2025 07:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnyF-0005Xw-AA; Tue, 13 May 2025 07:38:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnyB-0000wg-83; Tue, 13 May 2025 07:38:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1OUM7001465;
 Tue, 13 May 2025 11:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Dd+lPH
 LixyPQOsfEDYLqZhEqB9aMJGUX+DY3DINkRb4=; b=CFQUpvvPR2hTut2Zayk3wk
 f4LCkdwx6wePdzTvm7nvmJIzs1Y09lnMErHagHGrcGKKzw5n6GDb1YFktEr0nAab
 2lFMsT35bfJHY3zmVEUYvx3g9ERUHzb238xjaI9ig5pXVx8ELvqTcCqVpy5bxmPI
 3+Ooy+Ielml/pjB8GOq6EhmB/i1DKi7oxyMNTd1PmTJqDE26lIjShGNQov0Wp5Jh
 CwDxcSHebwZGKWuRBKN7RTAvLQUXBkYOaV/msmhgmvsFTI5QvCOosN5qmtYpww0h
 B+UNG19/Q5eysMoEVKLx9AkoodyxjbG15pmSLe7ATdjFx6a9Uj1BmouLgocbbVVA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75dd1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:38:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBFXPL011537;
 Tue, 13 May 2025 11:38:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku2ah3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:38:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DBchsw28377620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 11:38:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86F305805D;
 Tue, 13 May 2025 11:38:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DA7758054;
 Tue, 13 May 2025 11:38:42 +0000 (GMT)
Received: from [9.61.132.237] (unknown [9.61.132.237])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 11:38:42 +0000 (GMT)
Message-ID: <b747e9c1-b951-42be-89c3-ee3594517667@linux.ibm.com>
Date: Tue, 13 May 2025 07:38:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250512180230.50129-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMCBTYWx0ZWRfX7/TPxWzxRer4
 HtikKDZMLyOcYppeR0eU4eIz5XxzjhwqkYnbosnjIB13o4s8fh/gEMpB7ZMzn2qvtdDP6PugxC7
 FuBBsQE+Mvtkd2zeOFuy9dJQITfkB2gBAyjQ1c+aDKN5ZrCCzAD6NWagTQaDsUDB+3mjF93HU3i
 xNkGJEzZtqAmTFUCR685+SNGJ3bleh/dotxRhnUvTO430TMAvHTTSYKO3o148T9k4gWbic2c5nm
 LRqe3aWqpkM4O+u5KznvcGk8uhxZh7WjS8lAmfy4eYwEUFUPqwvkvV9rqlNauX8e4Fr5YTmwOsc
 CctLS7S0Xd9zNGwkUdOWG/2ZdCMlnM+psAHKhsFSQdDAmbNZBPjaXSaFTJ5k3s1iiddNW+S0C4d
 uDvlk9FXlMAISit6gsM2xApybiKABYnJXwNm/i+Lltv6EAvnYN9355Y7cQBp8V9Dz0x5PA/Z
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=68232f45 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=Kxg3JkpTSJxiqckDq54A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: salUNn-FSoWwhRDO8m_6xa81FxlBGoik
X-Proofpoint-GUID: salUNn-FSoWwhRDO8m_6xa81FxlBGoik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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




On 5/12/25 2:02 PM, Rorie Reyes wrote:
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>   2 files changed, 61 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 5ea5dd9cca..4f88f80c54 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    APConfigChgEvent *cfg_chg_event;
> +
> +    if (!ap_chsc_sei_nt0_have_event()) {
> +        return 1;
> +    }
> +
> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +
> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +    g_free(cfg_chg_event);
> +
> +    /*
> +     * If there are any AP configuration change events in the queue,
> +     * indicate to the caller that there is pending event info in
> +     * the response block
> +     */
> +    if (ap_chsc_sei_nt0_have_event()) {
> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +    }
> +
> +    nt0_res->length = sizeof(ChscSeiNt0Res);
> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
> +
> +    return 0;
> +
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..f4d838bf99 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,26 @@
>   
>   void s390_init_ap(void);
>   
> +typedef struct ChscSeiNt0Res {
> +    uint16_t length;
> +    uint16_t code;
> +    uint8_t reserved1;
> +    uint16_t reserved2;
> +    uint8_t nt;
> +#define PENDING_EVENT_INFO_BITMASK 0x80;
> +    uint8_t flags;
> +    uint8_t reserved3;
> +    uint8_t rs;
> +    uint8_t cc;
> +} QEMU_PACKED ChscSeiNt0Res;
> +
> +#define NT0_RES_RESPONSE_CODE 1;
> +#define NT0_RES_NT_DEFAULT    0;
> +#define NT0_RES_RS_AP_CHANGE  5;
> +#define NT0_RES_CC_AP_CHANGE  3;
> +
> +int ap_chsc_sei_nt0_get_event(void *res);
> +
> +int ap_chsc_sei_nt0_have_event(void);
> +
>   #endif


