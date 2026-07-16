Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC52FC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKdQ-0007ZM-Sz; Thu, 16 Jul 2026 07:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkKdP-0007Z6-6S; Thu, 16 Jul 2026 07:52:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkKdN-00009r-O3; Thu, 16 Jul 2026 07:52:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABvdr2899272; Thu, 16 Jul 2026 11:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=nqtInuljqCRBXQjymMG38k5wjV1cRR
 GCdeDznB7lg5o=; b=Fr2IMcV+N8hfsac5IbWLwuqoxH7N8dnuxxcytP5aLNY0/t
 GZu87uNSGd+HU7Sn9Kuhv4stRuVIf7DufNh6h390l7PaGDleBbtRrnm89z2jPrbM
 7diBxWLqxWLDI6aCQF3Mp8k7Zq+SbpQFqak54R50GFtKx9LDrg9nGucRznDGNT7R
 cONsxRgh4CJXDDTpGbHq1Ee3BVKVnHEgfnDVstpiOXZ5CzQIuIQ371icfZ3AkxCs
 G4drzdT9RUoS2KFhydUsCgB7Po0CoJneJcWqxQ9CBuRDpEk7vTl8/MpZepmiye6N
 6PKDl673tTU2KTO3P2rC+9MyRFxVlln/2jnmPYSQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbywhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 11:52:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GBndjP005300;
 Thu, 16 Jul 2026 11:51:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k4sja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 11:51:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GBptba47776114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 11:51:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 817B720040;
 Thu, 16 Jul 2026 11:51:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 705352004B;
 Thu, 16 Jul 2026 11:51:48 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.30]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 11:51:48 +0000 (GMT)
Date: Thu, 16 Jul 2026 17:21:44 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 3/9] pnv/phb5: Implement sticky reset logic in PHB5
Message-ID: <aljDwbMnI_w8R1Nu@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-4-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-4-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58c5e0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Io184aDfKauzPn52k4QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfXxcdNIndDaBdT
 p2h08Tt6leXc7n0dcpU7PbwBCtUl66StrwS8yqOHcYImJ0CeuQ1wE3dYRMQZQ+dk42Xq7aQ8fWe
 pT8EADyyKf6ilXSdBWxGPbaADgSylx1wyLmmBr+zmd03xWLBNRCmls/Wp7kO2vvV9a1iOF8VwaZ
 JPBaKwz/QcHDP06jYv2VDP0D4qdkvQZiKMPOJjwowduZ8EMI1j37Zilg6rID76ekoeRe7O1vYIf
 MAs5/unZR1i7l6guOzFAD8XE69HScshdLhiczsahPLEbcT18Q4upRQzLMdwOwwKkMu54SAEYzip
 xXHA+awEyNAa5zFvEcryc535eX1w4+DWfPrPkVhOInyB1N9JwLtQ818iLeyiC01+ohEavZOYeH+
 ql+7TXsUQ7PuJeaOm8ReITopqruRfvYMeej/SKNBlLIu4Qjv6+H8xWKR+7IrTg3H3OdpXAJ4bZV
 WEVOfV9tC9HcKUW9W6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfXw/UR5mDEncsr
 Yx2ITdKO3gcyT+rMuBFT4KJI6mnlqzrBcei7dCH8nxjr/kIsGV7lrIIOgwBNeOaVCL0pGOWgsmG
 Fh5oGjM8hneC6XMZ5NCsyteDSFYksCY=
X-Proofpoint-GUID: ZMiRvBoOZXpH4nMIsNxA4o9mCbBUN7oL
X-Proofpoint-ORIG-GUID: zBtPFy3VMsYr4n3iURW9CPaGJ-13PhNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160121
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
>  void pnv_phb4_cfg_core_reset(PCIDevice *d)
>  {
>      uint8_t *conf = d->config;
> @@ -557,14 +570,56 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
>      pci_set_long(conf + P16_ECAP, 0x22410026);
>      pci_set_long(conf + P32_ECAP, 0x1002A);
>      pci_set_long(conf + P32_CAP,  0x103);
> +
> +    /* Sticky reset */
> +    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,
> +                                          PCI_EXP_LNKCTL2_TLS_32_0GT, 0xFEFFBF);

This is different for PHB4, which is PCI_EXP_LNKCTL2_TLS_16_0GT (0x4)
and for PHB5, spec says PCI_EXP_LNKCTL2_TLS_32_0GT (0x5)

This doesn't affect skiboot anyways, but good to be correct now.
Rebasing/separating phb5 should fix such nits, let's discuss on it.

Rest looks good to me.

Thanks,
- Aditya G


