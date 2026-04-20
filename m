Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49CFF588C3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnl4-0003Fb-SJ; Mon, 20 Apr 2026 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wEnkq-0003F9-7C; Mon, 20 Apr 2026 08:29:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wEnkn-00019p-L1; Mon, 20 Apr 2026 08:29:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMEv8S3232467; Mon, 20 Apr 2026 12:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LUDL5e
 nqbLO0/bkuu8ekse5e56o44kchj1z6qfUHmbc=; b=J89lRnOwpsn2EuL1tdKX8m
 FJ+pgABr/VLv5EOjMTE4BQ1A2+1fXFDE48j3++X1FUGLiUri9Flo0CeaQ7ufQTRw
 1g7TujdsZPIs3drTc/NRnS1KH8EnwghvPEm3FQhmTEZOHb3uUnHN/LzRhRPQK4D0
 ZA8y0CNtqWGdfzP4e/Fvth2ayrTn1ZYaea4W12QBjUlqtHGW+ts+Ldlq0llbCPpv
 cxpVP38mneCEgnr0Z+MVvTpAsPsFXW8FjoW3ImAAG62oLgTxJGyWyNadN5xJ4Jhi
 RIQtRmH3vPyn1of5xDfFydg21A4iMfyJmCEfSS/T3UXB9bLcm42Jw/4UXgYSpsfA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k4yqes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 12:29:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KCKNKQ008057;
 Mon, 20 Apr 2026 12:29:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvmtju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 12:29:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KCTLKm29426198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 12:29:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 446EB58056;
 Mon, 20 Apr 2026 12:29:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9185F5803F;
 Mon, 20 Apr 2026 12:29:20 +0000 (GMT)
Received: from [9.61.174.150] (unknown [9.61.174.150])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 12:29:20 +0000 (GMT)
Message-ID: <530e4dc5-3a3f-4556-bfd6-d6e9e5b5da0e@linux.ibm.com>
Date: Mon, 20 Apr 2026 08:29:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
To: Cornelia Huck <cohuck@redhat.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260417154332.849664-1-jhkim@linux.ibm.com>
 <20260417154332.849664-2-jhkim@linux.ibm.com> <877bq2szx1.fsf@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <877bq2szx1.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EoeWitAEiWyJn6PaDWN3RA5dxIPjlMWq
X-Proofpoint-ORIG-GUID: EoeWitAEiWyJn6PaDWN3RA5dxIPjlMWq
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e61c23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=bPsVJAnUZ_hZJGt3Yn4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEyMSBTYWx0ZWRfX6nbSupiA8NA7
 AmjLa7GRKZh9rD5QFRhj1V7WKKHflkL6lPrpb0FhYJtkmE3XjcI9okZn2mtCjULzPD2iL211osd
 gL/kipkI5vsYX4SVd0LmJFcLCx+V/64fW+LUwlPq6l6j/eizJ5yHduWbjgV+tUSFk07Yl3/MNFB
 XX3V2Q/4ENO6tiwlE+j09FbjH4bzMfNB48nb//8xZyEbrslSY8NRzyiiapanqEFvX71fHHZFFJw
 mig9HXsT4pocqyE/ukRpsfpynfJs6OXKhrSbkyvFR0N2QP4jOO+vlEfjwGNtR7o2W2NeanONxiq
 7z5bcsBLjyrMeTlEMU6vqqWwekuE6Q/NxkTOq8PL7xf+GKrmdv4IbEjCjcDrQ4A9NjjS8YeCRQT
 HjRC/8J0Xo1SL5LXXTNYbavUjLf7pMIEbwO8Nt/m6ZUWx73TEfWbpUXOMinCch2HZs82jrniQqy
 WE8+/SVq72wVpMwSbhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 4/20/26 6:12 AM, Cornelia Huck wrote:
> On Fri, Apr 17 2026, Jaehoon Kim <jhkim@linux.ibm.com> wrote:
> 
>> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
>> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
>> making I/O BARs unusable.
>>
>> However, when virtio-pci devices operate in transitional mode, QEMU
>> unconditionally exposes the legacy interface via BAR0. This results in
>> firmware warnings during PCI enumeration, such as:
>>
>>   pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>>
>> even though BAR0 is never usable on the s390 kernel.
>>
>> Close this gap by disabling legacy virtio-pci support starting from
>> machine version 11.1. This effectively makes virtio-pci devices
>> non-transitional and prevents the creation of the unusable legacy I/O
>> BAR.
>>
>> This introduces s390x-specific global compatibility properties that
>> set disable-legacy=on as the default for virtio-pci devices. Machine
>> versions v11.0 and earlier set disable-legacy=off to maintain their
>> original default behavior (legacy support enabled), ensuring VMs
>> created with those versions continue to work identically.
>>
>> Users can override the default on the command line if needed:
>>   - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>>   - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
> 
> Makes sense to disable legacy virtio-pci devices, if they cannot work
> anyway. I'm wondering if we want to have a generic "no legacy" switch as
> well. I remember a patch from some time ago, but that was concerned with
> endianness IIRC.

Thanks Connie, I was hoping to get your input on this idea.

By generic, do you mean disabling legacy virtio-pci (and legacy
virtio-ccw?) across QEMU for all platforms vs only disabling it for s390x?

> 
> Anyway, we cannot turn off pre-1.0 for virtio-ccw at the moment, because
> the bios still uses legacy virtio. Would be a bit of an effort to change
> that, but still sounds like a good idea to me.
> 

Good point, hadn't thought about that and I guess it would be a pre-req
if you really wanted to disable legacy virtio everywhere; we can
certainly put this on our todo list for later, but I'd still like a
patch like this one to fix the awkward s390x virtio-pci situation now.

Thanks,
Matt

