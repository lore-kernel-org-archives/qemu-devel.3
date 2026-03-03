Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507BCEDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxX7I-0005Hz-Ag; Tue, 03 Mar 2026 16:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxX7C-0005BB-J2; Tue, 03 Mar 2026 16:17:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxX79-0003KD-Sl; Tue, 03 Mar 2026 16:17:14 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623HTqbZ1858431; Tue, 3 Mar 2026 21:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8HvGFX
 csgbdELkkKO9CRRW/oZsMPe3gYHAzCrQH6cXw=; b=nT8j5GlkF53BYQ5F2l0/XB
 Yh/fpgSXgpIBUsMsZ/ELOVA/xjL5j1BNIXD2s5XDmfTeKQdbwX22qOdvXoJ6NW8P
 cXYhNjN4ZailorIwKv+Rc+F4Gb6MCM6n0wX9yqTfy8dskBz21lUPIFQMfFWUirge
 RvpalEJVWsX2DPNz8/PDGwX6+XRGfmcoakIi/FTyvXtNMl9wLpKs6m0HicAD56l+
 35JOe6+3GhIqp/1S1RSSnvb7E/XpK0+BLXFDdI94uVC9eBKSJ5R4H+zvVScvhNMD
 5qIDmJvfTbuiIR7Yded510OY03sf0gsr3X+Hbgpd/EjCOfoD49/q5tvrra0QjDvA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj4xm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:17:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623Hi6ri003266;
 Tue, 3 Mar 2026 21:17:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y47q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:17:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623LH4Ng32375420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 21:17:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15BE358056;
 Tue,  3 Mar 2026 21:17:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1536358052;
 Tue,  3 Mar 2026 21:17:03 +0000 (GMT)
Received: from [9.61.108.121] (unknown [9.61.108.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 21:17:02 +0000 (GMT)
Message-ID: <1eeb9b9c-e7a5-4cf8-a989-0a55810bccee@linux.ibm.com>
Date: Tue, 3 Mar 2026 16:17:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/30] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-23-zycai@linux.ibm.com>
 <ba373cdc-bfb4-46b0-9a74-bfe7e74bdbca@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <ba373cdc-bfb4-46b0-9a74-bfe7e74bdbca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a74fd2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hBroyG_C7Neg0O3mkUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MyBTYWx0ZWRfX9gQmnOo4RWNA
 kAguziHzRfhmvANxroV6meri3/OP/SenTLFKxG/naS4LN6Fs1IMiur/F5BVvOQD8DM8FTRuUMRz
 g8a6K4qtKSaNyQypeQx2j4fqJzwuPExOK1QqVTFKJaaxunTMGO+OiJtrxT8vV8WLW1llrLWbC7X
 Wme/kTYCjzsbcdRDU5cpJ7PFDklL/Y5+i50cOM0raZr7WYLDS2yTrRHauHyF1o/5C1I6R/GYdO3
 7TrWRVdrMkhPKBBlMeuM6cX7L4XE1uHPkYm/mlvVx08qdeX+DHPThIRPrNqkRDpPPTPi05kegc7
 4wcxQdP1sK9Zn6Jb0mfQXfm4pZ+A7lDGv6e7/hXQducsF0jFvE+37FQZ8OhLYHoDWtRcD/XBJ0+
 GImlj/4LTqacYceXvejALsof0Th7s9sv+AfyLOi0DBD7R4CEontXMRSTjW1fmQc0V2UMoG8xGh2
 rh9r0ps8eoJlWSwTPBw==
X-Proofpoint-GUID: BUvlBVYhlIVaM_GP2usmg3-Qid-X1-yq
X-Proofpoint-ORIG-GUID: BUvlBVYhlIVaM_GP2usmg3-Qid-X1-yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On 3/2/26 6:24 AM, Thomas Huth wrote:
> On 12/02/2026 21.43, Zhuoying Cai wrote:
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
>> However, a missing SCLAB will not be reported in audit mode. The SCALB
>> checking will be skipped in this case.
>>
>> Add IPL Information Error Indicators (IIEI) and Component Error
>> Indicators (CEI) for IPL Information Report Block (IIRB).
>>
>> When SCLAF is installed, additional secure boot checks are performed
>> during zipl and store results of verification into IIRB.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   include/hw/s390x/ipl/qipl.h   |  29 +++-
>>   pc-bios/s390-ccw/s390-ccw.h   |   1 +
>>   pc-bios/s390-ccw/sclp.c       |   8 +
>>   pc-bios/s390-ccw/sclp.h       |   1 +
>>   pc-bios/s390-ccw/secure-ipl.c | 318 +++++++++++++++++++++++++++++++++-
>>   pc-bios/s390-ccw/secure-ipl.h |  42 +++++
>>   6 files changed, 395 insertions(+), 4 deletions(-)
> ...
>> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
>> index cf147f4634..3441020d6b 100644
>> --- a/pc-bios/s390-ccw/sclp.h
>> +++ b/pc-bios/s390-ccw/sclp.h
>> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>>   #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>>   #define SCCB_FAC134_DIAG320_BIT 0x4
>>   #define SCCB_FAC_IPL_SIPL_BIT 0x4000
>> +#define SCCB_FAC_IPL_SCLAF_BIT 0x1000
>>   
>>   typedef struct ReadInfo {
>>       SCCBHeader h;
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index 27d2833642..54e41ec11c 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -197,6 +197,12 @@ static bool secure_ipl_supported(void)
>>           return false;
>>       }
>>   
>> +    if (!sclp_is_sclaf_on()) {
>> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
>> +             " the hypervisor!");
>> +        return false;
>> +    }
> 
> Let me double-check: This emits a warning and then the bios might continue 
> with the boot process with another device? (zipl_load() prints another 
> warning and returns without panic'ing when ipl_scsi() failed)
> 
> ... is this what we want? Or should the boot process be stopped in case 
> we're running in (non-audit) secure mode?
> 

Thanks for pointing this out.

I agree that the boot process shouldn’t continue in this situation. All
secure‑boot facilities need to be present so the required checks can
run; if anything is missing, falling back to another device wouldn’t
make sense because no security checks could be performed.

So the boot process should stop rather than continue, whether we’re in
audit or secure mode. I’ll update this in the next version.

>>       return true;
>>   }
>>   
>> @@ -259,6 +265,290 @@ static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
>>       *addr_range_index += 1;
>>   }
>>   
>> +static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentEntry *comp_entry)
>> +{
>> +    /* unsigned load address must be greater than or equal to 0x2000 */
>> +    if (load_addr >= 0x2000) {
>> +        return;
>> +    }
>> +
>> +    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_UNSIGNED_ADDR,
>> +                          "Load address is less than 0x2000");
>> +}
>> +
>> +static bool check_sclab_presence(uint8_t *sclab_magic,
>> +                                 IplDeviceComponentEntry *comp_entry)
>> +{
>> +    /* identifies the presence of SCLAB */
>> +    if (magic_match(sclab_magic, ZIPL_MAGIC)) {
>> +        return true;
>> +    }
>> +
>> +    if (comp_entry) {
>> +        comp_entry->cei |= S390_CEI_INVALID_SCLAB;
>> +    }
>> +
>> +    /* a missing SCLAB will not be reported in audit mode */
>> +    return false;
>> +}
>> +

[...]



