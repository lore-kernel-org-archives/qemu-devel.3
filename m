Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D74D59D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6rV-0003Hq-D6; Fri, 12 Dec 2025 12:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6rT-0003GV-BH; Fri, 12 Dec 2025 12:23:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6rQ-0002xj-OJ; Fri, 12 Dec 2025 12:23:22 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCAo1kk008714;
 Fri, 12 Dec 2025 17:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=YI+hUey3lCt5HdFioKcBKHpJLxAlSByoD1phzd9tk3w=; b=NCl+8sfTzk32
 c3PsTivWaUgCmblZcZXCe9nmmo0B8Rx+TA+vsIDmo9ckZHvSLdWM+LsSGnPWxKoK
 KNuyK4qgqRiVIDh+3O03imjlGjGm54hh8/soA7kSMhV1t1AJnkwAScNOboYeyZg9
 DvwQd1Et0RZ+Kz37wCLwzewija1A6bq9lFDs7VZ+618xUeVV+G11tWy/Fj8n2v9U
 YE9zAcgxKwI4WHIC+5+b4RWvmeYCjzFhWrqDzzG0V4+7w8G8ITyDPgYQQiHW5l4v
 TodPm/tMch1wKOt83r6SoLAoB4MkmGfWL/JqPDZISF804/X0pfZErL73nKpcAKzi
 L6XN3JSYLw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kep3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:23:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCH0RpD012439;
 Fri, 12 Dec 2025 17:23:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kep3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:23:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCGkG6O028119;
 Fri, 12 Dec 2025 17:23:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6yd7xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:23:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHNDFn7733774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:23:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67BF25805D;
 Fri, 12 Dec 2025 17:23:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B7165805A;
 Fri, 12 Dec 2025 17:23:12 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:23:12 +0000 (GMT)
Message-ID: <fbdc008b8adc4f49a884e877697733252e312092.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] hw/ppc: pnv_core.c add vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:23:12 -0600
In-Reply-To: <20251211220926.2865972-6-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-6-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693c4f84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=zN4Llvrve8k7T7RATZ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MHHJzsZ_QiBPpuvhQEn6kuApEj4L4g3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX4cwRamVdBcva
 FSfByrnwG4SCbg77mpsWJANn0CS3T2Q51BmQBLjqm69sMic2e9W+cJ7efFX+DykQT/iKKoB2ckK
 KFtAviI76035HzT+B/g8iqeSjEkr+MWnlI79SyxvPKz4kLcIF06StsQFAk8vVVCUgpui5THYeM/
 s3fbBm/4ms3Two3MowYhDnn4ERmboH35/IYFOXpq/DxMM1n0uvxZOqeJ4d8LMshvvJcy8eWWHRe
 xd31pGoSWYcwI/ECrfYvM+Ai4bJOY848polQk/ewaSq/maHVlA/NTJ12sosX9Bx9ppC5Vtwn8Zn
 3lLdsYsjI9gM/qqQHtf0xhF6eLRvz+4Pq3tLUEgc3JyZOHlU9SY9NvUvbTBUTGNQG15Jcogge2Z
 ct/sDKdK86xR670bAef+u7Yo5xsNhQ==
X-Proofpoint-GUID: tfb4xMFSgCuq9wh1HucXVDUX4xNKTlnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
> - Removed VMSTATE for big_core, lpar_per_core, hwid, hrmor, and pir.
> - Removed quad_id vmstate
> 

The commit title and description don't seem to match.  This commit is
only adding vmstate and not removing anything.

-Glenn

> Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index fb2dfc7ba2..03b64f0013 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -31,6 +31,7 @@
>  #include "hw/ppc/xics.h"
>  #include "hw/qdev-properties.h"
>  #include "helper_regs.h"
> +#include "migration/vmstate.h"
>  
>  static const char *pnv_core_cpu_typename(PnvCore *pc)
>  {
> @@ -478,6 +479,15 @@ static void pnv_core_power11_class_init(ObjectClass *oc, const void *data)
>      pnv_core_power10_class_init(oc, data);
>  }
>  
> +static const VMStateDescription pnv_core_vmstate = {
> +    .name = TYPE_PNV_CORE,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(scratch, PnvCore, 8),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_core_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -486,6 +496,7 @@ static void pnv_core_class_init(ObjectClass *oc, const void *data)
>      dc->unrealize = pnv_core_unrealize;
>      device_class_set_props(dc, pnv_core_properties);
>      dc->user_creatable = false;
> +    dc->vmsd = &pnv_core_vmstate;
>  }
>  
>  #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
> @@ -737,12 +748,23 @@ static void pnv_quad_power11_class_init(ObjectClass *oc, const void *data)
>      pnv_quad_power10_class_init(oc, data);
>  }
>  
> +static const VMStateDescription pnv_quad_vmstate = {
> +    .name = TYPE_PNV_QUAD,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL(special_wakeup_done, PnvQuad),
> +        VMSTATE_BOOL_ARRAY(special_wakeup, PnvQuad, 4),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_quad_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      device_class_set_props(dc, pnv_quad_properties);
>      dc->user_creatable = false;
> +    dc->vmsd = &pnv_quad_vmstate;
>  }
>  
>  static const TypeInfo pnv_quad_infos[] = {


