Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10032C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujlGU-0005If-MV; Wed, 06 Aug 2025 17:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujlG8-0004vu-CP; Wed, 06 Aug 2025 17:01:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujlG6-0006W9-15; Wed, 06 Aug 2025 17:01:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576HUd4b019637;
 Wed, 6 Aug 2025 21:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ys7sUiKNbEPXu95PCX1EexSWJcRqK3XEFLXdlke6wXc=; b=EHYfWJBriWwl
 zPQ9Qlj4iwyVH3IoO9VhMPPoJeejmJJCbQEA7lEoMxEwE6Dc08QEJR6FINiAWHXe
 fp3uZLpY5c1oa5a2YaVsgHePSXIhAAGQKV7ophxieOOWmt3WBAR2Szd3tsHKsPcF
 yr8ZqdQXIpZJ++ox22oa5xpIqxRhzFdflBE8mG5jitZAwZXRLFEFeLnjAMOyxVBi
 vWqSSmxY4xww5wDZlTDtizUjY8iZAeNAjAqF7JSYi6qZzLKc3IYoDlD3woyFPfA4
 nCXNWK2Xh36TIC3OZ6BykyhcfxnMtpozZl0pvQ7ymYwkRiTXI7pMosraqrKWGSeK
 K2p6C6FZTw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tuv45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 21:01:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576KuO6K000371;
 Wed, 6 Aug 2025 21:01:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tuv44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 21:01:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576K06Os025878;
 Wed, 6 Aug 2025 21:01:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn5hcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 21:01:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 576L19VL12583526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Aug 2025 21:01:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C0E458061;
 Wed,  6 Aug 2025 21:01:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8D2D5803F;
 Wed,  6 Aug 2025 21:01:08 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Aug 2025 21:01:08 +0000 (GMT)
Message-ID: <901dc082099e720001d852ec34943bf4149db759.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/pci-host: PowerNV PCIe Device On Small PHB Seg Faults
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: kowal@linux.ibm.com, saif.abrar@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com
Date: Wed, 06 Aug 2025 16:01:08 -0500
In-Reply-To: <957b82100001831432cd29fc3af5f022c14018c7.camel@linux.ibm.com>
References: <20250716165017.2770845-1-milesg@linux.ibm.com>
 <957b82100001831432cd29fc3af5f022c14018c7.camel@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kE6gl1I-L90EQ9Rxmqq3uxBbrLPPseYV
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6893c297 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=kPGuEAcD5d1l2WuI2AoA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: vIVQCtHrjCA3vDwp_Ywz2s4JZv7tqbdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEzOSBTYWx0ZWRfXyt6u4vjyUHhR
 xiUrwNsoU1NetFldSy4zYAsjTm8Kg+KPLhjKLGDJ3zQ6E4bscuL6nECsXRVNtUmzaan/wK5RhBf
 9ExEvOfhpv6mmr4jYj48f7rByIzl3VePqfD0DT/OBcRxJqYhPE1WaGYj9xHiWbPXh9MI1qGnyKs
 TpkqFGH/5pOwooKjdTgpCseLSJGG+hMDIujDYJysEFG1Rvc9vJqoq5/goVd1GkJMgSKulEAclrO
 OW6w14JhrP9zyx+pOU6k05eNVha7BkeuObhqjnnK2uJSCEJCGxUmN78M3D8oY9vo/Dwve4o/M2N
 pBceXWj1tkxFJcoYqqjPVQSnT0E7YATBQkAq3cJNpIaDj9vk++zc1d97tMS0SGmdVLhldMTQWqp
 /XeSnmjsnPuuINwefM/kFcJXA2W6LMu7AB4hr14Qks6JpVCR49hzjL0R22MwYRemU2ea7/JY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+harsh

On Wed, 2025-07-16 at 12:24 -0500, Miles Glenn wrote:
> +qemu-ppc@nongnu.org
> 
> On Wed, 2025-07-16 at 11:50 -0500, Glenn Miles wrote:
> > The PowerNV PCI Host Bridge (PHB) supports a large and small
> > configuration where the small configuration supports only
> > half the number of interrupts supported by the large configuration.
> > 
> > Since the PCIe LSIs are allocated at the end of the PHB IRQ list,
> > when calculating the LSI IRQ number, the code must take into
> > consideration the number of IRQ's supported by the PHB.  This
> > was not happening and was resulting in a QEMU segmentation fault
> > when a PCI device was added to a PHB with the small configuration.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > ---
> >  hw/pci-host/pnv_phb4.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> > index 18992054e8..aeb2a45b4b 100644
> > --- a/hw/pci-host/pnv_phb4.c
> > +++ b/hw/pci-host/pnv_phb4.c
> > @@ -1167,6 +1167,7 @@ static int pnv_phb4_map_irq(PCIDevice *pci_dev, int irq_num)
> >  static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
> >  {
> >      PnvPHB4 *phb = PNV_PHB4(opaque);
> > +    XiveSource *xsrc = &phb->xsrc;
> >      uint32_t lsi_base;
> >  
> >      /* LSI only ... */
> > @@ -1175,6 +1176,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
> >      }
> >      lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
> >      lsi_base <<= 3;
> > +    lsi_base &= xsrc->nr_irqs - 1;
> >      qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
> >  }
> >  


