Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B30C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qVR-0001XC-Pz; Thu, 24 Sep 2026 16:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9qVP-0001WT-Ri; Thu, 24 Sep 2026 16:57:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9qVN-0005op-Vu; Thu, 24 Sep 2026 16:57:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5de72914250; Thu, 24 Sep 2026 20:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kQJXQw
 kQhhmKnMUAXJFr1ROuFBQuBYDzUW/tLh7Mkzw=; b=mKeoDDwmi560YXNhwhpozk
 X6Ql4cO7hU+fMChHQ9yswvpnLMwf16ATnhYSCk6gWudpnCJEIcbWy2LY1QoB0X5P
 ynOXrymmc1hCAkTyB+RxvBeMrH+u/YFVBx4v16Kay5y0c98uMP9JHlEVBYOKoIY2
 Fk1wxOkRdgSShVubdHZiT8JzYEM6//1SH5Fm6kMhkppjMkOy7ttfb4+tf0I1+lZT
 n69fJ0uLdddFd+dTbs9/PE7rk1uVpe+x9WSMCEeTFEW9Rg7gD1Bj6XSU+Oa1d4C1
 zhpnYX7EKsEZiL2MwkcVZz52QQrrwVBGml+A/7W/ccHIjAQW7KYZ2J6plhBsnARg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1tvd5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:57:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlVSC1233764; Thu, 24 Sep 2026 20:57:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ebxm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:57:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OKvIlg11338336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 20:57:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C7E35805D;
 Thu, 24 Sep 2026 20:57:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB37758054;
 Thu, 24 Sep 2026 20:57:16 +0000 (GMT)
Received: from [9.61.83.151] (unknown [9.61.83.151])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 20:57:16 +0000 (GMT)
Message-ID: <b1e671ba-595e-4ea8-9e75-4749dc254184@linux.ibm.com>
Date: Thu, 24 Sep 2026 16:57:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-7-zycai@linux.ibm.com>
 <d38eaf1a-2b72-462b-a4d1-db1d5e531532@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <d38eaf1a-2b72-462b-a4d1-db1d5e531532@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8n9oPoXINhMv8W_JKy20RVnjynB7mkRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NCBTYWx0ZWRfX7pW+Gc9n4h9y
 7zNCNrCSGzlSG3R8AAjgmVaD/r1QC7YIG03KYcaITpyIHeOiD70mRH7WI9Z/GsTEu/6Z3RqSmSe
 Y+Qmg83e39ZhRZq12ZP6de9qs7TUU7bMM8SyUz9zicc6lnFJcntZWP062eEMeRK7uszc8h/wpb4
 rr6Lo/LM49O6i/zZFhn30WGKdsxa0FgkJY/xZwNQAyvjhY61CNlldle4W7yMOzEsCXg7Cg6CSyu
 KGKom4+BWHO29O2BR+7GegQgRWQoWoJZsIV5MV/kMlYu6pAJwhe3EJlhjv+5DObuS2Ox2OMXAy6
 Du4I3mHEcdaYOw90al4VRgbulWQkCCRDgYBWy2P1+3f2RfTp2ehHA70F8gxkvSilmuKZgSOQIUr
 vaEn1u5toDxFdpnUg6NOr/0TGEdp/viZmScwFpcnCGuJHV6Yih4MOCAWVXZoEpiF595321O6mfT
 zVZMQDWD6EH4fnej28g==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab58eb0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=JyfQK4TMPtnT4apVw0sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NCBTYWx0ZWRfXxivvjMhrfp5z
 ihyUUcsFQZdREMqGMzE7BMCI/nmw9p9fZMC1RwpOZRROj2KnA0onPC+5j7IbgqCocUazAgZZey8
 o3zJZ0q2UV7Yzjywz40U6w79EHfkDsY=
X-Proofpoint-GUID: 8n9oPoXINhMv8W_JKy20RVnjynB7mkRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/24/26 4:25 PM, Matthew Rosato wrote:
> 
>> +
>> +static bool s390_bios_has_net_ccw(void)
>> +{
> 
> Since you'll need to respin anyway...
> 
> Sorry, I think there was some confusion about what I asked for here.
> 
> AFAIU checking for this string is going to unconditionally work as long
> as we enter netboot code, before we even decide if -ccw- or -pci support
> is actually available.  That's why you don't use this test for
> virtio-net-pci.
> 
> Your old comment block said virtio-net-ccw support has always been there
> (that's not strictly true)
> 
> So rather than removing the comment block, just reword it to explain
> that the test just assumes virtio-net-ccw support is always available
> and only checks that netboot started, it doesn't try to verify ccw support.
> 

Thanks for the clarification. I misunderstood your previous comment and
removed the comment block since we assume virtio-net-ccw support is
present. I’ll add it back and reword it accordingly.

>> +    return s390_bios_has_string("Network boot starting...");
>> +}
>> +
>>  static testdef_t s390x_tests[] = {
>> -    { "s390-ccw-virtio", "virtio-net-ccw" },
>> +    { "s390-ccw-virtio", "virtio-net-ccw",
>> +      .boot_dev_support = s390_bios_has_net_ccw },
>>      { NULL },
>>  };


