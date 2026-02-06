Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFFBEE20B9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPJp-0005ZC-FP; Fri, 06 Feb 2026 12:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1voPJm-0005Xo-7w; Fri, 06 Feb 2026 12:08:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1voPJh-00064Y-TA; Fri, 06 Feb 2026 12:08:27 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616CgmkL023258;
 Fri, 6 Feb 2026 17:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eSZPGd
 ZtjSuQYIhjkMH17ONr2g6G+a64Aryiz2XogBA=; b=Iad6WmhiX8rXsXmm92v5fR
 nETwvpjMK8aLQCUHOIypIVSI1ijrLOFYfYs7lOEjffHJAKlvkgVbzN/eQODH7zdL
 tyXR7IJd7L96CI+1MWP8FWsDgh6mko+SfIbjjeDW4+WYan1XNKhs6QZzzZMJjKcS
 N24H4RwHfLKsMflkb/gHMJpogHmCJMgqYeSA+4EMQ0UlcfX9iPhDIN5cWISb/uKb
 1h1fYSpQRol7fyzX9auCaeOM2dV/CP5iX5Vi2/UuqS8lYxS9WYVHPClnV2SANfA7
 ASzdzgwyUTos/ZiMmIXCSkDvKuGizfLr15DJGDXlN1x7oizcIX6mXyJVbNF3lzpQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6vpwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 17:08:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616GEsYi015800;
 Fri, 6 Feb 2026 17:08:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgybgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 17:08:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 616H8Ick7864834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 17:08:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ECD95805D;
 Fri,  6 Feb 2026 17:08:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3EDF58056;
 Fri,  6 Feb 2026 17:08:17 +0000 (GMT)
Received: from [9.24.20.109] (unknown [9.24.20.109])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 17:08:17 +0000 (GMT)
Message-ID: <92933127-8c06-44b9-8db0-cbb4c8b00431@linux.ibm.com>
Date: Fri, 6 Feb 2026 11:08:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix endianness for zPCI BAR values.
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org
References: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cMUdXiYMjVDUHEqXkVLVYZznfPT_Nvw8
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69862005 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=5dwcVOLGD4cZohy6t3cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cMUdXiYMjVDUHEqXkVLVYZznfPT_Nvw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyMyBTYWx0ZWRfX3egyzEbBd/40
 2yIjUZegljMeUUJjbSnVAk+DdEG9QzPetmRbXbeJrkBtGCkJiPr1NxyJvGeIb/1dsOz1OjBVZVp
 7eqeXl8WeMOKTehoIORP88/JVAJSXp2nz8eQHJUmA6hIh8WqP7gb5Yimx4AUfrfXbKPtcORsQ7d
 RyK66M987u+cp9DVXESIv2BZKJKqvA33WyOBGFLHy21pxPmEAiiVNXQ77ohWQMHIZsqrWvEYUoU
 6RfNpz+qpwDFxS8IgWzrFUR37Hve+vuXL4moAvO1RET/J70VcteMX43Y+QBHVrSxjTUWp+81qsD
 KYO+861xR05mi6VxAdilUItkaBcnrTS06PVe91kdVmNZE/frjdeo+3pY63zQ0mfO5W3uiGN1qjn
 lQqmcxIJnAR6uKuKkDGI9pfY/ozGQQSxBBw+YgJnaNqRh79HrXylnG23Z1ss/LRrTA8jZr7bU1K
 y0kcpw+Uaxw4fhXmCQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2/6/2026 10:46 AM, Jaehoon Kim wrote:

The previous mail didn't reach one reviewer; resending to the correct address.

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



