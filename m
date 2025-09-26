Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2927CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 17:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2CeJ-0000qL-Qz; Fri, 26 Sep 2025 13:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v2CeH-0000pi-LE; Fri, 26 Sep 2025 13:54:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v2CeA-00023x-50; Fri, 26 Sep 2025 13:54:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFFPf0005140;
 Fri, 26 Sep 2025 17:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F9LYBP
 /VflRRas7t9x0D9L2z/whxbLS4mwzjRhekbkg=; b=j0EfoWwRxroAM3AFaxQWR8
 EK9z9edTvgaXIsKYHGhy9bCUyTOvmlyo3QZ4nMZFy9B1OlbZ77YZGUInObVcIWT5
 MJmvot5WUvnNLtUYJ20VWVmLHoI8RZK8bZLn4g+lG/u/eJT/tDIK/fqgqaJd2vo0
 eklvgjPaHZ0jVEb28dT5YkofEFjMySg3I0JxxJCSp2KcnbL7AHY8O+buiFXcSu3d
 0bntmHEEQf+RLefh5+7dc3i2rlTsm3w9ms1wzsBWPK5QF5u5E6em9IbcEvUfdKWP
 h31C4Ai+VEPJstW6v0R4QavQWI2imv0SFq6JoJKC3pXM4q7Pk2cwTioIjRbho40g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb6pavh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 17:54:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHPbcu014297;
 Fri, 26 Sep 2025 17:54:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm5e4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 17:54:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58QHs5Ep49807638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 17:54:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D257E58054;
 Fri, 26 Sep 2025 17:54:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E1965803F;
 Fri, 26 Sep 2025 17:54:05 +0000 (GMT)
Received: from [9.61.249.51] (unknown [9.61.249.51])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Sep 2025 17:54:04 +0000 (GMT)
Message-ID: <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
Date: Fri, 26 Sep 2025 10:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 thuth@redhat.com, alex.williamson@redhat.com, clg@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <87qzvtstd7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MfBhep/f c=1 sm=1 tr=0 ts=68d6d33f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=5v1K1Rb0MuaBW23iG4QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9C569_T8PF_qMPkjbpa5Bnut3PfazkhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX5FjNgyLgpozw
 e8ByHNh1DPwATSu1id/z/AXVl51mHnKUUVON1Ht5ONHtAUlVGEBYAMTq7tm41IZswSVW8gEIxou
 zbY/9SjT1u3f+eIm+RYZlmSP7JpleUptGPWOlDJk5WINBSEaK7FTafkmXJrO7L7UDtV4y19oVMH
 t8j6YvEujMtzjiIueqkWzjnMKR9HD37FXI/yO5Wxf+nWH3h5dzrufa1BDD4CHqW3l2JaqG/GsHi
 KibUZXOYTi5Whafbz3nmI5WnrfXQ5YgbwhHRIM140P+HZuFnhjdcN9tSixavyybuV8R5TU4dIpI
 SiSEGiwlDd4t8+rsE8N+WhQk9Z+5xNnMyL1C/NVv7HMb4SfaEIcpPfIYiMNFtWvxl0KwwY1m0e+
 fb2IwgQWdQVoyR2NVbWbLkBa4fBMxA==
X-Proofpoint-ORIG-GUID: 9C569_T8PF_qMPkjbpa5Bnut3PfazkhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/25/2025 9:57 PM, Markus Armbruster wrote:
> Farhan Ali <alifm@linux.ibm.com> writes:
>
>> Provide a vfio error handling callback, that can be used by devices to
>> handle PCI errors for passthrough devices.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c | 8 ++++++++
>>   hw/vfio/pci.h | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index bc0b4c4d56..b02a974954 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>   static void vfio_err_notifier_handler(void *opaque)
>>   {
>>       VFIOPCIDevice *vdev = opaque;
>> +    Error *err = NULL;
>>   
>>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>           return;
>>       }
>>   
>> +    if (vdev->err_handler) {
>> +        if (vdev->err_handler(vdev, &err)) {
>> +            return;
>> +        }
>> +        error_report_err(err);
>> +    }
> This is unusual.
>
> Functions taking an Error ** argument usually do so to report errors.
> The rules spelled out in qapi/error.h apply.  In particular:
>
>   * - On success, the function should not touch *errp.  On failure, it
>   *   should set a new error, e.g. with error_setg(errp, ...), or
>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>   *
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>
> If ->err_handler() behaved that way, it @err would be null after it
> returns false.  We'd call error_report_err(NULL), and crash.
>
> Functions with unusual behavior need a contract: a comment spelling out
> their behavior.
>
> What is the intended behavior of the err_handler() callback?

Hi Markus,

Thanks for reviewing! The intended behavior for err_handler() is to set 
errp and report the error on false/failure. With the above code, I also 
intended fall through to vm_stop() when err_handler() fails.

I think I misunderstood the errp error handling, it seems like the 
correct way to do what I intended would be

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b02a974954..630de46c90 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void *opaque)
      }

      if (vdev->err_handler) {
-        if (vdev->err_handler(vdev, &err)) {
+        if (!vdev->err_handler(vdev, &err)) {
+            error_report_err(err);
+        } else {
              return;
          }
-        error_report_err(err);
      }

Please correct me if I missed anything.

Thanks
Farhan

>
>> +
>>       /*
>>        * TBD. Retrieve the error details and decide what action
>>        * needs to be taken. One of the actions could be to pass
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index e0aef82a89..faadce487c 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>>       EventNotifier err_notifier;
>>       EventNotifier req_notifier;
>>       int (*resetfn)(struct VFIOPCIDevice *);
>> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
>>       uint32_t vendor_id;
>>       uint32_t device_id;
>>       uint32_t sub_vendor_id;
>

