Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EDFC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqSr-0004a1-Iu; Mon, 05 May 2025 03:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBqSq-0004ZM-7u; Mon, 05 May 2025 03:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBqSo-0006Wh-9m; Mon, 05 May 2025 03:42:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544Ldti3013927;
 Mon, 5 May 2025 07:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9eK49w
 BONp6KPQTuZ7DBCHrbTAvxoQxK5rJ8snaBhVA=; b=bAPuX8na+WkQXmdppPeW1p
 sgz3NnGoFoaHQK2pTndMoQR4YsmAI1vlS2b924+mTPusHxa6jGWxwVifiHhrWe2o
 3ch0ghMf8a2aIJWBOpiNBfeUTCV+n0F0NIrn7qa2q9k2yKi+aiFp87QJ9n/6zApv
 HB+xGKOV6IiCN9AzfnKdWhW63twZsTFi2UotX1nCqV9b/g48HRjubpCAqJqek2mF
 V5CD9RXiQukOiJukVn8Hmro+hV+K9SL6v4bwGbKmof5TyrYkUAJUy4H9qkIweClT
 lZulVgRkGC4ksbTulxt92H7Tg0wPGlRE8ah0dFAH0eHFp2Kr/a+bl9iGX8xlcafA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46egb7spu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 07:42:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5457SAhX026038;
 Mon, 5 May 2025 07:42:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuynajx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 07:42:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5457g52120185818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 07:42:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 464BB58059;
 Mon,  5 May 2025 07:42:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6ECC58057;
 Mon,  5 May 2025 07:42:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 May 2025 07:42:04 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 05 May 2025 09:42:04 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 2/4] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <17ad2f31-dadb-4b36-b663-7736ac6c1cfe@redhat.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-3-shalini@linux.ibm.com>
 <17ad2f31-dadb-4b36-b663-7736ac6c1cfe@redhat.com>
Message-ID: <1c53abc29ddb96fee017fba5088e8619@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LNptLU1u9Z3duh6HVFMIp6_gL_0EXvmk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA3MCBTYWx0ZWRfX+iGfsQlQiZ9X
 CvHh/VjvasZ+cLE0K+v0DGWxQzJpftzUR/+2Pm1ZxtBgRWcXSpCSvUJUCQ1TLbJgeiSP8ZYHfS2
 uNnIOcrreLX+A/FQgxe5VYyBEuaTsRiOoR5mNMdIaenw+rYSZkhzyirrjjUJCvG27vaTSjM0Ave
 p3lfR1xncq7yUdMRrBvJIbBLyq9ktlMSg/mo2s8gsmBpGDH/tT9GuG8cLvWvygfZz1es0Zbvm9A
 QNT93yTEzKX4KrjNiGJlNH2SHih+Me2ThzfHpQqfurWGC5tkuDgKF+TY+OFNsQ3gpnjCeIU/80M
 PaKdf0kGh8bxAn5OB7TkIhj5QErBpcbHRJuODbQC9QcS4Ge1NhL80wOv5EKQvPC/8q4pTzOIXb9
 zHZWLehP/PCxyjIWPpHA/TPkD1MaEKFZQbVCSvboVWb3E5CbHIFIBqmmFRQ8o7XekxcZZSx4
X-Authority-Analysis: v=2.4 cv=YcK95xRf c=1 sm=1 tr=0 ts=68186bcf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=W5_4-01To_lkysA7RGcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LNptLU1u9Z3duh6HVFMIp6_gL_0EXvmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=945 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050070
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2025-04-30 12:34, Thomas Huth wrote:
> On 10/04/2025 17.09, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received.
> ...
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> index 13589459b1..dcc8bd3245 100644
>> --- a/hw/s390x/sclpcpi.c
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -18,7 +18,10 @@
>>     */
>>     #include "qemu/osdep.h"
>> +#include "qemu/timer.h"
>>   #include "hw/s390x/event-facility.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "qapi/qapi-visit-machine.h"
>>     typedef struct Data {
>>       uint8_t id_format;
>> @@ -58,11 +61,39 @@ static int write_event_data(SCLPEvent *event, 
>> EventBufferHeader *evt_buf_hdr)
>>   {
>>       ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, 
>> ControlProgramIdMsg,
>>                                                ebh);
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
>> +
>> +    ascii_put(e->cpi.system_type, (char *)cpim->data.system_type, 8);
>> +    ascii_put(e->cpi.system_name, (char *)cpim->data.system_name, 8);
>> +    ascii_put(e->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 
>> 8);
> 
> Would it be possible to use sizeof() instead of hard-coding "8" here?

Hello Thomas,

Yes, it is. I will do so. Thank you very much for the review.

I will also move the property use_cpi to ccw_machine_10_0_class_options, 
as version 10.0 is already released.

> 
>  Thanks,
>   Thomas

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

