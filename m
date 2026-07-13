Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjH63-0000Zb-EI; Mon, 13 Jul 2026 09:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wjH60-0000ZG-UF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:53:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wjH5y-00057V-OD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:53:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DCDASt2434128; Mon, 13 Jul 2026 13:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HvD10D
 /7FFLhX6UC+OkK36xu6mlfEmvR/IMsU3CEHGg=; b=Hz9lQwSo46wLJjrEyKLK6A
 9BGpbDcRwB7tOzO9tgm9Gz5sWw4LsyIByblCd7ZoldW/fE0ACHOecBcvLUKmncUD
 6KmHMsUz8Q6Tkp1OTJJRZklYZRCsRxrzD1AqRRicAcRlic9snYVuaVdUb+H9f6Sg
 Et1yXFPwyW/oi5Jv/VAQdJZlF1tVI4ArwlnP9zIFmjddEPskxnOdDTRPu1/pF1GK
 +b9RC5P9mZKxaTgjlWmeTPevelWF79/rHijBAeAdcThfB38CKN8c82g0+WDAvrH9
 fA5zlOTUGTkPbx84rjSatkqHpVto3401mM9B3B0N+zylpnT16G59LnqsckF1iNvQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbgmmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 13:53:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DDnt6R023050;
 Mon, 13 Jul 2026 13:53:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5u5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 13:53:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66DDrBXR23200102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2026 13:53:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A1E20043;
 Mon, 13 Jul 2026 13:53:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BD0420040;
 Mon, 13 Jul 2026 13:53:10 +0000 (GMT)
Received: from [9.111.32.211] (unknown [9.111.32.211])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jul 2026 13:53:10 +0000 (GMT)
Message-ID: <1e02ef6d-2f36-4219-9c1d-680fd6426a67@linux.ibm.com>
Date: Mon, 13 Jul 2026 15:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what is qemu_system_guest_panicked() for?
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <87ik6ji3zl.fsf@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <87ik6ji3zl.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54edcc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KRiwUzRM81OJinXqfTIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0MyBTYWx0ZWRfXzcmR5lp/J55d
 uur9nLju9GTJ6HuIK7Ru19rEMR9/gxxkuGHTXx5DLTk8c8ezXvGlZ889EzVi8Y+lSMsrL8D5uQE
 cVVYr8W9xleBSAiFH6xRQQeh382gCd3+/S2UCD5DoMHUs1wmFbfXJleh5z7GRsXfOdTazCWK2ui
 D+ioc6+i1rld//CVx/rZE2AJ2IEbQK01LWOLhjU/8TlxnppxCFAMdN6OAuhM3/X5ff0toceDqyM
 7A3p4gbHJAtVL+16tgOOcYfzsoIJcbDpSc0iwvSl6/SlDe7nTFc6mHk2pH9FsZScz8HoQDsJGnc
 90ExxReM5hbzda2+TCY1AuVICIDES6xlcucnW5oqi6UaqDIdyluKmlGLxMnxtF4cGsSHEZQ46Oz
 +t4FJr4K8bN5QFarZIWmu/+P5MWMaJj08R9uXfK3QG6CEb3Mww+xyxjWDTtfG9iWM1PKWyrEJsY
 Hs50i1Ha340l5eTST6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0MyBTYWx0ZWRfXycd8hmgsSYMJ
 gpuudUUtAwORLzwbYBa/m1rG8B72hWNToFWH2ZHPAmlPlwL7AQFHbcLgb5s0hJHeNPx1kwK5VY+
 u5AptHt23J0Y2IffOEclpYVgR726Ibc=
X-Proofpoint-GUID: WRGCKFOLzLpMvalWkLQObb2fiwuvVAXL
X-Proofpoint-ORIG-GUID: kwAA1LAZ_OWBVWh1-wtS33fmLVvDMXwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130143
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Am 13.07.26 um 12:22 schrieb Cornelia Huck:
>> Cases which are not:
[...]
>>   - s390_handle_wait(): not sure exactly what this is
> 
> Loading a "disabled wait PSW" (waiting for interrupts with no interrupts
> enabled) is basically the way for an OS to "panic". (The "special wait
> PSW" is for signifying that a cpu has been shut down.) IOW, this is
> indeed the "panic" case for s390x.
[...]
>>   - s390 unmanageable_intercept(): again not sure, think this is where
>>     the guest has gone off the rails and we can't keep running
> 
> It's basically "the handling code for an exception immediately leads to
> the same exception", the cpu has gone into a loop and can't get out of
> it again. Not sure if that should be getting some different handling.
Right. I think having both cases in the same bucket makes sense.

