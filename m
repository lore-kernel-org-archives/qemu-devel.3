Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E77CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 20:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Rxr-0003fz-1Q; Fri, 26 Apr 2024 16:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0Rxn-0003dZ-IB; Fri, 26 Apr 2024 16:14:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0Rxl-0002e4-FO; Fri, 26 Apr 2024 16:14:31 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QK5MF3020600; Fri, 26 Apr 2024 20:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wmkJ8JKaZcBqJihGssmYz2xCi4YP5pOZhzO/JwBzXzM=;
 b=BCUE+3WY8PVfcUV/wehv3NTmzLstyiU95W9pvHL4dpmEXpdvalotDIHzgeZszC9d4/Xz
 N1nB81DtR0FcpxBn50emFdWeLyOKtvLgvx630OB5HZ/RM/1zWMtIZ3Q4pHJ9JiU0hOy0
 6mJ82HeqWXTqvhmmBYffumLVnZSFjrxRBNQ8fQehy2giwntC/inBSxpID8tYoJUEpkJ7
 HBZ2oNQ0pqe+mPZGjXeMmJBlzJib2fiahNysbJJuOLgOy6lNW4MoBP3a+GKTFwt71Mic
 mBPDJEQs4A+xZMpcBsz9NH/WHlcSbMePintQ36h0dZH2LlGI7KHjRug2B4U+KKPEkzF8 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrjye00jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 20:14:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QKEJqa000884;
 Fri, 26 Apr 2024 20:14:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrjye00hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 20:14:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QH9VsN015299; Fri, 26 Apr 2024 20:12:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmsfxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 20:12:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QKBwhE47710882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 20:12:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0970A58051;
 Fri, 26 Apr 2024 20:11:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EFB15805A;
 Fri, 26 Apr 2024 20:11:57 +0000 (GMT)
Received: from [9.67.41.19] (unknown [9.67.41.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 20:11:57 +0000 (GMT)
Message-ID: <f966a24e-dd7e-408c-b394-cc8650786713@linux.ibm.com>
Date: Fri, 26 Apr 2024 16:11:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net
References: <20240424215633.48906-1-walling@linux.ibm.com>
 <20240424215633.48906-2-walling@linux.ibm.com> <87o79wy0pv.fsf@pond.sub.org>
 <8c265c38-d9aa-43bf-a0b6-f70a52c5acf4@linux.ibm.com>
In-Reply-To: <8c265c38-d9aa-43bf-a0b6-f70a52c5acf4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nZ-AtOp1Aj_TLisOVGVfOTa4tK1-3nt2
X-Proofpoint-GUID: yle3bvWxvCwosH0l3GxtH6Cc0roX_q29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_17,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 4/26/24 13:35, Collin Walling wrote:
> On 4/26/24 04:42, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>>
>>> Retain a list of deprecated features disjoint from any particular
>>> CPU model. A query-cpu-model-expansion reply will now provide a list of
>>> properties (i.e. features) that are flagged as deprecated. Example:
>>>
>>>     {
>>>       "return": {
>>>         "model": {
>>>           "name": "z14.2-base",
>>>           "deprecated-props": [
>>>             "bpb",
>>>             "csske"
>>>           ],
>>>           "props": {
>>>             "pfmfi": false,
>>>             "exrl": true,
>>>             ...a lot more props...
>>>             "skey": false,
>>>             "vxpdeh2": false
>>>           }
>>>         }
>>>       }
>>>     }
>>>
>>> It is recommended that s390 guests operate with these features
>>> explicitly disabled to ensure compatability with future hardware.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>  qapi/machine-target.json         |  5 ++++-
>>>  target/s390x/cpu_features.c      | 14 ++++++++++++++
>>>  target/s390x/cpu_features.h      |  1 +
>>>  target/s390x/cpu_models_sysemu.c |  6 ++++++
>>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index 29e695aa06..3799a60e3d 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -20,11 +20,14 @@
>>>  #
>>>  # @props: a dictionary of QOM properties to be applied
>>>  #
>>> +# @deprecated-props: a list of QOM properties that are flagged as deprecated
>>
>> Deprecated by whom?  QEMU?  The CPU vendor?
>>
> 
> The CPU vendor would be the one who decides which props are deprecated.
> How about:
> 
> # @deprecated-props: a list of QOM properties that are flagged as
> 		     deprecated by the CPU vendor
> 

^ let's ignore the incorrect indentation here.

Actually, I may be wildly incorrect with my description by referring to
this as "a list of QOM properties", when in fact this is just an array
of strings.  Also, the deprecated props may not always reflect the
features that are found by a static expansion, so I added another
sentence to describe that they are a part of a full model expansion.

# @deprecated-props: a list of properties that are flagged as deprecated
#     by the CPU vendor.  These props are a subset of the model's full
#     definition list of properties. (since X.Y)

I may need some help with the wording on the 2nd sentence.

[...]

> 
>>> +#
>>>  # Since: 2.8
>>>  ##
>>>  { 'struct': 'CpuModelInfo',
>>>    'data': { 'name': 'str',
>>> -            '*props': 'any' } }
>>> +            '*props': 'any',
>>> +            '*deprecated-props': ['str'] } }
>>>  
>>>  ##
>>>  # @CpuModelExpansionType:
>>
>> [...]
>>
>>
> 

-- 
Regards,
  Collin


