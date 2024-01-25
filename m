Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF1DC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 23:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT9Aq-0005xK-60; Thu, 25 Jan 2024 18:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rT9Am-0005vv-JE; Thu, 25 Jan 2024 18:30:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rT9Ak-0004dX-IQ; Thu, 25 Jan 2024 18:30:16 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PMqKe7005486; Thu, 25 Jan 2024 23:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QOn6uj54Rh5zJLkfaufY5+25B/75ZfZ3UYV+QPeKYZY=;
 b=W7ipD4LvenRM7Am64EfYM59Ew/9HOMls0SbiKSY0UfyQDw4LQdeM75AdlyF8FoafmiJ9
 M5E7lEDkltdQGpcQTQUi6dfF8UKYKnbloLs2pk3N+UMgPi0Sb7oO8hfUtPrDZGBjDEZG
 2AOEBVLIgl07p8le1n039ogIwfIVBUnMpjYhT6S3UUlEhTn2k2EEVbF0esItItEoVekh
 fqbxmxG47DlW9v0zPHYCDlMvM4NCTT0RRhMhUZN2N+7fyByazFRZ7EOBiX0v30vwpJbu
 4/J9iufxFSjlekDD/xWG/iEP3OVpUnvFm7SNDlMoyJgKza+0RyMWKgw+EzBVGJhXtsS2 Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0tprv3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 23:29:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PNTgPH021845;
 Thu, 25 Jan 2024 23:29:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0tprv3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 23:29:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PNL6wM025291; Thu, 25 Jan 2024 23:29:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkpyuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 23:29:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PNTqJG4850588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 23:29:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B90915805E;
 Thu, 25 Jan 2024 23:29:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5427258055;
 Thu, 25 Jan 2024 23:29:52 +0000 (GMT)
Received: from [9.61.160.70] (unknown [9.61.160.70])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 23:29:52 +0000 (GMT)
Message-ID: <92173476-2b24-475d-8af8-8f135176a125@linux.ibm.com>
Date: Thu, 25 Jan 2024 17:29:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] hw/fsi: Introduce IBM's Local bus and scratchpad
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-2-ninad@linux.ibm.com>
 <c85c8ce7-38cf-410a-b226-5810793295a6@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <c85c8ce7-38cf-410a-b226-5810793295a6@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hJEKntmd7957K7D2-YbhugN4yFwNV4fP
X-Proofpoint-GUID: qpJNU7Xh88XYoPOIJXRE9D7NWvDAX4hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=791 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Cedric,

>
>
>> [ clg: - removed lbus_add_device() bc unused
>>         - removed lbus_create_device() bc used only once
>>         - removed "address" property
>>         - updated meson.build to build fsi dir
>>         - included an empty hw/fsi/trace-events ]
>
> this list of modifications should be before my S-o-b.
Moved it to correct place.

>> +
>> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
>> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
>> +
>> +#define FSI_LBUS_MEM_REGION_SIZE  (1 * MiB)
>> +#define FSI_LBUSDEV_IOMEM_START   0xc00 /* 3K used by CFAM config 
>> etc */
>
> These define are not very useful. Please remove (see comments in
> lbus.c)
Removed.
>
>>
>> +typedef struct FSILBusDeviceClass {
>> +    DeviceClass parent;
>> +
>> +    uint32_t config;
>> +} FSILBusDeviceClass;
>
> This class is unused now.
Removed the class. We will add it once we add more devices.
>
>>
>> +#include "trace.h"
>> +
>> +static void lbus_init(Object *o)
>
> I would prefix the lbus routine and struct with fsi_lbus to be
> consistent with the types and macro.
Added prefix fsi_ for all routines.
>
>> +{
>> +    FSILBus *lbus = FSI_LBUS(o);
>> +
>> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
>> +                       FSI_LBUS_MEM_REGION_SIZE - 
>> FSI_LBUSDEV_IOMEM_START);
>
> This is enough :
>
>     memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS, 1 * MiB);
Changed as per your suggestion.

>
>>
>> +
>> +static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t 
>> data,
>> +                                 unsigned size)
>> +{
>> +    FSIScratchPad *s = SCRATCHPAD(opaque);
>> +
>> +    trace_fsi_scratchpad_write(addr, size, data);
>> +
>> +    if (addr & ~(FSI_SCRATCHPAD_NR_REGS - 1)) {
>
> There is a type confusion. addr is an offset in a memory region and
> FSI_SCRATCHPAD_NR_REGS is an index an array.
Fixed.
>
>
>> +        return;
>> +    }
>> +
>> +    s->reg[addr] = data;
>
> same here.
Fixed.
>
>>
>> +static void fsi_scratchpad_reset(DeviceState *dev)
>> +{
>> +    FSIScratchPad *s = SCRATCHPAD(dev);
>> +    int i;
>> +
>> +    for (i = 0; i < FSI_SCRATCHPAD_NR_REGS; i++) {
>> +        s->reg[i] = 0;
>
> memset(s->regs, 0, sizeof(s->regs));

Fixed.

Thanks for the review.

Regards,

Ninad



