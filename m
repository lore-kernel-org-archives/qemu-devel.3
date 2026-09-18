Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC47C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwD-00033B-18; Fri, 18 Sep 2026 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw9-00032G-5t
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:33 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw7-0003Dj-BQ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoD67OOcouGjdkaRzvR5OaufbE/Hjn1Y1y/gmOqYNf9wjIxy3iRc+pjcy7osbyxX+nilf6tSuotGvQYUM87g+aox2kx5Hxa6bLB76Bj6OmIPi5Zd+04U4mOaYYioNxvn3yb9hk/iOwDt/Idt1hBV8JoggRRV9RoQifLgI2F4foJm3VpH+P5C8ilAlEoIBDWJUt+bJ0nXVx6psvRSakwWuGCnDRMtsoYGHggcfTgbFauu+9iaZ6EUX++5Ob+IYmkvLCVWwffW1HRoSnpwNWjYkeoRwcmwLQk1XKTZeFsXPPY02a83YL1z1AnGzdIAesqxKQSRQR3gQf5ETz/k8FordA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=Bo7UD71kxO/AC6icjCniD2yKg+O0/S2tN87g/ZWnUN8Q0dmAkvowxRJfrXCvVVIwBwSkhB0D7XSF4hiC5uNZaUvC4mjZRAvnQW3RlUvNAvarruNOPpYHwVLU/qtmkib/lCPMQPtGS5UZLFxHkx/tOu9hCuX+pK5bUVJ/Z692odSxFedCtr+W6UKPHbatHCeiV7ckEYirTFV+jPR+jv/mYjNhDowo1R8gv0ZyypuomQvfLrfO9tDodYpKoULjluNfTUJrvgxH7uiRkEr7jr3fdiB3luVIuIti7cYRSmpe3coYSXhEgApUNgKFFeIfIGf/cVdSVpxQPl2PW3lEP3rm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=D6JhRMXjcIjylM7atSs0g0UJNHK1sGblZrBqHxFwOmxmCmKtVidjrBpSRTXgOpVuOi+3TKvApEqvPq5K7ptDivmVH16Bjwu0SP8gEdhsF8wqGnloGnv97M6xiYXEfIS3HPE0S/JDmpND8/XgNPHkYmHWirmgkmrnZGusv+lOrP8U6azdxNLEqGv4Z5XM6xJn90rzvHAnfLK74whLYkHw8+EXHhjfEja/TFSkC6I3pVpYqCfnkqV0V1v9clHFqIR3S1qBzwomo3fduo62aUbWdYB+449MDp41j7cFGGsEp/DR2A4r0SaK1PTG5QKHCdcdK0cgLJAclQu2NpZ02FseCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5483.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:03 +0300
Subject: [PATCH v7 12/16] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-12-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e244981-9067-47b6-8884-08df158b5fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 3bV9nqgG/GiegkYHPrxQSPy/5y9/YTbl4j7jtopBXFOUgNk5Fpluo9yzpYrDkkZ0jF6yeOSeChJQrB0qI/UcPo3MslHnS+DxJkMdXVdrK7UuH4M/t0gp94Zd3vFQkwUL9MzYh78O38U4agAhpZdIr5htmj3KGKxskvpqfygLKaLkicLjSUgXk+mOiencx7x2ANaBf83LLBWzy23o1kqLLFTl/SSLTbhyAdcscSZfIXsM0VA1GV+hTpYmInXWHPO4/Sr9WR9UQ8nWodHSBJVKFxK+wlYjAifzHCXJ4I0KIyNAsReBpXmA0mi0G9Ouethuni9Ddpf6qtVPIElqdhRxXeEzZXshDqWyp/aqGObjJlPLLNlSlOnQtgSJEgCOXc1iSxS2vBwJehkGcroQn17kOs0PLhiTQxpB22YFecvfa2TD/n6Jt0LfvCvXIMAds6XuNNIX51r7goQdK+eNRHpvh1vszntH0lcLJ/CHMxBLpy/onZHK7KNUr8fRTKWKkom5u6CwlTZv2R+Bqkm+0200Q6xjYCbMkwKmb6ebEos2dWzvQ/qV0avqrYrsJNf0sF/HHsgp+hfi3aEriBzxh/DZ36s8wXsjkQDLebafPEd5sWZ9s7nalNwAyWG3kG1ug1HPhrVHbZPJYqyclFiT6nxm00WkitFFfs4GIoXzqYx5WYG29VMhA21m8z7cTmfc2TzovwpHPrGL79YKdGzRbZZzS22LbUV0U6ORhgKbym8T7gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdBT1BFOVdvSHM1OW9PeWJXTG9jQWgzM0E5NzhSeVRHZ0tpWlZtS0RuQjBI?=
 =?utf-8?B?VXZmbkFRZFhQS0lQQU9Jc05RN3d4bEtjb2JsNEFtNEtaaUQwbEd3dFh0Q1RM?=
 =?utf-8?B?MVYwZU1qOVZ2dFMxM3RneDY4QkpORU8vY1QrYTIzOS9TSjY5b1NlelNEc2M5?=
 =?utf-8?B?Y2dsNTg0aE1TbUJDQ0JYWThRQWF1Um9mMW1NRTdCME42R1A5aVhObnF0RjZ1?=
 =?utf-8?B?WlJxWHZudTRGSXliTi9CWUVzaFlqaXNBQXVUS1AvK256OVBxYVFxZkszTEln?=
 =?utf-8?B?alI0akFEZkFHT1JxeE5Dcnd6MUFSMUV0bnFNa3Z1MSszOUVZa3Ztd1lGRHNZ?=
 =?utf-8?B?VFY0K3lCUU5Wa3V3N2VQK05DSWt3b1B0V3ZkRzh2dkYvUmVNQ25GZmVxak4x?=
 =?utf-8?B?WmJuZ0I0aElqZ2tXdjFCY1IvTGZQc29Zd0hEVG9LWkNRQlI3QjF3RW5PMWMv?=
 =?utf-8?B?ZjJQTWlJTVhCSnEzWE5mclJPd0ZkN3E4OU1jMGUvTjV1cFBIWHRTNXdaTjVM?=
 =?utf-8?B?bStLSEptL2VjNEYzQWNRME93SHdHSm9MZC90dk96WVduck91TE1OOTRuZXVt?=
 =?utf-8?B?TGM4d1dlRUFCUE1wa1ZtNkZ5dlZvOGloa2NpRXhhbFdSZU9lSjBYclVCUTF3?=
 =?utf-8?B?dW5mQndQaXFzMDhEWTdZT1lMaVBPSWw3akIveXBJeEt1bTNJaDJuV1BwV3l4?=
 =?utf-8?B?QURPSUFCMU1Gam5sTDVuYUxIZzR2Z3F5NnlhWHhBb1N5c0dBdG93M3p2Umdk?=
 =?utf-8?B?S2NVa3UxSFd5dE40MlRSUDNIZU5JdTZ5eXFxcnI2OEwvZXVqMWJmd3FHTmV0?=
 =?utf-8?B?SDRuVCt5ZjRaaXZWZ0xyUFZmcWszcXNMTjk5SE52cTFpOEZhRXdta0pick0x?=
 =?utf-8?B?WEFMb1hzYXNjaW43eWs1UmFCR0ZCYVBXYnU4emVyOGNVWEp3SzRBM05tRGd5?=
 =?utf-8?B?bEVIZk1TN3VDM1RVSHlQc0Y2U1NVL2RqeTJiK2U5ZTNvUjZmRnZ3a3FzdWNy?=
 =?utf-8?B?SFA2eXhOZUtEeHI2RVVhM202VTBhY3Z2YjNhVEJ5YldPd1N1ajZaQmRQNU5F?=
 =?utf-8?B?THphVDd0Umg0UmtnYUM3RU5qRURuZWkycEk4RnV4TGZNVWliZytJWVVqN2xW?=
 =?utf-8?B?dHk3SWc4UExLUHFvSHNvN0oyOG54a2szVmN1c1BST1lrVlRoZWFEdkdKVnpK?=
 =?utf-8?B?RFZqMlFhWjM0T3JTOGdUbGoxdDhuSDRqZEhaUHowL005YzZFeXRhblpyM3pu?=
 =?utf-8?B?TEF3TFppZjNjMW9wQ2d5N0t3TXlmSmdRZTdiRnJqWk1TRk9GZ25rbTNabjFj?=
 =?utf-8?B?WlR1eXhHWGZjek5LOHZ3UU9aRHZSUWZHRUhWeGRZdUUyVDlNYStaUUxKWFZl?=
 =?utf-8?B?RjN3K0xsM1BCUWNzcnV2RlcyQVZwU1hTL25vUEMybzFiNTlDUmtxRThYTjV4?=
 =?utf-8?B?bkE4Z05IanhrWFozVjZMRjVWc0FsUHhId1NLQWVuUHQxMWFoVFd0QUFWUVQw?=
 =?utf-8?B?b3BadzZwcHM3aG5GcVBqU016azg4NE9reUpja016UkdjMXNKRWJER2Rrd0xx?=
 =?utf-8?B?RnBOYk56VlhPTXU3TmcrOGtuOG5od3JCdWpXRHIrRE1xY1VWcDVZajYwMVFY?=
 =?utf-8?B?RWV1cGJuN1lhOXIxZytQS1BkRmVTVnVYOVhJcHdFUlY1WEorUDU3Ui9MK3ZG?=
 =?utf-8?B?TlI0WDMwSkNlMzdweDd5Z3lCRHV0V3J4ZXJUQyt6TGlPQkhac001aGZCMzFn?=
 =?utf-8?B?S0lxbWI2TjZmQk9mNGczMjRTdEgrQWtCbzFMZGczcHB5YnhWZ09GVTJ0RUZv?=
 =?utf-8?B?T1F5UGRQRkEvUWNSZHFiOWpCQ25tSnNpNkIzZWV3V1JnWWxKaWRZdEE1T2pq?=
 =?utf-8?B?MTdNQ3B3RkNWaEJSN3dyc0xqZVp3M2ZTNFZ2SzVrcGpNT1lOQXBSN29ubG42?=
 =?utf-8?B?cHA4enl5SlJuaHI3MUw3enFhZSt1WkEwdjludkdVLysxRHUrTkxDRTB6emRh?=
 =?utf-8?B?ZDlnOU9QVjcydmpkQW80QVJ6TFJMOHY5YWJtRFo2SkNFYytFSSsvOXBBbDl0?=
 =?utf-8?B?UlQ2U3BwVk5nL2kxRW9YMGJuc3Y0ZEpvZk9YckJqSHBXaHozdE5xbkhESnZN?=
 =?utf-8?B?ZjMvMmx2Mk0xWll3eWxnYU5wbjVtVFE1Nnk1M2ZkYU15RkY5bE1SYVJmcFFw?=
 =?utf-8?B?VVFRVjJhb2ppS0ZSWEVZR0QxbVhzalJzUUcyUEZyaFJ3UlFvNjRZUW0xUHpK?=
 =?utf-8?B?K2ZjcGlSbSs4KzkxR1ZxWDJFa05zQkhvdnRrVzZuUlhVZ2pmMlltbDdIbXpE?=
 =?utf-8?B?bmJLQnVrTDkyZm5mYy9uQW1PSWc2cmtycHVHZ29mWkNMV3d3ZHF3ZUUxRW9K?=
 =?utf-8?Q?6YCmP3xUd/kvFBRY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e244981-9067-47b6-8884-08df158b5fd8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:27.1002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFNjlCa7SiI8HgtJ1JNEQ+0ooJHEb7YGE41dPPoObj8QiFt57IjHOs+oSHlpyveWlt0HTXURjGEN0bvPrr+WqiUaU5m1H875E2EKFbm5kKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5483
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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


