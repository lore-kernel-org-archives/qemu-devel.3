Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5B8CF31BF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 05:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swEfl-0003PD-6V; Thu, 03 Oct 2024 01:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1swEfe-0003On-2r
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 01:46:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1swEfa-0007xT-PU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 01:46:37 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241003054622epoutp039bc36b1af394ab7e6c7e5486f5fb9cb6~62yqBzydJ3225032250epoutp03T
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2024 05:46:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241003054622epoutp039bc36b1af394ab7e6c7e5486f5fb9cb6~62yqBzydJ3225032250epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1727934382;
 bh=F2ING18sTsuH4MsE6f3JYYfilOiYycl42ucfktm12No=;
 h=From:To:Cc:Subject:Date:References:From;
 b=l/vLADnDlz/zoy4nzansZDTOCX0T8F24H7chfdVqGEMSl3F5ZnmP196EYkkzi8OUn
 JgwfsRQ4r6ld0ZiGnFCP5qBr8Iv+u2rC8EeySb0Ayd8TVEpgdrHfW4vZRo77rJmyhN
 CaVGsAIraLOyv9en69M7UWI7gUYAbq6Z3K6IchoQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20241003054622epcas5p3db8aae163ed9986099398e967211771a~62ypio5hm2618226182epcas5p3o;
 Thu,  3 Oct 2024 05:46:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4XK0zJ3kJwz4x9Pt; Thu,  3 Oct
 2024 05:46:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.57.18935.CAF2EF66; Thu,  3 Oct 2024 14:46:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20241001065838epcas5p158f96030a744df180b1b3818287c2a84~6QfLHlPiB0421904219epcas5p1E;
 Tue,  1 Oct 2024 06:58:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241001065838epsmtrp2f3ca34085bafe870cdea73889e1cb026~6QfLG58tb1529415294epsmtrp2c;
 Tue,  1 Oct 2024 06:58:38 +0000 (GMT)
X-AuditID: b6c32a50-cb1f8700000049f7-86-66fe2fac11dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AA.F8.07371.D9D9BF66; Tue,  1 Oct 2024 15:58:37 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20241001065837epsmtip2ca5aeb743abb809f55fbe115ea986f0c~6QfKSRQGx2308723087epsmtip2k;
 Tue,  1 Oct 2024 06:58:37 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH v2] hw/nvme: Adding support for NPDAL and NPDGL
Date: Tue,  1 Oct 2024 06:58:33 +0530
Message-ID: <20241001012833.3551820-1-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmhu4a/X9pBjtmSFjcnsxjcWJKmMX+
 g99YLSYdusZocbx3B4sDq8eUadfYPc7tOM/usWlVJ5vHk2ubmTz6tqxiDGCNyrbJSE1MSS1S
 SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
 0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOONX3hbVgjnDF
 l86lTA2MM/m6GDk5JARMJF42HmTqYuTiEBLYwygxo6udCSQhJPCJUeLepEKIxDdGibcHbrDC
 dNw/8IkFIrGXUeLvuT5miI4uJokn67hBbDYBLYl7L2+xgNgiApISv7tOA9VwcDALJEl0fdYG
 CQsL2Ess/boXbBmLgKrE0bm/mEBKeAVsJJ4+1YdYJS+xeMdysOm8AoISJ2c+AZvIDBRv3jqb
 GeQECYF97BINczZB3eYiMWF/EzuELSzx6vgWKFtK4vO7vWwQdrbEnNZvjBB2icTaeddYIGx7
 iYt7/jJBnKkpsX4X1A2yElNPrWOC2Msn0fv7CRNEnFdix7wnYOUSAsoSPYcMIMKSEk9ef4Ha
 5CHR8/MFCyRwYiWWrWlgncAoPwvJN7OQfDMLYfECRuZVjFKpBcW56anJpgWGunmp5fBYTc7P
 3cQITn9aATsYV2/4q3eIkYmD8RCjBAezkgjvvO1/04R4UxIrq1KL8uOLSnNSiw8xmgKDeCKz
 lGhyPjAB55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwKTJP+Fs
 z0GfnBOF7fFHVr1ryTDa+67lufSlrTs/lhblMB7hu3TBe57xky8/qnYlBrp9vKLf+v/A4tKk
 c2uvpFdV3i4xWMCbeyH/wu7/Fy5c05Q9WTprtsrPLK+LEZ8e3Zi8bs/K25Kda5aULDTL8vNY
 0bzO/psn9/VccU/ev3LJxx9veZcWs9Nz07Hg6Z0NH59c1MzY59P82fVDwmmfV/8sVq+UWftK
 9epMpv6Q+5uXL/gmZ3D5DF/+BicJ5oMSTk+11m7++kPZ4/X6M8vLFtTv9P2jmVCt0F6+rEqh
 +/i/z2snSayIfFx9/O2mreXcDI//HWm16ty0tjv0+a4gadey8+2nmxikd21/kKt2bYKZihJL
 cUaioRZzUXEiAHxyptUIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvO7cub/TDJY9tbK4PZnH4sSUMIv9
 B7+xWkw6dI3R4njvDhYHVo8p066xe5zbcZ7dY9OqTjaPJ9c2M3n0bVnFGMAaxWWTkpqTWZZa
 pG+XwJVxqu8La8Ec4YovnUuZGhhn8nUxcnJICJhI3D/wiaWLkYtDSGA3o8TRrU2sEAlJibnb
 vkHZwhIr/z1nhyjqYJJY+GEVG0iCTUBL4t7LWywgtghQw++u08wgNrNAmsTXlsdgNcIC9hJL
 v+5lArFZBFQljs79BWRzcPAK2Eg8faoPMV9eYvGO5WCtvAKCEidnPmGBGCMv0bx1NvMERr5Z
 SFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIDkctjR2M9+b/0zvEyMTB
 eIhRgoNZSYT33qGfaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8sSc1OTS1ILYLJ
 MnFwSjUwve1yn2e90tX2h0eEbKZyr6hGLGN3uu3anhN1W3g1nr2b8TQyb8Hcl0vEH3l/aFzj
 fCVjiuoK7uas/SrTalTfSPE3buzcfLNsrczEi9zi9f8TCkJ4PCtMnCfyHVDr2H1+W49VbYbK
 nI8XJt3i0r7HW1ptLbtGN0R7+vnAoNrWygA3g9fnHnyZnS79q3n/rk1HZYuiLS8rnhSUvXZs
 4YlDEd9mOr9SPplU8/H+85jtn9+9clxwZnPlf2cP5/kZH37xS272/fjALdNN9Yr3ohulWXwX
 +B+u232KzTg27gHP0R+dik9PvZ1b8vloCf/sskwr3zmv+Z9lf3xUVvz+VdPGeRd2L+Sq7pp7
 4RLP7Q8dfkosxRmJhlrMRcWJAONIvNG2AgAA
X-CMS-MailID: 20241001065838epcas5p158f96030a744df180b1b3818287c2a84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241001065838epcas5p158f96030a744df180b1b3818287c2a84
References: <CGME20241001065838epcas5p158f96030a744df180b1b3818287c2a84@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=ayush.m55@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.144, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adding support for new 32 bit NPDGL and NPDAL fields to address the
needs of larger granularities.

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
---
 v1 -> v2: Added macros for NSFEAT in /include/block/nvme.h as suggested
by Klaus.

 hw/nvme/ns.c         |  5 ++++-
 include/block/nvme.h | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..7f51b6eec4 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -30,6 +30,7 @@
 void nvme_ns_init_format(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
@@ -55,6 +56,8 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+    id_ns_nvm->npdal = npdg;
+    id_ns_nvm->npdgl = npdg;
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
@@ -72,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->id_ns.dlfeat = 0x1;
 
     /* support DULBE and I/O optimization fields */
-    id_ns->nsfeat |= (0x4 | 0x10);
+    id_ns->nsfeat |= (NVME_DEALLOCATED_ERROR | NVME_OPTIONAL_WRITE_PERF);
 
     if (ns->params.shared) {
         id_ns->nmic |= NVME_NMIC_NS_SHARED;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5298bc4a28..7a84664bf2 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1413,7 +1413,12 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint8_t     pic;
     uint8_t     rsvd9[3];
     uint32_t    elbaf[NVME_MAX_NLBAF];
-    uint8_t     rsvd268[3828];
+    uint32_t    npdgl;
+    uint32_t    nprg;
+    uint32_t    npra;
+    uint32_t    nors;
+    uint32_t    npdal;
+    uint8_t     rsvd288[3808];
 } NvmeIdNsNvm;
 
 typedef struct QEMU_PACKED NvmeIdNsDescr {
@@ -1536,6 +1541,16 @@ typedef union NvmeDifTuple {
     } g64;
 } NvmeDifTuple;
 
+enum {
+    NVME_THIN_PROVISIONING          = 1 << 0,
+    NVME_NS_SUPP_ATOMIC_BOUND_POW   = 1 << 1,
+    NVME_DEALLOCATED_ERROR          = 1 << 2,
+    NVME_UID_REUSE                  = 1 << 3,
+    NVME_OPTIONAL_WRITE_PERF        = 3 << 4,
+    NVME_MULTIPLE_ATOMICITY_MODE    = 1 << 6,
+    NVME_OPTIONAL_READ_PERF         = 1 << 7,
+};
+
 enum NvmeZoneAttr {
     NVME_ZA_FINISHED_BY_CTLR         = 1 << 0,
     NVME_ZA_FINISH_RECOMMENDED       = 1 << 1,
-- 
2.43.0


