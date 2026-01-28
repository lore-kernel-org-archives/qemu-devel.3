Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E542D46BFB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKj-0008Dv-Gk; Wed, 28 Jan 2026 15:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKK-0007ap-5P
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKG-00085J-W3
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:47 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60SILwij2173547; Wed, 28 Jan 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=jan2016.eng; bh=Ua/Q7Oj5QfoZ80F2n7lQ
 CdaspRJGcMjsMmwOOGbwtro=; b=RoueHMENKWGOmw9dTAD0oG5rLydso9pKd6ql
 4pvKogUbvMS0o79FSizgGWxZhV4CYCSQJh+FAloo9aTapnhw8fPpPkKzobOEAYUv
 NFB8njyvV7N0SDCt/9Fv1ilNya8erzeSSImB9WKLI4CI4re4oZQh1vOLZGd1WEwq
 2ya6OKlFXdqAEY/JxI1X1Ow1tezTUtYLxHv8Cxc/8wO8Uq7C4ZoovbNZUmoZl/Lw
 cADyk72uAMS941WgSLZoWLxspZN9u2Ie0+q5M8t9lpCsXGsEOXPPcUPKKiRHzoWS
 ZShbFvNcU9SeShUgGUCNmsgL59kAcTpRZZuMRJ9BiuLp09+S6g==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4byqnat9w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SJOrxf016903; Wed, 28 Jan 2026 15:39:41 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4bvta3rd2j-1;
 Wed, 28 Jan 2026 15:39:39 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id F030D98;
 Wed, 28 Jan 2026 20:39:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v4 0/8] Live update: tap and vhost
Date: Wed, 28 Jan 2026 15:39:28 -0500
Message-Id: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAB0emkC/3WMQQrCMBBFr1KyNpJJoqSuvId0MaYTO0jbkJSil
 N7dtCtBXL7Pf28RmRJTFpdqEYlmzjwOBeyhEr7D4UGS28JCK30CrYz0MckJo1Q2tA4APSkjyjs
 mCvzaS7emcMd5GtN7D89mW38bs5FKGu9dTfUdarJXfGKPfPRjvzX/CaBJ4RmCo2+hWdf1A11N4
 IjQAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=2157;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=JrnOYw6PfRAbfYfFdJb+fYkp/nGJf3ONOu23fWG9D00=;
 b=NtVA/7LssK2vQAEqLm8c+dLApFouukCd2JoLLouvqFxp/4wvqqG4YxIZXUx+tbrOHNvDTHShY
 gfJeymrN/DfAbnWEOBmnZOZU9oIfX3QHmIQ+iIoPlrqmopkq1tsGlNY
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=867
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280169
X-Proofpoint-GUID: eEbbahj3XWcTeeHSF1uhJAbyejuf-1ZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfX3lDs7LcKA++b
 JhCYGHPUXV9SxtqkpguyarBf5kpQ6BVAT6/LKFzWbRJdoS3En9eczhRKpsaAteAyj9M3lXumpNe
 QCcZaMBhNpMyrB4ZmcZRDM6jwn/cyg1qybEPDHCq8FsT/12pb2UqB6vtvqIbq00MkLBuR04wX/f
 D55BM9c9LBXEMDWYCAZsf4jrTr262z/HSVgHuHK5HsJ2L1gtv7rtrYVbqdH9CJkCQrEEaq0DFmJ
 WlKHl64XVwbIRo48r9QNnvmFtvrf4BFmMDQlgigjZUzqtLn5ZIwLB0udjC1pyFAQocErblR9Kxv
 O4s4f3wamGUvQtWcupQ7eJa5rKmEoMYJYWKYI1bbU+xCcx0fbPWYc7VlStUC29MUiU/N8TIb7Mv
 ApKzcmQq2LIzFL8fkQpU0hIpTkZlOSoMyxjxk3vWROm2OtKVMTKztdTXV5zt37vosKl8Aem2llU
 q6mdt8HP8k4ANr1KhFA==
X-Authority-Analysis: v=2.4 cv=AtTjHe9P c=1 sm=1 tr=0 ts=697a740f cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=JVPeIT-X6wxlae_9F0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eEbbahj3XWcTeeHSF1uhJAbyejuf-1ZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280170
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Changes in v4:
- change the name of cpr_get_fd_param as it is no longer used
  exclusively during cpr transfer
- clarify documentation
- Do not require fd=-1 if fds will be provided by cpr
- Do not interleave tap and vhost fds
- Do not check cpr state in qio_channel_handle_fds
- Link to v3: https://lore.kernel.org/qemu-devel/20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com

---
Ben Chaney (2):
      tap: cpr support
      tap: cpr fixes

Steve Sistare (6):
      migration: stop vm earlier for cpr
      migration: cpr setup notifier
      vhost: reset vhost devices for cpr
      cpr: delete all fds
      tap: common return label
      tap: postload fix for cpr

 hw/net/virtio-net.c               |  26 +++++++
 hw/vfio/device.c                  |   2 +-
 hw/virtio/vhost-backend.c         |   6 ++
 hw/virtio/vhost.c                 |  32 +++++++++
 include/hw/virtio/vhost-backend.h |   1 +
 include/hw/virtio/vhost.h         |   1 +
 include/migration/cpr.h           |   5 +-
 include/net/tap.h                 |   1 +
 migration/cpr.c                   |  32 ++++++---
 migration/migration.c             |  69 ++++++++++++++----
 net/tap-win32.c                   |   5 ++
 net/tap.c                         | 148 +++++++++++++++++++++++++++++---------
 qapi/net.json                     |   6 +-
 stubs/cpr.c                       |   8 +++
 stubs/meson.build                 |   1 +
 15 files changed, 283 insertions(+), 60 deletions(-)
---
base-commit: 2339d0a1cfac6ecc667e6e062a593865c1541c35
change-id: 20251203-cpr-tap-04fd811ace03

Best regards,
-- 
Ben Chaney <bchaney@akamai.com>


