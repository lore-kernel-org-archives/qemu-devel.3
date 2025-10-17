Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DF0CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 04:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9cSM-0003Xd-Fb; Fri, 17 Oct 2025 00:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9cSI-0003WX-SE; Fri, 17 Oct 2025 00:52:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9cSE-0003zK-SS; Fri, 17 Oct 2025 00:52:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLU2Bv010215;
 Fri, 17 Oct 2025 04:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V/dHWB
 b1BNdqYFr3DdmmRX4nGLf3wutMCJN1bMcaups=; b=Hbbw3gqze88/vrpwG1fnU4
 I3qhhucdOm3E2yHFVL2RYJo2CtiJzS3D2ZfK/3gBFbGdr8XxgKGlO0USWEMpNrJO
 6zeG5vmjFqETa4rBPO6Hk54GiP6QKKwfjzheHRXBGu/SzQ+XMn3gmu6ZNUPIfrQ3
 WeM6H24tACzils6O0dJTdnukfw7cpX8SvUZK1ZHKf8qTUh5xpJu7YTbQ5XNpHsBN
 X0Ji5LKiASfI+n/8eF+uURWfNC46dl9Ze6XEJmiau0EmdjxLTRvlBp1NB4Zqgmox
 lLq4sy86x0yRIScTFSCdQRjKf1MxtxZas/Mu+5eTboAub9FWvva9iq+w/ysC8stg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuet97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:52:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H4mKGM019271;
 Fri, 17 Oct 2025 04:52:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuet8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:52:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H0ZNXl003613;
 Fri, 17 Oct 2025 04:52:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy9fvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:52:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H4qM4b40763804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 04:52:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11C3320090;
 Fri, 17 Oct 2025 04:52:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04ACF2008F;
 Fri, 17 Oct 2025 04:52:20 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 04:52:19 +0000 (GMT)
Message-ID: <3099333d-f5c2-40d5-8d87-314c90cd2647@linux.ibm.com>
Date: Fri, 17 Oct 2025 10:22:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/core: Pass errp to load_image_targphys_as()
To: Alistair Francis <alistair23@gmail.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com, alistair@alistair23.me,
 alex.bennee@linaro.org
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-6-vishalc@linux.ibm.com>
 <CAKmqyKME2SWuE0LjcgcxuR=vLLnKfqUkB2DsvuTxVgX9QrxTDQ@mail.gmail.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <CAKmqyKME2SWuE0LjcgcxuR=vLLnKfqUkB2DsvuTxVgX9QrxTDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zTIHHnjO9-qflJRSHK70AGhpbYcKJWQ1
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f1cb8c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=JF9118EUAAAA:8 a=hIcB_HTkvoYA2ucdpecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HbS5m-eWJxCKbjJfvC8VQjn7YSLlowNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX+X+4UAC4qkP9
 soZsFLCi2Rdzst7+FoOetcXbzZO/iGWrn5awmfFJFRm51xj7eAv6V2K024H5d06r2VJiW/vqgz/
 V/z9VviDx+BOFOOvIuO01tlN8mE33bIFvM7Flig2Jlya5gITyN+ihLLh6sUJPVXzH6bQg3i4Ku8
 TPgbEeH6sIQgNtfYwK4oDrIHahv1+VISYw/4pRL0Q5K7Hn5FAY6bTw93IoolVBVlvmwBl+7yC+R
 GhBagkouQEEPZXTHBZHZ93OZ1SpkHycXyDVBjDPVHSdsdSubAlsxRY+Q2SaKrcXHDSXH1E8cUEO
 fqN3c0FwHwzqYg0ZUoKlN2qhVqNU1vQZtUCVA5wILD2OqAWzw0PHu8Pelu0R+pfVPb0pj0uE4aC
 ii8PsalJy0jHMaH+WYH92ThTqAT7HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thanks Alistair for the review.

On 17/10/25 04:29, Alistair Francis wrote:
> On Fri, Oct 17, 2025 at 3:41 AM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>> Pass errp to load_image_targphys_as() in generic-loader and
>> guest-loader to capture detailed error information from the
>> loader functions.
>>
>> Use error_prepend() instead of error_setg() to preserve the
>> underlying error details while adding context about which image
>> failed to load.
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

I have one more change to be added to this patch.

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 433efb7387..c69c857ed4 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -155,7 +155,12 @@ static void generic_loader_realize(DeviceState 
*dev, Error **errp)
          }

          if (size < 0) {
-            error_prepend(errp, "Cannot load specified image %s: ", 
s->file);
+            const char *msg = "Cannot load specified image %s: ";
+            if (*errp) {
+                error_prepend(errp, msg, s->file);
+            } else {
+                error_setg(errp, msg, s->file);
+            }
              return;
          }
      }

Similar change has to be done in guest-loader.c
I will include it in v4.

>
> Alistair
>
>> ---
>>   hw/core/generic-loader.c | 4 ++--
>>   hw/core/guest-loader.c   | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>> index 6689847c33..433efb7387 100644
>> --- a/hw/core/generic-loader.c
>> +++ b/hw/core/generic-loader.c
>> @@ -149,13 +149,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>>           if (size < 0 || s->force_raw) {
>>               /* Default to the maximum size being the machine's ram size */
>>               size = load_image_targphys_as(s->file, s->addr,
>> -                    current_machine->ram_size, as, NULL);
>> +                    current_machine->ram_size, as, errp);
>>           } else {
>>               s->addr = entry;
>>           }
>>
>>           if (size < 0) {
>> -            error_setg(errp, "Cannot load specified image %s", s->file);
>> +            error_prepend(errp, "Cannot load specified image %s: ", s->file);
>>               return;
>>           }
>>       }
>> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
>> index 59f325ad9c..618455e556 100644
>> --- a/hw/core/guest-loader.c
>> +++ b/hw/core/guest-loader.c
>> @@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
>>
>>       /* Default to the maximum size being the machine's ram size */
>>       size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
>> -                                  NULL, NULL);
>> +                                  NULL, errp);
>>       if (size < 0) {
>> -        error_setg(errp, "Cannot load specified image %s", file);
>> +        error_prepend(errp, "Cannot load specified image %s: ", file);
>>           return;
>>       }
>>
>> --
>> 2.51.0
>>
>>

