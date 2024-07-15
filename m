Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E72C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 16:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTOwt-0005k0-Sz; Mon, 15 Jul 2024 12:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTOwr-0005g4-Dk; Mon, 15 Jul 2024 12:53:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTOwp-0003F8-9J; Mon, 15 Jul 2024 12:53:13 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FGRNBf004180;
 Mon, 15 Jul 2024 16:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
 aRKaGXgd3qZ/h/bjJPGVs0hqBQZIg+h9d6s69fyXP8=; b=H7EcMiOUznQKEuEuw
 Q0D0BgC5D1/VMj72bxkMLydKQwqxQITQmnR6Q3+o1ICTpBCarXJVGbLDq4ncjDBQ
 A0XqkB+q9yR/CCSnpKNo3wYS17rhryEwQqADyD7Ug1RkHEafV4oloXQkMtnszaAX
 eWKHGBm786IKPx5bFQlhYS34WaRJE21MurysIFDgFHfMNom7nfbGW0Ma/BQ3AWhV
 jbk7K9U0KPwPyBZdR47KEC+XS/v8NQ/HKDRleQd/qm+MYMCvs9udj0DBCMKiwGBa
 Lt8yMaI5MelTPeckdvnFCG7DSllaVKlAVIN5k6RVrFxOPK0ug9SnRwmU65tk6SbT
 2ClaQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d4p9ggfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:52:59 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FGqw38008243;
 Mon, 15 Jul 2024 16:52:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d4p9ggfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:52:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FDc3dl021975; Mon, 15 Jul 2024 16:52:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c5dnqrtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 16:52:58 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FGqteg44696268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Jul 2024 16:52:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75C8E58063;
 Mon, 15 Jul 2024 16:52:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEF355803F;
 Mon, 15 Jul 2024 16:52:54 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jul 2024 16:52:54 +0000 (GMT)
Message-ID: <141e7b65-2e72-4216-acb7-10899adaf372@linux.ibm.com>
Date: Mon, 15 Jul 2024 12:52:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: filter deprecated features based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240711203254.49018-1-walling@linux.ibm.com>
 <87h6cvxjxg.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87h6cvxjxg.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HxeTdhM7y967lKOSlgycAtnfCyxwcr9A
X-Proofpoint-GUID: FnYK8jTp7-Io49r1aaE3SrfVlLPON2S7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150133
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

On 7/12/24 1:23 AM, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
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
> 
> Which command(s) exactly are affected?
>

The query-cpu-model-expansion result will now report all deprecated
features when a user requests a full expansion.  The inputs are not
affects, but the output is modified.  I will make this more concise on
the v2 commit message.

> Do they need a doc update?
> 

Yes, I forgot to add this.  This is what is currently documented:

##
# @CpuModelInfo:
#
...
#
# @deprecated-props: a list of properties that are flagged as deprecated
#     by the CPU vendor.  These props are a subset of the full model's
#     definition list of properties. (since 9.1)
#

I will change to:

#
# @deprecated-props: a list of properties that are flagged as deprecated
#     by the CPU vendor. These are a subset of the reported @props.
#     (since 9.1)
#

(I will also the correct typo in my commit message).

[...]

Thanks!

-- 
Regards,
  Collin


