Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71545CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJk-0000lv-QM; Wed, 30 Sep 2026 06:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJj-0000ku-8R
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:39 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJh-00045p-4U
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlmc/0Kbrx/ZbAGElPPOaZjD+bXSc8UZjFZPrkuif5mG3RFN8ymT/rJ/28qpTD1ZHiN78CB/QGpsUmjuHu885N3toxYmhZXnyIxo1vNUsu/gIH2x572UbDG1mn+K9KYknbZuErvCvXNul8GgzPcZkYZ3tn6MSddPtpXlaQkoaJxi3TY68HLLG02uoRpE3/3BLOUedutvjZjBQPpFvbPjdLvOpEoxB1uJ9cAyMiZ7sNg6O3vEegiVc0hanyKUERtBe0I0bpdFK0AoNB9HCkKx0EgSugnMVIqlXkdSg6A0dzO3hmLXYNeR7RSp+UaKc98cFSzjJ/4xyfedZ/L+jy4nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=fLz0n4E9P4Ags7OmD9LyMdcEk1ptwhBiFTcJMSsozFqBf+0hX/e6ySYYW3v61bSYVxuN0EQmSgH9LRTEhmyAJI+YNfsctWd/XVzEXdd7pILQDncH+kdLpVjRkr2H+u8EEbdNN+R7BgtrdF9GnLPhzLh52dNkin2a01QPEBf7rAitmiKLKqU83GHtP87VjlbiDtnVCYJggF5aNVi0jUTT235W1yDKOHOJh7XB+4zWbnctJYCW4J+/yi/7NNw2ue54AYbW3Wh1WfcjMw7fiumOWR9ZQ54ubglEMcPt7b49vCQd/YkTPSQe9amafEwbE4fccLPYiIGtNG0Of8Pjmb8iMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=OoLwibhi4onpUG3RckAz1IHH5uQRcMPwKJO3Dzw2tYO/pduLsCJveXakH6sXiqP7flyhRt9s9HcnfUMTXw7fVxDF6L3TRMjrLNpyMc+Q4dzknqkuLwsLo0OY4K8CZ4ql65pKNxtqJiBWuTR8+qOqNSzY4AStWrzdtsO6+oFBLk8qtEN3hqpApsQTrdjMwIt/mYP4L8ryuz6AefjAw5Mu3c24qISSqS2iB9mJ+WiaslOsBU8DXyy2l4bc6XCvJuNCIRjSMP5D9I/zlri8aHtJDfZN3GSXLMjBZanDkw6JJEcVZGeGPl2owIi8A48ICnH+s6kKUt+Tn4FctNQBRwWHsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:15 +0300
Subject: [PATCH v9 16/18] vhost-vsock: hand off device ownership across CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-16-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: d81367f2-0eb0-4df0-c61a-08df1edb77f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: jvfSA9ujrlq6IPrNebgEWr7mALgI8lKAPsooyl910U7utmCSNFgOEBL5zmrA9yY5vD6Rt42wVRTElIYShajEE4Uv2rPIqwLSYwTuBBIfrnhaMVR5kpq4Xz9R0w2Auuoogb3Zk4cWz1isXn2SnQwlk612ZU7xWyuQBux9FIMCFT0QrnABD7kpLsZ1GufLtZoVNAicJdT8vRfuaVr9ab1F8+0BqinktlK74l1lUTSgwYbwOAGNhv3ZdHYtKkvP21qsrXdCUu4HrYmwWX7xJWXYXsXY1v0VYHYhX5G8HbZREgxQuLb9iPS1xQJ5nUN34oys7BFPa9sg6duNabado+1+ZqBDgU5MdwuIfHN3MEUuoHYsLPo9+Mj2T7NitPiZsBBctP0S+WPop2R5lWOeiyVDq5aZnHGPdX/byooEMBRr4KAXFcZvreLg/RD7X1oCrLFezqr5P6zTmx1OmqL3bThE7QVZZJtALc59feViDJdPVJ5jxG+84KqB/Rw+sXY2Jilslre0oCDf8PL6yntwtiL4RNu901hIrqQZW+GM+iPImKnhGJplPkg+3TVmx5x1+9blQLDJCsQNFKMZLzBav53l3AEuYnwjrnqqyOyZka5/0yLv0oZu0jdeX+ycqbPTV8M/KmoqDdoE9RGLJHkql0i/kfF2Ez9sInNs9ipPKegwSzIxAet3FSUx/qipBhX8uV8MV86tfdePe/TrqPxkDHlwWNBPUhxaf4U60ItRaeW6zlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1UQUNHRXVnM0lIa2F6SmlCanROcVZ0V0dIQVUvSXRYb29iZlJWWGNQNCsw?=
 =?utf-8?B?Rm0wRTFuZ2szR0FzMEw4amNHNUxjODBJVG1jTFI0WE5MenhGQzRPVzRJeW9j?=
 =?utf-8?B?ZTdETStxSEE2dVN4UXNOeDVaVjk4Z0FuVXRoK0xLbWpDcHI4ZTEybklwaTNL?=
 =?utf-8?B?blIxYS9mMDFKOWZFUmhSUW5ITVV2bFdmYkxzY1JHZG1CSVNXak5mV3dyUlIz?=
 =?utf-8?B?UXpYazNjR3IzQVpPR05oZUxSR0RhWDEzZEtvRGp0OVI3eFZLUGRVRm9pUnVO?=
 =?utf-8?B?dE1vRmREV010eVpOSWhqMW53ZXFRRWRjc3dSSUN0MWxTclB2OWMrWDFDajdy?=
 =?utf-8?B?Tm1uQnk0TmxsVWpKNjZWdkMzd2FCVWVNc1QwL0FxaDk5aE8zQ29jVjhvYk1J?=
 =?utf-8?B?dkJROHNzbktOeXVnOHpFMy93Z0FLYVduZjk0WmNjdEliOW1tRkVleVVpTHJv?=
 =?utf-8?B?RllnUStjVk1UWktoR1Z6U0dhbFpIRFl0cXZ1VFplTXhkL2ZOMWpQRHNNR0dC?=
 =?utf-8?B?b1lUYmdyQ0lYQzkwWDVpMXRxaS9VL0pNTXhITjN0dEF0Y3UzVFQ3SE53eC9D?=
 =?utf-8?B?RGpqbHorRDJkWmRjRHpxdlp0bnMvN0w0YzQvQUkrVXRhd3gvOWI3NS9KRmp3?=
 =?utf-8?B?RHdxQjNvVXhFREVnVThCWXZ6emFIOGFPL0dNNzkvZ1RXUU4rR2M5Y05iV0pY?=
 =?utf-8?B?WlFIVzhWQ21TSnptUDJSUElHWkt0NFlOSHVualh4bnByek8vd1lKRDlrQTdw?=
 =?utf-8?B?UDg0YlJIL0lkNWIrakVCeEJYeTFrRUEwRXpCV0NzWXAyVWU0V01PSEpRaU1N?=
 =?utf-8?B?OHhsTklyZS91M1VHN2RUNkhnZDZodXlQdHV4ZHRnbEgwU1l5MzYzWGhudTNG?=
 =?utf-8?B?NEUvYUd1K0lQNEhHVTk2UFJ3dnd4bmovWS9LZFFMN3UvRkhMZythMmowUEpD?=
 =?utf-8?B?bXpPU2prRk9ZTzZCYUtuQ2IxRlZPTHFCbnlNeG5Lb2FJeXFRSUswTkluTThJ?=
 =?utf-8?B?UW11Q3U1SS9nOVJRNGJpMHBQbU5XWXI3Q0FyV3gxVFdaWDc0ZkhoSkg3ZExK?=
 =?utf-8?B?aS9uMkRuWCs2Y3BWUzk4WDdIajVkaUNkZitYOGZRT1NzZHRVR0YxSHgwWDZH?=
 =?utf-8?B?V0cvUjBDYmZhK3lBNzYvYmdpckpuaWFVdTlmNGhBT3FQaXYvYVJCRG1kNk1a?=
 =?utf-8?B?LzlIbnZRdlgyR3FJMmo0dDdZdEFoUHpaVkdHU05qYkZnb3hQYWhnRjFKd1Az?=
 =?utf-8?B?bkovSFBxSnJKTzNySnpyaGUya1dlbS9zS3BxUFFqY2hFL1NEOFI3eUVRUHhE?=
 =?utf-8?B?R2twZHpoaEJ0S01ML2pXWVFKZ3RSalhCOWJ1Vm5TZUVtUHFmRGxmSFJBZEFx?=
 =?utf-8?B?S0w3STM5V3JRQlphVXFyZDl1bGxPTDhUZndUNFFyTnBCVTJUbU9SR0xqTjMw?=
 =?utf-8?B?LzdFN1NhSnhZZFgwcVpCcVowK1c0bldVNFZsS1d1ZHZXSFRBdjRaVmlzQ1RR?=
 =?utf-8?B?dU1Vbk5rQ292MDZRT2xMblNBK3pVSUpLVzJIdERnbllYMzg5L3VDMWdtelZ1?=
 =?utf-8?B?b0lMNmp6L0Q4bHMzR1M4YjRHRTVUaWdsY0ozTnZhWTJpNFVYTmQ1TEJzajcx?=
 =?utf-8?B?MERLUVhOVUFYZ2hjWXByOUl4eVFKVDFnUElKdU5kVkFnU2szVTdvWk1leVNv?=
 =?utf-8?B?allFYWwzQVAzVzdxMHFaYkFNSVF2RWpUVFplaUNDbUJQTG5Ia3l1WWEyc3Bw?=
 =?utf-8?B?UmZaY2JGa2k5OXBTZlJrZVdneW1UVjZtSFNXRG5yR1NCMFora09PQnRwTGd1?=
 =?utf-8?B?R3V0OVlrVzVxbFl6cHBNTjFKcjFRL1hhZ3RvSmtMNThiNDQxcDZLL1I3VjYz?=
 =?utf-8?B?Mm00ZTRVL2xTV0pzT2Z4b1ZBdzFmcG5ZK1AzNVhsUVFFUTMvS0VHNGxxUHVZ?=
 =?utf-8?B?ZHh0YXBmdUpzazRLakh0a1NJbldNcXhxUkpMaFUyNll4aFJxaUNoZXJWY2tx?=
 =?utf-8?B?RVVBK09aOGNDdzZYaHp2N2Q1VmJmbEdKVnhMUzJNVXQySVBzV0FIL0ZHQVpR?=
 =?utf-8?B?RDhUSXVHbU1sSkVYdjJsMjNKeWJPNUY2TWFsZHlsNEJJLzA1M08wSVFqTzJr?=
 =?utf-8?B?VksyOWppbjhSSWgzOTRONEVFOUxWRHI4MDBBOXhxNVFDY1pCSjlxRVBYaGxx?=
 =?utf-8?B?SkdySkQvSzVTTWpYT2JFYnc5NXIybTZ6ZGppMkxBcVkwUkN6MlJjd2xndUVV?=
 =?utf-8?B?c1FYUDM5aXhyaTQ5OE1YR3BDWjE2MzFpL1JLenhCQllJVTMxbVhyeXBjQXNP?=
 =?utf-8?B?VGVZeW41b2R6ZldlS3BoMDJuZ2JEczJ6OXJVVEtZSWFQWUZSNGVsdVd5NG43?=
 =?utf-8?Q?HvkZ7uddoexmf4Kc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81367f2-0eb0-4df0-c61a-08df1edb77f8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:27.0601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03+rtEcdvAnrt+VjWjyy5vl/ZfLWc557ZPRw5eikmxksSPW3Sdq9Lq9ucYacATTqy4yTPgr0J3KwLTO9YsXUd5CEVBMXill8kZVm6H00XIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
ownership in pre_save, reclaim in post_load, re-acquire on restart:

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

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
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
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
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
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
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
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


