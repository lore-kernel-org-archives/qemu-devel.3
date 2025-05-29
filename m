Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E9EC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiwZ-0003hA-Kc; Thu, 29 May 2025 15:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKiw6-00034t-67; Thu, 29 May 2025 15:29:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKiw2-0000ie-Ad; Thu, 29 May 2025 15:29:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TCcVgk002036;
 Thu, 29 May 2025 19:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Rg5jUy
 P8alS4V9q3WytclRClQTCPpEcWIgh5+DFQQOs=; b=Bo0s2/gNALyNO2KoQyAE+8
 fFq1W+rGte3Ir2TYey/u3dYk1GzkgBPXav2Xl5+au6zRn1ATE6hL7QZcDcyG8gbE
 DOBqOIM/iilcm53j1knVBNKGn4G5DqoOrSLaRN3QAhOoVm1dxHZI6eXOe9pJAaL7
 u7VKqcGnlgGZLfNtYO0CqyxDIGfbaGQwxYTyn0u9mcF19uXC9osgjNL1gXZrRyho
 djmpnchiFrO1N6nh9saWJca0TCwhtQe/NGNYDZn7tOdrnmylTql3lCjGKxfuMv44
 XWSv2nsZzFYVb38mIrJUhywk/hFFE9xPZTA5ZScy0be9GgvhiEaBepfXy7HvOAzg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gqjk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 19:29:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54THYvaK029562;
 Thu, 29 May 2025 19:28:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usxn5whj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 19:28:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54TJSwnA4522564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:28:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 019595805D;
 Thu, 29 May 2025 19:28:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36D6358052;
 Thu, 29 May 2025 19:28:57 +0000 (GMT)
Received: from [9.61.85.78] (unknown [9.61.85.78])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 May 2025 19:28:57 +0000 (GMT)
Message-ID: <2cf5fa7f-1756-4639-b3a3-87104493d9d5@linux.ibm.com>
Date: Thu, 29 May 2025 15:28:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-18-zycai@linux.ibm.com>
 <53616ccd-3fb5-41e9-bd6a-0a0243b1a392@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <53616ccd-3fb5-41e9-bd6a-0a0243b1a392@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=6838b57c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=f-wdDlZkA8hqA7SaI3YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4NSBTYWx0ZWRfX9h2gWJv4w5r0
 fVSV3FdqCgh9u0j8IviwOxxrULS9daCOO63q28woqkr0/1FmT4nNl3wTpwUxi9S/6pgkt+S+q0y
 1KNfaq0ATCflPkfwG0ZSmUvms1+g0N+oxka9ILTt01r1NzmAMUkJtHTYP/8bSlpVAJBSnyyYZzN
 9lgrdo3R9liVUYFKVeqK3Ngo4pqGhzrCjIFeruDgnAQjbQEqrRl2kT6ASYuByxZ8W3cPE3+DU8P
 ozHjiRXi2qBU5Zc8RPE2Ugl1+sMoYp6xul1nFN3kgfzhViz739DF1L77dTVzhT+BzT0sdvzPFT6
 55ctSEclQyOwCTMu1/L7ZcVLiWsI7ejc7jQH9QxZjROj/xnTHsQm7sZRGLn3Dxrk32ghZ4qYnHP
 rSrN6tj299lYVruPID6AJgP4I5OWiqu4Tvw8nboQH9WSghbHkuOivq0KErUB7e9rDiQeZHd9
X-Proofpoint-GUID: N4ozhC6ZzGg9eETvkqmzsFldlq51Bfyy
X-Proofpoint-ORIG-GUID: N4ozhC6ZzGg9eETvkqmzsFldlq51Bfyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/20/25 6:25 AM, Thomas Huth wrote:
> On 09/05/2025 00.50, Zhuoying Cai wrote:
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
>>   pc-bios/s390-ccw/Makefile     |   3 +-
>>   pc-bios/s390-ccw/bootmap.c    | 192 +++++++++++++++++++++++++++++++++-
>>   pc-bios/s390-ccw/bootmap.h    |   9 ++
>>   pc-bios/s390-ccw/main.c       |   9 ++
>>   pc-bios/s390-ccw/s390-ccw.h   |  14 +++
>>   pc-bios/s390-ccw/sclp.c       |  44 ++++++++
>>   pc-bios/s390-ccw/sclp.h       |   6 ++
>>   pc-bios/s390-ccw/secure-ipl.c | 175 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h | 109 +++++++++++++++++++
>>   9 files changed, 558 insertions(+), 3 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index dc69dd484f..fedb89a387 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>   .PHONY : all clean build-all distclean
>>   
>>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
>> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
>> +	  secure-ipl.o
>>   
>>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>>   
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 3dd09fda7e..06cea0929a 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -15,6 +15,7 @@
>>   #include "bootmap.h"
>>   #include "virtio.h"
>>   #include "bswap.h"
>> +#include "secure-ipl.h"
>>   
>>   #ifdef DEBUG
>>   /* #define DEBUG_FALLBACK */
>> @@ -34,6 +35,13 @@ static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
>>   const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
>>                                     "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>   
>> +/* sector for storing certificates */
>> +static uint8_t certs_sec[CERT_MAX_SIZE * MAX_CERTIFICATES];
> 
> If I calculated correctly, that's a buffer of 512 kB... That's quite huge 
> already. Would it be possible to malloc() it only if we really need this 
> instead of statically allocating it?
> 
>> +/* sector for storing signatures */
>> +static uint8_t sig_sec[MAX_SECTOR_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
>> +
>> +ipl_print_func_t zipl_secure_print_func;
>> +
>>   /*
>>    * Match two CCWs located after PSW and eight filler bytes.
>>    * From libmagic and arch/s390/kernel/head.S.
>> @@ -676,6 +684,155 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>>       return comp_len;
>>   }
>>   
>> +static uint32_t zipl_handle_sig_entry(ComponentEntry *entry)
>> +{
>> +    uint32_t sig_len;
>> +
>> +    if (zipl_load_segment(entry, (uint64_t)sig_sec) < 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> +        puts("Signature is not in DER format");
>> +        return -1;
>> +    }
>> +    sig_len = entry->compdat.sig_info.sig_len;
>> +
>> +    return sig_len;
>> +}
>> +
>> +static int handle_certificate(int *cert_table, uint64_t **cert,
>> +                             uint64_t cert_len, uint8_t cert_idx,
>> +                             IplSignatureCertificateList *certs, int cert_index)
>> +{
>> +    bool unused;
>> +
>> +    unused = cert_table[cert_idx] == -1;
>> +    if (unused) {
>> +        if (zipl_secure_request_certificate(*cert, cert_idx)) {
>> +            zipl_secure_cert_list_add(certs, cert_index, *cert, cert_len);
>> +            cert_table[cert_idx] = cert_index;
>> +            *cert += cert_len;
> 
> So zipl_secure_cert_list_add() checks for the index not going beyond 
> MAX_CERTIFICATES, but here you ignore that error and update cert_table and 
> *cert anyway? Sounds like a potential bug to me.
> 

If zipl_secure_request_certificate() successfully retrieves a
certificate from the S390 certificate store, updating the corresponding
entry in cert_table should not pose any issues. This is because we
strictly limit the number of certificates to MAX_CERTIFICATES, and
cert_idx is guaranteed to be within the range [0, 63].

The size of cert_table and the memory allocated for *cert are both
defined based on MAX_CERTIFICATES and MAX_CERT_SIZE, so as long as the
request is successful, the update is safe.

The index check in zipl_secure_cert_list_add() ensures that the IIRB
cert list does not exceed the valid range defined by MAX_CERTIFICATES,
preventing out-of-bound memory overwrites.

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

[...]

