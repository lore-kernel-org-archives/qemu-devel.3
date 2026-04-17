Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382DFF436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkb2-0002Mb-KB; Fri, 17 Apr 2026 10:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDkaw-0002L0-JC; Fri, 17 Apr 2026 10:54:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDkat-0000Fb-JI; Fri, 17 Apr 2026 10:54:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HEObAr2130784; Fri, 17 Apr 2026 14:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2AtyMX
 ldpPuwWKoCD024KuJcrTOspJfqw3vwHV4ZlqM=; b=qLLEb/yE6SGs61LCZ1a71H
 m6EqUSrHkMMP83o3Wap9q4rLBZt+CRp7uzv6gNW75uKzlpmFNuwn0eOh/a+X0tX3
 ye5NXydxMYPmAmkQ8yeajxplg8EAtFJGQBEUeaJVhDsFonEJj9gI30KPcVpmknlT
 G5bTrMXPCFmMpb5t4NXJquKqoUjGGB51J+n2U6FFGEJl/3wOa91vnsZZ1Z59rS8a
 WxU5Cg0o1tYaoPM3GRma3+S11iw8oFszG5F0ceSHSrXIBSPdDB8EuqUaySMR/Tr7
 KAUmNLPezr5G5PVdnUh5NtoCjqt7Jz6Njg5n/DdsEeIZCj2ncUct7fKSVGhOMGzQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nu6tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:54:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HCnTuB003568;
 Fri, 17 Apr 2026 14:54:49 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnqmsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:54:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HEsmef32965246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 14:54:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B320358056;
 Fri, 17 Apr 2026 14:54:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7195E58052;
 Fri, 17 Apr 2026 14:54:48 +0000 (GMT)
Received: from [9.16.58.46] (unknown [9.16.58.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 14:54:48 +0000 (GMT)
Message-ID: <4e2a294f-f27b-4790-a9d0-c3823167d561@linux.ibm.com>
Date: Fri, 17 Apr 2026 09:54:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] qapi/iothread: introduce poll-weight parameter for
 aio-poll
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 sw@weilnetz.de, mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260412215011.326196-1-jhkim@linux.ibm.com>
 <20260412215011.326196-4-jhkim@linux.ibm.com> <87qzodk6uh.fsf@pond.sub.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <87qzodk6uh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p_TZ-oHfSVuK5fsgoo-VYLU0fE8IiP6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0OSBTYWx0ZWRfX7XIgIFUY6ONL
 AZyYZN7vYrXZFXsjimdUDaMXAOgHyqR6u6YWg3uRkz4rq3BUL4PUVVImoRtoN0QmsjirtTQMkYR
 22PdxF0ZAymFrUQfO0d2PCqJQSedMHrqWo1c4aMXUHCO/scbHP1/EWyFbQr6fwVGVVq8CXWcIQG
 wWZnDb+frTO7IVmqZg8smF0SOIJUnEo9rpl0vpPIolQPlEdEW212BeeP5asUf6tk3WPUB+2R8IN
 Z///Td3Ar0VKKq3Liwnpje7z1+/IRr9Sm+Zz9C6V0cYrzQGMfVm4eRyzsoPZqgHsxgeFpRL82Jg
 3hn1m0xf4qMx1dFQ8gFPI1ZmQpsiTHIfRCkfiN2PHhzF2i7e3hMjj1y58e+u30YryPcibGOjnGv
 QcNCb9DticgXsEbEbptJxlB3wmp/hJfU0KeL8iMAFWvY6AS4B/1OeZW+RUgHExBtmZPH1fYQH9y
 oZCIvuqujoqFdYFSaDw==
X-Proofpoint-ORIG-GUID: p_TZ-oHfSVuK5fsgoo-VYLU0fE8IiP6E
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e249bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Ai-VZMc-9L5DP-xjSIEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/17/2026 9:19 AM, Markus Armbruster wrote:
> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>
>> Introduce a configurable poll-weight parameter for adaptive polling
>> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
>> constant, allowing runtime control over how much the most recent
>> event interval affects the next polling duration calculation.
>>
>> The poll-weight parameter uses a shift value where larger values
>> decrease the weight of the current interval, enabling more gradual
>> adjustments. When set to 0, a default value of 3 is used (meaning
>> the current interval contributes approximately 1/8 to the weighted
>> average).
>>
>> This patch also removes the hardcoded default value checks from
>> adjust_polling_time(). Instead, poll-grow, poll-shrink, and
>> poll-weight now use default values initialized in iothread.c
>> during IOThread creation.
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> I reviewed v3 instead of this one by mistake.  Fortunately, the relevant
> parts are identical.  Please check out my review of v3.
>
Thank you for the review.
I already replied to your comments on v3. I will apply the same updates in
the next version.

Please let me know if I missed anything in my v3 response.

Thanks,
Jaehoon Kim.



