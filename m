Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C82CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 20:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU9Bq-0006DX-Nb; Mon, 01 Jun 2026 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wU9Bn-0006D2-Jr; Mon, 01 Jun 2026 16:24:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wU9Bk-0003fE-Bc; Mon, 01 Jun 2026 16:24:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651G0Xh43309410; Mon, 1 Jun 2026 20:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lxcAmP
 8xBTH3fnKZJuMGrh9qW/fcfoEUTL4u6C5uSy0=; b=D3Z8R0DrhXAFzulPX9mdiX
 bjO9MDLLo3nVazZJyOsbP7OEDuvIbwgilusXCtw/kN/mQS8IeIi4uiKENUnmFGj5
 2nkNoBOaovwZEhFFVbJn3TM/Eq2NMFjvbAq6tUCFxpww9aWLb9d4a/b7zzsMppc9
 QMjRs/0eMJ/vDJeYE/YF80f9dbnaJE0gLuPbOSFfrWjoKJ0D9n5/0ZrPXaPzxHY3
 ODtZcTY8fUK7Ikr+WqJ/MsVj5wbu2g57+9occKlu6KWjI83/RDv7B35AygQ9HhpC
 2UVTQMcUHC9ioScs9gzYU/I2IQ2k2hyfxezKUT0l0Gagg18mm8TfnshSHQ/6xVCw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjkxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 20:24:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651KO7T2002968;
 Mon, 1 Jun 2026 20:24:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q85ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 20:24:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651KOYrF10748622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 20:24:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 292EB5803F;
 Mon,  1 Jun 2026 20:24:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D5A358061;
 Mon,  1 Jun 2026 20:24:32 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  1 Jun 2026 20:24:32 +0000 (GMT)
Message-ID: <632db3ab-408a-4d0c-b8ce-be6d52bb9cad@linux.ibm.com>
Date: Mon, 1 Jun 2026 16:24:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-22-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260505201905.997996-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE5NiBTYWx0ZWRfXyOfV1hgRP38k
 sXa0PjWlUX6/zJ8jN4BMOmI8awNvjxxTamdjK0u42tJ1y7Oxtxad7xf4b2DqNjn2scAaotPAp7A
 zx6bb38n51itwcvsfoyY9D0rZWJ7qpR6Tkmr+v9n30FGwyXJD6nzZ8pHVObkmclbI+tDpMaq4NE
 4A41N+IwNwBTnGov8Z4hbMvHoeJBUUrGzWJnn9y9HzMYpAKbUGLVp7uEXOE0LyExhr3+cU/2ZnV
 qPO2ucHYgvBliofkCaP0XJTRBz8EyBYOCwegE3zzc2p3v9qwNmx0dDhHHvz+aLogUS/xXI6Zt3g
 hUoRx47AKcZbo0Ko5tDT4sBqsL2645Vd6zwkr/TuOpiQRhxQ1b6NEsD8m0pHSFt/aRSKyfmxawt
 Mrm7Sgn81Mq8HKO3/X3i1xNXcGmP0NJrPVAjDeDN0PamLadGChxzY6IXPgJjsDcodudi1iG+lNl
 Zg/ZbibakwfzGu+GbTg==
X-Proofpoint-ORIG-GUID: _nPeQj_7vVp-AcLCKZvakuDHkknOVYIL
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dea85 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IS6b3r6a9NrpiuS5_00A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _nPeQj_7vVp-AcLCKZvakuDHkknOVYIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010196
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 5/5/26 4:18 PM, Zhuoying Cai wrote:
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
>   docs/system/s390x/secure-ipl.rst |  15 ++
>   pc-bios/s390-ccw/Makefile        |   2 +-
>   pc-bios/s390-ccw/bootmap.c       |  16 ++
>   pc-bios/s390-ccw/bootmap.h       |   9 +
>   pc-bios/s390-ccw/main.c          |  10 +-
>   pc-bios/s390-ccw/s390-ccw.h      |  24 ++
>   pc-bios/s390-ccw/sclp.c          |  27 +++
>   pc-bios/s390-ccw/sclp.h          |   6 +
>   pc-bios/s390-ccw/secure-ipl.c    | 364 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h    | 113 ++++++++++
>   10 files changed, 584 insertions(+), 2 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 9d7d33f5ed..cf6ccf5d57 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -39,3 +39,18 @@ Configuration:
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio ...
> +
> +Audit Mode
> +^^^^^^^^^^
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
> index 3e5dfb64d5..2109d16781 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o clp.o pci.o virtio-pci.o
> +	  virtio-ccw.o clp.o pci.o virtio-pci.o secure-ipl.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 667a69f80d..a300fba8cd 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -15,6 +15,7 @@
>   #include "bootmap.h"
>   #include "virtio.h"
>   #include "bswap.h"
> +#include "secure-ipl.h"
>   
>   #ifdef DEBUG
>   /* #define DEBUG_FALLBACK */
> @@ -737,6 +738,9 @@ static int zipl_run(ScsiBlockPtr *pte)
>       case ZIPL_BOOT_MODE_NORMAL:
>           rc = zipl_run_normal(&entry, tmp_sec);
>           break;
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        rc = zipl_run_secure(&entry, tmp_sec);
> +        break;
>       default:
>           panic("Unknown boot mode");
>       }
> @@ -1107,6 +1111,18 @@ static int zipl_load_vscsi(void)
>    * IPL starts here
>    */
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
>   void zipl_load(void)
>   {
>       VDev *vdev = virtio_get_device();
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 8d61ac383c..1e00454a1f 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>       BootMapPointer entry[];
>   } __attribute__ ((packed)) BootMapTable;
>   
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} SignatureInformation;
> +
>   typedef union ComponentEntryData {
>       uint64_t load_psw;
>       uint64_t load_addr;
> +    SignatureInformation sig_info;
>   } ComponentEntryData;
>   
>   typedef struct ComponentEntry {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 66544f75f5..0bcd32b059 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -394,7 +394,15 @@ void main(void)
>           probe_boot_device();
>       }
>   
> -    boot_mode = ZIPL_BOOT_MODE_NORMAL;
> +    boot_mode = get_boot_mode(iplb->hdr_flags);
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        if (!secure_ipl_supported()) {
> +            panic("Unable to boot in audit mode");
> +        }
> +    default:
> +        break;
> +    }
>   
>       while (have_iplb) {
>           boot_setup();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 5420443ad2..b66a9b50bf 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -40,6 +40,22 @@ typedef unsigned long long u64;
>                               ((b) == 0 ? (a) : (MIN(a, b))))
>   #endif
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
>   #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>   
>   #include "cio.h"
> @@ -64,6 +80,8 @@ void sclp_print(const char *string);
>   void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>   void sclp_setup(void);
>   void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
>   int sclp_read(char *str, size_t count);
>   
>   /* bootmap.c */
> @@ -71,10 +89,16 @@ void zipl_load(void);
>   
>   typedef enum ZiplBootMode {
>       ZIPL_BOOT_MODE_NORMAL = 0,
> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
>   } ZiplBootMode;
>   
>   extern ZiplBootMode boot_mode;
>   
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
> +
> +/* secure-ipl.c */
> +bool secure_ipl_supported(void);
> +
>   /* jump2ipl.c */
>   void write_reset_psw(uint64_t psw);
>   int jump_to_IPL_code(uint64_t address);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..48bdfedf1f 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
>       }
>   }
>   
> +bool sclp_is_diag320_on(void)
> +{
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
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
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        return sccb->fac_ipl & fac_ipl_flag;
> +    }
> +
> +    return 0;
> +}
> +
>   int sclp_read(char *str, size_t count)
>   {
>       ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..a8a41cd004 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>   } __attribute__((packed)) SCCBHeader;
>   
>   #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_FAC_IPL_SIPL_BIT   0x4000
>   
>   typedef struct ReadInfo {
>       SCCBHeader h;
> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>       uint8_t rnsize;
>       uint8_t reserved[13];
>       uint8_t loadparm[LOADPARM_LEN];
> +    uint8_t reserved1[102];
> +    uint8_t fac134;
> +    uint8_t reserved2;
> +    uint16_t fac_ipl;
>   } __attribute__((packed)) ReadInfo;
>   
>   typedef struct SCCB {
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> new file mode 100644
> index 0000000000..6e943446a7
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,364 @@
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
> +#include "sclp.h"
> +#include "secure-ipl.h"
> +
> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
> +{
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb.length == VCSSB_MIN_LEN) {
> +        return &vcssb;
> +    }
I don't quite understand what is happening with the VCSSB_MIN_LENGTH 
here.  Why
is the minimum length significant, as opposed to simply non-zero?

> +
> +    vcssb.length = VCSSB_MIN_LEN;
> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
> +        vcssb.length = 0;
> +        return NULL;
> +    }
> +
> +    return &vcssb;
> +}
> +
> +static uint32_t get_total_certs_length(void)
> +{
> +    if (zipl_secure_get_vcssb() == NULL) {
> +        return 0;
> +    }
Should we check if vcssb.len == 4 for the early return?  I think it 
designates
an empty cert store and nothing else gets initialized.

> +
> +    return vcssb.total_vcb_len - sizeof(VCBlockHeader) -
> +           vcssb.total_vc_ct * sizeof(VCEntryHeader);
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
> +    } __attribute__((__aligned__(4096))) vcb = { 0 };
Regarding Collin's comments about using CERT_BUF_MAX_LEN versus 
vcssb.max_single_vcb_len,
because the VCB must be 4k aligned we didn't want to malloc a variable 
length
buffer, which is why the constant max was used.  AFAIK malloc cannot enforce
any alignment requirements and we do not have the libraries for memalign 
in BIOS.

I thought I saw that the cert store does already reject certs exceeding 
this size,
but if not, I agree with Collin that it should.

> +
> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
> +    if (zipl_secure_get_vcssb() == NULL) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     *
> +     * First and last index must be equal because only one
> +     * VCE per VCB is currently supported
> +     */
> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
> +    vcb.vcb_hdr.first_vc_index = index;
> +    vcb.vcb_hdr.last_vc_index = index;
> +
> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
> +        puts("No certificate entry");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.remain_ct != 0) {
> +        panic("Not enough memory to store all requested certificates");
> +    }
> +
> +    vce_hdr = &vcb.vce.vce_hdr;
> +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
> +        puts("Invalid certificate");
> +        return 0;
> +    }
> +
> +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr->cert_len);
> +
> +    return vce_hdr->cert_len;
> +}
> +
> +static int cert_list_add(IplSignatureCertificateList *cert_list,
> +                         uint8_t *cert_buf, uint64_t cert_len)
> +{
> +    static bool warned;
> +    int cert_entry_idx;
> +
> +    cert_entry_idx = (cert_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
> +                     sizeof(IplSignatureCertificateEntry);
> +    if (cert_entry_idx > MAX_CERTIFICATES - 1) {
I think this is actually impossible because we terminate the IPL when 
building
the cert store if there are too many entries, right?

> +        if (!warned) {
> +            printf("Warning: only %d cert entries are supported;"
> +                   " additional entries are ignored\n",
> +                   MAX_CERTIFICATES);
> +            warned = true;
> +        }
> +        return cert_entry_idx;
> +    }
> +
> +    cert_list->cert_entries[cert_entry_idx].addr = (uint64_t)cert_buf;
> +    cert_list->cert_entries[cert_entry_idx].len = cert_len;
> +    cert_list->ipl_info_header.len += sizeof(IplSignatureCertificateEntry);
> +
> +    return cert_entry_idx;
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comp_list,
> +                          SecureIplCompEntryInfo comp_entry_info)
> +{
> +    int comp_entry_idx;
> +
> +    comp_entry_idx = (comp_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
> +                     sizeof(IplDeviceComponentEntry);
> +    if (comp_entry_idx > MAX_COMP_ENTRIES - 1) {
> +        printf("Warning: only %d component entries are supported\n",
> +                MAX_COMP_ENTRIES);
> +        panic("The device component list has reached its maximum capacity");
> +    }
> +
> +    comp_list->device_entries[comp_entry_idx].addr = comp_entry_info.addr;
> +    comp_list->device_entries[comp_entry_idx].len = comp_entry_info.len;
> +    comp_list->device_entries[comp_entry_idx].flags = comp_entry_info.flags;
> +    /* cert index field is meaningful only when S390_IPL_DEV_COMP_FLAG_SC is set */
> +    if (comp_entry_info.flags & S390_IPL_DEV_COMP_FLAG_SC) {
> +        comp_list->device_entries[comp_entry_idx].cert_index =
> +                                                  comp_entry_info.cert_index;
> +    }
> +    comp_list->ipl_info_header.len += sizeof(IplDeviceComponentEntry);
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
> +bool secure_ipl_supported(void)
> +{
> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SIPL_BIT)) {
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
> +    comp_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
> +
> +    cert_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_CERTIFICATES;
> +    cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
> +}
> +
> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
> +{
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
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
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> +{
> +    IplDeviceComponentList comp_list = { 0 };
> +    IplSignatureCertificateList cert_list = { 0 };
> +    SecureIplCompEntryInfo sig_entry_info = { 0 };
> +    SecureIplCompEntryInfo comp_entry_info;
> +    ComponentEntry *entry = *entry_ptr;
> +    uint8_t *cert_buf = NULL;
> +    int sig_len = 0;
> +    int comp_len;
> +    int cert_entry_idx;
> +    uint64_t comp_addr;
> +    uint64_t cert_len;
> +    uint8_t cert_table_idx;
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
> +    init_lists(&comp_list, &cert_list);
> +    cert_buf = malloc(get_total_certs_length());
> +    sig_entry_info.addr = (uint64_t)malloc(MAX_SECTOR_SIZE);
I think we can reduce the memory footprint significantly, which will 
also help
with designating a safe spot for the components if we are worried about them
getting clobbered or lost.

Currently cert_buf is allocating enough space for the entire cert store, but
if I understand correctly, only 2 or possibly 3 certs can be used for 
any one
IPL.  So I don't think it is necessary to allocate more than 3x the max cert
size.

If we need a well defined place to put them, my first thought would be 
to use
the "next_iplb" field of the qipl struct.  This field points to the next 
IPLB
to be used when multiple boot devices are specified, but the address 
itself is
derived as an offset from the start of the kernel code in memory.

There are 8 4K pages that can be used for chained IPLBs, but that space 
is no
longer needed once we have identified our good IPLB and commit to 
booting it.
I think this space can safely be used to store the certs until the kernel
reads them during boot.

There might be a few other things that need adjustment, but in principle 
I think
writing to the pages previously occupied by an IPLB chain should be viable.

> +
> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        switch (entry->component_type) {
> +        case ZIPL_COMP_ENTRY_SIGNATURE:
> +            if (sig_entry_info.len) {
> +                goto out;
> +            }
> +
> +            sig_len = zipl_load_signature(entry, sig_entry_info.addr);
> +            if (sig_len < 0) {
> +                goto out;
> +            }
> +
> +            sig_entry_info.len = sig_len;
> +            break;
> +        case ZIPL_COMP_ENTRY_LOAD:
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry->data.blockno, comp_addr);
> +            if (comp_len < 0) {
> +                goto out;
> +            }
> +
> +            comp_entry_info = (SecureIplCompEntryInfo){ 0 };
> +            comp_entry_info.addr = comp_addr;
> +            comp_entry_info.len = (uint64_t)comp_len;
> +
> +            /* no signature present (unsigned component) */
> +            if (!sig_entry_info.len) {
> +                break;
> +            }
> +
> +            /*
> +             * Initialize with SC flag (signed component)
> +             * CSV flag set upon successful verification
> +             */
> +            comp_entry_info.flags = S390_IPL_DEV_COMP_FLAG_SC;
> +
> +            verified = verify_signature(comp_entry_info, sig_entry_info,
> +                                        &cert_len, &cert_table_idx);
> +
> +            if (verified) {
> +                if (cert_list_table[cert_table_idx] == -1) {
> +                    if (!request_certificate(cert_buf, cert_table_idx)) {
> +                        puts("Could not get certificate");
> +                        goto out;
> +                    }
> +
> +                    cert_entry_idx = cert_list_add(&cert_list, cert_buf, cert_len);
> +                    /* map cert-store index to cert-list entry index */
> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
> +                    /* increment for the next certificate */
> +                    cert_buf += cert_len;
> +                }
> +
> +                comp_entry_info.cert_index = cert_list_table[cert_table_idx];
> +                comp_entry_info.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
> +                puts("Verified component");
> +            } else {
> +                zipl_secure_error("Could not verify component");
> +            }
> +
> +            comp_list_add(&comp_list, comp_entry_info);
> +
> +            signed_count += 1;
> +            /* After a signature is used another new one can be accepted */
> +            sig_entry_info.len = 0;
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
> +        zipl_secure_error("Secure boot is on, but components are not signed");
> +    }
> +
> +    update_iirb(&comp_list, &cert_list);
> +
> +    *entry_ptr = entry;
> +    free((void *)sig_entry_info.addr);
> +
> +    return 0;
> +out:
> +    free(cert_buf);
> +    free((void *)sig_entry_info.addr);
> +
> +    return -1;
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..cc0302f56b
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,113 @@
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
> +/* Custom struct for secure IPL component entry information */
> +typedef struct SecureIplCompEntryInfo {
> +    uint64_t addr;
> +    uint64_t len;
> +    uint16_t cert_index;
> +    uint8_t  flags;
> +} SecureIplCompEntryInfo;
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
> +    if (_diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM) != DIAG_320_RC_OK) {
> +        return false;
> +    }
> +
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
> +static inline bool verify_signature(SecureIplCompEntryInfo comp_entry_info,
> +                                    SecureIplCompEntryInfo sig_entry_info,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SigVerifBlock svb;
> +
> +    svb.length = sizeof(Diag508SigVerifBlock);
> +    svb.version = 0;
> +    svb.comp_len = comp_entry_info.len;
> +    svb.comp_addr = comp_entry_info.addr;
> +    svb.sig_len = sig_entry_info.len;
> +    svb.sig_addr = sig_entry_info.addr;
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


