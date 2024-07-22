Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B22EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuNG-00046a-2m; Mon, 22 Jul 2024 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sVuND-00045C-8w; Mon, 22 Jul 2024 10:50:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sVuNA-0001O2-Qc; Mon, 22 Jul 2024 10:50:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MDpVFv004052;
 Mon, 22 Jul 2024 14:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
 SqlrLi3038mrMeL7628MtfKD4vx9WeZD01grs7xCSw=; b=l6CPdj6wgkN6/vVJr
 yL/8mcOBsxZx3U/G7SLRFu26VtX/syK6ULf0wl7bbjtjVyNC7h0bNslMhwmvJ0Yx
 geTxbJGWFceYYhPz8FS7h/EYhZfI398rt8laMNAPFZalyZy7Y854O9/bb8HpC0Zn
 sdNLtPzOU+ch8D7LgDwdGNarthoEkqBWGzWy/bX20wF0c9EI8cyEEvD7NsxmPABs
 yXRXQtvULy5x6KHdKHmGz7U46KDATZS7KRiIrxDye2PhCGDnsTtFH8Bkxbvpujpp
 9MHz2gFNy8l2qKgCNg9olFWfkrDdowTgvsekCIlbRJZt1sv4kWS5fciN2o/N9z3n
 m1Saw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hjmp93qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:50:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46MEoVud029484;
 Mon, 22 Jul 2024 14:50:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hjmp93qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:50:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46MCW8Fn006718; Mon, 22 Jul 2024 14:50:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn75saa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:50:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46MEoQ7q49742486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:50:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D91E15805B;
 Mon, 22 Jul 2024 14:50:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F236158067;
 Mon, 22 Jul 2024 14:50:25 +0000 (GMT)
Received: from [9.67.181.135] (unknown [9.67.181.135])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jul 2024 14:50:25 +0000 (GMT)
Message-ID: <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
Date: Mon, 22 Jul 2024 10:50:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87h6cksk4h.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: euFx5qDrZ0uIuoSYxFvpHDIN1DMxEI3-
X-Proofpoint-ORIG-GUID: mfouTK2_nTcP9R5ZaRZz8BseC8RGRaoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220108
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

On 7/20/24 1:33 AM, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> Currently, there is no way to execute the query-cpu-model-expansion
>> command to retrieve a comprehenisve list of deprecated properties, as
>> the result is dependent per-model. To enable this, the expansion output
>> is modified as such:
>>
>> When reporting a "full" CPU model, show the *entire* list of deprecated
>> properties regardless if they are supported on the model. A full
>> expansion outputs all known CPU model properties anyway, so it makes
>> sense to report all deprecated properties here too.
>>
>> This allows management apps to query a single model (e.g. host) to
>> acquire the full list of deprecated properties.
>>
>> Additionally, when reporting a "static" CPU model, the command will
>> only show deprecated properties that are a subset of the model's
>> *enabled* properties. This is more accurate than how the query was
>> handled before, which blindly reported deprecated properties that
>> were never otherwise introduced for certain models.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>
>> Changelog:
>>
>>     v3
>>     - Removed the 'note' and cleaned up documentation
>>     - Revised commit message
>>
>>     v2
>>     - Changed commit message
>>     - Added documentation reflecting this change
>>     - Made code changes that more accurately filter the deprecated
>>         properties based on expansion type.  This change makes it
>>         so that the deprecated-properties reported for a static model
>>         expansion are a subset of the model's properties instead of
>>         the model's full-definition properties.
>>
>> ---
>>  qapi/machine-target.json         |  5 +++--
>>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>  2 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index a8d9ec87f5..67086f006f 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -21,8 +21,9 @@
>>  # @props: a dictionary of QOM properties to be applied
>>  #
>>  # @deprecated-props: a list of properties that are flagged as deprecated
>> -#     by the CPU vendor.  These props are a subset of the full model's
>> -#     definition list of properties. (since 9.1)
>> +#     by the CPU vendor.  These properties are either a subset of the
>> +#     properties enabled on the CPU model, or a set of properties
>> +#     deprecated across all models for the architecture.
> 
> 
> When is it "a subset of the properties enabled on the CPU model", and
> when is it "a set of properties deprecated across all models for the
> architecture"?
> 
> My guess based on the commit message: it's the former when
> query-cpu-model-expansion's type is "static", and the latter when it's
> "full".
> 

Correct.  I'm not confident where or how to document this dependency
since cross-referencing commands/data structures does not seem to be the
convention here.  My first thought is to mention how deprecated
properties are expanded under the @CpuModelExpansionType.  Something like:

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 67086f006f..3f38c5229f 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -44,11 +44,15 @@
 #     options, and accelerator options.  Therefore, the resulting
 #     model can be used by tooling without having to specify a
 #     compatibility machine - e.g. when displaying the "host" model.
-#     The @static CPU models are migration-safe.
+#     The @static CPU models are migration-safe.  Deprecated
+#     properties are a subset of the properties enabled for the
+#     expanded model.
 #
 # @full: Expand all properties.  The produced model is not guaranteed
 #     to be migration-safe, but allows tooling to get an insight and
-#     work with model details.
+#     work with model details.  Deprecated properties are a set of
+#     properties that are deprecated across all models for the
+#     architecture.
 #
 # .. note:: When a non-migration-safe CPU model is expanded in static
 #    mode, some features enabled by the CPU model may be omitted,

Thoughts?

[...]

>> +
>> +        /* deprecated features that are a subset of the model's enabled features */
> 
> Recommend to wrap this line for legibility.
> 

[...]

Thanks for the feedback!  Pending your response to the above, I'll post
a v4.

-- 
Regards,
  Collin


