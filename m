Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37039C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 10:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR84f-0004IM-Sn; Tue, 09 Jul 2024 06:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sR84c-0004GW-MP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:27:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sR84X-0006Oh-L9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:27:50 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240709102735epoutp031d06bc8bb07bb42bbb6266f7b5352193~ghJoqDfAw1641216412epoutp03g
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2024 10:27:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240709102735epoutp031d06bc8bb07bb42bbb6266f7b5352193~ghJoqDfAw1641216412epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720520855;
 bh=YqyeHxL78ThG96lQTQog+FIXs+685GTl3PmSws78rgY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RtIEoiBv5B8nTqEQV5pVTIBPS5o0H0tMEtR56FE213XSfrU6V6dwF8Qw6fsHQwiyH
 HqXiYjHAk6OqQUHZB6hbW+wDpnmJOPiXGNfENYInHtKoI8ibmoLCeXXh/buLq8iS9Q
 aKRDFMsbbA+6oxUkZ1P4TalVealEG+bWTY0eZPNI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240709102735epcas2p28bb049408c48a32894e6e9b5e58b562b~ghJoXYL-r0665606656epcas2p24;
 Tue,  9 Jul 2024 10:27:35 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WJHHV37Vsz4x9Q1; Tue,  9 Jul
 2024 10:27:34 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 32.B9.09806.6901D866; Tue,  9 Jul 2024 19:27:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240709102733epcas2p1a8050270f90e633593c024f583c008fd~ghJnTHNEk2080920809epcas2p1C;
 Tue,  9 Jul 2024 10:27:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240709102733epsmtrp2a23f93b66f6ec9d3b58e4113d9d5176c~ghJnSWMBR1615816158epsmtrp2A;
 Tue,  9 Jul 2024 10:27:33 +0000 (GMT)
X-AuditID: b6c32a47-ecbfa7000000264e-a1-668d10962252
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 1D.FF.18846.5901D866; Tue,  9 Jul 2024 19:27:33 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240709102733epsmtip2b8f29296d6f6eeedb00814f71eebb83c~ghJnG177s2494824948epsmtip2I;
 Tue,  9 Jul 2024 10:27:33 +0000 (GMT)
Date: Tue, 9 Jul 2024 19:15:02 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Message-ID: <Zo0NpttNP8OkrOG8@localhost>
MIME-Version: 1.0
In-Reply-To: <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhe40gd40g/0nRC3+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zByg25QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
 BeYFesWJucWleel6eaklVoYGBkamQIUJ2RlvTjcxFswVrXj7nqWB8QxfFyMnh4SAicS9/a+Z
 uhi5OIQEdjBKnF80lR3C+cQosXnuXCY45/mjv+wwLe1n77NCJHYySlzZ8hjKec4o8ed2OytI
 FYuAisTD99dYQGw2AXWJhqmvwGwRARuJptM7GEEamAWmM0vc7bgH1iAs4CbRsXs6WBGvgIZE
 x5MD7BC2oMTJmU/A4pwCnhIdl1uYIM6YySHxZXFVFyMHkO0i8XJJFkRYWOLV8S1Ql0pJfH63
 lw3Crpb4v+QS2DsSAi2MEl1LV0Il7CWmdZwAm88skClxZHMjG8RMZYkjt6DCfBIdh0G+Bwnz
 SnS0CUF0Kkt8PHSIGcKWlFh+6TXURA+JFS8+QcPkFqPE1/5JTBMY5WYh+WYWkm2zgMYyC2hK
 rN+lDxGWl2jeOpsZIiwtsfwfB5KKBYxsqxjFUguKc9NTi40KjOFxnZyfu4kRnGq13Hcwznj7
 Qe8QIxMH4yFGCQ5mJRHe+Te604R4UxIrq1KL8uOLSnNSiw8xmgKjaSKzlGhyPjDZ55XEG5pY
 GpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwJSz9skt/QRlllTL242VkfuE
 Fm28Lbw4bvl3vZ9VL8K6jt00/L4j8deiAM69eZv+8npNftl9Qnke32/VmWLsh5OD7i4rqPZ0
 uOksWBHIznvZPaJyp436jEW3JlycksNb862ScU3qWZ0/S95EW1ya/XDP4+vpOd4zlYqf1Ci8
 yFr1fsaP5/7c6pPiE/Q85io9W6F06/+R4Mj8O8WvbrsdWntpf57q9/dTnt+W1K7LCbbap/a5
 4vTHP2r//ga9M/vb9fcC2+Jtxjmx5w3/LQ78171ivw1D2ecKpo+mzU65051cn2q9Peyhb3A5
 oCMm12eLU/7FSbzOVtJzBV+v8Gfu3ZV2fve21XdDn+9Z7xG3YoqOEktxRqKhFnNRcSIAK8ug
 qD4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvO5Ugd40gzOv9Sz+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtigum5TUnMyy1CJ9uwSujKN/elkL9ghVvFn3ja2B
 sZ2ni5GTQ0LARKL97H3WLkYuDiGB7YwSSw/9Y4dISErsO32TFcIWlrjfcgSq6CmjxM9Zn5hA
 EiwCKhIP319jAbHZBNQlGqa+ArNFBGwkmk7vYARpYBaYzSxxetZMsAZhATeJjt3TwYp4BTQk
 Op4cYIeYeotR4sKqu2wQCUGJkzOfgBUxA039M+8ScxcjB5AtLbH8HwdEWF6ieetsZhCbU8BT
 ouNyC9MERsFZSLpnIemehdA9C0n3AkaWVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBEaQV
 tINx2fq/eocYmTgYDzFKcDArifDOv9GdJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUgg
 PbEkNTs1tSC1CCbLxMEp1cC0tmTy/zW6Pxzlr6byJt/vsph3s6zQW3V+zbciQ52tO1SuBsW4
 l8SGTo9gmv3yQVeerqrDrje79lo/85A9fu1WFfOkUrfLn4wufQydvfuXVcOdlMe+iyZG7Vol
 a9i0K8Al9cKzzdUfVwokT5N3MlrsdCeCdfuDRZ9jz1elr5h2sKH9OVfYKdsrXvH39NKSu62c
 kxvdFnSdaNq9Imz7890nnp645RRRZLjg5/d9csUzPlx7P+dwzcOrS28/0Puhsv+FiM+kzS95
 1WKdQpcnHNs+ca117aQbmippzKUn4k3uPSibwdjUduUbo5ZqO6Os1RqvzHRVSYG50vHOTo8+
 l/3S3Ls34gQ/y9dcgTtVy/oClViKMxINtZiLihMBDEOYeA8DAAA=
X-CMS-MailID: 20240709102733epcas2p1a8050270f90e633593c024f583c008fd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b60ea_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <CGME20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a@epcas2p2.samsung.com>
 <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b60ea_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-02 05:52:45, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Devices implementing ATS can send translation requests using
> pci_ats_request_translation_pasid.
> 
> The invalidation events are sent back to the device using the iommu
> notifier managed with pci_register_iommu_tlb_event_notifier and
> pci_unregister_iommu_tlb_event_notifier
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/pci/pci.c         | 44 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 7a483dd05d..93b816aff2 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2833,6 +2833,50 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>      }
>  }
>  
> +ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
> +                                          bool priv_req, bool exec_req,
> +                                          hwaddr addr, size_t length,
> +                                          bool no_write, IOMMUTLBEntry *result,
> +                                          size_t result_length,
> +                                          uint32_t *err_count)
> +{
> +    assert(result_length);
> +    IOMMUMemoryRegion *iommu_mr = pci_device_iommu_memory_region_pasid(dev,
> +                                                                        pasid);
> +    if (!iommu_mr || !pcie_ats_enabled(dev)) {
> +        return -EPERM;
> +    }
> +    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
> +                                                       exec_req, addr, length,
> +                                                       no_write, result,
> +                                                       result_length,
> +                                                       err_count);
> +}

Can we use this function not from the endpoint PCI device, but inside of the pci
subsystem (hw/pci/pci.c) to make transparent abstraction for ATS request from
PCI endpoint device POV?  I guess it would be better to have PCI subsystem to
issue ATS request if pcie_ats_enabled(dev) rather than calling from the endpoint
side.

------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b60ea_
Content-Type: text/plain; charset="utf-8"


------y9GWJqC4K.rPJEJ.ALiyjYPlNXwxamzJyfEeFgjpfKb-nUZ-=_1b60ea_--

