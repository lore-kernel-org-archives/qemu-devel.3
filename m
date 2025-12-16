Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E39D609C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 17:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYTg-0002A8-Gj; Tue, 16 Dec 2025 12:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYTQ-0001rz-68; Tue, 16 Dec 2025 12:04:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYTM-00035J-Ra; Tue, 16 Dec 2025 12:04:31 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCqZHw027851;
 Tue, 16 Dec 2025 17:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yvUduX
 Fp6c8b9R6ajZH4kW4+N6ckXZ1nZuPPqxCy6cs=; b=JpzBucOcrvv0kViG8t50AC
 Af1sgcgZyQCrJ/AaDHDwkWrVVIe5Ikb9JpvjLOsrRom5A9NdSt45G3jXkGM8HOta
 z0GP8fzfQRQ7p2PsF+i/ylKdMWT/f6lBuhpAn90Uf78CZfb9rVnoM3/eSYrO/fT3
 oYS+qJewQ5GOtgJuvEBDKQqIpk7oFvzqAits+LC946ggNJc4+T17NiUcI2riIc4b
 hZ7Ceqfd5oZjGVtPwme068LDLIqVyE1rL114jpL59ifa8bQFE/2wqFU4yCk0qJft
 AGhr0xC9hogVM8c7fC/cOOKRcG70Zj57g8Xm4k0xcRMMvVhcMOaf8GIGNommynyA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq02uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:04:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGH4Pf5018513;
 Tue, 16 Dec 2025 17:04:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq02ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGH0bqB014324;
 Tue, 16 Dec 2025 17:04:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjw829-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:04:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGH4Nuv65929494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 17:04:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C98B58050;
 Tue, 16 Dec 2025 17:04:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75A9658045;
 Tue, 16 Dec 2025 17:04:22 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 17:04:22 +0000 (GMT)
Message-ID: <9b1b4ea6-3372-432e-b58b-661e2baa95b0@linux.ibm.com>
Date: Tue, 16 Dec 2025 11:04:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] hw/ppc: pnv_core.c add vmstate support
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-6-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-6-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX4Q/rlO7pveAp
 thCBE9Cj0K/Ax6u8sJvBfs6MW+26iJ8RQYtZotsH1NsRvTwF3BQiL7P1h/wDc/7QgwFzC0Y/KyM
 oKftLKfMwg2xmjqGO3UnJ/Ik7jHzq9YaGbJlJ96s8v5m0nyG6eNx9xqtTXQp88Mpq0vyc3o8CDv
 d1UCwlETbr+cs1uLkZcRXwm6PqkbPsbtLpFIxQPjwhyGObpeIVeoiCa7J6VASX5eYuusC3/0ATZ
 zdvLYeY4eMVAjmhYRFS0ZOUQObX0u/ICF+959rNtzx6cKiENS3o2p34jSAUey6iWys62RF6vK/g
 E8VuAUy8gWXrK0Bc9CkL2QhEPG4HeJaCjqzdNacjD4kgPMshQ2oH8BsBmFE3klqcwy3fs2liqXC
 d/kHTB5rdGcMQvWLDEJleOUowPH8mA==
X-Proofpoint-GUID: PmLvB-lItoHRuybK2beaDNEWOEvv5WRD
X-Proofpoint-ORIG-GUID: Mdbg5UGBQs_oZrjzxrVaajbh4YHnmlc-
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69419119 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Am2e6uvtdsXxczCLzKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> - Add vmstate support PnvCore and PnvQuad capturing scratch
> registers and special wakeup registers
>
> Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index fb2dfc7ba2..03b64f0013 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -31,6 +31,7 @@
>   #include "hw/ppc/xics.h"
>   #include "hw/qdev-properties.h"
>   #include "helper_regs.h"
> +#include "migration/vmstate.h"
>   
>   static const char *pnv_core_cpu_typename(PnvCore *pc)
>   {
> @@ -478,6 +479,15 @@ static void pnv_core_power11_class_init(ObjectClass *oc, const void *data)
>       pnv_core_power10_class_init(oc, data);
>   }
>   
> +static const VMStateDescription pnv_core_vmstate = {
> +    .name = TYPE_PNV_CORE,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(scratch, PnvCore, 8),

This should probably be a constant or dynamically calculated.

MAK

> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_core_class_init(ObjectClass *oc, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -486,6 +496,7 @@ static void pnv_core_class_init(ObjectClass *oc, const void *data)
>       dc->unrealize = pnv_core_unrealize;
>       device_class_set_props(dc, pnv_core_properties);
>       dc->user_creatable = false;
> +    dc->vmsd = &pnv_core_vmstate;
>   }
>   
>   #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
> @@ -737,12 +748,23 @@ static void pnv_quad_power11_class_init(ObjectClass *oc, const void *data)
>       pnv_quad_power10_class_init(oc, data);
>   }
>   
> +static const VMStateDescription pnv_quad_vmstate = {
> +    .name = TYPE_PNV_QUAD,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL(special_wakeup_done, PnvQuad),
> +        VMSTATE_BOOL_ARRAY(special_wakeup, PnvQuad, 4),

Same as above...

MAK

> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_quad_class_init(ObjectClass *oc, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
>   
>       device_class_set_props(dc, pnv_quad_properties);
>       dc->user_creatable = false;
> +    dc->vmsd = &pnv_quad_vmstate;
>   }
>   
>   static const TypeInfo pnv_quad_infos[] = {

