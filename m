Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C97C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrxA-0007Kq-Ln; Thu, 09 Jul 2026 12:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1whrx9-0007KA-1U; Thu, 09 Jul 2026 12:50:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1whrx7-0005C5-48; Thu, 09 Jul 2026 12:50:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669GoHG92880183; Thu, 9 Jul 2026 16:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+r6SDq
 EzqINgUUfDL896gt/if/SgYAaa/KpA1JTKpLA=; b=Hbe4ttJiim3nLNLcK+vOOb
 gIQVRBTX3O5q2fgtYrUWoZH2knQLGpqJblW81uyx9aPd9w9IODvOBaqmZg8N6Q8u
 btr6rvsV5Ei8PXPUfWKs7nXrop3yA6pvy+3RJZ8Ig5x5aK3PmbSA9tj0nCM9kpKN
 LC6UrPjPOwXCwCOPnRYQ3/kXu0sNYtGmDnltaq+NOprXyK3+3eH9ZkJf6ZKinJAj
 ITPbx6G8f4jpOjQ1Mq1bENxOE5i4K/54B6I2PXCPu3WBE0H4hlCmKftWWKghjkw2
 lNmRSwDyIfzWrKw8EwKzvUvbVpwL7ohJZa5OAoG2jnGk6NhZX8GC/OL2+e1EzcoQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknt64x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 16:50:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669GYeQE027194;
 Thu, 9 Jul 2026 16:50:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwe836-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 16:50:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669GoF3n23986750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 16:50:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611A458057;
 Thu,  9 Jul 2026 16:50:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5C655805D;
 Thu,  9 Jul 2026 16:50:14 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2026 16:50:14 +0000 (GMT)
Message-ID: <526e5b56-ee82-45e1-b2fc-d8d9a073d3ff@linux.ibm.com>
Date: Thu, 9 Jul 2026 12:50:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: query-cpu-definitions filter deprecated
 features
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, cohuck@redhat.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20260708202149.103063-1-walling@linux.ibm.com>
 <87mrw0hhix.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87mrw0hhix.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fd149 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=MFNUwojNkRGJtbRpc4YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g2HA04JeGrPcBcLdH1_tGyKeDJ5yVunL
X-Proofpoint-ORIG-GUID: g2HA04JeGrPcBcLdH1_tGyKeDJ5yVunL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfX8fxU1HJcmivl
 vtUuIwCwcU6qvatl6Ni8oFldXmrFPfRsGj6YVJvP58ftguUxO8rYi5VnR3VkI2oBrxDRk3SRVtP
 wmPmfasejLxX+pAuSOMjoUSub5ESIjo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfX6ZGcjooi7tvT
 m/XjaNWHAgIy/0AqTBMagC9FR2U1buX1VdjunX8o4NlBivmn0MygIblAMTpXbzD//LYGy6LjADB
 dWPZEglI0I74xOblLaz7JNAp3E7tmTAaftWw77CPCYhLXBw1IpMJ63skAMUHR29g5X+KbBrC1CE
 6jQ07OSpfUqvIMcqH0O6MEfwQiQY3oMx7/ZIkZpadQPHaRgojuZkS3RPdISCjD3KmHA4uO2NxNF
 oj28Ch4bt5dQdYQ2HtwBf9sQkFxeiGHZ/TjQxrHPGSlrg7MtJqANeMIaO41pgnqrvwfdNvQ06OC
 +iMVToM3aLyt1qHTzUjNfX/yaCqHtd8IlngsDlnOwHr74iss2XEgkvTimlODk0RqOT80P/Y16uF
 /TCp7TrITy0WdXlmL6z3EUP+pJkeCxAKu7IMY76YG0pMaYlbs2ovg+YTC2c3uKaHZaKGCpC9mUw
 YIKe540KfcUeCWi/NEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/9/26 01:13, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> Part of the query-cpu-definitions return payload includes an array of
>> of "unavailable-features" which helps determine if the CPU model is
>> compatible with the system's configuration.  When a KVM guest is
>> using a CPU model with deprecated features disabled,
>> query-cpu-definitions will claim that certain models are incompatible
>> due to these features missing.
>>
>> Since deprecated features are preferred to be disabled for s390 CPU
>> models, lets filter them out from the "missing" features list.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>
>> Examples output of query-cpu-definitions ran on a gen17a host:
>>
>> WithOUT patch:
>>
>> ```
>> {
>>   "return": [
>>     {
>>       "name": "z13",
>>       "typename": "z13-s390x-cpu",
>>       "unavailable-features": [
>>         "csske"
>>       ],
>>       "static": false,
>>       "migration-safe": true,
>>       "deprecated": false
>>     },
>>     ...
>> ```
>>
>> WITH patch:
>>
>> ```
>> {
>>   "return": [
>>     {
>>       "name": "z13",
>>       "typename": "z13-s390x-cpu",
>>       "unavailable-features": [],
>>       "static": false,
>>       "migration-safe": true,
>>       "deprecated": false
>>     },
>>     ...
>> ```
> 
> I'd put this right into the commit message.
> 
> Possibly stupid question (I know nothing about the subject matter): any
> compatibility ramifications?  Does the change need to be tied to machine
> type version?
> 
> 

This is a valid question, and one we raised internally when performing
some regression tests (specifically about differing QEMU and libvirt
versions).  Functionally, there should be no compatibility ramifications.

However, you got me to investigating some other behaviors, specifically
regarding how libvirt utilizes this command.

This patch introduces a possible discrepancy between libvirt's domain
capabilities report and what the user may expect when defining a domain
with a CPU model within that report.

Here's a rundown of how libvirt utilizes the query-cpu-definition data
command WITHOUT the patch:

Let's say I'm running on a z17 machine.  On this hardware generation,
some CPU features have been dropped completely (e.g. csske). Now, being
on a newer generation machine, I would assume that I could start a guest
with an older model (e.g. z14). However, running virsh domcapabilities,
libvirt tells me otherwise:

      <model usable='no' vendor='IBM'>z14</model>
      <blockers model='z14'>
        <feature name='csske'/>
      </blockers>

But this is not entirely true.  I could create a domain with a z14 CPU
model and either explicitly disable csske, or append the
deprecated_features='off' attribute to the <cpu> element and the domain
will start successfully.

Now, let's run through this scenario WITH the patch:

Running virsh domcapabilities, I see:

      <model usable='yes' vendor='IBM'>z14</model>

But this is _also_ not entirely true: a user cannot simply define a
domain using a z14 CPU model without further adjustments.  This invokes
the following error:

      qemu-system-s390x: Some features requested in the CPU model are
      not available in the current configuration: csske
      Consider a different accelerator, QEMU, or kernel version

Again, the user can either explicitly disable this feature or use the
deprecated_features attribute and everything is fine, but that isn't
immediately clear.

I am now wondering if this filtering should be handled via libvirt
instead of QEMU?  Right now, it is possible to run virsh domcapabilities
and provide a --disable-deprecated-features flag, which currently only
presents the host-model with deprecated features disabled.  I wonder if
this functionality should be extended to the custom models in this
output as well?  This could be done by simply checking the blocking
features against the deprecated features and filtering them out when the
command flag is provided.

I've added Christian, Hendrik, and Boris to CC to gather their input.

Thank you for posing your question.

-- 
Regards,
  Collin

