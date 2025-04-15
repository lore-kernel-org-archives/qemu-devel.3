Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C5C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cLp-0001sw-6L; Tue, 15 Apr 2025 05:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1u4cLn-0001sO-2B; Tue, 15 Apr 2025 05:13:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1u4cLg-0000lT-4D; Tue, 15 Apr 2025 05:13:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F7PahI026315;
 Tue, 15 Apr 2025 09:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GYwgXv
 gogHbf4Rxmw4tj0ygllOpjn6We9NadOBf+OmQ=; b=VUjRUYiE3zsWmcU/k4oa22
 z2BZB6z1sh3khqNfiA/QW0O2h1CaVs/uy1+5lSQRyOXNWp6XzxNOd6Rxo/pcYseY
 d8xXBzEYpVKtRVaSeaBuy33nFDi+cdEqjQ9pgpsybS8yU8CMXATWng/X55VHQHNI
 ZfMGVrnm1wzJwJQo5zxj/M43k5WNMJnzzrDZrh9K56mmsaZ0aJapCMw28wMS/NMo
 /50mfE4gGtGB4fqOm2kMp29hYR1m3asgbpbCjcfiwZ48a6afb9gb/zr0DWA8ZKRp
 UvNMQlFKbh9pFdf3zCykdCyK/pHz6WY2EzgdqiHFQbKYgkHD7LCJG7j8si8gdYvQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f5sq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 09:12:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53F97gj4014268;
 Tue, 15 Apr 2025 09:12:06 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f5spy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 09:12:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8NrOD024882;
 Tue, 15 Apr 2025 09:12:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtaqnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 09:12:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53F9C4vm16188030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 09:12:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7033D5803F;
 Tue, 15 Apr 2025 09:12:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FEA258056;
 Tue, 15 Apr 2025 09:12:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Apr 2025 09:12:03 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 11:12:02 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Michael Rolnik <mrolnik@gmail.com>, Helge Deller
 <deller@gmx.de>, Song Gao <gaosong@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, Stafford
 Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Thomas Huth <thuth@redhat.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH 01/17] accel/tcg: Store section pointer in CPUTLBEntryFull
In-Reply-To: <20250415081231.21186-2-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
 <20250415081231.21186-2-jim.shu@sifive.com>
Message-ID: <2dd5952a93aca15bbae4b5624b680637@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HB-xAWOWlqrH5x5tcS9sBMp2CsTcscjv
X-Proofpoint-ORIG-GUID: rVrALMiRTwmK2Otn1O2icx0hNubiDuRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=784 malwarescore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2025-04-15 10:12, Jim Shu wrote:
> 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> find the correct section when CPU access the IO region over the IOTLB
> (iotlb_to_section()).
> 
> However, section_index is only unique inside single AddressSpace. If
> address space translation is over IOMMUMemoryRegion, it could return
> section from other AddressSpace. 'iotlb_to_section()' API only finds 
> the
> sections from CPU's AddressSpace so that it couldn't find section in
> other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> wrong section and QEMU will have wrong load/store access.
> 
> To fix this bug, store complete MemoryRegionSection pointer in
> CPUTLBEntryFull instead of section_index.
> 
> This bug occurs only when
> (1) IOMMUMemoryRegion is in the path of CPU access.
> (2) IOMMUMemoryRegion returns different target_as and the section is in
> the IO region.
> 
> Common IOMMU devices don't have this issue since they are only in the
> path of DMA access. Currently, the bug only occurs when ARM MPC device
> (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> handling. Upcoming RISC-V wgChecker device is also affected by this 
> bug.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  accel/tcg/cputlb.c    | 19 +++++++++----------
>  include/hw/core/cpu.h |  3 +++
>  2 files changed, 12 insertions(+), 10 deletions(-)

Does this mean that there can be more than 4k sections now and the
assertion in phys_section_add() can be removed?

