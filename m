Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99194D1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwt-0007Uu-6N; Wed, 03 Dec 2025 13:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwq-0007Sx-Vw
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:33 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwo-0000zn-97
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:32 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37jXLM3680851; Wed, 3 Dec 2025 18:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=jan2016.eng; bh=P/6EV1veq+S1ZP/OBaTW
 715pumkOOn7ntQjtPk0bRMk=; b=PwrmUX+GHlQVBZCxRGuSWNsrSKpzrygsGXq2
 ZgWkdTG2iibGdJPDNnMcbvNI+HNADuJF5qHk2uGmnpCG2E0xnuE1cKahq+d0a/2V
 W1VwKy1gYiuj1aExkP6RuMTsN4SGukWZCS/WFYl8fPC5go6cHybnHYa5gkuZc7AH
 gK9DfLTz3U3grLqjYL2lMhZX5n9SmL/6qFB0WqxrdNepT9pc1OCpJ3sn12wUhpc3
 QARi0p025i7wH73vgy0OasFEldcF757dC4ecbRtq95Lqp/x9Vg50FUEmy1KZZa+M
 Gta6/yYoTmZgd+6r9bePKeDbL44NORpK5xdpt5OLBdKQrIfCug==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aspcaafqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FlNNb025617; Wed, 3 Dec 2025 13:51:26 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4aqw21kuh5-1;
 Wed, 03 Dec 2025 13:51:26 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 9708880;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v3 0/8] Live update: tap and vhost
Date: Wed, 03 Dec 2025 13:51:17 -0500
Message-Id: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWGMGkC/2XMywrCMBCF4Vcps3YklwqNK99DuhjTqR2kTUlKU
 Ere3dity/9w+HZIHIUTXJsdImdJEpYa9tSAn2h5MspQG4wyF22URb9G3GhF1Y5DpzV5Vhbqe40
 8yvuQ7n3tSdIW4ueAs/2t/0a2qNB63zl2D+24vdGLZpKzDzP0pZQvA1sie58AAAA=
X-Change-ID: 20251203-cpr-tap-04fd811ace03
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=2009;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=5q1cQf932k8LKhz/1ErXhKVhvIGOXcagIbzzlLQDNcU=;
 b=tHD3IqPk1ZZYHzVZBH9H6k1ucf8TtUPPI52xLJKwKH3QFforS7UC8MLSoxW2vKbSgjB28AZKL
 U8IYSMQEcrWAgLPIeUoVl7g+UEVJtZVO4rhJE8EgZrQzc7wdDhwfo8s
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=643 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-GUID: CQsYVtjdd9cENLS0gw5g7syK-fiUqZk8
X-Authority-Analysis: v=2.4 cv=c5umgB9l c=1 sm=1 tr=0 ts=693086af cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=X7Ea-ya5AAAA:8 a=SJiDcYIvfsGvQCbKpNoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CQsYVtjdd9cENLS0gw5g7syK-fiUqZk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0OCBTYWx0ZWRfXxzIduKy1Eudg
 EYQ9/QIaoLq3JMJFm4X2PuAGSIyFI4LScteRUBartVdeFrAZkKEXjGVXQJhtheEu6B+0A7lfMql
 7pH50WmF3SaWL51xFeoutv01gbpZ0aW31kVtiJNCJ0XYjqQ4J7HxdGBePT6VRQoKuXUXRR7D++9
 wu1jrWhSArB0jO+faVdoXcG5TbtcWHYEosVVf8BUjAIa7eqHVDxdBYPBITnKgaa/ely0FexAECf
 0obOET6ys9Rox/pDWN4D8OyKEEnqHYPAyvrf4WeU/GmzPR99PZbfgFGhpQ1X5YLiJcGtN1BVgvm
 Bdq9BNFAc8OcWnfONaIEjh7THDfQ/ulu2C94ytEJydeG+35VfJikWtFYnTAPiLkOBdxD9y+lCAn
 kPhXz4eK1Fc74MbWPADiwmH6Va7qhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030148
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
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


