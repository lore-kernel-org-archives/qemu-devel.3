Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C25C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRIPm-0003HH-Vy; Tue, 09 Jul 2024 17:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sRIPk-0003Ef-7v
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:30:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sRIPh-0002jp-6e
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:30:19 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240709213004epoutp0102832c0996cccb4858d4d6919ebe1c86~gqMDtLRwa1813518135epoutp01F
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2024 21:30:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240709213004epoutp0102832c0996cccb4858d4d6919ebe1c86~gqMDtLRwa1813518135epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720560604;
 bh=Aww60PJfUUQEJiGeuXK4r+L3I6Fy+fj/DhSyNPMEc6k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lgDM8ZNu76KpTIls/2i9E2/14iprVtdJ+PnC5Z8nLamFZVeA34ndjupCj4H55sx79
 BgASg8dcJQIFxk17CGSpQ9B+9xX8Wga47vFE+bmST70bRr3o+Wr5HUUnI3e9FxX3qn
 dSx25F6ZEcyjiJrKxhohpcS2kC+ff/qcToLqhyrE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240709213003epcas2p366a6b3960d0071e7c0699bff139e05fe~gqMDNH0p-2555925559epcas2p3m;
 Tue,  9 Jul 2024 21:30:03 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4WJYzv14H8z4x9Pq; Tue,  9 Jul
 2024 21:30:03 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 3B.0D.09485.BDBAD866; Wed, 10 Jul 2024 06:30:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240709213002epcas2p28d9a411d549ecbadd3b3a5eeba10c423~gqMCQRgb51972819728epcas2p2b;
 Tue,  9 Jul 2024 21:30:02 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240709213002epsmtrp141b1041ba6fab72b9646325cdda10dbf~gqMCPcPiF2804228042epsmtrp1k;
 Tue,  9 Jul 2024 21:30:02 +0000 (GMT)
X-AuditID: b6c32a46-19bfa7000000250d-51-668dabdbc272
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 71.ED.07412.ADBAD866; Wed, 10 Jul 2024 06:30:02 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240709213002epsmtip19aa0a33914eab66819dd7aef2cce5cd0~gqMCFLDVu1235612356epsmtip1R;
 Tue,  9 Jul 2024 21:30:02 +0000 (GMT)
Date: Wed, 10 Jul 2024 06:17:30 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Message-ID: <Zo2o6kkqpSgmj4yN@localhost>
MIME-Version: 1.0
In-Reply-To: <929fc1df-0a19-4da0-8399-5d792dd25684@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmue7t1b1pBq//sFj8WbuQ2WLZpc9M
 Fieef2a2WPp2K7vFs9MHmC3+/3rFarFl/zd2i+O9O1gs5v68xmKx+NZ5Rgcuj3/rHrN4LN7z
 ksnjybXNTB4fn95i8Xi/7yqbR9+WVYwBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
 uoaWFuZKCnmJuam2Si4+AbpumTlAtykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN2zutlL5iiWPH0xnmWBsZX4l2MnBwSAiYSS1q2
 snQxcnEICexglHj0eTYrSEJI4BOjxMVZnBCJb4wS16bPYOxi5ADruP9eDSK+l1GiefNJRgjn
 OaPEncUXWUC6WQRUJS5PecwEYrMJqEs0TH0FFhcRsJFoOr0DrIFZYDqzxN2Oe2DrhAXcJDp2
 Twcr4hXQkPjwezkbhC0ocXLmE7A4p4CdxPMvD5lBmiUElnJI/L87iwXiCReJu53rmSFsYYlX
 x7ewQ9hSEi/726Dsaon/Sy4xQTS3MEp0LV3JBpGwl5jWcQJsELNApkT/0jWsEH8qSxy5BRXm
 k+g4/JcdIswr0dEmBNGpLPHx0CGotZISyy+9hproIbHixSdWSKisZZI48XMu0wRGuVlI/pmF
 ZNssoLHMApoS63fpQ4TlJZq3zmaGCEtLLP/HgaRiASPbKkax1ILi3PTUYqMCI3hkJ+fnbmIE
 J1sttx2MU95+0DvEyMTBeIhRgoNZSYR3/o3uNCHelMTKqtSi/Pii0pzU4kOMpsCImsgsJZqc
 D0z3eSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MK35uCvl5bll
 bh9FJFy/zUw4eeCCzUV5x51mLt5Btve5FvxQ2H70wxmjM7oRAgbc4fUPoywnCfnufVT0U9A+
 zyLdyvxx+x6R55VZC/+vlc4oVvnJ5nDP8n+Udaz/T5nMihtGvr+Odvv5VIkrNG7xzt+m3yKx
 wJb1htrUnPcRf3hubDfvmeHlUBXkmCHd9v/qtXU3f97a0Dn16I5UyT+6T0+aGYTm/lw30fPE
 /5vrboYu9PtxRmyBdZ/BofnBW6uWXUwRWrnppVDG9bYH8/3MbKwz1R0jy969KzFuYX8sOWe2
 Q+b/jX36QY4tj6uuJ3+btWRerKVQn5Si/L/5FXLGutbV5e/nFzK9enRg73PtZCWW4oxEQy3m
 ouJEAMLKfDk/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO6t1b1pBhcWKFv8WbuQ2WLZpc9M
 Fieef2a2WPp2K7vFs9MHmC3+/3rFarFl/zd2i+O9O1gs5v68xmKx+NZ5Rgcuj3/rHrN4LN7z
 ksnjybXNTB4fn95i8Xi/7yqbR9+WVYwBbFFcNimpOZllqUX6dglcGTfffmUr2CxXMbGnjbWB
 caloFyMHh4SAicT992pdjFwcQgK7GSXWLZ3M3sXICRSXlNh3+iYrhC0scb/lCCtE0VNGiZc3
 NzODJFgEVCUuT3nMBGKzCahLNEx9xQJiiwjYSDSd3sEI0sAsMJtZ4vSsmWBFwgJuEh27p4MV
 8QpoSHz4vZwNYupaJokZ65YwQiQEJU7OfAJWxAw09c+8S8wgpzILSEss/8cBEZaXaN46G+wI
 TgE7iedfHjJPYBSchaR7FpLuWQjds5B0L2BkWcUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpec
 n7uJERxHWho7GO/N/6d3iJGJg/EQowQHs5II7/wb3WlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
 eQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MHXvvxEea2xt6LxUWyUo3VT+9McLZ24ftTEqPtve
 uOnwb+euP2+DdG73fDIrWP+C83ebxJHajCkLfSPL8rqj51WWXGWL71VkzPcJOTBvfab1q4+/
 Mw782uVnP/2hrmhoysbgrtdS+rdLm11f/P/iofh9hkGAx+usw1bNudvz9FKtonLdAi7tvSa1
 dOmzFYu8a7T7lXJXSFzpsW+0e2LObaWT7H782cSYY7eiF65iOMHE5Cgb/vJGuLHMuff64c/O
 SYkZX/++6eGPG8H2X5y36f658e4AS9+7D19s9plpFv/6tNZJdta6jzK3elae2ir98jIvxyJL
 sdXGFhv/fL97ziLhG5PunAdbch0rvnH4HVRiKc5INNRiLipOBACdLpk0EgMAAA==
X-CMS-MailID: 20240709213002epcas2p28d9a411d549ecbadd3b3a5eeba10c423
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b9e2d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <CGME20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a@epcas2p2.samsung.com>
 <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
 <Zo0NpttNP8OkrOG8@localhost>
 <929fc1df-0a19-4da0-8399-5d792dd25684@eviden.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=minwoo.im@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b9e2d_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-09 11:58:53, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 09/07/2024 12:15, Minwoo Im wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> > On 24-07-02 05:52:45, CLEMENT MATHIEU--DRIF wrote:
> >> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>
> >> Devices implementing ATS can send translation requests using
> >> pci_ats_request_translation_pasid.
> >>
> >> The invalidation events are sent back to the device using the iommu
> >> notifier managed with pci_register_iommu_tlb_event_notifier and
> >> pci_unregister_iommu_tlb_event_notifier
> >>
> >> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >> ---
> >>   hw/pci/pci.c         | 44 +++++++++++++++++++++++++++++++++++++
> >>   include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 96 insertions(+)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 7a483dd05d..93b816aff2 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -2833,6 +2833,50 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
> >>       }
> >>   }
> >>
> >> +ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
> >> +                                          bool priv_req, bool exec_req,
> >> +                                          hwaddr addr, size_t length,
> >> +                                          bool no_write, IOMMUTLBEntry *result,
> >> +                                          size_t result_length,
> >> +                                          uint32_t *err_count)
> >> +{
> >> +    assert(result_length);
> >> +    IOMMUMemoryRegion *iommu_mr = pci_device_iommu_memory_region_pasid(dev,
> >> +                                                                        pasid);
> >> +    if (!iommu_mr || !pcie_ats_enabled(dev)) {
> >> +        return -EPERM;
> >> +    }
> >> +    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
> >> +                                                       exec_req, addr, length,
> >> +                                                       no_write, result,
> >> +                                                       result_length,
> >> +                                                       err_count);
> >> +}
> > Can we use this function not from the endpoint PCI device, but inside of the pci
> > subsystem (hw/pci/pci.c) to make transparent abstraction for ATS request from
> > PCI endpoint device POV?  I guess it would be better to have PCI subsystem to
> > issue ATS request if pcie_ats_enabled(dev) rather than calling from the endpoint
> > side.
> Hi,
> 
> This series aims to bring support for SVM (we are trying to integrate 
> the patches bit by bit).
>  From a spec point of view, I don't know if it would make sense to 
> implement the SVM logic at the PCI level
> as it's supposed to be implemented by endpoint devices.

Understood that this series is targeting the SVM usage.  But ATS feature is
something general to PCI devices, not only just for SVM, so I guess it would be
better to have caller to `pci_ats_request_translation_pasid()` in pci subsystem
like pci_dma_rw() to avoid duplicated implementation in the future for the
other PCI enpoint devices.

> However, we could consider providing a reference/reusable/encapsulated 
> implementation of SVM with a simplified API
> that would call the pci_* functions under the hood.

I would prefer that PCI devices which want to request ATS translation has no
additional implementation for ATS, but only pcie_ats_init().

> 
> Do you have a specific use case in mind?

ATS/PRI is the actual use case, and it's not that different what you are
targeting for :)

> 
>  >cmd
> 
> >

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b9e2d_
Content-Type: text/plain; charset="utf-8"


------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b9e2d_--

