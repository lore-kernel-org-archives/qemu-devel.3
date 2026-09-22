Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F83C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x931Q-0006Ul-D1; Tue, 22 Sep 2026 12:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x931D-0006QT-4A; Tue, 22 Sep 2026 12:06:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x931B-0006XS-GX; Tue, 22 Sep 2026 12:06:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5YOI3768271; Tue, 22 Sep 2026 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cXySDV
 x/cPVuPte31ohl4b7fZIQ5KgM0ApDEbaT6BIo=; b=Al+u3iiavzgKQKl0v7u4Ou
 YztsLp02G7+3hveKwTbSay+Opt/pcTGI2TJQ8ezabhkrkCK+kgFa0u6u59SPmnVA
 Px8urm38dFuIGkUSDAztPFUgtCmIeqPx9TRyJ0yK1oLkb/lQLyQoU6d4fwdotg3C
 8ehAqfKI8tO/6dfZVTuQ5CHJ9iy6XNzoiRGE5d7aaXBl+x7uwGtC54OClz6jsQyu
 txpG5xXsGgFz6q/WD1L+lGPqvj9x+JXZEWHqZV2FyS87zPUAFJYiGpLn65zVWW2d
 rPljmr/eCD7Irf27mq4DXwVw1vRyIOSVtV3d/5rSTjsaOMtaNq+aYqkmhzeCHH4g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqee5b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 16:06:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEmCu81738380; Tue, 22 Sep 2026 16:06:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkd3cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 16:06:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MG6njg22414038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 16:06:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AEF85805E;
 Tue, 22 Sep 2026 16:06:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43DEA5805B;
 Tue, 22 Sep 2026 16:06:48 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 16:06:48 +0000 (GMT)
Message-ID: <8f8f5a82-fad1-4943-9c7b-cc99d3bf3f4f@linux.ibm.com>
Date: Tue, 22 Sep 2026 12:06:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2a79b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wT3z3fLtLi6pCf_uqfoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzNSBTYWx0ZWRfX7mwcIADKcrkf
 MBR0+foLkpXM1NfFTglVhyBQgnR7YlMs4OoyGNa+xTKC4sAiQhI6GcL+0/vAYXXBDq8sBEkiRjp
 RNsRtgb9X/Fjp6uX+D8PMpuKsFDzIH8L/JKyQzP5UdVU0tBcJeauog1gGEi0LCgeqDIYoWq2o4d
 WmnEqJjVDl4sK5U3tBshYqEChBzQTT9wieIi6/OuC8YCITziFgAX8SbuVSzQ5fath8RLvFiFXif
 LT1BPwTqHz5v8RrAN/tfBDCR17pjg3byUZRVYyzUGWzPSwhX02Iezhix9P3fmL/AeBXyIT9I02t
 Y0oZ3ZoqMcnxWfpJtEH74xemjZbdPA2SiD6VE3wv8OT7iCWaEE4pAO/8mS+7hGuwGbhhudhNQm+
 D1HrSfwpGDeE6xo92OdM83flxyOIkcaWMkZR/0tzX3M/+/zrwG6T4ZJmjH9n0SNg0n+7mWkG0CQ
 GN5vtXZvAHHNAB/RsTA==
X-Proofpoint-ORIG-GUID: dwqUsrpSiWL2u-8UjxXOkSnYPS_5Czsk
X-Proofpoint-GUID: dwqUsrpSiWL2u-8UjxXOkSnYPS_5Czsk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzNSBTYWx0ZWRfX6O4xw378Brt6
 qkQiEorZJlyDh3NoGDeY1rrP0Jid+IkeVpz1z+QFbyfYF5o/mL48gu6TUPkPRQvFD9EFBY4A6lC
 PbnZaz8U+P5q9nsIZAuAzwGdjXWb1/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220235
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

On 9/14/2026 3:34 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   tests/qtest/pxe-test.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index 8b6015b6cd..c29386ed4b 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -129,9 +129,16 @@ static bool s390_bios_has_net_ccw(void)
>       return s390_bios_has_string("Network boot starting...");
>   }
>   
> +static bool s390_bios_has_net_pci(void)
> +{
> +    return s390_bios_has_string("Setup failed for virtio-net-pci");
> +}
> +
The presence of this string in the bios img indicates that virtio-net-pci
support has been implemented (this string is added in patch 4).

Maybe a clarifying comment would be helpful... the fact that it's a failure
message disoriented me at first. :)

>   static testdef_t s390x_tests[] = {
>       { "s390-ccw-virtio", "virtio-net-ccw",
>         .boot_dev_support = s390_bios_has_net_ccw },
> +    { "s390-ccw-virtio", "virtio-net-pci",
> +      .boot_dev_support = s390_bios_has_net_pci },
>       { NULL },
>   };
>   


