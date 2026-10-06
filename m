Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4885ACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAD-0002sL-BB; Wed, 07 Oct 2026 04:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xEIAS-0001zq-1y; Tue, 06 Oct 2026 23:18:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xEIA7-0002MG-AK; Tue, 06 Oct 2026 23:17:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696I5UWU3216224; Tue, 6 Oct 2026 21:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+tq+yW
 23WUezmmhkHqo+m0kdgURT/X+r9gh3gx9xpQM=; b=ndrcnzoHMuU5hNvs4VPbwx
 PDsI50BgDQL3GSwwh4B0knrMFHir6H/6jaiyhgo1LdnLWngcVHu0Iaf74gKXPCdZ
 uaZS9uWbjUE4nsegLvZGcPGHmVoHRojVvvuQ1riuLHUbmjzyA9TLhF+OfVfNH35h
 EJaTF6m+abi5V2wiDA0Yab+uqBVUqHM0BvvLDz6SrHyTs7LxOTeEbGJ5evdXjBsu
 0J7bHY/A7Y+QXhLnHy03p74ariNBMuMLSOwLKRuI3QeDKQoU+wa/coktPU+Nnh0h
 rCuIvN6uiFvWIVIdCjIT0TrHtOH+F43jnjaE+RQNTfztwa42tqUH6idRU81EUH/g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g1jpk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 21:13:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HlgSh690711; Tue, 6 Oct 2026 21:13:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgus1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 21:13:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696LDPXe9831120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 21:13:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C3495805E;
 Tue,  6 Oct 2026 21:13:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7267258052;
 Tue,  6 Oct 2026 21:13:24 +0000 (GMT)
Received: from [9.61.251.167] (unknown [9.61.251.167])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 21:13:24 +0000 (GMT)
Message-ID: <ec2c8b15-0d83-457c-885b-8e0fbb04ad0c@linux.ibm.com>
Date: Tue, 6 Oct 2026 14:13:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/17] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
 <20261006001643.420929-17-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261006001643.420929-17-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac56476 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=x-B4hQBy79GTlnKUhDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4MyBTYWx0ZWRfX6Pz7qz3AR1R5
 f4MxkEUbeYQLrzM5eg7MaHRJupkEgmJpjm47HV9hloxfeS/7Zg2HQrlWuQ60Kmp9OUj+wG12Y63
 uuNVwMEu4Kq1+51eMug24gJ9DOczHbu5FL3kWuGqOHj1BuTls9Pul73taKQfNAxmgilJhKAf4Ut
 wws7AGZJEAb8OgvGAYcv3APkg4GDzAFsLxehF4/J2RoBO678yq3ZqmX2q3UnE4cOSBaPwhkNTe/
 sxdPJyThiVQw0O8THk42NoIwpFoc4qSZoegtjPQ0yXSXEzU6pZqjewxUlcA4eXOyhOL/I6DBcX2
 1fhFgFjuzP+qLRam1f+Yq7RUILwgfhVcs5YZoetA50SBbb8nbEdOJu3Llxa5EROVqy7Kg9H5D4o
 5anNoqKrBlQP9lSYN44CXs6n0oVvWfz8iqn8EUFe8BN7DtChVZWuIJfudi5Mbi8P5RZKAbh35Ay
 gjEmsKBcpBvQNTpEJMQ==
X-Proofpoint-GUID: NPhK1lSjleCQUOwEL_Xj0QF4KFPwq-Kz
X-Proofpoint-ORIG-GUID: NPhK1lSjleCQUOwEL_Xj0QF4KFPwq-Kz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4MyBTYWx0ZWRfX6q0zpbIPufSc
 bPmbgqxPrM9r2NSFVCvCmLetum99oOKjkjDx8rD258B4CQ5DGbQLH9uJ56xQkssPPcO+2OpF9NA
 Y/r6f4AyUS1YtEnkMfGMRNaU2HI5oco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060083
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


On 10/5/2026 5:16 PM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
>
> This will enable emulated PCI migration starting with s390-ccw-virtio-11.2.
>
> Passthrough devices will continue to block migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          | 346 ++++++++++++++++++++++++++++++-
>   hw/s390x/s390-pci-inst.c         |   2 +-
>   hw/s390x/s390-virtio-ccw.c       |   4 +
>   include/hw/s390x/s390-pci-bus.h  |   9 +-
>   include/hw/s390x/s390-pci-inst.h |   1 +
>   5 files changed, 353 insertions(+), 9 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



