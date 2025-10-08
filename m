Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Rdf-0003Z2-Ew; Wed, 08 Oct 2025 06:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v6Rdc-0003Xf-9s; Wed, 08 Oct 2025 06:43:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v6RdZ-0007bi-0v; Wed, 08 Oct 2025 06:43:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5986fx4c004993;
 Wed, 8 Oct 2025 10:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hgwq8R
 W7Lnii00jSJ0RUD5KcGCBQi4d2NgidjxlzkVA=; b=TtNtlRYXZPx28tfkR5G8JE
 VYqfS80RZWfBlswlvgbmM57GJCjaek88pYidJxzLlhLWrDO9NVgi84oQj8v+YZEi
 WeHLPqUzC52qi5cfqsdkn4JjqeMGEFAQ0zT28DNdSPLtCRht1zoAnqDEwslNHCAk
 1En5pjBWfjpNVP1OZdDPGGSQlzp2kjGscn1iCGBIWSG8xMfOTpsxMheVJC69Se00
 +QHqNf9Fmz4Ugwc837aiGty0gpPOJQ4QRfCOB0JVrGc6UrZrPTy+396PPFFPBdKt
 bhJRtxGzW5gRuaSKXH5+lf1IVuigaVcR4mQo695NdYdIXOpKtnCnLCI3ybsyVKNQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h4k6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 10:43:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598AI2Hw030969;
 Wed, 8 Oct 2025 10:43:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdk7yyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 10:43:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598Ah25l45613388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 10:43:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A633A20043;
 Wed,  8 Oct 2025 10:43:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D18020040;
 Wed,  8 Oct 2025 10:43:02 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.155.208.219])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Oct 2025 10:43:02 +0000 (GMT)
Date: Wed, 8 Oct 2025 12:43:00 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390x/pci: fix interrupt blocking by returning only
 the device's summary bit
Message-ID: <20251008124300.4b391ad9.pasic@linux.ibm.com>
In-Reply-To: <20251001154004.71917-1-jhkim@linux.ibm.com>
References: <20251001154004.71917-1-jhkim@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX71O6cQuh2cDx
 fVNzvGlc19Dxn5m0VAVY8j8WNmQy4/ZldkG0uvC9GfDOg6rLrw1KvRTsoJ8WERtj4OasG4v3DYh
 +aEgcF6IunAvvK/DqjS1OG8iV/OX35nCw+Bmov3Y5EbQ8AHcJA8Zitk4wu+1D1Xx5g2qkdjGOFa
 XgbiqaE6u2sZYB/VM3C6pXcIroLvSr6NcAwVkovSdhXi+Lfn2gK6iJKhwFAeuptnULILj8KoyCY
 lCKiFiivKmd39os858NPFKg8tCcR8ummTiVRvKbFgQyVhii+CMPsD1pVfJvMKlIiLnaPhOgHI7p
 cZpEQabAZu9kQ6ipJ9/NQuhNTuiOFsHFsJsgIS56oy/J1xkb5RSmzKiULtQVdy6+nj6F1nVNqtK
 3b6a1D75A9NcEc9zVJwyLIH1Yfs/xw==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e6403c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=a0Kf5bPM5kDjCRkYeL8A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: uNBfVyuGKU39V_19wj2ACTdTsJ5pzKzf
X-Proofpoint-ORIG-GUID: uNBfVyuGKU39V_19wj2ACTdTsJ5pzKzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Wed,  1 Oct 2025 10:39:38 -0500
Jaehoon Kim <jhkim@linux.ibm.com> wrote:

> Previously, set_ind_atomic() returned the entire byte containing
> multiple summary bits. This meant that if any other summary bit in the
> byte was set, interrupt injection could be incorrectly blocked, even
> when the current device's summary bit was not set. As a result, the
> guest could remain blocked after I/O completion during FIO tests.
> 
> This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
> returns true if the bit was set by this function, and false if it was
> already set or mapping failed. Interrupts are now blocked only when
> the device's own summary bit was not previously set, avoiding
> unintended blocking when multiple PCI summary bits exist within the
> same byte.
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index f87d2748b6..e8e41c8a9a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -652,7 +652,16 @@ static const PCIIOMMUOps s390_iommu_ops = {
>      .get_address_space = s390_pci_dma_iommu,
>  };
>  
> -static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
> +/**
> + * set_ind_bit_atomic - Atomically set a bit in an indicator
> + *
> + * @ind_loc:   Address of the indicator
> + * @to_be_set: Bit to set
> + *
> + * Returns true if the bit was set by this function, false if it was
> + * already set or mapping failed.
> + */
> +static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)

Unlike for example set_bit() in the Linux kernel which works with
a bit number, this one works with basically a mask in which only that
single bit (or possibly multiple bits) is set which needs to be set in
the target byte as well. I'm not sure if bit nr based would lead
to simplification or not, just wanted to point this out.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

