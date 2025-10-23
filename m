Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC8CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw0G-0003Cm-Eu; Thu, 23 Oct 2025 10:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBw08-0003AY-Vx; Thu, 23 Oct 2025 10:09:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBw05-0006Tw-Ip; Thu, 23 Oct 2025 10:09:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9900e002342;
 Thu, 23 Oct 2025 14:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=iDKZkquY7aBokhVmL0bu/Ro2THa8la
 sAa0JdvAc0OcM=; b=Q66U5tpyZ2xrfQiS8fGDVGFIyL7MXi7+ADYuX2eZh/jJNG
 GF6/o5nAtebYzmagUiZTtKQmOW42dqBnRPJR+6ytLhJsslxd1hTbc3ynoAG9Qydd
 t/8P4pna3dXcJY4fx6qcsGFB2sKeb2e1BoFRxkoQRVzoy5oS4fn+66J4Qb4eJcm/
 Mq2cuXtByplm+h9OndmzHWqZptAEXSCUd+EikYJrjmKlK++ZDzt5QDYpwzyNoL0h
 Gvz4oqxeQI2fJY9QCONzKER/b2w5IIYWkICePZ4eembs3US+RAmM0MnjAJUzTiOG
 HcAFbCtbYHO8IoziS3s8wy0vNBgR9s4fkjIGttuQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ch745-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 14:09:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NDwje2020485;
 Thu, 23 Oct 2025 14:09:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ch743-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 14:09:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAlndE002381;
 Thu, 23 Oct 2025 14:09:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejnwf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 14:09:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NE8vBH20906652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 14:08:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F6702004E;
 Thu, 23 Oct 2025 14:08:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 996B02004B;
 Thu, 23 Oct 2025 14:08:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.222.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 14:08:53 +0000 (GMT)
Date: Thu, 23 Oct 2025 19:38:48 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Subject: Re: [Patch v7 0/5] hw/core/loader: capture Error from
 load_image_targphys
Message-ID: <aPo28IOBup3XLlfd@linux.ibm.com>
References: <20251022192717.1644251-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022192717.1644251-1-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C6uSXtUD4t6KXCPaZ3w0tWrn_2ukr1sC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7aHs+POtL5fe
 WcewluaElOloNsbe5xXWv5Cxu8kSP3DF0+QdJ402g8StDKOvyLYEb4nu8u3lqQj0794w8U4GUCQ
 qdep0jv0eRndT3A7TT2DipLMWlHw3f2xk3cr73eKnV+PJiW+ebz6jQwMuA99sBpyllvHND4M2rZ
 Wm8hssSZZMQA0wIjnY5KoGxe3MH3dYy7gpHllMHbUXXdwKwhJNjh18CnpBRSwAQC3m1Yy4rpPwF
 m9r062MPb0hml+J5yNG8eUnfnOXlzZ2tD7ZGC8Vs7f7uLh1+KDvVLyuLI6wiA2n0/85dsGBqQaE
 2GkzVHLi+ttM5w9k+PgZr8GuQZ6FPPWVwngG8VCKsBahT+lEqUYsbqR0xccLdOFGCMMmHag+sD1
 dc/TL19gowq8iJk6aLh1/d88d3ppKw==
X-Proofpoint-GUID: 4UuL819XtKjLB9fymOel_c3fVWsAeZmi
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa36ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=FCSi8R6wi129c_b2OPAA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi Peter, Daniel, Alistair, Balaton,

Does the patch series look good for your ack now?

Thanks

On Thu, Oct 23, 2025 at 12:57:12AM +0530, Vishal Chourasia wrote:
> Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
> load_image_targphys(), the error messages are not descriptive enough
> for users to understand why the loading failed. This series adds the
> ability to add Error information through the loader functions to
> provide more detailed error reporting.
> 
> v7:
> - Dropped the patch [hw/ppc/spapr: Rename resize_hpt_err to errp]
>   already merged. Rebased on latest master.
> 
> v6:
> - Pass error_fatal instead of errp where caller exits right after
>   load_image_targphys() fails
> - Include filename in error messages.
> 
> v5:
> - Moved the patch which replaces open() with qemu_open() earlier in the
>   series
> - Incorporated minor changes in the error messages requested by Balaton
> - Moved check for size zero in load_image_targphys_as() into it's
>   separate patch 
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
>   error details (danpb)
> 
> [v6]: https://lore.kernel.org/qemu-devel/20251022132507.1597232-2-vishalc@linux.ibm.com
> [v5]: https://lore.kernel.org/all/20251021105442.1474602-2-vishalc@linux.ibm.com
> [v4]: https://lore.kernel.org/all/20251017181250.1421446-2-vishalc@linux.ibm.com
> [v3]: https://lore.kernel.org/all/20251016173502.1261674-1-vishalc@linux.ibm.com
> [v2]: https://lore.kernel.org/all/20251015134716.1099351-2-vishalc@linux.ibm.com
> [v1]: https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com
> 
> Vishal Chourasia (5):
>   hw/core/loader: Use qemu_open() instead of open() in get_image_size()
>   hw/core/loader: capture Error from load_image_targphys
>   hw/core/loader: add check for zero size in load_image_targphys_as
>   hw/core: Pass errp to load_image_targphys_as()
>   hw/ppc: Pass errp to load_image_targphys() and report errors
> 
>  hw/alpha/dp264.c         |  4 ++--
>  hw/arm/armv7m.c          |  2 +-
>  hw/arm/boot.c            |  5 +++--
>  hw/arm/digic_boards.c    |  2 +-
>  hw/arm/highbank.c        |  3 ++-
>  hw/arm/raspi.c           |  2 +-
>  hw/arm/vexpress.c        |  2 +-
>  hw/core/generic-loader.c |  8 +++++---
>  hw/core/guest-loader.c   |  7 ++++---
>  hw/core/loader.c         | 37 +++++++++++++++++++++++++++++--------
>  hw/hppa/machine.c        |  5 +++--
>  hw/i386/multiboot.c      |  2 +-
>  hw/i386/x86-common.c     |  4 ++--
>  hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>  hw/loongarch/boot.c      |  5 ++---
>  hw/m68k/an5206.c         |  2 +-
>  hw/m68k/mcf5208.c        |  4 ++--
>  hw/m68k/next-cube.c      |  2 +-
>  hw/m68k/q800.c           |  7 ++++---
>  hw/m68k/virt.c           |  4 ++--
>  hw/microblaze/boot.c     |  5 +++--
>  hw/mips/boston.c         |  2 +-
>  hw/mips/fuloong2e.c      |  9 +++++----
>  hw/mips/jazz.c           |  2 +-
>  hw/mips/loongson3_virt.c | 10 ++++++----
>  hw/mips/malta.c          |  9 +++++----
>  hw/nubus/nubus-device.c  |  2 +-
>  hw/openrisc/boot.c       |  5 +++--
>  hw/pci/pci.c             |  2 +-
>  hw/ppc/amigaone.c        | 13 ++-----------
>  hw/ppc/e500.c            | 20 ++++----------------
>  hw/ppc/mac_newworld.c    | 19 ++++++-------------
>  hw/ppc/mac_oldworld.c    | 19 ++++++-------------
>  hw/ppc/pegasos2.c        | 10 +++-------
>  hw/ppc/pnv.c             | 27 ++++++---------------------
>  hw/ppc/ppc440_bamboo.c   |  9 ++-------
>  hw/ppc/prep.c            | 19 ++++++-------------
>  hw/ppc/sam460ex.c        |  8 ++------
>  hw/ppc/spapr.c           | 17 ++++-------------
>  hw/ppc/virtex_ml507.c    | 11 +++--------
>  hw/riscv/boot.c          |  7 ++++---
>  hw/rx/rx-gdbsim.c        |  2 +-
>  hw/s390x/ipl.c           |  8 +++++---
>  hw/sh4/r2d.c             |  8 +++++---
>  hw/smbios/smbios.c       |  2 +-
>  hw/sparc/leon3.c         |  4 ++--
>  hw/sparc/sun4m.c         |  8 +++++---
>  hw/sparc64/sun4u.c       |  7 ++++---
>  hw/xtensa/xtfpga.c       |  3 ++-
>  include/hw/loader.h      |  8 +++++---
>  system/device_tree.c     |  2 +-
>  51 files changed, 173 insertions(+), 213 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

