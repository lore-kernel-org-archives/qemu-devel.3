Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38423C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZDT-0007Md-7C; Mon, 24 Feb 2025 09:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tmYN8-00014q-Qd; Mon, 24 Feb 2025 08:19:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tmYN4-00052X-Mk; Mon, 24 Feb 2025 08:19:44 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2DpSI026276;
 Mon, 24 Feb 2025 12:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9DDnRY
 PZV3sMX17lNQoEE9HbUOsEz6ycagwFMkyOnL8=; b=PdOF+4W8xwhpHr04PLXSEm
 oT2cwKA74S1GlBNHPkeId4L9knJu75oBZaHwurbOZ+Wu4imQFxvVD40l/FbmpnE/
 Lb1yUVM9fZrkIwLVtBUI3q0nZqVZHvp0/AZhaIQl0g8I/p83hMUf/72ebL5pZGca
 c8YZ18pZ7IqMZfhB1qbfQfRYNPQuhrRLFZkpVMzp0rFu4kUWGIqbhzU67JUWWgZG
 kQ8AYIcBsxTsDNkoWt7+N2zVXVSLb/MhfuIL4uOSFWgeFzwtL5CkmQxjmn1plLbq
 WaKaiYBYYa4c0oL9UhkUcqg7yk/Po7f8FGBBeN7lkcKOGIHq99FoDtvK+o0U+d3w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450eu9thmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:36:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBv1mX026274;
 Mon, 24 Feb 2025 12:36:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn73x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:36:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OCa0fL65077654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 12:36:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA4585805C;
 Mon, 24 Feb 2025 12:35:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73E9F5805A;
 Mon, 24 Feb 2025 12:35:59 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 12:35:59 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 13:35:59 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v1 2/3] hw/s390x: add CPI values to QOM
In-Reply-To: <812ab32cb4f2ca3d8290936989491b8f3b970692.camel@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
 <20250115133106.3034445-2-shalini@linux.ibm.com>
 <812ab32cb4f2ca3d8290936989491b8f3b970692.camel@linux.ibm.com>
Message-ID: <7fefa7560b7e42ae34680c99a69ba57f@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XtLYWf4gX0reyl0A0xVuGv10QubCvchr
X-Proofpoint-ORIG-GUID: XtLYWf4gX0reyl0A0xVuGv10QubCvchr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1034 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240091
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=shalini@imap.linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Feb 2025 09:13:48 -0500
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

On 2025-01-24 18:49, Nina Schoetterl-Glausch wrote:
> On Wed, 2025-01-15 at 14:31 +0100, Shalini Chellathurai Saroja wrote:
>> This commit adds the firmware control-program
>> identifiers received from a KVM guest via the
>> SCLP event type Control-Program Identification to QOM.
>> A timestamp in which the data is received is also
>> added to QOM.
>> 
>> Example:
>> virsh # qemu-monitor-command vm --pretty '{
>> "execute":"qom-get","arguments": {
>> "path": "/machine", "property": "s390-cpi"}}'
>> {
>>   "return": {
>>     "timestamp": 1711620874948254000,
>>     "system-level": "0x50e00",
>>     "sysplex-name": "SYSPLEX ",
>>     "system-name": "TESTVM  ",
>>     "system-type": "LINUX   "
>>   },
>>   "id": "libvirt-15"
>> }
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c         | 26 ++++++++++++++++++++++++++
>>  hw/s390x/sclpcpi.c                 | 10 ++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>>  qapi/machine.json                  | 24 ++++++++++++++++++++++++
>>  4 files changed, 68 insertions(+)
>> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 38aeba14ee..35fb523af9 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -49,6 +49,7 @@
>>  #include "hw/virtio/virtio-md-pci.h"
>>  #include "hw/s390x/virtio-ccw-md.h"
>>  #include CONFIG_DEVICES
>> +#include "qapi/qapi-visit-machine.h"
>> 
>>  static Error *pv_mig_blocker;
>> 
>> @@ -773,6 +774,25 @@ static void machine_set_loadparm(Object *obj, 
>> Visitor *v,
>>      s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>>  }
>> 
>> +static void machine_get_cpi(Object *obj, Visitor *v,
>> +                             const char *name, void *opaque, Error 
>> **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +    S390Cpi *cpi;
>> +    cpi = &(S390Cpi){
>> +        .system_type = g_strndup((char *) ms->cpi.system_type,
>> +                       sizeof(ms->cpi.system_type)),
>> +        .system_name = g_strndup((char *) ms->cpi.system_name,
>> +                       sizeof(ms->cpi.system_name)),
>> +        .system_level = g_strdup_printf("0x%lx", 
>> ms->cpi.system_level),
> 
> Is there any way in which it would make sense for the qmp caller to
> interpret this as a number? If so exposing it as a number would be 
> preferable.
> 

Hello Nina,

As discussed offline, when interpreted as a number the output was

'system-level': 74872343805430528

however, the desired output is

'system-level': '0x10a000000060b00'

So, this code is not changed in v2. Thank you.

>> +        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
>> +                        sizeof(ms->cpi.sysplex_name)),
>> +        .timestamp = ms->cpi.timestamp
>> +    };
>> +
>> +    visit_type_S390Cpi(v, name, &cpi, &error_abort);
>> +}
>> +

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

