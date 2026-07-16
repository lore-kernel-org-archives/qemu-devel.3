Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22FDC43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkEao-0007VS-NO; Thu, 16 Jul 2026 01:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkEan-0007V0-65; Thu, 16 Jul 2026 01:25:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkEal-0003Hw-6c; Thu, 16 Jul 2026 01:25:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G4Be9r2152176; Thu, 16 Jul 2026 05:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=lzKDkgOzXYdPjjjXlBLYwnpyfI/G0v
 Jz3NyOF8hiWIw=; b=KFEctGxPR8SdULaJsn+WZu70EwueBRj150XZnX0pP46nYw
 Nk6JrrIkYnQsrf+8TfPhoB0Q2ik3JYDCm64V4qmrmmsoUH4ATzY6ogoI3Fthf9Zd
 twpjKNWVyqUnOnHne5C6uMnWlTxi9Jt7t0YPYqwd9blZZKLEtvfKelAmT2dugtET
 0uk2AXi6Y5ZO7gOfjOg+oWsVKUu5jrA2OPjEB55SLhZeVYDAtdsz83MJNcFNFS/n
 VO0OnTqNO6Z5rVshLlH7wh8XMKyM5HJ6lrVf3F3ZcvJm3xRTUqtO7ZpY+O+tqmu8
 obh6QritlLXaqZra6E59tmq2w4uF0PFFQLdYZlCg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxq3sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 05:24:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G5JZUo008069;
 Thu, 16 Jul 2026 05:24:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgkaak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 05:24:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66G5Oj9n25559480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 05:24:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A98D520049;
 Thu, 16 Jul 2026 05:24:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B60C220040;
 Thu, 16 Jul 2026 05:24:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 05:24:39 +0000 (GMT)
Date: Thu, 16 Jul 2026 10:54:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 2/9] pnv/phb5: Add reset logic to PHB5
Message-ID: <alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-3-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-3-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: f_Ualj4YP5cLG4bZRnkc92n6XTkABSKc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfX9tzkWpg3XLbN
 ZJhc1D/tFCfMRS/wCWfXn0cnpNU83JB+TO+tftfgzv4RtKcPQNfLR/hLdmyRXO63XcnAgGD0M57
 fXeZZxRTSD4jAha1/RodjcvxR1sm3GU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfXzzdG8S6JnJwA
 Svx10wjpe1NyOigonKP0K9ZGPk1gBLU1AiAy/fVe176XcFs7EUtHxN/ktm7id2hY1aBWlxzGaMs
 t1HOoKs0NtSlV5PvJjeU5+KkuqYFGIHM3hQ0DjcXuqU1ZCsR4hgYU7KT30fXJe37MvRRJvBZquL
 NQE2FHiFV90XOeZDjfpV9nP4mVzqEYNS/WNc9RcMkt0Bh86LTSX187CjYvMEGZFe9SySLX65wYL
 bJ3ckcqD+AC4yJ0roNoKmkOCdpAYnV2i1GIDSCOi0tcWphdJL1dnBvaCUy4SKdaCAtBe/dZAnXR
 Fr3+ArO+EjNaCMfzzk3NLtQEv7gNCHvGUW2YJ2b2uoxU+pSS1JQOp8Bj3xO0YbnA5Kt6qwewJG1
 lrepXcUOI9ukMQKsmDee+RWY2B9Q4htY+Dw8ozlG2wBxixQmPrLSidHHoJoxCUmBukFKtZBwcqz
 H2DjE5p1DmUfEsEwppQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a586b22 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=5fUirfjHXe-NdIqDpewA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0sPJkewydW_qirbL3SOdBwCBZmf6BFE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Thanks for the patches !

On 26/06/17 04:50AM, Saif Abrar wrote:
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 0b556d1bf5..d4f452d7b2 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>      pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>      pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>      pci_config_set_interrupt_pin(conf, 0);
> +    pnv_phb4_cfg_core_reset(d);

nit: phb4 reset in common phb path ? will it affect phb3 too ?

>  }
>  
> <...snip...>
> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
> +{
> +    uint8_t *conf = d->config;
> +    uint32_t exp_offset = get_exp_offset(d);
> +
> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
> +    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
> +
> +    pci_set_long(conf + exp_offset, 0x420010);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
> +                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
> +                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
> +    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
> +    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
> +                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
> +                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
> +                       | PCI_EXP_LNKCAP2_SLS_32_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
> +    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
> +    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
> +                                                       | PCI_EXT_CAP_ID_SECPCI);
> +    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
> +    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
> +    for (int i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
> +        pci_set_long(conf + i, 0x9C38);
> +    }
> +
> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
> +    pci_set_long(conf + P16_ECAP, 0x22410026);
> +    pci_set_long(conf + P32_ECAP, 0x1002A);
> +    pci_set_long(conf + P32_CAP,  0x103);
> +}
> +
> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
> +{
> +    /* Zero all registers initially */
> +    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {

nit: should we use PNV_PHB4_NUM_REGS here, since we want to set all
phb->regs to 0 here ?

#define PNV_PHB4_NUM_REGS          (0x3000 >> 3)

> +        phb->regs[i >> 3] = 0x0;
> +    }
> +
> +    /* Set specific register values */
> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;

This reset value is different for PHB4 and PHB5.

The PHB4 spec that i am referring to marks the bits 8:15 as reserved,
and unimplemented. While PHB5 suggests the reset value of 0x9.

I am okay with considering those bits as implementation defined and let
qemu set those bits, but maybe it's better to separate it out in
pnv_phb5.c ?

> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;

Same 8:31 are reserved bits in PHB4, while not in PHB5.

Maybe separating out PHB5 from PHB4 helps in such cases.

> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
> +}
> +

> <...snip...>

> +static void phb5_tests(void)
> +{
> +    QTestState *qts = NULL;
> +
> +    qts = qtest_initf("-machine powernv10 -accel tcg");
> +
> +    /* Check reset value of a register */
> +    phb5_reset_test(qts);
> +
> +    qtest_quit(qts);
> +}
> +
>  /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>  static void phb_version_test(const void *data)
>  {
> @@ -59,7 +83,7 @@ static void phb_version_test(const void *data)
>          expected_ver = 0xA4;
>      } else if (chip->chip_type == PNV_CHIP_POWER10) {
>          machine = "powernv10";

This patch is giving an error on compilation now in upstream, due to
introduction of 'pnv_get_machine_type'. We can use
'pnv_get_machine_type' here in the start in place of machine = "powernv8".
What do you say ?

Thanks,
- Aditya G



