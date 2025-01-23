Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA3C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taxsd-0001UJ-65; Thu, 23 Jan 2025 09:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB8-0002QP-Aa
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:58 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB2-000543-Ux
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:58 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250123055443epoutp03a62f262584d6c744193be78f45d2b252~dPJ6wH9gp0655706557epoutp03c
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 05:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250123055443epoutp03a62f262584d6c744193be78f45d2b252~dPJ6wH9gp0655706557epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1737611683;
 bh=Shlxy2HSoAM/bmUI5fRJ9/7uU06xbow/BwqAGq/IZ4U=;
 h=From:To:Cc:Subject:Date:References:From;
 b=YjyFmNPqf5GSWwWCrl48vjl8aNG7YL3ssAy/srPtfOzai+xeCnMtixF38MXscJ20l
 zzHmEYHKvyu4jGfpkBxTMXEV0pNAIv6g8mlAmcenpz3piX4jI/bu8JP03mZwI1Zz+U
 lNowYgAAlb5XxgSB9tctlUMbFF2k3gpZfGDB/HWs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20250123055443epcas5p446df9cb0f7e7bcfe3abcb14b0a698e51~dPJ6WXO1F2996629966epcas5p4v;
 Thu, 23 Jan 2025 05:54:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YdqsD4489z4x9Q5; Thu, 23 Jan
 2025 05:54:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 79.6C.20052.D99D1976; Thu, 23 Jan 2025 14:54:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250123050911epcas5p1be43ec1084c4e4d6f56670cfb513c3e5~dOiKPv3Vn3166631666epcas5p1A;
 Thu, 23 Jan 2025 05:09:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250123050911epsmtrp1c788cfc67f6b3c7690655d77abe7ae57~dOiKOIE320313303133epsmtrp1V;
 Thu, 23 Jan 2025 05:09:11 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-50-6791d99d1fb3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FD.6F.18729.7FEC1976; Thu, 23 Jan 2025 14:09:11 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250123050910epsmtip12de03008d06d2dab5fd5a0c0ea92c9dc~dOiJL1bkX2181921819epsmtip1-;
 Thu, 23 Jan 2025 05:09:10 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: krish.reddy@samsung.com, vishak.g@samsung.com, a.manzanares@samsung.com,
 alok.rathore@samsung.com, s5.kumari@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH 0/2] CXL CCI Media Operations 
Date: Thu, 23 Jan 2025 10:39:01 +0530
Message-Id: <20250123050903.92336-1-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmpu7cmxPTDS6+N7OYfljR4svpPWwW
 CzcuY7I43ruDxWLNuc8sFidObme3OD9rDrsDu8eTa5uZPPq2rGIMYIrKtslITUxJLVJIzUvO
 T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qukUJaYUwoUCkgsLlbSt7Mp
 yi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5o6/nPUrCAraLjrUkD
 Yw9rFyMnh4SAicTthR1MXYxcHEICuxklTnzczA7hfGKUmPXmEzOE841RYuWjv+wwLa+PPgNr
 FxLYyyhx+rEcRFEDk8SHxoksIAk2AQOJB83HwRpEBCQlfnedZgaxmQXWMEpsWyIPYgsL6EnM
 fXoGrIZFQFXi5K6/QL0cHLwC1hJ/bzlA7JKX2H/wLFgrr4CgxMmZT1ggxshLNG+dDXachMA2
 dokVR95BHeci0f79ApQtLPHq+BYoW0riZX8blF0sce7iJ0YIu0biddcKZgjbXqL1VD8zyA3M
 ApoS63fpQ4RlJaaeWscEsZdPovf3EyaIOK/EjnkgNgeQrSKx9G0mzKYvz5qhpntITGz5zwIJ
 qliJU/cPM05glJ+F5JtZSL6ZhbB4ASPzKkbJ1ILi3PTUYtMCw7zUcnisJufnbmIEpz0tzx2M
 dx980DvEyMTBeIhRgoNZSYT3/5MJ6UK8KYmVValF+fFFpTmpxYcYTYEhPJFZSjQ5H5h480ri
 DU0sDUzMzMxMLI3NDJXEeZt3tqQLCaQnlqRmp6YWpBbB9DFxcEo1MG3KnJ5oMKPzvdqCWRcu
 xSkm1jcaSpyOv6+7N/ebvrUj5+LpMaUXlTlKrXyqD6+XeCM+xXSZupzY1yWSv/tjN0bzdumq
 qJgLBi++zSJ/ZFuzq6jBlOncZjwKzxuj5VZlsbPceVb4KTGZr7Y0hulSf3Dmaa17mSf4OPU+
 ldYLfl9uFDo399/bnbzPn/5STWTOsS14rl6Qzv5o38nZ7w9csljtknL68PLOWbw7vb8/rvzy
 P+VA9NXwFetqwhmz/9m0m+tcX388679ZSnprb+ilEpmshCvPrIO+RbY1xUy3CH5o27NVbd1R
 +bZvE7X3lYXzf5wqE6r8K9Fyx3ffmf/v/Mzw0cz5dE3LTos3olxZiaU4I9FQi7moOBEAYzWA
 WAQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnO73cxPTDeZcE7CYfljR4svpPWwW
 CzcuY7I43ruDxWLNuc8sFidObme3OD9rDrsDu8eTa5uZPPq2rGIMYIrisklJzcksSy3St0vg
 ymjr+c9SsICtouOtSQNjD2sXIyeHhICJxOujz8BsIYHdjBI/p4pBxKUkju38yQZhC0us/Pec
 vYuRC6jmH6PEmbeHwBJsAgYSD5qPs4PYIgKSEr+7TjOD2MwCmxglWvfpgdjCAnoSc5+eAath
 EVCVOLnrL0sXIwcHr4C1xN9bDhDz5SX2HzwL1sorIChxcuYTFogx8hLNW2czT2Dkm4UkNQtJ
 agEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAQ1NLcwbh91Qe9Q4xMHIyHGCU4
 mJVEeP8/mZAuxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1Oq
 gcn1wCZFXd2XcVPzcvzuvfgnock6vbU/uG91Q8rjLRriv+y5jj3WPje/5c/aS6fsKpL1Gh/N
 WunE8XxS5L+E2nsGnksDxWSXH2S41/kuobMpNbS9azK7q51W55xM51NZyXNyPea+LdXYx/zL
 vtX3WtBPlcsSC9nMPxwR00lTFuMJK1lkbbd0Y5ug49YFSt1OvTu63c+ytHL0CC5cennB0VMn
 7f90yud/s0v5rxjXtFyO2dHygGWCtCFvk2dyymeu++GBGbyXDzz/KN0auWMue17f9w9fS32P
 beJ4Y9PGlpsQ8e9L/736p+Kzjq2+8HnVgpo4ma8H4kxbtwVncDRFTtSwq1vu3uz+9n94bUe7
 EktxRqKhFnNRcSIAmE4p0bACAAA=
X-CMS-MailID: 20250123050911epcas5p1be43ec1084c4e4d6f56670cfb513c3e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050911epcas5p1be43ec1084c4e4d6f56670cfb513c3e5
References: <CGME20250123050911epcas5p1be43ec1084c4e4d6f56670cfb513c3e5@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=vinayak.kh@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jan 2025 09:08:18 -0500
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
3.1 8.2.9.9.5.3
1) General(00h) - Discovery (00h)
2) Sanitize(01h - Sanitize (00h)
                  Write zeros (01h)

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>

Vinayak Holikatti (2):
  hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery
    commands (8.2.9.9.5.3)
  hw/cxl/cxl-mailbox-utils: Add support for Media operations Sanitize
    and Write Zeros commands (8.2.9.9.5.3)

 hw/cxl/cxl-mailbox-utils.c  | 331 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |  11 ++
 2 files changed, 340 insertions(+), 2 deletions(-)

-- 
2.34.1


