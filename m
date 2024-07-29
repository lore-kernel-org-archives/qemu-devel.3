Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD3FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRhS-0000v2-Up; Mon, 29 Jul 2024 10:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sYRhO-0000fr-Rk; Mon, 29 Jul 2024 10:50:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sYRhL-0000yE-EL; Mon, 29 Jul 2024 10:50:06 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TDHoQA022870;
 Mon, 29 Jul 2024 14:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=c
 CuzDWZmHC1uEAWPZnHkf/jF4e1fCd8khXJAk2AXcxg=; b=NmtoQ6x8jlNxl0/TD
 G++V/kCbAHRmbouT3Wggoc5/nrN4yO6TDBcFxIiphyWQabduQTjIKODNKbHOyDlr
 7y94SCaVL+tZPKN3vbohEG16fqysdmiArI5BHUrh2ymwvoG0EjmqULVt0rYHj5jY
 d5EIaWGpPzf8fCYpecGbEVPCI6RMizThqjK0xqxGO8M6VBzxVz9llIIQt0ptjZRj
 kOXiDEMQBuldNMjP/zvt5YAJwvUzmz98lsylRF9utJYmJgeiu/nKcZAt7LOKxlmS
 TcHYXvaslz39gtZGrN7UZCKL9QcQBfY0Hy3896TrZPtj919jtP5TGAFPih4WYw7O
 Uj64Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mwdm4r04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 14:49:44 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TEninx030123;
 Mon, 29 Jul 2024 14:49:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mwdm4qyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 14:49:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46TE5Vgq018867; Mon, 29 Jul 2024 14:49:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pf8a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 14:49:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46TEneVd41288008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 14:49:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B65558061;
 Mon, 29 Jul 2024 14:49:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A81025806E;
 Mon, 29 Jul 2024 14:49:39 +0000 (GMT)
Received: from [9.67.22.193] (unknown [9.67.22.193])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jul 2024 14:49:39 +0000 (GMT)
Message-ID: <63774cce-d8f6-4cfd-9e0b-0a8244653fab@linux.ibm.com>
Date: Mon, 29 Jul 2024 10:49:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
 <87a5i0cmht.fsf@pond.sub.org>
 <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
 <87msm0b6zj.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87msm0b6zj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oLzngipvA6x6YUkL_KPkJxa7OBTTTi-_
X-Proofpoint-ORIG-GUID: vtwVYZpy-ZyVLFJoY7ccP-W9lWGU8WzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=825 impostorscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/29/24 10:36 AM, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>>>>> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
>>>>> @deprecated-props.
>>>>>
>>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index 09dec2b9bb..0be95d559c 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -253,7 +253,7 @@
>>>>    ##
>>>>    { 'struct': 'CpuModelExpansionInfo',
>>>>      'data': { 'model': 'CpuModelInfo',
>>>> -            '*deprecated-props': ['str'] },
>>>> +            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
>>>>      'if': { 'any': [ 'TARGET_S390X',
>>>>                       'TARGET_I386',
>>>>                       'TARGET_ARM',
>>>>
>>>>
>>>> Should do the trick, right?
>>>
>>> Yes.  Break the line before 'if', please.
>>
>> Ack
>>
>> [...]
>>
>>>
>>> Questions?
>>
>> As clear as it can get, thanks! :)
>>
>> That would leave us with:
> 
> Looks good to me!
> 
> 

Fine by me as well.  Thanks you both for taking care of this.

-- 
Regards,
  Collin


