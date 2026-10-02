Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B922CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwj-0002r2-Ce; Fri, 02 Oct 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuL-0000ow-Hs
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:38 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuJ-0007Qg-OU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRR7CalX6a5AcnL1EouBG87u08uElbPvrGM3FCXyTP+g8tiDhqOy+PSv6tQyi+WtfUvbMh/9itaze6ARMosaMHUmCyXx4UZ0cSpWUG1w9Mox0YdW7108CrXOjR2fQ0JosallrfSgShdfpG0w5QxXP5Zt0TKxEXA443TzbBzsoB0tsGJpUIgz9RNegsQI80ByJqAfmMYqJrwrnex4yGDlNNflgvLY05ecmLdPvtp87y7yNUsUL38Cx3PY1+0nCwRw4qNtWtHfoDo9d1CUaoLtbRawU7d9nC3mtS3T8mmtaJB0mTA+9vnQtWvlaLDVjWBfowvYMmcDuI6tfWUVqyMLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=CFmnnfSgJ97FGYcLUvzKTh2obSStE/36OG6DZ17UEHOcw4KVjfgryewmFhUNGHO4CyH2T5tLQLoQ3UzjA3qyY4dnzYfWHEHJloF6DmsAW2By43zCIgJzCc/MPsPKKrStzL+w1W7epLJRdQMFVdGU9mzSRwGuz/Cvz7LIj4GoYoM+0gYsOXhBpgLT+GaQLFMWOCo2iRE3H3BiLmxkzfVy7t5IQnXnm/fNjv2DWGdLv+7rPvujQJBgF47uU3Gl1ZuhMI0RGCkLcE/P08qrZ+gRofM9ZjzLJP8HSQ0wZGuvo2w5dc08u/4ajJv4SAasnPfrTLYE323pRsQnYUY/SUKe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=laocEPxawPNVUYerhqSQZ/FG/3cXRhr/pgI95G7KQLjzoenfCRlj1jyXmpNVMtLgHuteJolWSTvwD+jp4Xq8/+1NBiK/y0g7BV4CYYZHdr9SbTIF8aRujcU36so2pMqIvmOyuWDvu4+giNpzFApeChKd6oA+E18kb+TRu0aD7qZ7i1NP/j++9VZL140jIHGPGZirqOhSLSq8cWuE8HtWoWEibMCDm39cmcge0qcIxzJATcNlyxdq52Dda3ez5XD4ecQD13ztmmz4vKhU8Q0fblgCwOelCU5afSG7HC/TONuVpNn3F+9eNlj956+kLONdCOtxbxiloIqjYot5LkbUiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:15 +0300
Subject: [PATCH v11 06/19] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-6-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e7724b-53e2-4192-07de-08df20856711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4LGWMSxsc4Ik3d6qFxnh9oSeX/7JAa2o5pEgszAMzusZ2oX7jVBuSbW3yzi5R6HjjqKTAe0aBRLmZ458E65dUtxesGH8k3nAfwXuYq66hkNq6LwTajErWM4tR/5SekebMwoQMzxHD0qwK9/dNQEMNosed3097gR26N+nc9XEcKo3QqIgPcHEq1LbpgqcKYwsx78a9E6K+MMzfcpNkQq7oNXkbPBuqT9fGHVyc+yUHO65zO8CwIpqVurcXXOyjljHlyYBH87jzyuzA2co/hwsX6k0LiSl2fYu5BjWZC3U1FhEybBKf/VVq/+1kuGgAnosWZcFjPw5vYWu2Hl6ityaJnHCF6pg26ZFNyIYEJJ1UfEN9hdg/9suLmrwhyAq3U67EbACVMYN2xSzfgaavaUbRdd/Oxd+3bS1eEm6ICKfxGHk0cYHKuOK12u1AXWaCjlh3vgMSHUqn5SRxqBXV1Dd1mh9GkuqRFmO70QMTvLQ3RkoF9H8AWOVhBeoYKKzOKpdCzMfRLhYAkSYDcEQ58kKsHQCWWSSdrmQbQQK7sEGhxToxDt41lQbp9Pgpv98Hpz9xBQ5840zJFO+eKWLsUhl7E4o0bug9Q048+FHjdZ+cfSMqJkIRWuogyEuQ17TkxGYlSFuJe3h9o47H4r3s3bHj1OD4KJTErZcBgUMHE2YV6AJNVl5Tn0Gqd6xlhti3gaAFS02Sz8wAYu7iHE4U47XKI8IOSPczuTVfgwOjC/svLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RpSWt0S2JsbkhIdFUzdG9jOUIyTm9VV0NldUlKWWtVREdZbzBBbHRLNlh1?=
 =?utf-8?B?VnU1UlFPU1ZmYkVPMGd4ZzhLS3lMWjE4T29OV3BEanoyb1ZaVTlqdWxWZDJ0?=
 =?utf-8?B?Rm1GemR2Q0xWNHpmUWI0SkwxZkNlVGxSeHNYaDFPU3hORjhJUC8xdzFPcGU0?=
 =?utf-8?B?aHh4UWRYMmczN0YvUG9rOXpKRjlaK1FTZ3liektzS0doWWxwNzQ4TlBSaXNu?=
 =?utf-8?B?cGZZbWlFRC95WEQzNThJakQ5Q2ZxWTdtMmxCeVR0VVkvdGNBbnBLZTArTGpv?=
 =?utf-8?B?aUJDTWRmODRKNWFBcFVSRVphcTNGbzBNaWJlUmZLbTRIeEEySUZTMjB2Q1pP?=
 =?utf-8?B?OWxiYUIyRzl0Uk9UV0c1RjA4MHJHNktBNU9MVmE1Z1ZXd2hqejlqNUw5SHh1?=
 =?utf-8?B?akxZOElNZnNIQ29KeHRCa0NUaXBKc1J6WERjbTJFUzlGNVdwajdhbkxIOC9j?=
 =?utf-8?B?MjdpYzlMYnhiVGNHQ2IwMjFFUEN4Ny9EK2RTVy92MytKZWtCaC9TZWxWZGVm?=
 =?utf-8?B?eERObEdXRGRQT210Zjc1UEJiZ2hVNlV1RDdHd1RnY04wYlJjRDVlTGxVdGFv?=
 =?utf-8?B?WW52TmZESDVZbHlNYXdjTkh4YlhqY1RhbS9EendtODdMOTJQMXVjSWZKbThv?=
 =?utf-8?B?TGNQamxNNEhjQWFqaFEzSzNZdmQ1WGd3N1l6UkIySnlIaEFKZmhmNUszUkdV?=
 =?utf-8?B?SW1KSXo0YmVEeHNmQkRHYW95c1RPZkoyUkJ0NUpNNUJ5dU0vblgwQTNvL0Rh?=
 =?utf-8?B?ZXlQeFBwNElvRWtXR2doSU4zak5lQnBnQjhOUENuZkZWRllZNHhPbXlPVlh0?=
 =?utf-8?B?WWs5NEJrT25PYk9KS2NZWFB5MFI1RWdlRnQ4T2dWeTR2cENJR2tkUUZxdXJ0?=
 =?utf-8?B?Tm9abVdhL2RER0NadFJ0QnFMWEx4RjFrS1lLRW4vM1RUTTFFcGNYTlplSm9q?=
 =?utf-8?B?OXBMdm90UGUzSjNzaFFHbXFVNEpMV2l2UFBBZEJRRlhiWkpzY3NRVDBVRXpU?=
 =?utf-8?B?cUp2VUIyTDBsQTF3b041Qi9xK1I3dzFxcWQyWVhLV0FXWlFNL1pBUlJSR3Za?=
 =?utf-8?B?dTFVcko4Q3dsYjZkaUZpNjIrQnFpbHNBV0tRaVk2U1ptSm0xVEhqMFlFVnc3?=
 =?utf-8?B?RllPNXJpTFFKQ0Exck5ES1pXR0xqeVF3VmxTSHRJWUYxMENvaU94SDd0VXFG?=
 =?utf-8?B?aGRIUVZFMXJJbE1tbHE4ZTgyK3JTciszZldiWGR3emk3dXF6Y1hwRm5PZzlT?=
 =?utf-8?B?UDdWSVh2Um13Q01uR2pDWlR2ZG9BeUN0WDA5N2Zla054RFZhYTdybFFIRVUx?=
 =?utf-8?B?RE5PNE94WWtOZk05RlNhd05BRmMxbnZjK3VIVXlHL3ROeWFkRUo0VVFHQUxn?=
 =?utf-8?B?VkZSaHo2OXpiUkFQNmpsVk5rSjFJYUFjNHFqUlIzQXJOQzVZWWdqaG5aK3Ix?=
 =?utf-8?B?VW8vUjUxM2N4SmJuQXh0QkRMQ0xhZEFvUzdQcmFzQTgzUFFmc3NBQzd2YlBw?=
 =?utf-8?B?S09HQTJhUGw0UWRZTDdHWUIwUkdKV0dLZjU3ajNWbXFwVnl0K1U0M1c4Z2RZ?=
 =?utf-8?B?eWxrUUYzQUhnUGVpejlTdHAwZjc3WGFKeUp4TCtZZVJDaldQcFVYeEhFaHUx?=
 =?utf-8?B?L1MzVEx2MHlFQ08xV2UzNVJWUXk3SlgvNlFkV2dZN08zdG5YcitramxQU3A5?=
 =?utf-8?B?L0VMeVZ2bUZtd0F3U25YK3MzenUwNmlmaDlJV1J0QnU5aE8zSGgxR1lvS3ZU?=
 =?utf-8?B?RkxzYVgvWkVxWkNHZ1FKRk9BeU45ZE5GcGV4elpsRE9sZUZ5dm16VzV3WUNV?=
 =?utf-8?B?c21MVmpaMTRXWTdrV3VBbW05V01wbW9WV05CbW01K0JSQTVsMXArS3dxcHA0?=
 =?utf-8?B?RmZoWmtPVW5KUWROR3h3a3NOODZWY2dYNXp3VWN0RXJycDJDdzFyZ3JMeEJO?=
 =?utf-8?B?N0VqdlNGdlVqYWR5UFBtOWJzcW9QTUY5eEVla3V3aStNa1BCQkZyV2psRmJm?=
 =?utf-8?B?OTAvWjVOdXdTdHZXNWxISHZNRlZNZlJicFhCbmpsNjE4WjBGYlhlbVREQ2tL?=
 =?utf-8?B?WlVZS0p0VXBIZFplanJwRUVOdFF1YncvYUw4TTVrQ3N4eU9FcEVwT1RoWDd6?=
 =?utf-8?B?MnZJOVJwZjIyL0N1ZkJBYnZiQkRUYzdBdFRSeEEvQm8zZDYwMzNRaG96aGx0?=
 =?utf-8?B?Nll1dUw2R0dZZ3NxekI4azFzWllLUTNtL1RmZGQvZ2xEMGgyR2xqTnVDc01W?=
 =?utf-8?B?OXZOZlBsM2UxUVVjckIxZ3RoanBDRURDWDBzSE9jbDR4T0lleE9rOXU0d3J4?=
 =?utf-8?B?bC9TZjlzU0FZZk5DdWRobjBMZ0o5MUFEWFNqS0JJUzdheEFtVUlwTVltekZw?=
 =?utf-8?Q?icPJ0qm0rgfUpEGY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e7724b-53e2-4192-07de-08df20856711
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:24.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/6Hi4OvM3jolpRQbLzaOD1NkB9rTmveLyGfBR5N9kdDtBHrL+8ylCvmtQTt57w1ywgwyb1B8wgXcBFo4NwiiEmjesewTbJDgGqj/2hFGZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


