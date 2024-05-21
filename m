Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87510C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NUH-0007hE-6g; Tue, 21 May 2024 07:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NUE-0007gH-34
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NUA-0003wS-1g
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:53 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240521111646epoutp0394e6d3d0536bc316cfbc4da45d442a8a~RfNljnUMK2197621976epoutp03Y
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 11:16:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240521111646epoutp0394e6d3d0536bc316cfbc4da45d442a8a~RfNljnUMK2197621976epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716290206;
 bh=uVMaVeIYh8ndztOjRlC2QPkO5J3sODX0iHTCTbsClDw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=LutsdGDxCU98vovLQwjTOL55AyXAJBIceZrmaDNk0A0gcArbakV5NyabQXBrIQWE9
 p+VPrJZyLF+HPq/v6vjPOSCA76QdZqWm+Hw3z0Ez75Sg0evBbf8Q5SgVJJUydl6uLu
 zOiFfoHxAHJor/6zHpso4ns451HVQuGAZWDELrDs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240521111644epcas2p1fdc8a857423d290deac3d50ac2aa4ec9~RfNkeQbM_0933409334epcas2p1Z;
 Tue, 21 May 2024 11:16:44 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VkBhr1hqqz4x9Px; Tue, 21 May
 2024 11:16:44 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 9E.D2.09639.C928C466; Tue, 21 May 2024 20:16:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epcas2p119387edb838377d98d269e62d994cc3a~RfNjR14L80933409334epcas2p1X;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240521111643epsmtrp28d4b25534cff1626c2aff6b52f2395f2~RfNjRMOBL2930529305epsmtrp2P;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
X-AuditID: b6c32a46-8ddfa700000025a7-c5-664c829c8de8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.B4.09238.B928C466; Tue, 21 May 2024 20:16:43 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epsmtip1311da565348b66f81abbf8a6bcd4974e~RfNjEYRsv0093400934epsmtip1l;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 0/2] hw/ufs: Add support MCQ
Date: Tue, 21 May 2024 20:05:42 +0900
Message-Id: <20240521110544.258772-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmme6cJp80g9ZjXBY3D+xksnhwt5/R
 4v7Wa4wWSy6mWjw7fYDZYta7djaL4707WBzYPZ5c28zk8X7fVTaPvi2rGAOYo7JtMlITU1KL
 FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMz6dWsdUcJm1
 ouUtewPjdpYuRk4OCQETiX1bPzN2MXJxCAnsYJT4c/AbK4TziVGi58gcJgjnG6PEiacn4FpW
 P3vCApHYyyixpOs/VP9vRoneti+MIFVsAuoSDVNfgXWICKRLXH63EmguBwezQLbEwxt6IGFh
 AR2J5n+b2UBsFgFViWV/FrCD2LwC1hLLvmxlglgmL7H/4FlmiLigxMmZT8BGMgPFm7fOZgbZ
 KyGwi13i17c9zBANLhLrD+2HsoUlXh3fwg5hS0l8freXDcIul/j5ZhIjhF0hcXDWbTaQ2yQE
 7CWuPU+BOFNTYv0ufYiossSRW1Bb+SQ6Dv9lhwjzSnS0CUHMUJb4eOgQ1E5JieWXXkPt8ZBo
 nXIYbI+QQKzEqnlLGScwys9C8sssJL/MQti7gJF5FaNYakFxbnpqsVGBETxGk/NzNzGCE5+W
 2w7GKW8/6B1iZOJgPMQowcGsJMK7aYtnmhBvSmJlVWpRfnxRaU5q8SFGU2DoTmSWEk3OB6be
 vJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamM6fK37wR2eXJ9eU
 XZ8+mq9Nl4xKaQiZMal11pcNfzPUbxuyCHmX6/xPvTn35R63b9P97fcXzr7gHLRiiXeN13Ku
 tSIOU/55TC59f9n3fUz0LoGeioC+G5dNo90CvhzZK53Lf+S5zqFfx3d4d6f+Xla6mkH97P76
 owE39+UwBQVo8k1jeKesl5bAqWn+cHJ4kuv2i/ccTkf/1Mr1ubGxX+uLSO/uC6JrmIRtFxYt
 7WQ6svry4a5X5V5Oy/uvlTqsaHH/cSLhs0LlNXG5hvj9x5/9X5KremID/+fnk70Covt/3xII
 3PBySu2EL+cPh8st3Jp78IZau6uCkZbevZMfY79plzGmecwSCGO6vfvrpktKLMUZiYZazEXF
 iQAr/l0/BQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO7sJp80g0c/lC1uHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR3HZpKTmZJal
 FunbJXBlfDq1jqngMmtFy1v2BsbtLF2MnBwSAiYSq589AbOFBHYzSvz5UQQRl5TYd/omK4Qt
 LHG/5QiQzQVU85NR4sHqWcwgCTYBdYmGqa/AmkUEMiUWvupgB7GZBfIlujoWMIHYwgI6Es3/
 NrOB2CwCqhLL/iwAq+EVsJZY9mUrE8QCeYn9B88yQ8QFJU7OhDiIGSjevHU28wRGvllIUrOQ
 pBYwMq1ilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAgORy2NHYz35v/TO8TIxMF4iFGC
 g1lJhHfTFs80Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODil
 GpjKFmS5FmnMY5jee/JPWqdr4PLQx8rx+6N3+86S/HugzYFzFbff8Tf/N9pyFD8XVmd6+THi
 Yv5vOfcvfC9D+n/7HKhRnx3+V3Tl0le9NfENvsW7Zl332u/2fLm+lczZN1OZwk0YPqx16Hny
 8OokK7Vy2/Pbd3nGb/oiJ1UhVCU/wyP987/92wsE/vc4b7hQZ+Ep1830ZbU0j+6RwHuHxTce
 deTfmNxx4b6m6Lr40yadCcxz57bcNazR+rTz1hZTxy7LN6uerkrtsXlhW7rN0qRffovinkPl
 wWeuTFCtbJabYpy9NcK9+f+t2GOnnt/+cdbGYeEKXu0YKZ+otWaS1uldU7859aju573tFlRU
 dF6JpTgj0VCLuag4EQBHlmQrtgIAAA==
X-CMS-MailID: 20240521111643epcas2p119387edb838377d98d269e62d994cc3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521111643epcas2p119387edb838377d98d269e62d994cc3a
References: <CGME20240521111643epcas2p119387edb838377d98d269e62d994cc3a@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


