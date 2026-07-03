Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848F2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcFm-0002lw-57; Fri, 03 Jul 2026 07:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfcFh-0002jD-UD; Fri, 03 Jul 2026 07:40:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfcFe-0007ZY-TY; Fri, 03 Jul 2026 07:40:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636ISNr1761111; Fri, 3 Jul 2026 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZCeFFR
 OB4RvDRWfoANb0faW85dPPw+jpufW8xdFAzV4=; b=mOpsLan2/X0oZN+2pGPzRd
 c/+99iMqlPDE9QyU7WHi5aeWWycnli4PDfz+S5vnn5d1PqThEr8EFFhafKFAu7O4
 b4YUINpcsYqU57jRfZTToFRHV1m5YCk0oyJIo5J48k9epHkXFrgyjnpDhzKawEny
 ZTDQY8o/kX1IhS2qojRsLuWnqumkuVlfIL1+mL8/PBNqaHrRiOiHvdWJgQMBl3S2
 GphVytScdUNpWq8M+MGpvrN1kqGLQeB7TD6soVMU80WH99Li9l6CBIAMRMRfjVDI
 q5n7uy2eamV3TV3g4WoiMwz43XP+PI8WNYXo3KM5prMcZKdIVKtmqpgivhXYIjSQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk6hjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 11:40:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663BYhr4009001;
 Fri, 3 Jul 2026 11:40:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqrtys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 11:40:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663Be3Xb22741558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 11:40:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 812E358059;
 Fri,  3 Jul 2026 11:40:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 746F55805B;
 Fri,  3 Jul 2026 11:40:01 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 11:40:01 +0000 (GMT)
Message-ID: <26e6d55b2ea246f2c2602ff911f459c7df8b57b0.camel@linux.ibm.com>
Subject: Re: [PATCH v13 23/33] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Fri, 03 Jul 2026 07:40:00 -0400
In-Reply-To: <20260703022933.1805010-24-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-24-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX+Fm0ukY0HExj
 NwJwws6gTV/HIRC79F58nsV9IkEkGx83u3fF9hg2m5eXQOdeEnsyEYbFraNWfVVP8hrr21sg4Kn
 D+52JMTl3m006+mtL2fL7GVqUFC63BY/ZUYHoNy8ySPZnF/gYewwLG9stucvWCGBJHVyOAxRJ4J
 /GfPYsoqdhcn6Mb1V0dqUXfSJGcjIXzXgoxCMWiWvN/A5InRqCNC2jWbldf/sCiQamtDDDG4Uv9
 BkqCZ8faJdk+OV4uKRkG8hqCPlqSSWHU8npbj4CUFrq80MSmGOwxuSkVhSSdK7uUSNtdni1PBUK
 5oQDFjBMoyoHRIuMJcxVPiE8v4kFdQ5dKMw0Y1Pi5xODbbUwBZvtBrrZBxm6ORh4A4J5sDvLaHO
 ucYQLH2abQBqacbJO8FBXbEjQfVNebBEMak51Yn+cE6jCrMeW1scljOQl6zPNmlEjIPEIeBFQLF
 6eF3SkDxIqD+Iaq8IEQ==
X-Proofpoint-GUID: h-DiUNnQqCSxTX8GYLxTMtQD9s6uF7TQ
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a479f95 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=SE0i1jBJbef-UEk91_cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX/vVH/h3BenbA
 n8mGTMtyO2C3q79yoxx5os3inYu6GXI9/qQ/whKxapWMY5RWaIaRh4v8MBFBK6JM2ekRQpSOTSQ
 Odgng8XOayphe4lLqBKAouzwj0avXxE=
X-Proofpoint-ORIG-GUID: h-DiUNnQqCSxTX8GYLxTMtQD9s6uF7TQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2026-07-02 at 22:29 -0400, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
>=20
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
>=20
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst |  15 ++
>  hw/s390x/ipl.c                   |   9 +
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/bootmap.c       |  27 +++
>  pc-bios/s390-ccw/bootmap.h       |   9 +
>  pc-bios/s390-ccw/jump2ipl.c      |   7 +
>  pc-bios/s390-ccw/main.c          |  18 +-
>  pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>  pc-bios/s390-ccw/sclp.c          |  27 +++
>  pc-bios/s390-ccw/sclp.h          |   6 +
>  pc-bios/s390-ccw/secure-ipl.c    | 363 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h    | 115 ++++++++++
>  12 files changed, 616 insertions(+), 2 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>=20

...snip...

> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index cd3d0776b0..7484429c9a 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -20,6 +20,7 @@
>  #include "dasd-ipl.h"
>  #include "clp.h"
>  #include "virtio-pci.h"
> +#include "secure-ipl.h"
> =20
>  static SubChannelId blk_schid =3D { .one =3D 1 };
>  static char loadparm_str[LOADPARM_LEN + 1];
> @@ -383,6 +384,8 @@ static void probe_boot_device(void)
> =20
>  void main(void)
>  {
> +    int vcssb_len;
> +
>      iplb =3D &ipl_blocks.iplb;
> =20
>      copy_qipl();
> @@ -394,7 +397,20 @@ void main(void)
>          probe_boot_device();
>      }
> =20
> -    boot_mode =3D ZIPL_BOOT_MODE_NORMAL;
> +    boot_mode =3D get_boot_mode(iplb->hdr_flags);
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        if (!secure_ipl_supported()) {
> +            panic("Unable to boot in audit mode");
> +        }
> +
> +        vcssb_len =3D zipl_secure_get_vcssb();
> +        if (vcssb_len =3D=3D 0) {
> +            panic("Failed to query certificate storage information!");
> +        }

break? fallthrough?

> +    default:
> +        break;
> +    }
> =20
>      while (have_iplb) {
>          boot_setup();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 5420443ad2..ca2737054d 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -40,6 +40,22 @@ typedef unsigned long long u64;
>                              ((b) =3D=3D 0 ? (a) : (MIN(a, b))))
>  #endif
> =20
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
> =20
>  #include "cio.h"
> @@ -64,6 +80,8 @@ void sclp_print(const char *string);
>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
>  int sclp_read(char *str, size_t count);
> =20
>  /* bootmap.c */
> @@ -71,9 +89,11 @@ void zipl_load(void);
> =20
>  typedef enum ZiplBootMode {
>      ZIPL_BOOT_MODE_NORMAL =3D 0,
> +    ZIPL_BOOT_MODE_SECURE_AUDIT =3D 1,
>  } ZiplBootMode;
> =20
>  extern ZiplBootMode boot_mode;
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
> =20
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..48bdfedf1f 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      }
>  }
> =20
> +bool sclp_is_diag320_on(void)
> +{
> +    ReadInfo *sccb =3D (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length =3D SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        return sccb->fac134 & SCCB_FAC134_DIAG320_BIT;
> +    }
> +
> +    return 0;
> +}
> +
> +/* check if specified IPL facility flag is enabled */
> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag)
> +{
> +    ReadInfo *sccb =3D (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length =3D SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        return sccb->fac_ipl & fac_ipl_flag;
> +    }
> +
> +    return 0;
> +}
> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb =3D (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..a8a41cd004 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>  } __attribute__((packed)) SCCBHeader;
> =20
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_FAC_IPL_SIPL_BIT   0x4000
> =20
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
> =20
>  typedef struct SCCB {
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.=
c
> new file mode 100644
> index 0000000000..2cfa16fb68
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,363 @@
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
> +#include "s390-ccw.h"
> +#include "sclp.h"
> +#include "secure-ipl.h"
> +
> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
> +
> +#define for_each_rb_entry(entry, list) \
> +    for (entry =3D (void *)(list) + sizeof((list)->ipl_info_header); \
> +         (void *)(entry) + sizeof(*(entry)) <=3D \
> +         (void *)(list) + (list)->ipl_info_header.len; \
> +         entry++)
> +
> +int zipl_secure_get_vcssb(void)
> +{
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb.length =3D=3D VCSSB_LEN_VALID) {
> +        goto out;
> +    }
> +
> +    vcssb.length =3D VCSSB_LEN_VALID;
> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) !=3D DIAG_320_RC_OK) =
{
> +        vcssb.length =3D 0;
> +    }
> +
> +out:
> +    return vcssb.length;
> +}
> +
> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
> +{
> +    VCEntryHeader *vce_hdr;
> +    struct vcb {
> +        VCBlockHeader vcb_hdr;
> +        struct vce {
> +            VCEntryHeader vce_hdr;
> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
> +        } vce;
> +    } __attribute__((__aligned__(PAGE_SIZE))) vcb =3D { 0 };
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     *
> +     * First and last index must be equal because only one
> +     * VCE per VCB is currently supported
> +     */
> +    vcb.vcb_hdr.in_len =3D ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE)=
;

Don't you need to convert max_single_vcb_len from be to cpu?

> +    vcb.vcb_hdr.first_vc_index =3D index;
> +    vcb.vcb_hdr.last_vc_index =3D index;
> +
> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) !=3D DIAG_320_RC_OK) {
> +        puts("Could not get certificate");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.out_len =3D=3D sizeof(VCBlockHeader)) {
> +        puts("No certificate entry");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.remain_ct !=3D 0) {
> +        panic("Not enough memory to store requested certificate");
> +    }
> +
> +    vce_hdr =3D &vcb.vce.vce_hdr;
> +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
> +        puts("Invalid certificate");
> +        return 0;
> +    }
> +
> +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr=
->cert_len);
> +
> +    return vce_hdr->cert_len;
> +}
> +
> +static int cert_list_add(IplSignatureCertificateList *cert_list,
> +                         IplSignatureCertificateEntry cert_entry)
> +{
> +    int cert_entry_idx;
> +
> +    cert_entry_idx =3D (cert_list->ipl_info_header.len - sizeof(IplInfoB=
lockHeader)) /
> +                     sizeof(IplSignatureCertificateEntry);
> +
> +    cert_list->cert_entries[cert_entry_idx] =3D cert_entry;
> +    cert_list->ipl_info_header.len +=3D sizeof(IplSignatureCertificateEn=
try);
> +
> +    return cert_entry_idx;
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comp_list,
> +                          IplDeviceComponentEntry comp_entry)
> +{
> +    int comp_entry_idx;
> +
> +    comp_entry_idx =3D (comp_list->ipl_info_header.len - sizeof(IplInfoB=
lockHeader)) /
> +                     sizeof(IplDeviceComponentEntry);
> +    if (comp_entry_idx > MAX_COMP_ENTRIES - 1) {
> +        printf("Warning: only %d component entries are supported\n",
> +                MAX_COMP_ENTRIES);
> +        panic("The device component list has reached its maximum capacit=
y");
> +    }
> +
> +    comp_list->device_entries[comp_entry_idx] =3D comp_entry;
> +    comp_list->ipl_info_header.len +=3D sizeof(IplDeviceComponentEntry);
> +}
> +
> +void update_iirb(IplDeviceComponentList *comp_list,
> +                 IplSignatureCertificateList *cert_list)
> +{
> +    IplInfoReportBlock *iirb;
> +    IplDeviceComponentList *iirb_comps;
> +    IplSignatureCertificateList *iirb_certs;
> +    uint32_t iirb_hdr_len;
> +    uint32_t comps_len;
> +    uint32_t certs_len;
> +
> +    if (iplb->len % 8 !=3D 0) {
> +        panic("IPL parameter block length field value is not multiple of=
 8 bytes");
> +    }
> +
> +    iirb_hdr_len =3D sizeof(IplInfoReportBlockHeader);
> +    comps_len =3D comp_list->ipl_info_header.len;
> +    certs_len =3D cert_list->ipl_info_header.len;
> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlo=
ck)) {
> +        panic("Not enough space to hold all components and certificates =
in IIRB");
> +    }
> +
> +    /* IIRB immediately follows IPLB */
> +    iirb =3D &ipl_blocks.iirb;
> +    iirb->hdr.len =3D iirb_hdr_len;
> +
> +    /* Copy IPL device component list after IIRB Header */
> +    iirb_comps =3D (IplDeviceComponentList *) iirb->info_blks;
> +    memcpy(iirb_comps, comp_list, comps_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len +=3D comps_len;
> +
> +    /* Copy IPL sig cert list after IPL device component list */
> +    iirb_certs =3D (IplSignatureCertificateList *) (iirb->info_blks +
> +                                                  iirb_comps->ipl_info_h=
eader.len);
> +    memcpy(iirb_certs, cert_list, certs_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len +=3D certs_len;
> +}
> +
> +bool secure_ipl_supported(void)
> +{
> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SIPL_BIT)) {
> +        puts("Secure IPL Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_signature_verif_supported()) {
> +        puts("Secure IPL extensions are not supported by the hypervisor!=
");
> +        return false;
> +    }
> +
> +    if (!is_cert_store_facility_supported()) {
> +        puts("Certificate Store Facility is not supported by the hypervi=
sor!");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void init_lists(IplDeviceComponentList *comp_list,
> +                       IplSignatureCertificateList *cert_list)
> +{
> +    comp_list->ipl_info_header.type =3D IPL_INFO_BLOCK_TYPE_COMPONENTS;
> +    comp_list->ipl_info_header.len =3D sizeof(IplInfoBlockHeader);
> +
> +    cert_list->ipl_info_header.type =3D IPL_INFO_BLOCK_TYPE_CERTIFICATES=
;
> +    cert_list->ipl_info_header.len =3D sizeof(IplInfoBlockHeader);
> +}
> +
> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
> +{
> +    if (entry->compdat.sig_info.format !=3D DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return -1;
> +    }
> +
> +    if (zipl_load_segment(entry->data.blockno, sig) < 0) {
> +        return -1;
> +    }
> +
> +    return entry->compdat.sig_info.sig_len;
> +}
> +
> +void update_cert_list(IplSignatureCertificateList *cert_list)
> +{
> +    IplSignatureCertificateEntry *cert_entry;
> +    uint8_t *cert_buf;
> +
> +    /* Recover the original base address of ipl_data for cert storage */
> +    cert_buf =3D (uint8_t *)qipl.ipl_data - qipl.index * sizeof(IplParam=
eterBlock);
> +
> +    for_each_rb_entry(cert_entry, cert_list) {
> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
> +        cert_entry->addr =3D (uint64_t)cert_buf;
> +        cert_buf +=3D cert_entry->len;
> +    }
> +}
> +
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
> +                    IplDeviceComponentList *comp_list,
> +                    IplSignatureCertificateList *cert_list,
> +                    uint8_t **tmp_cert_buf)
> +{
> +    /*
> +     * Keep track of which certificate store indices correspond to the
> +     * certificate data entries within the IplSignatureCertificateList t=
o
> +     * prevent allocating space for the same certificate multiple times.
> +     *
> +     * The array index corresponds to the certificate's cert-store index=
.
> +     *
> +     * The array value corresponds to the certificate's entry within the
> +     * IplSignatureCertificateList (with a value of -1 denoting no entry
> +     * exists for the certificate).
> +     */
> +    int cert_list_table[vcssb.total_vc_ct + 1];
> +    IplSignatureCertificateEntry sig_entry =3D { 0 };
> +    IplSignatureCertificateEntry cert_entry;
> +    IplDeviceComponentEntry comp_entry;
> +    ComponentEntry *entry =3D *entry_ptr;
> +    int rc =3D -1;
> +    int sig_len =3D 0;
> +    int comp_len;
> +    int cert_entry_idx;
> +    uint64_t comp_addr;
> +    uint8_t cert_table_idx;
> +    uint8_t *tmp_buf;
> +    bool verified;
> +    bool signed_found =3D false;
> +
> +    if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > CERT_BUF_SIZE) {
> +        panic("Not enough memory to store certificates");
> +    }
> +    *tmp_cert_buf =3D malloc(CERT_BUF_SIZE);
> +    tmp_buf =3D *tmp_cert_buf;
> +
> +    init_lists(comp_list, cert_list);
> +    sig_entry.addr =3D (uint64_t)malloc(MAX_SECTOR_SIZE);
> +    memset(cert_list_table, -1, sizeof(cert_list_table));
> +
> +    while (entry->component_type !=3D ZIPL_COMP_ENTRY_EXEC) {
> +        switch (entry->component_type) {
> +        case ZIPL_COMP_ENTRY_SIGNATURE:
> +            if (sig_entry.len) {
> +                goto error;
> +            }
> +
> +            sig_len =3D zipl_load_signature(entry, sig_entry.addr);
> +            if (sig_len < 0) {
> +                goto error;
> +            }
> +
> +            sig_entry.len =3D sig_len;
> +            break;
> +        case ZIPL_COMP_ENTRY_LOAD:
> +            comp_addr =3D entry->compdat.load_addr;
> +            comp_len =3D zipl_load_segment(entry->data.blockno, comp_add=
r);
> +            if (comp_len < 0) {
> +                goto error;
> +            }
> +
> +            comp_entry =3D (IplDeviceComponentEntry){ 0 };
> +            comp_entry.addr =3D comp_addr;
> +            comp_entry.len =3D (uint64_t)comp_len;
> +
> +            /* no signature present (unsigned component) */
> +            if (!sig_entry.len) {
> +                comp_list_add(comp_list, comp_entry);
> +                break;
> +            }
> +
> +            /*
> +             * Initialize with SC flag (signed component)
> +             * CSV flag set upon successful verification
> +             */
> +            comp_entry.flags =3D S390_IPL_DEV_COMP_FLAG_SC;
> +            signed_found =3D true;
> +
> +            cert_entry =3D (IplSignatureCertificateEntry) { 0 };
> +            verified =3D verify_signature(comp_entry, sig_entry,
> +                                        &cert_entry.len, &cert_table_idx=
);
> +
> +            if (verified) {
> +                if (cert_list_table[cert_table_idx] =3D=3D -1) {
> +                    if (!request_certificate(tmp_buf, cert_table_idx)) {
> +                        puts("Could not get certificate");
> +                        goto error;
> +                    }
> +
> +                    cert_entry.addr =3D (uint64_t)tmp_buf;
> +                    cert_entry_idx =3D cert_list_add(cert_list, cert_ent=
ry);
> +                    /* map cert-store index to cert-list entry index */
> +                    cert_list_table[cert_table_idx] =3D cert_entry_idx;
> +                    /* increment for the next certificate */
> +                    tmp_buf +=3D cert_entry.len;
> +                }
> +
> +                comp_entry.cert_index =3D cert_list_table[cert_table_idx=
];
> +                comp_entry.flags |=3D S390_IPL_DEV_COMP_FLAG_CSV;
> +                puts("Verified component");
> +            } else {
> +                zipl_secure_error("Could not verify component");
> +            }
> +
> +            comp_list_add(comp_list, comp_entry);
> +
> +            /* After a signature is used another new one can be accepted=
 */
> +            sig_entry.len =3D 0;
> +            break;
> +        default:
> +            puts("Unknown component entry type");
> +            goto error;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            rc =3D -EINVAL;
> +            goto error;
> +        }
> +    }
> +
> +    if (!signed_found) {
> +        zipl_secure_error("Secure boot is on, but components are not sig=
ned");
> +    }
> +
> +    *entry_ptr =3D entry;
> +    free((void *)sig_entry.addr);
> +
> +    return 0;
> +error:
> +    free(*tmp_cert_buf);
> +    *tmp_cert_buf =3D NULL;
> +    free((void *)sig_entry.addr);
> +
> +    return rc;
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.=
h
> new file mode 100644
> index 0000000000..d4a4553215
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,115 @@
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
> +#include "bootmap.h"
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +#define MAX_SIGNED_COMP     3
> +
> +int zipl_secure_get_vcssb(void);
> +bool secure_ipl_supported(void);
> +void update_iirb(IplDeviceComponentList *comp_list,
> +                 IplSignatureCertificateList *cert_list);
> +void update_cert_list(IplSignatureCertificateList *cert_list);
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
> +                    IplDeviceComponentList *comp_list,
> +                    IplSignatureCertificateList *cert_list,
> +                    uint8_t **tmp_cert_buf);
> +
> +static inline void zipl_secure_error(const char *message)
> +{
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        printf("AUDIT MODE WARNING: %s\n", message);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static inline uint64_t _diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") =3D (unsigned long)data;
> +    register unsigned long rc asm("1") =3D 0;
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
> +    if (_diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM) !=3D DIAG_320_RC_OK=
) {
> +        return false;
> +    }
> +
> +    return d320_ism & (DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") =3D (unsigned long)data;
> +    register unsigned long rc asm("1") =3D 0;
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
> +    d508_subcodes =3D _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
> +                                    IplSignatureCertificateEntry sig_ent=
ry,
> +                                    uint64_t *cert_len, uint8_t *cert_id=
x)
> +{
> +    Diag508SigVerifBlock svb;
> +
> +    svb.length =3D sizeof(Diag508SigVerifBlock);
> +    svb.version =3D 0;
> +    svb.comp_len =3D comp_entry.len;
> +    svb.comp_addr =3D comp_entry.addr;
> +    svb.sig_len =3D sig_entry.len;
> +    svb.sig_addr =3D sig_entry.addr;
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) =3D=3D DIAG_508_RC_OK) {
> +        *cert_len =3D svb.cert_len;
> +        /*
> +         * DIAG 508 utilizes an index origin of 0 when indexing the cert=
 store.
> +         * The cert_idx will be used for DIAG 320 data structures, which=
 expects
> +         * an index origin of 1. Account for the offset here so it's eas=
ier to
> +         * manage later.
> +         */
> +        *cert_idx =3D svb.cert_store_index + 1;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */

