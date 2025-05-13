Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FDEC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEptx-0006Cx-Hm; Tue, 13 May 2025 09:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uEptw-0006Ca-1e; Tue, 13 May 2025 09:42:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uEptt-0000WU-Lf; Tue, 13 May 2025 09:42:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAmcAh001397;
 Tue, 13 May 2025 13:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bZZCRi
 wNuvCsOy/JhzNnpRjBv8+KZmI70ywYBCGmn3o=; b=LV3dB6AALaZy6ugtIkQSFQ
 mKNcFtPMQxwgb/k1X40eiHv1OFiCya86yzp/tC3Tqq3daLXqgLopxHs4GjbHlLMk
 v158jhXme+l0e72GAl8HuPafl4Nkov5julRYxVEjd2l+AvgrtXenZ/lrRKly3/NJ
 PRRVoGM42uumrw2xuONq2mJcfXBU5CELa57PNTh/aeTkE2thmj89gx7pkqNocxXR
 2UpeyHlUcKjdV6m7GXH0CiGG2yq+UZeDFXxZZK7BNyQ25A4v8vQh3BuM55DvI3Rq
 GhnLcGqTuDvOhxsTqB4BHyn9xx/lL49VELcz5RJ2abRXHPOqqtOJDavddaVQqZbw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75e077-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 13:42:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBt8kw011552;
 Tue, 13 May 2025 13:42:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku2aym4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 13:42:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DDgMFj31261382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 13:42:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA0D45805F;
 Tue, 13 May 2025 13:42:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2D558054;
 Tue, 13 May 2025 13:42:21 +0000 (GMT)
Received: from [9.61.136.253] (unknown [9.61.136.253])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 13:42:21 +0000 (GMT)
Message-ID: <1c983e1e-9610-4c53-8453-2db52ffa47e9@linux.ibm.com>
Date: Tue, 13 May 2025 09:42:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
 <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
 <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
 <14b9b607-c88a-4691-9872-cc6a51834c95@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <14b9b607-c88a-4691-9872-cc6a51834c95@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyOSBTYWx0ZWRfX5eICdFTxUffv
 8ZCztgzZrWwIWUrV6oAj/8mMpnbggXIuOodON+9LOyjN5f31sezPXmkQRKLcb3sk4lHNi5zhzME
 VvN8y5zmcjsGSH0Awp6R8N8lMsD50zCdEczX/KgKRlNTxWuR0JwgSPWNyYpVZf9Mi6xufVq627r
 MDsv5yI+3v8gwLsovs2weSQQSNXMUv6mq79/5TVEsTuyi9VMabe16Fpa0/CqKQXda0FYOekotiB
 sb7upVeZY5dyHWLCvxSt4Gw5zK+CTaFG5G+rGTaTYR0+C0A2TBf3UdXKq4TGj1DkCtKvD5KLPbX
 gCYET1UfwMTBZUf0ZwKPq4eIeK5OLgZJOqdPL/3xFc+xxacOuOXNKxavC+kgtxV/UX9TlIW8Me+
 L+KQtxSlFN+fGZPqhv0vyluPSnOGjVkPNmPONEAxE+AIRuwQW1O/DlNch2s/XQXSVQpJ0/2K
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=68234c40 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=z5aA2HeAKe8svm0xGp0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UFmBCrZZg3ewFlQgsewNqiXYqvUVTGNs
X-Proofpoint-GUID: UFmBCrZZg3ewFlQgsewNqiXYqvUVTGNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130129
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/25 2:50 AM, Christian Borntraeger wrote:
> Am 29.04.25 um 16:09 schrieb Matthew Rosato:
>> On 4/29/25 3:45 AM, Christian Borntraeger wrote:
>>> Am 29.04.25 um 09:37 schrieb David Hildenbrand:
>>> [...]
>>>> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
>>>>
>>>> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.
>>>
>>> CC Matt to double check.
>>
>> When triggering the "relaxed translation" mode via iommu.passthrough in the guest, we now take the default (for other platforms) memory_region_is_ram() path in vfio_listener_region_add/del() which handles the pin/unpin from vfio common code.  As for ram discarding, we then also use the vfio common path and only uncoordinated discards are disabled via:
>>
>> vfio_ram_block_discard_disable() -> ram_block_uncoordinated_discard_disable()
> 
> So this patch is good?
> 

Worked fine in my testing in combination with iommu.passthrough=1.  I traced to verify I was hitting the S390_RESET_REIPL_CLEAR path in s390_machine_reset() and observed the pinned memory of the guest shrink / grow.  Device worked fine afterwards.

