Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754DCCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHi-0007yP-UE; Mon, 12 Oct 2026 06:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH6-0007dN-HR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:01 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH3-0005Fy-0I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNRhvwQCk+q4qo7M0EYG5sMEQ2BVM51vtMGjsC1O9hct2wCHsJUgdZfXQAjW3ycnWT7bIh8Kk23UhGMyRbmQdD71+m3tGmwdDDKdvrjkJ14728w78pt7xDIOziVswPlB7YJ1J3P6d+LX4N4SHCXbm5zU5Db4NRY7CMypHAyT2RJjHaLISsEjGvM/32n9Hvi3BX6VCdoUGyDqNQBnQeVbal+ZCvCGz7/fbtFgDUX2j6qpsqHneOhK56DBPlmLUIMoF5BeR3TsavQvqw23MSa6Vsr9nkOKxRZ9XJXi51YDD16uSCVY6+zaD7RCHaP/N0UNLg9Yq/iFLd0dnmcSyhadjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncY3aBoopIW4OgNFcxrbEFdrNLaTHYF0LW8//1vaR/0=;
 b=atUpqM4mz4yyWpaMPG0aoKNBxNwye/B5RKkObOOwx6IEQZXOTL5l1Xl9ZRTByOfUVspCy2JzcO/b96n1UAY/10wvnON83oRpZqtJCOYJ9ei2uAKFyhVGbZbHLe++Qp14pqS2Ko1D/9N6WV/OQ1MRwFCvPl/LuiburXJrk64Js34vFfIVhnITJRI+AMTY/jSyLwa1bnry9GI/3Z2LJ5tTG79NZsRMPtUfxNbyePnfT+mcVIxOASJduD7REDRweTTcAg8uJ0dM0i5BsR2ZCZEb6oNkLoZf47Glw+jQ3DMvjHruRiWUevdIM8+xAhrNC3Ke/cO/5tvRhFXZmw6BeqZfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncY3aBoopIW4OgNFcxrbEFdrNLaTHYF0LW8//1vaR/0=;
 b=Ag+HDSvgQzrjEUArmcKmZhPj9E6d+CA9PDfXlbmgf9xiLs8KR2Wl+A8gAZhI4sqh5Y1dkrojayOR4S/9mLGtJseTYbQctcUJLd4U2BKnIOAZ5b/Kf8x02+cob1ubDEULkoQfghJRVJvyC3k/HFqVMzBE1CGXGtXupFBhzYweFAJGwMRGS5jf28zvTdaua4FczfFlcsLRJxMSO1TVZj2EU60vWKcIKuOC/YmInxAPQH/8QIoTmd/lIWx8At0SoAOgWHF13pgD83O71w6RXic4jgh3qLTFLWat0rgrLTsnbClcj2UqWsR71/Vqndu8XOlPUK34OMWesxw9LLtUGxu08w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11921.eurprd08.prod.outlook.com
 (2603:10a6:10:614::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 10:28:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:47 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:27 +0300
Subject: [PATCH v16 19/22] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-19-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4519f942-f3fa-4983-d142-08df284b997f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|6133799003|18002099003|22082099003|10067099003|38350700014|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: /Xfx+0Yze7CXgnIYsUZZE0bAcDJ4WJr86hWM18/jBPhQ5dc6xDMoPY1QvtdvjC6ofXuWkrYGe1cjwvZWFum4kAnNNW0ya7A6b1TQ5bdY0+t4xhqhAueqINJC2sCDxsI3XZzgWWRlX6sVJPXZkrvIQMBRLdI0GvvNq8y0HLXhYbWHa1Jt9Q1Y+UxAwmqHW/Axh7ZbJ/Lzcr6b647eO5Q+wD66ZFrU7BqJ6yAakhz5V2YWD3SUh6Q9MgwgqepFXY05x7Kbfup+NuDEWIpHhTsHigKzEQW629qhJ4z7jhwzgbfPtHUYjgTkEAo7sUIqsKP/2JIpz8msPQb3YcT5LVfkX+tbPiGnIysDVBo4A2ydask8dxpY0IUV1jvsAE6FMp0W3ekBba6zo/2spWGk7x+i1ffbLtbc5zJJVZobe1Lg+tk48p0GC3hKDZqdhNQSRNIoE+4tjF0R5EjvjEtav2JTVK+diC0IfuwBPeMqzL2dByADXJzpDWirK0IhS/o4Vwp+ywArrC4pxnLGGtmlfx2zPv1q5aYywZUE6lgbHbGTjbfZiLN1JBukZ4JvFtJ6L8Bht9W4I0TjQZ8Llw/9H2wLyA+lGTnuKQzJScx7tW6q/WyiIaQzPK1T8TAOT5fufzhzgoI2gHdnhWMN9iTgYGBXSISBPKcULLnI2qLOAyMIQQoQVrNrJG+OtQi0pkmvPZPgqGqK071E9ic3dRy3xImpS90o+HMH8lUpxiSF6Zf35kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(38350700014)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lVZjJpZFQ5ZkNJODV5MktOSHpDSWV0aEdjTzYyM2tnd05MYmJxN0ZCY1BW?=
 =?utf-8?B?UWpqVlB6WmZWQVJqcDZ0d2d4dkRSeThYNTIrQmVOTHJBS0xETXFVWEhXZFVB?=
 =?utf-8?B?VnFFTi80TGtIMS94dFRoZXRHK2c3Sk5uQlFXVFZrYU5DV1hBcXBJNnFxVjdN?=
 =?utf-8?B?VUh5WHkwZjd4ME5sVEhFVzNZd3NzRWIxeGVXclpaN1lpRDRmQVpEYlBsTFlx?=
 =?utf-8?B?dFBiN09MWHBFczJWVVNGenVjeTJLc0ZhS2pxTTFBMlJ2OVNWWWgvak44Qlhr?=
 =?utf-8?B?SitQTzIzbkRqNHdoSllEVU03eHpPU3BodWR2cjFIOHdXTHJzenFMVzBBM28x?=
 =?utf-8?B?SStZcEM0VFNQbGxnTWkwaXVBeXBJMS9xYjRwbVZQUUVwdEZ4WnM0TE9zVUl5?=
 =?utf-8?B?NXFQcktxYzM5b0VvMk5MMFJlTjg0djhienZVS2IwUXRUVTREMVFWZ0JhN2Rl?=
 =?utf-8?B?ZERpbGRtdldOaGJ3ck5Db3F4MGMza0djTjJsNnBIa2ZqSzRzQmdiT1FEbllq?=
 =?utf-8?B?ZE41eFcybkpQMkpLdmZEWTRvUEFma1hCT2VQQjNEM2F2R2ZVd1RaNHV5WDdY?=
 =?utf-8?B?ZDlCZStZZHIxSU9vNHlZYTZBVmZxRXlFZWZScWpybGgvTmVBak5UTXJRa1Bq?=
 =?utf-8?B?Ty8rQ3FNRi9naU5hT28rbWM3VXRDZll1MVVlS0VZd2dzdkhQM3VJMGoyQkM1?=
 =?utf-8?B?NU53R3U2L24yMGdvRDRWbU03U05KeTJxOWFtTU5zbURsaVB3RnNUVFB1VGpN?=
 =?utf-8?B?TVZOc0R5emlpb1pmektxcytDSklld2pWUkh6dkhMVW5LU3d3SlRvdk9NSDF5?=
 =?utf-8?B?MnkxL05QTU51VDBGSmRtZDBCWFZEUEpzaVNLaG9uNU4wcEdudytzVFpBRTZN?=
 =?utf-8?B?dm9kQ053dzdxU3hKNGZ1NzV1OHpaelBBSWdFMFVxcmVHc2xJT0hFME9kWFpY?=
 =?utf-8?B?L1ZXOVdZRzJoWWQzL0JweSswS2h1ek5YZ0gxMTNZeFZGbExpUzdsQmxmMHBS?=
 =?utf-8?B?K2paeE02eHd6YkNEbnI4U2F5VVI5dXh0ajAyTTRpUG9XdlZORERaMjVFZ3di?=
 =?utf-8?B?RExJOVR1S3ROMkYvQzRXY0pLQU5YY1VadXFWN3RhVVJLcDlNbC9IempBdUJN?=
 =?utf-8?B?Q2crZk53TmwzMHl1NjBLVVpuUmRNdkVCREUvS0hoc3Z6UU1pcVcxYTU3WUdj?=
 =?utf-8?B?YVFrMUxzT2tyTmRJUlIxVzBBTXkyQjNKeXNycG0yZ2RrK3NKRXh0ZWNrKzc2?=
 =?utf-8?B?dzJIaFNEaTNyVGM0ZTVZcGY3VnluTjhzM1NWeC8zQW5rQXl0ZG1YbXVtMUNR?=
 =?utf-8?B?bTJoRVlXOGJwQ2t0ek41anJleFJXYy9nMVR2d0JQbjVlMFR6aThkbllYdHh0?=
 =?utf-8?B?MXdJcFhmKzl1YlFVQ3dWbmpmRTVzdUorMHZITjVGcElXMHlhWGVpNW9CTGo2?=
 =?utf-8?B?d2djUDAxNm93OHlFZUh4LzZEcytIdGJsVTNINmxWQUpDb0M4U2VhTjhuMmVa?=
 =?utf-8?B?ZHJKMC9ObUZDVjhsa0FacWNEcFZZQTBOVzgvTFpDdG5kWTc4KzFUaE5hdmds?=
 =?utf-8?B?TGRaTFdVZWFFdDRhRWEzVWNZbHpSUU16M2sreUVFNmZWeHA0U3hLcDlzZGhj?=
 =?utf-8?B?MnZqS3QrMkY5M0huMmxRbHNxYkg3R3NOTk5WRzdLTWFlWGM5ZnNTUDFUakJa?=
 =?utf-8?B?UlVtWU9lMkxocENySDc5ZG42dDYzZVdJb2lwZEhLYzdiVVdRbVVFWURQWWpy?=
 =?utf-8?B?YWRQYlU1OXpuaThtdXFrZ0c5bWZuQUVreUx1cjVMbC9sQ2xRRUtPT1Qzbzlh?=
 =?utf-8?B?UWZSeEVHY0FuYWl1WERsdlJublNiVFZZN3d3dVFvb2JvMC9kUXpnWmRxcTZT?=
 =?utf-8?B?ek9EQXJNNkdPMDlBN3RnTXNTSTJNVkV2Z1FieHRha3NFY1JiSCs5dC9Qb1VO?=
 =?utf-8?B?YWRFMzlhUFdkVXFYcmRkM3lzcXFuZGVnK2dhdjhWT0ZEa3ZmUllNWVZ6L0xp?=
 =?utf-8?B?cnBUVGFma2FhSXlJY2xvZktFaUl4Q3NKMmx2UWN0Y2l5L0dOSE9paTN5bEVz?=
 =?utf-8?B?VDlEMUgzU1hZUVRwQ25mcFNqODF1eVErbnMzeFBlZWdEeUUzOUx6a2x3R3Bv?=
 =?utf-8?B?NTN5K1k1RkJRa052K3JMTE5BUFA2ZEQxVVVYZi94bTlCS3NkTXVtaVdGU3BI?=
 =?utf-8?B?ZkphLytybnAzdk1tWTNybXlRWjM3dkpTbVQzcTQyRnVNWTQ1d0NDTlFPYnJH?=
 =?utf-8?B?ZHNPZzR1R2U1cW5XN0FWNkNmNnRhVmVwYUYwS1RpRVAyNzBTdWlUdTJicGlr?=
 =?utf-8?B?VS96akwvTVhsVUs0SDgzS1BBTHpVVGJXeEhBandiLzNzaUQwTi9DU2c0WmJH?=
 =?utf-8?Q?egdUwbh4amqnEQzo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4519f942-f3fa-4983-d142-08df284b997f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:47.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVTA4hThWz8V3m6mV2PGvuMMMrCtA5Tf7HfnrFfLuPGEH0WNhqI5ckmC2oM2ehw8HcrHGAEC8PAuDISVAt2JTiWqlML9VSQ35Z9mPgZUflo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11921
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
    the device is started at vm_start.  It also marks the ownership as
    handed over ('owner_handed_over'), so that it's released if this
    target goes away.

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
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   1 -
 2 files changed, 127 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..4ff58a98019 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -88,11 +87,40 @@ static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
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
+         * The ownership is released in .pre_save() on CPR migration
+         * source.  If we end up here without it - that means that either
+         * CPR migration failed, or we got 'cont' cmd from the management
+         * (e.g. cpr-transfer target died).  In either case, we need to
+         * re-acquire device ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (!vvc->vhost_dev.owner) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +151,42 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
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
+        vvc->vhost_dev.owner) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
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
@@ -134,6 +196,40 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
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
+    /*
+     * The source has released the ownership on this FD for us, so give it
+     * back if this target goes away.
+     */
+    vvc->vhost_dev.owner_handed_over = true;
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
index a964d57e1bc..84f4e727c70 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,6 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


