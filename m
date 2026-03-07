Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940DEF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmH-0000hW-Dq; Sat, 07 Mar 2026 10:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmF-0000gb-OT
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:15 -0500
Received: from qs-2004d-snip4-1.eps.apple.com ([57.103.84.34]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmD-0001uF-VI
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 2BCE61800AB6; Sat,  7 Mar 2026 15:41:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898072; x=1775490072;
 bh=uFnSCt530eDZTdUYCOZjfr/zmR792B8dPu7lXXJfa2Q=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Fz6bFL62+sASTmr0LmeqIaVHAlWR0bfOLp8yU25WRaRsLKP4VYg2G8CI1eI4VKqN0TN+8W/86W9JFrfQ7HiQSwxfqoFl8XqkQo63SenDAx7in1HT2FMpUVAKtBeAIir/Hi2TNUfOO4MEJjU4ufsYvvUHa8+TX0TunI8XQw9IRxIgKvYqoKt55hjk7VeSQfRQRVa7Wuzi4STN9ITbecMzLJpMjOS8JjXBf1FD+/LbdKTx+HOMDST7z9VBKxEO4lTfm6kezR1QCusuOJVazCXxovnrrrFiZeI0xzB1hNXDAVPA7on0tbJcfawGTvUpb1lQF4E/2hCqbjnHALVyHAEpnw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 7BBF21825303; Sat,  7 Mar 2026 15:41:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 0/9] hvf, whpx: i386: x86-centric fixes before softfreeze
Date: Sat,  7 Mar 2026 16:40:55 +0100
Message-ID: <20260307154104.84567-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=69ac4717
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2hR40MzdYebMGYd4gb8A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5GmARcu8n4ioAV8Q57n-12rkFDwJggmi
X-Proofpoint-ORIG-GUID: 5GmARcu8n4ioAV8Q57n-12rkFDwJggmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfXxM4gtVtOZO/i
 8dKqq7I0UVPgBU5bDkSJQJVJT7BPEu9o4Bhgq3i+lyypJKvp4osT0LzwxHZU0xEzvomlYmmG5uV
 0tLeuKC9ybo86outOUVypA8StwntbAQuB5jmGpDBtoV4wuxypz0n1p7ATQzkORGAdzNT0SKFSRx
 hirGHK3BXK8tQb9eHZiK6ZSJv/VoX5r3gnQCtt4lyMxxit/FNnVGqF8ATPsxR+r4+lW+uMVQbqp
 ZndtKWp/rS4ZM6pJVPNPoiKlFhk+26enr6tzRGfeT/5gh1qPF8NP+PWzKVkNTWb/wlPNkMjwMfB
 So9nL1uyoZYt1kanutXSmHpG9zaeY0S68tzGr5y9m5Tm0WzUhy1Y6n6jNckMyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030
 malwarescore=0 mlxlogscore=874 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABOqq+24FMoPWNxjgEI7kOqL5nsyq6kAOG7+rV50arXTqqMmGolgV9HGUIDBPsMUJDGc6peLPq6/x8HzVMLhf1v93Xjg4hfodQH3KxiO8iOqr0nh2OpXvqqCC+H6IXMzUSAzvJaDZp5faXO0+eeVaFn3L5GHleRbOoifb94Uqk4MqrCxtxbPLu28Z9FoaZ5nYdR97FNprtEMg8bHtk62hE9t7ry4TMtU969GzXyN4XnY7LhroK9HchIpsA/r1NxMDTpxQT259G0kcApP2AIYtPipBG/apgHLAObftHccv6jTcxBfQTUUnGf1aFxTFMSPNOEcl/2P7Latvv2PgNSKFgrhybgRPD7uf5HY08i4nTwkO1PXv+LJHl046nUBcnwtfap4sEKe7QdvJ/i/QBIiXuQmYAfXud9/wO2WVXSvnXg9uOxcHgHdydUprOXWmeBa/NITxJYa9Tgki8A6CUZGSrbB/vqjVRVK7tvScjdYfZPN5t1ls0HVqiSLgThTH/1pngg70DEN0RxsdHgxbAh6FzXfjBN538n3g47TfHUvm7sWiXnQ8y8RtzgpytaC2VBq0KQMPi3lOCN/+7qMvRSWvx3bRVgtiJcPpf5tX1SGzD8mT0BPh6HUIfNZORYIkL1B4LXaVonsgOiI7YXGQEHkmTV9W2aPX64px6aLtxnExIVW1TbiOPrKJW3loChiFk91ao4MYI7uiFQBeCvTXwkETHJ1h/8WHPXdHXMbI1o35uXkR3Qsyy+7JCqBKRm8LzoorSL9OaFUKmzweY5+3QZbCxKBAqoXFd
Received-SPF: pass client-ip=57.103.84.34;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v5:
- Also include HVF buildability fixes...

v4:
- Removed two patches that I didn't intend to be merged at this point yet...

v3:

- Added HVF build fix from Pierrick Bouvier (oops... forgot to have it copied over from the test machine earlier...)
- Also added a fix for "whpx: make enlightenments configurable" highlighted with an error from GCC. Clang did not catch this...

Mohamed Mediouni (8):
  meson.build: older macOS targeting compatibility with macOS 15.4 SDK
  hvf: arm: unbreak the x86 build
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments
  whpx: make Hyper-V enlightenments configurable
  whpx: arm64: enable enlightenments if asked for
  whpx: i386: remove SIPI trapping

Pierrick Bouvier (1):
  target/i386/hvf/hvf.c: fix compilation

 accel/whpx/whpx-common.c       |  44 ++++++++++++
 include/system/whpx-internal.h |   4 ++
 meson.build                    |   7 +-
 target/arm/hvf_arm.h           |   2 +-
 target/arm/whpx/whpx-all.c     |  37 ++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 ++--
 target/i386/whpx/whpx-all.c    | 122 ++++-----------------------------
 8 files changed, 115 insertions(+), 117 deletions(-)

-- 
2.50.1 (Apple Git-155)


