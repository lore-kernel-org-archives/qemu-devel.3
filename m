Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E968C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGTY-0006n4-1f; Wed, 12 Feb 2025 12:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiGTV-0006lh-SQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:24:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiGTT-0002dB-PW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:24:37 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFduWv012541;
 Wed, 12 Feb 2025 17:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QqF9+D
 ZuKzt8QD5xtrNjzy2yxyezcx2/tA5hWWC1Iec=; b=fErfjcpXmpN371gvhQEBsx
 w51RIUD5t5BhRBAcbVli4M39UQBqFSVLpmIN305ovrUfV29QcFC1+jOTSwDW5piH
 j0KFEVQCVaMQu/0Yh9Q5x2HjjrvI38fRg4F1TtcdBxs+ABLHwOiOnVpRF41ho/m1
 lVLHKc7eOlYfmFXPTHp1IrV/V/nXODBmkbNqonnG+H1tv0R7jLsPdoBq/uYxEWWT
 dhSpzDLtei0qSyNOJl1anemMXKJ3iR3nZ/KmXbIM87PEHOKxfqZXDCeC2FZ2ckyp
 4cYIuDXsC10uBWmCuFdCjk6kBdev4U8Gi5Iy9TeSmcxzCBE0Ug9mwo9mN6hRo2nQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rxfu0j36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 17:24:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGZ5at011651;
 Wed, 12 Feb 2025 17:24:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktk1s17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 17:24:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51CHOWZV18416182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 17:24:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ECC35805E;
 Wed, 12 Feb 2025 17:24:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 440BC5805D;
 Wed, 12 Feb 2025 17:24:32 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2025 17:24:32 +0000 (GMT)
Message-ID: <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
Date: Wed, 12 Feb 2025 11:24:32 -0600
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
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jz1gI1ylLNz99zMKVhsnFjm6hxVq-KKy
X-Proofpoint-GUID: Jz1gI1ylLNz99zMKVhsnFjm6hxVq-KKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 2/12/2025 08:52, Philippe Mathieu-Daudé wrote:
> On 11/2/25 17:19, Konstantin Shkolnyy wrote:
>> Add .set_vnet_le() function that always returns success, assuming that
>> vDPA h/w always implements LE data format. Otherwise, QEMU disables 
>> vDPA and
>> outputs the message:
>> "backend does not support LE vnet headers; falling back on userspace 
>> virtio"
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>>   net/vhost-vdpa.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 231b45246c..7219aa2eee 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>>   }
>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
>> +{
>> +    return 0;
>> +}
>> +
>>   static bool vhost_vdpa_check_peer_type(NetClientState *nc, 
>> ObjectClass *oc,
>>                                          Error **errp)
>>   {
>> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>>           .cleanup = vhost_vdpa_cleanup,
>>           .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>>           .has_ufo = vhost_vdpa_has_ufo,
>> +        .set_vnet_le = vhost_vdpa_set_vnet_le,
> 
> Dubious mismatch with set_vnet_be handler.

I'm not sure what you are suggesting...


