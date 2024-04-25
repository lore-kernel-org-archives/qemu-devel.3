Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D23DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 17:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s030d-0000d5-2b; Thu, 25 Apr 2024 13:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s030a-0000ca-GW; Thu, 25 Apr 2024 13:35:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s030P-0004Ie-M7; Thu, 25 Apr 2024 13:35:44 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PGXrp0007755; Thu, 25 Apr 2024 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nYrImb9mBVrs01Vk171wpxYPHYdjk5wwqO6fG60zVSU=;
 b=EUJVjmZgSFnn7y8mzgIAioNW5w6bAeBeDdToXqobCFaxoTsTr6+1n/oW6AtA3kDUZrul
 60epycMVPf/sTx/ZFzP8ZJE7LSuCtzGM7qyxbcpqwUyjtZ9bwKnlw1S+EUuteVlWUQjD
 Fe6w+OcYDVROtQOBBNrWF2iZXDT7hEiDxb8ytTbcfxJJM7W31cRXE7bcI91Dy0oDNK6u
 sHlumyYLkQCfqBv+CkXbMjj5iGgEJ5YIvPtLBm35BAsLMSWBESIVxyO6OI/YprM+qt4A
 1Us+4qYdRkqKmcggybX9zw2/kwg4vTf84hArN67DSz8cYXtRj9P3DpcdJAlHkZp5gS8d Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqtsqg4wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 17:35:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PHZKOr004726;
 Thu, 25 Apr 2024 17:35:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqtsqg4wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 17:35:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PFjH5W015277; Thu, 25 Apr 2024 17:35:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmjwrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 17:35:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43PHZIfh2753044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 17:35:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9E3158069;
 Thu, 25 Apr 2024 17:35:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C555805A;
 Thu, 25 Apr 2024 17:35:18 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Apr 2024 17:35:18 +0000 (GMT)
Message-ID: <f5d362f7-c9dd-4730-9b1c-07b14f8128a8@linux.ibm.com>
Date: Thu, 25 Apr 2024 13:35:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option
 to cpu model expansion
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com> <87bk5z5ll9.fsf@pond.sub.org>
 <809ee6ee-e66e-466f-bbf2-93ba7ec1afda@linux.ibm.com>
 <87jzkm9cn8.fsf@pond.sub.org>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87jzkm9cn8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 13lDnWhT2St1WT7IVbDQ0yXgG-5RYcrN
X-Proofpoint-GUID: dfgP1bk5vm8MfkPpo-Y89ycZalLjFSS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250127
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

On 4/25/24 02:31, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> On 4/24/24 02:19, Markus Armbruster wrote:
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> This optional parameter for query-cpu-model-expansion enables CPU
>>>> model features flagged as deprecated to appear in the resulting
>>>> list of properties.
>>>>
>>>> This commit does not add support beyond adding a new argument
>>>> to the query. All queries with this option present will result
>>>> in an error claiming this option is not supported.
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>  qapi/machine-target.json         | 7 ++++++-
>>>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index 29e695aa06..b9da284d2d 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -285,6 +285,10 @@
>>>>  #
>>>>  # @type: expansion type, specifying how to expand the CPU model
>>>>  #
>>>> +# @disable-deprecated-feats: include CPU model features that are
>>>> +#     flagged as deprecated. If supported, these features will appear
>>>> +#     in the properties list paired with false.
>>>
>>> What's the default?
>>>
>>> Which command result(s) does this affect?  Suggest to explain using
>>> unabridged example QMP input and output before and after this series.
>>
>> Fair enough. Bool defaults to false but that's not apparent in the
>> description. I will add more detail.
> 
> I didn't mean to ask for example QMP in the doc comment.  I need you to
> explain the new member to me.  Once I understand what the thing does, I
> may have suggestions on improving the doc comment.
> 
> [...]
> 

Ah, I misunderstood.  The idea behind this "disable-deprecated-feats"
option is to add/override any CPU features that are flagged as
deprecated to the props dictionary (found in the CpuModelInfo struct)
paired with the value false.

For example, the csske feature on s390x is flagged as deprecated.  If a
query-cpu-model-expansion command is created with
"disable-deprecated-feats": true, then the csske feature will show up in
the props list as "csske": false.  This also overrides any user defined
features and props that would show up in the response normally. E.g. if
the same command was executed and "csske": true was provided in the
model's properties by the user, the response will still show "csske":
false since the "disable-deprecated-feats" option takes priority (there
is a discussion with David H regarding which should take precedence --
this is a flaw in this design).

In the below QMP samples I provide a static expansion on a host model.
Pay close attention to the bpb, te, cte, and csske properties.

========
 Before
========

This is how query-cpu-model-expansion may be executed today:

{
  "execute": "query-cpu-model-expansion",
  "arguments": {
    "type": "static",
    "model": {
      "name": "host"
    }
  }
}

{
  "return": {
    "model": {
      "name": "z14.2-base",
      "props": {
        "aen": true,
        "cmmnt": true,
        "aefsi": true,
        "diag318": true,
        "mepoch": true,
        "msa8": true,
        "msa7": true,
        "msa6": true,
        "msa5": true,
        "msa4": true,
        "msa3": true,
        "msa2": true,
        "msa1": true,
        "sthyi": true,
        "edat": true,
        "ri": true,
        "edat2": true,
        "etoken": true,
        "vx": true,
        "ipter": true,
        "mepochptff": true,
        "ap": true,
        "vxeh": true,
        "vxpd": true,
        "esop": true,
        "apqi": true,
        "apft": true,
        "els": true,
        "iep": true,
        "apqci": true,
        "cte": true,		<--
        "ais": true,
        "bpb": true,		<--
        "ctop": true,
        "gs": true,
        "ppa15": true,
        "zpci": true,
        "sea_esop2": true,
        "te": true,		<--
        "cmm": true
      }
    }
  }
}

Note: csske does not even show up here.

=======
 After
=======

This is with the optional "disabled-deprecated-feats":

{
  "execute": "query-cpu-model-expansion",
  "arguments": {
    "type": "static",
    "model": {
      "name": "host"
    },
    "disabled-deprecated-feats": true
  }
}

{
  "return": {
    "model": {
      "name": "z14.2-base",
      "props": {
        "aen": true,
        "cmmnt": true,
        "aefsi": true,
        "diag318": true,
        "mepoch": true,
        "msa8": true,
        "msa7": true,
        "msa6": true,
        "msa5": true,
        "msa4": true,
        "msa3": true,
        "msa2": true,
        "msa1": true,
        "sthyi": true,
        "edat": true,
        "ri": true,
        "edat2": true,
        "etoken": true,
        "vx": true,
        "ipter": true,
        "mepochptff": true,
        "ap": true,
        "vxeh": true,
        "vxpd": true,
        "esop": true,
        "apqi": true,
        "apft": true,
        "els": true,
        "iep": true,
        "apqci": true,
        "cte": false,		<-- overridden
        "ais": true,
        "bpb": false,		<-- overridden
        "ctop": true,
        "gs": true,
        "ppa15": true,
        "zpci": true,
        "sea_esop2": true,
        "te": false,		<-- overridden
	"csske": false		<-- added to the dict
        "cmm": true
      }
    }
  }
}

Now, regarding what I have proposed for v3, this option is gone entirely
and the CpuModelInfo structure has been amended to include a new
(optional) "deprecated-props" array.  As such, a lot of the headache
with requiring compliance or conditionals to satisfy other architectures
is completely gone, as well as the requirement for any additional
options to be provided on the QMP command.

For comparison's sake, here is the v3 QMP:

{
  "execute": "query-cpu-model-expansion",
  "arguments": {
    "type": "static",
    "model": {
      "name": "host"
    }
  }
}

{
  "return": {
    "model": {
      "name": "z14.2-base",
      "deprecated-props": [
        "bpb",
        "te",
        "cte",
        "csske"
      ],
      "props": {
        "aen": true,
        "cmmnt": true,
        "aefsi": true,
        "diag318": true,
        "mepoch": true,
        "msa8": true,
        "msa7": true,
        "msa6": true,
        "msa5": true,
        "msa4": true,
        "msa3": true,
        "msa2": true,
        "msa1": true,
        "sthyi": true,
        "edat": true,
        "ri": true,
        "edat2": true,
        "etoken": true,
        "vx": true,
        "ipter": true,
        "mepochptff": true,
        "ap": true,
        "vxeh": true,
        "vxpd": true,
        "esop": true,
        "apqi": true,
        "apft": true,
        "els": true,
        "iep": true,
        "apqci": true,
        "cte": true,
        "ais": true,
        "bpb": true,
        "ctop": true,
        "gs": true,
        "ppa15": true,
        "zpci": true,
        "sea_esop2": true,
        "te": true,
        "cmm": true
      }
    }
  }
}

Hope this helps to provide more context.  Please let me know if you'd
like more info.  I am leaning towards v3's design more, as it seems a
lot cleaner overall.  I would appreciate your feedback there as well if
you have the time.

Thanks!

[...]

-- 
Regards,
  Collin


