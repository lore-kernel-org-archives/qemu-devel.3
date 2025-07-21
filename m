Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3514C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrfm-0006Qc-PR; Mon, 21 Jul 2025 10:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udrfK-0005yH-Un
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:38:55 -0400
Received: from p-east3-cluster1-host5-snip4-10.eps.apple.com ([57.103.87.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udrfH-0005d3-Rt
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:38:54 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 A000E18005C6; Mon, 21 Jul 2025 14:38:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=W9rm4Z3YURnt25CcHTVKvCrh0kzNmY51JHp2Ot0ah4E=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=ahG2aF6REmixQWfdhr2vIzgTPFfZ5JSEZshWTYel/fawj3hQ16YXjoqqUYDPRzJbWVHIVRprSO4jbhJgheDuKM4iDMsGPXHbRnroQDnFxTMBG64b2C+/4/+UNwnbFSiOao81pbqPFLLsh1ew8aRgYBjkzstUVOLSC1rpwgLzcsGMFxkLK3NSvH8moXaQFOKPDBpzlr+ZTFGhQ1E4NgV5j//SR5hnDLhhx+up13ulDLBGrjrcMP+DTT1VCUD1K+feeSh7RVYq38A7vsu9Xp3usPpRznJhTJ2ZS50DWGVrjq2qAuMEHNVxO1xUQDmB/LdkW2a6VdtQ30PQw7uUh2oBcQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 D73D318005CC; Mon, 21 Jul 2025 14:38:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/1] hw/arm: virt: add GICv2m for the case when ITS is not
 available
Date: Mon, 21 Jul 2025 16:38:18 +0200
Message-Id: <20250721143819.32334-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _xXQjrpM0UXEA5joLzL7S9QbluIP_1xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyNyBTYWx0ZWRfX3D7yJW+yNgKN
 txS6NWc2cHVSM+hRH2rDqYHvhHfAsyF8V9aoCA2YJ6bc7GyKtwrvWtNqN3xheLgbmlEgr/lGD7W
 ispW5f1pkkEUfaBqQXUoutuNEy6LfHSOgaAYpOB/qoY47pRxw6MEfm4PqZetlwS4uG9EJWWF89a
 g8YR2Ho+T2psDIjYVyFX9tlnHK27iDBZfgjp6o01lmOfwT50kDk5GFpowEEoYAL7QauyEokovCc
 kb8FLL7FqjDUrWp8Ro/qJV4JDlj3YedlxjBocjLZu9lB9I+zW7m9hhZIJqV6CvHyKp26Y4pCA=
X-Proofpoint-ORIG-GUID: _xXQjrpM0UXEA5joLzL7S9QbluIP_1xu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=793 bulkscore=0 clxscore=1030 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507210127
Received-SPF: pass client-ip=57.103.87.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Client virtualization environments shipping with a GICv3 + GICv2m configuration
without support for emulating an ITS makes this more and more necessary...

Done in a backwards-compatible way without altering the existing device model
for older guests, but wonder if having a separate gicv2m flag is worthwhile.

Mohamed Mediouni (1):
  hw/arm: virt: add GICv2m for the case when ITS is not available

 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 8 +++++++-
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.39.5 (Apple Git-154)


