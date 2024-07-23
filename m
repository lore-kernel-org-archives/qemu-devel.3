Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5244C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 12:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWEwu-0005j2-Tu; Tue, 23 Jul 2024 08:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sWEwt-0005i3-8q; Tue, 23 Jul 2024 08:48:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sWEwq-0002dT-Pg; Tue, 23 Jul 2024 08:48:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCQdOE018309;
 Tue, 23 Jul 2024 12:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Q
 FzMd2TJmCQ5HsUO39RGB19Ufl1GTTxPL3PFFUNsfrI=; b=T2LHpMVszv3Jn2q8a
 ePSAYYg2Tmd9JS/hDb7yaYDWRoc1Voq+Z9gMbRESp/ByBNh1WbVM/XgK2DdLd0Ma
 XVyPMZsM5WNEEw9HrAHP3fqGtKI4o01qhg04/3IHfa0liUucS0fe5UuPTOba31R6
 LyZ+em1xtMENiUp94qCi0qXX50n1MNzZZve06mL3nNGGxjlA2vtPcvY8Ik0CJhfn
 DL7SrLH1ccrV22I+4HJERKwZomMCGAMrudUHn2Xt010dOZspqXJXjN1OWRhgEfGW
 5Ca7KwIc3sJ7GLWwhdd8bwK5VDDfUz8cT2azd3D8jlsRUdmUyvVOhbgHp0ZDULQS
 0Z17Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j9fq8eqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 12:48:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46NCiSr0011523;
 Tue, 23 Jul 2024 12:48:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j9fq8eq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 12:48:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46NAqPPv006227; Tue, 23 Jul 2024 12:48:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjubvf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 12:48:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46NCmgUd23659124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 12:48:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BCEB5809C;
 Tue, 23 Jul 2024 12:48:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E2AC580C5;
 Tue, 23 Jul 2024 12:46:20 +0000 (GMT)
Received: from [9.67.89.214] (unknown [9.67.89.214])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 Jul 2024 12:46:20 +0000 (GMT)
Message-ID: <9636c2af-7708-4aa3-99ab-ffaff4680b01@linux.ibm.com>
Date: Tue, 23 Jul 2024 08:46:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <58178bd0-4e7d-4770-aa54-5bd2811dcb39@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <58178bd0-4e7d-4770-aa54-5bd2811dcb39@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FnMkMdTD4WrPFM0YhYMyfmmqWXBm9EH5
X-Proofpoint-ORIG-GUID: ECHkJecNC68Sj_aF6_FjW6AdqfNGbY8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230089
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

On 7/23/24 5:23 AM, Thomas Huth wrote:
> On 22/07/2024 16.50, Collin Walling wrote:
>> On 7/20/24 1:33 AM, Markus Armbruster wrote:
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> Currently, there is no way to execute the query-cpu-model-expansion
>>>> command to retrieve a comprehenisve list of deprecated properties, as
>>>> the result is dependent per-model. To enable this, the expansion output
>>>> is modified as such:
>>>>
>>>> When reporting a "full" CPU model, show the *entire* list of deprecated
>>>> properties regardless if they are supported on the model. A full
>>>> expansion outputs all known CPU model properties anyway, so it makes
>>>> sense to report all deprecated properties here too.
>>>>
>>>> This allows management apps to query a single model (e.g. host) to
>>>> acquire the full list of deprecated properties.
>>>>
>>>> Additionally, when reporting a "static" CPU model, the command will
>>>> only show deprecated properties that are a subset of the model's
>>>> *enabled* properties. This is more accurate than how the query was
>>>> handled before, which blindly reported deprecated properties that
>>>> were never otherwise introduced for certain models.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>>      v3
>>>>      - Removed the 'note' and cleaned up documentation
>>>>      - Revised commit message
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
>>>> ---
>>>>   qapi/machine-target.json         |  5 +++--
>>>>   target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>>   2 files changed, 12 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index a8d9ec87f5..67086f006f 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -21,8 +21,9 @@
>>>>   # @props: a dictionary of QOM properties to be applied
>>>>   #
>>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>>> -#     definition list of properties. (since 9.1)
>>>> +#     by the CPU vendor.  These properties are either a subset of the
>>>> +#     properties enabled on the CPU model, or a set of properties
>>>> +#     deprecated across all models for the architecture.
>>>
>>>
>>> When is it "a subset of the properties enabled on the CPU model", and
>>> when is it "a set of properties deprecated across all models for the
>>> architecture"?
> ...
>>
>> Thanks for the feedback!  Pending your response to the above, I'll post
>> a v4.
> 
> Since we've got soft-freeze for 9.1 today, I went ahead and put v3 into my 
> last pull-request before the freeze period starts already. Please post the 
> update to the comments as diff on top of that instead - updates to comments 
> should still be fine for merging during the freeze period.
> 
>   Thanks,
>    Thomas
> 
> 

This is greatly appreciated, Thomas.  Thank you!

-- 
Regards,
  Collin


