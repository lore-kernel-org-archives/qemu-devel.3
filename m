Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E832AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PTu-0007Ii-44; Fri, 26 Apr 2024 13:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0PTp-000732-BQ; Fri, 26 Apr 2024 13:35:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0PTn-0006DK-47; Fri, 26 Apr 2024 13:35:24 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHRQNW029818; Fri, 26 Apr 2024 17:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vNmmZU5vzqHn8GZixhWx+KfJfMHL3P2Dg5hRADs8XKs=;
 b=sDx2aPSr8l4lm4kJeq8sMA6PaiwM7jfT36Nr6caAc0c2vLmx2wrCq+bZCOAQnkaFHixx
 lo4f0O2M6Q7m0hsmCxKF52qs4/0BFZ9Pl/pbGcp1gXOneCdzWrCPFAa7TjFiQCd5ib2f
 9KdnxjOi90+G5SshEmF+FX9ShfU+ldFKcgcTn171A1SYijzG0TTKWMAAHyyFMxMMh1/z
 3sXg5qdt+gj+3v5BjXpsLeJIxNc+V5Mkp5WCAlBRvjlwrgbmNcUkNltWQsvw76rM6JJz
 JJSDHpKlrxIjlgxaxsIj7cpGm/USv3YOaPxf9BwdSx5t1SO4bQ3KHam6X1p/YNkcNxZ8 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgp6r0dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:35:15 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHZEnG010872;
 Fri, 26 Apr 2024 17:35:14 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgp6r0dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:35:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QEn1Lj028356; Fri, 26 Apr 2024 17:35:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr30h39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:35:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHZAwr39060014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:35:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8518F5806F;
 Fri, 26 Apr 2024 17:35:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0685805E;
 Fri, 26 Apr 2024 17:35:09 +0000 (GMT)
Received: from [9.67.41.19] (unknown [9.67.41.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:35:09 +0000 (GMT)
Message-ID: <8c265c38-d9aa-43bf-a0b6-f70a52c5acf4@linux.ibm.com>
Date: Fri, 26 Apr 2024 13:35:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net
References: <20240424215633.48906-1-walling@linux.ibm.com>
 <20240424215633.48906-2-walling@linux.ibm.com> <87o79wy0pv.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87o79wy0pv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BPmZm1FZM7B6rNpqpJ2wo1H_g_8T94sg
X-Proofpoint-ORIG-GUID: 6IhDocvs9K9yVGyqYFnxGyF-qLM2OnLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260119
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

On 4/26/24 04:42, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> Retain a list of deprecated features disjoint from any particular
>> CPU model. A query-cpu-model-expansion reply will now provide a list of
>> properties (i.e. features) that are flagged as deprecated. Example:
>>
>>     {
>>       "return": {
>>         "model": {
>>           "name": "z14.2-base",
>>           "deprecated-props": [
>>             "bpb",
>>             "csske"
>>           ],
>>           "props": {
>>             "pfmfi": false,
>>             "exrl": true,
>>             ...a lot more props...
>>             "skey": false,
>>             "vxpdeh2": false
>>           }
>>         }
>>       }
>>     }
>>
>> It is recommended that s390 guests operate with these features
>> explicitly disabled to ensure compatability with future hardware.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  qapi/machine-target.json         |  5 ++++-
>>  target/s390x/cpu_features.c      | 14 ++++++++++++++
>>  target/s390x/cpu_features.h      |  1 +
>>  target/s390x/cpu_models_sysemu.c |  6 ++++++
>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 29e695aa06..3799a60e3d 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -20,11 +20,14 @@
>>  #
>>  # @props: a dictionary of QOM properties to be applied
>>  #
>> +# @deprecated-props: a list of QOM properties that are flagged as deprecated
> 
> Deprecated by whom?  QEMU?  The CPU vendor?
> 

The CPU vendor would be the one who decides which props are deprecated.
How about:

# @deprecated-props: a list of QOM properties that are flagged as
		     deprecated by the CPU vendor

> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 

Noted for next iteration.  Thank you.

>> +#
>>  # Since: 2.8
>>  ##
>>  { 'struct': 'CpuModelInfo',
>>    'data': { 'name': 'str',
>> -            '*props': 'any' } }
>> +            '*props': 'any',
>> +            '*deprecated-props': ['str'] } }
>>  
>>  ##
>>  # @CpuModelExpansionType:
> 
> [...]
> 
> 

-- 
Regards,
  Collin


