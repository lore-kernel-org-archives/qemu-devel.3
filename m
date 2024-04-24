Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzhR3-0005eL-4E; Wed, 24 Apr 2024 14:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzhQw-0005dy-Jj; Wed, 24 Apr 2024 14:33:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzhQu-0002RB-LP; Wed, 24 Apr 2024 14:33:30 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OIWU4B016998; Wed, 24 Apr 2024 18:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aviPTn+wpyUl+nk06V1fPM0mFUiHtyZoNv2pAJAG4/s=;
 b=hQLMYHMQYsLkYDI3J7glqXwIeZnSgiZHtC3KlqCQXnjUAzOrUPaIOR8tuwPrsyKnAvfG
 EcQ1AtVDw3tnb5w5X85foRLDfZzi11SPZ+YD96aQP6iohSWwDm4pDj40mMGUaOtfp4NG
 MBL30JUesUIU8BO2alEuWFqUG9rVERdqNZUSsOAT6DiCxf5TMeGKhkbwKW+97suVBvvV
 G7uqAz/bIqNkxFWhRNPQaw5joRaPgoFLGWwO7gPjshOh0ljOzGDThtUoESr5/vVycg1O
 Wou2pGxNK8YPVwjpdrdBsDcxNete+Y34Rsk3Tiqf2zJTvPKGmp0Vj/ImuVzyvUXbp2yh 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq7ep003g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 18:33:18 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OIXIMn017605;
 Wed, 24 Apr 2024 18:33:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq7ep003b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 18:33:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OGd7tK005736; Wed, 24 Apr 2024 18:33:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cm2jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 18:33:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OIXEsM30867826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 18:33:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5B1D58070;
 Wed, 24 Apr 2024 18:33:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4908F5806D;
 Wed, 24 Apr 2024 18:33:14 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Apr 2024 18:33:14 +0000 (GMT)
Message-ID: <92b62a01-1ff0-4ad3-bbed-8a0f56954279@linux.ibm.com>
Date: Wed, 24 Apr 2024 14:33:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: add support for
 "disable-deprecated-feats" expansion option
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-3-walling@linux.ibm.com>
 <ec18d260-a882-480a-b7db-9c20aa4aacf7@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <ec18d260-a882-480a-b7db-9c20aa4aacf7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JfksCk3hjwz3ubIwQGOBXNiBU1xU2jJG
X-Proofpoint-ORIG-GUID: w6-Y31GsJ13jT80Ut5AlTmtxGL7qjYZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_15,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240086
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

On 4/24/24 03:24, David Hildenbrand wrote:
> On 23.04.24 23:06, Collin Walling wrote:
>> Retain a list of deprecated features disjoint from any particular
>> CPU model. When a query-cpu-model-expansion is provided with the
>> "disable-deprecated-feats" option set, the resulting properties list
>> will include all deprecated features paired with false. Example:
>>
>> 	{ ... "bpb": false, "csske": false, ...}
>>
>> It is recommended that s390 guests operate with these features
>> explicitly disabled to ensure compatability with future hardware.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   target/s390x/cpu_features.c      | 14 ++++++++++++++
>>   target/s390x/cpu_features.h      |  1 +
>>   target/s390x/cpu_models_sysemu.c | 20 ++++++++++++--------
>>   3 files changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index d28eb65845..efafc9711c 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -212,6 +212,20 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>>       };
>>   }
>>   
>> +void s390_get_deprecated_features(S390FeatBitmap features)
>> +{
>> +    static const int feats[] = {
>> +         /* CSSKE is deprecated on newer generations */
>> +         S390_FEAT_CONDITIONAL_SSKE,
>> +         S390_FEAT_BPB,
>> +    };
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(feats); i++) {
>> +        set_bit(feats[i], features);
>> +    }
>> +}
>> +
>>   #define FEAT_GROUP_INIT(_name, _group, _desc)        \
>>       {                                                \
>>           .name = _name,                               \
>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
>> index a9bd68a2e1..661a8cd6db 100644
>> --- a/target/s390x/cpu_features.h
>> +++ b/target/s390x/cpu_features.h
>> @@ -69,6 +69,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>>                             uint8_t *data);
>>   void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>>                                  void (*fn)(const char *name, void *opaque));
>> +void s390_get_deprecated_features(S390FeatBitmap features);
>>   
>>   /* Definition of a CPU feature group */
>>   typedef struct {
>> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
>> index ef9fa80efd..b002819188 100644
>> --- a/target/s390x/cpu_models_sysemu.c
>> +++ b/target/s390x/cpu_models_sysemu.c
>> @@ -171,7 +171,8 @@ static void qdict_add_enabled_feat(const char *name, void *opaque)
>>   
>>   /* convert S390CPUDef into a static CpuModelInfo */
>>   static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>> -                                bool delta_changes)
>> +                                bool delta_changes,
>> +                                bool disable_deprecated_feats)
>>   {
>>       QDict *qdict = qdict_new();
>>       S390FeatBitmap bitmap;
>> @@ -201,6 +202,13 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>>           s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
>>       }
>>   
>> +    /* features flagged as deprecated */
>> +    if (disable_deprecated_feats) {
>> +        bitmap_zero(bitmap, S390_FEAT_MAX);
>> +        s390_get_deprecated_features(bitmap);
>> +        s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
>> +    }
> 
> Likely, we should remove these features from the actual bitmap, such 
> that they won't appear twice in the output? I'd expect the 
> cpu_info_from_model() caller to handle that.
> 
> Just adding them to the list as disabled is likely wrong.
> 
> For example, if someone were to expend a given model with "... bpb: 
> true" with disable-deprecated-feat=on, that should be remove from 
> "bpb:true", and only replaced by "bpb=false" if it would be part of the 
> CPU model we would be expanding to.
> 
> Or am I missing something?
> 

qdict_add_disabled_feat will handle updating the feature if it already
exists. I placed the code to process deprecated features as the last
step of cpu_info_from_model to override any features that have already
been added to the bitmap. Whether it should be the deprecated feats that
take priority, or what the user requests is up in the air, however...

... Daniel's suggestion to modify the QMP response to include a separate
list of "deprecated-props" seems like a much more efficient and readable
way that alleviates both your and Markus' concerns.

Thanks for your feedback! Will work on the next proposal that implements
the above. If you have any strong suggestions otherwise, please let me
know :)

-- 
Regards,
  Collin


