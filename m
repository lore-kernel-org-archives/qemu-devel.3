Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6323FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 05:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkz7K-0006uI-4A; Thu, 20 Feb 2025 00:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tkz7H-0006ti-NE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:28:55 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tkz7E-00048s-Gi
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:28:55 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250220052840epoutp04a510f31802f9baef6936815326ffcb5f~l03KawJac1369413694epoutp04Q
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250220052840epoutp04a510f31802f9baef6936815326ffcb5f~l03KawJac1369413694epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740029320;
 bh=gknErlnI/nCVhLXNlXf6Oh7Q/wQGR8b/boj1h9A7aHM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=fXi7k2Ftd16Doumc9FY4PbneheWKx4LG1BTDtsVsOHKtrTyQWSlIc8uh1aS8Zo0gJ
 nHYQD/x3TL5FzrqhlSx2ETzlzAd3xpcpuiXDNXxU1Cm4XARMNmx9oKzUzfJn7kAOOa
 aMOAn38v0/6Oscj9aLiLhQ5PxUxUaQsrj9vBM9sk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20250220052839epcas5p27a9d99cc7bee8f05f27be0550f185afe~l03KCVCbP0943109431epcas5p2g;
 Thu, 20 Feb 2025 05:28:39 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Yz1yF3Mv0z4x9Q2; Thu, 20 Feb
 2025 05:28:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0A.8D.19710.58DB6B76; Thu, 20 Feb 2025 14:28:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20250220052733epcas5p41f847e5d0233a62703693565ee37374c~l02L-rwUX1131811318epcas5p4f;
 Thu, 20 Feb 2025 05:27:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250220052733epsmtrp260d87358903477cfd659449d7ba6c55f~l02L_LBIz3134831348epsmtrp28;
 Thu, 20 Feb 2025 05:27:33 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-2f-67b6bd85d841
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 75.43.18949.54DB6B76; Thu, 20 Feb 2025 14:27:33 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250220052731epsmtip2d2200820c508c1bde73ac9e15a0d59ad~l02KlSmSN1358513585epsmtip2X;
 Thu, 20 Feb 2025 05:27:31 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH v3 0/3] CXL CCI Media Operations
Date: Thu, 20 Feb 2025 10:57:21 +0530
Message-Id: <20250220052724.1256642-1-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmum7r3m3pBlv2S1pMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
 VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
 6Xp5qSVWhgYGRqZAhQnZGbvfv2YvmMVZsWbGbNYGxr3sXYycHBICJhJvl9wEsrk4hAR2M0o8
 e7eQEcL5xChx/8MRNgjnG6PEkf1v4FpmbjrHApHYyyixuWsrE4TTwCRxeNkHFpAqNgEDiQfN
 x8E6RAQkJX53nWYGsZkFPjBKLHqqC2ILA9Xs3bCPDcRmEVCVeP/zBlg9r4CtxN8bZ5ggtslL
 7D94lhkiLihxcuYTFog58hLNW2czgyyWEHjELvFxwwxWiAYXie7fXWwQtrDEq+NboM6Wkvj8
 bi9UvFji3MVPjBB2jcTrrhXMELa9ROupfiCbA2iBpsT6XfoQYVmJqafWMUHs5ZPo/f0E6jZe
 iR3zQGwOIFtFYunbTJhNX541Q033kLi7cglYuZBArMTbZctZJjDKz0LyzSwk38xCWLyAkXkV
 o2RqQXFuemqyaYFhXmo5PGKT83M3MYKTppbLDsYb8//pHWJk4mA8xCjBwawkwttWvyVdiDcl
 sbIqtSg/vqg0J7X4EKMpMIgnMkuJJucD03ZeSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS
 1OzU1ILUIpg+Jg5OqQamuTllpyyqlzOseeLf9sJNaMLO/66VXLkcxuEro8T/Gp3lFDUOfShv
 9eHClT1/1kw+qaTbb1PPKzCFXVW3Vv4/07wcif+5EaUF8XmnDGYdWSN3/6HPEsneRe18R1Za
 aXRuyE7dMSG4UG3my6Xte2u7501c8XrHD/Wgd25+R5qyPpqeLJnQ2B8aqRf37Lz77pPfG7bw
 GPzq+7HkpIEZ30ur09tYpl3P+Dp7zhz2MxMeW+z4uOTr7V/Ts1VZ+//d1tTx4k+UapRa71j5
 dGbrmzelszOOvZmx/saRCAOWTdNOPVXafZTbK/j00QSHtTfnvKh8+D1G6naUheGn9TPaok80
 GOatsGqXnhYkvGNNk7rgNSWW4oxEQy3mouJEAHSHY7EjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvK7r3m3pBtfvsFlMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6M3e9fsxfM4qxYM2M2awPjXvYuRk4OCQET
 iZmbzrF0MXJxCAnsZpQ4/eMuM0RCSuLYzp9sELawxMp/z9khiv4xStz90cQEkmATMJB40Hwc
 bJKIgKTE767TzCBFzAK/GCWe7r4PlhAGKtq7YR/YJBYBVYn3P2+AxXkFbCX+3jjDBLFBXmL/
 wbPMEHFBiZMzn7CA2MxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5x
 aV66XnJ+7iZGcAhrae1g3LPqg94hRiYOxkOMEhzMSiK8bfVb0oV4UxIrq1KL8uOLSnNSiw8x
 SnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg6tra6Ox80X9BaficSoegeXb2D2+z3Tk2
 PWqK5d7apcGXff6erVRbXiJdymR5/rF86SyDJTP8c2ztbx37UXle4lrUIemppUz/hGP2rAll
 +jxTVDSL3WHF7VsHpkh2rU5etEtqmhlL8byt25OTP8W2bf9z7VTrcVm9t2Ydsl/6FB6sfDAl
 eV9Mz3cm40OnYnbt/3f5RFnmnMlr1vzff8HU0XRtp3zHGebke3Y3F+9IrZB6uv3xR42uiY4P
 HzEmyhaULJu8rfzFPIkLq6fdXXrhTNbexbz7J7xcnMHG8T60WvZWa7dLVFSnbFBuzrHF/y9b
 r9bRD/nhN6/ngfWugkqFVXs8gqvsWY5wGT3mvOB2eo8SS3FGoqEWc1FxIgCmdxUm0AIAAA==
X-CMS-MailID: 20250220052733epcas5p41f847e5d0233a62703693565ee37374c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220052733epcas5p41f847e5d0233a62703693565ee37374c
References: <CGME20250220052733epcas5p41f847e5d0233a62703693565ee37374c@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=vinayak.kh@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

CXL CCI media operations commands implmented as per CXL Specification
3.2 8.2.10.9.5.3
1) General(00h) - Discovery (00h)
2) Sanitize(01h - Sanitize (00h)
                  Write zeros (01h)

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Changes V2 -> V3
- Addressed review comments from Jonathan Cameron.
- Updated CXL Spec r3.2 references

Changes V1->V2
- Addressed the review comments from Jonathan Cameron.

- Modularied the media operations class & subclass handling
into separate functions.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>

Vinayak Holikatti (3):
  hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery
    commands cxl r3.2 (8.2.10.9.5.3)
  hw/cxl: factor out calculation of sanitize duration from
    cmd_santize_overwrite
  hw/cxl/cxl-mailbox-utils: Add support for Media operations Sanitize
    and Write Zeros commands cxl r3.2(8.2.10.9.5.3)

 hw/cxl/cxl-mailbox-utils.c  | 402 +++++++++++++++++++++++++++++++++---
 include/hw/cxl/cxl_device.h |   4 +
 2 files changed, 380 insertions(+), 26 deletions(-)

-- 
2.34.1


