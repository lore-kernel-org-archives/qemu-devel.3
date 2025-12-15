Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86472D5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8LI-0005B1-Uf; Mon, 15 Dec 2025 08:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8L2-00059U-BU; Mon, 15 Dec 2025 08:10:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8L0-0002WH-EO; Mon, 15 Dec 2025 08:10:08 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF86n7a031125;
 Mon, 15 Dec 2025 13:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gRh2qb
 0tVVW/+mcbXOLT5nvkaAFiSWXAH4UhAupNKuE=; b=omz1aIbc5m9rZmi9CJlZH2
 tmDuRjSaEDfY+nnEQmYh6C5cqBLVd8FXjrPGTJsE05uf/z2Z1/Kq2ac836lK3ieL
 1Hla1sbEap44RBG2OP3J9AMSMCLL7VNYoP/Sy6mnP86fhHv2Ilu6Dee3x7RjKvMS
 DYAsJGvW2pYdAMd7kwDXsQfD0u9Objzv4haOCIipVdk0GA3HBlkBY6iRCPKKQ//k
 eQVg9V+e1RiNck4Kw4L4dWQjlLq8wNOFbkkMwWGv1ac+ecl3zAXjsxAKYt91LycW
 YPdlPS1byuo/hXpFzVNDJUb9ClvB3WoxEs9WXdW4Mp75zj3m79UMgYFW6xCiIqPQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkses9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:10:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFDA3M6028128;
 Mon, 15 Dec 2025 13:10:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkses3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:10:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFAWFOT005744;
 Mon, 15 Dec 2025 13:10:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnn3f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:10:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFDA0Kj7341040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 13:10:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 232C258057;
 Mon, 15 Dec 2025 13:10:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A926A58059;
 Mon, 15 Dec 2025 13:09:59 +0000 (GMT)
Received: from [9.10.80.79] (unknown [9.10.80.79])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 13:09:59 +0000 (GMT)
Message-ID: <8659dbc6-efd0-43a4-ac0f-d51a668b8480@linux.ibm.com>
Date: Mon, 15 Dec 2025 07:09:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/ppc: pnv_core.c add vmstate support
To: milesg@linux.ibm.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-6-calebs@linux.ibm.com>
 <fbdc008b8adc4f49a884e877697733252e312092.camel@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <fbdc008b8adc4f49a884e877697733252e312092.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Mtr2JV0WjLGfYBmwtB1cE8ptj_JigO_
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=694008ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=IMioQGDEx095__Zaiz0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t12OLghd5OD2KOr43IALJDdnjr6rFvOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX1JGm/P4lrCro
 NNWvFOFg9oRmV0d3ZHKZ2uQ+UR6dPp9ongP5gm/PnZK4GwvKXta7IqgCbvPCnCvc7QuUOdJjRkQ
 lwNnR7vTFh9Kq7EE0GgamdGIfpjyopky0e86Wa1XtZpMuN08vJO1ZI3FlN0rn37jvNW45EqKvap
 Uhqupe4RrkJhGTFAtuGHnTQT+AJRfWv0FwocfysrxWU3b0MoynaOsb69Y/YP4mw2QVuxZrdOSye
 m5UtWbEUVwBQlqfMhtsx8vBHfum0Sjl4QSZCaJM29HthlIK1GpvmwTd/uIK1L7mHeojOfIoerjU
 BLCYaqcycWSytse40Bx1qZNApHK9pI52Q51FenTKcfIci+p1T8me5pZKeSrE/jfxx+ZvU0MOpVm
 aYQ35eDmRz5LMGwxwOnef9JFU6YzmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Good point, I'll fix the commit msg on the next set of patches.

- Caleb

On 12/12/25 11:23 AM, Miles Glenn wrote:
> On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
>> - Removed VMSTATE for big_core, lpar_per_core, hwid, hrmor, and pir.
>> - Removed quad_id vmstate
>>
> 
> The commit title and description don't seem to match.  This commit is
> only adding vmstate and not removing anything.
> 
> -Glenn
> 
>> Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>> ---
>>  hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index fb2dfc7ba2..03b64f0013 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/ppc/xics.h"
>>  #include "hw/qdev-properties.h"
>>  #include "helper_regs.h"
>> +#include "migration/vmstate.h"
>>  
>>  static const char *pnv_core_cpu_typename(PnvCore *pc)
>>  {
>> @@ -478,6 +479,15 @@ static void pnv_core_power11_class_init(ObjectClass *oc, const void *data)
>>      pnv_core_power10_class_init(oc, data);
>>  }
>>  
>> +static const VMStateDescription pnv_core_vmstate = {
>> +    .name = TYPE_PNV_CORE,
>> +    .version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64_ARRAY(scratch, PnvCore, 8),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>>  static void pnv_core_class_init(ObjectClass *oc, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(oc);
>> @@ -486,6 +496,7 @@ static void pnv_core_class_init(ObjectClass *oc, const void *data)
>>      dc->unrealize = pnv_core_unrealize;
>>      device_class_set_props(dc, pnv_core_properties);
>>      dc->user_creatable = false;
>> +    dc->vmsd = &pnv_core_vmstate;
>>  }
>>  
>>  #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
>> @@ -737,12 +748,23 @@ static void pnv_quad_power11_class_init(ObjectClass *oc, const void *data)
>>      pnv_quad_power10_class_init(oc, data);
>>  }
>>  
>> +static const VMStateDescription pnv_quad_vmstate = {
>> +    .name = TYPE_PNV_QUAD,
>> +    .version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_BOOL(special_wakeup_done, PnvQuad),
>> +        VMSTATE_BOOL_ARRAY(special_wakeup, PnvQuad, 4),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>>  static void pnv_quad_class_init(ObjectClass *oc, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>  
>>      device_class_set_props(dc, pnv_quad_properties);
>>      dc->user_creatable = false;
>> +    dc->vmsd = &pnv_quad_vmstate;
>>  }
>>  
>>  static const TypeInfo pnv_quad_infos[] = {
> 


