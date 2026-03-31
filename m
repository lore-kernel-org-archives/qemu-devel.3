Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9396D10F92EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eoi-0000nG-Oj; Tue, 31 Mar 2026 15:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7eoh-0000mt-7h
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:31:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7eof-0007Dl-B3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:31:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VG0MHU3763981; Tue, 31 Mar 2026 19:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8lqXSf
 evQtueOFTt3w2ikaT6bNumJ6pvLdQ0FQwIBVk=; b=mGxquNdbnfDUB0e0DvA/z6
 kE+XJg3/7/7VWMeUnx6dcL9gKuL8GWeimUwe9uOI2HZBjT5OvWp+Y/M5haq67zcI
 vHXtq0scGKIRZnM8kun3Xoh46tAZ9N4ZlUoDkc9d94Ulb2hIvxVy4lYbRnasyWlq
 DpjwJOBY7FLKfs4k8J8bzfGvZvO2bai7hCGVDtL1UmwtrdZFAL78MuYoySaJ8J6y
 ZdOXNHf1MQjOS+LL4sWSCcVRlyt3eUUmWIZtV8G6g+E7roGeA5e/kYX3slN28Cnu
 vnsfy9jdEq/DQE3tN140H22ZrGrpSalMM4/WQ/XTPIAlQMx5xl1O2v5kWnLaBE9A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1w3p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 19:31:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VFd0gG022291;
 Tue, 31 Mar 2026 19:31:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan2m2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 19:31:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VJVL1s16384708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 19:31:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51A458058;
 Tue, 31 Mar 2026 19:31:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1703E58059;
 Tue, 31 Mar 2026 19:31:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2026 19:31:43 +0000 (GMT)
Message-ID: <b6aed41c-c5fe-415f-8523-fb1b34ff77ec@linux.ibm.com>
Date: Tue, 31 Mar 2026 15:31:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
From: Stefan Berger <stefanb@linux.ibm.com>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-8-armenon@redhat.com>
 <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cc2123 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xt6ew7UTAAAA:8
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=X55lTF6yM0CHJ4s2_v0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-ORIG-GUID: 8mdna5Pr7GAFxPLJFmOjXgXlkNEOiv0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NiBTYWx0ZWRfX35nuWrs+unEC
 9zYOWJJc7KStu2qVRjMs99SG5mm8xjyE0ZP3HMOrP8LMmC+zUrEiIKjVDy7gF4A1l7CkuGXnide
 4p3lYy4FSB3WFOsjNOZcqFEBL8CeW+/x0sN5IYP+gYzPgBhFsPQjZ7N3XiR2y+E5HBkPgM0QmXw
 Kj9NQZXqqXm4Xz+GYXl9sKjKJk+MrqptK/tdGc2qeeJAOFCYIZaFyoVMYfqyWcfiMTDTDHtiJ/B
 /2ugVMNbj3HWCzy1lk3f38oOH5q9KhMy3MGnj3pSRVBEtxatWb7/zAZqX/DsHfuBASJ19W3IZ7b
 3Ftf2YbKhv3O/pMpdJsh3YFzpiKngsITjCEj2l4dcC9wb0Vze9I3CBagjqnE/c8BpIeiFx4y2Vy
 h3X/blrMbmv8sB7dSqHYrYuVcU8i2p+7mi0QkKQqHf+qzMRAB4IXQzs5t+Lp0kSDBtin23wNWbB
 xzf1IUlZNQcBxdHcP5g==
X-Proofpoint-GUID: FtBFCdU0KBXMHXoZ-XoCx_C1jqj6UZCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310186
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 3/20/26 2:57 PM, Stefan Berger wrote:
> 
> 
> On 3/19/26 9:53 AM, Arun Menon wrote:
>> - Double the size from 4096 to 8192 so that we can have bigger buffer
>>    enabling support for PQC algorithms in the TPM TIS interface.
>> - v185 of TCG TPM rolls out PQC algorithm support. [1]
>>
>> [1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/ 
>> document/previewpdf/45151
>>
>> Signed-off-by: Arun Menon <armenon@redhat.com>
>> ---
>>   hw/tpm/tpm_tis.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
>> index 184632ff66..0df35d5a54 100644
>> --- a/hw/tpm/tpm_tis.h
>> +++ b/hw/tpm/tpm_tis.h
>> @@ -33,7 +33,7 @@
>>   #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
>> -#define TPM_TIS_BUFFER_MAX          4096
>> +#define TPM_TIS_BUFFER_MAX          8192
> 
> Unfortunately TIS uses a fixed-size buffer that would now become bigger:
> 
> typedef struct TPMState {
>      MemoryRegion mmio;
> 
>      unsigned char buffer[TPM_TIS_BUFFER_MAX];  <-- now 8192; before 4096
> 
> 
> static const VMStateDescription vmstate_tpm_tis_isa = {
>      .name = "tpm-tis",
>      .version_id = 0,
>      .pre_save  = tpm_tis_pre_save_isa,
>      .fields = (const VMStateField[]) {
>          VMSTATE_BUFFER(state.buffer, TPMStateISA),    <-- now 8192; 
> before 4096

This will have to become VMSTATE_PARTIAL_BUFFER and the rest is saved 
with VMSTATE_BUFFER_START_MIDDLE if necessary.

>          VMSTATE_UINT16(state.rw_offset, TPMStateISA),
> 
> Problem would be if an older version of the TIS (with size 4096) then 
> receives this 8192 buffer, we would (probably) get a buffer overflow.

I created 2 more patches for the TIS. It's now also in my branch here:

https://github.com/stefanberger/qemu-tpm/commits/crb-chunking/

Both TIS and CRB can now transfer >4096 bytes packets.

> 
> 
> 
>>   typedef enum {
>>       TPM_TIS_STATE_IDLE = 0,
> 
> 


