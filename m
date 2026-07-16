Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E76C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKlt-0000zv-AU; Thu, 16 Jul 2026 08:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkKlr-0000z7-2S; Thu, 16 Jul 2026 08:00:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkKlp-0001RQ-FT; Thu, 16 Jul 2026 08:00:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABtc22826184; Thu, 16 Jul 2026 12:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=hpG/iErSR7VD6lG11/wsZgh8a2tAKQ
 E+OyTLikaZW3E=; b=E6HfoNweaHPGle7tnwZQl6gM4FcpwGY99PfWPXn9WJnNOo
 C0dQmi1XiIRz/iVYWtVrHI6qyBgl9oeJShM+2xgCBmQudeaJNp8MNa221xXhjsyy
 tMpRK/O8v39rWlM7pQV6NbwBPlJnwQ2T3uFS5dYHhIUnXHx+OZlxK63ZRcf47bJK
 Oxuld2oJEEnzweoro7YJMvMJg7Su6oiBm4iFJrWn6NsK+piO/fO2kHPxLINOwSXR
 j2yTfw5/0tH0zDFUhVgT1IV6v4O9bsxnosIK7DNOalbX80uX2txgAIiCSFohpMSl
 8M+2WwZb5rycL+vG6aw2YKqIeYVMgnYxLveqX8aA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwyv82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:00:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GBni0H003265;
 Thu, 16 Jul 2026 12:00:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qd244-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:00:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GC0c8s47776136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:00:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92A2A2004F;
 Thu, 16 Jul 2026 12:00:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 292EE2004D;
 Thu, 16 Jul 2026 12:00:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.30]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 12:00:30 +0000 (GMT)
Date: Thu, 16 Jul 2026 17:30:27 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 4/9] pnv/phb5: Implement read-only and write-only bits
 of registers
Message-ID: <aljG2hajR3dLXHkB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-5-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-5-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qsHLIKL63rgzufoPUEnMgwWRvXrNLLrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfX1wPUV8ewuZmH
 G6daG+ufD0guME7C799o/uJBs1zFoN4J6uEgJ7L4NSQ9LqGf5xCTtw2Pwx6i00VzYmkbCahyrem
 O3Ar8YfV4qkk1pD5ivlRkpREu7ttH1RM+Vfb4ylgooqW2u8H9ygmNBz7jPX6K+hs+S5UHRapdSd
 pnw9nAAlFV230vSka0QQLPdmSB4lakjDO+JM5YuoiCj5e/4FuFrm8CYGcDeL9BZOIEIXhcBLJ/t
 xfbI99MW65t//wZU1d8bscMZB4RZdTJv8DLSsg2EdtC5ICA6VzmI/fXbRzm1+6bjl0N2n7AI7uf
 v49D83Nk7FrKUzHeE5dzynSxOAlkhUNXC85l/9+iUcfmPwAlNVtoDlP47q7hSNliVpqD8z9wvP8
 Nnle/WF7ZbeWXOYWhQs5HSOl40K/yHDbw5dgaj4Wo75cXhmK9zVgzmG+INxG+0VoE2WFq6kvk6z
 PGvZ4GTgsCRjKkQx/fw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58c7eb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=WcL14SwBzZWWs5KTvBEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: lu5mMUpuvgb2N6I0zwzlDeTWG7rrUXRQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfXyPti4SR/FxSh
 Lchp2nWHNpzbK3S3ims7sL+OMdHHFwHophHkhgCm1qnsLuqrEqUdTSsppbn1wNoHHT1fX8+Fnq3
 8jAoXYnmQKdyF0Xw39XmfW2Rrz87/YA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 26/06/17 04:50AM, Saif Abrar wrote:
> <...snip...>
>
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index df5e86d29a..dfd0e01d1e 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -180,9 +180,11 @@
>  #define PHB_M64_AOMASK                  0x1d0
>  #define PHB_M64_UPPER_BITS              0x1f0
>  #define PHB_NXLATE_PREFIX               0x1f8
> -#define PHB_DMARD_SYNC                  0x200
> -#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
> -#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
> +#define PHB_DMA_SYNC                    0x200
> +#define   PHB_DMA_SYNC_RD_START         PPC_BIT(0)
> +#define   PHB_DMA_SYNC_RD_COMPLETE      PPC_BIT(1)
> +#define   PHB_DMA_SYNC_WR_START         PPC_BIT(2)
> +#define   PHB_DMA_SYNC_WR_COMPLETE      PPC_BIT(3)

nit: This affects the behaviour in PHB4, where DMARD had bit 2 & 3 as
reserved

but i don't see it as a concern.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


