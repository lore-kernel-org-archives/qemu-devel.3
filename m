Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC686C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnzh-0003O4-Kj; Mon, 08 Jul 2024 09:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnzJ-0003E4-5q
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnzF-0000T4-4y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:00 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240708130045epoutp0409bf9a518a99e0ff61b3a0c4cf93ed28~gPmE_fZY72794427944epoutp04v
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2024 13:00:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240708130045epoutp0409bf9a518a99e0ff61b3a0c4cf93ed28~gPmE_fZY72794427944epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720443645;
 bh=EuMHvHvTqb7j2DsD6SGPXusbY2ax0KuZt8lsdJfDcK0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kyUVT3CKMAkde3oRLKkgANaR3JVP4BqilODQSx9dcLw6Zvq9ccWjOaVkdqoRMhIGq
 sdSgFW1VOPRJJoK1e9L70hAagqL9A75bdyGgCTINTdJQ96Q0RRoo93ILkYuIRfODDn
 qorcywBCwGqNgMzokEPU4eBApSuoSZxmOYijN3FI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240708130044epcas2p3e7ddc95856c2dca0232609ba592e36de~gPmEhpPP11536415364epcas2p3k;
 Mon,  8 Jul 2024 13:00:44 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.102]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4WHkkg5HXwz4x9Pt; Mon,  8 Jul
 2024 13:00:43 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E3.57.25328.BF2EB866; Mon,  8 Jul 2024 22:00:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240708130043epcas2p240bc5dcfa204bc2356d05f86be5cdb5b~gPmDJ8pcW2124021240epcas2p2D;
 Mon,  8 Jul 2024 13:00:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240708130043epsmtrp22bc2afd97dbaa81ebf573a37ade364f8~gPmDJESSY3038030380epsmtrp2G;
 Mon,  8 Jul 2024 13:00:43 +0000 (GMT)
X-AuditID: b6c32a4d-d53ff700000262f0-22-668be2fb399f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 38.28.18846.AF2EB866; Mon,  8 Jul 2024 22:00:42 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240708130042epsmtip2753788d0d35b50d4a325f42ad8657c1c~gPmC8Z9eK1342213422epsmtip2f;
 Mon,  8 Jul 2024 13:00:42 +0000 (GMT)
Date: Mon, 8 Jul 2024 21:48:13 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH  v5 1/4] intel_iommu: fix FRCD construction macro
Message-ID: <ZovgDVfCsJ01CFyS@localhost>
MIME-Version: 1.0
In-Reply-To: <20240708113908.19535-2-clement.mathieu--drif@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmhe7vR91pBr3ztSz+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zByg25QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
 BeYFesWJucWleel6eaklVoYGBkamQIUJ2RktX18zFXxiq7i+7TlzA2MvWxcjJ4eEgInEo117
 2LsYuTiEBPYwSrRea2ECSQgJfGKUeDKRCSIBZHe9/MwK0zGlYQ0jRGIno8Snn2ehqp4zSvzd
 0AM2l0VARWLFz70sIDabgLpEw9RXYLaIgI1E0+kdYN3MAtOZJe523AMbKyzgKjHv/ll2EJtX
 QEOip/c1I4QtKHFy5hOgZg4OTgE3idVzxEF6JQSmckjcWzqXCSQuIeAisXk1J8R1whKvjm9h
 h7ClJD6/2wv1Z7XE/yWXmCB6W4DeWboSKmEvMa3jBNhxzAKZEpNXNbJBzFSWOHILKswn0XH4
 LztEmFeio00IolNZ4uOhQ8wQtqTE8kuvoSZ6SHzq+wQNoKuMEmunnGKewCg3C8k3s5BsmwU0
 lllAU2L9Ln2IsLxE89bZzBBhaYnl/ziQVCxgZFvFKJVaUJybnppsVGCom5daDo/v5PzcTYzg
 lKvlu4Px9fq/eocYmTgYDzFKcDArifDOv9GdJsSbklhZlVqUH19UmpNafIjRFBhVE5mlRJPz
 gUk/ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGJv6vLm/dd7Vu
 +lyyYMeZnP4ZJR+8NkXYBnb/PDc1oUq470bJiap7bPNv7+mYlnnglV/1ZdMjwnw3lrQw71dZ
 /rbNfGHQNOnwSNkvNR+aOG7vL0zh22PiVXRvxvKghV9m7ci+3zXz0L7/GdPXbggIPanz860P
 yxELBR2T+x+lVE1tivytHjd22jZbG3y99z40R+W3wELWFasbTKa6bW/yMdndIhweG3+Vc3pS
 pMvp9sXSFvN7E+ZJFvnzTH2r+ymPef1jnwLL+1v+FD1ncpiuuVPR7rWxWZyAW8SiY2VWcpe2
 TxJ5kRayS75HTuG3sfHxnRuMjJ5lnny1rJShYr1zVafrIueHM0teKd+SvhzGqcRSnJFoqMVc
 VJwIANo4m39CBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO6vR91pBktfW1n8WbuQ2WLZpc9M
 Fieef2a2WPp2K7vFs9MHmC3+/3rFarFl/zd2i+O9O1gs5v68xmKx+NZ5Rgcuj3/rHrN4LN7z
 ksnjybXNTB4fn95i8Xi/7yqbR9+WVYwBbFFcNimpOZllqUX6dglcGStOb2crmMhS8ebWarYG
 xhPMXYycHBICJhJTGtYwdjFycQgJbGeUaHm1jw0iISmx7/RNVghbWOJ+yxFWiKKnjBKn318F
 S7AIqEis+LmXBcRmE1CXaJj6CswWEbCRaDq9A2wqs8BsZonTs2YygSSEBVwl5t0/yw5i8wpo
 SPT0voZafZVRYtWnW4wQCUGJkzOfgE1iBpr6Z94loFs5gGxpieX/OCDC8hLNW2eDhTkF3CRW
 zxGfwCg4C0nzLCTNsxCaZyFpXsDIsopRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOH60gnYw
 Llv/V+8QIxMH4yFGCQ5mJRHe+Te604R4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeW
 pGanphakFsFkmTg4pRqY1BUdjtzdLrRs4Y6mZNfVxT/CvM56beOVbveJObq68KZqe2Wu3d2D
 O+wXWideuPKvddYqn2OPBA6UGRsJ632sj50dvPnOXTfFx0vSTHw/8rjohdYs5s5Jmcibx++6
 bfLdLQw1bqUaRzSVWCSuWPyZdbCzt3Hfd/OL4o1rNDIt/1Xvmrz1/9awE6ofLRX6N0dJWPUt
 MfqeJhwutpZrgV+jrGuN6PVn64X71kz7s7OjX/k87/4vh1xbbH2Ot36+YbJ44pUTc44f2WTl
 tWbZm4TeGZtMWc3m2s56c4NBquvCEaldj4xeSrDEpiSvyvrqZxXz90nbv+AIedOiiy4GFxKP
 pNaqbBBUXHLzg+j3HZ17lFiKMxINtZiLihMBg0/qCQ4DAAA=
X-CMS-MailID: 20240708130043epcas2p240bc5dcfa204bc2356d05f86be5cdb5b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----He.yNZkzpBak.xuDKC9auljxNssTvAfbOgKyc16DCg-DQrdx=_1a87d5_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240708114058epcas2p3c43bdc21c3a08a5dce027bc95a266ac2
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
 <CGME20240708114058epcas2p3c43bdc21c3a08a5dce027bc95a266ac2@epcas2p3.samsung.com>
 <20240708113908.19535-2-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
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

------He.yNZkzpBak.xuDKC9auljxNssTvAfbOgKyc16DCg-DQrdx=_1a87d5_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-08 11:39:53, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The constant must be unsigned, otherwise the two's complement
> overrides the other fields when a PASID is present.
> 
> Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

------He.yNZkzpBak.xuDKC9auljxNssTvAfbOgKyc16DCg-DQrdx=_1a87d5_
Content-Type: text/plain; charset="utf-8"


------He.yNZkzpBak.xuDKC9auljxNssTvAfbOgKyc16DCg-DQrdx=_1a87d5_--

