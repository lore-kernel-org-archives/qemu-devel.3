Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA4C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 20:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXRH4-0002LV-BS; Fri, 26 Jul 2024 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXRGv-0002KQ-5y; Fri, 26 Jul 2024 16:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXRGs-00082N-BX; Fri, 26 Jul 2024 16:10:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QHSVWB003306;
 Fri, 26 Jul 2024 20:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
 L9f8ffniKYsZ8eA28xbSSQZvAVPD8AijTWcf2goRLE=; b=XajzZdm62BSUbsrYt
 uIlX6qV/JN+HNx7z5AfWYGhQWxxowhrVFHXMyaQlcgjlBqqyJBtybAOZ+JFm0eUZ
 AtMHkL+HNqj6FPd+V5WEcqA6WFYyz2hET3qe0IYzfXdM8lF2SF7u/KXyp7d8TeHT
 ZmocmWnV0406B7b5iZW0VJfoSNldkAArHATsODRRRUtmgqVJJhKma3gqyJ6NBYPD
 cahNT//H3fwibgrpdf8K3ZEains67+e/SegTcqjwN7X4Ckj0Jm+zXzGUf6wV5Y3f
 8vcEmF5BNaDeXpPim5TQktPjzqwO+jXkP7yXUW2xs4NmjM7Gj5Nz0ERQ94IK/9lV
 x8gnQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mg7s8bd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:10:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QKAMTg020299;
 Fri, 26 Jul 2024 20:10:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mg7s8bd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:10:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46QH6K1p005773; Fri, 26 Jul 2024 20:10:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pvuuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:10:21 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46QKAJiD22676112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 20:10:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EF2F5804E;
 Fri, 26 Jul 2024 20:10:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E67C5803F;
 Fri, 26 Jul 2024 20:10:18 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jul 2024 20:10:18 +0000 (GMT)
Message-ID: <05dbeed5-3ef9-4cda-af0d-8d4adf5ab6d5@linux.ibm.com>
Date: Fri, 26 Jul 2024 16:10:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/s390x: filter deprecated properties based on
 model expansion type
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240725183909.24144-1-walling@linux.ibm.com>
 <6f7b3367-4f13-44f0-8a04-f2be798e7bd3@redhat.com>
 <63ea00ec-ca05-4e52-b469-3c5b7d3da90a@linux.ibm.com>
 <f31312a9-60ba-4b34-93fa-27c4fc97d15a@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <f31312a9-60ba-4b34-93fa-27c4fc97d15a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YcKfjp3sfz6t4DUxDvC4VYchjNKwE1aW
X-Proofpoint-GUID: XYJOORqzcjkimvsE2SnDktHYSTOfwZdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On 7/26/24 4:03 PM, David Hildenbrand wrote:
> On 26.07.24 22:00, Collin Walling wrote:
>> On 7/26/24 3:57 PM, David Hildenbrand wrote:
>>> On 25.07.24 20:39, Collin Walling wrote:
>>>> Currently, there is no way to execute the query-cpu-model-expansion
>>>> command to retrieve a comprehenisve list of deprecated properties, as
>>>> the result is dependent per-model. To enable this, the expansion output
>>>> is modified as such:
>>>>
>>>> When reporting a "static" CPU model, the command will only show
>>>> deprecated properties that are a subset of the model's *enabled*
>>>> properties. This is more accurate than how the query was handled
>>>> before, which blindly reported properties that were never introduced
>>>> for certain models.
>>>>
>>>> When reporting a "full" CPU model, show the *entire* list of deprecated
>>>> properties regardless if they are supported on the model. A full
>>>> expansion outputs all known CPU model properties anyway, so it makes
>>>> sense to report all deprecated properties here too. This allows
>>>> management apps to query a single model (e.g. host) to acquire the
>>>> full list of deprecated properties.
>>>>
>>>> Additionally, the @deprecated-props array has been moved from the
>>>> CpuModelInfo struct to the CpuModelExpansionInfo struct, since the data
>>>> did not belong in the former.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>
>>>
>>> Hmmm, this does not apply on current master ... maybe because Thomas
>>> already merged part of it?
>>>
>>
>> Uh oh, sorry about that.  I'll fix this right now and post a v5 with a
>> corrected rebase on master.
> 
> It would be great if the changelog could then only describe the diff to
> already-merged:
> 
> commit da5cd572710cc4ad7e2c653614a4ab1598b17e78
> Author: Collin L. Walling <walling@linux.ibm.com>
> Date:   Thu Jul 25 14:39:09 2024 -0400
> 
>      target/s390x: filter deprecated properties based on model expansion type
>      
>      Currently, there is no way to execute the query-cpu-model-expansion
>      command to retrieve a comprehenisve list of deprecated properties, as
>      the result is dependent per-model. To enable this, the expansion output
>      is modified as such:
>      
>      When reporting a "static" CPU model, the command will only show
>      deprecated properties that are a subset of the model's *enabled*
>      properties. This is more accurate than how the query was handled
>      before, which blindly reported properties that were never introduced
>      for certain models.
>      
>      When reporting a "full" CPU model, show the *entire* list of deprecated
>      properties regardless if they are supported on the model. A full
>      expansion outputs all known CPU model properties anyway, so it makes
>      sense to report all deprecated properties here too. This allows
>      management apps to query a single model (e.g. host) to acquire the
>      full list of deprecated properties.
>      
>      Additionally, the @deprecated-props array has been moved from the
>      CpuModelInfo struct to the CpuModelExpansionInfo struct, since the data
>      did not belong in the former.
> 
> 

Okay, yeah... a previous iteration was already merged:
eed0e8ffa38f0695c0519508f6e4f5a3297cbd67.

Since that patch describes the "static" and "full" expansion stuff, I'll
rework the commit message for this one to explain that it moves the
@deprecated-props from CpuModelInfo to CpuModelExpansionInfo.

-- 
Regards,
  Collin


