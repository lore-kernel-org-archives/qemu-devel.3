Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669EAD609C6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXnn-0004OM-DT; Tue, 16 Dec 2025 11:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXnR-0004Ib-8x; Tue, 16 Dec 2025 11:21:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXnL-0007lL-4a; Tue, 16 Dec 2025 11:21:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGEDV1i029950;
 Tue, 16 Dec 2025 16:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=v13P5ngI131lIAmUoGgpseEA84J3HO0Sn7IimbhJmaI=; b=RL/KMKIiDjVO
 LpkCV1wdwBDKqeo+8uRUr/5RmydhshWHulc3Z9nKJo60qEcCWimsmRD9/ue85IAi
 YroVYfF/R5j73IajuorlFP0e9G7Jt2f1eq0mvz/1ZnomqyR++P319KlaPNf2Ii7X
 jmuRlHvdrIycVvtJfFIibPKbUhYDWwcoXrUOBKAVuedyGtPSqz6+tx5cQVUj58e4
 eeZRVG03ZKIB3K5VBQAhKTp0kOha0KOLuhtBJG/4yCv/otzo8fS8znKzM1RLSoC+
 Xtn5TaSnNuvGe29zc/nM24lHcCGBW+PwZeJVybkLGQYsMLYBaOzXHiijlcKn6+wo
 cMq5/7A88A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb83tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:20:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGEAhV001951;
 Tue, 16 Dec 2025 16:20:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb83th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:20:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGBI4l012788;
 Tue, 16 Dec 2025 16:20:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy59xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:20:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGKYP130802548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:20:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 537A958052;
 Tue, 16 Dec 2025 16:20:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDFE358056;
 Tue, 16 Dec 2025 16:20:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:20:33 +0000 (GMT)
Message-ID: <d2e0c2ec59d94ef7e37bf3da4aaf4948e8e0670c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/7] hw/ppc: pnv_core.c add vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Tue, 16 Dec 2025 10:20:33 -0600
In-Reply-To: <20251216151359.418708-6-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-6-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=694186d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qtmRp8ezACxhaHKQCycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WNy9Rv38ZEn3uKx-7DUjipmOqcBUkxLm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX8U7Q4gAvGM/f
 1G9UUQh4PKmS5euNCKqsHFXKAXoVsCNW+bc22KgHcGONvw2fOxjBHEgi+3KpBX6KZZgEivLe4Cs
 /xmUH4g5pA2rm+z/CQNwSbCngfqnuBgXTlyi11e2I4M66HbubJJ30XKp00StSz9xvtHX9bokoAC
 93dPZPYicOL4B89sOYtgsjQdkCqAXqnuU1Uyx1puc4t7fDxuvxZorP6MOaZJ5Xqv8DIY3pUmjiE
 x4zMunnmjlt6K5CJdvhhYyizC0MleMAV07CC3C1Pq9ZG+VEFa3yiyv4nGqp1z6zg2CL5daETnMY
 w3Z+2CZsrqdaKZVlODbaCtzJnYEw51T7NbIbO9MMXkOu/9mI2skUV5YazulHuz2bzCGDJvya56D
 5BvnKX6OyWX1XQhKirAWDCbsoApA0Q==
X-Proofpoint-ORIG-GUID: XVbbXldkG2AggCMiSc8NBVpZSBW6H3zN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2025-12-16 at 09:13 -0600, Caleb Schlossin wrote:
> - Add vmstate support PnvCore and PnvQuad capturing scratch
> registers and special wakeup registers
> 
> Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
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


