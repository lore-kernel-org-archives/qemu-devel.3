Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB9C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzu95-0002FR-2F; Wed, 02 Apr 2025 05:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzu8u-0002Cv-Si; Wed, 02 Apr 2025 05:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzu8t-0000Lg-2Q; Wed, 02 Apr 2025 05:12:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531NDI2I005015;
 Wed, 2 Apr 2025 09:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Pl57NX
 P8Waboz/12D81WL9G/3/41+51SNNt34mDGOdc=; b=QvGXOgAA99Xn9NoabsUmxz
 dvKUrRGE3vSHzDMVS2B7PC0mUdwjOTCpQn/g9Xl4R2YjraWtr53psngY1RHxAjRH
 XE0PwmKWKTlXuJU1/MDXqq8/hVlYqFnnyF5oCFaaCKNX2AtsXF/gXDxGQlOYJMKk
 LRI11jJFH1gA7lpmSecZn0u4duZQfumpqoRaU6TGjJTZeNtUSu2bd9w3wS0rT5DL
 +VvaUmju6iNDP/STpthv2bG61rS79jPsenRwVEEHslDgZCAlku3TANvuG0ZjUtVi
 2YD6b9KIyrpE7ohRqNhh71CzzEZ4k5pMhAo3UGafMJ5XHUIRMQAsPXsLH7Ud6SyQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rhjpw2ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 09:12:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5328CTG7019410;
 Wed, 2 Apr 2025 09:12:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t7ad2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 09:12:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5329C9nU26280510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Apr 2025 09:12:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98A2A58054;
 Wed,  2 Apr 2025 09:12:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C9825805A;
 Wed,  2 Apr 2025 09:12:09 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Apr 2025 09:12:08 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 02 Apr 2025 11:12:08 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] hw/s390x: support migration of CPI data
In-Reply-To: <6da8fc30-c951-43dc-a3b3-903fa54237dd@redhat.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-4-shalini@linux.ibm.com>
 <6da8fc30-c951-43dc-a3b3-903fa54237dd@redhat.com>
Message-ID: <2c4a1a9015f051aeffd4bb5d9534edef@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MDxT6I9B9JoGNiFTgSx3AXUnufvnD9Oj
X-Proofpoint-ORIG-GUID: MDxT6I9B9JoGNiFTgSx3AXUnufvnD9Oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
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

On 2025-04-02 08:05, Thomas Huth wrote:
> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>> Register Control-Program Identification data with the live
>> migration infrastructure.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> ---
>>   hw/s390x/sclpcpi.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>> 
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> index 969c15e43d..0b1b5293ea 100644
>> --- a/hw/s390x/sclpcpi.c
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -62,6 +62,7 @@
>>   #include "hw/s390x/event-facility.h"
>>   #include "hw/s390x/ebcdic.h"
>>   #include "qapi/qapi-visit-machine.h"
>> +#include "migration/vmstate.h"
>>     typedef struct Data {
>>       uint8_t id_format;
>> @@ -133,12 +134,38 @@ static void get_control_program_id(Object *obj, 
>> Visitor *v,
>>       visit_type_S390ControlProgramId(v, name, &cpi, errp);
>>   }
>>   +static const VMStateDescription vmstate_control_program_id = {
>> +    .name = "s390_control_program_id",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
> 
> Nit: As long as it is 0, I think you could simply omit the
> minimum_version_id field here.
> 

Ok, I will omit the minimum_version_id field in both, thank you.

>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
>> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(system_level, ControlProgramId),
>> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(timestamp, ControlProgramId),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_sclpcpi = {
>> +    .name = "s390_sclpcpi",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
> 
> dito
> 
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_STRUCT(cpi, SCLPEvent, 0, vmstate_control_program_id,
>> +                       ControlProgramId),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>  Thomas

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

