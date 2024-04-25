Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A4EC19F53
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 16:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s02RE-00071N-FB; Thu, 25 Apr 2024 12:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s02R6-00070O-Oq; Thu, 25 Apr 2024 12:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s02R3-00006L-WD; Thu, 25 Apr 2024 12:59:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PGwmJH022843; Thu, 25 Apr 2024 16:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tIg6O+2TsRUycu+fNrQc1OUch1gaEWBmyohrwIsQVrQ=;
 b=AOh9qnnZn+NeYWL3lPecZAl/JXMzok179vlfKq5dQxfOYtYjjVm6cSW+OQEs361W/Uyg
 8bREiv87rXi+dGciB9r+8VEONBH0gtPcWyBNxmLic8aRPF+K6Evv9P3d3X1R3f2J4mPa
 12cwnUciCitYr0UiMFTp4tIqvnBl1EGJVQmkETCVnmDXw08Byvu5JYmGh3WbEUhMhjzf
 1oeWxU5/BsLuVgb/nE9iHLLQqhSVJByJEl7yJyPuNcYBL8pU6KpoKsBiKJRF2TUnQBSF
 32c4kOMuvLYSVc+gjHwSedWpNbXmWmQwmTrVLRxpPmQX5CblAXy9tqqKPz/H5uS/jEt7 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqu5kg016-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 16:58:47 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PGwla8022818;
 Thu, 25 Apr 2024 16:58:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqu5kg013-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 16:58:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PGRXFI015299; Thu, 25 Apr 2024 16:58:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmjqjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 16:58:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43PGwi4X26804984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 16:58:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB3665805E;
 Thu, 25 Apr 2024 16:58:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 675D25805A;
 Thu, 25 Apr 2024 16:58:43 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Apr 2024 16:58:43 +0000 (GMT)
Message-ID: <fa5e4d8b-eb4f-4b81-9da9-6a71912ce1f7@linux.ibm.com>
Date: Thu, 25 Apr 2024 12:58:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option
 to cpu model expansion
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com> <ZijA2XFbPwxi0F4h@redhat.com>
 <9a5fee10-4260-4311-95b9-77791217993e@linux.ibm.com>
 <d9284ef0-abdd-4976-896d-a78eb04cb349@linux.ibm.com>
 <ZipcG7Dy5t83HKMY@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <ZipcG7Dy5t83HKMY@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EJYwXIGNOVcLM6_ADe1IqtueCaAfydrr
X-Proofpoint-GUID: J0ZY3yaL-Pf7iHNKKFFSE--vY89td8VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_16,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250123
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

On 4/25/24 09:35, Daniel P. Berrangé wrote:
> On Wed, Apr 24, 2024 at 03:12:42PM -0400, Collin Walling wrote:
>> On 4/24/24 13:51, Collin Walling wrote:
>>> On 4/24/24 04:20, Daniel P. Berrangé wrote:
>>>> On Tue, Apr 23, 2024 at 05:06:53PM -0400, Collin Walling wrote:
>>>>> This optional parameter for query-cpu-model-expansion enables CPU
>>>>> model features flagged as deprecated to appear in the resulting
>>>>> list of properties.
>>>>>
>>>>> This commit does not add support beyond adding a new argument
>>>>> to the query. All queries with this option present will result
>>>>> in an error claiming this option is not supported.
>>>>>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>> ---
>>>>>  qapi/machine-target.json         | 7 ++++++-
>>>>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>>>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>>>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>>>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>>> index 29e695aa06..b9da284d2d 100644
>>>>> --- a/qapi/machine-target.json
>>>>> +++ b/qapi/machine-target.json
>>>>> @@ -285,6 +285,10 @@
>>>>>  #
>>>>>  # @type: expansion type, specifying how to expand the CPU model
>>>>>  #
>>>>> +# @disable-deprecated-feats: include CPU model features that are
>>>>> +#     flagged as deprecated. If supported, these features will appear
>>>>> +#     in the properties list paired with false.
>>>>> +#
>>>>>  # Returns: a CpuModelExpansionInfo describing the expanded CPU model
>>>>>  #
>>>>>  # Errors:
>>>>> @@ -298,7 +302,8 @@
>>>>>  ##
>>>>>  { 'command': 'query-cpu-model-expansion',
>>>>>    'data': { 'type': 'CpuModelExpansionType',
>>>>> -            'model': 'CpuModelInfo' },
>>>>> +            'model': 'CpuModelInfo',
>>>>> +            '*disable-deprecated-feats': 'bool' },
>>>>>    'returns': 'CpuModelExpansionInfo',
>>>>>    'if': { 'any': [ 'TARGET_S390X',
>>>>>                     'TARGET_I386',
>>>>
>>>> I think this is an odd design approach. Lets consider the
>>>> current output:
>>>>
>>>> (QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
>>>> {
>>>>     "return": {
>>>>         "model": {
>>>>             "name": "z14-base",
>>>>             "props": {
>>>>                 "aefsi": true,
>>>>                 "aen": true,
>>>>                 ...snip...
>>>>                 "vxpd": true,
>>>>                 "zpci": true
>>>>             }
>>>>         }
>>>>     }
>>>> }
>>>>
>>>>
>>>> If we want to inform a mgmt app of some features being deprecated,
>>>> why not just unconditionally include that info in the reply thus:
>>>>
>>>>
>>>> (QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
>>>> {
>>>>     "return": {
>>>>         "model": {
>>>>             "name": "z14-base",
>>>>             "props": {
>>>>                 "aefsi": true,
>>>>                 "aen": true,
>>>>                 ...snip...
>>>>                 "vxpd": true,
>>>>                 "zpci": true
>>>>             }
>>>>             "deprecated-props": ["ppa15", "ri"]
>>>>         }
>>>>     }
>>>> }
>>>>
>>>>
>>>>
>>>> With regards,
>>>> Daniel
>>>
>>> That's a good idea. In this way, we're not mucking up any of the CPU
>>> model information and this makes it much more clear as to which features
>>> are actually deprecated... I like this more.
>>>
>>> I'll work on this.
>>>
>>
>> Follow-up question as I look more closely to the QMP response data
>> structures: should the "deprecated-props" list be added to the
>> CpuModelInfo struct, or to the CpuModelExpansionInfo struct?
>>
>> The former makes more sense to me, as the deprecated features are tied
>> to the actual CPU model... but unsure if other QMP commands would even
>> care about this info? I will begin with this approach, and if feedback
>> in the interim strongly sways in the other direction, then it should be
>> an easy change :)
> 
> I hink CpuModelInfo makes more sense than CpuModelExpansionInfo.
> The CpuModelExpansionInfo struct feels pretty pointless to me
> in fact, since the only thing it contains is CpuModelInfo !
> 

Agreed! :)

> I think it should also be added to 'CpuDefinitionInfo', which
> is the return type of 'query-cpu-defintions'.  This command already
> has a 'unavailable-features' array listing features which the host
> does not support. Conceptually having a 'deprecated-features' array
> alongside that is a nice fit.
> 

Okay. Pending review on the v3 I posted yesterday -- if those patches
look like they're on the right track, then I can add this
"deprecated-props" array to CpuDefinitionInfo as well for the next
iteration.

> 
> 
> With regards,
> Daniel

-- 
Regards,
  Collin


