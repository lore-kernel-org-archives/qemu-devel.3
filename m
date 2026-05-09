Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF41CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLit2-0001dB-G2; Sat, 09 May 2026 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLit0-0001by-FL; Sat, 09 May 2026 10:42:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLisy-0000v8-JT; Sat, 09 May 2026 10:42:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649Bs7A54050256; Sat, 9 May 2026 14:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=crcIxI
 LMY8bJVjAWLQh2dNcIW0vCX3+y7OPVAKUI2GM=; b=HbqNQx2jfmkxaQrINfbe4t
 hp4XeQD9Rw0pVBcYBnkcaQZ94zJ9SlRqCZTZdi39ljt9j8aEAaegELzQ/8qUVOX1
 O6TSUYnb3YdiCVV4NbQy8/Qhf2BK7UKe/EdSyGriO0wO8AudxbeDJmLl5qzD8QBv
 9w5RttB6Zs/Baq4y8qz1slApYm27Sy4IJhJZoJBbcPp++Tunq8IEenM0VmrETKZx
 kjsS9W3wWqAXsE8hzcBK5mpCw5m6FqbIp0HSIsf7lmi0pzNuQ5iuFh/vLbskW22R
 /evxa8af+s08f645VvLeLp7nz5uR5SXcV8q2Jhy0UJTZojjxq328B7itsJkvUgSg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju1s2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:42:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649Edh3m008518;
 Sat, 9 May 2026 14:42:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10077wuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:42:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649EgHvX55247226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:42:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3AC120043;
 Sat,  9 May 2026 14:42:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8D7620040;
 Sat,  9 May 2026 14:42:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 14:42:10 +0000 (GMT)
Date: Sat, 9 May 2026 20:12:06 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
Message-ID: <af9F84KcjdZsb0_y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=69ff47ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=UeORujM8hhX0G6YtbEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: Uv_14TLbaUkhp-bIycZaY5q99q5bVtOb
X-Proofpoint-ORIG-GUID: vlaU1UdnPzl-yrzaiXl9KrLW_oaEkpfK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX8xcpO+5klf5e
 MtGx3T3u4gdUiNt72PrH+1YTXN0oZTXikjUqkHdgyNg1yHGLKrkyYIMp1obEn1GA4RrbFiMYGAE
 WIhbbh/yubdNK0tJHn66AVXFLGqHY/MOWe8LvQa6RnEq6wOsRvVEXJ0Lb1oJ5fkCxPNzWawhXCd
 cCNymlVlZG5tR7qiYRKUMewWQg470sACpKmLzlfA1lDR29HBClgpgEPmlv02qmYnvSenSyzFdqK
 JnBrmUXIkAxyvadyTbKShZgFpBKz7qleJHBOkfPxSBHJtzDT/+9tC7IT8St7gU4MJjbDMvSzNRp
 ywmF0JGzj7KThi9XJdWvhBXE5hBivWPOPN878LzBfT+Ae3L8vIt+qWK7jyORwo12aH1Vqidnvm8
 BKG4UQPsXX8v0qet3pVx2CyHPHqcKTnR9a273AEY2V8I3YLstUv2wNS+qv2+MViBe+xDHQP4hx8
 PJcitEUughri93oI9Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
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
> Add a method to be invoked on QEMU reset.
> Also add CFG and PBL core-blocks reset logic using
> appropriate bits of PHB_PCIE_CRESET register.
> 
> Tested by reading the reset value of a register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v3: Updates for coding guidelines.
> v2:
> - Using the ResettableClass.
> - Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
> 
>  hw/pci-host/pnv_phb.c               |   1 +
>  hw/pci-host/pnv_phb4.c              | 103 +++++++++++++++++++++++++++-
>  include/hw/pci-host/pnv_phb4.h      |   1 +
>  include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>  tests/qtest/pnv-phb4-test.c         |  28 +++++++-
>  5 files changed, 145 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 0b556d1bf5..d4f452d7b2 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>      pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>      pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>      pci_config_set_interrupt_pin(conf, 0);
> +    pnv_phb4_cfg_core_reset(d);

seems these are common steps for phb4/5 now, if that's the case, do you
think this small change makes sense ?

    diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
    index d4f452d7b2fe..0432466b249f 100644
    --- a/hw/pci-host/pnv_phb.c
    +++ b/hw/pci-host/pnv_phb.c
    @@ -220,7 +220,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
             return;
         }
     
    -    /* PHB4 and later requires these extra reset steps */
    +    /* PHB4/5 and later requires these extra reset steps */
         pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
                                    PCI_IO_RANGE_MASK & 0xff);
         pci_byte_test_and_clear_mask(conf + PCI_IO_LIMIT,

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

Above 3 configs are set twice, in this function as well as the callee

Also, these were set to different values before this patch, such as
PCI_MEMORY_BASE being set to BIT(0) in 'pnv_phb_root_port_reset_hold'.

Can this cause any issues ?

Also, can you help me find which section in spec contains the sequence
for core/pbl core reset ?

> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));

nit: duplicates

> <...snip...>
> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
> +    pci_set_long(conf + P16_ECAP, 0x22410026);
> +    pci_set_long(conf + P32_ECAP, 0x1002A);
> +    pci_set_long(conf + P32_CAP,  0x103);

the current patch has lots of hardcoded values (above ones and below
this line too), does it make sense to have macros or ppc_bitmasks for
some of them ?

> +}
> +
> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
> +{
> +    /* Zero all registers initially */
> +    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
> +        phb->regs[i >> 3] = 0x0;
> +    }
> +
> +    /* Set specific register values */
> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
> +}
> +

> <...snip...>

> @@ -72,8 +95,6 @@ static void phb_version_test(const void *data)
>      /* PHB Version register bits [24:31] */
>      ver = ver >> (63 - 31);
>      g_assert_cmpuint(ver, ==, expected_ver);
> -
> -    qtest_quit(qts);

qtest_quit is removed here, won't it cause issues where QTestState is
not terminated properly ?

Thanks,
- Aditya G


