Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2086BCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOxP-0008EY-QZ; Fri, 08 May 2026 13:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wLOx4-00087e-Gd; Fri, 08 May 2026 13:25:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wLOx1-0003wD-1T; Fri, 08 May 2026 13:25:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6487nUkB800514; Fri, 8 May 2026 17:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+402Gl
 znCJNCPv+UZktYMAWjxiYJJOcsC3HX2IxOQbc=; b=Z9DDWmmA+o2tSXgnMsD0wM
 H9PAzejK0eGOfkcUlrHwi8kO7Vy+S7nsujUjo8D0XR8Zlnal+4Ox7FGnfICIVvcr
 R5DUP4HDi0CWx/+Zpc3WvDvbS8tiAVXEAQjxqz3XG1/qlWJcPECAB7cngcSCw24T
 vERcikpVUi9ncnnkUhPueyXmI+OaQQr5Ya/Cr285WmJ/pfA3fssk2EgzAMZjTGto
 14wVY9oJqBCEaf3nSEf3RiZIk0qZtnAiUHKKL6/boCkB79VTPOYNIav3jnef6Bf5
 gzgOt63yPPCReuFCOJ+vjyZFXgexdlF914SQikg+UFTjoN3pUDcwf+arZz6mdqhQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x54vkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:25:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648HOTeY017118;
 Fri, 8 May 2026 17:25:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hh4n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:25:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648HPFrW31654476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 17:25:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BBD75805D;
 Fri,  8 May 2026 17:25:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D83658056;
 Fri,  8 May 2026 17:25:15 +0000 (GMT)
Received: from [9.61.162.242] (unknown [9.61.162.242])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 17:25:14 +0000 (GMT)
Message-ID: <070d2e8f-dcba-4846-9d0c-a733fb2b1448@linux.ibm.com>
Date: Fri, 8 May 2026 13:25:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
To: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-s390x@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20260506174135.2630613-1-thuth@redhat.com>
 <946651d9-0cd5-4482-96e5-a4c59b4d5fcc@linux.ibm.com>
 <1400ae28-5bac-4c18-afa2-64fd11293c05@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <1400ae28-5bac-4c18-afa2-64fd11293c05@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX/yA0lhRcmT4z
 xP4tf8+GPo/M+PEq7l4Ben5vH/jjFF8JuxaM3P7V0lM7hpLr3n6pmwE+HkHBEHS2uXmQ9RxIUYV
 U6usU7Zat7AfJl35rc51TvxH299p/a+m3Zohjc4JrFCYWlPR5Nr+6EpALiI3BCnDO3U64e4ssn4
 KAOIQ46jfVP/G6MbubmigSki+5RNi2wjA2OApoimEceYXjeuB36URZYaqfDz9eVx1E+JB+aj/e/
 aORuNkKnZ3lNRwEWIGWHiUF7+PlgSJkG+m7HcaVSVrsqyAbcMkeaA2g/zdBcC4Nrqomn1eeop6k
 M3x2yYAsCMKddCue3X2Ni92aWLlOk3A3RNH2olrs1Ek5x6qGN2NsqQD0JowQeG9M0Q9mDMEl4f0
 9r3tCxKzWHGaS1wagvDsT0nYhFocysosGM21ujwt+Yba8JBO0XDcb0Nrm52SwNzD+gdu2aKbKfs
 HSInH0yz0JtzUxxxXDA==
X-Proofpoint-ORIG-GUID: kV-hZSzqosBbTJcpY6rUCxpO7e2YzG2Q
X-Proofpoint-GUID: kV-hZSzqosBbTJcpY6rUCxpO7e2YzG2Q
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fe1c7e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=9fMvcRJvRAoHR0IlenoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080171
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

On 5/7/26 3:31 AM, Thomas Huth wrote:
> On 06/05/2026 21.45, Matthew Rosato wrote:
>> On 5/6/26 1:41 PM, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The elements that get removed with QTAILQ_REMOVE are never referenced
>>> afterwards anymore, so the corresponding memory should get freed.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c  | 1 +
>>>   hw/s390x/s390-pci-vfio.c | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>
>> Thanks Thomas!  Code looks good and I did some regression testing with
>> this patch applied:
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> Should we also consider adding:
>>
>> Fixes: b354d5d804 ("s390x/pci: clean up s390 PCI groups")
>> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
> 
> Yes, that makes sense.
> 
> Actually, looking at the commit description of b354d5d804, I think this
> code has been added with a wrong assumption: The unrealize method is not
> called during system reset.

So, yes, you're right that this isn't doing what was intended per the
commit message...

> So to free the memory, this should likely be added to a reset handler
> instead? Could you maybe have a look?

But I also don't think that we really want to arbitrarily clear this
list on a machine reset.

As written, it's only OK to free this list arbitrarily if we are 1)
ending the process anyway or 2) can expect another call to
s390_pcihost_realize() + device plug (s390_pcihost_plug) events for all
devices in order to re-establish new group pointers.

When we do, say, a reboot or kexec in the guest, because the associated
devices did not go through an unplug they continue to use the reference
to their pci_group which should be OK -- the underlying vfio device will
still give the same group data post-reset.  (Or, if it's an emulated
device, it will today always use the same QEMU-defined group)

I think the only issue is that when we do actually unplug vfio-pci
devices, we can potentially orphan groups in the list that are no longer
used.  Fortunately there is an upper-limit of 256 entries; while the
S390PCIGroup supports a full int, s390-pci-vfio.c will base all group
IDs from a uint8_t.
But it does leave a theoretical issue of what if the device is also
unplugged from the host, and a new device later comes along that re-uses
the host group ID with new group info, and then you pass that device
through to this guest.

So: I wonder if the proper thing to do is to refcount the groups during
plug and remove them from the list during unplug when refcount hits 0
(and of course, add the missing g_free here) -- with special handling
for the default group that should never go away.

Which is probably more than you signed on for with this patch ;) If
you'd like, I can instead sort this out and give you a reported-by?

Meanwhile you could still split out the fix to s390_pci_end_dma_count()
and send that one again by itself (w/ Fixes: 37fa32de70)

Thanks,
Matt



