Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B29DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIou-00079X-HA; Wed, 29 May 2024 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIop-00077I-Un
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIoj-0008Ih-2Y
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:14 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240529125357epoutp031e2060cb9ce68cab7233783aaaeb9ee8~T9su9r3kl3112731127epoutp03a
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:53:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240529125357epoutp031e2060cb9ce68cab7233783aaaeb9ee8~T9su9r3kl3112731127epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716987237;
 bh=UFoxEuujungGm/NwuRDf69SSGdr7RSQ/cQSqpF+TqTg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=e4BM6F900DJiaMLbB4ZqUULJgu+GNfjdzEY8FBaVDBk/1qNpEUWxsz8BmlkxigAsV
 AjbKzGn3I7VtJBpJaIEipPTVbjZVRqKVf2oZhCPIG7pMI7oJRmCFcuYglVYqlJKQu0
 ZVziSK5M20tA5NoOjXkiQSlq1XPiFdwZwCEhFmAg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240529125357epcas2p2e32dbdd85772809d9a3027d2f60bc676~T9suvuw-Z0038900389epcas2p2R;
 Wed, 29 May 2024 12:53:57 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.102]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Vq8TK29qCz4x9Ps; Wed, 29 May
 2024 12:53:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0B.D5.18956.56527566; Wed, 29 May 2024 21:53:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epcas2p44725c6fa708097d0394eba22abafdc2b~T9st837wu0604606046epcas2p41;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240529125356epsmtrp297e1291a8379ffc502786ab911bf7b02~T9st8BxvG1584215842epsmtrp2k;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
X-AuditID: b6c32a4d-247ff70000004a0c-56-66572565f682
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D8.3A.18846.46527566; Wed, 29 May 2024 21:53:56 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epsmtip209ec74d69d2e54c7a8c6fc7a5954e23b~T9stxZNBX1461114611epsmtip2p;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, minwoo.im@samsung.com,
 gost.dev@samsung.com
Subject: [PATCH v4 0/4] hw/nvme: FDP and SR-IOV enhancements
Date: Wed, 29 May 2024 21:42:30 +0900
Message-Id: <20240529124234.1430707-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQjdVNTzN4M4sfosTU8Isbh7YyWSx
 /+A3VotJh64xWjw7fYDZYta7djaL4707WBzYPaZMu8bucW7HeXaPTas62TyeXNvM5NG3ZRVj
 AGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0BlK
 CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DC
 hOyM+T3bGAvO8Fe874ppYJzM08XIwSEhYCIx/S5rFyMXh5DAHkaJpqmfWCCcT4wSf+7fY4Vz
 vv/YBORwgnV8mv+IGSKxk1Fi06nTTBDOb0aJt7NPsoFUsQmoSzRMfcUCYosI5Ej0r/zOBGIz
 C8RLPF/xgx3EFhawkdh07xwziM0ioCpx+8kkMJsXKL7q4z0WiG3yEvsPnoWKC0qcnPmEBWKO
 vETz1tlgV0gI7GOXmHi0lx2iwUXi9exJTBC2sMSr41ug4lISn9/tZYOwyyV+vpnECGFXSByc
 dZsNEhj2Eteep4CYzAKaEut36UNElSWO3ILayifRcfgvO0SYV6KjTQhihrLEx0OHmCFsSYnl
 l15D7fGQeHfyOlirkECsxOXfSxknMMrPQvLLLCS/zELYu4CReRWjVGpBcW56arJRgaFuXmo5
 PFaT83M3MYKTopbvDsbX6//qHWJk4mA8xCjBwawkwntmUmiaEG9KYmVValF+fFFpTmrxIUZT
 YAhPZJYSTc4HpuW8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY
 hPdOWth1dOZ5GTOVrEfZdqLaXmtsHfK2y1/qvDVdTFMnOuRS0cslq42Sfp7YlvryaNjTgiPz
 voSrfIu3jkqt5JmycR/vwbJutTYHXqeddw7efZH8MeN1sqzxg2q1+plGS8NMHxx2ZqrYc9vB
 PecEv8vSvaYqFQ/bc9V3TLFbESu97LmEoLGEkeFdhyRFlhLBj2EOvH41S3d93R66M80ybZMf
 i0TCsg/JvN8se3buPhi7MVPhK1/h2Vf1fYwCh2Y8TNP5EGzSs4GhK4F7V/2SoysKDt9we54s
 2HpoqfmtaOPw/fPZJXbFvVu585bzk4dHf63Ra9GWbfn1T8e1wtPo/ezY6796D036V1U3Kd5L
 iaU4I9FQi7moOBEAdWsoMRMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvG6KaniawdIWLYsTU8Isbh7YyWSx
 /+A3VotJh64xWjw7fYDZYta7djaL4707WBzYPaZMu8bucW7HeXaPTas62TyeXNvM5NG3ZRVj
 AGsUl01Kak5mWWqRvl0CV8b8nm2MBWf4K953xTQwTubpYuTkkBAwkfg0/xEziC0ksJ1RYn2v
 KkRcUmLf6ZusELawxP2WI0A2F1DNT0aJ2Y+7WEASbALqEg1TX4HZIgJ5EtdeLgEbxCyQLHF8
 2QywuLCAjcSme+fA4iwCqhK3n0wCs3mB4qs+3mOBWCAvsf/gWai4oMTJmU9YIObISzRvnc08
 gZFvFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCQ1MraAfjsvV/9Q4xMnEw
 HmKU4GBWEuE9Myk0TYg3JbGyKrUoP76oNCe1+BCjNAeLkjivck5nipBAemJJanZqakFqEUyW
 iYNTqoFphcz9xQkzn6QoK1c17Xp+9UpNS1j01VypO+xr92beTMlZefPq6+82mhuk3hzNVIvR
 bL36cv6Hb2//PmGcqvGtgoPZyj5rZ0h+wArJNQczLzw+J5Vo9HGS/MxM00C1VxEPj6smi2h+
 b9C7JH9RxvXJR/V8pxiuQ0xm/eVOqws4DaYXzLezmrAheFaniFVyZCBrzvzAtEnci/cpd33v
 fL9aSXFFd9tyljvucfoTvs3IEmyfJXemLkFW6vb35y/vXWmbGvHNasns246yjC8C5qllFL/X
 KxA2aDptZGL5e7PbpYuTjGapCE6fbpCvI9t5VKVt3bbo8gCTwiqT3nqXHamqAa/X5BglPQr/
 yv5opZsSS3FGoqEWc1FxIgAJrmPvvAIAAA==
X-CMS-MailID: 20240529125356epcas2p44725c6fa708097d0394eba22abafdc2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240529125356epcas2p44725c6fa708097d0394eba22abafdc2b
References: <CGME20240529125356epcas2p44725c6fa708097d0394eba22abafdc2b@epcas2p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

Hello,

This is v4 patchset to increase number of virtual functions for NVMe SR-IOV.
Please consider the following change notes per version.

This patchset has been tested with the following simple script more than
127 VFs.

	-device nvme-subsys,id=subsys0 \
	-device ioh3420,id=rp2,multifunction=on,chassis=12 \
	-device nvme,serial=foo,id=nvme0,bus=rp2,subsys=subsys0,mdts=9,msix_qsize=130,max_ioqpairs=260,sriov_max_vfs=129,sriov_vq_flexible=258,sriov_vi_flexible=129 \

	$ cat nvme-enable-vfs.sh
	#!/bin/bash

	nr_vfs=129

	for (( i=1; i<=$nr_vfs; i++ ))
	do
		nvme virt-mgmt /dev/nvme0 -c $i -r 0 -a 8 -n 2
		nvme virt-mgmt /dev/nvme0 -c $i -r 1 -a 8 -n 1
	done

	bdf="0000:01:00.0"
	sysfs="/sys/bus/pci/devices/$bdf"
	nvme="/sys/bus/pci/drivers/nvme"

	echo 0 > $sysfs/sriov_drivers_autoprobe
	echo $nr_vfs > $sysfs/sriov_numvfs

	for (( i=1; i<=$nr_vfs; i++ ))
	do
		nvme virt-mgmt /dev/nvme0 -c $i -a 9

		echo "nvme" > $sysfs/virtfn$(($i-1))/driver_override
		bdf="$(basename $(readlink $sysfs/virtfn$(($i-1))))"
		echo $bdf > $nvme/bind
	done

Thanks,

v4:
 - Rebased on the latest master.
 - Update n->params.sriov_max_vfs to uint16_t as per spec.

v3:
 - Replace [3/4] patch with one allocating a dyanmic array of secondary
   controller list rather than a static array with a fixed size of
   maximum number of VF to support (Suggested by Klaus).
v2:                                                     
 - Added [2/4] commit to fix crash due to entry overflow

Minwoo Im (4):
  hw/nvme: add Identify Endurance Group List
  hw/nvme: separate identify data for sec. ctrl list
  hw/nvme: Allocate sec-ctrl-list as a dynamic array
  hw/nvme: Expand VI/VQ resource to uint32

 hw/nvme/ctrl.c       | 59 +++++++++++++++++++++++++++-----------------
 hw/nvme/nvme.h       | 19 +++++++-------
 hw/nvme/subsys.c     | 10 +++++---
 include/block/nvme.h |  1 +
 4 files changed, 54 insertions(+), 35 deletions(-)

-- 
2.34.1


