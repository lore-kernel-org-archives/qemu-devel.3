Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3ADC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 20:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiIvI-00085y-A9; Wed, 12 Feb 2025 15:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiIvG-000851-54
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:01:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiIvE-0004JY-Cx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:01:25 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJPsUV013502;
 Wed, 12 Feb 2025 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CoZv6m
 DrNebNGWzEXlljZ4QP6mewdwBA2/vQzac1FnQ=; b=Ywf9jJw4K0jZAvhG0r1Eb4
 Q8DKhXPqGqy+kJqoUtZek9P9mITeHQ05kUajl/R05ZOncYsAWSgyYwNAcgZKgHEs
 nt+gLdqTmF60onhhie7BjDkHkrMKXcq4SChK/m3+BYOJFa5vdGBOoIMe07hrpO6R
 MG45vYr+k4hx330o8A4nU+zQv/lp1/SPOSUyTytJGoKYbJ3L/TZmUld4o6Z8NcFp
 vIzqGEjQUjm6kuXKZIUVFfO9/vqh5eIxdTI5ZzlOu2v2o2L1g5l0uOEL2iLdZZUf
 F279hOFTxZ6oTf6eNT0CZvXgcYxwsJhkO9vxbihD0eHUKN+PH7EQM6jywgh5RIrA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa5tbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 20:01:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIPMGp021706;
 Wed, 12 Feb 2025 20:01:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksttg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 20:01:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51CK1IWM18023052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 20:01:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B11CF58058;
 Wed, 12 Feb 2025 20:01:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DBED58059;
 Wed, 12 Feb 2025 20:01:19 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2025 20:01:19 +0000 (GMT)
Message-ID: <90adacff-9409-44f2-9ae6-9e01c8dc6e5c@linux.ibm.com>
Date: Wed, 12 Feb 2025 14:01:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
 <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
 <07a8be9a-d99e-4d02-b475-671435c11396@linaro.org>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <07a8be9a-d99e-4d02-b475-671435c11396@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FwfDYI31bgkoWeqKjs9Ca6LXeFV-KmnQ
X-Proofpoint-ORIG-GUID: FwfDYI31bgkoWeqKjs9Ca6LXeFV-KmnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/12/2025 12:07, Philippe Mathieu-Daudé wrote:
> On 12/2/25 18:24, Konstantin Shkolnyy wrote:
>> On 2/12/2025 08:52, Philippe Mathieu-Daudé wrote:
>>> On 11/2/25 17:19, Konstantin Shkolnyy wrote:
>>>> Add .set_vnet_le() function that always returns success, assuming that
>>>> vDPA h/w always implements LE data format. Otherwise, QEMU disables 
>>>> vDPA and
>>>> outputs the message:
>>>> "backend does not support LE vnet headers; falling back on userspace 
>>>> virtio"
>>>>
>>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>>> ---
>>>>   net/vhost-vdpa.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 231b45246c..7219aa2eee 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>>>>   }
>>>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static bool vhost_vdpa_check_peer_type(NetClientState *nc, 
>>>> ObjectClass *oc,
>>>>                                          Error **errp)
>>>>   {
>>>> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>>>>           .cleanup = vhost_vdpa_cleanup,
>>>>           .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>>>>           .has_ufo = vhost_vdpa_has_ufo,
>>>> +        .set_vnet_le = vhost_vdpa_set_vnet_le,
>>>
>>> Dubious mismatch with set_vnet_be handler.
>>
>> I'm not sure what you are suggesting...
> 
> Implement set_vnet_le for parity?

To my (very limited) knowledge, kernel's vhost_vdpa that QEMU talks to 
doesn't have an API to "change h/w endianness". If so, vDPA's 
.set_vnet_le/be(), as well as qemu_set_vnet_le/be() have very limited 
choices. qemu_set_vnet_le/be() behavior with vDPA was to simply assume 
that h/w endianness by default matches host's. This assumption is valid 
for other types of "NetClients" which are implemented in s/w. However, I 
suspect, vDPA h/w might all be going to be LE, to match virtio 1.0. Such 
is the NIC I'm dealing with.

My patch is only fixing a specific use case. Perhaps, for a complete 
fix, qemu_set_vnet_be() also shouldn't unconditionally return success on 
big endian machines, but always call .set_vnet_be() so that vDPA could 
fail it? But then it would start calling .set_vnet_be() on other 
"NetClients" where it didn't before.

That's why I don't want to just add a .set_vnet_be(), before someone 
here even confirms that vDPA h/w is indeed assumed LE, and, hence, what 
the right path is to a complete solution...

int qemu_set_vnet_be(NetClientState *nc, bool is_be)
{
#if HOST_BIG_ENDIAN
     return 0;
#else
     if (!nc || !nc->info->set_vnet_be)
         return -ENOSYS;

     return nc->info->set_vnet_be(nc, is_be);
#endif
}


