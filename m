Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980A3C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 14:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEtv-00079B-8I; Wed, 14 Aug 2024 10:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1seEtt-00077o-NY; Wed, 14 Aug 2024 10:22:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1seEtq-0003Kz-W6; Wed, 14 Aug 2024 10:22:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EDEvO3019961;
 Wed, 14 Aug 2024 14:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=F
 W990GYEJ3HqYuhDLff0vU2pFNIlHHQ+Xwx3BayWMps=; b=IZEPtQVXD+pWNuhEW
 ekyb1OHRvbx4yiqov8BS8uGXSUWTB4d21ThP9I1mf92H470w+x9cOSQBQfwkFbMw
 cZmtPijcGDxIgjo7NbvHGfHFIBBTEC/m43zlDV1VvM6AGWNSrq9oPDHX4iDHnoDR
 EYK3O2/p06kSViBUpXopq+GGMZc64BVYChr+xQctTggsCcAA+kig+KtH3tp+8LRm
 vU2JrpdYxUvncgKovyXDIif19R9k8tleM2CnR02l06F7QILzlZNvNxmjhLPDBTOF
 X0FtAliX1xP3zMRSrLo94/44Bdqevn3Omrd37CZFkQFt3gmqZWjGUZsL/RT9QTNF
 diomg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410w9u0a4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 14:22:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EEMo94031803;
 Wed, 14 Aug 2024 14:22:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410w9u0a4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 14:22:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47EECpcq015321; Wed, 14 Aug 2024 14:22:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1msnh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 14:22:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47EEMh2Y49545698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2024 14:22:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B39020043;
 Wed, 14 Aug 2024 14:22:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1DA720040;
 Wed, 14 Aug 2024 14:22:42 +0000 (GMT)
Received: from [9.179.20.40] (unknown [9.179.20.40])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Aug 2024 14:22:42 +0000 (GMT)
Message-ID: <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
Date: Wed, 14 Aug 2024 16:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wDlJRhf0GlXO-kDkcn4Ga9SUoVWnXzCR
X-Proofpoint-ORIG-GUID: 8J3AF_DrORPuMgrjLN5ptqVr0yo2MlYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 13.08.24 um 18:52 schrieb Peter Maydell:
> The main aim of this patchseries is to remove the two remaining uses
> of device_class_set_parent_reset() in the tree, which are virtio-ccw
> and the s390 CPU class. Doing that lets us do some followup cleanup.
> (The diffstat looks alarming but is almost all coccinelle automated
> changes.)
> 
> virtio-ccw is a simple conversion, because it's a leaf class and no
> other code interacts with the reset function. So we convert to
> three-phase and resettable_class_set_parent_phases().
> 
> The s390 CPU is trickier, because s390 has its own set of different
> kinds of reset (the S390_CPU_RESET_* enum values). At the moment we
> have a single function implementing the reset, which always chains to
> the parent DeviceClass::reset, and which can be called both from the
> CPU object's own DeviceClass::reset method and also from other s390
> code.
> 
> I opted to handle this by adding two new S390-CPU-specific reset types
> to the Resettable ResetType enum.  Now instead of having an underlying
> implementation of reset that is s390-specific and which might be
> called either directly or via the DeviceClass::reset method, we can
> implement only the Resettable hold phase method, and have the places
> that need to trigger an s390-specific reset type do so by calling
> resettable_reset().
>                              
> The other option would have been to smuggle in the s390 reset type
> via, for instance, a field in the CPU state that we set in
> s390_do_cpu_initial_reset() etc and then examined in the reset method,
> but doing it this way seems cleaner.
> 
> The rest of the series is largely cleanup. Some small stuff:
>   * remove the now-unused device_class_set_parent_reset() function
>   * remove some CPU state struct fields in alpha and hppa that
>     were simply unused
>   * fix an accidental comma in xilinx_axidma that confused a
>     Coccinelle script
>   * hw/remote/message.c should not be directly invoking the
>     DeviceClass::reset method
> 
> There are also patches here which convert devices from directly
> setting:
>     dc->reset = my_reset_function;
> to using a function call:
>     device_class_set_legacy_reset(dc, my_reset_function);
> 
> The conversion is entirely scripted using a coccinelle patch, and it
> is responsible for the large diffstat here.
> 
> If people feel this is unnecessary churn I'm open to that argument,
> but my motivation here is:
>   * it means that people writing device code see the "legacy" word
>     and get a hint that a new QEMU device probably should be using
>     something else (i.e. Resettable)
>   * it makes it easier to find the places in the code that are
>     still using legacy-reset with a simple grep
> 
> In particular, having done that makes it easier to rename the
> DeviceState::reset field to DeviceState::legacy_reset, and that in
> turn is how I found that hw/remote/ was still directly invoking it.
> 
> The last patch removes device_phases_reset(), which was the part of
> the reset transition glue that supported "device is reset via the
> legacy reset method but it is a three-phase device".  Now we know
> there is no way to directly invoke legacy-reset any more, we can drop
> that bit of glue. (The opposite direction, "device is reset via a
> three-phase-aware method but only implements the legacy reset method",
> is still supported.)
> 
> I am pondering the idea of a further Coccinelle-driven conversion
> of device_class_set_legacy_reset() calls into three-phase setting
> of the Resettable hold phase method. This would be a zero behaviour
> change, but the difficult part will be where we have devices
> which make direct function calls to their reset function as well
> as registering it as the reset method; I'm not sure if Coccinelle
> can do "match functions which are not referenced elsewhere in the
> file" checks.
> 
> Note that my testing here has only been "make check" and
> "make check-avocado", which I know doesn't really exercise reset
> very heavily.

Nina, can you have a look at those patches?


