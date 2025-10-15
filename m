Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DD1CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94JW-0003pi-GD; Wed, 15 Oct 2025 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v94JT-0003pR-9N; Wed, 15 Oct 2025 12:25:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v94JI-0006xM-JA; Wed, 15 Oct 2025 12:25:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDh6sY009916;
 Wed, 15 Oct 2025 16:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VZpRoZ
 Oviq1H1OzYdb/+YlOy4X2WnqtsAcg93jd0oLo=; b=g6/VIAPc/uYUUjguqQ4ShD
 dzm5oiy0enCQVTh1KIMGy+N6VBhIhmiRaOSZHB9p6bmglhiTtPpnhO5RyRF99A4Y
 6dM/QV54H5F3uQeqH87mf7bA5vEcQp9GdycQh29C+2iUQi7Z/31XTgZUJjl6oqqB
 5OGV9CHcMPCTKKRevB1Ug7XmG705UT0zncWxNdqHzzhyO67RYe0RvsrRdKCISiyH
 hVF1bRzfrkY7sjrgGcLc3NNboLXh7wUsN0Bz/1h8gCc199gtIvZbeMiE8PPbCiWW
 rA2pfeHpg3C61LUe7nw3xgzLI5yVz7CTjn4h9ZxkBSw16vwXni3okp19JmcvbBVQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpn0k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 16:25:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FGP4lK013457;
 Wed, 15 Oct 2025 16:25:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpn0k3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 16:25:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FEYHnW028071;
 Wed, 15 Oct 2025 16:25:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg98f8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 16:25:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59FGOxl553150146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 16:24:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 467FB2008B;
 Wed, 15 Oct 2025 16:24:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1398A2008C;
 Wed, 15 Oct 2025 16:24:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.24.169])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Oct 2025 16:24:46 +0000 (GMT)
Date: Wed, 15 Oct 2025 21:54:44 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
Message-ID: <aO_KzHgv-D7fXni2@linux.ibm.com>
References: <20251015134716.1099351-2-vishalc@linux.ibm.com>
 <aO-pc3Qgi9tmr1JZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aO-pc3Qgi9tmr1JZ@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX7i+KERfZbfqK
 qjoZj9QeAuCipNHyKNaE3gXY6jcDq4KYV71ojuHhsvozsrsiG0DItBJ5kXP0oCIvUSzuXr7tT2O
 qZNs2hUs+fS3/mJVJRSbgnCHW6zoYXR2xPMw8o3pRUy0xQo3jk5Lhb/nc6N/fIBu1EPi5q5hsww
 GNxVacfuXSvLVm2SBN3+uoD8F2FjJFSNJM0i7r4nqzOwqpyl7yOrSQddAZ9RCG2fbVQOAvPlM6o
 mR7FS9Sgyw97A3Fg0ymuHTX+o2I9T/A7xtUfmv8ix4/x31WTETWHA9ifnp+T5n2cZdlXHfzjyZH
 t2KNorrTrgA9TGyMSJyy+KTIzjP76uNQ9t/p1VncieiTHMqr5APM3x5g+9wTQ0HaFHI6iV96Tmr
 lKSW1MNlAmIapdzrLPPRgFInNI2LaQ==
X-Proofpoint-ORIG-GUID: BoFofPI--UJ0l5BpDJcvJreOcqmlX6Vr
X-Proofpoint-GUID: HLW9rOdgiIpVeMxOmudlPEpMnvS-Fweb
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68efcae0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tZty7TLBYI1PViTkrPsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005
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

Hello Daniel,

Thank you for the review!

On Wed, Oct 15, 2025 at 03:02:27PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 15, 2025 at 07:17:17PM +0530, Vishal Chourasia wrote:
> > diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> > index e72bbde2a2..8cf5aadf1f 100644
> > --- a/hw/core/generic-loader.c
> > +++ b/hw/core/generic-loader.c
> > @@ -148,13 +148,14 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
> >  
> >          if (size < 0 || s->force_raw) {
> >              /* Default to the maximum size being the machine's ram size */
> > -            size = load_image_targphys_as(s->file, s->addr, current_machine->ram_size, as);
> > +            size = load_image_targphys_as(s->file, s->addr,
> > +                    current_machine->ram_size, as, errp);
> >          } else {
> >              s->addr = entry;
> >          }
> >  
> > -        if (size < 0) {
> > -            error_setg(errp, "Cannot load specified image %s", s->file);
> > +        if (*errp || size < 0) {
> 
> We should not have to check both *errp and 'size < 0'.
Sure, I will remove the `*errp`

> We must ensure that every code path in 'load_image_targphys_as' that can
> return -1, will *always* fills in 'errp', so that callers can be sure
> that *errp is always non-NULL on failure.
> 

> > +            error_reportf_err(*errp, "Cannot load specified image %s", s->file);
> 
> This method is propagating the error to the caller in its 'errp'
> parameter, so it is wrong to call error_reportf_err. The latter
> should only be used at the final point in the callstack which
> owns the 'Error' parameter.
> 
> The only change in this method should be to remove the existing
> error_setg call.
Agreed. Removing it altogether.

> > diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> > index 3db89d7a2e..d4f749fd6e 100644
> > --- a/hw/core/guest-loader.c
> > +++ b/hw/core/guest-loader.c
> > @@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
> >  
> >      /* Default to the maximum size being the machine's ram size */
> >      size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
> > -                                  NULL);
> > -    if (size < 0) {
> > -        error_setg(errp, "Cannot load specified image %s", file);
> > +                                  NULL, errp);
> > +    if (*errp || size < 0) {
> > +        error_reportf_err(*errp, "Cannot load specified image %s", file);
> >          return;
> 
> Again must not be calling error_reportf_err nor chcking *errp,
> just remove error_setg().
Will remove.

> >  
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 477661a025..d8c02786d2 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -48,6 +48,7 @@
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-machine.h"
> >  #include "qapi/type-helpers.h"
> > +#include "qemu/units.h"
> >  #include "trace.h"
> >  #include "hw/hw.h"
> >  #include "disas/disas.h"
> > @@ -61,23 +62,31 @@
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "system/memory.h"
> >  #include "hw/boards.h"
> > +#include "qapi/error.h"
> >  #include "qemu/cutils.h"
> >  #include "system/runstate.h"
> >  #include "tcg/debuginfo.h"
> >  
> > +#include <errno.h>
> >  #include <zlib.h>
> >  
> >  static int roms_loaded;
> >  
> >  /* return the size or -1 if error */
> > -int64_t get_image_size(const char *filename)
> > +int64_t get_image_size(const char *filename, Error **errp)
> >  {
> >      int fd;
> >      int64_t size;
> >      fd = open(filename, O_RDONLY | O_BINARY);
> > -    if (fd < 0)
> > +    if (fd < 0) {
> > +        error_setg_file_open(errp, errno, filename);
> >          return -1;
> > +    }
> 
> This perhaps ought to be changed to call 'qemu_open' which
> already fills in an Error object, and additionally protects
> the fd with O_CLOEXEC and handles FD passing with /dev/fdset
> 
Make sense, thanks for the suggestion. 

> >      size = lseek(fd, 0, SEEK_END);
> > +    if (size < 0) {
> > +        error_setg_errno(errp, errno, "lseek failure");
> > +        return -1;
> > +    }
> >      close(fd);
> >      return size;
> >  }
> > @@ -118,21 +127,28 @@ ssize_t read_targphys(const char *name,
> >  }
> >  
> >  ssize_t load_image_targphys(const char *filename,
> > -                            hwaddr addr, uint64_t max_sz)
> > +                            hwaddr addr, uint64_t max_sz, Error **errp)
> >  {
> > -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> > +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
> >  }
> >  
> >  /* return the size or -1 if error */
> >  ssize_t load_image_targphys_as(const char *filename,
> > -                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
> > +                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
> > +                               Error **errp)
> >  {
> >      ssize_t size;
> >  
> > -    size = get_image_size(filename);
> > -    if (size < 0 || size > max_sz) {
> > +    size = get_image_size(filename, errp);
> > +    if (*errp || size < 0) {
> 
> Must not chck *errp, only 'size < 0'.
Sure. I will modify accordingly.

> 
> >          return -1;
> >      }
> > +
> > +    if (size > max_sz) {
> > +        error_setg(errp, "Exceeds maximum image size (%lu MiB)", max_sz / MiB);
> > +        return -1;
> > +    }
> > +
> >      if (size > 0) {
> >          if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> >              return -1;
> > @@ -150,7 +166,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr)
> >          return -1;
> >      }
> >  
> > -    size = get_image_size(filename);
> > +    size = get_image_size(filename, NULL);
> >  
> >      if (size < 0 || size > memory_region_size(mr)) {
> >          return -1;
> 
> 
> I'd suggest that we add the Error parameter in one patch, making every
> caller pass NULL. Then a second patch update the callers to pass a
> non-NULL errp and use error_report_err to print details, ideally  for
> more than just the 1 ppc source file. 

sure.

Planning to make following changes as per your review.

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 8cf5aadf1f..cd636d9d89 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -154,8 +154,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
             s->addr = entry;
         }

-        if (*errp || size < 0) {
-            error_reportf_err(*errp, "Cannot load specified image %s", s->file);
+        if (size < 0) {
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index d4f749fd6e..9722474480 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -102,8 +102,7 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
                                   NULL, errp);
-    if (*errp || size < 0) {
-        error_reportf_err(*errp, "Cannot load specified image %s", file);
+    if (size < 0) {
         return;
     }

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d8c02786d2..68cf982efe 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -77,14 +77,13 @@ int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
-    fd = open(filename, O_RDONLY | O_BINARY);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
     if (fd < 0) {
-        error_setg_file_open(errp, errno, filename);
         return -1;
     }
     size = lseek(fd, 0, SEEK_END);
     if (size < 0) {
-        error_setg_errno(errp, errno, "lseek failure");
+        error_setg_errno(errp, errno, "lseek failure: %s", filename);
         return -1;
     }
     close(fd);
@@ -140,12 +139,12 @@ ssize_t load_image_targphys_as(const char *filename,
     ssize_t size;

     size = get_image_size(filename, errp);
-    if (*errp || size < 0) {
+    if (size < 0) {
         return -1;
     }

     if (size > max_sz) {
-        error_setg(errp, "Exceeds maximum image size (%lu MiB)", max_sz / MiB);
+        error_setg(errp, "%s exceeds maximum image size (%lu MiB)", filename, max_sz / MiB);
         return -1;
     }

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e293d2ef35..16f3802717 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1072,8 +1072,7 @@ static void pnv_init(MachineState *machine)
     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
                                     &errp);
     if (fw_size < 0) {
-        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
-                fw_filename);
+        error_report_err(errp);
         exit(1);
     }
     g_free(fw_filename);
@@ -1086,8 +1085,7 @@ static void pnv_init(MachineState *machine)
                                           KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
                                           &errp);
         if (kernel_size < 0) {
-            error_reportf_err(errp, "Could not load kernel '%s': ",
-                    machine->kernel_filename);
+            error_report_err(errp);
             exit(1);
         }
     }
@@ -1098,8 +1096,7 @@ static void pnv_init(MachineState *machine)
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                   pnv->initrd_base, INITRD_MAX_SIZE, &errp);
         if (pnv->initrd_size < 0) {
-            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
-                    machine->initrd_filename);
+            error_report_err(errp);
             exit(1);
         }
     }


- vishalc


