Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B456E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshqb-0000KY-9m; Wed, 18 Feb 2026 08:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vshqZ-0000JO-84; Wed, 18 Feb 2026 08:44:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vshqW-0007B1-FZ; Wed, 18 Feb 2026 08:44:05 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61I9KW1Z3661553; Wed, 18 Feb 2026 13:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nv7eqP
 KlXz+34ocB3RLqC3LSEMXqQkvWORpbXEbfpKg=; b=ctWCwejsEQDiFcGv/i+abT
 r97RAUVULz9MXDX4/rIpg/D0NdpkLbBAcjjbZq3OCJTlenkFW5P3OHsYODP5dY4u
 Y5hxHNLYuzaYWleNsR/XjMGIh1i16vBqaCLOL9GxaQgrk5t6k+ofhj2pUzl4Ukk1
 /+23iwC6jaUga55u0VW+mnQCaHqu3SWH0WVervsGPAT2UZWPIPV/Z5sTs1Kq2BPV
 sBa56imkbClAqhPx1CGcczlyOALxKdIQ5+yvPR3OLINtE2p5U+1uETV680/MI/CR
 GgmkfzCfxt6CYpYT4abKm2ZXDemcFiQJ9xD3JWhvRdlIH5zpTgIM7pEM68ZBpcLg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjgad7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Feb 2026 13:43:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDaGsZ015679;
 Wed, 18 Feb 2026 13:43:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb457ye2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Feb 2026 13:43:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61IDhwwM31785646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Feb 2026 13:43:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 881CB58068;
 Wed, 18 Feb 2026 13:43:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3585058065;
 Wed, 18 Feb 2026 13:43:58 +0000 (GMT)
Received: from [9.24.20.109] (unknown [9.24.20.109])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Feb 2026 13:43:58 +0000 (GMT)
Message-ID: <b4ad76d0-e3ca-4e68-b382-bc73663d77b6@linux.ibm.com>
Date: Wed, 18 Feb 2026 07:43:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-2-jhkim@linux.ibm.com>
 <20260216152131.GB396170@fedora>
 <bca708cd-a776-4103-a328-fa6b3d65a47e@linux.ibm.com>
 <20260217131603.GA442289@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260217131603.GA442289@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0dI0VuBzaru3Rkx8Tikf7UzdFVmgroBp
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6995c21f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8nBm8Mein_lpDjsijIgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDExNiBTYWx0ZWRfXwGFAZSdzj9iu
 2rw9wBSeg9jj27aIxQ7lqfbXP7i0RDZ0E8M64xB/kxbVCILYvcubvSjftclHg54ZRGI+LMiXf6n
 HBau1ZVoWkE0UrHNx0j+Z+4+q6uEEGGK68yekPyPrl5UHM0AR75gKFIAXhOhGz5jRlpBBrV0XEa
 3dzZcSiyLTZKuEyHXpoNT45e4h//BGQwynXqUNgM0Aa4pfc2ADcDUuZWX+mjqOj2hxiQbOLNnRX
 5JmnF7uwvJAY0ZFkSPpQ97hdYw0gu/Ac7C3EvumyohZRyUWWTcUSRcYE9sW9gw50LJQMiPzpwDf
 j4biunOaMmXQQWwvxq881kOo1b0/pefgCQJYiDO9zJGMrDjaQ5waAGSC+td36w3SNHQZsAHbWPm
 sW9jbNc2E/ngzPEoQd5qcJtXshetvY0aW0ptiBpYcrtqL0/HlDjXfUVvETTtFClhUZwavM1aN2Q
 ZQO9YW/6dV6qYzwMRNQ==
X-Proofpoint-GUID: 0dI0VuBzaru3Rkx8Tikf7UzdFVmgroBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=1.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/2026 7:16 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 16, 2026 at 02:47:27PM -0600, JAEHOON KIM wrote:
>> On 2/16/2026 9:21 AM, Stefan Hajnoczi wrote:
>>> On Tue, Jan 13, 2026 at 11:48:22AM -0600, Jaehoon Kim wrote:
>>>> Nodes are no longer added to poll_aio_handlers when adaptive polling is
>>>> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
>>>> aio_poll() skips try_poll_mode() when timeout is 0.
>>>>
>>>> This avoids iterating over all nodes to compute max_ns unnecessarily
>>>> when polling is disabled or timeout is 0.
>>> Did you consider optimizing the case when polling is active and there is
>>> no way around calculating the polling time? Glib has ordered data
>>> structures that have lower operation costs than O(n).
>>>
>>> Stefan
>> If I understand correctly, while optimizing the data structure to be cheaper
>> than O(n) is one approach, I believe bypassing the function entirely
>> efficient
>> for cases where timeout=0 is frequently triggered.
>>
>> Since the result of the calculation is not used at all in these cases, it
>> seems
>> to more efficient to skip the function than to optimize calculation itself.
> Yes, skipping it when not needed makes sense and I'm in favor of it.
>
> I was thinking that, separately from this patch, the data structure
> might be worth optimizing since the value needs to be computed when
> polling is enabled.
>
> Stefan

That makes sense. I agree that when polling is enabled, optimizing the
data structure could help reduce the overhead of computing the value.
I'll take a closer look at potential improvements there.

Thanks,
Jaehoon


