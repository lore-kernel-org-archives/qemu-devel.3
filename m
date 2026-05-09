Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE815CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLjAw-0007vQ-6y; Sat, 09 May 2026 11:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjAm-0007q4-Fq; Sat, 09 May 2026 11:00:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjAh-0006vU-W6; Sat, 09 May 2026 11:00:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6493NdP93411261; Sat, 9 May 2026 15:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=QjloOb+q5WLlS8qC0maHbo/qgT+1Ak
 Ng3eE531UuxiI=; b=KhEQc56L5juZX0hp7XOGsCXRoyq7Do4KYVzIWFPpul9pwP
 Dind4fTo54Se3zhvMqKVy4YKoewJQadRprFPhsBxClGvA7gEKhBSJPFa631SbhuR
 gWHqHxT0EnlevP6hmHzFUVe+WXHECjoa8W9lN2O9xneT2CA1rxC0w7I2RRPb8T5a
 ajf9sGqRmBJQrbBbix2+G080Chm7m7cLUJ/Mag2er9prFyNq7hLQr4WMP2giqiiP
 l0NqtQqnnJCCVkB/nmxe326q1upKjAOFYXhNiGez2uPTnzoFZ0KnST3X9f+W0pcl
 vJs3CeR6cs7ScISkw571AwrZPmxQFaa1ZmYEFxVw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdhydw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:00:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EsS6C023616;
 Sat, 9 May 2026 15:00:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywn12u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:00:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649F0Zhg30802526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 15:00:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79C4F20040;
 Sat,  9 May 2026 15:00:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BCFF20043;
 Sat,  9 May 2026 15:00:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 15:00:27 +0000 (GMT)
Date: Sat, 9 May 2026 20:30:24 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 6/9] pnv/phb4: Set link-active status in HPSTAT and
 LMR registers
Message-ID: <af9LQsiL9Wear4kN@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=69ff4c18 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=XfbUPoBrIe06zKqIYwUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: h_3XDBWB2NJt7g4dgbg8RwYeEbQKU1of
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfXwAEYl2EdsMcs
 ps/xb75LK46vcFhi8YkuJOJVEi+d6o/7nHZLo+xOd9940T7weqWO3Eq+1u8ijmyONPN62gY8ra4
 tGjv1S4NJ/Z1OkYFx9zRfV5Qay3NDGEfi983BrQpX6E2XMdh6h1t9JUl31tCaaDWsOAkpeDxDnD
 oqhLQyJRq+VCWuZREzQ9vDbGYSyaSswJJNJLckfN/+FaDutMsZgdMi7Ejm/p6r3YvFjapS/IEOh
 h7dMTV4qSsTosCd2sGkJbGkm6IepzexSX0EGZwxxz1TjjN4RDyM1UvsyhWQTnTzP96Ne3Ii9Djd
 2eAO/79PNZnEvCBKi52ceKBx2Zs1wKwe+EIrtER/RTlyPfipOwqxwa6XqCSV1wpvs1ZCcfZdM5N
 nhvIabaBbETjnHptIOHcHj+4li0+M+rJrBrnsiIJHaI4QUlgS5qVi8PpOEgX1oIug4RZGPnsj6L
 hL1kepw7dYPBjfv/lvA==
X-Proofpoint-ORIG-GUID: wNTDJgo2I8eu3F39bLsoU4-6zy1goJRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> <...snip...>
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -511,6 +511,20 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>      return rpc->exp_offset;
>  }
>  
> +/*
> + * Config-read the link-status register in the PCI-E macro,
> + * convert to LE and check the link-active bit.
> + */
> +static uint32_t is_link_active(PnvPHB4 *phb)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_offset = get_exp_offset(pdev);
> +
> +    return (bswap32(pnv_phb4_rc_config_read(phb, exp_offset + PCI_EXP_LNKSTA, 4)
> +                    ) & PCI_EXP_LNKSTA_DLLLA);

should it be be32_to_cpu instead of bswap ?

> +}
> +
>  /*
>   * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>   * RC-config space values and masks are LE.
> @@ -729,6 +743,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          val = 0;
>          break;
>  
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* For normal operations, Simspeed diagnostic bit is always zero */
> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
> +        break;

spec says this about HPSTAT_SIMDIAG bit in Hot Plug Status register:

	NOTE: if simulation code changes this bit (Simspeed diagnostic bit)
	it should also write bit '9' so that the input status signal
	will re-sample correctly.".

i don't think bit 9 makes a difference for us currently, but i think
good to set bit 9 too. what do you say ?

> <...snip...>
>
> +        /*
> +         * Config-read the PCI-E macro register for slot-status.
> +         * Method for config-read converts to BE value.
> +         * To check actual bit in the PCI-E register,
> +         * convert the value back to LE using bswap32().
> +         * Clear the Presence-status active low bit.
> +         */
> +        if (bswap32(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA, 4))
> +                    & PCI_EXP_SLTSTA_PDS) {
> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;

be*_to_cpu makes more sense than bswap32 here, as PCI_EXP_SLTSTA_PDS is
in qemu endianness

- Aditya G


