Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02E2F428C8
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD5cN-0000XQ-5X; Wed, 15 Apr 2026 15:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wD5cK-0000Wj-G7; Wed, 15 Apr 2026 15:09:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wD5cH-0005Mn-GH; Wed, 15 Apr 2026 15:09:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FHjQLr1833338; Wed, 15 Apr 2026 19:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fyDIjU
 MG/f2HcYwTXnPdbTRnN7dDwrOAxXXvO7xNnP8=; b=ma+8X9EoqgqP3PB2Tvv2Pa
 BQZ+Wo1bDiGI7ZoRwhCSmHCRt6g6S5wqu20kHByybGr141PQu+L1bd/urOt2CL0r
 3pE6fkk/MbITuaAWFIr0ozkmk1Go7g+Mo2TfCrmbgipzRaFp3llzyWBcif2EkHgg
 zRJjcvIzM+RpxXfkUVajhJL3OQm3YPbw8xlHVl3ZUfyHNpLXla7l7E6RO8MpV0ml
 AHibeGzF7RbvLV5XTbArTdUGypVNELTcfe2qj8cERnQEBiR9YkM6KkX828xs0Hao
 N74e1D6KWOnx9Ex7by+PNRJ5vrzerW2GOjiLYX/tWmpM/pRRRwkq2TLYiUcnmAjQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rhupp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 19:09:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FHnUMS003278;
 Wed, 15 Apr 2026 19:09:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh918sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 19:09:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FJ9I3r2884496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 19:09:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4D3D58062;
 Wed, 15 Apr 2026 19:09:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D1605805A;
 Wed, 15 Apr 2026 19:09:16 +0000 (GMT)
Received: from [9.61.102.229] (unknown [9.61.102.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Apr 2026 19:09:16 +0000 (GMT)
Message-ID: <cfdaf3ec-23c5-4ae1-977e-5a6eb1727f42@linux.ibm.com>
Date: Wed, 15 Apr 2026 15:09:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 22/30] pc-bios/s390-ccw: Add additional security
 checks for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-23-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3NSBTYWx0ZWRfX0S+ouW7vPYWc
 p0lM9lV/ZSLR3m0lf3QTe3rutHLVFHpfhYwfhFoCRoLR/94QzXugqtSDE5pdk9tylWCZGOn+kXj
 jS3KtGCKX/LzPHpmhmxgFCTm1urXS46uSZ45ZOQwtH3YEY5/SGUKRhqC1ZfI4KiuRpVkdVhz0aI
 mjg0jN2NTHW5MH7NqUqri4tRwaEomyMxrZJJ/MeNRF3aG7GrqZ05M1k/6xeIjtFaQsDYe42rWVi
 LlcfEc67sj2uCsU6fVN2rT8u67Dx2xWeLWE3zu/sNVKTAjzqxu/ZnDWzOcofajdoVj7aYmbejVk
 6mUk9gsgUz0qnVijB+2wvYpNrw8PtfURHVIuW6nNHQVfRIzo3RF9rkXXtug3wPz1bRKLOlgONtY
 a0aN5jtD+l7JuEnGvhD6Zx+zSnS0YQkoCYu6aJKzm7rfvNrYCwPdOraj8d40IdGsyDkIfxZpcJc
 qdHUVgOts7OEZiuwfug==
X-Proofpoint-ORIG-GUID: 7bnw4k1LLA0DUnPWwsF2Sv4Ddq2pycnj
X-Proofpoint-GUID: 7bnw4k1LLA0DUnPWwsF2Sv4Ddq2pycnj
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69dfe260 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=bsw2H0sJ5yV3TC_93pkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 4/2/26 6:14 PM, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
>
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
>
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
>
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
>
> When SCLAF is installed, its content must be evaluated during secure IPL.
> However, a missing SCLAB will not be reported in audit mode. The SCALB
> checking will be skipped in this case.
>
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
>
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/qipl.h   |  29 +++-
>   pc-bios/s390-ccw/s390-ccw.h   |   1 +
>   pc-bios/s390-ccw/sclp.c       |   8 +
>   pc-bios/s390-ccw/sclp.h       |   1 +
>   pc-bios/s390-ccw/secure-ipl.c | 283 +++++++++++++++++++++++++++++++++-
>   pc-bios/s390-ccw/secure-ipl.h |  49 ++++++
>   6 files changed, 365 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index dcb84f729a..ea9bd8bf8b 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -156,10 +156,20 @@ struct IplInfoReportBlockHeader {
>   };
>   typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
>   
> +/* IPL Info Error Indicators */
> +#define S390_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
> +#define S390_IIEI_NO_SCLAB            0x4000 /* bit 1 */
> +#define S390_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
> +#define S390_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
> +#define S390_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
> +#define S390_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
> +
>   struct IplInfoBlockHeader {
>       uint32_t len;
>       uint8_t  type;
> -    uint8_t  reserved1[11];
> +    uint8_t  reserved1[3];
> +    uint16_t iiei;
> +    uint8_t  reserved2[6];
>   };
>   typedef struct IplInfoBlockHeader IplInfoBlockHeader;
>   
> @@ -183,13 +193,28 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
>   #define S390_IPL_DEV_COMP_FLAG_SC  0x80
>   #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
>   
> +/* IPL Device Component Error Indicators */
> +#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
> +#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
> +#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
> +#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
> +#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLA    0x2000000  /* bit 6 */
> +#define S390_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
> +#define S390_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
> +#define S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
> +#define S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
> +#define S390_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
> +
>   struct IplDeviceComponentEntry {
>       uint64_t addr;
>       uint64_t len;
>       uint8_t  flags;
>       uint8_t  reserved1[5];
>       uint16_t cert_index;
> -    uint8_t  reserved2[8];
> +    uint32_t cei;
> +    uint8_t  reserved2[4];
>   };
>   typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
>   
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 1b09aed8b1..e1a8097c95 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -82,6 +82,7 @@ void sclp_setup(void);
>   void sclp_get_loadparm_ascii(char *loadparm);
>   bool sclp_is_diag320_on(void);
>   bool sclp_is_sipl_on(void);
> +bool sclp_is_sclaf_on(void);
>   int sclp_read(char *str, size_t count);
>   
>   /* bootmap.c */
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 6283ae71bc..be6055bb40 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -150,6 +150,14 @@ bool sclp_is_sipl_on(void)
>       return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
>   }
>   
> +bool sclp_is_sclaf_on(void)
> +{
> +    uint16_t fac_ipl = 0;
> +
> +    sclp_get_fac_ipl(&fac_ipl);
> +    return fac_ipl & SCCB_FAC_IPL_SCLAF_BIT;
> +}
> +
Could sclp_get_fac_ipl() be reworked to instead take the FLAGS as a 
parameter and then return the result of sccb->fac_ipl & FLAGS?  That way 
we wouldn't need a wrapper to check the bits.

>   int sclp_read(char *str, size_t count)
>   {
>       ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index cf147f4634..3441020d6b 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>   #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>   #define SCCB_FAC134_DIAG320_BIT 0x4
>   #define SCCB_FAC_IPL_SIPL_BIT 0x4000
> +#define SCCB_FAC_IPL_SCLAF_BIT 0x1000
>   
>   typedef struct ReadInfo {
>       SCCBHeader h;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index d2079e19bc..d4e455ed0c 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -134,6 +134,7 @@ static void comp_list_add(IplDeviceComponentList *comp_list, int comp_entry_idx,
>   
>       comp_list->device_entries[comp_entry_idx].addr = comp_entry_info.addr;
>       comp_list->device_entries[comp_entry_idx].len = comp_entry_info.len;
> +    comp_list->device_entries[comp_entry_idx].cei = comp_entry_info.cei;
>       comp_list->device_entries[comp_entry_idx].flags = comp_entry_info.flags;
>       /* cert index field is meaningful only when S390_IPL_DEV_COMP_FLAG_SC is set */
>       comp_list->device_entries[comp_entry_idx].cert_index = comp_entry_info.cert_index;
> @@ -198,6 +199,12 @@ static bool secure_ipl_supported(void)
>           return false;
>       }
>   
> +    if (!sclp_is_sclaf_on()) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
> +             " the hypervisor!");
> +        return false;
> +    }
> +
>       return true;
>   }
>   
> @@ -254,6 +261,259 @@ static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
>       range_list->comp_addr_range[range_list->index].end_addr = end_addr;
>   }
>   
> +static void check_unsigned_addr(SecureIplCompEntryInfo *comp_entry_info)
> +{
> +    /* unsigned load address must be greater than or equal to 0x2000 */
> +    comp_entry_info->cei |= validate_comp_condition(
> +                    comp_entry_info->addr >= S390_SECURE_IPL_UNSIGNED_MIN_ADDR,
> +                    S390_CEI_INVALID_UNSIGNED_ADDR,
> +                    "Load address is less than 0x2000");
> +}
> +
> +static bool check_sclab_presence(uint8_t *sclab_magic, uint32_t *cei_flags)
> +{
> +    /* identifies the presence of SCLAB */
> +    if (magic_match(sclab_magic, ZIPL_MAGIC)) {
> +        return true;
> +    }
> +
> +    *cei_flags |= S390_CEI_INVALID_SCLAB;
> +
> +    /* a missing SCLAB will not be reported in audit mode */
> +    return false;
> +}
> +
> +static void check_sclab_length(uint16_t sclab_len, uint32_t *cei_flags)
> +{
> +    *cei_flags |= validate_comp_condition(sclab_len >= S390_SECURE_IPL_SCLAB_MIN_LEN,
> +                                          S390_CEI_INVALID_SCLAB_LEN |
> +                                          S390_CEI_INVALID_SCLAB,
> +                                          "Invalid SCLAB length");
> +}
> +
> +static void check_sclab_format(uint8_t sclab_format, uint32_t *cei_flags)
> +{
> +    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
> +    *cei_flags |= validate_comp_condition(sclab_format == 0,
> +                                          S390_CEI_INVALID_SCLAB_FORMAT,
> +                                          "Format-0 SCLAB is not being used");
> +}
> +
> +static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
> +                             SecureIplSclabInfo *sclab_info, uint32_t *cei_flags)
> +{
> +    const char *msg;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW)) {
> +        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
> +        msg = "Load PSW is not zero when Override PSW bit is zero";
> +        *cei_flags |= validate_comp_condition(sclab->load_psw == 0,
> +                                              S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
> +                                              msg);
> +
> +    } else {
> +        /* OPSW = 1 indicating global SCLAB */
> +        sclab_info->global_count += 1;
> +        if (sclab_info->global_count == 1) {
> +            sclab_info->global_load_psw = sclab->load_psw;
> +            sclab_info->global_flags = sclab->flags;
> +        }
> +
> +        /* OLA must set to one */
> +        msg = "Override Load Address bit is not set to one in the global SCLAB";
> +        *cei_flags |= validate_comp_condition(
> +                            sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA,
> +                            S390_CEI_SCLAB_OLA_NOT_ONE, msg);
> +    }
> +}
> +
> +static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab,
> +                            uint64_t load_addr, uint32_t *cei_flags)
> +{
> +    const char *msg;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
> +        /* OLA = 0 - Load address field in SCLAB must contain zeros */
> +        msg = "Load Address is not zero when Override Load Address bit is zero";
> +        *cei_flags |= validate_comp_condition(sclab->load_addr == 0,
> +                                              S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
> +                                              msg);
> +    } else {
> +        /* OLA = 1 - Load address field must match storage address of the component */
> +        msg = "Load Address does not match with component load address";
> +        *cei_flags |= validate_comp_condition(sclab->load_addr == load_addr,
> +                                              S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
> +                                              msg);
> +    }
> +}
> +
> +static void check_sclab_nuc(uint16_t sclab_flags, uint32_t *cei_flags)
> +{
> +    const char *msg;
> +    bool is_nuc_set;
> +    bool is_global_sclab;
> +
> +    is_nuc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
> +    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
> +    msg = "No Unsigned Components bit is set, but not in the global SCLAB";
> +    *cei_flags |= validate_comp_condition(!is_nuc_set || is_global_sclab,
> +                                          S390_CEI_NUC_NOT_IN_GLOBAL_SCLA, msg);
> +}
> +
> +static void check_sclab_sc(uint16_t sclab_flags, uint32_t *cei_flags)
> +{
> +    const char *msg;
> +    bool is_sc_set;
> +    bool is_global_sclab;
> +
> +    is_sc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
> +    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
> +    msg = "Single Component bit is set, but not in the global SCLAB";
> +    *cei_flags |= validate_comp_condition(!is_sc_set || is_global_sclab,
> +                                          S390_CEI_SC_NOT_IN_GLOBAL_SCLAB, msg);
> +}
See comment below about how the flags are defined.

These checks seem unnecessarily complicated.  I think the whole SCLAB 
validation process could be distilled into one function that does the 
checks inline.

e.g. (untested)

     if (~sclab_flags & S390_SCLAB_SC || sclab_flags & S390_SCLAB_OPSW) {
         zipl_secure_handle("SC bit is set, but not in the global SCLAB");
         cei_flags |= S390_CEI_SC_NOT_IN_GLOBAL_SCLAB;
     }

etc...

It would be a fairly long series of if statements, but I don't see much 
benefit to wrapping them in layers of function calls.

> +
> +static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRangeList *range_list)
> +{
> +    uint32_t addr = psw & 0x7fffffff;
> +
> +    /* PSW points within a signed binary code component */
> +    for (int i = 0; i < range_list->index; i++) {
> +        if (range_list->comp_addr_range[i].is_signed &&
> +            addr >= range_list->comp_addr_range[i].start_addr &&
> +            addr <= range_list->comp_addr_range[i].end_addr - 2) {
> +            return true;
> +       }
> +    }
> +    return false;
> +}
> +
> +static void check_load_psw(SecureIplCompAddrRangeList *range_list,
> +                           uint64_t sclab_load_psw,
> +                           SecureIplCompEntryInfo *comp_entry_info)
> +{
> +    bool valid;
> +    uint64_t load_psw;
> +
> +    load_psw = comp_entry_info->addr;
> +    valid = is_psw_valid(sclab_load_psw, range_list) &&
> +            is_psw_valid(load_psw, range_list);
> +    comp_entry_info->cei |= validate_comp_condition(valid,
> +                                                    S390_CEI_INVALID_LOAD_PSW,
> +                                                    "Invalid PSW");
> +
> +    /* compare load PSW with the PSW specified in component */
> +    comp_entry_info->cei |= validate_comp_condition(sclab_load_psw == load_psw,
> +                                          S390_CEI_UNMATCHED_SCLAB_LOAD_PSW,
> +                                         "Load PSW does not match with PSW in component");
> +}
> +
> +static void check_no_unsigned_comp(SecureIplSclabInfo sclab_info,
> +                                   IplDeviceComponentList *comp_list)
> +{
> +    bool is_nuc_set;
> +
> +    is_nuc_set = sclab_info.global_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
> +    if (is_nuc_set && sclab_info.unsigned_count > 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_FOUND_UNSIGNED_COMP;
> +        zipl_secure_handle("Unsigned components are not allowed");
> +    }
> +}
> +
> +static void check_single_comp(SecureIplSclabInfo sclab_info,
> +                              IplDeviceComponentList *comp_list)
> +{
> +    bool is_sc_set;
> +
> +    is_sc_set = sclab_info.global_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
> +    if (is_sc_set &&
> +        sclab_info.signed_count != 1 &&
> +        sclab_info.unsigned_count >= 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_SIGNED_COMP;
> +        zipl_secure_handle("Only one signed component is allowed");
> +    }
> +}
> +
> +void check_global_sclab(SecureIplSclabInfo sclab_info,
> +                        IplDeviceComponentList *comp_list)
> +{
> +    if (sclab_info.count == 0) {
> +        return;
> +    }
> +
> +    if (sclab_info.global_count == 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_NO_GLOBAL_SCLAB;
> +        zipl_secure_handle("Global SCLAB does not exists");
> +        return;
> +    }
> +
> +    if (sclab_info.global_count > 1) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
> +        zipl_secure_handle("More than one global SCLAB");
> +        return;
> +    }
> +
> +    if (sclab_info.global_flags) {
> +        /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
> +        check_no_unsigned_comp(sclab_info, comp_list);
> +
> +        /* Only one signed component is allowed is SC flag is set in the global SCLAB */
> +        check_single_comp(sclab_info, comp_list);
> +    }
> +}
> +
> +static void check_has_signed_comp(int signed_count, IplDeviceComponentList *comp_list)
> +{
> +    const char *msg;
> +
> +    msg = "Secure boot is on, but components are not signed";
> +    comp_list->ipl_info_header.iiei |=
> +                validate_comp_condition(signed_count > 0,
> +                                        S390_IIEI_NO_SIGNED_COMP, msg);
> +
> +}
> +
> +static void check_sclab_count(int count, IplDeviceComponentList *comp_list)
> +{
> +    comp_list->ipl_info_header.iiei |=
> +                validate_comp_condition(count > 0, S390_IIEI_NO_SCLAB,
> +                                        "No recognizable SCLAB");
> +}
See above comments on the other check_sclab_* functions.  These types of 
wrappers don't seem necessary to me.

> +
> +static void check_sclab(SecureIplCompEntryInfo *comp_entry_info,
> +                        SecureIplSclabInfo *sclab_info)
> +{
> +    SclabOriginLocator *sclab_locator;
> +    SecureCodeLoadingAttributesBlock *sclab;
> +
> +    /* sclab locator is located at the last 8 bytes of the signed comp */
> +    sclab_locator = (SclabOriginLocator *)(comp_entry_info->addr +
> +                                           comp_entry_info->len - 8);
> +
> +    /* return early if sclab does not exist */
> +    if (!check_sclab_presence(sclab_locator->magic, &comp_entry_info->cei)) {
> +        return;
> +    }
> +
> +    check_sclab_length(sclab_locator->len, &comp_entry_info->cei);
> +
> +    /* return early if sclab is invalid */
> +    if (comp_entry_info->cei & S390_CEI_INVALID_SCLAB) {
> +        return;
> +    }
> +
> +    sclab_info->count += 1;
> +    sclab = (SecureCodeLoadingAttributesBlock *)(comp_entry_info->addr +
> +                                                 comp_entry_info->len -
> +                                                 sclab_locator->len);
> +
> +    check_sclab_format(sclab->format, &comp_entry_info->cei);
> +    check_sclab_opsw(sclab, sclab_info, &comp_entry_info->cei);
> +    check_sclab_ola(sclab, comp_entry_info->addr, &comp_entry_info->cei);
> +    check_sclab_nuc(sclab->flags, &comp_entry_info->cei);
> +    check_sclab_sc(sclab->flags, &comp_entry_info->cei);
> +}
> +
>   static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>   {
>       if (zipl_load_segment(entry, sig_sec) < 0) {
> @@ -297,7 +557,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>        */
>       int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>       SecureIplCompAddrRangeList range_list = { 0 };
> -    int signed_count = 0;
> +    SecureIplSclabInfo sclab_info = { 0 };
>   
>       if (!secure_ipl_supported()) {
>           panic("Unable to boot in secure/audit mode");
> @@ -337,9 +597,15 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>               range_list.index += 1;
>   
>               if (!sig_len) {
> +                check_unsigned_addr(&comp_entry_info);
> +                comp_list_add(&comp_list, comp_entry_idx, comp_entry_info);
> +
> +                sclab_info.unsigned_count += 1;
> +                comp_entry_idx++;
>                   break;
>               }
>   
> +            check_sclab(&comp_entry_info, &sclab_info);
>               verified = verify_signature(comp_entry_info,
>                                           sig_len, (uint64_t)sig,
>                                           &cert_len, &cert_table_idx);
> @@ -374,7 +640,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>               }
>   
>               comp_entry_idx++;
> -            signed_count += 1;
> +            sclab_info.signed_count += 1;
>               /* After a signature is used another new one can be accepted */
>               sig_len = 0;
>               break;
> @@ -391,10 +657,19 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>           }
>       }
>   
> -    if (signed_count == 0) {
> -        zipl_secure_handle("Secure boot is on, but components are not signed");
> +    /* validate load PSW with PSW specified in the final entry */
> +    if (sclab_info.global_load_psw) {
> +        comp_entry_info = (SecureIplCompEntryInfo){ 0 };
> +        comp_entry_info.addr = entry->compdat.load_psw;
> +
> +        check_load_psw(&range_list, sclab_info.global_load_psw, &comp_entry_info);
> +        comp_list_add(&comp_list, comp_entry_idx, comp_entry_info);
>       }
>   
> +    check_has_signed_comp(sclab_info.signed_count, &comp_list);
> +    check_sclab_count(sclab_info.count, &comp_list);
> +    check_global_sclab(sclab_info, &comp_list);
> +
>       update_iirb(&comp_list, &cert_list);
>   
>       *entry_ptr = entry;
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index c625ac2e3a..75d1c8e046 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -16,10 +16,47 @@
>   VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>   int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>   
> +#define S390_SECURE_IPL_SCLAB_FLAG_OPSW    0x8000
> +#define S390_SECURE_IPL_SCLAB_FLAG_OLA     0x4000
> +#define S390_SECURE_IPL_SCLAB_FLAG_NUC     0x2000
> +#define S390_SECURE_IPL_SCLAB_FLAG_SC      0x1000
In my opinion these should be shortened to, e.g.

     S390_SCLAB_SC   0x1000    /* single component flag */

This would make using them for bitwise operations much more manageable.

Add a comment for what each flag/acronym stands for.

> +
> +#define S390_SECURE_IPL_SCLAB_MIN_LEN      32
> +#define S390_SECURE_IPL_UNSIGNED_MIN_ADDR  0x2000
> +
> +struct SecureCodeLoadingAttributesBlock {
> +    uint8_t  format;
> +    uint8_t  reserved1;
> +    uint16_t flags;
> +    uint8_t  reserved2[4];
> +    uint64_t load_psw;
> +    uint64_t load_addr;
> +    uint64_t reserved3[];
> +} __attribute__ ((packed));
> +typedef struct SecureCodeLoadingAttributesBlock SecureCodeLoadingAttributesBlock;
This is kind of ugly.  Maybe SclaBlock?  SCLoadAttrBlock?  Just include 
a comment with the full name.

> +
> +struct SclabOriginLocator {
> +    uint8_t reserved[2];
> +    uint16_t len;
> +    uint8_t magic[4];
> +} __attribute__ ((packed));
> +typedef struct SclabOriginLocator SclabOriginLocator;
> +
> +/* Custom struct used to consolidate SCLAB overhead */
> +typedef struct SecureIplSclabInfo {
> +    int count;
> +    int global_count;
> +    int signed_count;
> +    int unsigned_count;
> +    uint64_t global_load_psw;
> +    uint16_t global_flags;
> +} SecureIplSclabInfo;
> +
>   /* Custom struct for secure IPL component entry information */
>   typedef struct SecureIplCompEntryInfo {
>       uint64_t addr;
>       uint64_t len;
> +    uint32_t cei;
>       uint16_t cert_index;
>       uint8_t  flags;
>   } SecureIplCompEntryInfo;
> @@ -50,6 +87,18 @@ static inline void zipl_secure_handle(const char *message)
>       }
>   }
>   
> +static inline uint32_t validate_comp_condition(bool condition, uint32_t flag,
> +                                               const char *message)
> +
> +{
> +    if (condition) {
> +        return 0;
> +    }
> +
> +    zipl_secure_handle(message);
> +    return flag;
> +}
> +
>   static inline uint64_t diag320(void *data, unsigned long subcode)
>   {
>       register unsigned long addr asm("0") = (unsigned long)data;

Regards,
Jared Rossi

