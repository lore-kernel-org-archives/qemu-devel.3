Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A0CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB3nu-0001B8-An; Tue, 21 Oct 2025 00:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB3ng-00018c-GU; Tue, 21 Oct 2025 00:16:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB3nc-0005g5-OW; Tue, 21 Oct 2025 00:16:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KKf2Uf014762;
 Tue, 21 Oct 2025 04:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AOc1F5
 s2LNIn3qt5Jv/nii/LlsSIhnJo9XvlvxYK/So=; b=pR0L1b85LZTA7UFlQyNw5J
 zmyDCa3HgJvvUrm99T0cO2587VLfeg2RjkkBPnOBBd0hoOivSg+sDSSOV/5ERQr/
 XK3GUGirBhmwl/S+n/arr98IFZECnLqrvKlBKTgDNZzcA8wgNshc6PxNTFHYoJ2s
 Wjw+ZHhS87PFnDyYUUh/P1noiPcqAbPQBWvMW0i9Hri9u+3db4uuQxwXQS/LIw8W
 qW6GV8KIRpI32/LN6z3ks2j607cg1sCtN5G9PUjunH46qdOgg3zfyyq1XX+hOGu1
 gHnF1/M5IUabzPyPhG9FBk/VBPIa/ZM4mPnR3m/ccN1JwnAi/mu+6FF97sEUnBzA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c3s1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:16:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L4EmeD026334;
 Tue, 21 Oct 2025 04:16:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c3s1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:16:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3Umw0024687;
 Tue, 21 Oct 2025 04:16:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjrw7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:16:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L4GXjR30933706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 04:16:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B76F58056;
 Tue, 21 Oct 2025 04:16:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E8775805D;
 Tue, 21 Oct 2025 04:16:30 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 04:16:29 +0000 (GMT)
Message-ID: <cea28220-f39d-43e3-991c-eb8538df0bfc@linux.ibm.com>
Date: Tue, 21 Oct 2025 09:46:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] hw/pci-host/raven clean ups
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <cover.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Np4rI57YBT9i4pTN7RumCfGvPoUNLgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/6gF6qPoS1dZ
 MyHI9GDrQ8TfgtygQxV48R+H9Txz0eYhMG9xnME0lejjyPT7/VyG97GknI/q6Zkhapa4SZkIZDj
 5QmEo3oZQqqhdSctGdbd+ZCMDZOb+PP9BSkQ+yPmiKdOKAuQiJRDNCjzZ8Mz5ud4Do3fCT9+pHp
 bNMM14s2QYfPkKfcBfLh6jSfgJhYXALPvm3Eovtcoh8iMyfN1n7SYmy4QobzNKz3vqcfesVntpG
 Vfa+MgyXFlWhLcbXDYWh2wByAiHpjxfavF+zrGE5Cr8dFxQl+nY02vabtyRgp2Ac4jJn244ectN
 rCgMePNI9SXt5RL+N9y3n+/mQ4fpdON3UoMbf2ky7frOJwLGjXq8fCAEbMWRPljpgZ1PKegFEgv
 iLNJfa/IQmsW8YkrYHr9bU3dpJCCMA==
X-Proofpoint-GUID: L-eY_JY-hWHE6cZgD0S6p4H0R5EuwTmi
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f70923 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=DJXXegCixT14xEhUmasA:9
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22 a=HhbK4dLum7pmb74im6QT:22
 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

+ Mark (since he reviewed v3)
+ Michael, Marcel (for changes in include/hw/pci/pci_host.h , although 
appear safe as only raven specific)

On 10/18/25 19:34, BALATON Zoltan wrote:
> Hello,
> 
> This series cleans up and simplifies the raven model which does some
> strange stuff that no other pci-host is doing and does it in a
> convoluted way and also has some legacy bits that can be removed.
> Apart from making the model much more readable this also fixes the
> non-contiguous IO control bit which was there but did not work as it
> was not connected but apparently it's not really used by any guest so
> that wasn't noticed.
> 
> Regards,
> BALATON Zoltan
> 
> Link to previous version:
> https://patchew.org/QEMU/cover.1758219840.git.balaton@eik.bme.hu/
> 
> V4:
> - added R-b tags from Mark and address some of his review comments
> (other comments not addressed were answered on the list explaining why
> I did not add them to this version)
> - added new patches to fix creation and reset of prep-systemio
> - rebased on master
> 
> V3:
> - rebase on master
> - Fix issue with device-crash-test reported by Akihiko Odaki: make
> sure device is correctly used by adding assert and making it not user
> creatable in patch 14.
> 
> v2:
> - rebase on master
> - add R-b tags from Philippe
> 
> BALATON Zoltan (16):
>    hw/pci-host/raven: Simplify PCI facing part
>    hw/pci-host/raven: Simplify host bridge type declaration
>    hw/pci-host/raven: Use DEFINE_TYPES macro
>    hw/pci-host/raven: Simplify PCI bus creation
>    hw/pci-host/raven: Simplify PCI interrupt routing
>    hw/pci-host/raven: Simplify direct config access address decoding
>    hw/pci-host/raven: Rename direct config access ops
>    hw/pci-host/raven: Use correct parameter in direct access ops
>    hw/pci-host/raven: Do not use parent object for mmcfg region
>    hw/pci-host/raven: Fix PCI config direct access region
>    hw/pci-host/raven: Simpify discontiguous IO access
>    hw/pci-host/raven: Move bus master address space creation to one place
>    hw/pci-host/raven: Do not map regions in init method
>    hw/ppc/prep: Always create prep-systemio
>    hw/ppc/prep: Fix non-contiguous IO control bit
>    hw/ppc/prep: Add reset method to prep-systemio
> 
>   hw/pci-host/raven.c       | 328 ++++++++++++--------------------------
>   hw/ppc/prep.c             |  35 ++--
>   hw/ppc/prep_systemio.c    |  26 ++-
>   include/hw/pci/pci_host.h |   1 -
>   4 files changed, 145 insertions(+), 245 deletions(-)
> 

