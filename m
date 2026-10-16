Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5FCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdWS-0005Hr-Ag; Fri, 16 Oct 2026 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdWM-0005Gb-9F; Fri, 16 Oct 2026 04:42:34 -0400
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdWJ-0000fT-RG; Fri, 16 Oct 2026 04:42:34 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.37.127])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4j5djR32H1z3xVZ;
 Fri, 16 Oct 2026 08:42:19 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 10:42:18 +0200
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Guillaume Vincke
 <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v2 0/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Fri, 16 Oct 2026 10:41:34 +0200
Message-ID: <20261016084136.233836-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 16387473146538311975
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGW8Sx6pLvS2Cp3jzmO1yfAARkBp1YsrR9tgmXtlPec00kKQEkiR+/Dg59xHSuQr5N5KUHnnzZ8cyaPf+sCKxPVCJsn6ZyUYj7ceMy3lrB3VPuMGmnE8LI8EtBONO652ixOWy5Z68XvwZcBX/I/wdT8gUuji1pfeI9TZOT9pn6qTNbMCgFNsyQOuz7c62wYnfih3WU4UVVfZ6QgONN8SW/HAlJVWu2/k3d3OwWa4eqpQjO4HJenavB4E+SdWZ5EyMVBdXm9CJ9RQiofGrmKTY5B9ijNwQ6yjaJ8J56Bc08zQ8XZWLe3Wvyt8VxIaGU7UMlh2r3oUdheU9/Bn+IFDPtbUFO9Uz6UWxp2eVwPZaHSQIQ5/qjYcd5bYLhkTdK/vB9oVbJl51//TioWmqaTjYYmxVcS4mRNT9dscsJQ030xzjaI7eQ2HexsZQeMjmnK2ngBzIla6o7hBDdeQzRdxkI4H2o2rYActdChSGSYlP+XSkHid4VYoiXSJDKEXCiKm1X9opFgqWNb5xbF5cTMboutHOJh1RARqhgj0LHy7MgDUp0qsCFeL3AbvTOzVWM0th1s4ZujQUU1J6sV+kMkpSQ11SxhQ5PfcFxHsWmw5eB3QIhR4LIPCSnkJiUHUDi14IVbwKyPqWyeWnAsO74AWPoFfocaBBu8+1X+bGVY70//2A
DKIM-Signature: a=rsa-sha256; bh=O/YCaKHdAWIvfI8v3IUy3Q1NVD4OxrlQPJDL1/Pn6Bs=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1792140140; v=1; 
 b=D+eDVjmdXSPixGFwIKxpBm3phyKDWWqcVEjjBuaCWRe2bTG8JYRjHe3n+LWp+4awc/3qHv6n
 UZdHqGGmOdJi0rNyxEV0Btlmk8bgjcPFRysxWID/ogeE/cisqCet85vjCuKgx5EjWEdU6N0uPZ2
 uTszh8iYk4laKetLMMIexyaQ=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
Reply-To: guillaume.vincke@ovhcloud.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

NBD client relies on lazy reconnection on error. There is a case where
nbd_co_establish_connection() will hand back a channel disconnected by
its peer. This leads to the request running on the dead channel. When
reconnect-delay is set to 0 (the default), this bug prevents the
nbd-connect thread from running on the first operation. This patch set
addresses this specific case.

Found while searching for a way to force client reconnection to simplify
the resize of idle nodes which will be the subject of another patch set.

v1: https://patchew.org/QEMU/20260925155346.357703-1-guillaume.vincke@ovhcloud.com/

v1 -> v2:
- patch 1: Pick up Eric Blake's formatting changes.
- patch 2: Start the connect thread after the NBD server so the test no
longer depends on the 1s connect retry, which made v1 fail in CI. Raise
the connect wait to 1s.

Guillaume Vincke (2):
  nbd/client-connection: Fix client returning a closed channel
  iotests: Add coverage for NBD connect thread start delay

 nbd/client-connection.c                       | 32 ++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 ++++++
 3 files changed, 109 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

-- 
2.43.0


