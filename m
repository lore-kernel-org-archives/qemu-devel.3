Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B3AC19F4E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 07:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0G0T-00070i-3V; Fri, 26 Apr 2024 03:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0G0R-00070A-6l; Fri, 26 Apr 2024 03:28:27 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0G0L-0008FB-FJ; Fri, 26 Apr 2024 03:28:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnWAmJVytmQ7X1CQ--.42S2;
 Fri, 26 Apr 2024 15:28:09 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXaEyDVytmqGUAAA--.521S3;
 Fri, 26 Apr 2024 15:28:03 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org,
 Xiong Yining <xiongyining1480@phytium.com.cn>
Subject: [PATCH v3 0/1] ARM Sbsa-ref: Enable CPU cluster topology
Date: Fri, 26 Apr 2024 07:27:03 +0000
Message-Id: <20240426072704.325883-1-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXaEyDVytmqGUAAA--.521S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAGBmYpXuMFaAAEsa
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Wr4kAr45ZF1rZFWUWryxuFg_yoW3Zrc_Ar
 n7Za95Krs7AF4vkay0y3WfCry8ArWYgr15tFn7KF4jqw1fCF4UJrsFk3s3Ar1rWr18W348
 AF48A3yfA34agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Enable CPU cluster support on SbsaQemu platform, so that users can
specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And this
topology can be passed to the firmware through DT cpu-map.

Changes in v3:
- squash the two patches together into one
- add the DTB information in docs/system/arm/sbsa.rst
- Link to v2: https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg02951.html

Changes in v2:
- put this code before sbsa_fdt_add_gic_node().
- Link to v1: https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg03390.html


xiongyining1480 (1):
  hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine

 docs/system/arm/sbsa.rst |  4 ++++
 hw/arm/sbsa-ref.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.34.1


