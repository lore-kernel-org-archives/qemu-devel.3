Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ACBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOJu-0005XR-65; Thu, 02 Jul 2026 16:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfOJr-0005WZ-ES; Thu, 02 Jul 2026 16:47:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfOJp-0002L4-5e; Thu, 02 Jul 2026 16:47:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662JIRQt723198; Thu, 2 Jul 2026 20:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KwYIB0
 a9luYC9YjgySomi8O/UOYXEe8m35va+GYDyBs=; b=UYzxrBo3r7cYilFpTLX23g
 Sgxs9nQFkYVS5XahWWhJdRm47lPZrtTZIwLnaQctPhxAReCtVEleBJ5MKgXefZSQ
 ZMUnO/5OZtQivgspikjthDvVRzv84RFuHAKJxQ7GX3wLuVLdal2cxOlwUs5L+L0B
 u1k5E/7KTp4ASb26cTsk8MWdwaM0GImvzjIVpExlkr7RW/dBPEpJCUjUIeOkGJ9V
 FKE2zbgrQrZGbXJjLt52XktlHUQ5M1k3NLKEQTEoCZ/NK9bwr0/0V8mWYk2cwWM5
 BQAWBLPeNAHY4H8pMVsbUdte8Q+Nhs46eMT9MjGSzloJKwbCMLYOTgSGe+yJv05A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgbxss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 20:47:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662KYcdH031116;
 Thu, 2 Jul 2026 20:47:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhnpmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 20:47:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662KlQhe27918898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 20:47:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBA3F58053;
 Thu,  2 Jul 2026 20:47:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20CC058043;
 Thu,  2 Jul 2026 20:47:23 +0000 (GMT)
Received: from [9.61.151.121] (unknown [9.61.151.121])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 20:47:22 +0000 (GMT)
Message-ID: <efefd0a4-e40e-4555-9e1b-5cdd1edb55c5@linux.ibm.com>
Date: Thu, 2 Jul 2026 16:47:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 26/35] pc-bios/s390-ccw: Add additional security
 checks for secure boot
To: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-27-zycai@linux.ibm.com>
 <2648e0272c9a8b9d5c5667a85a303f63b54ecb3a.camel@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <2648e0272c9a8b9d5c5667a85a303f63b54ecb3a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a46ce60 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ZuPAuNYYAqAqPPLlsVkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIxMyBTYWx0ZWRfXw8zjJsFy4Urw
 i3lnMzR/zuBkcwx7GH/lzIiL72hTODpTUqlTBocNdozYJXV62smNRUcwq85SXzmQDNtifE1xTfO
 II9TNxHpW9amy6lTzotQ/JQ8HDVKi1A=
X-Proofpoint-GUID: LaZXV_xjz4ZyUuyFaZp45dQ_4q_vGGVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIxMyBTYWx0ZWRfX2UM4GoiPTk6k
 qWr4TDhvA8kw1ergN8EGzl7/6kOtZZLNlN73oqVbPeYgZsNKrURCSUjwlZdw4L0f5bkTP9tfZ0F
 L8yt70gB3yrPQtex9b9/z5ViOIrEX2LqjhWhp7kOyvqLIacHqi2FbkuamzZVoG6ljmzThEM0vTR
 W+sukZv6GK++VvIRIMyiI+DmHld1D75lk2SnJJxUV5+Nq/pEPiNlIylDJnecwixLPGoctTH9vm0
 kj0jgMo0/N2hlZDwHKQCaYTvs/Tea2MiJ2EY2wslMLHMb3zDDz7sYtVzgV+CA1IIdQbBzJDaMkw
 ACA0yeyxGhCfC2jrtQaLcWKtEZHgJ6hb4PWMMizjiGQfNoa7/xWOage74A8N/x7/NdZsjbk2jpc
 7xaaH0Zz0GVRK/ETOkcge9/GNTSfVX+2+h9gA4c+QU5hiyM+pWCuH6GMvnXuezZbSDIAoAhoClE
 upob6fGFTcpenBXOizA==
X-Proofpoint-ORIG-GUID: LaZXV_xjz4ZyUuyFaZp45dQ_4q_vGGVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020213
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

Thanks for the review!

On 7/2/26 12:08 PM, Eric Farman wrote:
> On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
>> Add additional checks to ensure that components do not overlap with
>> signed components when loaded into memory.
>>
>> Add additional checks to ensure the load addresses of unsigned components
>> are greater than or equal to 0x2000.
>>
>> When the secure IPL code loading attributes facility (SCLAF) is installed,
>> all signed components must contain a secure code loading attributes block
>> (SCLAB).
>>
>> The SCLAB provides further validation of information on where to load the
>> signed binary code from the load device, and where to start the execution
>> of the loaded OS code.
>>
>> When SCLAF is installed, its content must be evaluated during secure IPL.
>>
>> Add IPL Information Error Indicators (IIEI) and Component Error
>> Indicators (CEI) for IPL Information Report Block (IIRB).
>>
>> When SCLAF is installed, additional secure boot checks are performed
>> during zipl and store results of verification into IIRB.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  include/hw/s390x/ipl/qipl.h   |  29 +++++-
>>  pc-bios/s390-ccw/sclp.h       |   1 +
>>  pc-bios/s390-ccw/secure-ipl.c | 170 +++++++++++++++++++++++++++++++++-
>>  pc-bios/s390-ccw/secure-ipl.h |  51 ++++++++++
>>  4 files changed, 246 insertions(+), 5 deletions(-)
>>

[...]

>> +static void check_sclab(SclaBlock **global_sclab,
>> +                        IplDeviceComponentEntry *comp_entry,
>> +                        IplInfoBlockHeader *comp_list_hdr)
>> +{
>> +    SclabOriginLocator *sclab_locator;
>> +    SclaBlock *sclab;
>> +
>> +    /* sclab locator is located at the last 8 bytes of the signed comp */
>> +    sclab_locator = (SclabOriginLocator *)(comp_entry->addr +
>> +                                           comp_entry->len - 8);
> 
> Need to verify that len >=8, otherwise who knows what gets read.
> 
>> +
>> +    /* return early if sclab does not exist */
>> +    zipl_secure_validate(magic_match(sclab_locator->magic, ZIPL_MAGIC),
>> +                         &comp_entry->cei, S390_CEI_INVALID_SCLAB,
>> +                         "Magic does not match. SCLAB does not exist");
>> +
>> +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
>> +        return;
>> +    }
>> +
>> +    zipl_secure_validate(sclab_locator->len >= S390_SCLAB_MIN_LEN, &comp_entry->cei,
>> +                         S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
>> +                         "Invalid SCLAB length");
>> +
>> +    /* return early if sclab is invalid */
>> +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
>> +        return;
>> +    }
> 
> I get why these two conditions (missing/invalid SCLAB) cause us to stop processing when in audit
> mode...
> 
>> +
>> +    sclab = (SclaBlock *)(comp_entry->addr + comp_entry->len -
>> +                          sclab_locator->len);
>> +
>> +    zipl_secure_validate(sclab->format == 0, &comp_entry->cei,
>> +                         S390_CEI_INVALID_SCLAB_FORMAT,
>> +                         "Format-0 SCLAB is not being used");
> 
> ...but why doesn't this one (SCLAB format)? Do the subsequent flags checks all apply regardless of
> format?
> 

Continuing with the flag checks seems reasonable to me, since we're
still dealing with some form of valid SCLAB. Please let me know your
thoughts. Thanks!

>> +
>> +    if (!(sclab->flags & S390_SCLAB_OPSW)) {
>> +        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
>> +        zipl_secure_validate(sclab->load_psw == 0, &comp_entry->cei,
>> +                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
>> +                             "Load PSW is not zero when Override PSW bit is zero");
>> +    } else {
>> +        /* OPSW = 1 indicating global SCLAB */
>> +        if (*global_sclab) {
>> +            comp_list_hdr->iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
>> +            zipl_secure_error("More than one global SCLAB");
>> +        }
>> +        *global_sclab = sclab;
>> +
>> +        /* override load address flag must set to one */
>> +        zipl_secure_validate(sclab->flags & S390_SCLAB_OLA, &comp_entry->cei,
>> +                             S390_CEI_SCLAB_OLA_NOT_ONE,
>> +                             "OLA flag is not set to one in the global SCLAB");
>> +    }
>> +
>> +    if (!(sclab->flags & S390_SCLAB_OLA)) {
>> +        /* OLA = 0 - Load address field in SCLAB must contain zeros */
>> +        zipl_secure_validate(sclab->load_addr == 0, &comp_entry->cei,
>> +                             S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
>> +                             "Load Address is not zero when OLA flag is zero");
>> +    } else {
>> +        /* OLA = 1 - Load address field must match storage address of the component */
>> +        zipl_secure_validate(sclab->load_addr == comp_entry->addr, &comp_entry->cei,
>> +                             S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
>> +                             "Load Address does not match with component load address");
>> +    }
>> +
>> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_NUC || sclab->flags & S390_SCLAB_OPSW,
>> +                         &comp_entry->cei, S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB,
>> +                         "NUC bit is set, but not in the global SCLAB");
>> +
>> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_SC || sclab->flags & S390_SCLAB_OPSW,
>> +                         &comp_entry->cei, S390_CEI_SC_NOT_IN_GLOBAL_SCLAB,
>> +                         "SC bit is set, but not in the global SCLAB");
>> +}
>> +
>>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>>  {
>>      if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> @@ -268,6 +415,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>>      uint8_t *tmp_buf;
>>      bool verified;
>>      bool signed_found = false;
>> +    bool sclab_found = false;
>> +    SclaBlock *global_sclab = NULL;
>>  
>>      if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > (CERT_BUF_SIZE)) {
>>          panic("Not enough memory to store certificates");
>> @@ -308,6 +457,10 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>>  
>>              /* no signature present (unsigned component) */
>>              if (!sig_entry.len) {
>> +                zipl_secure_validate(comp_entry.addr >= S390_UNSIGNED_MIN_ADDR,
>> +                            &comp_entry.cei, S390_CEI_INVALID_UNSIGNED_ADDR,
>> +                            "Load address for unsigned component is less than 0x2000");
>> +
>>                  comp_list_add(comp_list, comp_entry);
>>                  break;
>>              }
>> @@ -319,6 +472,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>>              comp_entry.flags = S390_IPL_DEV_COMP_FLAG_SC;
>>              signed_found = true;
>>  
>> +            check_sclab(&global_sclab, &comp_entry, &comp_list->ipl_info_header);
>> +            sclab_found |= !(comp_entry.cei & S390_CEI_INVALID_SCLAB);
>> +
>>              cert_entry = (IplSignatureCertificateEntry) { 0 };
>>              verified = verify_signature(comp_entry, sig_entry,
>>                                          &cert_entry.len, &cert_table_idx);
>> @@ -364,9 +520,17 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>>          }
>>      }
>>  
>> -    if (!signed_found) {
>> -        zipl_secure_error("Secure boot is on, but components are not signed");
>> -    }
>> +    zipl_secure_validate(signed_found, &comp_list->ipl_info_header.iiei,
>> +                         S390_IIEI_NO_SIGNED_COMP,
>> +                         "Secure boot is on, but components are not signed");
>> +
>> +    zipl_secure_validate(sclab_found, &comp_list->ipl_info_header.iiei,
>> +                         S390_IIEI_NO_SCLAB, "No recognizable SCLAB");
>> +
>> +    comp_entry = (IplDeviceComponentEntry){ 0 };
>> +    comp_entry.addr = entry->compdat.load_psw;
>> +    check_global_sclab(global_sclab, &comp_entry, comp_list);
>> +    comp_list_add(comp_list, comp_entry);
> 
> Do we actually need to add an (empty) entry when global_sclab wasn't found?
> 

I think we should still add this entry even when global_sclab is not
found, since the comp_entry would still contain the PSW value from the
EXEC entry.

>>  
>>      *entry_ptr = entry;
>>      free((void *)sig_entry.addr);
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index 1b1287858b..1bacb4987a 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.h
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -27,6 +27,33 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>>                      IplSignatureCertificateList *cert_list,
>>                      uint8_t **tmp_cert_buf);
>>  
>> +#define S390_SCLAB_OPSW    0x8000   /* override PSW flag */
>> +#define S390_SCLAB_OLA     0x4000   /* override load address flag */
>> +#define S390_SCLAB_NUC     0x2000   /* no unsigned components flag */
>> +#define S390_SCLAB_SC      0x1000   /* single component flag */
>> +
>> +#define S390_SCLAB_MIN_LEN      32
>> +#define S390_UNSIGNED_MIN_ADDR  0x2000
>> +
>> +/* Secure Code Loading Attributes Block */
>> +struct SclaBlock {
>> +    uint8_t  format;
>> +    uint8_t  reserved1;
>> +    uint16_t flags;
>> +    uint8_t  reserved2[4];
>> +    uint64_t load_psw;
>> +    uint64_t load_addr;
>> +    uint64_t reserved3[];
>> +} __attribute__ ((packed));
>> +typedef struct SclaBlock SclaBlock;
>> +
>> +struct SclabOriginLocator {
>> +    uint8_t reserved[2];
>> +    uint16_t len;
>> +    uint8_t magic[4];
>> +} __attribute__ ((packed));
>> +typedef struct SclabOriginLocator SclabOriginLocator;
>> +
>>  static inline void zipl_secure_error(const char *message)
>>  {
>>      switch (boot_mode) {
>> @@ -38,6 +65,30 @@ static inline void zipl_secure_error(const char *message)
>>      }
>>  }
>>  
>> +static inline void zipl_secure_validate_u16(bool condition, uint16_t *flags,
>> +                                            uint16_t flag, const char *message)
>> +{
>> +    if (!condition) {
>> +        *flags |= flag;
>> +        zipl_secure_error(message);
>> +    }
>> +}
>> +
>> +static inline void zipl_secure_validate_u32(bool condition, uint32_t *flags,
>> +                                            uint32_t flag, const char *message)
>> +{
>> +    if (!condition) {
>> +        *flags |= flag;
>> +        zipl_secure_error(message);
>> +    }
>> +}
>> +
>> +#define zipl_secure_validate(condition, flags, flag, message)   \
>> +    _Generic((flags),                                           \
>> +        uint16_t * : zipl_secure_validate_u16,                  \
>> +        uint32_t * : zipl_secure_validate_u32                   \
>> +    )(condition, flags, flag, message)
>> +
>>  static inline uint64_t _diag320(void *data, unsigned long subcode)
>>  {
>>      register unsigned long addr asm("0") = (unsigned long)data;


