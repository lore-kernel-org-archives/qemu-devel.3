Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C2CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwh-00055P-4C; Wed, 07 Oct 2026 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCI-0001Ll-Sy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCG-0006kK-8p
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tjrs0tDyG+N2UqZq63exZZlNqgTOEe1I6AVTioodp4VHMRG63NbxukBVoQmi7PGuW7BqCX9gHuxN5tkL5MY/Wh3Y+PP1mZPNZJZ5bwZ96g8NlpRpoQ6AmpNaFK5yhsfm/itviz+O5yCFE7J6ODTC/Xf1RO3KnLvWLDZtoTiqwNjd7zgBjfi3yPUX+bL6Flfi9tzU44iBROR0O/hQE3adWNcjy1qIRRNxh2Dzv0yagOXUUckw36zyQdWdgYVhpth8QkVKg4s8AgEXmpXjCbKPWVbU89gTnFNQjH963Q7dUfszYDDjFRbdPwqrkq9GAdL3zR3Bxq546Y3+uL0x8KKEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=fPYZxwx2RZ9xncnxKmOifd+6Aw9I4bnUQxGtSuH435IwKMUFvHLPW6MH0lVf65xyn1THmLQRJgdVghGBKdSGmT5FvV5IZOgrFQ2rphuMH2+xSwRlMDfMlYFoibZAw7ExUC9KwcVyzBj6fRv+oPj/6krPO2jsGnPyIrC6/sbN90nBlrH4K6aZZiOpGujeIa4LfIe1cgX9xaL/DLVE3De9ndkb6d2/GzrBHJKHLn6k7oIHZdJ3T5RaQGWc5KZ8reczdWmFqZ6O2e1u1cntOjT5j37edZ/oldxy8RuUtkAA7R+lZsvb78HXnCESYxDgoez1GaMUT9gdLfV8S/CgG+awzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=ZHD05sX/tjv+dRGszyIPCsojaLxTEJsf0NGONkGvpVwzH5UEC1Vf1xV0BnFCFUxZZT5bWhFaQZh08To0w5aACAvDASoz/uce+x0/j4hSRJg+Xm94AJbHJ6gTk2qQ8GcUQEsCSYYAH/BF7T1Te5fXTbrpn4co/S5KvjABbs05ftFYZbUysKHaJqrFZXaqQcd/GZPdqF/nr3MaXkEZlkANrvIfpXxBAOXa0FVUjaKcrYO8ts2qW16fQyLV9HSCBuvAaz7eXrI9olGn0GlWHFovtpKom4SJvK95TuRjGoyz4vRRzu4BWyG+z2ayoBUqiZ3vwLGp+L09Q9JIp1RWcbax5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:07 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:06 +0300
Subject: [PATCH v14 13/22] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-13-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 626ad8d0-dbce-4026-9b28-08df244e96a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: uMk3LvlFG+FAK2lj73V0bNDJBmkFIxue9vWxKJlNKaKBnDrJWKlh1kfQSNhbpC23vGGCe7qLg+7DSyfb3OiYFsXFB24ixqgieLNelfJv9iMXUgTI+LeJLjvfHjOoGwq+WN8qMpqImFfIyfEZoSE3JGwM+kKknvxm3oxy0OU3HOtSQQ/eZk16slOZltF9HRHOm95TtfIT5Tbw4N4GgSTh+L+EG/49wDR8N8iGrdP6nfuts/UfzqsLxVB4vz01sB3ydfPpKKvuMRdy+66qYdr6lgaXnx6QtzOTpnYK33q83qfzUUv7ThEMw4C8V+TYcQ/rSYx1w2m/FCymRDsObQ4xc4A2Co12f8r8uZ4XIjBiI3REWNTigLtLgPzmBGw6AFen+IyGZCSYJDkWaKuEiAssCzuczGzN0wwz7wLyvaYSA3G0lyjuWJ8bbYyBZsG2/sX1yW7gb1UmmECFTZPds5zwo8oAdItNJg5FBY3hYuIL9lj0sdgbWrDoJxprtzZZug1ExE8GniCA7Lhpt3az64KZvuD3NXC/9v3VcY8xYTXSm1x/xbU5dpkMKlh9ftQ1eoA4kf1VU4pxxtcWzJyDpfif4u4An3b1O1VtXND5Ijjhtjwlfmy7Fol7LXBYa674N/pOz5CzyfWv/k5Q5Xpqoc2m1pOYb/eMi6wLprUk8HkQwn+HUE1lRZqFWCh9ua6pZV56LQMcT7Bvk1kF4dB8hWHaDtqhGVmE0sx+/tjavGzh01I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhtMkphYW9zUHVLbUF6a05heXQwZjRQV0txcnlOTEo0NlpXeVhaMm1uaFAy?=
 =?utf-8?B?MHhhb1dJODZxblNudUhhQjh0aWJmTHFPcktpSlNCZkxzNDdCNWtSK1pqRFJ6?=
 =?utf-8?B?NGVyRUIzenJseHRmYS9MZjlxMHoxeHNEVm91cWxEZVR1L00zSHpHcy8zcjhk?=
 =?utf-8?B?NDY3OTlpNkRsSG9wVW4xQWQ1MnlDS2t2ZHlnNytJYzZjZlozRlVQOXA3cnpS?=
 =?utf-8?B?ZXRvR2xqa3RQamVwYm5KZU5zblgzUUk4dCt3U3hPeUNCM0h3NFo1MjY2eVVw?=
 =?utf-8?B?aCtTQVJZWDVybGF1b2JmRzRvV0hZaEQrU2dPZHVyRTZXMmxGUHJlaktnMEkw?=
 =?utf-8?B?ZHBQNTZGK1BhRDhLaGN6QzFYeWZPcFNHY2w2NVFBUm5Da3VYVzZGV042NWEy?=
 =?utf-8?B?THJlRmN0SFVlTXJGWXFsY3VCUWFZU3A4SVlMdEhjVDhkejlWeHkvb0NVeFZU?=
 =?utf-8?B?aXllQ3pCZ3h3YlhKOTlQYXZKdlJ3Q1dJTjd5aDFRMS96djV3YTNBTnVRVXBQ?=
 =?utf-8?B?NVZFT24rNlZVa1ZIU1hrRlQwcGlUVCt2ekl4ZjFTSVRkVGpRUGtIS1crQU5Z?=
 =?utf-8?B?MHNmSkFhUlpNYkFPc2JrMDZFdGUyanVGMGtHbWlreGdQMUlNakJoWjRVcnZ3?=
 =?utf-8?B?OWE0N2pFNE13cktpTG15VGJzcUVnaGRLNk43NEFmck1OMkJrdndIQTJreGVH?=
 =?utf-8?B?cUxKdGQxUGxOTm9jWlo1S2RmRHVJTTR4NUs1MU1MSFpWU2FPVmZvWXcyV2NX?=
 =?utf-8?B?RnFVN2RNMTJYVXd2RVBjUVRucG9LQkhRTHRNRzdKRXYzZW5rcGdXbEt1SVBB?=
 =?utf-8?B?YVdkN3NhL1Q4dStpZTBlK094S2JUZy8xcjU5dk1mR2NucklFOTlSSFR0UWRI?=
 =?utf-8?B?clZKeGd0djVMVkJKeUt5ZEsrTnd2VVo3Zkw4MFR1MkxOd1h1YzhxNlJwWXNQ?=
 =?utf-8?B?alpuVHdVdmdnQ0JMSGo3cVY1dktoTW11WkZNa1BOL0sxSitDK0RsS3V6eTZ5?=
 =?utf-8?B?QzlDa0NVOExqUGxwMVo4ZGhHNURxQ0lqRXBxdGVweHF2bDhqV2ptS1lQTXEw?=
 =?utf-8?B?Y0hWRXp4NGg3RVlROENZY0RKVDRlOVRNV21ObXh5WEtJUnZDaThwTjFCVkk5?=
 =?utf-8?B?Z1Y0aWpvejF4WHQvQjBEeURwRTRqZEZOQTRIcmNObUcrc29VV3RnbjZ3YXNl?=
 =?utf-8?B?V0E3Z2ppTExFTWs4QW9oRnJvSk9keEtQY0xZZnhZTXRablZCSnZETUNIUzlz?=
 =?utf-8?B?YVFYWXVvUkhlN21PaFc2akgrcHUzTlJWY1JIejZseGJOaEJWZTk5cXdNZHZJ?=
 =?utf-8?B?Q09ocFVUYTd6RWhZM0c1V2gyR3p1UnpxMVNBdVA3QnF3Y3R6bXdSeGpvV0Js?=
 =?utf-8?B?YngzM2psaTVHWDhOb2Z3U012NkNFdUR6QzNKdEsvZnNWcW5qUTJrWUNyNTkz?=
 =?utf-8?B?L2FYL2x3TWFEblhIZTVBNHBDWHhmZjF0aVJFMnFPZVhyNGZLVWxRczV5NEZw?=
 =?utf-8?B?alQzdU1xTDdmQks3dm5DUEhDVVlOSEZyNEVlUDc4MXlaS09RREV6UmIwckhI?=
 =?utf-8?B?amUwUzhYNFpyVUFXMDhaeExjb1d5NGx4a2hHMWhKMCtmWU90emNQekxkTmhZ?=
 =?utf-8?B?Q2laR2lSQjlwcHpRbGxVUkorSkFsYjFSVTEzVmZyREVJa295N0pYYjZVaCtK?=
 =?utf-8?B?UTdqSnJ6cURSQlltWEtVZzB3TDZseGN0L2EyZ3FvVjMrREtOTmg0S0c0cElu?=
 =?utf-8?B?ZFlPemJHR2tCWXNDK1RwRTFrUzRNWFU3TEdWb2ppSGZDZUVDc1lkUDRSYTVH?=
 =?utf-8?B?WWhlTVdieFRJdVVmTDU2cFRvckxqMHBlR0d4VHhZUEovbTVpbWV6d09oaXd5?=
 =?utf-8?B?dWtpZnJ2ay9GcmdRbWNBQ2pCY0QybU05dENVNEZ3T3VsY3JEQytoU3E5Nnpq?=
 =?utf-8?B?MkYzbE9uVmhWZjR3VE9iYzRwODJGVTNPUDd5VDNOQkpheG5HV0NsYTIxdERz?=
 =?utf-8?B?dHRIY2V5WkVHUWRvT2ZFbFpDOU1qb2p2WjZlTjQ4RUwyalExWnlQL0NOZlpj?=
 =?utf-8?B?bUJabnRoRTYwUjZxdUxGbWoxTnIzT0k4QVZ1cEJOQ0laMEtuMTRVZzRxMlgx?=
 =?utf-8?B?cmFqWXpMUittYXdiYnFZSGd0YTdqOEdCbnlJSUx1aWp3Mi9Fd0I1U2tmWnlj?=
 =?utf-8?B?MUFUNlB5RWtOUXcrZXpOTFdxUWluMUtZUjJWcE84WDVGWUl6L3NsbVA3MUV3?=
 =?utf-8?B?Y25KNUt0QTd0U0JBd2oyNkUybmVSWXRQOXhNRHVYYUxsWG9uQUlUcjRSR3c4?=
 =?utf-8?B?empvOEJOQjRLY3NMTnl3TGtSS3BzMHR6RlQxVVdRcWpXUEh3NlZCQ2Y3bGtI?=
 =?utf-8?Q?qAKkHZKK0gitEIDo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626ad8d0-dbce-4026-9b28-08df244e96a6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:06.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCnbEI1dnl0J/nLo+a5R8ykGgekgf1oiR9YTNcfaLSf7TB8hRTVkfF9TmwaR7Nk9NIpfnj9qIUPHRFtBzoryix25EwFnzUpSZhgUFuDeoGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3f..56fa4345886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1c..8127a9a5a2c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


