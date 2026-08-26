Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E239AC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIH5-0007tH-L2; Wed, 26 Aug 2026 14:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzIH4-0007t2-35; Wed, 26 Aug 2026 14:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzIH2-0006No-Gb; Wed, 26 Aug 2026 14:22:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1f2c3492880; Wed, 26 Aug 2026 18:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cj7QMJ
 DrOvUHrDn2U534Pk0p/r+66wfb7m33C8/6AYg=; b=Dpt+BBBeDjR/wq+zkZ2GIy
 txcCc/b4OAfs4rfL8dp//bkoOoaOWCVwU2CLycCutrfjfadQrUKRzGe/hsES0PCI
 FRgTl53k8davg9FuRMhtBk8A9dyaBMhhCB2vuKjhWcTU2tD+TLb1uUXygs2Uel/o
 Q0r+eAor3zzWZ/PNXQqTJmbByptCStrwSNivE3CzpoO5EWauRQ3OWeCyOJfZQnTd
 i0hg2gg6cw2H2f3VZ//nlz9TlTIp8hym5MRkP1iCJQ23CytX6/f6OIyUwVrVB6tH
 zs9ESV6DBYlN4Trg9e8y/sRMrTpAr0/fYar58L9n8R/jdWFLtwoq6Yh+Zi5jKhxQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726erbay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 18:22:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHuK0v019423;
 Wed, 26 Aug 2026 18:22:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhbcgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 18:22:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QIMpAh8847956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 18:22:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFEBA58059;
 Wed, 26 Aug 2026 18:22:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D2775805B;
 Wed, 26 Aug 2026 18:22:50 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 18:22:50 +0000 (GMT)
Message-ID: <fc52bb9a-7d1b-4ebe-87cc-faf218fca94e@linux.ibm.com>
Date: Wed, 26 Aug 2026 14:22:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] tests/functional/s390x: Add tests for virtio net
 PCI in test_pxelinux.py
From: Joshua Daley <jdaley@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-8-zycai@linux.ibm.com>
 <7c7f089c-b01b-48da-b1ef-2f6aca096c44@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7c7f089c-b01b-48da-b1ef-2f6aca096c44@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f2efe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=L4DMIUeYWxJp4MNzNqsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX9x40ubI4D34E
 D/iCSPwMIJM/IIFb1vDrcLZP3TH+Yznf8t++3YpecBixyADBzn/88VWlsAkLlmBc5swQwSNb1fr
 2LS7X0BH4zKFo1rzSNif5S37YWy+pyc=
X-Proofpoint-GUID: vWzl6N6Nsrm4-PicuA_WWOnP7D6zTOSZ
X-Proofpoint-ORIG-GUID: vWzl6N6Nsrm4-PicuA_WWOnP7D6zTOSZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX+ueRwf6TGsaV
 r/84wwqf9JST0Kh38nX+7bOqlv2uBQ52b1a8luBVOyU5ua0IGS2jVLHprjaM6nK4IaQhP9d4/A0
 wl9uYnHbas6o1Ntvp5hlCu5akvwYQcE7xyM0Mux3wniCMh1Y8ZkFsFz0no8F285DQzxHK0hy7Gd
 N7TKjZRAOxhI2YeLmRYS9Y/i6XWdP7dQMZiQGEdyoMz9SklU76tb6YHmvVbSNPI/QX3Z5qu0Pp1
 izl8VoJckBfSUGUBFUev/1ESrf0epTm9XKkugWs67DvN3DZisNV2pKO8ylADLjM6eUkMOeALxBT
 031zvB1/4oH6zB1ri2XaoMAhgVxXwmgwLpXWkKUTWRoWNEv6N9MvG5x/GFxDsJ9nNVFwey10ibo
 UMO8QXKTpdLPLC7tZKUUDNCUWS7rJDhDjBZL90EqcuAKMcX4wPJFZ10KmNV+WfVlH9H70Hx9RwV
 AA1U0MXy7IZkJ/Y+DFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

On 8/26/2026 2:17 PM, Joshua Daley wrote:
> On 8/18/2026 4:53 PM, Zhuoying Cai wrote:
>> Add test coverage for virtio-net-pci network booting on s390x by
>> extending the pxelinux functional tests.
>>
>> This patch adds PCI variants of all existing pxelinux tests to verify
>> that virtio-net-pci devices work correctly for network booting.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++-----
>>   1 file changed, 59 insertions(+), 12 deletions(-)
>> Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> 
> 
> make check-functional-s390x MTESTARGS="func-s390x-pxelinux"
> 
> ...
> ok 1 test_pxelinux.S390PxeLinux.test_default
> ok 2 test_pxelinux.S390PxeLinux.test_default_pci
> ok 3 test_pxelinux.S390PxeLinux.test_ip
> ok 4 test_pxelinux.S390PxeLinux.test_ip_pci
> ok 5 test_pxelinux.S390PxeLinux.test_mac
> ok 6 test_pxelinux.S390PxeLinux.test_mac_pci
> ok 7 test_pxelinux.S390PxeLinux.test_menu
> ok 8 test_pxelinux.S390PxeLinux.test_menu_pci
> ok 9 test_pxelinux.S390PxeLinux.test_uuid
> ok 10 test_pxelinux.S390PxeLinux.test_uuid_pci
> 

Sorry for the formatting error.
Tested-by: Joshua Daley <jdaley@linux.ibm.com>

