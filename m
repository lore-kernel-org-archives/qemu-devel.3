Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6C2FD45F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMnt-00072F-RH; Wed, 25 Feb 2026 16:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vvMnf-0006wF-B5; Wed, 25 Feb 2026 16:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vvMnc-00065W-P1; Wed, 25 Feb 2026 16:52:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PDXbt72346014; Wed, 25 Feb 2026 21:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OHz+fy
 BizV6nhTTB5lfuPhhumXCAFawYL/p8RyzpxRE=; b=ij8lhCSgUjkVPCJ7ESm7zh
 mOsuuGOb2iso3C/2so96dCeFqDU3tuMI9hQdkuBnbeVq1GbgVsyxE5ltLrjw9ZjE
 gAI23ZmXeZiwi8i0wFYSgoO81c/DmfG3Rb/EW6p4luBstb2rH84XwJHH27hRP3/a
 3lUJ/CRjYJlce1M76HyYKYjP0oSrRboqhCiGSmMFNVZwKwUgXSbLzvw/6QKWPnLB
 mXMPZuU1K6FkFeEjlDbHPPqKvPbmGb0pritAi1nkvHEs6Vxo5eK2J3+d4aksN9vC
 BaP4m6kKiLGI65CTTkX61uizbgEeV2YzXzQc8S0sYggOCbxckfWCsFoeaMkyenRw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858r5my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 21:51:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PJt1Nh001674;
 Wed, 25 Feb 2026 21:51:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n7mx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 21:51:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PLptMV15729196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 21:51:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F3FA58058;
 Wed, 25 Feb 2026 21:51:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FCB758057;
 Wed, 25 Feb 2026 21:51:54 +0000 (GMT)
Received: from [9.61.247.213] (unknown [9.61.247.213])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 21:51:54 +0000 (GMT)
Message-ID: <daaa9033-d77d-4c50-928f-c6dd521454f0@linux.ibm.com>
Date: Wed, 25 Feb 2026 13:51:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/s390x/s390-pci-vfio: Avoid including
 CONFIG_DEVICES in hw/ header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260225031658.32095-1-philmd@linaro.org>
 <20260225031658.32095-4-philmd@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260225031658.32095-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIwNyBTYWx0ZWRfX/4AgVNDPnnMJ
 gJEuiIOie4dFrrd9LSAd+M6HyYeiBZIUShtVNmyqgNOAYwupn4xrhEKIwLPyb9DIl95kzHNdd3+
 1yHL35vklN/gIbyntA1oH0Yp45DOgK/9fPnLmRZZ2Y/yjtTac40WndXs8vqNlSh5eLTu/gsl+pz
 /1aWaEkjdgTxIFeOcIjFIo7dey5/SKqXePA5oyWvsvC+W7xNSueSCk6IHWyxFyWlF+Li+Cnl7tr
 DX74ZCim6xPmFeMj7IjfSqwfDWb3BFpF0G2lSynjbzKsbKPLV2osvazWCe9efiv2sPJA3qFpkSY
 RExV51whJOysHr1eklnfgm19E2OlUYvqtYxezcOjhLyL2760OJczpF2ghJLjex/s4tTlj7SPD4A
 +XZvhylKQoik3l+L1tWNTDcqVcE/TRTfHeeFfsNqJtY5wwdRqFWbvWPIK/q48ymJvhwCvz0IFyP
 y+JicWSrz8A5gQItSuQ==
X-Proofpoint-GUID: vY8HiRRbF3Xtspqts-ubZ9ptwVCohxgW
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699f6efe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=vXjSkX5Mo5nDCvKCHo8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vY8HiRRbF3Xtspqts-ubZ9ptwVCohxgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250207
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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


On 2/24/2026 7:16 PM, Philippe Mathieu-Daudé wrote:
> By inlinining the stubs we can avoid the use of target-specific
> CONFIG_DEVICES include in a hw/ header, allowing to build the
> source files including it as common objects.
>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/s390x/s390-pci-vfio.h | 20 --------------------
>   hw/s390x/s390-pci-vfio-stubs.c   | 32 ++++++++++++++++++++++++++++++++
>   hw/s390x/meson.build             |  1 +
>   3 files changed, 33 insertions(+), 20 deletions(-)
>   create mode 100644 hw/s390x/s390-pci-vfio-stubs.c

This doesn't seem to break anything on s390x :) apart from the typo for 
"inlinining" looks good to me

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


