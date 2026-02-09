Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EC1E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNPL-0005T3-U5; Mon, 09 Feb 2026 04:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vpNOx-0005A9-Bi; Mon, 09 Feb 2026 04:17:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vpNOu-0007O9-Op; Mon, 09 Feb 2026 04:17:50 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 618LG5Hs199006; Mon, 9 Feb 2026 09:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PadODz
 NX9aucw/TIrx/umxpk2I7XwCBF1O3Oz0hs0xM=; b=lCm1ZTsH9vjFrGps04YpFi
 dsg+eUl0OVJPKEv5+X0aHpQT9njKfjiHfL68Y8NLRoVdbxtoYpz7C0h8tdPA60nK
 h+zfApui/ftj6UMX5Afl/QuShgWVGte+jYOScaw3Dvo3SfBl1D5eewZyg66qvp1n
 dBAAAonOqr0Ifh562G7sbnZCHr1rbXGdTbR3A/9QQZaEZEFOvHiw7AmRywNKc4j5
 k5f+AjBjSx1lBruFFbcfdd7u91WoO8aB3oXUwsK6rRgmtnZuvzNcfqTDHVPFCWyv
 WWc37HptUzgtsI0tYCvLGdv7mnKL65PkrCUBYG+iaabIsvcTTsn3l2BvH21eNegA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u6a2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 09:17:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6198a0xF001427;
 Mon, 9 Feb 2026 09:17:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqmvhy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 09:17:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6199HaJE51052934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Feb 2026 09:17:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 728F62004B;
 Mon,  9 Feb 2026 09:17:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3682920040;
 Mon,  9 Feb 2026 09:17:36 +0000 (GMT)
Received: from [9.52.200.54] (unknown [9.52.200.54])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Feb 2026 09:17:36 +0000 (GMT)
Message-ID: <e26286fc-219c-4798-bb41-3c3be7ef194b@linux.ibm.com>
Date: Mon, 9 Feb 2026 10:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix endianness for zPCI BAR values.
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com
References: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=6989a635 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=5dwcVOLGD4cZohy6t3cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA3NyBTYWx0ZWRfX7lv4UQa+3PYI
 ggLx+C92EIOlyIa/W0D41KWMfnvw0xN9GnPhxGkDd23MYWBtdx/g3PQTsVK71GY4+NxLe7IVyXD
 XdFZc9kzcymkiGDuSdRd7vfIrlG3Pp5r8Un4958+rRiNpH7aNP7iYvPG1TUVV4O9KNYfih+FjNu
 quGZcgGDz+etecPDTGdCupa4CuvFAC0KSRY7eJ/pdv49bkRlnNBUwsvlHiIwMCJNDUkOoIZa5bS
 rVauPZhNAZ5slmlesiDD2RR0pPzm5cmf5Uvf71+m2lbgOvdccjdq8MHufY9kfFPSVmgFUHarkcF
 YIT451n3IamSBmeod35GQNpjhe/IF9VmOuGCinLrBfF7d+brmHVqG7KbL9aWR/7xKcm5VNum9QY
 3WEun8rWbaVfaAS0MmjuW8EqDTlum4pcAukUao9lVmGDtVAmgKeI3sNBMZ6AqCreDwH1pIif8Ma
 PC2G03ZX8EF/VkywHiw==
X-Proofpoint-ORIG-GUID: wOnS7qmb9VsOQBdafTPZ9oD5XsRqdPA5
X-Proofpoint-GUID: wOnS7qmb9VsOQBdafTPZ9oD5XsRqdPA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090077
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Am 06.02.26 um 17:46 schrieb Jaehoon Kim:
> During zPCI scan, BAR configuration data retrieved via CLP Query was
> misinterpreted due to an endianness mismatch between QEMU and the guest
> kernel.
> 
> The guest kernel's clp_store_query_pci_fn() expects BAR values in
> little-endian format and converts them with le32_to_cpu(). However, QEMU
> was incorrectly sending them in big-endian format, not following the
> architecture specification. This caused incorrect bit-swapping in the
> kernel, leading zpci_setup_bus_resources() to perform registration checks
> against invalid flags, making the process ineffective.
> 
> Observation values for zPCI device (NVMe passthrough):
> LPAR from real CLP:
> [    0.865595] Resource: PCI Bus 0000:00 -> zdev->bar[0].val: 0x4
> [    0.865597]  start: 0x4000000000000000
> [    0.865598]  end:   0x4000000000003fff
> [    0.865600]  flags: 0x100200
> 
> QEMU before fix (wrong):
> [    0.601083] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4000000
> [    0.601085]  start: 0x4003000000000000
> [    0.601086]  end:   0x4003000000003fff
> [    0.601087]  flags: 0x200
> 
> QEMU after fix (correct):
> [    0.601116] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4
> [    0.601117]  start: 0x4003000000000000
> [    0.601118]  end:   0x4003000000003fff
> [    0.601119]  flags: 0x100200
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   hw/s390x/s390-pci-inst.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 6b67c3c109..10066ca618 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -307,7 +307,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
>               uint32_t data = pci_get_long(pbdev->pdev->config +
>                   PCI_BASE_ADDRESS_0 + (i * 4));
>   
> -            stl_be_p(&resquery->bar[i], data);
> +            stl_le_p(&resquery->bar[i], data);
>               resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
>                                       ctz64(pbdev->pdev->io_regions[i].size) : 0;
>               trace_s390_pci_bar(i,


