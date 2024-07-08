Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402C1C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnzu-0003eQ-N9; Mon, 08 Jul 2024 09:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnze-0003O8-Ve
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnzd-0000Vc-0U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:22 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240708130118epoutp04d7c5e9d50815e8b83c1858b5ae26f844~gPmkFrmpm2794427944epoutp045
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2024 13:01:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240708130118epoutp04d7c5e9d50815e8b83c1858b5ae26f844~gPmkFrmpm2794427944epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720443678;
 bh=atbixfmoFrSMDPhxFoLf58v61Dd8mAaW/YtTqUB5xmk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=catIq3ORcOplAvPxXTHRdw5kcbfNVrE7IHzsiyoC8G/l1wi5AgAsB71CB4AfqPHKs
 YIrItSOLESaYfkgSBi1nM/3shj2lPMzgOZuN1rfXJ2msIqhgb/0bNHinHkKDvtLbEB
 42ozWWTQdA2sTU+gKpiZ4LQuHaM+5LKdhpnQYwh4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240708130117epcas2p4c4fd30badc08b1839731163973993b7d~gPmjlivDy1069510695epcas2p4j;
 Mon,  8 Jul 2024 13:01:17 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4WHklK10fWz4x9Pr; Mon,  8 Jul
 2024 13:01:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 12.03.56241.C13EB866; Mon,  8 Jul 2024 22:01:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240708130116epcas2p2cbafced6c757ca5e35e9a7a08e699a76~gPmiT6qjy1774117741epcas2p2J;
 Mon,  8 Jul 2024 13:01:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240708130116epsmtrp25b1c7c083ed6e63453578d115b483762~gPmiSnyfR3038030380epsmtrp2U;
 Mon,  8 Jul 2024 13:01:16 +0000 (GMT)
X-AuditID: b6c32a43-c03fd7000000dbb1-d1-668be31cb9cf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 36.38.18846.C13EB866; Mon,  8 Jul 2024 22:01:16 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240708130116epsmtip1905ea366e5f9cf3fd6c1a563197e3264~gPmiIqegT2682026820epsmtip1k;
 Mon,  8 Jul 2024 13:01:16 +0000 (GMT)
Date: Mon, 8 Jul 2024 21:48:49 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH  v5 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <ZovgMSZ9NaEsTlr/@localhost>
MIME-Version: 1.0
In-Reply-To: <20240708113908.19535-4-clement.mathieu--drif@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmqa7M4+40g+NPbSz+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zByg25QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
 BeYFesWJucWleel6eaklVoYGBkamQIUJ2RmbH8xkLzjCU9E+pYmlgfEEVxcjJ4eEgInE7Rsd
 bCC2kMAORolVneldjFxA9idGiTvr5zLDOStWzWWC6Vj4by1UYiejxJSm76wQznNGiR/n14DN
 YhFQkXjdd4EZxGYTUJdomPqKBcQWEbCRaDq9gxGkgVlgOrPE3Y57rCAJYYFYiWdPVzOC2LwC
 GhIvljayQtiCEidnPgFq5uDgFHCT+N9tBtIrITCVQ2L5t8vsECe5SMxtOAN1nrDEq+NboOJS
 Ep/f7WWDsKsl/i+5xATR3MIo0bV0JVTCXmJaxwmw65gFMiXaFu1jBFkmIaAsceQWVJhPouPw
 X3aIMK9ER5sQRKeyxMdDh5ghbEmJ5ZdeQ030kPjSd5YdEihXgUF38ArLBEa5WUjemYVk2yyg
 scwCmhLrd+lDhOUlmrfOZoYIS0ss/8eBpGIBI9sqRrHUguLc9NRkowJDeGQn5+duYgQnWy3n
 HYxX5v/TO8TIxMF4iFGCg1lJhHf+je40Id6UxMqq1KL8+KLSnNTiQ4ymwHiayCwlmpwPTPd5
 JfGGJpYGJmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwNb1v9spb4fzj7Z3K
 1Ce2Fv7qm/d8irLYUSKTk8i7WuF4Lmeix/3lt8VYHz89rrnsxfGFPGxsYb83SPY3p97/bMX8
 +OiSoMb2Kq03uRr2W5jyE3Ztbf4j9vd/4Pq90pN3MDOcOhzHsW/ZUxn/NWyP1jRmap41610i
 KmXiV/A974/Foykuwko7Jp1f/2WlQ+0hlckT2b4LZnlNParzcN3V7ftdGJbtj3JNilKJ8fu2
 5fBaHZftfvF9wjsjFh14GBLpYh6yLqmq8Wnl6ka7k+xMXcGcAcJP5gsYzPqkbPis60/DM1nV
 vEzd6VP/Vgkoaqk2MXkc3KHqu7Q8/HBw2+7kq9MVJvYkivrLuExhNWRSYinOSDTUYi4qTgQA
 79sh4z8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnK7M4+40g2MrpC3+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtigum5TUnMyy1CJ9uwSujD9rutkKHnNW/HixnL2B
 sZmji5GTQ0LARGLhv7XMXYxcHEIC2xkl3v3+wAyRkJTYd/omK4QtLHG/5QgrRNFTRol/DxqY
 QBIsAioSr/sugDWwCahLNEx9xQJiiwjYSDSd3sEI0sAsMJtZ4vSsmWANwgKxEs+ermYEsXkF
 NCReLG2EmnqVUeLsianMEAlBiZMzn4BNYgaa+mfeJaA4B5AtLbH8HwdEWF6ieetssDCngJvE
 /26zCYyCs5A0z0LSPAuheRaS5gWMLKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxguNHK2gH
 47L1f/UOMTJxMB5ilOBgVhLhnX+jO02INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpi
 SWp2ampBahFMlomDU6qBKfhO5bPI34+MV8yy/NRZqCF/sEkoRddyv1H734/qluwyf9s3qITd
 e2Ji+KuMJTk7uzrkmkRR8+ek2cprb5XKG8zrTZCaftZsYQ57l9XtLbVK2b6vJsxte2cbbKwZ
 6J3TFnzL6L1O8Y7mU+s2Tt+5YnGOceSfwgNFkxLOXzwQuS3ncHzUqfB7XlcZVn7cXzDBb+WD
 qIpI8Qm/r1oqWnJeEj/VVhFusZb70VzOqH28U4rKdu9a/C9McNkxt3r279fKmk64B4u0rl+X
 9ZIj6FAtx+WKri/Hjp85tLvjYiHH4U8f3+58LcopJGl0fftbPeGHprf3GT1O2fy+kmluUegU
 sasPhKZ1sb7beG5eS72jshJLcUaioRZzUXEiAIQzZH0OAwAA
X-CMS-MailID: 20240708130116epcas2p2cbafced6c757ca5e35e9a7a08e699a76
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_1a9016_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240708114202epcas2p34a65b1d59433192a5d3948f83ba1d6f8
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
 <CGME20240708114202epcas2p34a65b1d59433192a5d3948f83ba1d6f8@epcas2p3.samsung.com>
 <20240708113908.19535-4-clement.mathieu--drif@eviden.com>
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

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_1a9016_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-08 11:39:54, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> fit in an uint8_t. Use uint64_t to avoid overflows.
> 
> Per the below code, it can overflow as am can be larger than 8 according
> to the CH 6.5.2.3 IOTLB Invalidate. And you may want a fix tag as well.
> 
> info.mask = ~((1 << am) - 1);
> 
> CH 6.5.2.3 IOTLB Invalidate
> 
> Address Mask (AM): For page-selective-within-domain invalidations,
> the Address Mask specifies the number of low order bits of the ADDR
> field that must be masked for the invalidation operation. This field
> enables software to request invalidation of contiguous mappings for
> size-aligned regions. Refer to Table 19 for encodings of this field.
> When invalidating a large-page translation, software must use the
> appropriate Address Mask value (0 for 4KByte page, 9 for 2-MByte page,
> and 18 for 1-GByte page). Hardware implementations report the maximum
> supported address mask value through the Capability register.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_1a9016_
Content-Type: text/plain; charset="utf-8"


------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_1a9016_--

