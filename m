Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED09CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4sp-0000jT-FT; Fri, 29 May 2026 17:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wT4sm-0000ZP-NU; Fri, 29 May 2026 17:36:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wT4sj-0003lt-ED; Fri, 29 May 2026 17:36:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TKiXg41468544; Fri, 29 May 2026 21:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IyoU64
 4D9a0aDDj9k47ynf5+5dw34pm6PRh3LPmq+do=; b=BFeh1T+sOBC/8+Rkm1Qkm2
 zpw17N8N8O3Og/PgnfZHKqH5IamVHFi/oGbVfzQ1SsIDfKBrc9PbUS1bojCScNdQ
 3RlpXRcY9Xo56JVT7xw1pf/ma+hFHFau9OblOcZeXQwnfodNmaw344p9GclNp3Dv
 rAugEjJYWgyr6ZCotpb1lIKLrMhZQSY6dWYoQ4DNRfXdAjEhm2fy+w/4nk1akpuK
 kceLW+7Fha4+7Sw0P7HAOS6N6APm0amMZhz1f3a9Ram+XJCPUFG2HyK3cBR43tP8
 q0Z/nU0Azg7a4ZJnnS9Nt+JGz7GAuqXiPzyOj0fUb250Ske+p6UrVDs26Es79/HQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886rpr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2026 21:36:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TLO9Do016817;
 Fri, 29 May 2026 21:36:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrcak5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2026 21:36:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64TLaXtx24773300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2026 21:36:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4304D5805C;
 Fri, 29 May 2026 21:36:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 282165805A;
 Fri, 29 May 2026 21:36:32 +0000 (GMT)
Received: from [9.67.138.50] (unknown [9.67.138.50])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 29 May 2026 21:36:32 +0000 (GMT)
Message-ID: <b5162186-d837-4e3d-ae9b-3fe9ea2c4385@linux.ibm.com>
Date: Fri, 29 May 2026 17:36:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 24/32] pc-bios/s390-ccw: Add additional security
 checks for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-25-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PE-fUvQxhtmeQU_cNT6--ZgppWQVqg1z
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a1a06e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YGMwIM37LgBmNbVkSW8A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxNSBTYWx0ZWRfX8n15ASkzndwr
 nqr9KEZDOTOFRWwj9iXjYo5Jof0M+pqhV8WiJ1Uqk/ACuKnJJiei5/Yg81JbrP1TdApZGIvIQ+O
 lfsKMj1ntYc1K0RQECyZIfqj4BxWEqTkhwtq1ThATacc9yZly038Z6cJaf19qa6JNi2B3ftxDtB
 07n8NjxPiqiHiaDBJg9Oa9sWIzghz4xp1C1BBw9h1hPNktZ3ANyjCvcXooGDVLaM8jXKBmRt+qi
 0lzXzTKUf+4lOLpro2mUEtFoYVY60xH0TO5gRvzk6sJx+poydkjzyIJn8a1cJcs/XIOKDuJK5hj
 k5t5sHj7hRVaBiDjSVF+dNG7pHdrzMO+wjIEAKTX7DGfMNzBoXd+7dC5XllETqcTt614f2D81As
 tUhef22jcNWvvo477ueZ9Xu1f5KPyBz8k+bwvJ/Ai/sAN8S6mcbov47f7TGON5k9UB09Sj6WOtr
 wxqK5IXzcPvSXrM+w2g==
X-Proofpoint-ORIG-GUID: PE-fUvQxhtmeQU_cNT6--ZgppWQVqg1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290215
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/5/26 16:18, Zhuoying Cai wrote:
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
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

You've done an awesome job at cleaning up the large list of parameters
passed to some functions, and I think it's bringing to light some
cleaner approaches to the SCLAF code.

Here's what I'm thinking:
 - process each SCLAB at the same time a component is processed (already
done here)
 - Use a SclaBlock global_sclab variable to hold on to the global SCLAB
(instead of using an info struct)
 - Once all components are processed, then check_global_sclab (already
done here)
 - While checking the global SCLAB, iterate through the component list
to tally the signed / unsigned counts (by checking the component flags)
and set errors depending on the SCLAB flags.

This will get rid of the SecureIplSclabInfo struct and the signed /
unsigned counter fields can be contained within the scope of the
check_global_sclab function.

> ---
>  include/hw/s390x/ipl/qipl.h   |  29 ++++-
>  pc-bios/s390-ccw/sclp.h       |   1 +
>  pc-bios/s390-ccw/secure-ipl.c | 210 +++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/secure-ipl.h |  62 ++++++++++
>  4 files changed, 296 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index a2180719b1..2a3ae6b9f5 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -167,10 +167,20 @@ struct IplInfoReportBlockHeader {
>  };
>  typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
>  
> +/* IPL Info Error Indicators */
> +#define S390_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
> +#define S390_IIEI_NO_SCLAB            0x4000 /* bit 1 */
> +#define S390_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
> +#define S390_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
> +#define S390_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
> +#define S390_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
> +
>  struct IplInfoBlockHeader {
>      uint32_t len;
>      uint8_t  type;
> -    uint8_t  reserved1[11];
> +    uint8_t  reserved1[3];
> +    uint16_t iiei;
> +    uint8_t  reserved2[6];
>  };
>  typedef struct IplInfoBlockHeader IplInfoBlockHeader;
>  
> @@ -194,13 +204,28 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
>  #define S390_IPL_DEV_COMP_FLAG_SC  0x80
>  #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
>  
> +/* IPL Device Component Error Indicators */
> +#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
> +#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
> +#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
> +#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
> +#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB   0x2000000  /* bit 6 */
> +#define S390_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
> +#define S390_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
> +#define S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
> +#define S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
> +#define S390_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
> +
>  struct IplDeviceComponentEntry {
>      uint64_t addr;
>      uint64_t len;
>      uint8_t  flags;
>      uint8_t  reserved1[5];
>      uint16_t cert_index;
> -    uint8_t  reserved2[8];
> +    uint32_t cei;
> +    uint8_t  reserved2[4];
>  };
>  typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
>  
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index a8a41cd004..cae65b29b5 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>  #define SCCB_FAC134_DIAG320_BIT 0x4
>  #define SCCB_FAC_IPL_SIPL_BIT   0x4000
> +#define SCCB_FAC_IPL_SCLAF_BIT  0x1000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index fdac74aa97..9c992149ee 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -140,6 +140,7 @@ static void comp_list_add(IplDeviceComponentList *comp_list,
>  
>      comp_list->device_entries[comp_entry_idx].addr = comp_entry_info.addr;
>      comp_list->device_entries[comp_entry_idx].len = comp_entry_info.len;
> +    comp_list->device_entries[comp_entry_idx].cei = comp_entry_info.cei;
>      comp_list->device_entries[comp_entry_idx].flags = comp_entry_info.flags;
>      /* cert index field is meaningful only when S390_IPL_DEV_COMP_FLAG_SC is set */
>      if (comp_entry_info.flags & S390_IPL_DEV_COMP_FLAG_SC) {
> @@ -207,6 +208,12 @@ bool secure_ipl_supported(void)
>          return false;
>      }
>  
> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SCLAF_BIT)) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
> +             " the hypervisor!");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -265,6 +272,179 @@ static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
>      range_list->num += 1;
>  }
>  
> +static void check_sclab_opsw(SclaBlock *sclab, SecureIplSclabInfo *sclab_info,
> +                             uint32_t *cei_flags)
> +{
> +    if (!(sclab->flags & S390_SCLAB_OPSW)) {
> +        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
> +        zipl_secure_validate(sclab->load_psw == 0, cei_flags,
> +                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
> +                             "Load PSW is not zero when Override PSW bit is zero");
> +    } else {
> +        /* OPSW = 1 indicating global SCLAB */
> +        sclab_info->global_count += 1;
> +        if (sclab_info->global_count == 1) {
> +            sclab_info->global_load_psw = sclab->load_psw;
> +            sclab_info->global_flags = sclab->flags;
> +        }
> +
> +        /* override load address flag must set to one */
> +        zipl_secure_validate(sclab->flags & S390_SCLAB_OLA, cei_flags,
> +                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
> +                             "OLA flag is not set to one in the global SCLAB");
> +    }
> +}
> +
> +static void check_sclab_ola(SclaBlock *sclab, uint64_t load_addr, uint32_t *cei_flags)
> +{
> +    if (!(sclab->flags & S390_SCLAB_OLA)) {
> +        /* OLA = 0 - Load address field in SCLAB must contain zeros */
> +        zipl_secure_validate(sclab->load_addr == 0, cei_flags,
> +                             S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
> +                             "Load Address is not zero when OLA flag is zero");
> +    } else {
> +        /* OLA = 1 - Load address field must match storage address of the component */
> +        zipl_secure_validate(sclab->load_addr == load_addr, cei_flags,
> +                             S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
> +                             "Load Address does not match with component load address");
> +    }
> +}
> +
> +static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRangeList *range_list)
> +{
> +    uint32_t addr = psw & 0x7fffffff;
> +
> +    /* PSW points within a signed binary code component */
> +    for (int i = 0; i < range_list->num; i++) {
> +        if (range_list->comp_addr_range[i].is_signed &&
> +            addr >= range_list->comp_addr_range[i].start_addr &&
> +            addr <= range_list->comp_addr_range[i].end_addr - 2) {
> +            return true;
> +       }
> +    }
> +    return false;
> +}

This function is very similar to check_comp_overlap. I suggest making a
single "check_overlap" or "intersect" function (the latter mirrors the
naming scheme in the kernel) to combine their functionality and then
have their callers handle the outcome.

e.g. the if function will return true if there is an overlap/intersect.
For components, caller will true it as an error.  For the PSW check, the
caller will treat true as success.

> +
> +static void check_load_psw(SecureIplCompAddrRangeList *range_list,
> +                           uint64_t sclab_load_psw,
> +                           SecureIplCompEntryInfo *comp_entry_info)
> +{
> +    uint64_t load_psw;
> +
> +    load_psw = comp_entry_info->addr;
> +    zipl_secure_validate(is_psw_valid(sclab_load_psw, range_list) &&
> +                         is_psw_valid(load_psw, range_list),
> +                         &comp_entry_info->cei, S390_CEI_INVALID_LOAD_PSW, "Invalid PSW");
> +
> +    /* compare load PSW with the PSW specified in component */
> +    zipl_secure_validate(sclab_load_psw == load_psw, &comp_entry_info->cei,
> +                         S390_CEI_UNMATCHED_SCLAB_LOAD_PSW,
> +                         "Load PSW does not match with PSW in component");
> +}
> +
> +static void check_no_unsigned_comp(SecureIplSclabInfo sclab_info,
> +                                   IplDeviceComponentList *comp_list)
> +{
> +    bool is_nuc_set;
> +
> +    is_nuc_set = sclab_info.global_flags & S390_SCLAB_NUC;
> +    if (is_nuc_set && sclab_info.unsigned_count > 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_FOUND_UNSIGNED_COMP;
> +        zipl_secure_error("Unsigned components are not allowed");
> +    }
> +}
> +
> +static void check_single_comp(SecureIplSclabInfo sclab_info,
> +                              IplDeviceComponentList *comp_list)
> +{
> +    bool is_sc_set;
> +
> +    is_sc_set = sclab_info.global_flags & S390_SCLAB_SC;
> +    if (is_sc_set &&
> +        sclab_info.signed_count != 1 &&
> +        sclab_info.unsigned_count >= 0) {

Does the unsigned count matter here?

> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_SIGNED_COMP;
> +        zipl_secure_error("Only one signed component is allowed");
> +    }
> +}

For both functions check_no_unsigned_comp and check_single_comp, could a
zipl_secure_validate be used instead?

> +
> +void check_global_sclab(SecureIplSclabInfo sclab_info,
> +                        IplDeviceComponentList *comp_list)

Pass this a SclaBlock global_sclab (which should've been assigned by a
subsequent call to check_sclab -- see below), and the
IplDeviceComponentList *comp_list.  Iterate through the list and check
each comp.flags for signed and unsigned components, and check PSW validity.

> +{
> +    if (sclab_info.count == 0) {
> +        return;
> +    }

Is this check needed here? zipl_secure_validate(sclab_info.count > 0,
...) is called before this function anyway.

> +
> +    if (sclab_info.global_count == 0) {

Would be: if (!global_sclab)

> +        comp_list->ipl_info_header.iiei |= S390_IIEI_NO_GLOBAL_SCLAB;
> +        zipl_secure_error("Global SCLAB does not exists");
> +        return;
> +    }
> +
> +    if (sclab_info.global_count > 1) {

This check should happen earlier in check_sclab() (see below).

> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
> +        zipl_secure_error("More than one global SCLAB");
> +        return;
> +    }
> +
> +    if (sclab_info.global_flags) {
> +        /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
> +        check_no_unsigned_comp(sclab_info, comp_list);
> +
> +        /* Only one signed component is allowed is SC flag is set in the global SCLAB */
> +        check_single_comp(sclab_info, comp_list);

Move both function bodies to here, they're small enough and it'll be
easier to read (the comments are helpful)

> +    }
> +}
> +
> +static void check_sclab(SecureIplCompEntryInfo *comp_entry_info,
> +                        SecureIplSclabInfo *sclab_info)
> +{

Pass this a SclaBlock global_sclab.  When the OPSW is set, check if
!global_sclab, set global_sclab = sclab; else, set iiei.

The global_sclab is later passed to check_global_sclab().

You might need to pass this function the comp entry (to locate
sclab and set cei) and the header (to set iiei)... this assumes
SecureIplCompEntryInfo goes away as suggested in a previous patch.

> +    SclabOriginLocator *sclab_locator;
> +    SclaBlock *sclab;
> +
> +    /* sclab locator is located at the last 8 bytes of the signed comp */
> +    sclab_locator = (SclabOriginLocator *)(comp_entry_info->addr +
> +                                           comp_entry_info->len - 8);
> +
> +    /* return early if sclab does not exist */
> +    zipl_secure_validate(magic_match(sclab_locator->magic, ZIPL_MAGIC),
> +                         &comp_entry_info->cei, S390_CEI_INVALID_SCLAB,
> +                         "Magic does not match. SCLAB does not exist");
> +
> +    if (comp_entry_info->cei & S390_CEI_INVALID_SCLAB) {
> +        return;
> +    }
> +
> +    zipl_secure_validate(sclab_locator->len >= S390_SCLAB_MIN_LEN, &comp_entry_info->cei,
> +                         S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
> +                         "Invalid SCLAB length");
> +
> +    /* return early if sclab is invalid */
> +    if (comp_entry_info->cei & S390_CEI_INVALID_SCLAB) {
> +        return;
> +    }
> +
> +    sclab_info->count += 1;
> +    sclab = (SclaBlock *)(comp_entry_info->addr + comp_entry_info->len -
> +                          sclab_locator->len);
> +
> +    zipl_secure_validate(sclab->format == 0, &comp_entry_info->cei,
> +                         S390_CEI_INVALID_SCLAB_FORMAT,
> +                         "Format-0 SCLAB is not being used");
> +
> +    check_sclab_opsw(sclab, sclab_info, &comp_entry_info->cei);
> +    check_sclab_ola(sclab, comp_entry_info->addr, &comp_entry_info->cei);

Both check_sclab_opsw() and check_sclab_ola() function bodies can just
be put in here.  They're small enough and visually similar (check flag,
then zipl_secure_validate()).  Would be more readable to see all sclab
checking code in one view.

> +
> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_NUC || sclab->flags & S390_SCLAB_OPSW,
> +                         &comp_entry_info->cei, S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB,
> +                         "NUC bit is set, but not in the global SCLAB");
> +
> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_SC || sclab->flags & S390_SCLAB_OPSW,
> +                         &comp_entry_info->cei, S390_CEI_SC_NOT_IN_GLOBAL_SCLAB,
> +                         "SC bit is set, but not in the global SCLAB");
> +
> +}
> +
>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>  {
>      if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> @@ -307,7 +487,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>       */
>      int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>      SecureIplCompAddrRangeList range_list = { 0 };
> -    int signed_count = 0;
> +    SecureIplSclabInfo sclab_info = { 0 };
>  
>      init_lists(&comp_list, &cert_list);
>      cert_buf = malloc(get_total_certs_length());
> @@ -343,6 +523,13 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>  
>              /* no signature present (unsigned component) */
>              if (!sig_entry_info.len) {
> +                zipl_secure_validate(comp_entry_info.addr >= S390_UNSIGNED_MIN_ADDR,
> +                                     &comp_entry_info.cei, S390_CEI_INVALID_UNSIGNED_ADDR,
> +                                     "Load address is less than 0x2000");

"Load address for unsigned component is less than 0x2000"

> +
> +                comp_list_add(&comp_list, comp_entry_info);

Thinking about it... back in patch 21, shouldn't unsigned components be
added to the list?

> +
> +                sclab_info.unsigned_count += 1;
>                  break;
>              }
>  
> @@ -352,6 +539,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>               */
>              comp_entry_info.flags = S390_IPL_DEV_COMP_FLAG_SC;
>  
> +            check_sclab(&comp_entry_info, &sclab_info);
>              verified = verify_signature(comp_entry_info, sig_entry_info,
>                                          &cert_len, &cert_table_idx);
>  
> @@ -378,7 +566,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>  
>              comp_list_add(&comp_list, comp_entry_info);
>  
> -            signed_count += 1;
> +            sclab_info.signed_count += 1;
>              /* After a signature is used another new one can be accepted */
>              sig_entry_info.len = 0;
>              break;
> @@ -395,10 +583,24 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>          }
>      }
>  
> -    if (signed_count == 0) {
> -        zipl_secure_error("Secure boot is on, but components are not signed");
> +    /* validate load PSW with PSW specified in the final entry */
> +    if (sclab_info.global_load_psw) {
> +        comp_entry_info = (SecureIplCompEntryInfo){ 0 };
> +        comp_entry_info.addr = entry->compdat.load_psw;
> +
> +        check_load_psw(&range_list, sclab_info.global_load_psw, &comp_entry_info);
> +        comp_list_add(&comp_list, comp_entry_info);
>      }

This check could be done inside check_global_sclab() with the changes
mentioned above.  While iterating through the comp_list checking for
flags, you can also check PSW validity.

>  
> +    zipl_secure_validate(sclab_info.signed_count > 0,
> +                         &comp_list.ipl_info_header.iiei, S390_IIEI_NO_SIGNED_COMP,
> +                         "Secure boot is on, but components are not signed");
> +
> +    zipl_secure_validate(sclab_info.count > 0, &comp_list.ipl_info_header.iiei,
> +                         S390_IIEI_NO_SCLAB, "No recognizable SCLAB");

Both of these iiei flags could be set near the start of
zipl_run_secure() (which is technically true since no SCLABs or signed
comps have been found at that point in time).  Then, when the first
valid SCLAB or signed comp is found, clear the respective flag.

At the end of this function, check if those flags are still set
and call zipl_secure_error().

That will help justify getting rid of the counter fields.

> +
> +    check_global_sclab(sclab_info, &comp_list);
> +
>      update_iirb(&comp_list, &cert_list);
>  
>      *entry_ptr = entry;
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 29bbf65c6c..950cd45b3c 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -16,10 +16,48 @@
>  VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>  int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>  
> +#define S390_SCLAB_OPSW    0x8000   /* override PSW flag */
> +#define S390_SCLAB_OLA     0x4000   /* override load address flag */
> +#define S390_SCLAB_NUC     0x2000   /* no unsigned components flag */
> +#define S390_SCLAB_SC      0x1000   /* single component flag */
> +
> +#define S390_SCLAB_MIN_LEN      32
> +#define S390_UNSIGNED_MIN_ADDR  0x2000
> +
> +/* Secure Code Loading Attributes Block */
> +struct SclaBlock {
> +    uint8_t  format;
> +    uint8_t  reserved1;
> +    uint16_t flags;
> +    uint8_t  reserved2[4];
> +    uint64_t load_psw;
> +    uint64_t load_addr;
> +    uint64_t reserved3[];
> +} __attribute__ ((packed));
> +typedef struct SclaBlock SclaBlock;
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

I think with the suggestions above, this struct should no longer be
needed.  The global fields can be handled by tracking a special
SclaBlock global_sclab.  The signed/unsigned counts can be tallied by
iterating through the comp list.  Global count can be checked by
global_sclab != NULL.

Count might be able to go away too (see above).

> +
>  /* Custom struct for secure IPL component entry information */
>  typedef struct SecureIplCompEntryInfo {
>      uint64_t addr;
>      uint64_t len;
> +    uint32_t cei;
>      uint16_t cert_index;
>      uint8_t  flags;
>  } SecureIplCompEntryInfo;
> @@ -50,6 +88,30 @@ static inline void zipl_secure_error(const char *message)
>      }
>  }
>  
> +static inline void zipl_secure_validate_u16(bool condition, uint16_t *flags,
> +                                            uint16_t flag, const char *message)
> +{
> +    if (!condition) {
> +        *flags |= flag;
> +        zipl_secure_error(message);
> +    }
> +}
> +
> +static inline void zipl_secure_validate_u32(bool condition, uint32_t *flags,
> +                                            uint32_t flag, const char *message)
> +{
> +    if (!condition) {
> +        *flags |= flag;
> +        zipl_secure_error(message);
> +    }
> +}
> +
> +#define zipl_secure_validate(condition, flags, flag, message)   \
> +    _Generic((flags),                                           \
> +        uint16_t * : zipl_secure_validate_u16,                  \
> +        uint32_t * : zipl_secure_validate_u32                   \
> +    )(condition, flags, flag, message)
> +

This is MUCH better! :)

>  static inline uint64_t _diag320(void *data, unsigned long subcode)
>  {
>      register unsigned long addr asm("0") = (unsigned long)data;

With the suggestions above, most (if not all) SCLAF-related code should
be contained to the check_sclab and check_global_sclab functions and
less overhead managed in zipl_secure_run, which will make this a LOT
easier to visually parse.

Hopefully I'm not missing a major design flaw in this thinking.  Please
let me know if the suggestions are not feasible.

-- 
Regards,
  Collin

