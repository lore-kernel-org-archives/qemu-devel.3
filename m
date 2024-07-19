Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87801C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpLl-0007F7-Vz; Fri, 19 Jul 2024 11:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUpLk-000796-3B; Fri, 19 Jul 2024 11:16:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUpLh-0005wN-QG; Fri, 19 Jul 2024 11:16:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JEoiOq031575;
 Fri, 19 Jul 2024 15:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 vaedzC0vh3G+9LdMnaRjuOD08oZIz3/Sy/JA9wl/VXE=; b=lU5CPUsCWP1A73Nc
 wp0QNBVVJvfUDt098XNQdcuMXQZrb3SP59aT6MZL+UJfJAYdp4GnmmfpeB+iAaCi
 ARB8LEqxTy+9ggaK/GADJYGAfZ2mIIFB2+KRYI4K+ErJc1/ooQaiFG20z5psGzZm
 cBj5LJS2gf6WPWEw1PQ13HKxmlEcwJbn6rdoObJEhj1bZicw1+nTTZAS/yzNPUaE
 Kfcqe8MOJFTyb1Gy6s41N59yoH5WZsYxEEGiCp20uvjAsyFx+bjrX05CVHDPiyL/
 t7FFT0WOmN2aLh1vjxVIrVVkxqjfLftFY5m8FWgazSCmuEEiUlocmKJYVPkcnRlv
 +XHCJA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fs2908gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:16:30 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46JFGU3w003276;
 Fri, 19 Jul 2024 15:16:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fs2908gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:16:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46JC0Eba006082; Fri, 19 Jul 2024 15:16:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmqs71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:16:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46JFGQMa28967556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 15:16:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E6B85805A;
 Fri, 19 Jul 2024 15:16:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A6565806A;
 Fri, 19 Jul 2024 15:16:25 +0000 (GMT)
Received: from [9.67.171.109] (unknown [9.67.171.109])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jul 2024 15:16:25 +0000 (GMT)
Message-ID: <64b0b74b-6e5e-4538-bb73-d03b36975ec0@linux.ibm.com>
Date: Fri, 19 Jul 2024 11:16:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240716173253.28533-1-walling@linux.ibm.com>
 <87le1yn7jy.fsf@pond.sub.org>
 <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
 <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T2D__zA2tTd35zx2t0WZ-UGS2dQem6Nq
X-Proofpoint-ORIG-GUID: AnoQFtel7owjZYrw753STo8jkF3wjwV2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 7/19/24 6:16 AM, Thomas Huth wrote:
> On 18/07/2024 20.22, Collin Walling wrote:
>> On 7/18/24 9:39 AM, Markus Armbruster wrote:
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> As s390 CPU models progress and deprecated properties are dropped
>>>> outright, it will be cumbersome for management apps to query the host
>>>> for a comprehensive list of deprecated properties that will need to be
>>>> disabled on older models. To remedy this, the query-cpu-model-expansion
>>>> output now behaves by filtering deprecated properties based on the
>>>> expansion type instead of filtering based off of the model's full set
>>>> of features:
>>>>
>>>> When reporting a static CPU model, only show deprecated properties that
>>>> are a subset of the model's enabled features.
>>>>
>>>> When reporting a full CPU model, show the entire list of deprecated
>>>> properties regardless if they are supported on the model.
>>>>
>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>>      v2
>>>>      - Changed commit message
>>>>      - Added documentation reflecting this change
>>>>      - Made code changes that more accurately filter the deprecated
>>>>          properties based on expansion type.  This change makes it
>>>>          so that the deprecated-properties reported for a static model
>>>>          expansion are a subset of the model's properties instead of
>>>>          the model's full-definition properties.
>>>>
>>>>          For example:
>>>>
>>>>          Previously, the z900 static model would report 'bpb' in the
>>>>          list of deprecated-properties.  However, this prop is *not*
>>>>          a part of the model's feature set, leading to some inaccuracy
>>>>          (albeit harmless).
>>>>
>>>>          Now, this feature will not show during a static expansion.
>>>>          It will, however, show up in a full expansion (along with
>>>>          the rest of the list: 'csske', 'te', 'cte').
>>>>
>>>> @David, I've elected to respectully forgo adding your ack-by on this
>>>> iteration since I have changed the code (and therefore the behavior)
>>>> between this version and the previous in case you do not agree with
>>>> these adjustments.
>>>>
>>>> ---
>>>>   qapi/machine-target.json         |  8 ++++++--
>>>>   target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index a8d9ec87f5..d151504f25 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -21,8 +21,12 @@
>>>>   # @props: a dictionary of QOM properties to be applied
>>>>   #
>>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>>> -#     definition list of properties. (since 9.1)
>>>> +#     by the CPU vendor.  (since 9.1).
>>>> +#
>>>> +# .. note:: Since 9.1, the list of deprecated props were always a subset
>>>> +#    of the model's full-definition list of properites. Now, this list is
>>>> +#    populated with the model's enabled property set when delta changes
>>>> +#    are applied. All deprecated properties are reported otherwise.
>>>
>>> I'm confused.
>>>
>>> "Since 9.1, the list of deprecated props were ..." and "Now, this list
>>> is" sounds like you're explaining behavior before and after a change.
>>> What change?  Since only released behavior matters, and
>>> @deprecated-props is new, there is no old behavior to document, isn't
>>> it?
>>
>> I admittedly had some difficulty articulating the change introduced by
>> this patch.  The @deprecated-props array, as well as a way for s390x to
>> populate it, was introduced in release 9.1.  Prior to this patch, the
>> deprecated-props list was filtered by the CPU model's full feature set.
>> I attempted to explain this with:
>>
>> "Since 9.1, the list of deprecated props were always a subset of the
>> model's full-definition list of properties."
> 
> Version 9.1 has not been released yet (see 
> https://wiki.qemu.org/Planning/9.1), so I agree with Markus, this sounds 
> confusing/wrong to me, too.
> 
>   Thomas
> 
> 
> 

Ah, well then pardon my ignorance of the release schedule.  With that
said my `note` makes 0 sense to keep here.

-- 
Regards,
  Collin


