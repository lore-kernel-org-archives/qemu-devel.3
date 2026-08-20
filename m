Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3616C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx188-00018t-05; Thu, 20 Aug 2026 07:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx185-00017c-Bd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:17 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx182-0002G4-MS
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9GT65aKcTPimSFurMG6lCI/N+Z+GaBgkbQBYxxmC2+F4k9ZJN6knyH25eCgcss/f718JKgx4ShZagDdS0FrGc6IZrKCMbVMPbDaftekPG5s7+uWe1oD1s7+nN0Af4RNMd8EGYlZn69nysZvWmIYtYaW4rCESaXfR5FVtSpSLxfUXqZSsYoYIh6ifaD58m8dx2eEHczYSOnZnXsdb/ebu1PIlO/YcooQ4rX3jyUrGckdSwf0ELFu3HNUP2NaCMuE4R2infHUiziiTPC7Sda0aOXqZRJJozbyGVOJlKa5eLCsDh3PuNF05DS06Zeru+Bh/lYAEY7L3rS3U7mI+H10UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npRP9gTgJjV9KV93DFJ3LdmwFuvgUWpk6hh4lgfcpQ0=;
 b=azjbR4lbeYgjnfUkbof3SmoTR2bTNYTZC20iVa72owRiAIK59eRW3sHWfOvnbnM1di02dmnakj3xeWkl7+PdV16hJEIRih4U5p8rA/a70YPmmpqdl251Z3+FYmtx6lRNrcjj3lcWcHFWRWoGE69Tg3Q9keW06Eak12iqBj6l7yy9hoc/Oxi7kFIHL1TXsM9Lg4PCSG0NGD7zS3m1NAgZmJEzRCMLQbdX3OzULO5lrYDhN5BG09ZzscgTvuVHMIgJOfzu/DOlg6A6SR2n61nvyYpEFIBD0p9rxx/adHmDdMqhwh+8cFsbQtQbSt3gR8wLJebt8KtUK33GUX2+x4KLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npRP9gTgJjV9KV93DFJ3LdmwFuvgUWpk6hh4lgfcpQ0=;
 b=Y6FGx18UMpK9E1C1f3B6UUT7DSyDtJa0IERwLSMdBN7Tmit1d/4WokYEeoArZyYhmzvGp+fsk/JpTLunDUDXzM3NPsunvCd4M7zStzb7LzY19ZD4vzcSY+Osg8tJo7nBU0n9/tWemN21Vscl6UeSB/tRyPYLe7+H3Rwbq8GoU8RN7bPZpuH7fLEssAtrOwaS3aF0rFgaHZPaGmvqmdzm6rSEGNn0QvNxYiSejN+iJyfPpttDkFrV7tEhr57JFxN33rBMlIuWg2iyAwrPXzdY0OnS2qT+82qZK8t/oFZV25Ro+530bbYg07Dg2dUiP8KejulE4vUYBuu2hTFFGikTGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8413.eurprd08.prod.outlook.com
 (2603:10a6:150:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 02/10] vhost: add vhost_reset_owner op
Date: Thu, 20 Aug 2026 14:39:47 +0300
Message-ID: <20260820113955.509478-3-andrey.drobyshev@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 01235e91-7317-47fd-da9e-08defeafc6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: He/MEXkLfMq90R6id01AwXb4aPbd8NncdL6cCvB0sQWCuvMYpWbJ629wVPGcS8dym+P3TdU7KSil94pGsouqACb64Zdk9hCMW6VA3rupaveSNWF6oXhHQbLBEHFdRqp9AJiJOA6nu+qVIL281A0TgSRDwldHFHD4X+/UIZ1DUCUPyc92nFOHmiUkobbTuCnh7N4qxHRAwNYbowOdkt6HJ3keQYx2h8X3r2TLk3hmfMdGVWLqbgCvOqjCyAdyl8EW1oZoV7OnBnmEj/kE1NGyobLZaQAENgiKNutkGWRiT8jPCV12ap/ZW6kOag5NU0RPU3OGaYRVQ74lAixBlVN84UW/qfaJZs2oPbaf672iV5S0gV4hzhV1xKAKjtOZAW0iCgD/UBNhheTRNTQ2ZV9wpTobacp9KqqWN/zlrf6QUKWHWuOBI2sHDwOjb7q1bhF4zpKILqoDAw9qAmK0tnPV6MQplXd4evNOM762Oi3Fknbh3q7XxxE/8m7ZPfJqzoVGTMZRYLmDStSsF7yW/h8zdZD26UUeVNbwOSlyn+ieYoxGvheZDaV/odipvP3o7+xMQuXGQExY/CYs1h03uhS7XRccgNrb8VoUYrwAOAy+KwRI82N+/mH36N5xucrElHdsxe0s9bG7JWss6iZ5e5YFoY+/rrGd2SgYvDT1S3oK/L+RSXK8z4dGAlu+scwJSlB5fgvxf449YTekw745xH7Nqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LsjB2r9+NH60+6yjiZTQ0GNbAg4wpWZbLutSinJnHcOJOH8sxDNmnlAoRq0?=
 =?us-ascii?Q?fSzWTtatUxxZZVwM0jn6733xCKWaLIHmY8pYgq1AiDaFSw6NRNYLZTqiXQ3R?=
 =?us-ascii?Q?sKCXVZoN11Teco1Z5/iSoR7klYBgatiOCnJ3PX1uxdIyLWvVrZFcqfAm8AzG?=
 =?us-ascii?Q?rMcoa27u5eVzlaAct3adi1WGi1AbIgsCdKpcKWhffCWyXlRM4IkBBX/nAolG?=
 =?us-ascii?Q?IT9VARipfSYRoBVY048BjDSMj1BxpSBJHJCjoIFWqqalEqPG0Am0jdxm5Lrk?=
 =?us-ascii?Q?5oR8AoG+5HJKgdtRi/g3E5qt8jXyXADu3i1fcv/9HmitJlj5I61YLr9YLF/R?=
 =?us-ascii?Q?9I31wT3aSWxH4529dG5bmZ/LB68AwHSzvg4xVXR+s2tL8GVs11iZKlP7IdLL?=
 =?us-ascii?Q?B3ZXPWNzv+NJflhGSE2U3M2Q2joZAhUU7kG8r4hkP/LNwmLC/s0tZ1Iwug3L?=
 =?us-ascii?Q?P5NYjlHxL5FUMDEF5kZzy/q7ZYyMeICJGeMldp060sck3vF/bL+blWoDWBj4?=
 =?us-ascii?Q?ORz87BipVEPsv1XGGDu9HF7Fd9dsD7huJbNV12TlR14bkvPf9n9xKJs5Hzor?=
 =?us-ascii?Q?FS4z1Mh8SmP7GGaS+Z4Ga6L4a2G42oEdLKU39dDN+vDASvcb0stp8Cq3ciFS?=
 =?us-ascii?Q?FnZKdHPyt2lqVyrmSo51DQZnNw4YzvCnzbrYsSXoVuPMNsYeEhXqgI8olvjr?=
 =?us-ascii?Q?pvMGdZ4zctYU4TYkrNvg2qOv5wI3z/KCxu/XYxgvYmcHpr+mmQ0ttuP/E4vM?=
 =?us-ascii?Q?MFw9uQKL+KZvgy1WGv1eDgY3ly/cY/FaKX/DN+w+4gqHz3nq2TQpU5VHdcG4?=
 =?us-ascii?Q?Ra5z6wCLIHkRq+93sBaijnv3q9j47AIg0Ue3b773q4ufnG2Md4GemCg3O1Wc?=
 =?us-ascii?Q?qbASMNRes81IyImpPr/PyTJPc7QBH4/GZDRoUSqYVi3qbrGg7laPajGb0PsA?=
 =?us-ascii?Q?FUTKG5CmxD7vjSR1mswAcySBR8v4n1R28K+S42nWVVmwzzu8mPLxFnNJw+nI?=
 =?us-ascii?Q?oi44prWfhZj94anPQoNMSSe2NDJowo2K/jXd0gs9f34BAkZ0p4l7ouyW4RvH?=
 =?us-ascii?Q?STltew806jooWYflZblrNgDYd0jywzRkUuDkErWyZgRLIWn4JazCl4JYXCpy?=
 =?us-ascii?Q?XNDG5YA1Dqw0gPNkpU4KZcrxY5lDGIMYqa9oYE8P/QCa0Y9oI/eSFi0nt85h?=
 =?us-ascii?Q?1EzM/hWeCCLfcqzY+6Gwskxk+la4xRjtQgq/lfGUHOVDOZuFgS8YaFCcIRz6?=
 =?us-ascii?Q?oVgaji6w5OBuDKh7w07TR4cluSvUnHtDWN0LsceQFr15MblipQ8F+m1KdOn3?=
 =?us-ascii?Q?EfXe75gXuIWPtD+aqiVgc9URDsb1PgO8fxA6RDdd3AtBBcfdXU3w4K6Ff/dF?=
 =?us-ascii?Q?00HogP0kwOVLgoBErpTgsczR7jFUzTgogVGTU7Y86H+tyIjhqjFIsrLNOy/5?=
 =?us-ascii?Q?31gorFDjJtMhFaM8G/Kn0Q6wfw8PQWZwFYbrZTkXusUJani3ka6ttpzK5dWk?=
 =?us-ascii?Q?L1aOucyv+ZGD+sCXs7bYqN5EzRvT3g8FP032J87S/e4OgeMU5vbn16ReGFQJ?=
 =?us-ascii?Q?IdInpQSur78fqD+sgo6dYxTXGRvwZWHrksauM0xR7KMvmv+HUnCILuLJ90cH?=
 =?us-ascii?Q?sL5poX/7XqUwjUdfVgGWOT/Efvro+gs5Y4A59H+Jwj7gLlzHsteG7mXsgWTP?=
 =?us-ascii?Q?LvlgMPjVCN/iag/R1kV6nfCuKYFIDpO8mntR+H9BuYfkZ6WMztwnx+tfuiQ1?=
 =?us-ascii?Q?Gu/f6T9nFfIUj28phVlUmF87vetadm4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01235e91-7317-47fd-da9e-08defeafc6ea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:04.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZAO7EiGuvExD2g0xqr5yU7oYWp8RD7YFGTVjK6xo+lwhA2xrI2zXNI3P4ySbG7ptPK5r7ANX5Ox6Bb/EaPK34de8rUq9Th0LiZ4NnvnSfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8413
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d878d7b733a..6c949e6a38d 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -204,6 +204,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
-- 
2.47.1


