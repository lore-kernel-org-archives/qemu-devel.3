Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F12CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 05:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCWgc-0001gh-JL; Sat, 25 Oct 2025 01:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vCWgW-0001gA-NN; Sat, 25 Oct 2025 01:19:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vCWgT-0007Xh-PH; Sat, 25 Oct 2025 01:19:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P4OOdD018285;
 Sat, 25 Oct 2025 05:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cNX5xJ
 RGEck+lP76Z34rwWqZhHJWBhCXp9hzZQ1jznc=; b=dVqrtp1CuOghoOH2p4qXzl
 nROApHgAioSgMHV1RZCFisKMWkfB+N0Age3DaBThRI6bPpBUUisJ2Yixnild1d3i
 MxTjRrELbembhwkyE0xf4DNoTO3GusXN1OEyJAw7Ut3xkvZ+SWN+zJ5LMPOSMK7+
 5UKjbs5vAsgo7KFdf+W965/6EZYDqg8lQrLyQgredCvSZlW0GmZAQ+Q+BQ8IAjRD
 gUQLr6Nmxz2QxSq1AWvgxTsM+rnaU2nSEJUNFfIq1eVncgoDBZOuGi9MXu0CzA3l
 GB47y2FairGjfLg/TAfmyMXCoUgAVukRSVvml8AvbJrTrX9Y/4hos2GJDB1+DVag
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p28r8mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Oct 2025 05:19:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59P5JE7o004163;
 Sat, 25 Oct 2025 05:19:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p28r8mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Oct 2025 05:19:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59P1RxE3014685;
 Sat, 25 Oct 2025 05:19:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7spgwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Oct 2025 05:19:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59P5JCxh27984588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Oct 2025 05:19:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02D9F5804E;
 Sat, 25 Oct 2025 05:19:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 420325803F;
 Sat, 25 Oct 2025 05:19:08 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 25 Oct 2025 05:19:07 +0000 (GMT)
Message-ID: <53420335-4e33-4dea-8cbc-2c1f1b7667a6@linux.ibm.com>
Date: Sat, 25 Oct 2025 10:49:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 0/6] core/loader: capture Error from
 load_image_targphys
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, alistair23@gmail.com, peter.maydell@linaro.org
References: <20251024130556.1942835-2-vishalc@linux.ibm.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, balaton@eik.bme.hu
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251024130556.1942835-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX3otnV3H7nd51
 XWllwz+J7VuWbF/Tuacoss3s0ABnLmlaA/SnlDJxkp+1Bsrk7KzyGA84XGxLIxNOqEPTpq/8g8/
 c7Gb3dJdZZGSfz0NXVUua+12p12xNJbQRHpUtATm/sGvgPFgwD32fvTi1HoWdMEBQPGxxRoVY3P
 ZLpBKdkNIdDveUt9E0wFs/ial6LKQTy/qf5MvB9588n+m9L1PAtKZNpS13h9tkH5G0suX9SjD6R
 2JBwkXmrT0LdTgfoXTW59lMU7slvpvlnpZ4wE+X9OiW0GRzz/BImT20t6TT1K2R0FXun4RHIa4i
 WxaZkHAMT3U7P9y3E/5+jxJX+rsB5FixwH1E8Ls8eXxwSxi2FUuSKa6miXWqCPyyAcMRLorVPpr
 zWdnMT1xMbX0sB9yAI/RW3fegXRYrg==
X-Proofpoint-GUID: QSLNEtTuEKRyow-5Mi1-CPRyl0peemmZ
X-Authority-Analysis: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=68fc5dd3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cAstxx6WfqyoKRQ31CwA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-ORIG-GUID: ViB0xUyfoNpIFthwmLlBJtLdTfLmJ0Bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250019
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Philippe,

Thanks to you and others for valuable inputs on the series.
Should this be queued via your tree ?

Also, I see Daniel and Alistair had provided their R-bs on v3 of the
series, which were not retained possibly since the series had gone
through  multiple iterations with significant improvements. I hope they
should be fine with their ack on finally approved series.

regards,
Harsh

On 10/24/25 18:35, Vishal Chourasia wrote:
> Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
> load_image_targphys(), the error messages are not descriptive enough
> for users to understand why the loading failed. This series adds the
> ability to add Error information through the loader functions to
> provide more detailed error reporting.
> 
> v10:
> - Use size_to_str() to pretty print the maximum size allowed
>    information.
> - Use size < 0 check instead of *errp
> 
> v9:
> - Split Patch 2 from v8 into two patches.
> - Included RB from Aditya Gupta.
> 
> v8:
> - Rebased on latest master.
> - Modified commit message for Patch 5.
> 
> v7:
> - Dropped the patch [hw/ppc/spapr: Rename resize_hpt_err to errp].
>    already merged. Rebased on latest master.
> 
> v6:
> - Pass error_fatal instead of errp where caller exits right after
>    load_image_targphys() fails.
> - Include filename in error messages.
> 
> v5:
> - Moved the patch which replaces open() with qemu_open() earlier in the
>    series.
> - Incorporated minor changes in the error messages requested by Balaton.
> - Moved check for size zero in load_image_targphys_as() into it's
>    separate patch.
> 
> v4:
> - Reject empty files (`size == 0`) with an appropriate error. [1/5]
> - Populate error when `rom_add_file_fixed_as()` fails. [1/5]
> - Add missing check in hw/ppc/virtex_ml507.c [5/5]
> - Fixed checkpatch warnings [5/5]
> - Check errp for failures from load_image_targphys/load_image_targphys_as [3,5/5]
> - Remove unused variables [5/5]
> 
> v3:
> - Use qemu_open() instead of open() in get_image_size() (danpb)
> - Remove redundant error_setg_file_open() call (danpb)
> - Use error_prepend()/error_reportf_err() to preserve underlying
>    error details (danpb)
> 
> [v9]: https://lore.kernel.org/all/20251024092616.1893092-2-vishalc@linux.ibm.com
> [v8]: https://lore.kernel.org/all/20251024052707.1852358-1-vishalc@linux.ibm.com
> [v7]: https://lore.kernel.org/all/20251022192717.1644251-1-vishalc@linux.ibm.com
> [v6]: https://lore.kernel.org/qemu-devel/20251022132507.1597232-2-vishalc@linux.ibm.com
> [v5]: https://lore.kernel.org/all/20251021105442.1474602-2-vishalc@linux.ibm.com
> [v4]: https://lore.kernel.org/all/20251017181250.1421446-2-vishalc@linux.ibm.com
> [v3]: https://lore.kernel.org/all/20251016173502.1261674-1-vishalc@linux.ibm.com
> [v2]: https://lore.kernel.org/all/20251015134716.1099351-2-vishalc@linux.ibm.com
> [v1]: https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com
> 
> Vishal Chourasia (6):
>    core/loader: Use qemu_open() instead of open() in get_image_size()
>    core/loader: capture Error from load_image_targphys
>    core/loader: improve error handling in image loading functions
>    core/loader: add check for zero size in load_image_targphys_as
>    core: Pass errp to load_image_targphys_as()
>    ppc: Pass error_fatal to load_image_targphys()
> 
>   hw/alpha/dp264.c         |  4 ++--
>   hw/arm/armv7m.c          |  2 +-
>   hw/arm/boot.c            |  5 +++--
>   hw/arm/digic_boards.c    |  2 +-
>   hw/arm/highbank.c        |  3 ++-
>   hw/arm/raspi.c           |  2 +-
>   hw/arm/vexpress.c        |  2 +-
>   hw/core/generic-loader.c |  5 +++--
>   hw/core/guest-loader.c   |  4 ++--
>   hw/core/loader.c         | 42 ++++++++++++++++++++++++++++------------
>   hw/hppa/machine.c        |  5 +++--
>   hw/i386/multiboot.c      |  2 +-
>   hw/i386/x86-common.c     |  4 ++--
>   hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>   hw/loongarch/boot.c      |  5 ++---
>   hw/m68k/an5206.c         |  2 +-
>   hw/m68k/mcf5208.c        |  4 ++--
>   hw/m68k/next-cube.c      |  2 +-
>   hw/m68k/q800.c           |  7 ++++---
>   hw/m68k/virt.c           |  4 ++--
>   hw/microblaze/boot.c     |  5 +++--
>   hw/mips/boston.c         |  2 +-
>   hw/mips/fuloong2e.c      |  9 +++++----
>   hw/mips/jazz.c           |  2 +-
>   hw/mips/loongson3_virt.c | 10 ++++++----
>   hw/mips/malta.c          |  9 +++++----
>   hw/nubus/nubus-device.c  |  2 +-
>   hw/openrisc/boot.c       |  5 +++--
>   hw/pci/pci.c             |  2 +-
>   hw/ppc/amigaone.c        | 13 ++-----------
>   hw/ppc/e500.c            | 20 ++++---------------
>   hw/ppc/mac_newworld.c    | 19 ++++++------------
>   hw/ppc/mac_oldworld.c    | 19 ++++++------------
>   hw/ppc/pegasos2.c        | 10 +++-------
>   hw/ppc/pnv.c             | 27 ++++++--------------------
>   hw/ppc/ppc440_bamboo.c   |  9 ++-------
>   hw/ppc/prep.c            | 19 ++++++------------
>   hw/ppc/sam460ex.c        |  8 ++------
>   hw/ppc/spapr.c           | 17 ++++------------
>   hw/ppc/virtex_ml507.c    | 11 +++--------
>   hw/riscv/boot.c          |  7 ++++---
>   hw/rx/rx-gdbsim.c        |  2 +-
>   hw/s390x/ipl.c           |  8 +++++---
>   hw/sh4/r2d.c             |  8 +++++---
>   hw/smbios/smbios.c       |  2 +-
>   hw/sparc/leon3.c         |  4 ++--
>   hw/sparc/sun4m.c         |  8 +++++---
>   hw/sparc64/sun4u.c       |  7 ++++---
>   hw/xtensa/xtfpga.c       |  3 ++-
>   include/hw/loader.h      |  8 +++++---
>   system/device_tree.c     |  2 +-
>   51 files changed, 170 insertions(+), 215 deletions(-)
> 

