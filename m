Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1B6FEC118
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58gi-0000lh-IR; Tue, 24 Mar 2026 16:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gh-0000lO-47
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:19 -0400
Received: from p-west2-cluster5-host5-snip4-10.eps.apple.com ([57.103.71.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gf-0004d7-8k
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:18 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 21FE8180017D; Tue, 24 Mar 2026 20:49:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385355; x=1776977355;
 bh=kf6eKxyXZLEjqR0ByHDLZ2Xd+/71MZRm+msYxj6G2To=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=YiHXHh/wnamsM7VcaGyxgTUhRncH44hSYKyUPucUvBMW6sCs2iRLg8basZNM5w1ANnHFVD+KZOwAQ3yK3IVhN0KRcZmzh8pE8W1pQxDwWtwMkCy6eNU1Ba9g5dgTL06NWoP3reDFBuuHwmpMNG+VPILyBXrsfnOPp/JR4269Z1ZspLogJ88mTTDXw8ISaEFPZ/p6tlD15Te4RhVCLea6VqsVBgMMspzzaT0T0579Ef5AaDDUBomHCmPYkWSuiuQDQrGKlcqfsdzKtMflmAHGsrC6K3SgHrLo6ghfp4wLJk4G0sSkt5HEr/9JhJftfNzzRHlHEOqN0roYpnEg5wH1bQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 46ADF180012F; Tue, 24 Mar 2026 20:49:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 0/7] vmapple: making it work on the latest macOS host
 releases
Date: Tue, 24 Mar 2026 21:48:48 +0100
Message-ID: <20260324204855.29759-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OZ+VzxTY c=1 sm=1 tr=0 ts=69c2f8ca
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=PWwuWOSklEzM4Y2Y:21 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2hVxfcq2HnubPNJNzroA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aJmD7Zdr8NioKUfSGBhWf0oqLjj0nE4P
X-Proofpoint-ORIG-GUID: aJmD7Zdr8NioKUfSGBhWf0oqLjj0nE4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX+AoJ6Dss5Y53
 Etfd46m/786A8nLpE2YcCraiJa9Z+5m63esbkGAFApmEa/Fi340iwJaZ4Edl+QPgW4IV4RNeBIN
 vdlgSofqO/hUfSHKhs2R5KzTabqAr3et3bNlpMIlLT0ucCCIcBk/SoO3MuklJIVa6tzenutKe/H
 59GrhAA7cUqCcn6j+VbhSqFtzHhqaVsyX/h2NaG0hpq0JxTfUaZZebdXSjKsCHwwpYgvcGYyYrL
 8J6EwpOTNtT+7+vHpghd3AE00+Ty484oTcFugSW5dVuqAoWksQsjGMPc0gDeUHECqgE/ySycz0i
 rbfaui86PwUmz4xUpg56FDgeCzgLzuX3l+NA22Wj7pnwmLQCOgi0YdLGB7szz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1030
 mlxscore=0 mlxlogscore=678 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.71.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v7:

Support for newer guest OSes.

Added not mergable patch for private ISA enablement.

Not grabbing a memory reference and still using flatview_for_each_range
for this one, which works fine as live migration is disallowed anyway.

v6:
Rework the patches a bit, with making sure that there's no compiler warnings

v5:
Address review comments and rebase.

v4:
Rebase and resend without the RFC tag as I didn't get feedback.
Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (7):
  vmapple: apple-gfx: make it work on the latest macOS release
  hw/vmapple: aes: convert MAX_LEN to a #define
  vmapple: declare it as an AArch64-compatible machine
  Revert "hw/arm: Do not build VMapple machine by default"
  vmapple: add gicv2m
  vmapple, gicv2m: add macOS compat quirk
  hvf: do not merge: enable private ISA

 accel/hvf/entitlements.plist                |  2 +-
 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 59 ++++++++++++++++-----
 hw/display/apple-gfx.h                      | 16 ++++++
 hw/display/apple-gfx.m                      | 41 +++++++++++++-
 hw/intc/arm_gicv2m.c                        |  5 ++
 hw/vmapple/aes.c                            |  3 +-
 hw/vmapple/vmapple.c                        | 27 ++++++++++
 target/arm/hvf/hvf.c                        |  8 +++
 9 files changed, 144 insertions(+), 18 deletions(-)

-- 
2.50.1 (Apple Git-155)


