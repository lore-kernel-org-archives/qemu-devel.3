Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF267CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 19:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKhpu-0005QO-1O; Wed, 06 May 2026 15:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKhpr-0005Pg-S7; Wed, 06 May 2026 15:23:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKhpp-0007CC-0v; Wed, 06 May 2026 15:23:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646BYHnJ3104130; Wed, 6 May 2026 19:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UK68io
 RAidsxyhY+7li1uP5scAcLt6KK2yYCSOhyCac=; b=AnuzXr3+kqKu8RDgTPKPF7
 6q1KGtcPAsDVq9cVvCyQX8TamyQfyQZov7lro5bnSiOBPNwg+WlAC7jdlsXZmyT5
 H0vA23vfnIKaOajtFTAKxtrVnAqHEsmakbTzo1nF7bbdIz/l32D9HF0M1hEJBUnf
 70RYMLzC2dY3YoqDEpXWtgygVdSBWvS08Viv9S/YcvqCgwGm+4od7i6//pKFDy+G
 4tmJ2uHBJec5Tu6jvFp94K99ufvUr80na9lsh3SCAKxdF2ShLP9r70TLGEplhHZK
 dCLbz4igjzFV4/OI9PQYDCCSYWP1xK9xJNvVr3dUhNZTXT3DTi8l6b/wmVHu1i9w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6hp8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:23:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646J9W8Q028347;
 Wed, 6 May 2026 19:22:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yfes9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:22:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646JMxl122217432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 19:22:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F056158055;
 Wed,  6 May 2026 19:22:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAB7458043;
 Wed,  6 May 2026 19:22:57 +0000 (GMT)
Received: from [9.61.184.19] (unknown [9.61.184.19])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 19:22:57 +0000 (GMT)
Message-ID: <367fca42-e606-4034-93d3-83a07bc2ecad@linux.ibm.com>
Date: Wed, 6 May 2026 15:22:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 27/32] pc-bios/s390-ccw: Handle true secure IPL mode
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, pierrick.bouvier@oss.qualcomm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-28-zycai@linux.ibm.com>
 <195523c9-747a-4b83-b0a3-3cca3b9a13f0@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <195523c9-747a-4b83-b0a3-3cca3b9a13f0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb9514 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mqyOHuzQTb_LAAcy73UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dIRICj4pnr3qTUO9KzGDtOkQ2OIBkhuE
X-Proofpoint-GUID: dIRICj4pnr3qTUO9KzGDtOkQ2OIBkhuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfX3wHnxvHYcXlK
 6X18m23hEpJ+yZt9nV9Mmg6kmeGpH5TIfEKj/AZ3HA6+ZrE3VsCg0ALILDMoRyCVTk5KRBafBVK
 X8vOui6+rGCQbgSnBqkN+MnQDdgy8X5YDYK0MeVBMv3h53BJ/sN22EQ4uDTa9U+pPTaP+wADFSC
 mZ9pJH3gSVxq/rmPCZpDJzWcFA+0Fflm+mV0mbkMF0YMOZOFCrzbYyGHbCx5eaZTEqTWgu7Tooi
 7LVrPGllXdM+/Y8m0Jjdenu/xuFztvrUBENXzWu8ThaH+sxKvYfUsfOS/WwzJXo2/uHdq4WC9l7
 3FsbwHgPyCb7m2MblE644+tWKPEhdABl1PhdZ5ww4e/r02lNDbyA/DVJmCxrYdlOU4bG1jwLLCG
 lWo9WdHqDnW/l8CWbpvKg9Xn2TCUU6fJsT+XeMF6p452X7uRc19qiQ9j37ne6xpjhVPPB9GRNpO
 LIQI7+ARaS/oVAfFLJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 5/6/26 2:59 PM, Joshua Daley wrote:
> On 5/5/2026 4:18 PM, Zhuoying Cai wrote:
>> When secure boot is enabled (-secure-boot on) and certificate(s) are
>> provided, the boot operates in True Secure IPL mode.
>>
>> Any verification error during True Secure IPL mode will cause the
>> entire boot process to terminate.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities. If secure boot is enabled
>> but no certificate is provided, the boot process will also terminate, as
>> this is not a valid secure boot configuration.
>>
>> Note: True Secure IPL mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
>>   pc-bios/s390-ccw/bootmap.c       |  8 ++++++++
>>   pc-bios/s390-ccw/main.c          |  3 ++-
>>   pc-bios/s390-ccw/s390-ccw.h      |  1 +
>>   pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>>   5 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> index 9e3955f8fc..c8fb887ac0 100644
>> --- a/docs/system/s390x/secure-ipl.rst
>> +++ b/docs/system/s390x/secure-ipl.rst
>> @@ -66,3 +66,16 @@ Configuration:
>>   .. code-block:: shell
>>   
>>       qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
>> +
>> +Secure Mode
>> +^^^^^^^^^^^
>> +
>> +When the ``secure-boot=on`` option is set and certificates are provided,
>> +a secure boot is performed with error reporting enabled. The boot process aborts
>> +if any error occurs.
>> +
>> +Configuration:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index a300fba8cd..8f54c15144 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -738,6 +738,7 @@ static int zipl_run(ScsiBlockPtr *pte)
>>       case ZIPL_BOOT_MODE_NORMAL:
>>           rc = zipl_run_normal(&entry, tmp_sec);
>>           break;
>> +    case ZIPL_BOOT_MODE_SECURE:
>>       case ZIPL_BOOT_MODE_SECURE_AUDIT:
>>           rc = zipl_run_secure(&entry, tmp_sec);
>>           break;
>> @@ -1115,9 +1116,16 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
>>   {
>>       bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
>>       bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
>> +    VCStorageSizeBlock *vcssb;
>>   
>>       if (!sipl_set && iplir_set) {
>>           return ZIPL_BOOT_MODE_SECURE_AUDIT;
>> +    } else if (sipl_set && iplir_set) {
>> +        vcssb = zipl_secure_get_vcssb();
>> +        if (vcssb == NULL || vcssb->length == VCSSB_NO_VC) {
>> +            panic("Need at least one certificate for secure boot!");
>> +        }
>> +        return ZIPL_BOOT_MODE_SECURE;
>>       }
>>   
>>       return ZIPL_BOOT_MODE_NORMAL;
> In main(), get_boot_mode() is called before the secure_ipl_supported() 
> condition. Here, the call to zipl_secure_get_vcssb() fails disgracefully 
> when using a cpu gen that does not support secure IPL.
> 

Thanks for catching this. The is_cert_store_facility_supported() check
and its handling should be added before calling zipl_secure_get_vcssb().
I'll fix it.

>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 0bcd32b059..e34179a05f 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -396,9 +396,10 @@ void main(void)
>>   
>>       boot_mode = get_boot_mode(iplb->hdr_flags);
>>       switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE:
>>       case ZIPL_BOOT_MODE_SECURE_AUDIT:
>>           if (!secure_ipl_supported()) {
>> -            panic("Unable to boot in audit mode");
>> +            panic("Unable to boot in secure/audit mode");
>>           }
>>       default:
>>           break;
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index b66a9b50bf..7a7bf7720b 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -90,6 +90,7 @@ void zipl_load(void);
>>   typedef enum ZiplBootMode {
>>       ZIPL_BOOT_MODE_NORMAL = 0,
>>       ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
>> +    ZIPL_BOOT_MODE_SECURE = 2,
>>   } ZiplBootMode;
>>   
>>   extern ZiplBootMode boot_mode;
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index 950cd45b3c..723612b9ea 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.h
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -83,6 +83,9 @@ static inline void zipl_secure_error(const char *message)
>>       case ZIPL_BOOT_MODE_SECURE_AUDIT:
>>           printf("AUDIT MODE WARNING: %s\n", message);
>>           break;
>> +    case ZIPL_BOOT_MODE_SECURE:
>> +        panic(message);
>> +        break;
>>       default:
>>           break;
>>       }
> 


