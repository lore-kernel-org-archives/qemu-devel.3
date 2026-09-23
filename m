Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53118C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NqB-0005v2-2s; Wed, 23 Sep 2026 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9Nq8-0005uV-CD; Wed, 23 Sep 2026 10:20:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9Nq6-0006gM-ML; Wed, 23 Sep 2026 10:20:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZrM41729876; Wed, 23 Sep 2026 14:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mCo4qU
 dLgPCwcWQuLPowDmQwh3TXbDacN45+Ji9G+AU=; b=BKeO/DG9jJltcFd4h58uAp
 ACPLNJBmD2iCcHiB8p1zkon9/VSSjNkIkuqPOiSlVxGI+ihlzfRWR2B2oHRoyzeT
 bb1aFw43BdcN1tDC1lVHbl42Ghw9+45tjKi44/mdtXrUly9APLp6bjA6V/9cF1WF
 IVnRSyc9BcYxp8ekyFP2dfM5DAv5KSpkIn+oh0fjAcLCgvMoeX8C1dY58bRW/rOL
 lUQF2Ok+datXZvj8XaL6VwHwpTnfywpuYtKQrszoeH4oxC5zDC+eGWre9X+z6+HT
 eVkmAWeAmnTqzMuOMT4kTvLKPPg0WzHC0hmT5QU6gQDWj46eIUiF12Ob4HKLj8Sw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqk8rh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:20:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCsqmv007920; Wed, 23 Sep 2026 14:20:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2s85s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:20:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEKkEu28705308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:20:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92A4B5805B;
 Wed, 23 Sep 2026 14:20:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DFD458058;
 Wed, 23 Sep 2026 14:20:45 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:20:45 +0000 (GMT)
Message-ID: <4e25f10d-11ca-4d0b-89ec-3ec5af1b2dfc@linux.ibm.com>
Date: Wed, 23 Sep 2026 10:20:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] s390x: Add support for virtio-net-pci boot device
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <0ec1ff23-83f4-4572-974a-076d7fc6673c@linux.ibm.com>
 <75eec9ab-af1c-4ff9-806e-3855f9150935@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <75eec9ab-af1c-4ff9-806e-3855f9150935@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3e040 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=w35kvJcTJE75TvMfCLYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX4TqtyJiWbJiC
 mDZtuXGc3ntWN7OYwjbzhtjrzz6kvKOm69TPJpUt38l/nifXD9DZQ8vUIsQm+I/6Kj0JXVEpyNk
 lBBhy1ow7ws24ydUMVSnt6/vy71+gXmzdrRo4/hrAknw5CGzczsZwxYuttx77t/0NhAnHjQYxev
 8dvqOU9LG/bK2RFYfc1lCirSPR2ePqxCj4ARSjDRl0itvlWXQsHwNcipgqP9cPdG8BuyoFRx15p
 c+ID4r5M3zAl4fQUSJNB0nVvGeNRQD/49JzARquSismgkFmv6xWy/7qkxpMBXvstAvfHs5yGfZw
 qMmQh4woHf2K3QjUYXhUtTNQs5VhOYCgb4YEYG13E4MK1j7yOZX/9ZJSSJrIdi+LUes0yvQQ+vA
 qdVv6rqfeltCSMe7SsG/xQo/5V3KZtgBKiB62WBi/Fgwa6fvwz5FEFEJQDV20vOZCBNCQWw8hH5
 WAHv14MrQ7pS8u7PqTQ==
X-Proofpoint-ORIG-GUID: oIopndAN34IkTV5aQrFWA80B70qoM7fv
X-Proofpoint-GUID: oIopndAN34IkTV5aQrFWA80B70qoM7fv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX1MXNcdA3BD3u
 2iTdqxJDvu9bJXgvamX2si/N7JvRJGpOFxWJ6mB0gKd18EkobrgNqyqwcD33+8ddKZ4/ZYEUc/c
 kqd02or/tneqyCrnvajuseMnBGYtWDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

On 9/22/26 9:01 PM, Matthew Rosato wrote:
> On 9/22/26 5:33 PM, Matthew Rosato wrote:
>> On 9/14/26 3:34 PM, Zhuoying Cai wrote:
>>> changelog v2->v3
>>
>> FYI, this will need a respin to handle merge conflicts I'm getting
>> against master.  I didn't investigate, but I assume it's due to Jared's
>> virtio-scsi-pci series merging.
>>
> 
> This series is close; please respin to address the merge conflicts,
> minor comments, and if you address the message confusion on the qtests I
> will take another review pass at those - they ran as expected and the
> code overall looks good it's just that I'd really like less-confusing
> breadcrumbs should a test skip/fail.
> 
> Thanks,
> Matt

I’ll address all the feedback and send out a new version soon. Thank you!

