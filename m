Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D526C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 18:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUVpe-0003LS-1j; Thu, 18 Jul 2024 14:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUVpa-0003Iv-Nu; Thu, 18 Jul 2024 14:26:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUVpY-0000yh-Ai; Thu, 18 Jul 2024 14:26:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IILhqV003276;
 Thu, 18 Jul 2024 18:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
 p2kiH0XYUr8YtkCks2Qr2osjuNq6xc+wjcIymzm/E8=; b=SfGvp+da3zRoRUJb2
 GgrekTTIbuPTkM6hZghomAfsaqTQcDDFJ/nx+dHwIwJ/Zthaz3mNJFLa4P+tcQmy
 WThUzTSmo/3qzErwNCsm4wh7JH/ByeodLfL/fXZ0JE7BSg87JkWCI2asoALfLTRZ
 RCSLB3TKPPtmyZVaXWbkWHDUI3eve3pFh9cGOB+9t6BD9XooxGKkGGl7tibHYBlF
 jqSQOtYQsBH2xDLAzLEozO5hhMXeQkZq/1eM5fJWCtEFkVNYn9YCYKt/LAxZhj7u
 A6V3Ign7SLlapB3Y9fLZZUniIuO0kFoiNth/mrQHc5dXJSkSUqdF/60oIXyf8UDS
 AbxVA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40f6knr90b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 18:26:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46IIQ27O007864;
 Thu, 18 Jul 2024 18:26:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40f6knr8t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 18:26:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46IGKDOh006337; Thu, 18 Jul 2024 18:22:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmk3nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 18:22:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46IIMYk029753932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 18:22:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C32E258054;
 Thu, 18 Jul 2024 18:22:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEACB5805A;
 Thu, 18 Jul 2024 18:22:33 +0000 (GMT)
Received: from [9.67.137.143] (unknown [9.67.137.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Jul 2024 18:22:33 +0000 (GMT)
Message-ID: <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
Date: Thu, 18 Jul 2024 14:22:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240716173253.28533-1-walling@linux.ibm.com>
 <87le1yn7jy.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87le1yn7jy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YeKHs78y8fH1mu4KBXrtFgLnxmDNadHa
X-Proofpoint-ORIG-GUID: Xcfjc18Yf1D0vFNelI2ah_MEZ4SDomJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_12,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180121
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

On 7/18/24 9:39 AM, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> As s390 CPU models progress and deprecated properties are dropped
>> outright, it will be cumbersome for management apps to query the host
>> for a comprehensive list of deprecated properties that will need to be
>> disabled on older models. To remedy this, the query-cpu-model-expansion
>> output now behaves by filtering deprecated properties based on the
>> expansion type instead of filtering based off of the model's full set
>> of features:
>>
>> When reporting a static CPU model, only show deprecated properties that
>> are a subset of the model's enabled features.
>>
>> When reporting a full CPU model, show the entire list of deprecated
>> properties regardless if they are supported on the model.
>>
>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>
>> Changelog:
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
>>         For example:
>>
>>         Previously, the z900 static model would report 'bpb' in the
>>         list of deprecated-properties.  However, this prop is *not*
>>         a part of the model's feature set, leading to some inaccuracy
>>         (albeit harmless).
>>
>>         Now, this feature will not show during a static expansion.
>>         It will, however, show up in a full expansion (along with
>>         the rest of the list: 'csske', 'te', 'cte').
>>
>> @David, I've elected to respectully forgo adding your ack-by on this
>> iteration since I have changed the code (and therefore the behavior)
>> between this version and the previous in case you do not agree with
>> these adjustments.
>>
>> ---
>>  qapi/machine-target.json         |  8 ++++++--
>>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>  2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index a8d9ec87f5..d151504f25 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -21,8 +21,12 @@
>>  # @props: a dictionary of QOM properties to be applied
>>  #
>>  # @deprecated-props: a list of properties that are flagged as deprecated
>> -#     by the CPU vendor.  These props are a subset of the full model's
>> -#     definition list of properties. (since 9.1)
>> +#     by the CPU vendor.  (since 9.1).
>> +#
>> +# .. note:: Since 9.1, the list of deprecated props were always a subset
>> +#    of the model's full-definition list of properites. Now, this list is
>> +#    populated with the model's enabled property set when delta changes
>> +#    are applied. All deprecated properties are reported otherwise.
> 
> I'm confused.
> 
> "Since 9.1, the list of deprecated props were ..." and "Now, this list
> is" sounds like you're explaining behavior before and after a change.
> What change?  Since only released behavior matters, and
> @deprecated-props is new, there is no old behavior to document, isn't
> it?

I admittedly had some difficulty articulating the change introduced by
this patch.  The @deprecated-props array, as well as a way for s390x to
populate it, was introduced in release 9.1.  Prior to this patch, the
deprecated-props list was filtered by the CPU model's full feature set.
I attempted to explain this with:

"Since 9.1, the list of deprecated props were always a subset of the
model's full-definition list of properties."

This patch modifies what is populated in the list by filtering it via an
intersection of the model's /default/ feature set.  The reason for this
change was that the deprecated-props list reported for very old s390
models was showing features that were not *actually* a subset of the
model's feature set.  One of the changes proposed by this patch corrects
this for static model expansions.  Explained by:

"Now, this list is populated with the model's enabled property set when
delta changes are applied."

The other change introduced by this patch is that the entire list of
deprecated-properties is now reported via a full model expansion,
explained by:

"All deprecated properties are reported otherwise."

My thoughts were to acknowledge this change in case a user sees
different results between QEMU versions.  However, as this
@deprecated-props thing is relatively new (a few months), perhaps it
does not make sense to include this note?  What would you suggest?

> 
> docs/devel/qapi-code-gen.rst section "Documentation markup":
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 

Forgot about the 70 rule for these docs.  Missed the double space.
Thanks for reminding me.  Will update.

>>  #
>>  # Since: 2.8
>>  ##
> 
> [...]
> 
> 

-- 
Regards,
  Collin


