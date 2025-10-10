Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDF8CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HQB-0007zv-8B; Fri, 10 Oct 2025 14:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v7HQ3-0007wE-Hw; Fri, 10 Oct 2025 14:00:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v7HPo-0005G7-3K; Fri, 10 Oct 2025 14:00:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ACOUCO031164;
 Fri, 10 Oct 2025 18:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tBvUhx
 dXGN7V5oi5rvDLgBaRtLl3OuCDoz341tv+oyQ=; b=k+p4A/B8XZ6wE7Qkbhek8N
 aSraGodkCUqII1LjOeNevXBCYTVMENiU1MkCpDTRw4Ddt/5PG4Ae3KrvHzy/3OE4
 mo0eIu19gb/eILSbFU8dsm8b8wqEZxoZDS+xLEFrx/4dmmzA5pi0Q79UWvvXMM/0
 m6J0ZugxPE048RTjhAzLIqWo9rGk/iuEQikpLPYkYGNznaKr9t3/CTh4/Fd5ga2W
 Ziz1VJ3EfckFQ/8C3L0Rim76O/s0lQ6m9TZDvfO+Cb6yzuM6OV8wcTSS5aqAWi6I
 gDeO4lA1ioWEIgJZskiWvm4ufAFi/IDCxFQPiPz9/m2a29vneS3sGUbtsEtaUHdQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81uyud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 18:00:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFccBs026015;
 Fri, 10 Oct 2025 18:00:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamu27e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 18:00:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59AI0FuX30606016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 18:00:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4CA358052;
 Fri, 10 Oct 2025 18:00:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD5AD58065;
 Fri, 10 Oct 2025 18:00:14 +0000 (GMT)
Received: from [9.61.95.157] (unknown [9.61.95.157])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Oct 2025 18:00:14 +0000 (GMT)
Message-ID: <4b3100eb-2ada-4331-bc3d-f2faeafb1e2a@linux.ibm.com>
Date: Fri, 10 Oct 2025 14:00:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Farhan Ali <alifm@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-20-zycai@linux.ibm.com>
 <23e3c4f3-7e8c-4d00-8dee-91bf15261cfb@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <23e3c4f3-7e8c-4d00-8dee-91bf15261cfb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WbQhlWmp6cJaMdIzOKLBxb0GmeVWOStA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxUeoNkKMqpZ+
 hje2ODo/YgVKcVEfftZLTZ4GpII0ZtVpcQHCE18dN5k04ugV/ViwdHzNPq3EuFhahYw7lfZ3MWm
 mIl2mkKMvByh9MuvY0auqp9bFHyRQV78KqYJJL/KgW42k0UaXcA59nTIe4MgF7XpTZzx6gYL8u3
 ASz+4nx2c89UTbWK5XkAS2cP8WtY7E6K3wzg2U9UPm8RwjLcJOs5quQ4080i8XolRvhjMeun4pA
 WJjRZMrdtHfu7CMcUeaC9Dnt1zjl7lErIx/ktZ7X8q18tFpExjFzgO2+vEB19ERHKWshWX2KsD3
 x8/qyy7mm0LWAWHhLoIn1FbMJd4Q1yTCC0XPEaf6NsZL6SaauoqIrowHNB0za0oUI1UTsC2aKFS
 o29wWG1+dmaOTi+KObube69OkddA6w==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e949b2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=DHNh8X_YsdPW5Z7zh6UA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WbQhlWmp6cJaMdIzOKLBxb0GmeVWOStA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/25 2:42 PM, Farhan Ali wrote:
> 
> On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
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
>> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst |  36 +++
>>   pc-bios/s390-ccw/Makefile        |   3 +-
>>   pc-bios/s390-ccw/bootmap.c       |  39 +++-
>>   pc-bios/s390-ccw/bootmap.h       |  11 +
>>   pc-bios/s390-ccw/main.c          |   9 +
>>   pc-bios/s390-ccw/s390-ccw.h      |  15 ++
>>   pc-bios/s390-ccw/sclp.c          |  44 ++++
>>   pc-bios/s390-ccw/sclp.h          |   6 +
>>   pc-bios/s390-ccw/secure-ipl.c    | 371 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h    |  99 +++++++++
>>   10 files changed, 630 insertions(+), 3 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>

[...]

>> +
>> +static int handle_certificate(int *cert_table, uint8_t **cert,
>> +                             uint64_t cert_len, uint8_t cert_idx,
>> +                             IplSignatureCertificateList *certs, int cert_index)
>> +{
>> +    bool unused;
>> +
>> +    unused = cert_table[cert_idx] == -1;
>> +    if (unused) {
>> +        if (request_certificate(*cert, cert_idx)) {
>> +            cert_list_add(certs, cert_index, *cert, cert_len);
>> +            cert_table[cert_idx] = cert_index;
>> +            *cert += cert_len;
> 
> It's hard to understand why we increment *cert in this function by just 
> looking at the function. But this function is called in the loop in 
> zipl_run_secure, could we move this entire function in zipl_run_secure?
> 
> 

Thanks for the suggestion.

I'm concerned that moving this function into zipl_run_secure() could
make it harder to read, since it's already quite large. I'd prefer to
keep this function separate because it handles all certificate related
operations here and add comments to clarify why *cert is incremented.
I'd be happy to hear additional thoughts.

>> +        } else {
>> +            puts("Could not get certificate");
>> +            return -1;
>> +        }
>> +
>> +        /* increment cert_index for the next cert entry */
>> +        return ++cert_index;
>> +    }
>> +
>> +    return cert_index;
>> +}
>> +
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comps;
>> +    IplSignatureCertificateList certs;
>> +    ComponentEntry *entry = *entry_ptr;
>> +    uint8_t *cert = NULL;
>> +    uint64_t *sig = NULL;
>> +    int cert_index = 0;
>> +    int comp_index = 0;
>> +    uint64_t comp_addr;
>> +    int comp_len;
>> +    uint32_t sig_len = 0;
>> +    uint64_t cert_len = -1;
>> +    uint8_t cert_idx = -1;
> 
> Why do we have 2 variables (cert_idx, cert_index) that are named 
> similar? Can we rename cert_index to cert_table_idx?
> 
> 
>> +    bool verified;
>> +    uint32_t certs_len;
>> +    /*
>> +     * Store indices of cert entry that have already used for signature verification
>> +     * to prevent allocating the same certificate multiple times.
>> +     * cert_table index: index of certificate from qemu cert store used for verification
>> +     * cert_table value: index of cert entry in cert list that contains the certificate
>> +     */
>> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
>> +    int signed_count = 0;
>> +
>> +    if (!secure_ipl_supported()) {
>> +        return -1;
>> +    }
>> +
>> +    init_lists(&comps, &certs);
>> +    certs_len = get_certs_length();
>> +    cert = malloc(certs_len);
>> +    sig = malloc(MAX_SECTOR_SIZE);
>> +
>> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
>> +        switch (entry->component_type) {
>> +        case ZIPL_COMP_ENTRY_SIGNATURE:
>> +            if (sig_len) {
>> +                goto out;
>> +            }
>> +
>> +            sig_len = zipl_load_signature(entry, (uint64_t)sig);
>> +            if (sig_len < 0) {
>> +                goto out;
>> +            }
>> +            break;
>> +        case ZIPL_COMP_ENTRY_LOAD:
>> +            comp_addr = entry->compdat.load_addr;
>> +            comp_len = zipl_load_segment(entry, comp_addr);
>> +            if (comp_len < 0) {
>> +                goto out;
>> +            }
>> +
>> +            if (!sig_len) {
>> +                break;
>> +            }
>> +
>> +            verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
>> +                                        &cert_len, &cert_idx);
>> +
>> +            if (verified) {
>> +                cert_index = handle_certificate(cert_table, &cert, cert_len, cert_idx,
>> +                                                &certs, cert_index);
>> +                if (cert_index == -1) {
>> +                    goto out;
>> +                }
>> +
>> +                puts("Verified component");
>> +                comp_list_add(&comps, comp_index, cert_table[cert_idx],
>> +                              comp_addr, comp_len,
>> +                              S390_IPL_COMPONENT_FLAG_SC | S390_IPL_COMPONENT_FLAG_CSV);
>> +            } else {
>> +                comp_list_add(&comps, comp_index, -1,
>> +                              comp_addr, comp_len,
>> +                              S390_IPL_COMPONENT_FLAG_SC);
>> +                zipl_secure_handle("Could not verify component");
>> +            }
>> +
>> +            comp_index++;
>> +            signed_count += 1;
>> +            /* After a signature is used another new one can be accepted */
>> +            sig_len = 0;
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
>> +        zipl_secure_handle("Secure boot is on, but components are not signed");
>> +    }
>> +
>> +    if (update_iirb(&comps, &certs)) {
>> +        zipl_secure_handle("Failed to write IPL Information Report Block");
>> +    }
>> +
>> +    *entry_ptr = entry;
>> +    free(sig);
>> +
>> +    return 0;
>> +out:
>> +    free(cert);
>> +    free(sig);
>> +
>> +    return -1;
>> +}

[...]


