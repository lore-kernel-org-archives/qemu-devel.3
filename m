Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF3D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpP-0001io-Cp; Wed, 03 Dec 2025 13:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpJ-0001gZ-VC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hK-8S
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B3BFkA53427910
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=jan2016.eng; bh=P/6EV1veq+S1ZP/OBaTW
 715pumkOOn7ntQjtPk0bRMk=; b=kCuzJiV8Az/HHvpjR+mkWICnRFF2gN7cXzq0
 19PJEKxean35FvXnyTSb4X1Ynl9ZzVek3dHWbZwyMDUk2OOOM8zT3Idqy0nN+ygi
 tUeqn+XPzZmOjbquv3U/rz1hD/0F++rL3zzvKaWgndqyLNXWmQLskfaJZG+dXuyJ
 egIcLmRWm0uRvuSeAp/DyRg2/Dmle4OR72OQgg42P2Kx/e9Hjvf8pzB2NO3JFE+S
 6qntfb/g8vyWtKVETbG5Of0QX6DOnI2UFbjY9t69kZmcvRV6Bq+kwwCO8OUalvrk
 zkVHUkNfnE27ovIi3AtYoaZi3aajbM6QNY6ejo4XlHzxG73OaA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4atm5s69ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3GBdFj014748
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4aqw21m40d-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 43C1683
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v3 0/8] Live update: tap and vhost
Date: Wed, 03 Dec 2025 13:43:21 -0500
Message-Id: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmEMGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3eSCIt2SxAJdA5O0FAtDw8TkVANjJaDqgqLUtMwKsEnRsbW1AFz
 MjOtZAAAA
X-Change-ID: 20251203-cpr-tap-04fd811ace03
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=2009;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=5q1cQf932k8LKhz/1ErXhKVhvIGOXcagIbzzlLQDNcU=;
 b=kF0tDP9L9GNLl/baqjsSyk9ZERVQhQYqGbpVOiCtrSYIZAVOWGZ0v9plVkr5aUseW8ADKzp3a
 5LWNyIaMUMwAyx+CDN7tHVR8unKgc6H5MEFTVFP4fhmrf8WPJx+3xSt
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=536 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030146
X-Proofpoint-GUID: 2PtSkzfIh3DPkZaKjkhMGpa3GB2q7l7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX6wzJYaIIwh75
 tECxbVx1Clj3iDfh7zFY7zRpQgH7FBjoVa31khlxwO1UoWFL7NodEUk5fUEW92S3wvYKMj4V8BN
 hai0Zyn9ntDYsWVoT28lLWPHR17LGlCTl7P9zFLDZmINsQ6py7dSgruDb97540Hb0kAW+3RPBpx
 0OkffrE68E0pWYdvXSdehyl2io2qWfgBvFD5trdotb+3y5vDZCBA/0nPCc/M6n5e6X4oLsb8zyq
 ydF4yBC7+ubkgiynqrIYmBjdkbTM4FyysX8jLbAY1X5YTfCpI2F0gednXIDiEUg/FB9NRvdNqje
 SXwrtVvRVQRPNTaitnQ2tqBlnLh+/HWB7g4n9UYtGyvLxgqa71iiLA37HMPq/BJvCmjHjQiGHk4
 YliwYs63kbTQrBSGy3NImtNjRM7r9w==
X-Authority-Analysis: v=2.4 cv=VdH6/Vp9 c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=X7Ea-ya5AAAA:8 a=SJiDcYIvfsGvQCbKpNoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2PtSkzfIh3DPkZaKjkhMGpa3GB2q7l7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changes since v2
- I have taken over this patch set since Steve retired
- Added comments to explain the order of events
- Remove redundant reversion to cleanup git history
- Inclusion of virtio and stub fixes

Tap and vhost devices can be preserved during cpr-transfer using
traditional live migration methods, wherein the management layer
creates new interfaces for the target and fiddles with 'ip link'
to deactivate the old interface and activate the new.

However, CPR can simply send the file descriptors to new QEMU,
with no special management actions required.  The user enables
this behavior by specifing '-netdev tap,cpr=on'.  The default
is cpr=off.

Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
Steve Sistare (8):
      migration: stop vm earlier for cpr
      migration: cpr setup notifier
      vhost: reset vhost devices for cpr
      cpr: delete all fds
      tap: common return label
      tap: cpr support
      tap: postload fix for cpr
      tap: cpr fixes

 hw/net/virtio-net.c               |  26 +++++++
 hw/vfio/device.c                  |   2 +-
 hw/virtio/vhost-backend.c         |   6 ++
 hw/virtio/vhost.c                 |  32 +++++++++
 include/hw/virtio/vhost-backend.h |   1 +
 include/hw/virtio/vhost.h         |   1 +
 include/migration/cpr.h           |   3 +-
 include/net/tap.h                 |   1 +
 io/channel-socket.c               |   4 +-
 migration/cpr.c                   |  24 +++++--
 migration/migration.c             |  69 ++++++++++++++----
 net/tap-win32.c                   |   5 ++
 net/tap.c                         | 147 +++++++++++++++++++++++++++++---------
 qapi/net.json                     |   5 +-
 stubs/cpr.c                       |   8 +++
 stubs/meson.build                 |   1 +
 16 files changed, 279 insertions(+), 56 deletions(-)
---
base-commit: 9febfa94b69b7146582c48a868bd2330ac45037f
change-id: 20251203-cpr-tap-04fd811ace03

Best regards,
-- 
Ben Chaney <bchaney@akamai.com>


