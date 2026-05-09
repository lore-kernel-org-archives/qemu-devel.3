Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307CCCD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLj5D-0005zl-4Y; Sat, 09 May 2026 10:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLj5A-0005xL-HM; Sat, 09 May 2026 10:55:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLj58-0005FW-P7; Sat, 09 May 2026 10:55:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6492jte82826990; Sat, 9 May 2026 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=28FTllpQaaanOJsLjadC3AMLMPaHLJ
 lFqcpk79vVwQ8=; b=kw23em91C8aBAg/ksdxulWPzEdUrxs2XxM8Z60hvOzPfl6
 onbdlMlkNuzhC1M45QqQ/KKjP3vzxelqedVry+zq8cCaKgQf5WkxRZlIy5xFMxgC
 oPx7HC7WQSZDNDYs0s2HwYKLs0IScGiEdJAAX9u1xKWJLluIcYhKFxuI9SIHXlCh
 1a791N+ubYSPAJu2knEBIRIKqb6BEUFrUP6TFZA2V1pQPdeCbI8SB8BpxR6nkbUT
 BWOhHJxS1ywatRTRn/zDFeVcWhzMUGOgwUs7/tPgNrFMLtBWo117X4rjTew23Swv
 rE6mZmSFUyYslYa/V2sqWtwsFNKJn2JK4/loSheg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6sxnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:54:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EsRQF008229;
 Sat, 9 May 2026 14:54:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yvnm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:54:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649Esp1Q52363646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:54:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DE292004B;
 Sat,  9 May 2026 14:54:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0163920040;
 Sat,  9 May 2026 14:54:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 14:54:43 +0000 (GMT)
Date: Sat, 9 May 2026 20:24:40 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 4/9] pnv/phb4: Implement read-only and write-only bits
 of registers
Message-ID: <af9JzTz4HyuPBSnH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX3GR674labKea
 sfY1r99tSlpMzicZThMLyzn3eMhlp4leVnIU/I4xp3MWhUvq1+GJ6WIyvnojw3QsxaMydjwydWX
 GZFY+t5aivfvmUJQ1tt/bSTDCzZ1DqYuH0nUMdg2AEHHSWsVqKtgQScoh6JhbmTp09nslQ02vkx
 r9SDRYEx4yC2U9duMqJZmHM+z0GE3yNhJrSDbgW1zbo1H2pxfZBdISChcZMKRhHAKw4wXbhbi5U
 okzY7b1/6C5QZUJF/6ZiLJW/9Ftc7YnW1AMmV3S7OiTVMq9ZItvnXvOMLaiKNfGyJhc+g5aCtaI
 ur6ZoPr4B1grAGvWuBB4jKI8kr6Ia02a4hAG7v89JyNsBdA6gPUSNSx8L3gNcrnbLjqQ5O91RB4
 Fu8tjHexUNYxwKINUuGUavZrdPoxhEURHANDSt2zogze8O4FKImy/j49iQPJJnyQgilhg40MB34
 w6DbNXT4S4KJ1RTGODw==
X-Proofpoint-GUID: VH7-IGr6C4aBFLUqxRlweFT7Sd83JA7h
X-Proofpoint-ORIG-GUID: iaHUQYe_D1Dj5Pt8barNUijy7B0G7HYe
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=69ff4ac0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QWRBx45KI3EdOKQnfmwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

nice functionality !

On 26/03/05 12:09AM, Saif Abrar wrote:
> <...snip...>
> +    /*
> +     * DMA sync: make it look like it's complete,
> +     *           clear write-only read/write start sync bits.
> +     */
> +    case PHB_DMA_SYNC:
> +        val = PHB_DMA_SYNC_RD_COMPLETE |
> +            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
> +        return val;
> +
> +    /*
> +     * PCI-E Stack registers

nit: s/Stack registers/System Config Register/ ?

> +     */
> +    case PHB_PCIE_SCR:
> +        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
> +        break;
> +
>      /* Link training always appears trained */

> <...snip...>

> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> index 419f34987a..2078fab9a9 100644
> --- a/tests/qtest/pnv-phb4-test.c
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -73,7 +73,8 @@ static void phb4_sticky_rst_test(QTestState *qts)
>       * Sticky reset test of PHB_PBL_ERR_STATUS.
>       *
>       * Write all 1's to reg PHB_PBL_ERR_INJECT.
> -     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
> +     * RO-only bits will not be written and
> +     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
>       *
>       * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
>       * Verify the sticky bits are still set.
> @@ -81,7 +82,59 @@ static void phb4_sticky_rst_test(QTestState *qts)
>      PHB4_XSCOM_WRITE(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
>      PHB4_XSCOM_WRITE(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
>      val = PHB4_XSCOM_READ(PHB_PBL_ERR_STATUS);
> -    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
> +    g_assert_cmpuint(val, ==, 0xF00DFD8E00);

instead of this hardcoded value, can it be PPC_BITMASKs as previously
used ?

- Aditya G

