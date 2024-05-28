Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DFAC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmnQ-0008Od-Vb; Mon, 27 May 2024 22:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmnP-0008NX-Kw
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:42:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmnJ-0003TF-D0
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:42:39 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240528024227epoutp033ca1d25f85c3ff2510f8a9e678950bb6~ThtiE52Y_1271512715epoutp03E
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 02:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240528024227epoutp033ca1d25f85c3ff2510f8a9e678950bb6~ThtiE52Y_1271512715epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716864147;
 bh=bSH95VCh3yumd0gQefwMa0/NB4YzNOZf1D+4v1OspGc=;
 h=From:To:Cc:Subject:Date:References:From;
 b=RWVGieqrGBXuA2s4QtJyT75jm8WK7x5xbJL8DGLpMwebXTfXUaXgGiQHjFYQjamv+
 XWm4/PZBu9BurNPvRr+gaL81aRROpAvsyxNny07ywwYbKgJ3/eb/iBBTirJzKFc1oo
 ktz25O8EI9klnh7h4mgpU74Ems4i1FHUui7kYbxk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240528024227epcas2p168f81485b91fbceee09047bbc42c6d58~ThthzINq00179601796epcas2p1X;
 Tue, 28 May 2024 02:42:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VpGyB2G3rz4x9QD; Tue, 28 May
 2024 02:42:26 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 BA.C4.09848.29445566; Tue, 28 May 2024 11:42:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240528024226epcas2p1667c281607ce0496703c688b2559a8f1~Thtgu7jtF2380623806epcas2p1o;
 Tue, 28 May 2024 02:42:26 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240528024226epsmtrp147f95741624a89828496e46b9d32af53~ThtguWLIW1332413324epsmtrp1j;
 Tue, 28 May 2024 02:42:26 +0000 (GMT)
X-AuditID: b6c32a45-1c7ff70000002678-2c-66554492c418
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.AD.18846.19445566; Tue, 28 May 2024 11:42:25 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240528024225epsmtip2bbaaad3a6a1ddd9e0e2b52dce876a59a~Thtgg4Q4D2467724677epsmtip2c;
 Tue, 28 May 2024 02:42:25 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v2 0/2] hw/ufs: Add support MCQ
Date: Tue, 28 May 2024 11:31:04 +0900
Message-Id: <20240528023106.856777-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmue4kl9A0gxm3+SxuHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR2XbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0y5tputYA1H
 xdJZP5gaGE+xdTFyckgImEhsbtzI0sXIxSEksINRYu+PX6wQzidGiTlHpiI439feZYRpef5h
 FhtEYiejxPGXjUwQzm+QllnMIFVsAuoSDVNfsYDYIgLpEpffrQQaxcHBLJAt8fCGHkhYWEBf
 4syvBrASFgFViRkLrjODlPAKWEvsfmcIsUteYv/Bs2ATeQUEJU7OfAJWzgwUb946mxmiZhe7
 xNX3GiCtEgIuEruOVUOEhSVeHd/CDmFLSbzsb4OyyyV+vpkE9UqFxMFZt9kgWu0lrj1PgbhR
 U2L9Ln2IqLLEkVtQO/kkOg7/ZYcI80p0tAlBzFCW+HjoENQpkhLLL72GhqyHxPqpr1lBbCGB
 WIlbF2ezT2CUn4Xkk1lIPpmFsHcBI/MqRrHUguLc9NRiowJDeHwm5+duYgQnPS3XHYyT337Q
 O8TIxMF4iFGCg1lJhFdkXmCaEG9KYmVValF+fFFpTmrxIUZTYNBOZJYSTc4Hpt28knhDE0sD
 EzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqYzjfJLHjIeDd8g/67mDbZC2cM
 t08omcaQ8/x+8db/RirLFhpH1tTe9j391FfoXbj537KA2ANLTy5/31H26H6O/Got3mVF9u9k
 Hx9p3HYha/71pNnPU5/pCxQu4/dOXvxGm+HJ+8zybazfX9VOWhb3RTjxY4TcIha9tRdXfY6q
 KfRinKcU8s/givul/OPLWdRjRZ4aXLu/Y9XMjKwH207Mmeld4cvU5a+27o21UkPThII/GfVv
 7UWvJHHFbBGc53tEIuTQb+vpSukGOopHJpou9L9koNqonvhIennYNpVzISwT7q2qbZsyceuZ
 +C9sV6LMvKJjfD+miWj/rbZaM/vQ5ZlTTB42Wp5TS1iRZSPNrsRSnJFoqMVcVJwIAP1FOo4D
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSvO5El9A0g91vzC1uHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR3HZpKTmZJal
 FunbJXBlTLm2m61gDUfF0lk/mBoYT7F1MXJySAiYSDz/MAvI5uIQEtjOKHH/6XR2iISkxL7T
 N1khbGGJ+y1HWCGKfjJKrL+4BizBJqAu0TD1FQuILSKQKbHwVQdYM7NAvkRXxwImEFtYQF/i
 zK8GsBoWAVWJGQuuM3cxcnDwClhL7H5nCDFfXmL/wbPMIDavgKDEyZlPWCDGyEs0b53NPIGR
 bxaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxggNRK2gH47L1f/UOMTJxMB5i
 lOBgVhLhFZkXmCbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TB
 KdXAJDxl3pkTFqteJb/rXsrV1rgtYK9GT2l0IIvuoyUua56yHp8p/G5uyiE7hqIw9S0397RM
 qsuOltltptym99Xz2eX5l73c96X/mfbXdZf2dtd7O74f4vm7ws5Qv09hpoH+4QQ7j2d39ZR+
 aelxRa2zf1fHo234872I2TyNef9M1i2yeP20J+Ivj96v87vl4jV6BZiehe54k+ydElVR6rS5
 OsjQq2ZKpVGcl75XXfFLoZvOf5P2RrLUx59tu7JPySPNdspnz9CZOnOiOA+5VbhqJ9rUXnv8
 bZl2ueZLfv+F6dqFybOr3kVqLvy/uaLlTLvRthMdkxnrN2xfKP937sS3Vxj1Ns5V4Y82KDK6
 bb9QiaU4I9FQi7moOBEAYe4c07MCAAA=
X-CMS-MailID: 20240528024226epcas2p1667c281607ce0496703c688b2559a8f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528024226epcas2p1667c281607ce0496703c688b2559a8f1
References: <CGME20240528024226epcas2p1667c281607ce0496703c688b2559a8f1@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2:
  It fixed printing error event trace even in normal shutdown cases for
SQ/CQ tear-down by checking whether each SQ/CQ is valid or not.  The
default value of mcq-maxq was updated to 2 from 1 to prevent the kernel
from allocating a single queue as a poll_queue by default and to ensure
that io_queues exist to handle device commands.

Please review.

Thanks,

Minwoo Im (2):
  hw/ufs: Update MCQ-related fields to block/ufs.h
  hw/ufs: Add support MCQ of UFSHCI 4.0

 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 478 ++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++-
 include/block/ufs.h | 131 +++++++++++-
 4 files changed, 702 insertions(+), 22 deletions(-)

-- 
2.34.1


