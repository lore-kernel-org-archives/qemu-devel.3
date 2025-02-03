Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2316FC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCvX-0001Xu-7n; Tue, 04 Feb 2025 02:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBN-0001An-Fv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:14 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBJ-0002Bi-Ir
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:12 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250204061257epoutp020ecec23251e536293231891d476a34f9~g7JRD3Ttk2255122551epoutp02z
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2025 06:12:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250204061257epoutp020ecec23251e536293231891d476a34f9~g7JRD3Ttk2255122551epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1738649577;
 bh=4aXhgDy+GveCJKRwZHUcVcqwoTnwr5AvBjR5R5ffQL0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=mdoXahCjRxTqkj3XWyzVbDNNcAYXxnN57pMpt4i4XnpAApJ5Kn4S9ARdj4IIDTZWn
 JV3w2rsvfsnCy3SKGlbRQGgybyEc9d5lKbpX/hZloGYnn8dastT3RPGy0C8HT+o1r7
 t6rvU3J2cva85vX5oyPjZ0omuoOYgnAJVDiy44YU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20250204061257epcas5p17ef8d137eb2cdfb48a19ad0b7d1f64ff~g7JQmju9p2596925969epcas5p1r;
 Tue,  4 Feb 2025 06:12:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YnChl3nWpz4x9Px; Tue,  4 Feb
 2025 06:12:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4E.DA.20052.7EFA1A76; Tue,  4 Feb 2025 15:12:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc~gnVZGWNKt0221502215epcas5p3K;
 Mon,  3 Feb 2025 06:00:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250203060050epsmtrp1aca86f738022d075d5c44b31a5c43bb9~gnVZFhsVj2494724947epsmtrp1q;
 Mon,  3 Feb 2025 06:00:50 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-d9-67a1afe71b35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.DE.23488.19B50A76; Mon,  3 Feb 2025 15:00:49 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250203060048epsmtip22533c88914fa3b474827be87d90e40f2~gnVXprEBf2702127021epsmtip20;
 Mon,  3 Feb 2025 06:00:48 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 0/3] CXL CCI Log Commands implementation
Date: Mon,  3 Feb 2025 11:29:47 +0530
Message-Id: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU/f5+oXpBlNmiFtMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
 1VbJxSdA1y0zB+gmJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
 ul5eaomVoYGBkSlQYUJ2xqot85gKjrFXfG3kaGBcydbFyMkhIWAisa3vFCuILSSwm1Gi5YRD
 FyMXkP2JUeLAsTfMEIlvjBInLqbANLT/W8UEUbSXUeJh+wZGCKeBSWLh1wNgHWwCOhLnb88F
 WyEiICnxu+s0M0gRs8AbRokHVxcAORwcwgIWEjN/2oDUsAioStzsmA1WzytgL7GmsY0RYpu8
 xP6DZ5kh4oISJ2c+YQGxmYHizVtng82UEHjELnHxwASoBheJ2c9mMEPYwhKvjm9hh7ClJF72
 t0HZ2RJ/5rdD/V8gsejnTKi4vUTrqX6w25gFNCXW79KHCMtKTD21jgliL59E7+8nTBBxXokd
 82BsNYn2HfOhxshIvPm1GGq8h0Tz5J/Q4I2VmP76JMsERvlZSN6ZheSdWQibFzAyr2KUTC0o
 zk1PLTYtMMxLLYdHa3J+7iZGcMLU8tzBePfBB71DjEwcjIcYJTiYlUR4T29fkC7Em5JYWZVa
 lB9fVJqTWnyI0RQYxhOZpUST84EpO68k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6Yklqdmpq
 QWoRTB8TB6dUA5NxZpWv6RWvKfOKZSMruz/YZu4Rm323uyJyJf+lIM3cNMn7RaVe0+evf31u
 8bGr/lE7Up//Uu2JKJBnbcpb7C14vya04oDsp6VMWYJ6xcsWGH95WLDRVM+ySjDfSDZjXS/3
 XCfT879qjM8cniS4fbHwPQ/BNd2KYTzi9ow5kY+Wrp/ssEn7fBj3/GPTc9kyp8y32LDaROTQ
 84oNDg81d62d+2r5Ysbc5VNkp8zY1Hcx41fj5F6dCTlF06bG9EXusqz3f663gKFj0nHtbdOn
 Pl7599FsebNdjMHTevObtmiyvXvzdWJXHXu2OvuvR3s3OT36db/rxOQ3Dx1mq0yx9dm65dSe
 nSe0dF6WtiUfnCGgxFKckWioxVxUnAgAwrzNPyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvO7E6AXpBl/uW1hMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugStj1ZZ5TAXH2Cu+NnI0MK5k62Lk5JAQMJFo
 /7eKqYuRi0NIYDejxJkljSwQCRmJizMfQ9nCEiv/PWeHKPrHKLHm4XZ2kASbgI7E+dtzwSaJ
 CEhK/O46zQxSxCzwjVFizq0XrF2MHBzCAhYSM3/agNSwCKhK3OyYDVbPK2AvsaaxjRFigbzE
 /oNnmSHighInZz4BW8wMFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YW
 l+al6yXn525iBIevlsYOxnffmvQPMTJxMB5ilOBgVhLh5Tg8J12INyWxsiq1KD++qDQntfgQ
 ozQHi5I470rDiHQhgfTEktTs1NSC1CKYLBMHp1QDk62p77Irot7a+Ve33zEKvDVnTfUcVkGP
 LQ135e59yrp/qfbpsisNrbcrPrzouem+zzRx72omf9tMVffNaU1sVv0SFybqvGUP2jQrOjUk
 9SDHT8N5j/58XBP0pT/f9tBTCbe/Ov1n7upa3fn95frl7259+m0b0/8Gnq2sSrjwasqiXfeS
 8k9oLTrhyBQpHW654f19BYf0D84Tj96brcbffueV7H5Ndpe+mZdDlOU2339Qd3bD3h8FXIJf
 TumWLBXd82rmKdXZ3mt3swaxeErKeZ80lhA6G960+43NLq1vh/ZpH1zAMkND4aHPsaSq+3zS
 K+xnrhXe8N2uY+dplUt7/r9drrI59ezDLoacei/JgmNKLMUZiYZazEXFiQAf8HE3zgIAAA==
X-CMS-MailID: 20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc
References: <CGME20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Feb 2025 02:00:11 -0500
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

CXL CCI log commands implmented as per CXL Specification 3.1  8.2.9.5
1) get_log_capabilities (Opcode 0402h)
2) clear_log (Opcode 0403h)
3) populate_log (Opcode 0404h)

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Arpit Kumar (3):
  hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
    (Opcode 0402h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
    0404h) as background operation

 hw/cxl/cxl-mailbox-utils.c   | 186 +++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h  |  33 +++++++
 include/hw/cxl/cxl_mailbox.h |   5 +
 3 files changed, 224 insertions(+)

-- 
2.34.1


