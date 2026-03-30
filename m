Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECF1061B1E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7J3Z-0007Dv-Hz; Mon, 30 Mar 2026 16:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w7J3G-00079I-9v; Mon, 30 Mar 2026 16:17:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w7J3E-0000u1-KH; Mon, 30 Mar 2026 16:17:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UEInU9142146; Mon, 30 Mar 2026 20:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3TTtfo
 /HLBwuRSmSJpw8ExFGkt3NfdtCuRb1vZRjpu8=; b=FfBzQU6340rMXCiLSojQ5u
 ErafogEU6OstaUzb7dJ2+MuF8hJuRPpWgYu1OHgoCfrAK0g/Pqkvy7U6lGrCzXa+
 cXs3SjSZdiObOt+XlPnrNmnfy6iBI/qNIBbv/xNWUKYXVQmqMBW57Crxb48G5LEt
 3ATu9NjiTv5vo65XzT/o/dvENRDF8TOichBvWjDuQOGpqcSpV0Fu09eEtThUNQn+
 sR3TaVoB02Ytm7g1fy6UmNZvO4aBmrX3mpjDe3yIiteptH0fPKD/LzEiAZbSP1dt
 zaghweppFoEkF+rIebfwj5VbB4Yj5AuO6sBznxI+ZXKRX1BNL7bbN5F3192LkmRQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dggae7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 20:17:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UJ0D0A021696;
 Mon, 30 Mar 2026 20:17:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasefey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 20:17:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62UKGwA729098582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 20:16:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0968558043;
 Mon, 30 Mar 2026 20:17:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25B1258061;
 Mon, 30 Mar 2026 20:17:21 +0000 (GMT)
Received: from [9.61.25.90] (unknown [9.61.25.90])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Mar 2026 20:17:21 +0000 (GMT)
Message-ID: <8ebba892-f77e-4976-bafc-30562f1ef132@linux.ibm.com>
Date: Mon, 30 Mar 2026 16:17:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/30] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-23-zycai@linux.ibm.com>
 <655c1663-787d-4a42-a90e-36798506c303@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <655c1663-787d-4a42-a90e-36798506c303@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2NiBTYWx0ZWRfX/NEj73KyPcHo
 PAxQVmsSswIVus6KHHydL5Z/rkyuFF5xu3LJzP9O0houRVfwdn29fKIU6hkINlqkJwhMq+rn7HR
 w5fOsdIMthOA6AIMD5QphhFiBMSSPGzXRkwLDy8FSXBT2nydQFp1rbfDoKHK+o9EkwWDw6RX7rc
 bohUhwssPS8rXogQHyYm0OZtF2XKC+0MjGHgL8NBplvnC60O/34y98+FJ5SRzrQhSZ3ALCJ2ojM
 dGRRoisLY/n0OUnMWcyiCLmsqfN7kBIxGJsdfpY1z4w5H0kVg34m3XgqjVPoyagH5puf550JC2w
 Dr60RnucpdrRH7Xegf4hEZWAfZ/PNkXFSPDYpITJ7UwtxAQ4sPLG+X0uNfWlE4ykNxlqmH17xtZ
 UBgdNFAr3POtVqUBkbSZl+BC7102R5PhIIkPMtuBcYuDTlMhr9oOBwnbIt/fGGmwOQaDN1yRN7h
 fftUM/tOoi2yL6wT2cQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cada55 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=afb8Tjryq-pnIDj9U0sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NnG0Bg3H6_3HVX5qQUO4hKdv3JltzrWW
X-Proofpoint-ORIG-GUID: NnG0Bg3H6_3HVX5qQUO4hKdv3JltzrWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On 3/17/26 2:54 AM, Collin Walling wrote:
> On 3/5/26 17:41, Zhuoying Cai wrote:
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
> 
> This goes back to my comment in patch 19: who/what is going to make use
> of the IIRB? If no one or nothing will inspect this data structure, then
> perhaps it's sufficient enough to simply log the errors?
> 
>>
>> When SCLAF is installed, additional secure boot checks are performed
>> during zipl and store results of verification into IIRB.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  include/hw/s390x/ipl/qipl.h   |  29 +++-
>>  pc-bios/s390-ccw/s390-ccw.h   |   1 +
>>  pc-bios/s390-ccw/sclp.c       |   8 +
>>  pc-bios/s390-ccw/sclp.h       |   1 +
>>  pc-bios/s390-ccw/secure-ipl.c | 314 +++++++++++++++++++++++++++++++++-
>>  pc-bios/s390-ccw/secure-ipl.h |  42 +++++
>>  6 files changed, 391 insertions(+), 4 deletions(-)
>>

[...]

>>  
>> @@ -391,10 +691,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>>          }
>>      }
>>  
>> -    if (signed_count == 0) {
>> -        zipl_secure_handle("Secure boot is on, but components are not signed");
>> +    /* validate load PSW with PSW specified in the final entry */
>> +    if (sclab_info.load_psw) {
>> +        comp_entry = (comp_entry_idx < MAX_CERTIFICATES) ?
>> +                     &comp_list.device_entries[comp_entry_idx] : NULL;
> 
> Silently accepting a NULL component makes it seem like an error should
> be thrown, or a special case should be handled.
> 
> It looks like these `check_*()` functions only need the `cei` field of
> the `comp_entry`.  Instead of passing the entire `comp_entry` to these
> functions, pass something like an independent `cei_flags` variable. The
> functions will set the appropriate error bits where appropriate.  This
> also eliminates the various checks for `comp_entry != NULL`.
> 
> Then change `comp_list_add()` to accept the `cei_flags` field and set it
> in the respective component while still accounting for the
> `MAX_CERTIFICATES` check.
> 
>> +        check_load_psw(comp_addr_range, addr_range_index,
>> +                       sclab_info.load_psw, entry->compdat.load_psw, comp_entry);
>> +        comp_list_add(&comp_list, comp_entry_idx, -1,
>> +                      entry->compdat.load_psw, 0, 0x00);
> 
> Why is the exec component added to the list?  It wasn't added before
> this patch.

The exec component is included in the component list because it is used
to validate the Load PSW field of the global SCLAB. Since validation
relies on the exec component, it's added to the list for auditing purpose.

> 
>>      }
>>  

[...]


