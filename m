Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DE9C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTTJ-000318-Jv; Fri, 06 Jun 2025 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uNTTG-0002zG-RT; Fri, 06 Jun 2025 05:34:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uNTTD-0002Iu-I4; Fri, 06 Jun 2025 05:34:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5563humB026579;
 Fri, 6 Jun 2025 09:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d8t4Rs
 WCiyKxz9rBqJiypIeYyyZ2kuwKKk5UJyvq+9g=; b=GcFG3xU/nqglgjT2iHMHCl
 m+VBRDeww/PIdEYWxMHpOOsedufZg2kJZX5eue+zl2Yzw1g7g/gdhXOmP/bl/7Ol
 kw0IuEaMLpX6ZngDVlZPanKEAeNFUB4T/4i+1A8S662lLlRXET9Dh9qDVTLzRnNz
 FiqJxDvQ07FgWZaR3ZaFjxddSN4fdZjv3bmAOKFUbk7EBporM/2+IgS82ki5EhVz
 Co6kFZJA/FWlquRpOI8m3/daluU73PJIgIBd7D1tD7VeyASs/X+NI4clK31yaLNW
 XNua3mwWl5T8oxLyIATgY6FaLmPcY5EqVJ8mRxZdReMsaiYSTA5d8/cpmv9J4DhQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwuw07s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 09:34:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5566riXY019889;
 Fri, 6 Jun 2025 09:34:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p8tkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 09:34:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5569YMHE29426212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 09:34:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AABD58054;
 Fri,  6 Jun 2025 09:34:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4DDD5803F;
 Fri,  6 Jun 2025 09:34:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 09:34:21 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 06 Jun 2025 11:34:21 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
Message-ID: <7052f152ca5ce5c15275c9a57067a571@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA4MiBTYWx0ZWRfX3pTrzwDKX8fI
 05rtoaksmt2qADeRRFenbAOtnQBznnZSLLTiTEax56CtmSLRwHBs2If1kT/wv2Cf4qxzO1L9hi/
 APQw3Qluhov+/ej3YbzjKiSpONfyYTucKDM1sh/ERJXTkoKGPazgpsK39Th/I8LWZpTeorOhixb
 zQcSJjwOUIkbrX4xz5a+KtCBuxoRPzec7ojEWUZ/ciTfVJJTy4hhb2/Qr+p8uZqRqhSpDJ6w+a2
 UZJn+WIXwJ61Uo56S/eQLZi/dcbLPvlae7YceuXp2gGw7no1DekJ0ApBIPGn5Q5qf/vCvsmvOUK
 oRoKm+PTgaA1XrKPebwwktfRUtdZunFlwelrhFp4Spsz4B6OIi7GDw7mKOK5H2z+zpMmnWjlems
 qeMohV9Mo0+aZsrjkavskq88oPSwseuqqmsoxJCvdrSV/KpioU5RmFgB3nOP5KKNd6p03eBI
X-Proofpoint-GUID: lPSv9-gklqi02OnH7MSUz2mbQK-V9W70
X-Proofpoint-ORIG-GUID: lPSv9-gklqi02OnH7MSUz2mbQK-V9W70
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6842b620 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=LIxmkEhz09HK_Sj9jhYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 2025-06-05 13:56, Thomas Huth wrote:
> On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
>> On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
>>> Add Control-Program Identification (CPI) data to the QEMU Object
>>> Model (QOM), along with the timestamp in which the data was received
>>> as shown below.
>> 
>> [...]
>>> 
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> ---
>>>   hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>>>   include/hw/s390x/event-facility.h |  5 +++
>>>   qapi/machine.json                 | 58 
>>> +++++++++++++++++++++++++++++++
>>>   3 files changed, 110 insertions(+)
>>> 
>>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>>> index 935fa87acd..ec711e2291 100644
>>> --- a/hw/s390x/sclpcpi.c
>>> +++ b/hw/s390x/sclpcpi.c
>>> @@ -15,7 +15,9 @@
>>>     */
>> 
>> [...]
>>>   +static void cpi_init(Object *obj)
>>> +{
>>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>>> +
>>> +    object_property_add_str(obj, "system_type", get_system_type, 
>>> NULL);
>>> +    object_property_add_str(obj, "system_name", get_system_name, 
>>> NULL);
>>> +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, 
>>> NULL);
>>> +    object_property_add_uint64_ptr(obj, "system_level", 
>>> &(e->system_level),
>>> +                                   OBJ_PROP_FLAG_READ);
>>> +    object_property_add_uint64_ptr(obj, "timestamp", 
>>> &(e->timestamp),
>>> +                                   OBJ_PROP_FLAG_READ);
>>> +}
>> 
>> I think it would be cleaner if those were class properties.
>> You could use object_class_property_add_str in cpi_class_init,
>> but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
>> device_class_set_props.
> 
> For "normal" properties I'd say "yes" ... but in this case, this would
> also allow the user to set the properties from the host side - which
> would be a little bit weird? So I think it might be cleaner to keep it
> this way here without the "setter" functions? WDYT?
> 
>>> +{ 'struct': 'S390ControlProgramId', 'data': {
>>> +     'system-type': 'str',
>>> +     'system-name': 'str',
>>> +     'system-level': 'uint64',
>>> +     'sysplex-name': 'str',
>>> +     'timestamp': 'uint64' } }
>> 
>> This is unused now, so you can get rid of it and put the
>> documentation sclpcpi.c.
> 
> Agreed, that looks like it could be cleaned up now, indeed.
> 

Hello Thomas, Nina,

Yes, I will do this. I am sorry that I missed to do this earlier.
Thank you very much for the quick review.



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

