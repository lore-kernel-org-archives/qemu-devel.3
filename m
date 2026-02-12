Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D26EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRnL-0007HQ-3Q; Thu, 12 Feb 2026 03:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1vqRnG-000724-Ja; Thu, 12 Feb 2026 03:11:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1vqRn9-0001f2-70; Thu, 12 Feb 2026 03:11:18 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61C741Se473751; Thu, 12 Feb 2026 08:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yjfa6u
 v49QtMRaF3SlKO3vrCze1iA8OBjO2iYItTUR0=; b=IVoQ9exyhWuBraoYxvuLAW
 2UoB7WMNJDZPoHRkTU5U8ir7YIccUYAb231nkSIR+LmGsbVdjeDL0o/zj1ziwUfT
 oNJcrn/05YCJTBB/8S6Zhjo521hLhOsjGUFr10BtFD9e7eItpOp/qhkOubiqEZtG
 j63R7tG4aVDmnAxLt3oS/3aS3jZDsQKPcU2RcjXubyoX8LcYuWP3cAI6mkKUNuzN
 BC8xWFJFLucc4P8PAYlL8qTADuMXlkeUFUHUUcDtHei6q9ygsvBM5nN3sC9miNzv
 k3uN6L/0U95Jdzm5W0UpBB/F3m3sKa61RRIc9vrMSC2K5VfltlqesKQaByW16JQg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x2g0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 08:11:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C5JLXD001825;
 Thu, 12 Feb 2026 08:11:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je2970p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 08:11:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61C8B25m56623386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 08:11:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE632004D;
 Thu, 12 Feb 2026 08:11:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7134920040;
 Thu, 12 Feb 2026 08:11:02 +0000 (GMT)
Received: from darkmoore (unknown [9.111.23.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 08:11:02 +0000 (GMT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 09:11:14 +0100
Message-Id: <DGCTXWV8JGW1.25EN8P8FZ4GP9@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Halil Pasic" <pasic@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Eric Farman" <farman@linux.ibm.com>, "Matthew
 Rosato" <mjrosato@linux.ibm.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "David Hildenbrand" <david@kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Cornelia Huck" <cohuck@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Hendrik Brueckner" <brueckner@linux.ibm.com>, "Nina
 Schoetterl-Glausch" <nsg@linux.ibm.com>,
 <qemu-s390x@nongnu.org>, <kvm@vger.kernel.org>
To: "Thomas Huth" <thuth@redhat.com>, "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] s390x/kvm: Add ASTFLE facility 2 for nested virtualization
X-Mailer: aerc 0.21.0
References: <20260211-astfleie2-v1-1-cfa11f422fd8@linux.ibm.com>
 <696de68c-6422-4a1f-a462-808a891c4aca@redhat.com>
In-Reply-To: <696de68c-6422-4a1f-a462-808a891c4aca@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698d8b1b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=cK_2QuFJinR_CRx2KsQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WJCBRCKt3L2kH-hCL8TeQGU8IbcQ45aF
X-Proofpoint-ORIG-GUID: WJCBRCKt3L2kH-hCL8TeQGU8IbcQ45aF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA1NiBTYWx0ZWRfXw0/s+OHLtEnH
 y7xJQQ4+EGXfx77zFygpSegqIyBkf+5XYPxI3OhJqP9u8lc8EK7ddD+PFsm5zlbke64RtyVW/TS
 /gXXV33YN+9Vy7JQvGaICa/El4WKKDVNgFnUr10+yL6v7ruSyybtH2zMCE+BhXk4YF8rAzL+C0a
 1SGgMWuhfcReF59P39Qi6YXNAW8xmgFS/JjuRkSZ2xqYoLj13VD7KWeiChoRqMZLoRXFu1wBx7y
 CLt3ImvXjV6L1Nh7aX12Pl9WlDqhhnGHCsdmTFRAzMNOnxDIAc3k/KWGkUd+Op4OyaLQLupEyiX
 4PxgLAUlTvtFNkZuKjBcHBV5KaKsrIkAzXSb+6bDB2SZn9NgLujBKrK0mjg8yeIgd6nzkCz29+B
 9RkIGm1sohxwGbC4wl2//QhpOiwjhmPzbnJDhENeKr7hsRc9qbCY1ywZvHG2M1tnH5Dproge0/H
 uyc7nbfLeNU95w+qS9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120056
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schlameuss@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Wed Feb 11, 2026 at 5:00 PM CET, Thomas Huth wrote:
> On 11/02/2026 15.56, Christoph Schlameuss wrote:
>> Allow propagation of the ASTFLEIE2 feature bit.
>>=20
>> If the host does have the ASTFLE Interpretive Execution Facility 2 the
>> guest can enable the ASTFLE format 2 for its guests.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
> ...
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>> index ab5a6bce590c722452dac5aeb476bd1969d2235b..45a6d0a7406a3f1b71026c49=
e00ac25a6fc620ef 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
>>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>>   #define KVM_S390_VM_CPU_FEAT_KSS	13
>> +#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
>>   struct kvm_s390_vm_cpu_feat {
>>   	__u64 feat[16];
>>   };
>   Hi!
>
> Please don't send updates to linux-headers/ embedded in patches, such=20
> updates should go via a separate patch instead that has been created by t=
he=20
> scripts/update-linux-headers.sh script.
>
>   Thanks,
>    Thomas

Ah, yes, thank you for the headsup.
I will split this up then into two proper commits for the next series
version. I will just wait for some more feedback before sending that out.

