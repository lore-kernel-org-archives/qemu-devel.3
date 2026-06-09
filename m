Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BFACD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWycm-0008AE-Bi; Tue, 09 Jun 2026 11:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wWyck-00089g-Dy; Tue, 09 Jun 2026 11:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wWych-0001Sy-Cr; Tue, 09 Jun 2026 11:44:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6595ehIE2843554; Tue, 9 Jun 2026 15:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=64sp+0
 OuuzUNDiXTlTkfpeazuHZ91VeaXxCN+cn/8KQ=; b=Z8m1/GFyVBk7j36ROwJ3F0
 qeEG0F7GQ2glhJK7o3XdOxJwdXzgW/E4/Advwn0eMLatSraTJrFnurIPQ0Zx8w/k
 un+HLBde1202Q9uJRnQ6oR8/C0EV/yVyEIQ2cLSgtiSouGlqxS84k+WSGvEJtTGd
 +ZlhMRGrWUzbuLRs+L7ml3uYlYveGKJkgelVyFb7wtx5QszLFaMo3V+S+aGLUIT0
 zog4Dbmbt+Q5RHuFE+9+l24hTRo40yVxmvDPpGZaG3aIAoOBkCjJSmQGvD2gpfCf
 Jqej71qRK8jGbD0P4MemMYsSEr6yispksoazKBrFNO0cIuDkFz3VmS9hEv5V67bA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95cyd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 15:44:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659FYdXR001786;
 Tue, 9 Jun 2026 15:44:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w2sdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 15:44:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659Fi7Aa13107930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 15:44:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC51658056;
 Tue,  9 Jun 2026 15:44:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9DC95803F;
 Tue,  9 Jun 2026 15:44:05 +0000 (GMT)
Received: from [9.61.111.145] (unknown [9.61.111.145])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 15:44:05 +0000 (GMT)
Message-ID: <251df87f-e0d5-4897-94ce-34dbf3dadf53@linux.ibm.com>
Date: Tue, 9 Jun 2026 11:44:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-22-zycai@linux.ibm.com>
 <632db3ab-408a-4d0c-b8ce-be6d52bb9cad@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <632db3ab-408a-4d0c-b8ce-be6d52bb9cad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a2834c9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=A1-YhR8KWZWd19V_3qoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oZIAhaqyF05keP1eFPr8mjFmJfbPP7-A
X-Proofpoint-GUID: oZIAhaqyF05keP1eFPr8mjFmJfbPP7-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OCBTYWx0ZWRfX4zisS1e2FaO+
 2T8HZyNEKUqywGJAbgccnLZ8ggTPoRaWIMaFYgM7dbXOMJZmYjMRvQFwIVN1EsBOQmSuyfK7nk1
 bEyCEfKNSst3A1NPFVhHvJF7eVmnqcqrQAjMHZQgEeFJ91+iiCK7Yts2OsRWj5AOnjkeodq1DSV
 JIFGgPFJ+ZmmsKpZEWmAjJ2lA/FM2KJTKW/mtHgccfwaUvCGfO0xMswDQYrA+Wt9+/nwnQy+6WI
 BHOcPhrUW7r56gFpJOO584mYgBjuwQYOPDX/32VDjTF524kZVJxRd1QZX9fZ2QuvEOxy6IedjOR
 SWBndDD1Jhn6A2sAIxsrRVm6LZANwPRxTQ3jQxcQExlPVuduI6QH4kXLHypUCEGZhkc+PBKmk/Z
 vFiMo+Fx1jNqtp9AE7HANj3zzfvsNw3NXhUf3YtVrxQCA+mUp9w1PmpqCmSLYXZAvEzAQghslx6
 HY2EiXb2qgJ1dvEvI6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Thanks for the feedback and suggestion!

On 6/1/26 4:24 PM, Jared Rossi wrote:
> 
> 
> On 5/5/26 4:18 PM, Zhuoying Cai wrote:
>> Enable secure IPL in audit mode, which performs signature verification,
>> but any error does not terminate the boot process. Only warnings will be
>> logged to the console instead.
>>
>> Add a comp_len variable to store the length of a segment in
>> zipl_load_segment. comp_len variable is necessary to store the
>> calculated segment length and is used during signature verification.
>> Return the length on success, or a negative return code on failure.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities (Secure IPL Facility,
>> Certificate Store Facility and secure IPL extension support).
>>
>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst |  15 ++
>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>   pc-bios/s390-ccw/bootmap.c       |  16 ++
>>   pc-bios/s390-ccw/bootmap.h       |   9 +
>>   pc-bios/s390-ccw/main.c          |  10 +-
>>   pc-bios/s390-ccw/s390-ccw.h      |  24 ++
>>   pc-bios/s390-ccw/sclp.c          |  27 +++
>>   pc-bios/s390-ccw/sclp.h          |   6 +
>>   pc-bios/s390-ccw/secure-ipl.c    | 364 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h    | 113 ++++++++++
>>   10 files changed, 584 insertions(+), 2 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>

[...]

>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> new file mode 100644
>> index 0000000000..6e943446a7
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -0,0 +1,364 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
>> + * signature verification, and certificate handling).
>> + *
>> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
>> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include "bootmap.h"
>> +#include "s390-ccw.h"
>> +#include "sclp.h"
>> +#include "secure-ipl.h"
>> +
>> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
>> +{
>> +    /* avoid retrieving vcssb multiple times */
>> +    if (vcssb.length == VCSSB_MIN_LEN) {
>> +        return &vcssb;
>> +    }
> I don't quite understand what is happening with the VCSSB_MIN_LENGTH 
> here.  Why
> is the minimum length significant, as opposed to simply non-zero?
> 

VCSSB must be set to VCSSB_MIN_LENGTH (128), as this represents the size
of the VCSSB struct and indicates that it is present. Any other value
would be considered an invalid length for VCSSB.

To avoid confusion, we could consider renaming VCSSB_MIN_LENGTH to
VCSSB_LEN.

>> +
>> +    vcssb.length = VCSSB_MIN_LEN;
>> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
>> +        vcssb.length = 0;
>> +        return NULL;
>> +    }
>> +
>> +    return &vcssb;
>> +}
>> +
>> +static uint32_t get_total_certs_length(void)
>> +{
>> +    if (zipl_secure_get_vcssb() == NULL) {
>> +        return 0;
>> +    }
> Should we check if vcssb.len == 4 for the early return?  I think it 
> designates
> an empty cert store and nothing else gets initialized.
> 

Yes, this check is currently in [PATCH v11 27/32] pc-bios/s390-ccw:
Handle true secure IPL mode. I’ll refactor it so it can be performed
earlier during the secure boot process.

>> +
>> +    return vcssb.total_vcb_len - sizeof(VCBlockHeader) -
>> +           vcssb.total_vc_ct * sizeof(VCEntryHeader);
>> +}
>> +
>> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
>> +{
>> +    VCEntryHeader *vce_hdr;
>> +    struct vcb {
>> +        VCBlockHeader vcb_hdr;
>> +        struct vce {
>> +            VCEntryHeader vce_hdr;
>> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
>> +        } vce;
>> +    } __attribute__((__aligned__(4096))) vcb = { 0 };
> Regarding Collin's comments about using CERT_BUF_MAX_LEN versus 
> vcssb.max_single_vcb_len,
> because the VCB must be 4k aligned we didn't want to malloc a variable 
> length
> buffer, which is why the constant max was used.  AFAIK malloc cannot enforce
> any alignment requirements and we do not have the libraries for memalign 
> in BIOS.
> 
> I thought I saw that the cert store does already reject certs exceeding 
> this size,
> but if not, I agree with Collin that it should.
> 

Maybe we could use vcssb.max_single_vcb_len - sizeof(VCBlockHeader) -
sizeof(VCEntryHeader) instead of CERT_BUF_MAX_LEN when sizing cert_buf.

The cert store already rejects anything larger than CERT_BUF_MAX_LEN, so
the requested size is guaranteed to stay within bounds.

Since vcssb.max_single_vcb_len is also used as the input length for the
VCB, basing cert_buf on it would make the buffer size more accurate.

Does this sound reasonable to you?

>> +
>> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
>> +    if (zipl_secure_get_vcssb() == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Request single entry
>> +     * Fill input fields of single-entry VCB
>> +     *
>> +     * First and last index must be equal because only one
>> +     * VCE per VCB is currently supported
>> +     */
>> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
>> +    vcb.vcb_hdr.first_vc_index = index;
>> +    vcb.vcb_hdr.last_vc_index = index;
>> +
>> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
>> +        return 0;
>> +    }
>> +
>> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
>> +        puts("No certificate entry");
>> +        return 0;
>> +    }
>> +
>> +    if (vcb.vcb_hdr.remain_ct != 0) {
>> +        panic("Not enough memory to store all requested certificates");
>> +    }
>> +
>> +    vce_hdr = &vcb.vce.vce_hdr;
>> +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
>> +        puts("Invalid certificate");
>> +        return 0;
>> +    }
>> +
>> +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr->cert_len);
>> +
>> +    return vce_hdr->cert_len;
>> +}
>> +
>> +static int cert_list_add(IplSignatureCertificateList *cert_list,
>> +                         uint8_t *cert_buf, uint64_t cert_len)
>> +{
>> +    static bool warned;
>> +    int cert_entry_idx;
>> +
>> +    cert_entry_idx = (cert_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
>> +                     sizeof(IplSignatureCertificateEntry);
>> +    if (cert_entry_idx > MAX_CERTIFICATES - 1) {
> I think this is actually impossible because we terminate the IPL when 
> building
> the cert store if there are too many entries, right?
> 
>> +        if (!warned) {
>> +            printf("Warning: only %d cert entries are supported;"
>> +                   " additional entries are ignored\n",
>> +                   MAX_CERTIFICATES);
>> +            warned = true;
>> +        }
>> +        return cert_entry_idx;
>> +    }
>> +
>> +    cert_list->cert_entries[cert_entry_idx].addr = (uint64_t)cert_buf;
>> +    cert_list->cert_entries[cert_entry_idx].len = cert_len;
>> +    cert_list->ipl_info_header.len += sizeof(IplSignatureCertificateEntry);
>> +
>> +    return cert_entry_idx;
>> +}
>> +
>> +static void comp_list_add(IplDeviceComponentList *comp_list,
>> +                          SecureIplCompEntryInfo comp_entry_info)
>> +{
>> +    int comp_entry_idx;
>> +
>> +    comp_entry_idx = (comp_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
>> +                     sizeof(IplDeviceComponentEntry);
>> +    if (comp_entry_idx > MAX_COMP_ENTRIES - 1) {
>> +        printf("Warning: only %d component entries are supported\n",
>> +                MAX_COMP_ENTRIES);
>> +        panic("The device component list has reached its maximum capacity");
>> +    }
>> +
>> +    comp_list->device_entries[comp_entry_idx].addr = comp_entry_info.addr;
>> +    comp_list->device_entries[comp_entry_idx].len = comp_entry_info.len;
>> +    comp_list->device_entries[comp_entry_idx].flags = comp_entry_info.flags;
>> +    /* cert index field is meaningful only when S390_IPL_DEV_COMP_FLAG_SC is set */
>> +    if (comp_entry_info.flags & S390_IPL_DEV_COMP_FLAG_SC) {
>> +        comp_list->device_entries[comp_entry_idx].cert_index =
>> +                                                  comp_entry_info.cert_index;
>> +    }
>> +    comp_list->ipl_info_header.len += sizeof(IplDeviceComponentEntry);
>> +}
>> +
>> +static void update_iirb(IplDeviceComponentList *comp_list,
>> +                        IplSignatureCertificateList *cert_list)
>> +{
>> +    IplInfoReportBlock *iirb;
>> +    IplDeviceComponentList *iirb_comps;
>> +    IplSignatureCertificateList *iirb_certs;
>> +    uint32_t iirb_hdr_len;
>> +    uint32_t comps_len;
>> +    uint32_t certs_len;
>> +
>> +    if (iplb->len % 8 != 0) {
>> +        panic("IPL parameter block length field value is not multiple of 8 bytes");
>> +    }
>> +
>> +    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
>> +    comps_len = comp_list->ipl_info_header.len;
>> +    certs_len = cert_list->ipl_info_header.len;
>> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
>> +        panic("Not enough space to hold all components and certificates in IIRB");
>> +    }
>> +
>> +    /* IIRB immediately follows IPLB */
>> +    iirb = &ipl_data.iirb;
>> +    iirb->hdr.len = iirb_hdr_len;
>> +
>> +    /* Copy IPL device component list after IIRB Header */
>> +    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
>> +    memcpy(iirb_comps, comp_list, comps_len);
>> +
>> +    /* Update IIRB length */
>> +    iirb->hdr.len += comps_len;
>> +
>> +    /* Copy IPL sig cert list after IPL device component list */
>> +    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
>> +                                                  iirb_comps->ipl_info_header.len);
>> +    memcpy(iirb_certs, cert_list, certs_len);
>> +
>> +    /* Update IIRB length */
>> +    iirb->hdr.len += certs_len;
>> +}
>> +
>> +bool secure_ipl_supported(void)
>> +{
>> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SIPL_BIT)) {
>> +        puts("Secure IPL Facility is not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    if (!is_signature_verif_supported()) {
>> +        puts("Secure IPL extensions are not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    if (!is_cert_store_facility_supported()) {
>> +        puts("Certificate Store Facility is not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void init_lists(IplDeviceComponentList *comp_list,
>> +                       IplSignatureCertificateList *cert_list)
>> +{
>> +    comp_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_COMPONENTS;
>> +    comp_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
>> +
>> +    cert_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_CERTIFICATES;
>> +    cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
>> +}
>> +
>> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>> +{
>> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> +        puts("Signature is not in DER format");
>> +        return -1;
>> +    }
>> +
>> +    if (zipl_load_segment(entry->data.blockno, sig) < 0) {
>> +        return -1;
>> +    }
>> +
>> +    return entry->compdat.sig_info.sig_len;
>> +}
>> +
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comp_list = { 0 };
>> +    IplSignatureCertificateList cert_list = { 0 };
>> +    SecureIplCompEntryInfo sig_entry_info = { 0 };
>> +    SecureIplCompEntryInfo comp_entry_info;
>> +    ComponentEntry *entry = *entry_ptr;
>> +    uint8_t *cert_buf = NULL;
>> +    int sig_len = 0;
>> +    int comp_len;
>> +    int cert_entry_idx;
>> +    uint64_t comp_addr;
>> +    uint64_t cert_len;
>> +    uint8_t cert_table_idx;
>> +    bool verified;
>> +    /*
>> +     * Keep track of which certificate store indices correspond to the
>> +     * certificate data entries within the IplSignatureCertificateList to
>> +     * prevent allocating space for the same certificate multiple times.
>> +     *
>> +     * The array index corresponds to the certificate's cert-store index.
>> +     *
>> +     * The array value corresponds to the certificate's entry within the
>> +     * IplSignatureCertificateList (with a value of -1 denoting no entry
>> +     * exists for the certificate).
>> +     */
>> +    int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>> +    int signed_count = 0;
>> +
>> +    init_lists(&comp_list, &cert_list);
>> +    cert_buf = malloc(get_total_certs_length());
>> +    sig_entry_info.addr = (uint64_t)malloc(MAX_SECTOR_SIZE);
> I think we can reduce the memory footprint significantly, which will 
> also help
> with designating a safe spot for the components if we are worried about them
> getting clobbered or lost.
> 
> Currently cert_buf is allocating enough space for the entire cert store, but
> if I understand correctly, only 2 or possibly 3 certs can be used for 
> any one
> IPL.  So I don't think it is necessary to allocate more than 3x the max cert
> size.
> 
> If we need a well defined place to put them, my first thought would be 
> to use
> the "next_iplb" field of the qipl struct.  This field points to the next 
> IPLB
> to be used when multiple boot devices are specified, but the address 
> itself is
> derived as an offset from the start of the kernel code in memory.
> 
> There are 8 4K pages that can be used for chained IPLBs, but that space 
> is no
> longer needed once we have identified our good IPLB and commit to 
> booting it.
> I think this space can safely be used to store the certs until the kernel
> reads them during boot.
> 
> There might be a few other things that need adjustment, but in principle 
> I think
> writing to the pages previously occupied by an IPLB chain should be viable.
> 
>> +
>> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
>> +        switch (entry->component_type) {
>> +        case ZIPL_COMP_ENTRY_SIGNATURE:
>> +            if (sig_entry_info.len) {
>> +                goto out;
>> +            }
>> +
>> +            sig_len = zipl_load_signature(entry, sig_entry_info.addr);
>> +            if (sig_len < 0) {
>> +                goto out;
>> +            }
>> +
>> +            sig_entry_info.len = sig_len;
>> +            break;
>> +        case ZIPL_COMP_ENTRY_LOAD:
>> +            comp_addr = entry->compdat.load_addr;
>> +            comp_len = zipl_load_segment(entry->data.blockno, comp_addr);
>> +            if (comp_len < 0) {
>> +                goto out;
>> +            }
>> +
>> +            comp_entry_info = (SecureIplCompEntryInfo){ 0 };
>> +            comp_entry_info.addr = comp_addr;
>> +            comp_entry_info.len = (uint64_t)comp_len;
>> +
>> +            /* no signature present (unsigned component) */
>> +            if (!sig_entry_info.len) {
>> +                break;
>> +            }
>> +
>> +            /*
>> +             * Initialize with SC flag (signed component)
>> +             * CSV flag set upon successful verification
>> +             */
>> +            comp_entry_info.flags = S390_IPL_DEV_COMP_FLAG_SC;
>> +
>> +            verified = verify_signature(comp_entry_info, sig_entry_info,
>> +                                        &cert_len, &cert_table_idx);
>> +
>> +            if (verified) {
>> +                if (cert_list_table[cert_table_idx] == -1) {
>> +                    if (!request_certificate(cert_buf, cert_table_idx)) {
>> +                        puts("Could not get certificate");
>> +                        goto out;
>> +                    }
>> +
>> +                    cert_entry_idx = cert_list_add(&cert_list, cert_buf, cert_len);
>> +                    /* map cert-store index to cert-list entry index */
>> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
>> +                    /* increment for the next certificate */
>> +                    cert_buf += cert_len;
>> +                }
>> +
>> +                comp_entry_info.cert_index = cert_list_table[cert_table_idx];
>> +                comp_entry_info.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
>> +                puts("Verified component");
>> +            } else {
>> +                zipl_secure_error("Could not verify component");
>> +            }
>> +
>> +            comp_list_add(&comp_list, comp_entry_info);
>> +
>> +            signed_count += 1;
>> +            /* After a signature is used another new one can be accepted */
>> +            sig_entry_info.len = 0;
>> +            break;
>> +        default:
>> +            puts("Unknown component entry type");
>> +            return -1;
>> +        }
>> +
>> +        entry++;
>> +
>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>> +            puts("Wrong entry value");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    if (signed_count == 0) {
>> +        zipl_secure_error("Secure boot is on, but components are not signed");
>> +    }
>> +
>> +    update_iirb(&comp_list, &cert_list);
>> +
>> +    *entry_ptr = entry;
>> +    free((void *)sig_entry_info.addr);
>> +
>> +    return 0;
>> +out:
>> +    free(cert_buf);
>> +    free((void *)sig_entry_info.addr);
>> +
>> +    return -1;
>> +}
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> new file mode 100644
>> index 0000000000..cc0302f56b
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -0,0 +1,113 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +
>> +#include <diag320.h>
>> +#include <diag508.h>
>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>> +
>> +/* Custom struct for secure IPL component entry information */
>> +typedef struct SecureIplCompEntryInfo {
>> +    uint64_t addr;
>> +    uint64_t len;
>> +    uint16_t cert_index;
>> +    uint8_t  flags;
>> +} SecureIplCompEntryInfo;
>> +
>> +static inline void zipl_secure_error(const char *message)
>> +{
>> +    switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
>> +        printf("AUDIT MODE WARNING: %s\n", message);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>> +static inline uint64_t _diag320(void *data, unsigned long subcode)
>> +{
>> +    register unsigned long addr asm("0") = (unsigned long)data;
>> +    register unsigned long rc asm("1") = 0;
>> +
>> +    asm volatile ("diag %0,%2,0x320\n"
>> +                  : "+d" (addr), "+d" (rc)
>> +                  : "d" (subcode)
>> +                  : "memory", "cc");
>> +    return rc;
>> +}
>> +
>> +static inline bool is_cert_store_facility_supported(void)
>> +{
>> +    uint32_t d320_ism;
>> +
>> +    if (!sclp_is_diag320_on()) {
>> +        return false;
>> +    }
>> +
>> +    if (_diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM) != DIAG_320_RC_OK) {
>> +        return false;
>> +    }
>> +
>> +    return d320_ism & (DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
>> +}
>> +
>> +static inline uint64_t _diag508(void *data, unsigned long subcode)
>> +{
>> +    register unsigned long addr asm("0") = (unsigned long)data;
>> +    register unsigned long rc asm("1") = 0;
>> +
>> +    asm volatile ("diag %0,%2,0x508\n"
>> +                  : "+d" (addr), "+d" (rc)
>> +                  : "d" (subcode)
>> +                  : "memory", "cc");
>> +    return rc;
>> +}
>> +
>> +static inline bool is_signature_verif_supported(void)
>> +{
>> +    uint64_t d508_subcodes;
>> +
>> +    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
>> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
>> +}
>> +
>> +static inline bool verify_signature(SecureIplCompEntryInfo comp_entry_info,
>> +                                    SecureIplCompEntryInfo sig_entry_info,
>> +                                    uint64_t *cert_len, uint8_t *cert_idx)
>> +{
>> +    Diag508SigVerifBlock svb;
>> +
>> +    svb.length = sizeof(Diag508SigVerifBlock);
>> +    svb.version = 0;
>> +    svb.comp_len = comp_entry_info.len;
>> +    svb.comp_addr = comp_entry_info.addr;
>> +    svb.sig_len = sig_entry_info.len;
>> +    svb.sig_addr = sig_entry_info.addr;
>> +
>> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
>> +        *cert_len = svb.cert_len;
>> +        /*
>> +         * DIAG 508 utilizes an index origin of 0 when indexing the cert store.
>> +         * The cert_idx will be used for DIAG 320 data structures, which expects
>> +         * an index origin of 1. Account for the offset here so it's easier to
>> +         * manage later.
>> +         */
>> +        *cert_idx = svb.cert_store_index + 1;
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
> 


