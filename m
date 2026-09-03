Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4AC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BfA-0008Bl-SF; Thu, 03 Sep 2026 13:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x2Bf9-0008BU-84; Thu, 03 Sep 2026 13:55:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x2Bf6-00073j-SH; Thu, 03 Sep 2026 13:55:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2e9E1550225; Thu, 3 Sep 2026 17:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tOFsbQ
 2xJhEAkIGWjvuU3YUQI73jFJ+DVxI6VQa2Wec=; b=hKHlYXzeLltjX9Rdi6wwR4
 rhwKwBxoEBKN4Ces6kpGriAtyqm3VcGI550+fRZLbIGiaYqoFtI6bmF6ifNGvC1Y
 e1Orj+lByv5Dxhg3NDnU0ATLJNknTtk1zQhyA6YbZidUliTGhpJIDrEWEGpd+Dyq
 KXqosDPT5t4RMc/rfHlwhYbV8ATBkXjXm8SZF8Ng/L8c0Ku8JkF6+QcfGsEXt9kB
 f7eknZw2QID1piqdORF84KwttBt5mYcWMAbiZ/z9VLUNN3IfJvqgpI0SWc4WD51e
 iw+Wqd308Uak2oMqBeatT1SpbZ6eT7pgoYcPFER1W5dLLso8KJAKFsxYd+v32T7w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rp99g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 17:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683HfPC4032033;
 Thu, 3 Sep 2026 17:55:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygrncr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 17:55:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Hta983473942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 17:55:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DA705805D;
 Thu,  3 Sep 2026 17:55:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D95158054;
 Thu,  3 Sep 2026 17:55:35 +0000 (GMT)
Received: from [9.61.255.190] (unknown [9.61.255.190])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 17:55:35 +0000 (GMT)
Message-ID: <e6dfaf88-e1af-4744-baa2-ef1d760e0bd0@linux.ibm.com>
Date: Thu, 3 Sep 2026 10:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Error recovery for zPCI passthrough devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <a5dea766-1131-49cb-bd26-6a09673b176e@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <a5dea766-1131-49cb-bd26-6a09673b176e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99b49a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=NEAV23lmAAAA:8 a=d-hLNGcf60fGikFE0MUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE1MyBTYWx0ZWRfXw64C5/uqFs4d
 JURIRkC6mw3eTRUml8T/8/9Dm9nVAYZeuiXUSs/eoYVSyF/7dwsqLNN+t5oxDiqPod5OSHMarbG
 LVNMQ0R2e2j+CBF/Nj397CH2eAlByZPe8z6VTtyikmq2QGiTW/E4nXXBvB/px75zmULZOqSc2v3
 vxS4mdaY2V3fSD62OmHw8YyAc1nK4ydB2SAjVpaZbLGbZB9iRbpTz42nuE4vgPGIJkVMvxgr7Gq
 CD0l0jiwEwHMV801nWwHs//HODWQhbx97sj56PTuNVOE9G2eqkMhldFD5o5TNAvjtoIoBPur7F7
 za/ahyZi6WkL1XYS5bDRjOqS0zyJAe9YgyU4dS8Tg9Rb5d+AUHBvrd52Zvnjk41zQv00lYnnrWB
 wenXIQWDSoSUbS7b9ayRGvg1zaq5yWjEP7IPhinRSixFeAvNM27LJzKy4CSOpGsZ4peC3gcEfVr
 Ooz2VrJoYX5H5GSR7ng==
X-Proofpoint-GUID: N3-u3bK-25w7AkjDHBuhO0lxxub7YUSR
X-Proofpoint-ORIG-GUID: N3-u3bK-25w7AkjDHBuhO0lxxub7YUSR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE1MyBTYWx0ZWRfX7CT+gBS8PoW4
 pGlCU7m3litlcYDyux3a867ajJEIpbiM9GF37ReFAQJaSO84qJ5TYuapRBvXaSck+aWN+3sumAp
 fEOccdvk5Gfl3aNLKDErmrfKwevstqY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 9/3/2026 2:19 AM, Cédric Le Goater wrote:
> On 8/31/26 20:31, Farhan Ali wrote:
>> Hi,
>>
>> This patch series introduces support for error recovery for 
>> passthrough PCI
>> devices on System Z (s390x). This is the user space component for the 
>> Linux
>> kernel patches [1]. The kernel patches were merged for 7.3 and it had 
>> some
>> significant changes in VFIO API since the last QEMU series was 
>> posted. But the
>> design for QEMU component is still the same.
>>
>> For QEMU on eventfd notification for PCI error from vfio-pci driver 
>> we call the
>> vfio error handler. We can use a per device error handler callback to 
>> override
>> the default vfio error handler.  For s390x specific error handler, we 
>> retrieve
>> the architecture specific PCI error information and inject the 
>> information into
>> the guest. Once the guest receives the error information, the guest 
>> drivers will
>> drive the error recovery.  Typically recovery involves a device reset 
>> which
>> translate to CLP disable/enable cycle for the device.
>>
>> I would appreciate some feedback on this patch series.
>
Hi Cedric,

> Hi Farhan,
>
> Have you seen Shameer's kernel series for PCI error recovery [1] ?
> It uses a dedicated eventfd registered via VFIO_DEVICE_FEATURE_SET,
> with a self-contained handler independent of the legacy err_notifier.
>
> The QEMU side [2] just probes the feature, installs the eventfd, and
> suppresses the legacy vm_stop path with a bool flag : no callback in
> generic VFIO PCI code, which is cleaner.
>
> This is also the pattern used by the other s390 VFIO devices: vfio-ccw
> has three dedicated eventfds (io_notifier, crw_notifier, req_notifier)
> and vfio-ap has two (req_notifier, cfg_notifier).

My thought process was to use the existing legacy err_notifier and let 
each vfio-pci device handle the error. I thought the callback would also 
provide some flexibility on each device handling the error.

I can take a look at Shameer's approach and see if its something we can 
do. Just briefly looking at the QEMU code, it looks like it it ties the 
eventfd to the generic vfio-pci code (of course this is in flux). This 
would become problematic for s390x as unfortunately AER recovery will 
not work for zPCI devices due to platform firmware being involved in the 
recovery process.

> For zPCI, it would mean extending VFIO_DEVICE_FEATURE_ZPCI_ERROR to
> support SET with an eventfd field. The ABI is still new so the struct
> can be extended, keeping the s390 error recovery code self-contained,
> with no changes to generic VFIO  PCI code. I think this approach is
> preferable.
>
I would like to get some feedback from Alex to see if we could extend 
the ABI.

Thanks

Farhan


> Thanks,
>
> C.
>
> [1] 
> https://lore.kernel.org/all/20260901093217.8539-1-skolothumtho@nvidia.com/
> [2] 
> https://github.com/shamiali2008/qemu-master/commit/e45458710cd8509fa5bd81f4376126b77b6f40be
>
>

