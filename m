Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3AAC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx18A-00019f-8r; Thu, 20 Aug 2026 07:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx188-00018x-KW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:20 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx186-0002GQ-9g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ82INaFQKBpWWyB6TzfL3thSE2sNZ0VvcPMtHe+Am4Ifpv2eF5dIntVqbBOP5C5PuJYopNKUKum37oblfSjE7v4Edoh2ishLOUDAXOH0WlWJ6jVZq1FRMPyUsnPgRUWq7CHh2nMeCtLX16YU98y9RdvjOBLreE2DmPiFIra8yhp/gkFuOhwSF96ys/kGQypT5BC7+3V0sAuilPugOfFaJ8mCRwsfZzT8xgowtn5ueU1n46ZJ3ZQUo3RixzI7pbG3ef/Ck+KH4o1gDb/h959CSs1k0sP0R1LXcsJQ0V9lBt3rtctO8NOGL4MgerTkeOC9cszZtlcFjchGNW32aesAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhLjHgfdhFzk2/hTj+Mps2PFi6GOBAm7+WSoM/o1ChY=;
 b=VcJIus+gHaMUfkgqNG4h2xGSY9adW7bhohvGQxK06M27HATsfFLoc153qA1d+LPZY/zMb9XR+b4nD9oaEolm7g7B+sZ6UK6ccw5TS45cMRelSRaGa8x/2GgZmnvYeVKPFwoZYmk9w2/MdWA0wf6ZYiLBu8jzLWQ4XY7mL0Uf50NX385O/WyZrCCp8J+cZlzFuxCEBZa8z7F+M6Hf8pn7KZHo02pwtw/HnlYZF+8P4vxq341OcgP9UxqK2QpNuLB2C3UYjCK2udAOK9TxyuUG0wYVOuhWfZxbat6fDqCFw8cJFLeA5FK/c127tRBenTT/G5SS1/tp9ezDCMJ0TfNmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhLjHgfdhFzk2/hTj+Mps2PFi6GOBAm7+WSoM/o1ChY=;
 b=AZFtLNaGrBGKsfdbD0CFPI0JXLozMW6+A3eiA11R/BdbrNtueu2tn+UsZsT+L57PnGbwLOfHhs09tC2DFSGZdsiNWdxJKu4Ph2DBS0A/hpHha/DtmCXCjMvCqpv9EIYP7aAea8VaqI8SCWzwShpvJ9NcFESM5POBjgRIywmEsjlKUNU7x+T73vc0I9c5cmdRLEL8QxBf2Mw0IH25Pa4BoGYtgXSctdqCxmLqaafsJlexi2Gu5XI3fiSi2UXG6599i8loelbtChgFvG8KHmcu4hpPEIKAU++l9qCWDodNSSF6yWJlTZVaVCzFFVO89XQgnd3vDgSSKVJO5P7BZDEZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI9PR08MB975321.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:09 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
Date: Thu, 20 Aug 2026 14:39:55 +0300
Message-ID: <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MI9PR08MB975321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffb7f12-8c81-48d4-b2cc-08defeafc9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p+G9W9uTUfxUrdzpRk8/vX7S69HHnwH25gQLuuuqdCwqLXDDWgQC234NLSSSzR27HWQADjL7KBlZrEe/9tl+4m4mlT5t1mMH6eVbAK+WeL0AekO9URqXzHb7c/cCGuChG7GoFWvyYx/29DfCs7ukdoZ6zYvyqRoUu58+tHlENqhBQplPAdUagD25lN+HAUe9FczXjZGZAwhNQdUPadSWaFWNLjS0LYuG24SdFxd7iAV/ZdowkehF2jm3AcNv3FvMiOkLD8FWTPzWP41XAm3ZiXRiTsWXgtFQNzR253Sv1TGKNLRo0oU8GWj3oON7hjzg6Qkv3zGEBP/xDWceoGxZINLjFLaS4xSyfiqwmdj8FrCyVNmBplM0LusCuuUR/X+AJDTjrgFbaAl3PUYNE4WLrnLPqH0MCMvmzeYu8L50VsigACNEzlfV/Tc4Oje5gIKqK6wkgr1T2zYPmSuRbvuwmdKecbzT+M8fKS2YSgffCZG1GZPKnzQotgQ2h5jzfFo7R+T9+z7eiRv1GvTU6JkpJ8jM0+UqE1kdhaHLChJ/comggRM2yHYyEFojXwk0qHwheGIWbGsiErQNcrSjlqy4ckiIbbaY9tAkqvx0p4uucwe2PICSOkvD6behpBXamwiwm48ngs677UoHYlXyulUg57Vek/yMLmt3Wh1s45KaITrjhQLujhjaLVFh7jioR2M7MBNe1kC7bexu63+ehXYMQTtifFsF+gDzD39B2+h5Dxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EEuoqY4fD9oOrqWL8XbIbFd8b5WE8i2YG/KjYIyktVGImHF7sTwcmTMukuuG?=
 =?us-ascii?Q?OyUbikNyBUf6Rdhl3I9OwJ80Dlx7DphTPyJfgBBAMK3EmJnEjq9uVwtYmIx4?=
 =?us-ascii?Q?Oa2M7vFypyYSVJ7MTL/pUwztX5qyRmx37c1MHKID3vPM85yrV6jANdpqVAZE?=
 =?us-ascii?Q?aVb+2/9X473ryxVyY6hLwgZVodBt3LOW9VFV71JGbXZE6sHvE++oHN2t4P33?=
 =?us-ascii?Q?tI+NCD3ceG6LhFy1dRzVo5jZQv9f8GdK9SDDcI/NY9fhX9g98+mgdLqUus4m?=
 =?us-ascii?Q?REhtYef9aaNkOi5fd+GLb4yWcdq6CeErwN0cvWdaTMgJsKvTL2EQK/PlKnku?=
 =?us-ascii?Q?/pAuIGZNJwQUCPHMDFfQRirmSdSnj7gZZHAmHE1o+LftfxBicaEcHEzUrbjH?=
 =?us-ascii?Q?hCZEHpKyUN0VJhhPwwotCAUialVc895wWuBrkrl0rPBFe4ZIBWps4IQW5HoD?=
 =?us-ascii?Q?pF7Ayz0QmTlRpDPsV3m4JOAzak9uaimjTQTHwbB+mTLxBk3JOZPW9ocC282o?=
 =?us-ascii?Q?tLhsY9+CbAP7ViNFxJW1sSOLVwc/oZ8cCSX1G2gHqz/yv5UAmLpCTu/Ucn6M?=
 =?us-ascii?Q?EUTPCps0g9Sh4dV7QjQcA0CxyGoOjhyEAiyG42qQhE2gAmmLhNR2NT8lCITU?=
 =?us-ascii?Q?3y4Z/YI6drt8tkgJpXKBOsFcfR0s4/S4FaeXs9Fenuz5K69rVvL0XtJH/GPF?=
 =?us-ascii?Q?299IlzEJcUxVy9udR+4zO1bg3yAApU77d9PTRPf/kXH8phhwBpoEW7pq3jVy?=
 =?us-ascii?Q?B5RrpIzgbDBNVzduN2Ngd845UAGjGxKmK8t00f/u4HIzpfLvGe/jjV+iv8+9?=
 =?us-ascii?Q?WhyeCnbtyNv2Xk3ey2tFHSSZdVVGu5PGc35lCAnkkEMHjXIDFkVgSv1zW8pg?=
 =?us-ascii?Q?xBBNJli6/0gOZU0qoteDPofAglXz2Q8Ff3iJVg9xeSNoHCxCr94DVM4Ex5SU?=
 =?us-ascii?Q?r+aCU1qcphOehflqi6mzI+ZhBfTi94KDzLgGhZ3LPOH6VdRABsg6n2bPvnky?=
 =?us-ascii?Q?8YMAsKJt8SJgK3jFGNiwn0bSmi2L8s83KsW/R9V00QXhY5W97572TtP86mcy?=
 =?us-ascii?Q?tvUnSnEr7XrxBYWhtqcOYP5z+H0gsQfzhKnlayzhyboE9ley9D9AOaPEWJ7K?=
 =?us-ascii?Q?YBwXDti0qyKIPkafwzjQ/JG0oSWDB4QmiRHTuXgqW1z9Q23JJot2UDBCA+sM?=
 =?us-ascii?Q?dMXs9dBeY0kq9Z1HHdpZXWa9/VGGjOR5BqCXTdEG5GiQ34qky9UVWUUYmlio?=
 =?us-ascii?Q?915cHFxbF2emxlNw8qaic4shyWJLdcSs1RiIaa6Ro0jJg+bRgdi1GjNUx7xq?=
 =?us-ascii?Q?0eo/twYlpOZ95VNPbtOW1kGz+9H9mMq8QnzyLOE2uRalVUZH8e/ZaOE9m+CH?=
 =?us-ascii?Q?uzyliEDlmUNRH1NytevQJL1h1JLAIJYrsY2Z71xc5mWMDS/3ZxlXBQ629YbD?=
 =?us-ascii?Q?/ljgyxbZHHqpTmCqPow4EU1XbMmDIZZTDAEn730jx6GicbuCb1bpaKu85kIZ?=
 =?us-ascii?Q?z9vmSmwuUz4U8VZZRosS3jHECTccJ9Dgl0w3ADx8yGq+3BGzF6uQWa8MtG2L?=
 =?us-ascii?Q?HNYiQlDun+U3a/9qDySFZtzEnOV0mU5hFyR/8EEd81+pZRtPeNwooGEo1UUw?=
 =?us-ascii?Q?cZ3WCraY9mthA/xy+4HUyzteXyZDjHtQawrC8fpfi5FiEYvDKk7MVJUmSTjN?=
 =?us-ascii?Q?QWKNr8VjToVM+cWlaQbUmhcpjrTzLX3sgVQG0UJK5S2mg9+OxVxHlDYkzUUK?=
 =?us-ascii?Q?2ok3bBs1CgQVPj92/rXXuGOunt28C1o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffb7f12-8c81-48d4-b2cc-08defeafc9e1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:09.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvIpe/oHqlYzICPIq8cTgghjTvcVWuT9ks/988Ad5fqff0BKID/9k+DGjDLFWZcpBeJ4NX+FvNAd8J8dEVQqb3rIchC9xncPbTe/SnpHGL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB975321
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on failure:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
    fails after pre_save released it and the source VM is resumed.

  - .set_status() refuses to start a device whose handoff hasn't
    completed: not fully initialized yet, or left ownerless after a
    failed CPR.

With the handoff in place, lift the CPR blocker: only ID-less devices,
which can't preserve their FDs, remain blocked.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |   5 +-
 2 files changed, 152 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index cec2c31f0ca..e25e5350905 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
+    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  On source the device is left without an owner if a
+     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
+     * rather than issue vhost ioctls on a half-initialised or ownerless
+     * device.
+     */
+    if (should_start && (!initialized || vsock->owner_reset)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
@@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+/*
+ * Re-acquire device ownership if a CPR migration that released it (in
+ * vhost_vsock_pre_save()) failed and the source VM is about to resume.
+ * This runs before vm_start(), so the device is owned again before it is
+ * restarted.
+ */
+static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
+    int ret;
+
+    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
+        ret = vhost_dev_set_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
+        } else {
+            vsock->owner_reset = false;
+        }
+    }
+
+    return 0;
+}
+
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL)) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(proxy->id, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %d", ret);
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
+     * With the ownership handoff in place CPR migration is now supported.
+     * Having a unique ID is mandatory for FD preservation during it, thus
+     * we only keep the migration blocker for the ID-less case.
      */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
+    if (!proxy->id) {
+        error_setg(&vsock->migration_blocker,
+                   "vhost-vsock: device ID is required for CPR migration");
+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                      BIT(MIG_MODE_CPR_TRANSFER) |
+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+            return;
+        }
     }
 
-    if (cpr_is_incoming()) {
+    /*
+     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
+     * then fails.
+     */
+    migration_add_notifier_modes(&vsock->cpr_notifier,
+                                 vhost_vsock_cpr_notifier,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
+
+    if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU. */
         if (!proxy->id) {
             error_setg(errp, "vhost-vsock: device ID is required for "
@@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -233,6 +362,7 @@ err_vhost_dev:
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
 }
 
@@ -249,6 +379,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     if (proxy->id) {
         cpr_delete_fd(proxy->id, 0);
     }
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6d0cff4fb93 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -15,6 +15,7 @@
 #define QEMU_VHOST_VSOCK_H
 
 #include "hw/virtio/vhost-vsock-common.h"
+#include "qemu/notify.h"
 #include "qom/object.h"
 
 #define TYPE_VHOST_VSOCK "vhost-vsock-device"
@@ -29,7 +30,9 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    Error *migration_blocker;   /* set when the device has no ID */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
+    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
 
     /*< public >*/
 };
-- 
2.47.1


