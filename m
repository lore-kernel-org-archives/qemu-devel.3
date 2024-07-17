Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10948C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 23:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUEVx-00039T-Hx; Wed, 17 Jul 2024 19:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sUEVv-00033H-BR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 19:56:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sUEVp-0000JC-Ht
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 19:56:51 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240717235633epoutp043f1f45fab13313277cdf1b4ea933b3a4~jJWPJUSpE1645016450epoutp04M
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 23:56:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240717235633epoutp043f1f45fab13313277cdf1b4ea933b3a4~jJWPJUSpE1645016450epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1721260593;
 bh=RY0bFu40fWQaJ4egn1MaH6pvoltH6zxBuTwbRmum7RY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mucMDaDEw6tUEieUvhHL/WKMnStxNaLtOfQ2f53sM5AhCgmsH2L2aTsHFVSX51BLl
 pO3iAfBnlx8ZH8g8tjOcKswPI8jHCOmqdB0qrL08DlGZdzgRrtst2yLKnz8AiaWLOj
 RsplZf4hdseuehYPKB3RRDCUPcRdFNn/jOMHjOJw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240717235632epcas2p29c84339d502eb13c7048d73624e2c6a7~jJWO2byru2884528845epcas2p2X;
 Wed, 17 Jul 2024 23:56:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4WPXsD1DnDz4x9Py; Wed, 17 Jul
 2024 23:56:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.10.09848.F2A58966; Thu, 18 Jul 2024 08:56:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20240717235631epcas2p4fd8d616e3fb63ad69b12ee4476108e31~jJWN0EwPj1855318553epcas2p4g;
 Wed, 17 Jul 2024 23:56:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240717235631epsmtrp27d76d4ef0093e2b635c992a21d1486e0~jJWNzOwIc1951619516epsmtrp2T;
 Wed, 17 Jul 2024 23:56:31 +0000 (GMT)
X-AuditID: b6c32a45-447fe70000002678-75-66985a2f6fb7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.F8.19057.F2A58966; Thu, 18 Jul 2024 08:56:31 +0900 (KST)
Received: from localhost (unknown [12.36.63.198]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240717235631epsmtip1e62a27edfc0cc4cad7adf55e714a32ee~jJWNlz-F51080210802epsmtip1V;
 Wed, 17 Jul 2024 23:56:31 +0000 (GMT)
Date: Thu, 18 Jul 2024 08:44:02 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com,
 jongh2.jeong@samsung.com
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Message-ID: <ZphXQjbDzezleP8R@localhost>
MIME-Version: 1.0
In-Reply-To: <a1d82288-a3a7-46f0-b6bd-bb636ecc147d@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmua5B1Iw0g74OZos/axcyWyy79JnJ
 4sTzz0DWrwcsFkvfbmW3eHb6ALPF/1+vWC227P/GbnG8dweLxdyf11gsFt86z+jA7fFv3WMW
 j8V7XjJ5PLm2mcnj49NbLB7v911l8+jbsooxgC0q2yYjNTEltUghNS85PyUzL91WyTs43jne
 1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EAlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1S
 akFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGu9uv2QummFcsX/6DrYHxpGYXIyeHhICJ
 RHffNpYuRi4OIYEdjBKbH/WwQjifGCV2vpsGlfnGKLHm63E2mJbbVz4wQiT2Mko8e3kcquoZ
 o8SM5WuYQKpYBFQlpl39yw5iswmoSzRMfcUCYosI2Eg0nd4B1s0ssJlZYufJFkaQhLCAm0TH
 7ulgRbwCGhLb1x1nhbAFJU7OfAIW5xSwk5jc9QWsWUJgKYfE5wXzgLZxADkuEi+mMUOcJyzx
 6vgWdghbSuLzu71QZ1dL/F9yiQmit4VRomvpSqiEvcS0jhNgC5gFMiSm7b0MNVNZ4sgtqDCf
 RMdhkGdAwrwSHW1CEJ3KEh8PHYJaKymx/NJrqIkeEitefIKG42VmiQk/X7FMYJSbheSdWUi2
 zQIayyygKbF+lz5EWF6ieetsZoiwtMTyfxxIKhYwsq1iFEstKM5NTy02KjCEx3Zyfu4mRnDi
 1XLdwTj57Qe9Q4xMHIyHGCU4mJVEeCcwTksT4k1JrKxKLcqPLyrNSS0+xGgKjKeJzFKiyfnA
 1J9XEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAOT3gXeHU5Jfc2X
 VZmW+c06ueWs+uxjIQ0G0RVJZs9Y4/13XdjBur5DM6X9SkLCadc3f7UnhGQtZNJcIt++Wt/p
 M/N37tlFUbKeVZe2W/DaNrlUH3DTsFf0173VuE6dc5e48/LZzV9/LV9/gC199auk5RuyFwc/
 2uhe+fhzdoD6x74ZOimT/x9rOWFvb1b5TjWHlTviomSKSu7vD29v7r1xkLfogVLJ2ZgZGl+V
 GUx45quHv345v07yk38v7+qnEc2HXFxMV9jy2ggW9/8MOt68KuBjoHSlrMvH7fu5Obbay/ud
 6DHf/cOxX4T9MMtzccVWA+22GJF25dkFH68w9Obs7SlNva5R0Zt1Lm7mLiWW4oxEQy3mouJE
 ADEC0jhFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTlc/akaawYqLChZ/1i5ktlh26TOT
 xYnnn4GsXw9YLJa+3cpu8ez0AWaL/79esVps2f+N3eJ47w4Wi7k/r7FYLL51ntGB2+Pfuscs
 Hov3vGTyeHJtM5PHx6e3WDze77vK5tG3ZRVjAFsUl01Kak5mWWqRvl0CV0bvqnPMBdtMKt4+
 fsDSwNiu3sXIySEhYCJx+8oHxi5GLg4hgd2MEkv2rWeHSEhK7Dt9kxXCFpa433IEzBYSeMIo
 8WZOJojNIqAqMe3qX7B6NgF1iYapr1hAbBEBG4mm0zvAhjILbGeW2Pz8F1hCWMBNomP3dDCb
 V0BDYvu646wQmy8zS/zdtZMVIiEocXLmE7AiZqCpf+ZdYu5i5ACypSWW/+OACMtLNG+dzQxi
 cwrYSUzu+sI4gVFwFpLuWUi6ZyF0z0LSvYCRZRWjZGpBcW56brFhgVFearlecWJucWleul5y
 fu4mRnBEaWntYNyz6oPeIUYmDsZDjBIczEoivBMYp6UJ8aYkVlalFuXHF5XmpBYfYpTmYFES
 5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwGS5VvNnw+47red27Eh/VtVR9jVrf07s5nepTB/v
 tbvGP3lXN+nlY6M/tu7HJoq7B8WKl7wvMXHUirm55djrqxzPP0ee2NBe2fyLK+7wyWPRRj5/
 /p1YLafVty1HQkd/zrvsVh9+/osPU94ULXp8clbgX+MnB31uvw+70ePp1MioW/dyj2e1//sV
 7m1fXm3/6qm/aIuJmPqhj3fFuk5fZVsTt41TUvv3lh9ta877vJzQtLT+bMBOc8/f1nJpIsfE
 b5/PuFa9KGOP+iGZxz3f9Zg2KsU++TEtMjgvoynMrr2Hd92XwrOrfH1vc8rUh7lH6acuDfPh
 ePbhx62WT92LZxUXfdIW0Zd48PGJ2L3uB+VKLMUZiYZazEXFiQAxLwwiFwMAAA==
X-CMS-MailID: 20240717235631epcas2p4fd8d616e3fb63ad69b12ee4476108e31
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----kPZdWw8JFmoxBkiMjQTVl4Kq1icPrupLjm_cU6Xxti33FlR-=_42e40_"
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
 <Zo2o6kkqpSgmj4yN@localhost>
 <156af18e-255d-4149-be7b-bb93dc360da3@eviden.com>
 <Zo+SHAPHSbaIOJ25@localhost>
 <a1d82288-a3a7-46f0-b6bd-bb636ecc147d@eviden.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

------kPZdWw8JFmoxBkiMjQTVl4Kq1icPrupLjm_cU6Xxti33FlR-=_42e40_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-11 19:00:58, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 11/07/2024 10:04, Minwoo Im wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> > On 24-07-10 05:17:42, CLEMENT MATHIEU--DRIF wrote:
> >>
> >> On 09/07/2024 23:17, Minwoo Im wrote:
> >>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >>>
> >>>
> >>> On 24-07-09 11:58:53, CLEMENT MATHIEU--DRIF wrote:
> >>>> On 09/07/2024 12:15, Minwoo Im wrote:
> >>>>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >>>>>
> >>>>>
> >>>>> On 24-07-02 05:52:45, CLEMENT MATHIEU--DRIF wrote:
> >>>>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>>>>>
> >>>>>> Devices implementing ATS can send translation requests using
> >>>>>> pci_ats_request_translation_pasid.
> >>>>>>
> >>>>>> The invalidation events are sent back to the device using the iommu
> >>>>>> notifier managed with pci_register_iommu_tlb_event_notifier and
> >>>>>> pci_unregister_iommu_tlb_event_notifier
> >>>>>>
> >>>>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>>>>> ---
> >>>>>>     hw/pci/pci.c         | 44 +++++++++++++++++++++++++++++++++++++
> >>>>>>     include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>     2 files changed, 96 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>>>> index 7a483dd05d..93b816aff2 100644
> >>>>>> --- a/hw/pci/pci.c
> >>>>>> +++ b/hw/pci/pci.c
> >>>>>> @@ -2833,6 +2833,50 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
> >>>>>>         }
> >>>>>>     }
> >>>>>>
> >>>>>> +ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
> >>>>>> +                                          bool priv_req, bool exec_req,
> >>>>>> +                                          hwaddr addr, size_t length,
> >>>>>> +                                          bool no_write, IOMMUTLBEntry *result,
> >>>>>> +                                          size_t result_length,
> >>>>>> +                                          uint32_t *err_count)
> >>>>>> +{
> >>>>>> +    assert(result_length);
> >>>>>> +    IOMMUMemoryRegion *iommu_mr = pci_device_iommu_memory_region_pasid(dev,
> >>>>>> +                                                                        pasid);
> >>>>>> +    if (!iommu_mr || !pcie_ats_enabled(dev)) {
> >>>>>> +        return -EPERM;
> >>>>>> +    }
> >>>>>> +    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
> >>>>>> +                                                       exec_req, addr, length,
> >>>>>> +                                                       no_write, result,
> >>>>>> +                                                       result_length,
> >>>>>> +                                                       err_count);
> >>>>>> +}
> >>>>> Can we use this function not from the endpoint PCI device, but inside of the pci
> >>>>> subsystem (hw/pci/pci.c) to make transparent abstraction for ATS request from
> >>>>> PCI endpoint device POV?  I guess it would be better to have PCI subsystem to
> >>>>> issue ATS request if pcie_ats_enabled(dev) rather than calling from the endpoint
> >>>>> side.
> >>>> Hi,
> >>>>
> >>>> This series aims to bring support for SVM (we are trying to integrate
> >>>> the patches bit by bit).
> >>>>    From a spec point of view, I don't know if it would make sense to
> >>>> implement the SVM logic at the PCI level
> >>>> as it's supposed to be implemented by endpoint devices.
> >>> Understood that this series is targeting the SVM usage.  But ATS feature is
> >>> something general to PCI devices, not only just for SVM, so I guess it would be
> >>> better to have caller to `pci_ats_request_translation_pasid()` in pci subsystem
> >>> like pci_dma_rw() to avoid duplicated implementation in the future for the
> >>> other PCI enpoint devices.
> >> Would we store the ATC directly in the PCI subsytem?
> > Yes, endpoint device (e.g., svm.c) should call pci_* helpers in PCI subsystem
> > with `PCIDevice *pdev instance` which represents the endpoint device itself.
> > By the instance, we can look up the IOTLB entry from the ATC in the PCI
> > subsystem, not the current caller side.
> >
> >>>> However, we could consider providing a reference/reusable/encapsulated
> >>>> implementation of SVM with a simplified API
> >>>> that would call the pci_* functions under the hood.
> >>> I would prefer that PCI devices which want to request ATS translation has no
> >>> additional implementation for ATS, but only pcie_ats_init().
> >> Hi,
> >>
> >> I think both strategies can coexist.
> >> Keeping control can be interesting for people who use Qemu for hardware
> >> prototyping and who generally want to experiment.
> >> We can keep the current PCI-level API for devices that want to
> >> reimplement the logic themselves
> >> and add a kind of "DMA module"/"ATS+PRI module" that works out of the box.
> > I think we should proivde hybrid mode on this.  One for a `generic` cache
> > policy mode for every PCI endpoint devices which can be controlled in the PCI
> > subsystem for ATC, the other one is that device-specific cache policy mode
> > which let each device implement their own ATC lookup behaviors to optimize
> > their own caching impact.
> >
> >> That module could be called "struct PciDmaModule" and expose a simple
> >> set of functions like pci_dma_module_init, pci_dma_module_read,
> >> pci_dma_module_write.
> >> I think it's important to keep existing DMA API as is to allow devices
> >> to do both "with ATS" and "without ATS" operations.
> >>
> >> Do you agree with that?
> > Indeed.  Keeping the existing APIs is a good choice, but I would like to have
> > endpoint devices code much more simpler for the generic usages :)
> That's a good point, we will se what we can do once the current work is 
> integrated.
> Thanks for your comment :)

Do you have a plan to repost this series soon? I would like to apply your
patches and review/test this series.  It looks like you've been through some of
fix patches for VT-d, but I'm curious your further plan for the actual SVM
feature :)

> >
> >>>> Do you have a specific use case in mind?
> >>> ATS/PRI is the actual use case, and it's not that different what you are
> >>> targeting for :)
> >>>
> >>>>    >cmd
> >>>>
> >>>>>

------kPZdWw8JFmoxBkiMjQTVl4Kq1icPrupLjm_cU6Xxti33FlR-=_42e40_
Content-Type: text/plain; charset="utf-8"


------kPZdWw8JFmoxBkiMjQTVl4Kq1icPrupLjm_cU6Xxti33FlR-=_42e40_--

