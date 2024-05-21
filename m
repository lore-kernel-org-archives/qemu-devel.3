Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB77C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NU9-0007Zb-AW; Tue, 21 May 2024 07:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NU2-0007Xj-6X
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NTy-0003vb-JC
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:41 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240521111627epoutp04aa862b75adc8da206855fe6dcfa1b796~RfNT3L3RT2973829738epoutp040
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 11:16:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240521111627epoutp04aa862b75adc8da206855fe6dcfa1b796~RfNT3L3RT2973829738epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716290187;
 bh=uVMaVeIYh8ndztOjRlC2QPkO5J3sODX0iHTCTbsClDw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=dR07U7Fw/H8eJC9pP2rCNYup7Eruh+Npg5Q9CsWBARr0R9Jd0IEaWh3/PUBIws50z
 j4ItibgWulVEt1+FhV1jdLFgugueL1vUKXuEwYziFtrVrKyDkmHJlkdqqX9iHVwn7w
 qvCOKNzxhToKYsHgi6v0tR9/yvI+V3rvFlCZWP40=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240521111626epcas2p19a916bce994c75e8e69349387f53083f~RfNTmCKhD1779617796epcas2p1E;
 Tue, 21 May 2024 11:16:26 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VkBhV0nwXz4x9Q0; Tue, 21 May
 2024 11:16:26 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 A6.D2.09639.9828C466; Tue, 21 May 2024 20:16:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240521111625epcas2p24798db0caeed2faa2beb187fd7c81902~RfNSDlK3P0421204212epcas2p2O;
 Tue, 21 May 2024 11:16:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240521111625epsmtrp1df07dbe7dbf1fdb73c9603d651ac16da~RfNSCvYZS2776227762epsmtrp16;
 Tue, 21 May 2024 11:16:25 +0000 (GMT)
X-AuditID: b6c32a46-8ddfa700000025a7-a1-664c82896c85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7D.CF.08924.9828C466; Tue, 21 May 2024 20:16:25 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240521111624epsmtip16ead9ccdadaf5a481b066f9b6e0a21ad~RfNR261dl0066300663epsmtip1g;
 Tue, 21 May 2024 11:16:24 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 0/2] hw/ufs: Add support MCQ
Date: Tue, 21 May 2024 20:05:20 +0900
Message-Id: <20240521110520.258749-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmuW5Xk0+awd0tjBY3D+xksnhwt5/R
 4v7Wa4wWSy6mWjw7fYDZYta7djaL4707WBzYPZ5c28zk8X7fVTaPvi2rGAOYo7JtMlITU1KL
 FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMz6dWsdUcJm1
 ouUtewPjdpYuRk4OCQETiTOt21m7GLk4hAR2MEpsOHeeESQhJPCJUWLNAk0I+xujxMz7+l2M
 HGANRxfZQdTvZZQ486yBEcL5zSjR+/YWO0gDm4C6RMPUV2AbRATSJS6/W8kK0swskC3x8IYe
 SFhYQEei+d9mNhCbRUBVYsWWFrBWXgFriTe3FzJDHCcvsf/gWWaIuKDEyZlPwEYyA8Wbt85m
 BtkrIbCPXWLVkVNsEA0uElv/L2KCsIUlXh3fwg5hS0m87G+Dssslfr6ZxAhhV0gcnHWbDeIx
 e4lrz1MgztSUWL8L6l1liSO3oLbySXQc/ssOEeaV6GgTgpihLPHx0CGogyUlll96DXWLh8SR
 kzeggRkrsXr+aZYJjPKzkPwyC8kvsxD2LmBkXsUollpQnJueWmxUYASPzuT83E2M4JSn5baD
 ccrbD3qHGJk4GA8xSnAwK4nwbtrimSbEm5JYWZValB9fVJqTWnyI0RQYuhOZpUST84FJN68k
 3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBiafFCUvSxOxar7e/Tna
 z42y9Drl7IX/3qpbtnJJ15nIvdFvDtrPTSzPK/7A+ZOpYt7eoPM/JBZHlyxeesOHS2bSHau1
 f1U2bbR/o/q70L2xvpCt9R9r7JX/x937XSrXnP7r/djwmKnRbP9HO03CUpdf8Zbw35t85Wh9
 S5u5gHrsE7WFR242pC2wWRilx6YvLn1jud7lKQmPVf5bsd1bmXG0Ys17kx126/79ZRRf4HCf
 KT8h3jVcXecIQ+CpZ88i/e516888GnLywfw5p1o4fi0r3SjDZf1qzRxZ13y2JKWMXT18s6dG
 TPzssHZ/4LrXse3p7SG3555+Y/XA8mIo56uth1QNX8SInjm7L1K1xlCJpTgj0VCLuag4EQAa
 7ptpAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnG5nk0+aQc8zNoubB3YyWTy4289o
 cX/rNUaLJRdTLZ6dPsBsMetdO5vF8d4dLA7sHk+ubWbyeL/vKptH35ZVjAHMUVw2Kak5mWWp
 Rfp2CVwZn06tYyq4zFrR8pa9gXE7SxcjB4eEgInE0UV2XYxcHEICuxkl/h84xdbFyAkUl5TY
 d/omK4QtLHG/5QgrRNFPRomPez+AFbEJqEs0TH3FAmKLCGRKLHzVwQ5iMwvkS3R1LGACsYUF
 dCSa/20Gq2cRUJVYsaUFrIZXwFrize2FzBAL5CX2HzzLDBEXlDg58wkLxBx5ieats5knMPLN
 QpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcDhqae5g3L7qg94hRiYO
 xkOMEhzMSiK8m7Z4pgnxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgST
 ZeLglGpg4lc4kX1p0pMv29L1Fzutnm7Oc6Vr38vSfSeEPvtUzLp7p6H1Y1X8+d9V2RMOT/xc
 WBXDZJt0Zf57JYGKUrE1f3wvn/DmYwl0ftuT88xkxfM0dQ+3Q2Ja5216lb8VnzBy3LRKlvPu
 Vb8H23jj7Cr993qZdDfL2N170NuhN/2h1kadApFlbw+lJbytmWoX92ZlugOHis6/W8f9wrav
 L/prsXGhgOUB3pSpPF+aIhuYZN+pffL7UHnu8qnHzJtmSnXkS19YlxDyruAX2+2LBjy5a05W
 cZsFN91IeZ+qrmKX81cv17G1qpmNt6br0vStjtFP7kbYSz668v5JygQX3tUfM93S6w5/jTy8
 LFFWcV+SEktxRqKhFnNRcSIAcVhcJrYCAAA=
X-CMS-MailID: 20240521111625epcas2p24798db0caeed2faa2beb187fd7c81902
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521111625epcas2p24798db0caeed2faa2beb187fd7c81902
References: <CGME20240521111625epcas2p24798db0caeed2faa2beb187fd7c81902@epcas2p2.samsung.com>
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

UFSHCI 4.0 spec introduced MCQ(Multi-Circular Queue) to support multiple
command queues for UFS controller.  To test ufs-mcq path of kernel, MCQ
emulated device would be a good choice to go with.

The first patch added newly introduced fields in UFSHCI 4.0 to support
MCQ.  The other one made the actual changes for MCQ.

Please review.

Thanks,

Minwoo Im (2):
  hw/ufs: Update MCQ-related fields to block/ufs.h
  hw/ufs: Add support MCQ of UFSHCI 4.0

 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 474 ++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++-
 include/block/ufs.h | 131 +++++++++++-
 4 files changed, 698 insertions(+), 22 deletions(-)

-- 
2.34.1


