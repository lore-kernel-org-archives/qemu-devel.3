Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7B6C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRozh-0005Op-7l; Thu, 11 Jul 2024 04:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sRozf-0005IR-8Y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:17:35 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sRozb-0007rC-B5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:17:35 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240711081719epoutp0171c41bcd01ce2f68769d5d1bf9d64104~hGqeg2ptd1701617016epoutp01v
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240711081719epoutp0171c41bcd01ce2f68769d5d1bf9d64104~hGqeg2ptd1701617016epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720685839;
 bh=/1GQWDlJ/RdMiFKGxg9Xa/BS4nrIiFhTTiGJ2xIRZyk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gF/Kiq3r2JjuzXUsvd6S4em0mPf7VGu87TeUCE4vTnOelx49M5f71ThtnVDTd1+xH
 gpk8kPiIAIwM6G/Bjq2VxMwsKl/sPLY8MMOOMcT4D0z1opsiysdPwe0FSfjuD6XSIW
 UJgu1hG5Uq4wfRiwrinPD2bMrPHGXinyUGGJsPrE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240711081719epcas2p391aacdbe06e6b1c5b1fdf13d7f0e5a14~hGqeOlvg52041120411epcas2p3H;
 Thu, 11 Jul 2024 08:17:19 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4WKSJG6myDz4x9Ps; Thu, 11 Jul
 2024 08:17:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.DD.25328.E059F866; Thu, 11 Jul 2024 17:17:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240711081718epcas2p2ab37b57d411254030138ae8ae3e55c89~hGqdI3HGP2792527925epcas2p26;
 Thu, 11 Jul 2024 08:17:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240711081718epsmtrp239a66da784a68f7ffe1f0e04174801c3~hGqdIJQdg2340723407epsmtrp2V;
 Thu, 11 Jul 2024 08:17:18 +0000 (GMT)
X-AuditID: b6c32a4d-d53ff700000262f0-48-668f950e1b30
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.16.29940.E059F866; Thu, 11 Jul 2024 17:17:18 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240711081718epsmtip2f791d25280d2e12763c5a0b0febdf7df~hGqc4_Z793133731337epsmtip2l;
 Thu, 11 Jul 2024 08:17:18 +0000 (GMT)
Date: Thu, 11 Jul 2024 17:04:44 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Message-ID: <Zo+SHAPHSbaIOJ25@localhost>
MIME-Version: 1.0
In-Reply-To: <156af18e-255d-4149-be7b-bb93dc360da3@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmqS7f1P40g/33jC3+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zByg25QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
 BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkXl25gK9hsUNHXYdjA2KnSxcjJISFgInG76QJr
 FyMXh5DAHkaJebu2M0E4nxgl1r16AuV8Y5T487ufHaal7Ww/I0RiL6PE5JlToJznQM7vjawg
 VSwCqhKXDp4D62ATUJdomPqKBcQWEbCRaDq9A6yBWWA6s8TdjntgDcICbhIdu6cDFXFw8Apo
 SJy/EwkS5hUQlDg58wlYL6eAnUTrnDY2kF4JgYUcEr/bf0Gd5CKx9u5cZghbWOLV8S1QcSmJ
 z+/2skHY1RL/l1xigmhuYZToWroSKmEvMa3jBNhiZoFMidXrfEFMCQFliSO3wPYyC/BJdBz+
 yw4R5pXoaBOCaFSW+HjoENRWSYnll15DDfSQWPHiEzRMG5gl9n39yDyBUW4WkndmISyDMDUl
 1u/SnwW2TF6ieetsZoiwtMTyfxxIKhYwsq1ilEotKM5NT002KjDUzUsth0d3cn7uJkZwwtXy
 3cH4ev1fvUOMTByMhxglOJiVRHjn3+hOE+JNSaysSi3Kjy8qzUktPsRoCoypicxSosn5wJSf
 VxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDU9v8mFx9r0/RPn9v
 v2DqmCEhZcT7iXvPZ2tfnaA59pmBPmd3rZ7gfd9+U/6iM8LG3Ue9favWuhUZ8v4ObL1oZT9r
 ca3x15UfGZdkbPR9yik1NdFvXWucu8kHN3Mds65Fv9OnHvcRMF104y3nZE+NS43OkbONHPYf
 mOW8h49NRKdsrdf+50HGy7RZDJXWCeQI3Yrf7rbHQzpONr4r/yLj03LVpFyFs8fbj7jrRG9q
 yX6bfff5B+PXE81Y/pj4yDJt0219vn3TMt8bc15wXWSe6ci994RBSGOAN7uxmYVGgv/xpsJP
 CtoSVa+VQuxzVVrf1FTtygzKUzogcnBh6q+gGX2fd8zlu1X+affrM/1KLMUZiYZazEXFiQCw
 UCl2QQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvC7f1P40g8YTAhZ/1i5ktlh26TOT
 xYnnn5ktlr7dym7x7PQBZov/v16xWmzZ/43d4njvDhaLuT+vsVgsvnWe0YHL49+6xywei/e8
 ZPJ4cm0zk8fHp7dYPN7vu8rm0bdlFWMAWxSXTUpqTmZZapG+XQJXxsWWN4wFl3Qrpuy7wt7A
 eESxi5GTQ0LARKLtbD9jFyMXh5DAbkaJZwdPMkIkJCX2nb7JCmELS9xvOcIKUfSUUaLjRgsT
 SIJFQFXi0sFz7CA2m4C6RMPUVywgtoiAjUTT6R1gU5kFZjNLnJ41E6xBWMBNomP3dKAiDg5e
 AQ2J83ciIYY2MEvc2/APbBuvgKDEyZlPwAYxAw39M+8SM0g9s4C0xPJ/HBBheYnmrbOZQWxO
 ATuJ1jltbBMYBWch6Z6FpHsWQvcsJN0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
 bmIEx5GW5g7G7as+6B1iZOJgPMQowcGsJMI7/0Z3mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
 8Re9KUIC6YklqdmpqQWpRTBZJg5OqQammcxf5izSmqZXFxSy/KTyWacJS4LTtkscY/HxWvBk
 5hy+lsdGGwWbfQNXmy5eVVsoXmK+w8DORPiBj4Z5Z4GkrFnIdJmVh244pMpMdljmm37HfMva
 e5dufGJw+9pc+429M/+R0JKM+9HN+17tfaIYW7r0pPMTI8FJp0RzVJbO4jtnPnld45/jSvI7
 HotJL/ltO6V7hnv0zq+betYcm6ytOdHifUVAova5zJrrHEX/o/iazotUJX+X4bHLdq9TabxS
 uLFjd/qlOboMGqxqhXfKXVo32Maunb+3I5fb+838dG0X2U/zypLvBh782cS7RqR0Y2s2r1ih
 auup3v/7DLa1sHFetd5j/vmUqtWRfaJKLMUZiYZazEXFiQDTPO2VEgMAAA==
X-CMS-MailID: 20240711081718epcas2p2ab37b57d411254030138ae8ae3e55c89
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1cdf18_"
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

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1cdf18_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-10 05:17:42, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 09/07/2024 23:17, Minwoo Im wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> > On 24-07-09 11:58:53, CLEMENT MATHIEU--DRIF wrote:
> >>
> >> On 09/07/2024 12:15, Minwoo Im wrote:
> >>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >>>
> >>>
> >>> On 24-07-02 05:52:45, CLEMENT MATHIEU--DRIF wrote:
> >>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>>>
> >>>> Devices implementing ATS can send translation requests using
> >>>> pci_ats_request_translation_pasid.
> >>>>
> >>>> The invalidation events are sent back to the device using the iommu
> >>>> notifier managed with pci_register_iommu_tlb_event_notifier and
> >>>> pci_unregister_iommu_tlb_event_notifier
> >>>>
> >>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>>> ---
> >>>>    hw/pci/pci.c         | 44 +++++++++++++++++++++++++++++++++++++
> >>>>    include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >>>>    2 files changed, 96 insertions(+)
> >>>>
> >>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>> index 7a483dd05d..93b816aff2 100644
> >>>> --- a/hw/pci/pci.c
> >>>> +++ b/hw/pci/pci.c
> >>>> @@ -2833,6 +2833,50 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
> >>>>        }
> >>>>    }
> >>>>
> >>>> +ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
> >>>> +                                          bool priv_req, bool exec_req,
> >>>> +                                          hwaddr addr, size_t length,
> >>>> +                                          bool no_write, IOMMUTLBEntry *result,
> >>>> +                                          size_t result_length,
> >>>> +                                          uint32_t *err_count)
> >>>> +{
> >>>> +    assert(result_length);
> >>>> +    IOMMUMemoryRegion *iommu_mr = pci_device_iommu_memory_region_pasid(dev,
> >>>> +                                                                        pasid);
> >>>> +    if (!iommu_mr || !pcie_ats_enabled(dev)) {
> >>>> +        return -EPERM;
> >>>> +    }
> >>>> +    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
> >>>> +                                                       exec_req, addr, length,
> >>>> +                                                       no_write, result,
> >>>> +                                                       result_length,
> >>>> +                                                       err_count);
> >>>> +}
> >>> Can we use this function not from the endpoint PCI device, but inside of the pci
> >>> subsystem (hw/pci/pci.c) to make transparent abstraction for ATS request from
> >>> PCI endpoint device POV?  I guess it would be better to have PCI subsystem to
> >>> issue ATS request if pcie_ats_enabled(dev) rather than calling from the endpoint
> >>> side.
> >> Hi,
> >>
> >> This series aims to bring support for SVM (we are trying to integrate
> >> the patches bit by bit).
> >>   From a spec point of view, I don't know if it would make sense to
> >> implement the SVM logic at the PCI level
> >> as it's supposed to be implemented by endpoint devices.
> > Understood that this series is targeting the SVM usage.  But ATS feature is
> > something general to PCI devices, not only just for SVM, so I guess it would be
> > better to have caller to `pci_ats_request_translation_pasid()` in pci subsystem
> > like pci_dma_rw() to avoid duplicated implementation in the future for the
> > other PCI enpoint devices.
> 
> Would we store the ATC directly in the PCI subsytem?

Yes, endpoint device (e.g., svm.c) should call pci_* helpers in PCI subsystem
with `PCIDevice *pdev instance` which represents the endpoint device itself.
By the instance, we can look up the IOTLB entry from the ATC in the PCI
subsystem, not the current caller side.

> >
> >> However, we could consider providing a reference/reusable/encapsulated
> >> implementation of SVM with a simplified API
> >> that would call the pci_* functions under the hood.
> > I would prefer that PCI devices which want to request ATS translation has no
> > additional implementation for ATS, but only pcie_ats_init().
> Hi,
> 
> I think both strategies can coexist.
> Keeping control can be interesting for people who use Qemu for hardware 
> prototyping and who generally want to experiment.
> We can keep the current PCI-level API for devices that want to 
> reimplement the logic themselves
> and add a kind of "DMA module"/"ATS+PRI module" that works out of the box.

I think we should proivde hybrid mode on this.  One for a `generic` cache
policy mode for every PCI endpoint devices which can be controlled in the PCI
subsystem for ATC, the other one is that device-specific cache policy mode
which let each device implement their own ATC lookup behaviors to optimize
their own caching impact.

> That module could be called "struct PciDmaModule" and expose a simple 
> set of functions like pci_dma_module_init, pci_dma_module_read, 
> pci_dma_module_write.
> I think it's important to keep existing DMA API as is to allow devices 
> to do both "with ATS" and "without ATS" operations.
> 
> Do you agree with that?

Indeed.  Keeping the existing APIs is a good choice, but I would like to have
endpoint devices code much more simpler for the generic usages :)

> >
> >> Do you have a specific use case in mind?
> > ATS/PRI is the actual use case, and it's not that different what you are
> > targeting for :)
> >
> >>   >cmd
> >>
> >>>

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1cdf18_
Content-Type: text/plain; charset="utf-8"


------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1cdf18_--

