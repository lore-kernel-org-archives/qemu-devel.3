Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61615C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 16:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTOCV-0005Zk-2U; Mon, 15 Jul 2024 12:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTOCS-0005Xt-88; Mon, 15 Jul 2024 12:05:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTOCM-0001IU-UI; Mon, 15 Jul 2024 12:05:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FFLM71017056;
 Mon, 15 Jul 2024 16:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
 2KFXO/OsIOBAMAszZydy4DMAkG3UmKmDyQlOra3fuY=; b=K6K6QtAXeAc+qglKF
 WNJALD/DBuZ1D9XIM9Ih6lpB+vjvwqiC1QmwuBTJctCwP2Lfip3UDiOdP2ktYNyj
 GYvj7VhI4lS3hXkY3Edpmw4P7WHeFD4sXGFGF+RnahUqC4pPb2/1umrgASNsTFJe
 DsBrpZKpCP1QOF8ZaWNrGytsqrj+qe1lGiGPobe86StJXn9d0nWI5i/+5oeI9XGt
 xHKzsNEbpo08RKM9iGviNbwN1NLulW4+gfw+78xPdZIg+qqVWZbq+IgTVqHr+FK4
 ZGIaDWgyxPaTGHTMLpXqO2RBJ9oISMrsxiN3/k5nyiLYewnszDPlox+V2RkXk2XZ
 jfCqw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d60f84w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:04:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FG4wdW018799;
 Mon, 15 Jul 2024 16:04:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d60f84vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:04:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FEN9TG023095; Mon, 15 Jul 2024 16:04:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c64kyeu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:04:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FG4tJ138601130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 16:04:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 362FD5805F;
 Mon, 15 Jul 2024 16:04:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADDA85805C;
 Mon, 15 Jul 2024 16:04:54 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jul 2024 16:04:54 +0000 (GMT)
Message-ID: <8747bd61-4d38-45d1-9012-88764c9acd30@linux.ibm.com>
Date: Mon, 15 Jul 2024 12:04:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: filter deprecated features based on
 model expansion type
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240711203254.49018-1-walling@linux.ibm.com>
 <3d93bd6b-7ca2-44e0-839b-a504a76b79a0@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <3d93bd6b-7ca2-44e0-839b-a504a76b79a0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oVhaDNdWSC5-bQhaJgkEOXyhUHey9sBt
X-Proofpoint-ORIG-GUID: wjbrnJq3m0v0h3kSIlYnTBXC2j8c8rqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150125
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

On 7/11/24 5:10 PM, David Hildenbrand wrote:
> On 11.07.24 22:32, Collin Walling wrote:
>> It is beneficial to provide an interface to retrieve *all* deprecated
>> features in one go. Management applications will need this information
>> to determine which features need to be disabled regardless of the
>> host-model's capabilities.
>>
>> To remedy this, deprecated features are only filtered during a static
>> expansion. All deperecated features are reported on a full expansion.
>>
>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   target/s390x/cpu_models_sysemu.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
>> index 977fbc6522..76d15f2e4d 100644
>> --- a/target/s390x/cpu_models_sysemu.c
>> +++ b/target/s390x/cpu_models_sysemu.c
>> @@ -211,7 +211,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>>       bitmap_zero(bitmap, S390_FEAT_MAX);
>>       s390_get_deprecated_features(bitmap);
>>   
>> -    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
>> +    /*
>> +     * For static model expansion, filter out deprecated features that are
>> +     * not a subset of the model's feature set. Otherwise, report the entire
>> +     * deprecated features list.
>> +     */
>> +    if (delta_changes) {
>> +        bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
>> +    }
>> +
> 
> This would likely be the only interface where we expose "more" features 
> than a CPU model actually understands? I guess it wouldn't be that bad 
> because disabling unsupported features will just work, even if the CPU 
> model is not aware of them.
> 

Yes, and for a full expansion an exhaustive list of features are
reported, even the ones that the model does not support (they're paired
with "false").  So I think it makes sense to report *all* features that
are deprecated as well.

> So no strong opinion.
> 
> Just noting that libvirt cannot really rely on that information because 
> the behavior would change between QEMU versions? Maybe not an issue.
> 

Right.  If it's appropriate, I could handle back porting of this patch
if requested.  But that's not for me to decide :)

> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

-- 
Regards,
  Collin


