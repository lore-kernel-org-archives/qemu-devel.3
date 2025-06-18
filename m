Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92476C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRmOM-0003pM-58; Wed, 18 Jun 2025 02:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRmOJ-0003o9-K4; Wed, 18 Jun 2025 02:35:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRmOG-0004Rw-HQ; Wed, 18 Jun 2025 02:35:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I0nYSP004841;
 Wed, 18 Jun 2025 06:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n0quMR
 /1mZRMNuiUJgoKfPAkb3bBNpKiddJaJh2elSM=; b=bboLbtPehoyk2DxhoyZmjC
 hEnAklgCt0vqxgPFVIpIkmDzSw3wvrQYAEXj5jzWESFemI1iuEcNLWZAtcXBaeKe
 gcwz1LpDEmRM1vbBuHVSz6BMuNMTbXyj8Jf2JJx+7PxbXwZH5MnzZa1fFLUpKVxu
 W8iMCfzXcreDwl8mI5ycp3EXsJXAXMhaiA56b5cgdFSRZf5jNd8RltRkjCo/B6D9
 ROhGlabNMCOiE2btwUPx+PnoJd+JiPLfvad5IyhfqIWQ6RH4u3Q8VszCudckshf8
 oiKJUjbhJwB+FlXE4QNt5Ui/4pFoiFyhI3LMGtS0MN3uRyWqBgQINFNuYApf46Nw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790te5557-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 06:35:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I59ert014436;
 Wed, 18 Jun 2025 06:35:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42f8gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 06:35:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55I6ZEM226280658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Jun 2025 06:35:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3914C5805A;
 Wed, 18 Jun 2025 06:35:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D40EE58051;
 Wed, 18 Jun 2025 06:35:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Jun 2025 06:35:13 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 08:35:13 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <7f357b35ca800e45c4aff4635f06eb2ed79384fd.camel@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
 <20250616140107.990538-3-shalini@linux.ibm.com>
 <7f357b35ca800e45c4aff4635f06eb2ed79384fd.camel@linux.ibm.com>
Message-ID: <1209abbbca5102c921959e2d6edb70c0@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5igqftoNRmyu65J4RJmPYoeB--e3kaHC
X-Proofpoint-GUID: 5igqftoNRmyu65J4RJmPYoeB--e3kaHC
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=68525e24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=m3Y7-mmFki5-pPL34nEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1MiBTYWx0ZWRfXwRuUo84oPVgO
 xzOfmsFgYbSZI3VbkFV2VIwjNDpC/PHZ3T4oDgz/+ObpQjPcv41EJMK6flfrCNBOYkyHn/SyUYL
 N7W/IyHmq3mTEaZwqHgmQFJyz4CxdJckCcQhhtOLT3/PnsISwlcjQgrx9vR8vliQt8YA+lO/5EB
 7vldlWStKZ1eDGjcsYXLTKY0G5SdZ7JaXWYTjTG/G4O0Mbh1iAgzFKGdfDX6uk11/LRnGufM4OI
 QIz1vJLdSFX71cE/7iH0ZZ6ujEFzeNU35Jq9FUwAacTnWG55fBBwgnoaR7rT4aQ9kdvnCKCjGMW
 MB/gMyFfw9wqK5PW3FLnVCWIyO17Q9kfJLtoi+siPsFQvblWGdS/GUqCY8vQBJkhNEwHxnCnwSZ
 qWgf+soKQvm8f2MoK7e5Ft42iGq3r6/Dvcw1bw9t+1X25ZgXzLzwJEYvoI1T5o/+XOsKlzvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180052
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2025-06-17 19:09, Nina Schoetterl-Glausch wrote:
> On Mon, 2025-06-16 at 16:01 +0200, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received
>> as shown below.
>> 
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-list",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
>> {
>>   "return": [
>>     [...]
>>     {
>>       "name": "system_level",
>>       "type": "uint64"
>>     },
>>     {
>>       "name": "system_name",
>>       "type": "string"
>>     },
>>     {
>>       "name": "system_type",
>>       "type": "string"
>>     },
>>     {
>>       "name": "timestamp",
>>       "type": "uint64"
>>     },
>>     {
>>       "name": "sysplex_name",
>>       "type": "string"
>>     }
>>   ],
>>   "id": "libvirt-14"
>> }
>> 
>> Example CPI data:
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"system_type"}}'
>> {
>>   "return": "LINUX   ",
>>   "id": "libvirt-18"
>> }
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"system_name"}}'
>> {
>>   "return": "TESTVM  ",
>>   "id": "libvirt-19"
>> }
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"sysplex_name"}}'
>> {
>>   "return": "PLEX    ",
>>   "id": "libvirt-20"
>> }
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"system_level"}}'
>> {
>>   "return": 74872343805430528,
>>   "id": "libvirt-21"
>> }
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"timestamp"}}'
>> {
>>   "return": 1748866753433923000,
>>   "id": "libvirt-22"
>> }
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>  hw/s390x/sclpcpi.c                | 74 
>> +++++++++++++++++++++++++++++++
>>  include/hw/s390x/event-facility.h |  5 +++
>>  2 files changed, 79 insertions(+)
>> 
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> index a0b175c5d5..352ef0461d 100644
>> --- a/hw/s390x/sclpcpi.c
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -50,7 +50,10 @@
>>    */
>> 
>>  #include "qemu/osdep.h"
>> +#include "qemu/timer.h"
>>  #include "hw/s390x/event-facility.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "qapi/qapi-visit-machine.h"
>> 
>>  typedef struct Data {
>>      uint8_t id_format;
>> @@ -90,11 +93,58 @@ static int write_event_data(SCLPEvent *event, 
>> EventBufferHeader *evt_buf_hdr)
>>  {
>>      ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, 
>> ControlProgramIdMsg,
>>                                               ebh);
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
>> +
>> +    ascii_put(e->system_type, (char *)cpim->data.system_type,
>> +              sizeof(cpim->data.system_type));
>> +    ascii_put(e->system_name, (char *)cpim->data.system_name,
>> +              sizeof(cpim->data.system_name));
>> +    ascii_put(e->sysplex_name, (char *)cpim->data.sysplex_name,
>> +              sizeof(cpim->data.sysplex_name));
>> +    e->system_level = ldq_be_p(&cpim->data.system_level);
>> +    e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>> 
>>      cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
>>      return SCLP_RC_NORMAL_COMPLETION;
>>  }
>> 
>> +static char *get_system_type(Object *obj, Error **errp)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    return g_strndup((char *) e->system_type, 
>> sizeof(e->system_type));
>> +}
>> +
>> +static char *get_system_name(Object *obj, Error **errp)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    return g_strndup((char *) e->system_name, 
>> sizeof(e->system_name));
>> +}
>> +
>> +static char *get_sysplex_name(Object *obj, Error **errp)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    return g_strndup((char *) e->sysplex_name, 
>> sizeof(e->sysplex_name));
>> +}
>> +
>> +static void get_system_level(Object *obj, Visitor *v, const char 
>> *name,
>> +                             void *opaque, Error **errp)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    visit_type_uint64(v, name, &e->system_level, errp);
>> +}
>> +
>> +static void get_timestamp(Object *obj, Visitor *v, const char *name,
>> +                             void *opaque, Error **errp)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    visit_type_uint64(v, name, &e->timestamp, errp);
>> +}
>> +
>>  static void cpi_class_init(ObjectClass *klass, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -106,6 +156,30 @@ static void cpi_class_init(ObjectClass *klass, 
>> const void *data)
>>      k->get_send_mask = send_mask;
>>      k->get_receive_mask = receive_mask;
>>      k->write_event_data = write_event_data;
>> +
>> +    object_class_property_add_str(klass, "system_type", 
>> get_system_type, NULL);
>> +    object_class_property_set_description(klass, "system_type",
>> +            "operating system e.g. \"LINUX   \"");
>> +
>> +    object_class_property_add_str(klass, "system_name", 
>> get_system_name, NULL);
>> +    object_class_property_set_description(klass, "system_name",
>> +            "user configurable name of the VM e.g. \"TESTVM  \"");
>> +
>> +    object_class_property_add_str(klass, "sysplex_name", 
>> get_sysplex_name,
>> +                                  NULL);
>> +    object_class_property_set_description(klass, "sysplex_name",
>> +            "name of the cluster which the VM belongs to, if any"
>> +            " e.g. \"PLEX    \"");
>> +
>> +    object_class_property_add(klass, "system_level", "uint64", 
>> get_system_level,
>> +                              NULL, NULL, NULL);
>> +    object_class_property_set_description(klass, "system_level",
>> +            "distribution and kernel version in Linux e.g. 
>> 74872343805430528");
>> +
>> +    object_class_property_add(klass, "timestamp", "uint64", 
>> get_timestamp,
>> +                              NULL, NULL, NULL);
>> +    object_class_property_set_description(klass, "timestamp",
>> +            "latest update of CPI data in nanoseconds since the UNIX 
>> EPOCH");
>>  }
>> 
>>  static const TypeInfo sclp_cpi_info = {
>> diff --git a/include/hw/s390x/event-facility.h 
>> b/include/hw/s390x/event-facility.h
>> index e81bc80498..eac7a51100 100644
>> --- a/include/hw/s390x/event-facility.h
>> +++ b/include/hw/s390x/event-facility.h
>> @@ -201,6 +201,11 @@ OBJECT_DECLARE_TYPE(SCLPEventCPI, 
>> SCLPEventCPIClass,
>> 
>>  struct SCLPEventCPI {
>>      SCLPEvent event;
>> +    uint8_t system_type[8];
>> +    uint8_t system_name[8];
>> +    uint64_t system_level;
>> +    uint8_t sysplex_name[8];
>> +    uint64_t timestamp;
>>  };
>> 
>>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
> 
> Might want to make the uint8_ts into chars since it's ascii, but not 
> important.
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Hello Nina,

Thank you very much for the quick review.

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

