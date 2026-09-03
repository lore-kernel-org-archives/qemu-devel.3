Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C0C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BqN-0001wp-40; Thu, 03 Sep 2026 14:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x2BqI-0001vO-1q; Thu, 03 Sep 2026 14:07:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x2BqG-00023x-2H; Thu, 03 Sep 2026 14:07:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G34t63305377; Thu, 3 Sep 2026 18:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oZ91ba
 RR3MMf95b8ihr0wDYmCrBXAQTNjRqUgh7clQU=; b=XZCMl4ji63yPwxn3kG6EAH
 tP//VyMy6+75z41qQUbJmhC81d5C3SIIbDVag4sYd7Xf8iYPxV2Frwn+AOmcIRwZ
 x4LV9bE3TZah2VrW71hiTs5+4BXVPt5NEBxI2iHr4iLAE8ulfJWuKx9nTuSdMvlE
 uOtbHLZRqBtKYzGNNbZoP8JrlPMgTz3FDWzQuvmW3U9kWgoqqADXKGR2+15+9EWy
 BrNcS+xtD4Ls65LIxKE32jZgRoX7Xkl1qsR9Va3IV2AgmDJbrwxLxBRWMI/x6j3t
 B5S+k1hoKIlq8NRKpv9kDyygzjJzDrO2AukoWuDwKfW83eZdjMWFjVtAunR6KOiQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj62kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 18:07:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683HuO4T001741;
 Thu, 3 Sep 2026 18:07:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceygnvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 18:07:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683I7CSH10420866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 18:07:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5508E5805F;
 Thu,  3 Sep 2026 18:07:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6072B58054;
 Thu,  3 Sep 2026 18:07:11 +0000 (GMT)
Received: from [9.61.255.190] (unknown [9.61.255.190])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 18:07:11 +0000 (GMT)
Message-ID: <c761f020-4970-497d-a460-01933371cf0c@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:07:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Cc: "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "armbru@redhat.com" <armbru@redhat.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 <d32b992a-e4b2-494a-ad27-e38caaff7dc1@linux.ibm.com>
 <SJ0PR12MB8614E80E4BAB0FC192BB224BABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <SJ0PR12MB8614E80E4BAB0FC192BB224BABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iiwgsc0T2fKdFbjLpWAncoFli5ngGbke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE1OCBTYWx0ZWRfXwaFMYR0z1ziz
 ID/jf3GBBvilGk3jFyl6vlaLmFHrg0u25Br3PuisR8IHv8pyDsj/AHsAeX7GnbCGXYKHmoKBNSQ
 YlpMyIOKK4aOv2TaAuSx+rIctDq8S5vqGh38iHmy8TkUm2TZhH7AaveLIN5jz5d6fT8PZOG3XpR
 R5kNcTfMQPuHMAU/+DLFYbxXjBxWcWAE/qW5jp/43U+bQlFb2pfzWi/EBaoVm5kunyZbqcEVhrW
 SmQDSeHy9ajybreXqJbMUqqNPgL2ZRoPbDDV4yrhMG+KvHy+ECvXPA9iEhpH0oXh8rRWwO4+Fx4
 1ndfOObkP53HZxkq+CwvNzk3O34+NNSUMp8rQ/qjOUC6UhGXejFemKy28pHynUUM6ZRwM7AUog0
 uZkVb2/iaab8bpnZQ9ocCb0xDb/u+tan6/5wVyzcWPCgkGw5OkyUJRVK3mN1NvKj6S3u1a94aXP
 L0TWBExstorEy6QFPLA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a99b752 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9eNOUyr2UFhGGCzTvj8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE1OCBTYWx0ZWRfX7RrGOA9kCNoh
 Jc9e4YqPXsPnIHLV8XqmxiKeWooozM+M8SpGZwYiA75PCrkLQYr2TVhyhUAVPEDlTJ356evA8j9
 6YXhwYC+6wqGH+Ahtsicr9lZxH/T/Us=
X-Proofpoint-ORIG-GUID: iiwgsc0T2fKdFbjLpWAncoFli5ngGbke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

Thanks for your response!

On 9/3/2026 5:08 AM, Shameer Kolothum Thodi wrote:
>>> That said, I'd prefer to see AER forwarding first.
>> I am curious too to understand how AER forwarding will work. Based on
>> qemu patches (which may not be complete) [1], I can't tell how AER or an
>> event will be sent to a guest to notify of an error. Based on the
>> discussion on the link you posted, it looks like APEI/GHES based events
>> would be sent to the guest?
> Right, that QEMU branch is an early prototype which only observes and
> logs, so the forwarding is not in it.
>
> I am working on a QEMU branch which adds it, based on the kernel RFC.
> The plan is to use native AER rather than GHES, so QEMU injects with
> pcie_aer_inject_error() and an emulated pcie-root-port raises the
> interrupt to the guest. I will post a link once it is ready.

I am very curious to know (and learn) how we would do this.


>> Another question regarding AER recovery series, do we need some
>> mechanism to get the AER information from the kernel for userspace?
> Not as it stands. The feature reports how severe the event was and what
> the host did, not which error occurred, so QEMU cannot forward the real
> status bits today. If it is something that is useful then it probably
> needs to be added

IMHO I think there might be value in providing more detailed information 
to the QEMU/guest.

Based on my brief look at the kernel/QEMU patch series, it looks like 
there is not much coordination between the guest and host recovery. So 
when we inject an AER in the guest, is the device access still blocked? 
Is the device access enabled only after a guest completed the recovery?

Thanks

Farhan

> Thanks,
> Shameer

