Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200D2C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 22:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXTa6-0008Fp-7b; Fri, 26 Jul 2024 18:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXTa4-0008E7-8T; Fri, 26 Jul 2024 18:38:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXTa2-0001JW-Ab; Fri, 26 Jul 2024 18:38:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QGuWDr020267;
 Fri, 26 Jul 2024 22:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 gAd/V1SBe0RIt0lPe5P2bowfhgIVRHe3/pxwI4GQH84=; b=tLNTt2vE9L12KxRF
 CnsRDxilM4VrLN9ViA5R/VTy0xbYP5bLrbAulmvxEKOd9YMO+oIXbOTOtVKxzZO0
 /BZCrfIBKFiJzK7wz/pazDZt5R2K1ojKHHrW45Zs7uK2qUONu4iP0lzmwGM2s50x
 rhgPjg9K76135M/DxP5y3/Tp4tWwHF8DkO8ALJFVYROp2eyptjat1A+Mi3UhOiRa
 n4Zym8BFaJTvGYJpOudhVMIo55qz6W7XqYwRPkfU/CsBCLWN86/W/QFX5ZfLAqFU
 pdMGSz630lD6a9MJWrFSNl+138pt8WilvhBwos2o8B0KDJ2YuvMtxbt9aN9pRRq5
 LesJ/w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40md5bs7cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 22:38:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QMcJ1Y021174;
 Fri, 26 Jul 2024 22:38:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40md5bs7cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 22:38:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46QKqldh005773; Fri, 26 Jul 2024 22:38:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pwdcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 22:38:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46QMcGkr28836352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 22:38:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D52E58055;
 Fri, 26 Jul 2024 22:38:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 774CE58054;
 Fri, 26 Jul 2024 22:38:15 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jul 2024 22:38:15 +0000 (GMT)
Message-ID: <8d220cee-186b-486b-b729-293e0c9b1084@linux.ibm.com>
Date: Fri, 26 Jul 2024 18:38:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <7744345c-964a-445d-96e3-64f71183bfba@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <7744345c-964a-445d-96e3-64f71183bfba@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -tNshD6Nxm1N-dFqanDBpAwfAwEVoCEJ
X-Proofpoint-GUID: iOWudKAxq9CduvS-x_uqM8D2C9T1JRh5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260151
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

On 7/26/24 5:16 PM, David Hildenbrand wrote:
> On 26.07.24 22:36, Collin Walling wrote:
>> The @deprecated-props array did not make any sense to be a member of the
>> CpuModelInfo struct, since this field would only be populated by a
>> query-cpu-model-expansion response and ignored otherwise. Move this
>> field to the CpuModelExpansionInfo struct where is makes more sense.
>>
>> References:
>>   - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
>>   - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>
>> @David, the previous commit header did not align with the changes made
>> here, so I tagged this as a "v1" but added the previous conversation as
>> a reference.  I hope this is appropriate?
> 
> Thanks, I modified the "References" section and converted it to a "Fixes:".
> It's now:
> 
>      target/s390x: move @deprecated-props to CpuModelExpansion Info
>      
>      The @deprecated-props array did not make any sense to be a member of the
>      CpuModelInfo struct, since this field would only be populated by a
>      query-cpu-model-expansion response and ignored otherwise. Move this
>      field to the CpuModelExpansionInfo struct where is makes more sense.

s/is/it

>      
>      This was identified late during review [1] and we have to fix it up
>      while it's not part of an official QEMU release yet.
>      
>      [1] https://lore.kernel.org/qemu-devel/20240719181741.35146-1-walling@linux.ibm.com/
>      
>      Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
>      Fixes: eed0e8ffa38f ("target/s390x: filter deprecated properties based on model expansion type")
>      Signed-off-by: Collin Walling <walling@linux.ibm.com>
>      [ david: add "Fixes", explain why fix is required now and reference to v3 ]
>      Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> 
> Can you take a quick peek at
> 	https://github.com/davidhildenbrand/qemu/tree/s390x-next
> if everything is alright?
> 

Aside from a typo (on my end), everything looks golden.  Thanks, David!

-- 
Regards,
  Collin


