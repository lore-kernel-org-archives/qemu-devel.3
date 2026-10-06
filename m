Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2AACA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrw-0006SO-Rf; Wed, 07 Oct 2026 04:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHLA-0003L3-GO
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:25:22 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHKw-0008Mk-AX
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:24:59 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by GVXPR08MB11009.eurprd08.prod.outlook.com
 (2603:10a6:150:1fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Wed, 7 Oct 2026
 01:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP4HhXaI42OfR4XCo20p2rLPKNG8DgNlaTHSRBMPzy2uiYWsN/D5QDHmQkMWfEIEJd/ohICh7VelWVlse2J3Wtc24f9rqIsIYkkHnemvGmX2zszE05XvMU4LK83gQnNB1nFDw88R1NUYESNhM5TI3fA5r8Gtw3Q/9H+nHPiAV6XvK5XHcSeS8bCgWTBH+AUK9n4ea5U/HWz2Gyju7yJs0vK5nKqvoLzxKAGeCOK10jjJPxU90XM11pIZKWNfTDdlmPJBcvDNIBVKNHNHDNJlX4Nz2L577XM9taT9GGsyycZ6FtgiXqUleG3ctnffoGA64gaObnLlx6Xl+DwPJeIGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=tZyvoDdG/SdP7+eLAIzd5npc3h8kehne3qghSZb2ufEygRJXgav3w2xukIZ+HDOBoCvKreEk5GZdpF5s8+tNtZtRJxPhnGK8xju/Mbc1v+Pg1z7y5z1RYGV7REXL/YkR7xAPaJjiNRDjs4CtivKHbCO/KKBBTNN75HMXLgEK1uOWUCUCJwyImb/e9XJjR+DEdoaS27tSJc5dJJwMXruxe3fMuetR2xGrnefxgnZsh1K625ik3ajg4JVD97DBAO7WmrtZ9IiAxZIMpISTr/vXIBu9/S0T6SjuOgwZvS3Mhqqfos05gweeNRROR3aYoSM7wrOqgSmQndZtufcDK4LZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=AAjYjgjbIb++GJlmlgfSnQtHaptljEeaSqvFZvMEqYmKD/VBSBhjOHuvbWmlJp2sJ4SMSgSWQUvuSQ/LuAvVk5GKrwlPghZ0u4VApfQqIBXxA5jOEb+LXg0I6HM3f+f3QqxAWaWq+wDIfslz+szkqVh7AdYWHJ9tZwO+biCGWeBUdhN0SNZGqPMO+G94JxDX7fXyTpT04v6g+rOgNmEcj7a82B2UratDL4vjGiYqdYRZpvzEwp8pQa2ghKc39LpkeIpjpTaQ0o0QZntAIujucjF6eVH4rECi/kfHCL4kQzyWSGRk2v0HNYIRNtIcbddO5f3NxZ1Roi7v8FBpeJ1M8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:58 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:38 +0300
Subject: [PATCH v13 15/22] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-15-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|GVXPR08MB11009:EE_
X-MS-Office365-Filtering-Correlation-Id: 47499732-d62d-42b3-6b15-08df23b1f7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SASmZW3OOwqOYJuxkMOsEZKuAeDDW1x8/goalgaQTpx5TgXMcqflNnq4B26OUZVKp2+gKM/XmRww2ZWgXO4Br3VaWKvummtD3FhVXZHWhDjmAI3fZl9vdXNGccSnMYqdFIFZNwOOdyhAeX75QwDnY03c/0cp10Fagh6a8qsar0PMUugFDq4xogDNdi1i44AiPwhXr/rAdw0XnZLpFapxJ9XMin0UOzLJWAIzIHbxe4NjDMgRcvdpIlUO1StCKF+Q50k2vKK+cejnzGTRGLVXhEAkewwOOpIGEEROwaTb2QVulbEnVAlEBCNfmeVPvdH1R9YGEL/lfwC6YaM54QpXLTrcD0/zT/YTCsi4q8Pnjzyu0gcR8Z/4o15RHGISU23bb1TbAcsduB7SJlLCNYGYJPPmYX7VihIWTM3Mtc1BjsuNPxuTQOy+3Dv/8W46g1+hRG0VH0WOQoH/0yDB5cf/607Mx5acCHGnh+LSQ+Tpv2xnGSh/p1oteGTlhILp4ZBde0Z4RHtBSOTEnqFADHsjji2WL2KASj+cSp4//X7GwKnE271EXf0yGgj7YNVhuGexvkFbK69VtdO28z8R6TIFIUGutsKj9zzUPDGX8RljxowRV2Jr4/p5eXqG9BqdEEruwOl5VN9UMCD7KBzrIUBtjTYG4xzjsMAGYz0ExL7/zNI5muW5QVREV6Bu/JfMthGvLUkMByH945KGqH2ssdlyyE1WtRYUPzgzuex3MOnmKPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RkVlcydUlrdFVxbWM2SU02Qm55QkZkeXBMM3RsT2tobzN6RWRmKzVERmlM?=
 =?utf-8?B?b3NuZTQrYy9QYjZyYldEUUlrUzkvckI1ZmJQdmFUM1J0dzFLYTQxSEFzR3ZU?=
 =?utf-8?B?UWdWY3BSdndQS05tQ0M0dVFTQTJHd0VPUmpDTUl6S3lEdlBsU2hGdlpJbmlv?=
 =?utf-8?B?SVA4M3laaTluQkJ6SHNxZkFiallxVkYvNEsrVU1YTFg1YUx1TjZKSDVJMU9o?=
 =?utf-8?B?QVdiclp2aDZqSjdsbWVYU1FRRTVCRmY4SDN3S1pxZzUwWnk3VGRFTXVWa3I5?=
 =?utf-8?B?MnhUVlFzWTB2U3ZuR2QreVBxK1RiUmtCU3I1Q1BNbk9Dc2dIMnBPRnVFV09k?=
 =?utf-8?B?eE9VNnh6Zk5qWVhvVXlXcVFKWFNEWjYvNGI3NXRsUmp0Zyt1eXBXS25KSTh0?=
 =?utf-8?B?c3lUaGV2djRxaDJvL0V3dVJFckd4WFgzM0FZaStyY2RoMTNnd3U3bU8yellD?=
 =?utf-8?B?aE1wSDQvMC9kYWtjKzZYcVE0SE53ejJqWVpBNUtFRjZOamVseXdtam1pZE5l?=
 =?utf-8?B?VUNodHpYMHFHWTEvb3k4Z2pUNnBtRlhoZ3J0b0NnTnZHTytKSG11Q1Z2akVs?=
 =?utf-8?B?U24yQ1pKU0hHMjluUDZxVm4yL3NoSis4NkFmY3dRVk1YL2Izakdqem1sa0Jj?=
 =?utf-8?B?N0srMlVVT21PbSt4WHpTd1A5SEZPNmxVM05DbURZbEYwRHJDV0xKRjBHd0dr?=
 =?utf-8?B?NkUrcisya2xtbEFkbWNjOXA0NHh6d1VieHUwM2kxMCtqZFNUNThyK0NTdVpU?=
 =?utf-8?B?YWE1Q0ROU1ZQdUhHYjVVbWZUWlA4dUxiV2ZBSGZaWU1Pc2MrcCtpakJvL2l6?=
 =?utf-8?B?Nk5XWUQwa0k2d1M3K0dyc3k3T2ZyVlVIT2lQMldVMi80SFNybmhpR3JGRmpz?=
 =?utf-8?B?aElpODhXKzA5UlQxWEJybzBsaHk2b0VLM2V4aGtmeklZTjdsZTQyVDQwdDEv?=
 =?utf-8?B?TUE1NnJXUVFDaWhlSGozUmtqM25SN3ViOWcrNmNIYThFcGFRV2p3enkvNm4z?=
 =?utf-8?B?REEvSWlpdmtqZ2d0WUk5ZTIxREg1bmo2WjdhbisrZ1dkWHJFVS9iMHpGZC96?=
 =?utf-8?B?c1Z2YldvbVI1bHh1R0tlUUZDQWVORXZ0V2trU3RndUxEcUxiMUNSRDh6MGUv?=
 =?utf-8?B?bGNVOUlta3lnYVhVS3V0MmdWeFI4emtPTlRsUGpjOCtYT1B4NjZ2ZXdTS1kw?=
 =?utf-8?B?YXA3cThpV0U0SVRubWV4c25LRWdQN2p5anczeWFKZm1ONmE1bWRWVmh3bGJp?=
 =?utf-8?B?QzRKblYvWXBEUWFwUTlKb2cyMU12NzZQZ3N0Yi9zUno5TkFrSHR4UmY4bm1n?=
 =?utf-8?B?ZDhVRzZEanFhWXhXQmVrWjMwUHdkemtiaERnYzBYOVI0clY4RXg4L1NmSnlX?=
 =?utf-8?B?bkgrVHBGQVJoSGp4S2w2eVNtTWZ0ZEVtNHZJMllNK0pDM1B0MGtSVGZOZ1Vi?=
 =?utf-8?B?b1ZXSnhNUmFYYlpGdHBmUU00NStzRXJzdEYwWG9MOEEwWVNNMW1mNmpGQmdH?=
 =?utf-8?B?aDJ4b1NsS3dzTDZncFNqaVpFL3lUUWVwcmhpVUNncWdBYll3WWtnT1hKWnBI?=
 =?utf-8?B?eExwWjhRL2tjbnQ3eU0wclV3U3FId0ViZzZIeU5DSmt0ZktIQWo5R2FTS25D?=
 =?utf-8?B?MXZtem9xL1lKT0U3ZXNYKzdBSFBFc28zZG10WGFUTHk5UVZOQkNoT1c1dFdo?=
 =?utf-8?B?L2NsVi9qZnhuVVVhdDhGTWFIR1lvZWRlOUJaL2FybmhtZ293VmxOb0xRWDc3?=
 =?utf-8?B?ZFV3dkFIR21tdmppN2RlbnhJcjV5ZkcvMFZrSkJNY0tkR09FQkNtcTRXbFF3?=
 =?utf-8?B?blF5RVRBVVZ4V1A5dEVVT0VnemhpVWVyWTlrbmU5R3RMSUU2enBPR0picHVY?=
 =?utf-8?B?Nko1QTVXNEhNcUNkRldjVjVseVBhbWoyNC9USGlBZXFGbDNESnJvbFNaL21t?=
 =?utf-8?B?cGZxNlpMM2xrN0pBMXVuOVRCeDRMMUtrS3RzMXR0NVNWVnZUWm1sbW1MR01x?=
 =?utf-8?B?MEZOaDVGdUovMzlUZEFTL3NLdHkrSmwrcm9RYkxiVlF4SFNIaG15QWRFbnZY?=
 =?utf-8?B?TVQ4UExETlFhVlltdHdlVkpEanRrVGwyVHY2WExaM0Y1S1pJWitNWHZ4UEZm?=
 =?utf-8?B?SjF1QTJmYmdsdHhMZG5WeXhIQ1BUeVQrVXUxbFNJOW9sRUFKd3U5eEU3bUY3?=
 =?utf-8?B?dDdDQjBrWVdZZTJUQ2VPWVRDcTA4bytzN3lRcmovdUlkR01xL1hqclVkNGEv?=
 =?utf-8?B?MVEvbzEwamRqNUViTGdRVTNsMjBmZUtnTVhQcngwZnJDV3N1elFTWG1HM0My?=
 =?utf-8?B?ZStDaUtMc2pRZ0d5R3JaT21LSzU1MEs4NjJ3VElJazFnM1JtRkQwQmJScnNv?=
 =?utf-8?Q?DVKRGZUawD6201wA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47499732-d62d-42b3-6b15-08df23b1f7ee
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:58.6792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2/8rE/f7Z3yshbsUbVLwt4BMonjHQgYVgWCWr4vAI4RBEnnYinurzZE+390mzNAYzQVFL0iAHJzd3wGQ5byiuB0d8Z4NZ/AzRurZsxeYis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
teardown for all those paths.  That should be safe in any case: the kernel
refuses it from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++--
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..1241c5a954d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1876,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        if (hdev->owner) {
+            vhost_dev_reset_owner(hdev);
+        }
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..f6e32b59ab2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,11 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


