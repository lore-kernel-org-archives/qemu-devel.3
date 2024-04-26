Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0638C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RFm-00059z-RL; Fri, 26 Apr 2024 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0RFg-00055Q-5U; Fri, 26 Apr 2024 15:28:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s0RFa-0007f7-OY; Fri, 26 Apr 2024 15:28:55 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QJScxi015293; Fri, 26 Apr 2024 19:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RnkY8Tms0PG1JKaMf49Ft9rxKdAQosmEIj3aS6HBxfc=;
 b=UED3V2jtES9hrW4fYLQw5D9AE9rXy7L7TT3wtycI8DyTk762lhnfXA5V4Zw8iqIwGIKp
 HHe5KUA1FzGyKVxpYgBkQdmQprkD9E7KHCK2P5DbVrYuAH3lbNF95c0X9BXk07XwA43N
 a+W3HEcQ3OLO9yhMnPXVeLBKcP9nOW2hBRC4zNkb8brCIAtc/5bMUayOez9yW0L6CmyN
 IkoGxfz3Ji8Bhyh5hkbzzDK7mJIQXFBTLCfJzJe5A2lYWLK5/2VQJnpCVrCMyQgq4ZU2
 G5TH6oLWvtOLXKCw6IhJrYPl4Rh/SSsX4G2nQP+NGKtjLIWsWWS3icvSAkXKy0KVipxi 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrjet8010-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 19:28:37 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QJSaNU015276;
 Fri, 26 Apr 2024 19:28:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrjet800w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 19:28:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QJALHi020907; Fri, 26 Apr 2024 19:28:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0hk05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 19:28:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QJSXNv15467164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 19:28:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7722758065;
 Fri, 26 Apr 2024 19:28:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB82158062;
 Fri, 26 Apr 2024 19:28:32 +0000 (GMT)
Received: from [9.67.41.19] (unknown [9.67.41.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 19:28:32 +0000 (GMT)
Message-ID: <c5b19cae-d2a3-466c-91f0-76990937dea4@linux.ibm.com>
Date: Fri, 26 Apr 2024 15:28:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240424215633.48906-1-walling@linux.ibm.com>
 <20240424215633.48906-2-walling@linux.ibm.com>
 <60cd9494-fe97-4134-a16b-026e14186eed@redhat.com>
 <c5d459eb-c38f-4e8c-a1c3-ba47584e5b2a@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <c5d459eb-c38f-4e8c-a1c3-ba47584e5b2a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I13XSNICBFt_pRZCbBd2W3FmwN9DckCT
X-Proofpoint-GUID: GBzdJ-P8IwGvnCn60dfr-eVg0xYHxeKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_16,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/26/24 13:45, David Hildenbrand wrote:
> On 26.04.24 19:44, David Hildenbrand wrote:
>> On 24.04.24 23:56, Collin Walling wrote:
>>> Retain a list of deprecated features disjoint from any particular
>>> CPU model. A query-cpu-model-expansion reply will now provide a list of
>>> properties (i.e. features) that are flagged as deprecated. Example:
>>>
>>>       {
>>>         "return": {
>>>           "model": {
>>>             "name": "z14.2-base",
>>>             "deprecated-props": [
>>>               "bpb",
>>>               "csske"
>>>             ],
>>>             "props": {
>>>               "pfmfi": false,
>>>               "exrl": true,
>>>               ...a lot more props...
>>>               "skey": false,
>>>               "vxpdeh2": false
>>>             }
>>>           }
>>>         }
>>>       }
>>>
>>> It is recommended that s390 guests operate with these features
>>> explicitly disabled to ensure compatability with future hardware.
>>
>> Likely you should only report features that are applicable to a model.
>> that is, if it's part of the full_feat.
>>
>> Otherwise, the caller might simply want do set all features to "false",
>> and we'd fail setting a feature that is unknown to a specific CPU
>> generation.
>>
>> That is, you would AND the bitmap with the full_feat of the underlying
>> CPU definition.
> 
> Refreshing my memory, I think we can just clear any CPU features. We 
> only bail out when setting them!
> 

Very good point.  I've been working only with newer-gen machines and
would not have thought to test / catch that case.  I will filter the
deprecated-props array with features that are only available on the
full_model of the expanded CPU model.

-- 
Regards,
  Collin


