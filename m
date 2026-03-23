Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E5F4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrH-0005vx-AN; Mon, 23 Mar 2026 18:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrG-0005vY-3U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:50 -0400
Received: from qs-2006a-snip4-11.eps.apple.com ([57.103.85.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrD-0002ul-Bu
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:49 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 CCD3D18000B8; Mon, 23 Mar 2026 22:34:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305285; x=1776897285;
 bh=5I9QlRG/HpUqZk4PK7Wrni6vtmYRM4SvX6QQfzV9+W0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Ald4WxOPhUryw/ght1Hn/cxUEK8H4/T3XZm9z8ooHCAbT0WRF/FQ04IRZk/d+XoR+odqkbHXBpC7l9BuqqFeD+JJLprvsRAFvwQkfIQ7GPpaEVvKIUdSKuNj1lKicTkW4fxTUYn/pdEcWQBHdLA+YIBgm+LbP7Y8S9Kuk1SZ4pOFxLmT16x7dSW9AFfCcxnsxbWl/w9Jo+jZXlrLsLlJ3c2522t2aWClLClDLKKDcKhitySSwJ/AhoaaGHISC2k8PDsvBBPK+BecWSk6PkXLRXXKxoSki8sh5Id7SNtmSwmXxx6JMiPSkkFJ6Ic+MF5VGmWYjP16N0tAzfSY01nQ8w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 6B80C1800157; Mon, 23 Mar 2026 22:34:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 00/13] whpx: i386: Windows 10 and performance fixes
Date: Mon, 23 Mar 2026 23:34:21 +0100
Message-ID: <20260323223434.81780-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=bZxmkePB c=1 sm=1 tr=0 ts=69c1c003
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=td4nV04XUHi7FXuGOJ4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZT5PnTQo4YGXTN03b_RyTNluukt8hzhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX0REDLvG9aHkd
 eUTU+2TExLiZGRv8UJPWNwMIoSWFH/Q2qHB5UZRlAG4rkUghcip0E2fxhMk5SmGXLjpJJtfF9Mh
 iVQco0bEDKSZ4vrqGIHNOb2xeK5dwaVWJl7iIr1QoqIdaemk36PkfrPH6wjqD636OzSlT7lyW4e
 oE+tbLyGEEdcjzSajoRuQDrQufnmWidRjjgEtBgY/BTsFMH2uqTEHUomUl2VsCI3RrciTz5lrey
 yMdvGXDzWLbE/j7+k8/TwjbQlvIRPh72t64wX+P5ktuKN4WGtB1yU5IaA4V0023B1+GvWgDIwB+
 fnT7Xzx5CRO9jgL1BiWW9Nw2S1dPhoM3ADxcLw62fLLsoKTJzNEhJbboKiKZeo=
X-Proofpoint-GUID: ZT5PnTQo4YGXTN03b_RyTNluukt8hzhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=521 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.85.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Windows 10, the paravirtualisation enlightenments aren't available.
And neither is performance monitoring. Using the former as a gate to
operate in a reduced-functionality mode on Windows 10.

And on the performance side, some state is really expensive to fetch
or write with Hyper-V so switch some less-essential state to on demand.

The effect of this is magnified on Windows 10 because Hyper-V enlightenments
are not available there.

v1 -> v2:
- fix x86 HVF compatibility
- small nits
- added workaround for an issue that showed up during 32-bit Linux boot
on AMD

Issue number: https://gitlab.com/qemu-project/qemu/-/work_items/3349

Mohamed Mediouni (13):
  whpx: i386: workaround for Windows 10 support
  whpx: i386: enable exceptions VM exit only when needed
  whpx: i386: skip TSC read for MMIO exits
  whpx: i386: skip XCRs read for MMIO exits
  whpx: i386: don't restore segment registers after MMIO handling
  target/i386: emulate: add new callbacks
  whpx: i386: add implementation of new x86_emul_ops
  target/i386: emulate: indirect access to CRs
  whpx: i386: indirect access to CRs
  target/i386: emulate: segmentation rework
  whpx: i386: fetch segments on-demand
  whpx: i386: workaround for segment granularity reading as 0
  whpx: i386: fast runtime state reads

 target/i386/emulate/x86_emu.h     |   6 +
 target/i386/emulate/x86_helpers.c |  83 +++++----
 target/i386/emulate/x86_mmu.c     |  11 +-
 target/i386/hvf/x86.c             |  11 ++
 target/i386/whpx/whpx-all.c       | 283 +++++++++++++++++++++++++-----
 5 files changed, 305 insertions(+), 89 deletions(-)

-- 
2.50.1 (Apple Git-155)


