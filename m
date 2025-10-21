Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B4CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7n6-0002X6-BW; Tue, 21 Oct 2025 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vB7n4-0002Wi-BD; Tue, 21 Oct 2025 04:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vB7n1-0007i3-1t; Tue, 21 Oct 2025 04:32:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8R3c4009507;
 Tue, 21 Oct 2025 08:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=vLnCawyDL/VEHAnnaV3vKnHHhkUKR8
 864vG/Umi8hzk=; b=fhKvkx/o3BGBiyxaTTr95mVemsmXpto6GAxWFevBRyIquz
 AmSRk93bc31L/C91AXZISe1ttBCxjK6Xa8xWH/rWJegaA+/W1wkhB6R+jK3TwBii
 jTrAfgGJpCCvT8JfF3FPd5guO4oSfvbRixeYSYCc6LOxnxz7lmaZxL05ZAhjHsLD
 cC0ZPFbAWRoNLw4timMP2zM5y61Oo3vr6MJGw+cxFnW2JSIUxgE2yAfRK/qVzyPb
 j+TcyT6MEGN0mhjoXyVgNCxjdCWrch4K/IfJXQih4u367CD+GJbrbAGII1MpbTgI
 CqI897nTK6BecuyOQGB+txZA50fVY8EElLI0CK4Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326nxk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:31:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L8Ru0x029252;
 Tue, 21 Oct 2025 08:31:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326nxk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:31:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L6sdxL014685;
 Tue, 21 Oct 2025 08:31:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s20re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:31:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L8VsAL44695882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 08:31:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2844A20043;
 Tue, 21 Oct 2025 08:31:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3643020040;
 Tue, 21 Oct 2025 08:31:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.24.196])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 08:31:47 +0000 (GMT)
Date: Tue, 21 Oct 2025 14:01:45 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
Subject: Re: [Patch v4 1/5] hw/core/loader: capture Error from
 load_image_targphys
Message-ID: <aPdE8Wff6L8i4ybB@linux.ibm.com>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
 <20251017181250.1421446-4-vishalc@linux.ibm.com>
 <0026ec98-fa2b-7bf2-e40e-b8938b4f8c6f@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0026ec98-fa2b-7bf2-e40e-b8938b4f8c6f@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f744ff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=LDkM-SLTlzFY3Jr0tcQA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9arYl3HVnCBc
 feSoF2AP3ThgRKJTgQgRg1qy1BCujulOUN0MqnzUZA/lYF3GSVLG9eN0yjBHdtJVS3MPw1NIzIV
 JXf4LgIril3M+m9KwyUJR97cXWKKcl+9nysAYCWuEvnmMzfCNuYqPm7xGXTJU1nsShadDCfEtkj
 6v/gf9txlHUduVLMaFb15NrzI1whP7I9Yv4ZX5zZAGGdDsvzJSjm4RHyn50YScUbZVOLhps8BlV
 66Z8gCAE3rbcTisNWykfgbUEPEKDvz9oatYcKevnZUnmIP1bskNsiQpMl8ofEmkiXMQCFC3YaTD
 /4dMAMoFMP+biKvfRzjEWZNrQCkbW3KhsKe+CCSloGs3493vI4KsJaNH5dbc6XtA/8A24VgBiQA
 yi/WGdVn8mDd2LnnYtY05uGmfvP6zg==
X-Proofpoint-GUID: wqtQcZgA523dsswzzDWqq1KDOuDvhP9W
X-Proofpoint-ORIG-GUID: iTeW5zL9F6ZJ5UWl1Igzof67VcwtTyPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, Oct 17, 2025 at 09:25:41PM +0200, BALATON Zoltan wrote:
> On Fri, 17 Oct 2025, Vishal Chourasia wrote:
> > Add Error **errp parameter to load_image_targphys(),
> > load_image_targphys_as(), and get_image_size() to enable better
> > error reporting when image loading fails.
> > 
> > Pass NULL for errp in all existing call sites to maintain current
> > behavior. No functional change intended in this patch.
> > 
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > ---
> > hw/alpha/dp264.c         |  4 ++--
> > hw/arm/armv7m.c          |  2 +-
> > hw/arm/boot.c            |  5 +++--
> > hw/arm/digic_boards.c    |  2 +-
> > hw/arm/highbank.c        |  3 ++-
> > hw/arm/raspi.c           |  2 +-
> > hw/arm/vexpress.c        |  2 +-
> > hw/core/generic-loader.c |  3 ++-
> > hw/core/guest-loader.c   |  2 +-
> > hw/core/loader.c         | 40 ++++++++++++++++++++++++++++++++--------
> > hw/hppa/machine.c        |  5 +++--
> > hw/i386/multiboot.c      |  2 +-
> > hw/i386/x86-common.c     |  4 ++--
> > hw/ipmi/ipmi_bmc_sim.c   |  2 +-
> > hw/loongarch/boot.c      |  5 ++---
> > hw/m68k/an5206.c         |  2 +-
> > hw/m68k/mcf5208.c        |  4 ++--
> > hw/m68k/next-cube.c      |  2 +-
> > hw/m68k/q800.c           |  7 ++++---
> > hw/m68k/virt.c           |  4 ++--
> > hw/microblaze/boot.c     |  5 +++--
> > hw/mips/boston.c         |  2 +-
> > hw/mips/fuloong2e.c      |  9 +++++----
> > hw/mips/jazz.c           |  2 +-
> > hw/mips/loongson3_virt.c | 10 ++++++----
> > hw/mips/malta.c          |  9 +++++----
> > hw/nubus/nubus-device.c  |  2 +-
> > hw/openrisc/boot.c       |  5 +++--
> > hw/pci/pci.c             |  2 +-
> > hw/ppc/amigaone.c        |  4 ++--
> > hw/ppc/e500.c            |  5 +++--
> > hw/ppc/mac_newworld.c    |  9 ++++++---
> > hw/ppc/mac_oldworld.c    |  9 ++++++---
> > hw/ppc/pegasos2.c        |  5 +++--
> > hw/ppc/pnv.c             |  9 ++++++---
> > hw/ppc/ppc440_bamboo.c   |  3 ++-
> > hw/ppc/prep.c            |  8 +++++---
> > hw/ppc/sam460ex.c        |  3 ++-
> > hw/ppc/spapr.c           |  8 ++++----
> > hw/ppc/virtex_ml507.c    |  5 +++--
> > hw/riscv/boot.c          |  7 ++++---
> > hw/rx/rx-gdbsim.c        |  2 +-
> > hw/s390x/ipl.c           |  8 +++++---
> > hw/sh4/r2d.c             |  8 +++++---
> > hw/smbios/smbios.c       |  2 +-
> > hw/sparc/leon3.c         |  4 ++--
> > hw/sparc/sun4m.c         |  8 +++++---
> > hw/sparc64/sun4u.c       |  7 ++++---
> > hw/xtensa/xtfpga.c       |  3 ++-
> > include/hw/loader.h      |  8 +++++---
> > system/device_tree.c     |  2 +-
> > 51 files changed, 168 insertions(+), 107 deletions(-)
> [...]
> 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 477661a025..e40cba1b9f 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -48,6 +48,7 @@
> > #include "qapi/error.h"
> > #include "qapi/qapi-commands-machine.h"
> > #include "qapi/type-helpers.h"
> > +#include "qemu/units.h"
> > #include "trace.h"
> > #include "hw/hw.h"
> > #include "disas/disas.h"
> > @@ -61,23 +62,31 @@
> > #include "hw/nvram/fw_cfg.h"
> > #include "system/memory.h"
> > #include "hw/boards.h"
> > +#include "qapi/error.h"
> > #include "qemu/cutils.h"
> > #include "system/runstate.h"
> > #include "tcg/debuginfo.h"
> > 
> > +#include <errno.h>
> > #include <zlib.h>
> > 
> > static int roms_loaded;
> > 
> > /* return the size or -1 if error */
> > -int64_t get_image_size(const char *filename)
> > +int64_t get_image_size(const char *filename, Error **errp)
> > {
> >     int fd;
> >     int64_t size;
> >     fd = open(filename, O_RDONLY | O_BINARY);
> > -    if (fd < 0)
> > +    if (fd < 0) {
> > +        error_setg_file_open(errp, errno, filename);
> >         return -1;
> > +    }
> >     size = lseek(fd, 0, SEEK_END);
> > +    if (size < 0) {
> > +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> > +        return -1;
> > +    }
> >     close(fd);
> >     return size;
> > }
> > @@ -118,23 +127,38 @@ ssize_t read_targphys(const char *name,
> > }
> > 
> > ssize_t load_image_targphys(const char *filename,
> > -                            hwaddr addr, uint64_t max_sz)
> > +                            hwaddr addr, uint64_t max_sz, Error **errp)
> > {
> > -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> > +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
> > }
> > 
> > /* return the size or -1 if error */
> > ssize_t load_image_targphys_as(const char *filename,
> > -                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
> > +                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
> > +                               Error **errp)
> > {
> > +    ERRP_GUARD();
> >     ssize_t size;
> > 
> > -    size = get_image_size(filename);
> > -    if (size < 0 || size > max_sz) {
> > +    size = get_image_size(filename, errp);
> > +    if (*errp) {
> >         return -1;
> >     }
> > +
> > +    if (size == 0) {
> > +        error_setg(errp, "empty file");
> > +        return -1;
> > +    }
> > +
> > +    if (size > max_sz) {
> > +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> > +                   filename, (long unsigned int) max_sz / MiB);
> > +        return -1;
> > +    }
> > +
> >     if (size > 0) {
> >         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> > +            error_setg(errp, "failed to add file as ROM");
> >             return -1;
> 
> These in this file are functional changes adding new messages so that
> contradicts the commmit message and maybe should be in its own patch for
> easier review.
Sure, I will split it into separate patch.

Thanks
vishalc

