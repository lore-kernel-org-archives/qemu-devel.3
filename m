Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C332CCD19E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dLs-000376-HW; Fri, 17 Oct 2025 01:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9dLl-00036V-Km; Fri, 17 Oct 2025 01:50:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9dLi-0004cz-Ip; Fri, 17 Oct 2025 01:50:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H3me8E021054;
 Fri, 17 Oct 2025 05:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GiiAm+
 UrR0SUZZV0VPOEpf59Crzol9ZmKngDoEFvoGY=; b=J+2SyrTDDSdryqND2cj27Y
 uZNQvyIfa+W99mxAzhGeP3si9qC6bbEVx2+ViHg4dgIXz4v5Sk5Nv2Ki1bzva/cz
 KNqhiWBZB/Y7PfTT1JSzMeQhovonf/mBCUW495LBiMyrhG6SfeBE9L0mx2XD0I62
 8TbReO5U08aq04mQRRqhMOV8oOcRBMtsOr5I+QHT1FEhD+m46e8/Hg6ohqtQpmT0
 RfH9CqVu0Kp3ZdJokJpzlmRUOnq3R/CcJr1eKobvn40Vm2UfuHsocg79eQXzTO4F
 jqeyjoBPYOLTgT5EXJ0241YT3NyWB7ApMjfZFP2cxl3sw8zTCA1GlAmjCaCbGwAg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0dn7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 05:49:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H5nV4r003172;
 Fri, 17 Oct 2025 05:49:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0dn75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 05:49:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H50AT3018826;
 Fri, 17 Oct 2025 05:49:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn1md7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 05:49:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H5nQdb34144592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 05:49:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ECD82024C;
 Fri, 17 Oct 2025 05:49:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8C32024B;
 Fri, 17 Oct 2025 05:49:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.22.45])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 05:49:10 +0000 (GMT)
Date: Fri, 17 Oct 2025 11:19:07 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com, richard.henderson@linaro.org,
 alistair@alistair23.me, alex.bennee@linaro.org, deller@gmx.de,
 pbonzini@redhat.com, eduardo@habkost.net, minyard@acm.org,
 gaosong@loongson.cn, maobibo@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, hpoussin@reactos.org, balaton@eik.bme.hu,
 david@redhat.com, chigot@adacore.com, konrad.frederic@yahoo.fr,
 atar4qemu@gmail.com, jcmvbkbc@gmail.com
Subject: Re: [PATCH 1/5] hw/core/loader: capture Error from load_image_targphys
Message-ID: <aPHY0828TU5hl5Tg@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-3-vishalc@linux.ibm.com>
 <CAKmqyKOJS+rY0NpTpv76SJqZmgjoLnvQX8wiKgxgUP6k=+fpnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOJS+rY0NpTpv76SJqZmgjoLnvQX8wiKgxgUP6k=+fpnQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CGBSi45XDKWd1sAty0Z16EA1vSxMWGr9
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f1d8ec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8 a=a4e9Y00PKgMP4OML3gsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX3Ja2jSNYz1S0
 pmWn3JQwMR02sOHaNOXu1RN7pGeiEHKOcf7EjfL6SLsjci9aT7b+Ee5hft0WhUATsG3sx2NTOvj
 MoEqg42v7aYTTMEP2rDTcCOABaSqbnxqx2oPRU3psECmJeeJ6gZGot21rHP0of50ANxt1Hn7qdQ
 G+vpy40VuAio9nHYn4qjp7jIX8+Jkf4Y2mvV+g2ZTWsikCDvuPkUMKHigU+/Po5fwubz9VnFrLp
 M1Vb/3w62Wff66Hzw3ASlBerZiCZtL5HhAIKtkhJKJ4t3vz6Abws7gU2aoNDAB11k14tljYtMXj
 V/agmt6CkYbhjQombT8eG2sODolLrl4iQaBQmLWvU9t1uaUDZoYUo36Ljau4JGZgr8GM99KRYii
 a/2Ryzb9AJLoB9KC2jK+XOksHz9MSg==
X-Proofpoint-GUID: V8cx6_yy5CNvL_FtUBgUQGq0gyUvCLRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
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

Hi Alistair,



On Fri, Oct 17, 2025 at 08:58:58AM +1000, Alistair Francis wrote:
> On Fri, Oct 17, 2025 at 4:01 AM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >
> > Add Error **errp parameter to load_image_targphys(),
> > load_image_targphys_as(), and get_image_size() to enable better
> > error reporting when image loading fails.
> >
> > Pass NULL for errp in all existing call sites to maintain current
> > behavior. No functional change intended in this patch.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Alistair
> 
> > ---
> >  hw/core/loader.c         | 33 +++++++++++++++++++++++++--------
<snipped>
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 477661a025..63bb0578b1 100644
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
> >      size = lseek(fd, 0, SEEK_END);
> > +    if (size < 0) {
> > +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> > +        return -1;
> > +    }
> >      close(fd);
> >      return size;
> >  }
> > @@ -118,21 +127,29 @@ ssize_t read_targphys(const char *name,
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
> > +    ERRP_GUARD();
> >      ssize_t size;
> >
> > -    size = get_image_size(filename);
> > -    if (size < 0 || size > max_sz) {
> > +    size = get_image_size(filename, errp);
> > +    if (*errp) {
> >          return -1;
> >      }
> > +
> > +    if (size > max_sz) {
> > +        error_setg(errp, "%s exceeds maximum image size (%lu MiB)", filename, max_sz / MiB);
> > +        return -1;
> > +    }
> > +
> >      if (size > 0) {
> >          if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> >              return -1;


There was a case where load_image_targphys_as() can return -1 but errp
was not set. Following change addresses this issue.
I will incorporate this in the next version (v4).

 /* return the size or -1 if error */
 ssize_t load_image_targphys_as(const char *filename,
-                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
+                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
+                               Error **errp)
 {
+    ERRP_GUARD();
     ssize_t size;

-    size = get_image_size(filename);
-    if (size < 0 || size > max_sz) {
+    size = get_image_size(filename, errp);
+    if (*errp) {
         return -1;
     }
+
+    if (size > max_sz) {
+        error_setg(errp, "%s exceeds maximum image size (%lu MiB)",
+                   filename, max_sz / MiB);
+        return -1;
+    }
+
     if (size > 0) {
         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+            error_setg(errp, "failed to add file as ROM");
             return -1;
         }
     }

Thanks,
vishalc

