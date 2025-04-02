Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C5C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzu3Z-00084H-Ei; Wed, 02 Apr 2025 05:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzu3X-00082R-6A; Wed, 02 Apr 2025 05:06:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzu3V-00066H-4S; Wed, 02 Apr 2025 05:06:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5322xqVo032389;
 Wed, 2 Apr 2025 09:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=AzJxKGIHRba4kdlMiqUFZmdqx5N1
 08hhHtUc969g+YI=; b=XbangdkK+LVCL76oLC7vn2WdrSbRzkIhH9k+CKw8EMFS
 M02mh97uBptjVfmCC69KGwrzTuy1pxbU9FENUaTTB1dFSvGht+dR4WjqHLGAyEmh
 JGNZUADsxFrveTnI4juxDSYiNnMwFn4OYESbSUYGywOennR1VASWaEscYxkRglma
 1PQ93LUxB5f3njMYfvaj0HczmPhS0iaMXsBj+xNYE6v+iumsxlKwep6D5zJVkI92
 oBeeO4ocPegnyoz2aD2xEBSqsJa2aq18ZPbSebdrM/yP1GI0cWdn8qCUyGfKHPwj
 VzrnQGa4wbm3pUEDAZznXdX8ASFKQ35JTGnzFoFnFQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rg67nhxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 09:06:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5328KIdJ004829;
 Wed, 2 Apr 2025 09:06:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyy6fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 09:06:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53296aTQ31523418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Apr 2025 09:06:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 956F758055;
 Wed,  2 Apr 2025 09:06:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A00158043;
 Wed,  2 Apr 2025 09:06:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Apr 2025 09:06:36 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 02 Apr 2025 11:06:36 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
Message-ID: <bd0f521e58c4c2bb42a3b25882b1cd80@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KPhLaDD2kWPJxM7YNuuL862od8RoeRZ0
X-Proofpoint-GUID: KPhLaDD2kWPJxM7YNuuL862od8RoeRZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020053
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

On 2025-04-02 07:58, Thomas Huth wrote:
> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received.
>> 
>> Example:
>> virsh # qemu-monitor-command vm --pretty '{
>> "execute": "qom-get",
>> "arguments": {
>> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property": "control-program-id" }}'
>> {
>>    "return": {
>>      "timestamp": 1742390410685762000,
>>      "system-level": 74872343805430528,
>>      "sysplex-name": "PLEX ",
>>      "system-name": "TESTVM  ",
>>      "system-type": "LINUX   "
>>    },
>>    "id": "libvirt-15"
>> }
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>   hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
>>   include/hw/s390x/event-facility.h |  9 +++++
>>   qapi/machine.json                 | 58 
>> +++++++++++++++++++++++++++++++
>>   3 files changed, 105 insertions(+)
>> 
>> diff --git a/include/hw/s390x/event-facility.h 
>> b/include/hw/s390x/event-facility.h
>> index f445d2f9f5..39e589ed44 100644
>> --- a/include/hw/s390x/event-facility.h
>> +++ b/include/hw/s390x/event-facility.h
>> @@ -169,10 +169,19 @@ typedef struct ReadEventData {
>>       };
>>   } QEMU_PACKED ReadEventData;
>>   +typedef struct ControlProgramId {
>> +    uint8_t system_type[8];
>> +    uint8_t system_name[8];
>> +    uint64_t system_level;
>> +    uint8_t sysplex_name[8];
>> +    uint64_t timestamp;
>> +} QEMU_PACKED ControlProgramId;
> 
> Do we need the QEMU_PACKED here? The members seem naturally aligned,
> and the struct does not seem to be involved in the communication with
> the guest directly, so if you don't need it, please drop the
> QEMU_PACKED here.
> (without PACKED, the compiler can optimize the code in a better way,
> and this causes less trouble on exotic platforms like SPARC that
> cannot access unaligned memory addresses)

Hello Thomas,

Thank you for the explanation. I will drop the QEMU_PACKED.

> 
>>   struct SCLPEvent {
>>       DeviceState qdev;
>>       bool event_pending;
>>       char *name;
>> +    ControlProgramId cpi;
>>   };
>>     struct SCLPEventClass {
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..cd2bcd2d13 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -1898,3 +1898,61 @@
>>   { 'command': 'x-query-interrupt-controllers',
>>     'returns': 'HumanReadableText',
>>     'features': [ 'unstable' ]}
>> +
>> +##
>> +# @S390ControlProgramId:
>> +#
>> +# Control-program identifiers provide data about the guest operating 
>> system.
>> +# The control-program identifiers are: system type, system name, 
>> system level
>> +# and sysplex name.
>> +#
>> +# In Linux, all the control-program identifiers are user 
>> configurable. The
>> +# system type, system name, and sysplex name use EBCDIC characters 
>> from
>> +# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the 
>> system type,
>> +# system name and sysplex name are arbitrary free-form texts.
>> +#
>> +# In Linux, the 8-byte hexadecimal system-level has the format
>> +# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
>> +# <a>: is one hexadecimal byte, its most significant bit indicates 
>> hypervisor
>> +# use
>> +# <b>: is one digit that represents Linux distributions as follows
>> +# 0: generic Linux
>> +# 1: Red Hat Enterprise Linux
>> +# 2: SUSE Linux Enterprise Server
>> +# 3: Canonical Ubuntu
>> +# 4: Fedora
>> +# 5: openSUSE Leap
>> +# 6: Debian GNU/Linux
>> +# 7: Red Hat Enterprise Linux CoreOS
>> +# <cc>: are two digits for a distribution-specific encoding of the 
>> major version
>> +# of the distribution
>> +# <dd>: are two digits for a distribution-specific encoding of the 
>> minor version
>> +# of the distribution
>> +# <eeee>: are four digits for the patch level of the distribution
>> +# <ff>: are two digits for the major version of the kernel
>> +# <gg>: are two digits for the minor version of the kernel
>> +# <hh>: are two digits for the stable version of the kernel
>> +# (e.g. 74872343805430528, when converted to hex is 
>> 0x010a000000060b00). On
>> +# machines prior to z16, some of the values are not available to 
>> display.
> 
> You've got the same information in the comment at the beginning of the
> sclpcpi.c file already ... maybe it would be good to have it in one
> place only to avoid double maintenance in case it needs to be changed
> in the future. I'd suggest to change the comment at the beginning of
> sclpcpi.c to say something like "for a detailed description of the
> contents of the CPI, please see the S390ControlProgramId QOM-type
> description." or something similar?

ok, I will do that.

> 
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

