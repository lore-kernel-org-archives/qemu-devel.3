Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD6BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 19:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzi6g-0006lA-KU; Wed, 24 Apr 2024 15:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzi6d-0006ih-Gr; Wed, 24 Apr 2024 15:16:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzi6a-0000WL-06; Wed, 24 Apr 2024 15:16:34 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OJGLnU020404; Wed, 24 Apr 2024 19:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6woVJFfTEcvEzGI+HID9bLE1NUbtXzBUwvCJXiWJwRQ=;
 b=S4tm0pSylfN8lxcLWipDqbdoRMcSMYmq58TWwgKyfY5+lL93Wbpb/1ptyO2kisI1syl7
 9158dT238HYRqqP4cqAGkUY0FtJIF0OmgkTyCmSNI7iAT0Jd+vDiCvJ36My4j1cSy3WM
 QDGbKUznOIXygY0FsAORWv5+cAFNvHuBYCx0DGQxD9aCtW+oK9RjL1lNxOQ5UGxJOutz
 pTyqUwZnl6ap8M0396QEeAbjqAV7p8Q+X8K/jzk2DK8AX6UqctYb2CCowTrGDEQA4kje
 tVkwMRG3hoEK3PPjzstnDEJmqlA5DN8W4NHhA/FdpwR/dtINZKSg/JhrQR1l8XAlsig5 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq7kc02d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 19:16:20 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OJGKei020387;
 Wed, 24 Apr 2024 19:16:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq7kc02d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 19:16:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OIMokh015277; Wed, 24 Apr 2024 19:12:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmdc00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 19:12:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OJChWf1508048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 19:12:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 595EA58069;
 Wed, 24 Apr 2024 19:12:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDAFE5805F;
 Wed, 24 Apr 2024 19:12:42 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Apr 2024 19:12:42 +0000 (GMT)
Message-ID: <d9284ef0-abdd-4976-896d-a78eb04cb349@linux.ibm.com>
Date: Wed, 24 Apr 2024 15:12:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option
 to cpu model expansion
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com> <ZijA2XFbPwxi0F4h@redhat.com>
 <9a5fee10-4260-4311-95b9-77791217993e@linux.ibm.com>
In-Reply-To: <9a5fee10-4260-4311-95b9-77791217993e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZCyQUzxMvoDU6fTzEhCybWfutSULHDj2
X-Proofpoint-ORIG-GUID: oRfuMj6Xs8y2NhzfNkHZmvEfIPoLCNZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_16,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 4/24/24 13:51, Collin Walling wrote:
> On 4/24/24 04:20, Daniel P. Berrangé wrote:
>> On Tue, Apr 23, 2024 at 05:06:53PM -0400, Collin Walling wrote:
>>> This optional parameter for query-cpu-model-expansion enables CPU
>>> model features flagged as deprecated to appear in the resulting
>>> list of properties.
>>>
>>> This commit does not add support beyond adding a new argument
>>> to the query. All queries with this option present will result
>>> in an error claiming this option is not supported.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>  qapi/machine-target.json         | 7 ++++++-
>>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index 29e695aa06..b9da284d2d 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -285,6 +285,10 @@
>>>  #
>>>  # @type: expansion type, specifying how to expand the CPU model
>>>  #
>>> +# @disable-deprecated-feats: include CPU model features that are
>>> +#     flagged as deprecated. If supported, these features will appear
>>> +#     in the properties list paired with false.
>>> +#
>>>  # Returns: a CpuModelExpansionInfo describing the expanded CPU model
>>>  #
>>>  # Errors:
>>> @@ -298,7 +302,8 @@
>>>  ##
>>>  { 'command': 'query-cpu-model-expansion',
>>>    'data': { 'type': 'CpuModelExpansionType',
>>> -            'model': 'CpuModelInfo' },
>>> +            'model': 'CpuModelInfo',
>>> +            '*disable-deprecated-feats': 'bool' },
>>>    'returns': 'CpuModelExpansionInfo',
>>>    'if': { 'any': [ 'TARGET_S390X',
>>>                     'TARGET_I386',
>>
>> I think this is an odd design approach. Lets consider the
>> current output:
>>
>> (QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
>> {
>>     "return": {
>>         "model": {
>>             "name": "z14-base",
>>             "props": {
>>                 "aefsi": true,
>>                 "aen": true,
>>                 ...snip...
>>                 "vxpd": true,
>>                 "zpci": true
>>             }
>>         }
>>     }
>> }
>>
>>
>> If we want to inform a mgmt app of some features being deprecated,
>> why not just unconditionally include that info in the reply thus:
>>
>>
>> (QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
>> {
>>     "return": {
>>         "model": {
>>             "name": "z14-base",
>>             "props": {
>>                 "aefsi": true,
>>                 "aen": true,
>>                 ...snip...
>>                 "vxpd": true,
>>                 "zpci": true
>>             }
>>             "deprecated-props": ["ppa15", "ri"]
>>         }
>>     }
>> }
>>
>>
>>
>> With regards,
>> Daniel
> 
> That's a good idea. In this way, we're not mucking up any of the CPU
> model information and this makes it much more clear as to which features
> are actually deprecated... I like this more.
> 
> I'll work on this.
> 

Follow-up question as I look more closely to the QMP response data
structures: should the "deprecated-props" list be added to the
CpuModelInfo struct, or to the CpuModelExpansionInfo struct?

The former makes more sense to me, as the deprecated features are tied
to the actual CPU model... but unsure if other QMP commands would even
care about this info? I will begin with this approach, and if feedback
in the interim strongly sways in the other direction, then it should be
an easy change :)

-- 
Regards,
  Collin


