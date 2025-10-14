Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E4ECCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8afM-0001Yf-Au; Tue, 14 Oct 2025 04:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8afK-0001Y9-Bd; Tue, 14 Oct 2025 04:45:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8afH-0006P0-Fh; Tue, 14 Oct 2025 04:45:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6Zx97022496;
 Tue, 14 Oct 2025 08:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ndB1T9
 HKSNv1vkNUMzIWnb8HzVSMRApjeuwCKJWx7YA=; b=UnqkSdrIigDS/rqfQePIDN
 sSjehS8LmaewqKYKGgN9mg5YeuIiPkamQBXPELCOXSlGvl9g8W7bMyObOV9kkaBh
 lVeW4uIdkWDLXEr7XVecSzCY6GXTXETXWXN5e/RbPB99hSB3pYa2xaVWNQvjZGP1
 f14RoKsPwWrKGLzwKSfyvoEkCaixDQ69u663KRbL3Kn4FE1U+UU+9vZeqnJKZpWS
 sklPD38ZV3HtW2uYpV0aE2cWl2xtEh0xBer/FsAPyg2m7zll2ZogqphMK3Ctm7VC
 /XxybBrGFdPA3vHsOyt7PORFJIYX3kUjvUvQzK1FcUNHdnKIr/weUIEEbRfcJE/w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr5buh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 08:45:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7BJtS018823;
 Tue, 14 Oct 2025 08:45:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmj1jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 08:45:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59E8jkD728377344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 08:45:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 898F858052;
 Tue, 14 Oct 2025 08:45:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8C4158045;
 Tue, 14 Oct 2025 08:45:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 08:45:45 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 10:45:45 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Sebastian Mitterle <smitterl@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
In-Reply-To: <cb6b2a02856cffcb51b6049e7bc03ed8e160f03c.camel@linux.ibm.com>
References: <20251013133902.111233-1-shalini@linux.ibm.com>
 <cb6b2a02856cffcb51b6049e7bc03ed8e160f03c.camel@linux.ibm.com>
Message-ID: <4c4740467a03a54fa3f8bf42e0ee5c34@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ee0dbc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=-qjoJ--zFjlsQy1LV4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LMOVtkvt9dQIIgFH_dGikXPA9QZFW51J
X-Proofpoint-ORIG-GUID: LMOVtkvt9dQIIgFH_dGikXPA9QZFW51J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX5LmzmvxqTdsf
 wwM01PYkrmt27XZG2QhoffyX9W922zYwNIdp0AZoqG7Wp3N4XeSs1B/pPm90IiFQ3D2xL7qaZOE
 5/SlBMtI10q5Dz3eNf6DgBH0JrG8VnR8PEptrBcsIC8kt23aFdV3VcYRlD5EU/CEDiMa/gHOTOT
 TDmAx89JRUlPn3UTAk4rFUICXMs9+lz8Fby4SaWaMVTin8NRaXjqEOUGQSmAlGsJ5GoG1i6hFeb
 Ums7Cpy/U+4X0hqd6RgwC5EtfhkScDMPbFj+O/8GUAEFcMYdwO8cKhSmviThqSuenM7C8dyIduU
 /sbwF2DERnuNfXT5jVyT2lg3eNmPviSHN7gA8sA2Dt7YKcoWG0Y8efY8UWeb/b4seVedwc3blvu
 9lLUaK/ETsvnhFCChzGqZz3x3CwOlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
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

On 2025-10-13 18:50, Nina Schoetterl-Glausch wrote:
> On Mon, 2025-10-13 at 15:39 +0200, Shalini Chellathurai Saroja wrote:
>> Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
>> of Control-Program Identification data in QOM.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/sclpcpi.c      |  4 ++++
>>  qapi/machine-s390x.json | 25 +++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>> 
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> index 7aa039d510..90da61b1c8 100644
>> --- a/hw/s390x/sclpcpi.c
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -54,6 +54,7 @@
>>  #include "hw/s390x/event-facility.h"
>>  #include "hw/s390x/ebcdic.h"
>>  #include "qapi/qapi-visit-machine.h"
>> +#include "qapi/qapi-events-machine-s390x.h"
>>  #include "migration/vmstate.h"
>> 
>>  typedef struct Data {
>> @@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, 
>> EventBufferHeader *evt_buf_hdr)
>>      e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>> 
>>      cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
>> +
>> +    qapi_event_send_sclp_cpi_info_available(true);
>> +
>>      return SCLP_RC_NORMAL_COMPLETION;
>>  }
>> 
>> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>> index 966dbd61d2..338653e0b8 100644
>> --- a/qapi/machine-s390x.json
>> +++ b/qapi/machine-s390x.json
>> @@ -119,3 +119,28 @@
>>  { 'command': 'query-s390x-cpu-polarization', 'returns': 
>> 'CpuPolarizationInfo',
>>    'features': [ 'unstable' ]
>>  }
>> +
>> +##
>> +# @SCLP_CPI_INFO_AVAILABLE:
>> +#
>> +# Emitted when the Control-Program Identification data is available
>> +# in the QOM tree.
>> +#
>> +# @iscpiavailable: is CPI data available in QOM
>> +#
>> +# Features:
>> +#
>> +# @unstable: This event is experimental.
>> +#
>> +# Since: 10.2
>> +#
>> +# .. qmp-example::
>> +#
>> +#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
>> +#          "data": { "iscpiavailable": true },
>> +#          "timestamp": { "seconds": 1401385907, "microseconds": 
>> 422329 } }
>> +##
>> +{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
>> +  'data': { 'iscpiavailable': 'bool' },
> 
> 
> What is the point of this payload?

The data 'iscpiavailable' is not necessary. I will remove this
and send v3. Thank you Nina for the quick feedback.

> 
>> +  'features': [ 'unstable' ]
>> +}

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

