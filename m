Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBDFB5EA8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LJ5-0001t9-Qv; Mon, 16 Mar 2026 23:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2LJ3-0001sT-N4; Mon, 16 Mar 2026 23:41:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2LJ0-0003ZZ-BG; Mon, 16 Mar 2026 23:41:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GD1sxU372356; Tue, 17 Mar 2026 03:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CHHdfT
 JqsEWgrcZUZv0uQoLxBhyfmYCWHYYfFvk6FFk=; b=Ez7pfiCR2ywk3o0gtFm8Ag
 mXq2W75e5K3IjbnwVhFd+THFFtZgfaXzA3pWNCMD+8fwylcBga+LRhf++1rqEKjs
 ha99RiOMUqeBeOjJRF4mns3vzTiJusdOqvUkmUVeeRTFYKtIMwE50lQvms92+ZrD
 0o/aCMUkmE9Gp1sKd42+cLgxSHSTeNh743zvYclZhUDO7xGhqpvTah9yhDipSuQi
 3u314t3YwruDWIkBPNqLvrnWMclwEW+3SMDd3ZJnBnvf9YKsBT1HL1BFfaMjltMe
 eF2PBm7CaCpx5aJjBVvVsz4zyft9dJaLifuqcNe1DBgpz1mYtAkcooWdZ8ZuAAGA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauad05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 03:41:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H1NqCa015648;
 Tue, 17 Mar 2026 03:41:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n7etb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 03:41:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H3fAPp61014382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 03:41:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF4A358051;
 Tue, 17 Mar 2026 03:41:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1B545805C;
 Tue, 17 Mar 2026 03:41:08 +0000 (GMT)
Received: from [9.67.86.225] (unknown [9.67.86.225])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Mar 2026 03:41:08 +0000 (GMT)
Message-ID: <c062e73a-660d-4c92-9c84-937cb10d944d@linux.ibm.com>
Date: Mon, 16 Mar 2026 23:41:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v9 19/30] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-20-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260305224146.664053-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNSBTYWx0ZWRfX4ejzNTOF3yMe
 v2/Af/hYbZ+iJMnblQpOGrF3tnvCHFO3meBkdCub1jHWwiQd58zb8VZB+qknL4DreqT/YV1qXBD
 v0W5gBlaFCm3JxHmxaNaUWiXSVInixfb4OC31EuF1RS1JOC6AZO910VgdEovqt5Y4+xdyKnkQVo
 kRd4yX0H1tMIDDR7ErARBgnKne46jgieWYD2hSh9yGHNagrBCFuHn8YfOXeDvlxa9ILae2zqbaI
 hDxz8gHIz5byI8Kh7MgmNxjBKopkpNeGCX7+Hr2m8cVpXBFyD7LybVl24yyYnFKpOfEh7o9TPbU
 SObHOGecHMSd2F0DT7cfvR+znS7rDlVMkgrp0ltjJoTIyQ4H+PpVfSbC75SXUUytDcBFX7gIYg2
 O87J0WTdHmXa2gdB9GjM4AgsMA8IWRb1CthDfSIC42RGp641DQYwlaxqN9IJwVHRJ289/hXGIWW
 VeVL9HOsXm/5hrz3ISA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b8cd58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=k7Fsj5aoxv1Gb9ZhVVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tcZiqXdWDRFJjG1jIiKNc0F3Kxy-BKLn
X-Proofpoint-GUID: tcZiqXdWDRFJjG1jIiKNc0F3Kxy-BKLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/5/26 17:41, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst |  35 +++
>  pc-bios/s390-ccw/Makefile        |   3 +-
>  pc-bios/s390-ccw/bootmap.c       |  36 +++-
>  pc-bios/s390-ccw/bootmap.h       |  11 +
>  pc-bios/s390-ccw/main.c          |   6 +
>  pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>  pc-bios/s390-ccw/sclp.c          |  38 ++++
>  pc-bios/s390-ccw/sclp.h          |   6 +
>  pc-bios/s390-ccw/secure-ipl.c    | 357 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h    | 102 +++++++++
>  10 files changed, 618 insertions(+), 3 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 0a02f171b4..3a19b72085 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -18,3 +18,38 @@ Note: certificate files must have a .pem extension.
>  .. code-block:: shell
>  
>      qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +IPL Modes
> +=========
> +Multiple IPL modes are available to differentiate between the various IPL
> +configurations. These modes are mutually exclusive and enabled based on the
> +``boot-certs`` option on the QEMU command line.
> +
> +Normal Mode
> +-----------
> +
> +The absence of certificates will attempt to IPL a guest without secure IPL
> +operations. No checks are performed, and no warnings/errors are reported.
> +This is the default mode.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio ...
> +
> +Audit Mode
> +----------
> +
> +When the certificate store is populated with at least one certificate
> +and no additional secure IPL parameters are provided on the command
> +line, then secure IPL will proceed in "audit mode". All secure IPL
> +operations will be performed with signature verification errors reported
> +as non-disruptive warnings.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index a0f24c94a8..603761a857 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  .PHONY : all clean build-all distclean
>  
>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> +	  secure-ipl.o
>  
>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>  
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 9a03eab6ed..43a661325f 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -15,6 +15,7 @@
>  #include "bootmap.h"
>  #include "virtio.h"
>  #include "bswap.h"
> +#include "secure-ipl.h"
>  
>  #ifdef DEBUG
>  /* #define DEBUG_FALLBACK */
> @@ -617,7 +618,7 @@ static int ipl_eckd(void)
>   * Returns: length of the segment on success,
>   *          negative value on error.
>   */
> -static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
> +int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>  {
>      const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>      ScsiBlockPtr *bprs = (void *)sec;
> @@ -736,7 +737,19 @@ static int zipl_run(ScsiBlockPtr *pte)
>      /* Load image(s) into RAM */
>      entry = (ComponentEntry *)(&header[1]);
>  
> -    rc = zipl_run_normal(&entry, tmp_sec);
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        rc = zipl_run_secure(&entry, tmp_sec);
> +        break;
> +    case ZIPL_BOOT_MODE_NORMAL:
> +        rc = zipl_run_normal(&entry, tmp_sec);
> +        break;
> +    default:
> +        puts("Unknown boot mode");
> +        rc = -1;
> +        break;
> +    }
> +
>      if (rc) {
>          return rc;
>      }
> @@ -1103,17 +1116,33 @@ static int zipl_load_vscsi(void)
>   * IPL starts here
>   */
>  
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags)
> +{
> +    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
> +    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
> +
> +    if (!sipl_set && iplir_set) {
> +        return ZIPL_BOOT_MODE_SECURE_AUDIT;
> +    }
> +
> +    return ZIPL_BOOT_MODE_NORMAL;
> +}
> +
>  void zipl_load(void)
>  {
>      VDev *vdev = virtio_get_device();
>  
>      if (vdev->is_cdrom) {
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                   "Secure boot from ISO image is not supported!");
>          ipl_iso_el_torito();
>          puts("Failed to IPL this ISO image!");
>          return;
>      }
>  
>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                    "Virtio net boot device does not support secure boot!");
>          netmain();
>          puts("Failed to IPL from this network!");
>          return;
> @@ -1124,6 +1153,9 @@ void zipl_load(void)
>          return;
>      }
>  
> +    IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                "Secure boot with the ECKD scheme is not supported!");
> +
>      switch (virtio_get_device_type()) {
>      case VIRTIO_ID_BLOCK:
>          zipl_load_vblk();
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..dc2783faa2 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>      BootMapPointer entry[];
>  } __attribute__ ((packed)) BootMapTable;
>  
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} SignatureInformation;
> +
>  typedef union ComponentEntryData {
>      uint64_t load_psw;
>      uint64_t load_addr;
> +    SignatureInformation sig_info;
>  } ComponentEntryData;
>  
>  typedef struct ComponentEntry {
> @@ -113,6 +122,8 @@ typedef struct ScsiMbr {
>      ScsiBlockPtr pt;   /* block pointer to program table */
>  } __attribute__ ((packed)) ScsiMbr;
>  
> +int zipl_load_segment(ComponentEntry *entry, uint64_t address);
> +
>  #define ZIPL_MAGIC              "zIPL"
>  #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>  #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 819f053009..106cdf9dec 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -28,6 +28,7 @@ IplParameterBlock *iplb;
>  bool have_iplb;
>  static uint16_t cutype;
>  LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> +ZiplBootMode boot_mode;
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
> @@ -275,6 +276,9 @@ static void ipl_boot_device(void)
>      switch (cutype) {
>      case CU_TYPE_DASD_3990:
>      case CU_TYPE_DASD_2107:
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                    "Passthrough (vfio) CCW device does not support secure boot!");
> +
>          dasd_ipl(blk_schid, cutype);
>          break;
>      case CU_TYPE_VIRTIO:
> @@ -324,6 +328,8 @@ void main(void)
>          probe_boot_device();
>      }
>  
> +    boot_mode = get_boot_mode(iplb->hdr_flags);
> +
>      while (have_iplb) {
>          boot_setup();
>          if (have_iplb && find_boot_device()) {
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b1dc35cded..a0d568696a 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -40,6 +40,22 @@ typedef unsigned long long u64;
>                              ((b) == 0 ? (a) : (MIN(a, b))))
>  #endif
>  
> +/*
> + * Round number down to multiple. Requires that d be a power of 2.
> + * Works even if d is a smaller type than n.
> + */
> +#ifndef ROUND_DOWN
> +#define ROUND_DOWN(n, d) ((n) & -(0 ? (n) : (d)))
> +#endif
> +
> +/*
> + * Round number up to multiple. Requires that d be a power of 2.
> + * Works even if d is a smaller type than n.
> + */
> +#ifndef ROUND_UP
> +#define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
> +#endif
> +
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>  
>  #include "cio.h"
> @@ -64,6 +80,8 @@ void sclp_print(const char *string);
>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_sipl_on(void);
>  int sclp_read(char *str, size_t count);
>  
>  /* virtio.c */
> @@ -76,6 +94,15 @@ int virtio_read(unsigned long sector, void *load_addr);
>  /* bootmap.c */
>  void zipl_load(void);
>  
> +typedef enum ZiplBootMode {
> +    ZIPL_BOOT_MODE_NORMAL = 0,
> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
> +} ZiplBootMode;
> +
> +extern ZiplBootMode boot_mode;
> +
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
> +
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
>  int jump_to_IPL_code(uint64_t address);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..e3b6a1f07e 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,44 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      }
>  }
>  
> +bool sclp_is_diag320_on(void)
> +{
> +    ReadInfo *sccb = (void *)_sccb;
> +    uint8_t fac134 = 0;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        fac134 = sccb->fac134;
> +    }
> +
> +    return fac134 & SCCB_FAC134_DIAG320_BIT;
> +}
> +
> +/*
> + * Get fac_ipl (byte 136 and byte 137 of the SCLP Read Info block)
> + * for IPL device facilities.
> + */
> +static void sclp_get_fac_ipl(uint16_t *fac_ipl)
> +{
> +

nit: remove newline at top of function body

> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        *fac_ipl = sccb->fac_ipl;
> +    }
> +}
> +
> +bool sclp_is_sipl_on(void)
> +{
> +    uint16_t fac_ipl = 0;
> +
> +    sclp_get_fac_ipl(&fac_ipl);
> +    return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
> +}
> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..cf147f4634 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>  } __attribute__((packed)) SCCBHeader;
>  
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_FAC_IPL_SIPL_BIT 0x4000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>      uint8_t rnsize;
>      uint8_t reserved[13];
>      uint8_t loadparm[LOADPARM_LEN];
> +    uint8_t reserved1[102];
> +    uint8_t fac134;
> +    uint8_t reserved2;
> +    uint16_t fac_ipl;
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct SCCB {
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> new file mode 100644
> index 0000000000..8d281c1cea
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,357 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
> + * signature verification, and certificate handling).
> + *
> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "bootmap.h"
> +#include "s390-ccw.h"
> +#include "secure-ipl.h"
> +
> +static uint8_t vcb_data[MAX_SECTOR_SIZE * 4] __attribute__((__aligned__(PAGE_SIZE)));
> +static uint8_t vcssb_data[VCSSB_MIN_LEN] __attribute__((__aligned__(8)));
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
> +{
> +    VCStorageSizeBlock *vcssb;
> +
> +    vcssb = (VCStorageSizeBlock *)vcssb_data;
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb->length >= VCSSB_MIN_LEN) {
> +        return vcssb;
> +    }
> +
> +    if (!is_cert_store_facility_supported()) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return NULL;
> +    }
> +
> +    vcssb->length = VCSSB_MIN_LEN;
> +    if (diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
> +        vcssb->length = 0;
> +        return NULL;
> +    }
> +
> +    return vcssb;
> +}
> +
> +static uint32_t get_total_certs_length(void)
> +{
> +    VCStorageSizeBlock *vcssb;
> +
> +    vcssb = zipl_secure_get_vcssb();
> +    if (vcssb == NULL) {
> +        return 0;
> +    }
> +
> +    return vcssb->total_vcb_len - VCB_HEADER_LEN - vcssb->total_vc_ct * VCE_HEADER_LEN;
> +}
> +
> +static uint32_t request_certificate(uint8_t *cert_addr, uint8_t index)
> +{
> +    VCStorageSizeBlock *vcssb;
> +    VCBlock *vcb;
> +    VCEntry *vce;
> +    uint32_t cert_len = 0;
> +
> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
> +    vcssb = zipl_secure_get_vcssb();
> +    if (vcssb == NULL) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     */
> +    vcb = (VCBlock *)vcb_data;
> +    vcb->in_len = ROUND_UP(vcssb->max_single_vcb_len, PAGE_SIZE);
> +    vcb->first_vc_index = index;
> +    vcb->last_vc_index = index;
> +
> +    if (diag320(vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
> +        goto out;
> +    }
> +
> +    if (vcb->out_len == VCB_HEADER_LEN) {
> +        puts("No certificate entry");
> +        goto out;
> +    }
> +
> +    if (vcb->remain_ct != 0) {
> +        puts("Not enough memory to store all requested certificates");
> +        goto out;
> +    }
> +
> +    vce = (VCEntry *)vcb->vce_buf;
> +    if (!(vce->flags & DIAG_320_VCE_FLAGS_VALID)) {
> +        puts("Invalid certificate");
> +        goto out;
> +    }
> +
> +    cert_len = vce->cert_len;
> +    memcpy(cert_addr, (uint8_t *)vce + vce->cert_offset, vce->cert_len);
> +    memcpy(vcb_data, 0, sizeof(vcb_data));
> +
> +out:

Probably makes more sense to zero the VCB here, under the `out` label.

> +    return cert_len;
> +}
> +
> +static void cert_list_add(IplSignatureCertificateList *cert_list, int cert_index,
> +                          uint8_t *cert_addr, uint64_t cert_len)
> +{
> +    if (cert_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring cert entry #%d because only %d entries are supported\n",
> +                cert_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }
> +
> +    cert_list->cert_entries[cert_index].addr = (uint64_t)cert_addr;
> +    cert_list->cert_entries[cert_index].len = cert_len;
> +    cert_list->ipl_info_header.len += sizeof(cert_list->cert_entries[cert_index]);
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comp_list, int comp_index,
> +                          int cert_index, uint64_t comp_addr,
> +                          uint64_t comp_len, uint8_t flags)
> +{
> +    if (comp_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring comp entry #%d because only %d entries are supported\n",
> +                comp_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }
> +
> +    comp_list->device_entries[comp_index].addr = comp_addr;
> +    comp_list->device_entries[comp_index].len = comp_len;
> +    comp_list->device_entries[comp_index].flags = flags;
> +    comp_list->device_entries[comp_index].cert_index = cert_index;
> +    comp_list->ipl_info_header.len += sizeof(comp_list->device_entries[comp_index]);
> +}
> +
> +static void update_iirb(IplDeviceComponentList *comp_list,
> +                        IplSignatureCertificateList *cert_list)
> +{
> +    IplInfoReportBlock *iirb;
> +    IplDeviceComponentList *iirb_comps;
> +    IplSignatureCertificateList *iirb_certs;
> +    uint32_t iirb_hdr_len;
> +    uint32_t comps_len;
> +    uint32_t certs_len;
> +
> +    if (iplb->len % 8 != 0) {
> +        panic("IPL parameter block length field value is not multiple of 8 bytes");
> +    }
> +
> +    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
> +    comps_len = comp_list->ipl_info_header.len;
> +    certs_len = cert_list->ipl_info_header.len;
> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
> +        panic("Not enough space to hold all components and certificates in IIRB");
> +    }
> +
> +    /* IIRB immediately follows IPLB */
> +    iirb = &ipl_data.iirb;
> +    iirb->hdr.len = iirb_hdr_len;
> +
> +    /* Copy IPL device component list after IIRB Header */
> +    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
> +    memcpy(iirb_comps, comp_list, comps_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += comps_len;
> +
> +    /* Copy IPL sig cert list after IPL device component list */
> +    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
> +                                                  iirb_comps->ipl_info_header.len);
> +    memcpy(iirb_certs, cert_list, certs_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += certs_len;
> +}
> +
> +static bool secure_ipl_supported(void)
> +{
> +    if (!sclp_is_sipl_on()) {
> +        puts("Secure IPL Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_signature_verif_supported()) {
> +        puts("Secure IPL extensions are not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_cert_store_facility_supported()) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void init_lists(IplDeviceComponentList *comp_list,
> +                       IplSignatureCertificateList *cert_list)
> +{
> +    comp_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_COMPONENTS;
> +    comp_list->ipl_info_header.len = sizeof(comp_list->ipl_info_header);
> +
> +    cert_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_CERTIFICATES;
> +    cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
> +}
> +
> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
> +{
> +    if (zipl_load_segment(entry, sig_sec) < 0) {
> +        return -1;
> +    }
> +
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return -1;
> +    }
> +
> +    return entry->compdat.sig_info.sig_len;
> +}
> +
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> +{
> +    IplDeviceComponentList comp_list = { 0 };
> +    IplSignatureCertificateList cert_list = { 0 };
> +    ComponentEntry *entry = *entry_ptr;
> +    uint8_t *cert_addr = NULL;
> +    uint64_t *sig = NULL;
> +    int cert_entry_idx = 0;
> +    int comp_entry_idx = 0;
> +    uint64_t comp_addr;
> +    int comp_len;
> +    uint32_t sig_len = 0;
> +    uint64_t cert_len = -1;
> +    uint8_t cert_table_idx = -1;
> +    int cert_index;
> +    uint8_t flags;
> +    bool verified;
> +    /*
> +     * Keep track of which certificate store indices correspond to the
> +     * certificate data entries within the IplSignatureCertificateList to
> +     * prevent allocating space for the same certificate multiple times.
> +     *
> +     * The array index corresponds to the certificate's cert-store index.
> +     *
> +     * The array value corresponds to the certificate's entry within the
> +     * IplSignatureCertificateList (with a value of -1 denoting no entry
> +     * exists for the certificate).
> +     */
> +    int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
> +    int signed_count = 0;
> +
> +    if (!secure_ipl_supported()) {
> +        panic("Unable to boot in secure/audit mode");
> +    }
> +
> +    init_lists(&comp_list, &cert_list);
> +    cert_addr = malloc(get_total_certs_length());

I'm concerned about the cert_addr being malloc'd here...

> +    sig = malloc(MAX_SECTOR_SIZE);
> +
> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        switch (entry->component_type) {
> +        case ZIPL_COMP_ENTRY_SIGNATURE:
> +            if (sig_len) {
> +                goto out;
> +            }
> +
> +            sig_len = zipl_load_signature(entry, (uint64_t)sig);
> +            if (sig_len < 0) {
> +                goto out;
> +            }
> +            break;
> +        case ZIPL_COMP_ENTRY_LOAD:
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry, comp_addr);
> +            if (comp_len < 0) {
> +                goto out;
> +            }
> +
> +            if (!sig_len) {
> +                break;
> +            }
> +
> +            verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
> +                                        &cert_len, &cert_table_idx);
> +
> +            /* default cert index and flags for unverified component */
> +            cert_index = -1;
> +            flags = S390_IPL_DEV_COMP_FLAG_SC;
> +
> +            if (verified) {
> +                if (cert_list_table[cert_table_idx] == -1) {
> +                    if (!request_certificate(cert_addr, cert_table_idx)) {
> +                        puts("Could not get certificate");
> +                        goto out;
> +                    }
> +
> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
> +                    cert_list_add(&cert_list, cert_entry_idx, cert_addr, cert_len);

...then the malloc'd cert is added to the cert list (and this list later
gets appended to the IIRB).

Once IPL starts, the data at this address will eventually be
lost/overwritten. The certificate address needs to point to either:
 - somewhere on the disk
 - some dedicated memory space (likely designated by QEMU)

Though that begs the question: who/what makes use of the IIRB?  It seems
this information gets lost?

> +
> +                    /* increment for the next certificate */
> +                    cert_entry_idx++;
> +                    cert_addr += cert_len;
> +                }
> +
> +                puts("Verified component");
> +                cert_index = cert_list_table[cert_table_idx];
> +                flags |= S390_IPL_DEV_COMP_FLAG_CSV;
> +            }
> +
> +            comp_list_add(&comp_list, comp_entry_idx, cert_index,
> +                          comp_addr, comp_len, flags);
> +
> +            if (!verified) {
> +                zipl_secure_handle("Could not verify component");
> +            }
> +
> +            comp_entry_idx++;
> +            signed_count += 1;
> +            /* After a signature is used another new one can be accepted */
> +            sig_len = 0;
> +            break;
> +        default:
> +            puts("Unknown component entry type");
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    if (signed_count == 0) {
> +        zipl_secure_handle("Secure boot is on, but components are not signed");
> +    }
> +
> +    update_iirb(&comp_list, &cert_list);
> +
> +    *entry_ptr = entry;
> +    free(sig);
> +
> +    return 0;
> +out:
> +    free(cert_addr);
> +    free(sig);
> +
> +    return -1;
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..eb5ba0ed47
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,102 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
> +
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
> +
> +static inline void zipl_secure_handle(const char *message)
> +{
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        IPL_check(false, message);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static inline uint64_t diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x320\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_cert_store_facility_supported(void)
> +{
> +    uint32_t d320_ism;
> +
> +    if (!sclp_is_diag320_on()) {
> +        return false;
> +    }
> +
> +    diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM);
> +    return d320_ism & (DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x508\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_signature_verif_supported(void)
> +{
> +    uint64_t d508_subcodes;
> +
> +    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(uint64_t comp_len, uint64_t comp_addr,
> +                                    uint64_t sig_len, uint64_t sig_addr,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SigVerifBlock svb;
> +
> +    svb.length = sizeof(Diag508SigVerifBlock);
> +    svb.version = 0;
> +    svb.comp_len = comp_len;
> +    svb.comp_addr = comp_addr;
> +    svb.sig_len = sig_len;
> +    svb.sig_addr = sig_addr;
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
> +        *cert_len = svb.cert_len;
> +        /*
> +         * DIAG 508 utilizes an index origin of 0 when indexing the cert store.
> +         * The cert_idx will be used for DIAG 320 data structures, which expects
> +         * an index origin of 1. Account for the offset here so it's easier to
> +         * manage later.
> +         */
> +        *cert_idx = svb.cert_store_index + 1;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
-- 
Regards,
  Collin

