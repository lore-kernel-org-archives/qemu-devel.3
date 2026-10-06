Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB01CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7Z-0004dc-TA; Wed, 07 Oct 2026 04:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4s-0001G4-Nu
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:28 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4P-0000sp-7U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:06 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW3yXCBrQFPv2NVWgJzYu0xZL8rsPmcqzjLzZWMpzO+/4BUrvz/E4UdE7RAFcNx1qKdW+E1xQS03pYq024CUxn7fUJJfGwOfpiAkOXzMnCpuooQW4C9Dy0hfhvcqXlsd59aXGcnLepxUkfCJq6OhprhyOmcU2MaAs7F74kL4Dt8VCbITsNg4pPqnOjw3Vmnnv+Ftw4Ho8TDMeMTsNXU+A+kDk82tAOQAJ+KcE6KfobmuZ6do93W8ihD3tnno5CrhD/1qGszSPwsmVw/lBIZsrdn1yT1sYnyfr4IRJuZO7MvgAlWkPzLg/JdZMtsX1nrjWbJb1xd60wsq8R0SB9a6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=lq8UpBm/3tlOsfLNB4qjBw1uIyWT3nU/F16FKOhO9npoWnU5X9cFLReBZ4UmkelWa2jkZ1QdlLiJ7xTpH0+Avapq/KnXg+Gm5iWfQU3MA++CdGUM4Hya1Yj48RdKeQ4VFC8fZkUoy/Hd1e54OME1GSXPqA0ovjX+QzdffM3bdHS2RZJCgicTZet7efsM+K3912KFjBRYAjdpWgvu4dhpP0MiGZrcvY2CzafENeczPrYaVE3UA6Os0o4TVNqdim0PNdCTHWll5oMSqY8M+C5FHFnrlPzoi+1WaDrhGF/mzCyhiKIIF+PSaDxMM+hybfjFBnoHrWL+O+almjOtckHXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=n8o2oC7dyfXI1SDuDHJze6SdsjmyOajkKKryWZ88uPvKCaZqbMsFiILipabHibJ4YxHwayRoJwtk6YH5UnUbtHeL3FlS5bwSpXoz1w7RAUeI0F22LPNnN/XiJtkCnb5B7UzWiQJDMB0GmKGqbOwcyIhPgp3p5ohtyNwXdteqHLwqbA5GbLtM+9ZKTcU9O8Iv4Pvo4+QX4VxcSc6t7E3zs0u3NJmspvrU7/UNQZvtGr3V1cxO5PbtnUCuLSS83XZGQYhIyroVt5D6Z+jhiKRb0cF59V/PSP8kE5+S4BEdtvIM+B2jQpZ/rnxzrRvipQ/+W6oqaXrBp7/5yp3abgvhAQ==
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
Date: Tue, 06 Oct 2026 16:58:37 +0300
Subject: [PATCH v13 14/22] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-14-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e98ee7-3446-4bff-f3be-08df23b1f782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EeFWcs8LEfKGCY0YyhLwhjcxs9GBuEvSLqaaoZzOGK5M8X01rmhcdFXEo0UVoFKw2J/OGkdfLJcoIHHXJ1c9shK9u3nNjRY1SJDuj0ygR4LjPaqjFboo/V0V50KxHcRA0k8Gyghh2xgHS7j5OzI7J0j8TivUwWk+k+42EfJuGA+xklM5u1sFUwB/4dxcdbI/coWWYPQWzJd9FJ9zhq4oMfUeJ03qN1SWYjEQcRpu5Gw3p34oE1ZZk+zG3dAQbQ1GPcSfu+j2vsm+c+V+NKyRXmmu5OiRUuAwMuY1oAF+CR1r3LMb34iEJuk/zstO2G72oUhFnG8oQ0CrXBkm6u3whhStobWdhAAi0r1FkxMhi0zMmSGALG51cD/E6NWIWFmXq4BlUfnpao8wfmU/XPpKWYJBJC+3fBRS+tqvqtWo0gK+5tj/n5OEpK7ck05mr78fWpiKoqoTZMh/DlNXZJiAyCgY+gMGHXe92RtQX88TMkrw0+OmFprfi0AKdrA3I6u92ZZlPjx0ecequAluL1tG+rqmfVOV73Z7JNmVZODeA7o2rICNxuIARyBHC8/6H0+EDLMpJWuM8+pQxMOantv16AviPWpY7YAXIJeGNU2fS7yO4AIpvoU3EtzEqlPzfeiCmZdt1pcFLeFf/K6prI8W9SfUFE7PF/d9ZlvL4xTAdIU6ovdjm9vq5PPIOdMc2x5SC2dzt8HV7DIEiIFa2/KGDszc2E6wLhg/9P3wxVQrIw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDAzSWtEWHJyVGpRa2FzS20va05FejJXU1g0SDFnbCtkVlZtY1l1VmFQTlRy?=
 =?utf-8?B?aisyRGNuV2ZBcWJGcTAvVkxpb3d5dTZiUlVVaXpXV1pva0phazNPUEVZUU13?=
 =?utf-8?B?bXhHZzdGNFIxMDZMbSt2QytTbVNNU1dtWmd3emJ5bHN0WDMwQVRpQytMbnpN?=
 =?utf-8?B?dm5KYmd3blpoTEMrR3ZUSzB0WTdQUHQreUVNano1MmRuVzNveTNRdkZob3Jv?=
 =?utf-8?B?akR3OUxjeERRMjdyOHhERGVmNWpVWEliNGtYdXVGMXV5aC9VZlpJZmdUaG01?=
 =?utf-8?B?TDR0cE5wa0Jvd0Q4STRkL1NLa3BUckQ2Sis2L3VHZzFmRXVqcVJsdnh4eWJ6?=
 =?utf-8?B?bHpKajgxa2hIZCs0Rm9aOGcvUlozUXhwaXNLam5vbVFDdHZMS1diNjJIUVNH?=
 =?utf-8?B?TkJVQUNqcmlnVkcyRThyTW04WmVPNFBiV3FLaW1rT0NIWC8zcEdsOEQvOEJO?=
 =?utf-8?B?ME5Dc3hJY2xtUTJXZ1h0RFJJb1FMdFQrcndydSszMjFGazNGczVxSEdxbjVa?=
 =?utf-8?B?UC9CMjM3OVNMUmMwZE4yVjFyS3RRTmlNR2VZQS9GL0VGcHZIaEhNbmFWOUxo?=
 =?utf-8?B?eXF2Rmdud05GWHVFR2V5S2k1Y1ZIVUFSNnNXN1I0SkViYWxtdlFLMDhXWHR4?=
 =?utf-8?B?Y0RnaWIwZ1ZuZWpCME52d0kzZ3p3ZS85ZCtmdXJ4bWFQSHpwTkRNcGNkdEVR?=
 =?utf-8?B?aWl0N0taa3c2ckpWUXgrMXFvSGFOcEZsbFR4WjltUzlTZHZuU2wrczBPOWhG?=
 =?utf-8?B?elh4SGo3REh6QSt3Sit1SDdPR0hKRnhYYWMyZWZmQ0IzbWowSHhwMEpVaXFC?=
 =?utf-8?B?R1VWWk1GRlAxaWVWZzJlaytVNndRN3dkYzd6d2kzN1J4Y2NqODBaeDdHRHNK?=
 =?utf-8?B?TERIU09ja1hpKytqWXMrUmNIZTZKczNlL3FnSS8zb09zSTB5ZjNhN1phYjBD?=
 =?utf-8?B?WUovcnRSdlJJT3M0c1c1RDdkZFg0TEJBditITjlDUU9rZHJ6UWZyUGN5bmRI?=
 =?utf-8?B?SSt5M211VFpIZ1M2dlJsbm52S1l4bi82T29xbVVrSDRGUnZoV0VsNHRMNnNQ?=
 =?utf-8?B?VG14MlFCT1RqZDFvNUpHaHF2aENZcTU4eHdqUTRLcERIcXhqNEMwUklZZTdE?=
 =?utf-8?B?ZTNFV0lQbHFYb0FNZ29yVW5hZVZFWVp3NWkvZDkrSjdhTXVGbjVybHEwbzZv?=
 =?utf-8?B?LzQzQW41dHY4Q3ErU2Q0anI4Tm5Id3QzT0dSQnM1bXFidXY3OGErOE1VTllR?=
 =?utf-8?B?R1FrVGo4RzVhMFBXaGFTV3hIa3o2NWliamwxb2l1ZGg2UGdnOWJPOVFEaDE3?=
 =?utf-8?B?Ri95aHlOS0RqT3J4eGk3S3VhQVUrcHRuUUJSaDN4ZWZDNGluTC9DZUNVVk1j?=
 =?utf-8?B?KzZRUWpsWE95WnlCOEFiMzRYRVAxaVhKTmdHNlplTHBBVXN1OS9wSG1tWU9v?=
 =?utf-8?B?eVdITFlUMHVOdzM0dDhIdEdJSDZwd1hEaGkrN1lKU1ltQ1k5SU5QeGZzanAv?=
 =?utf-8?B?cVpLSmI5Y1RZeEZpZmFaOUZpSXZ4alpORCt3eXFVbkcveUdIaWVXdmQ4cVRK?=
 =?utf-8?B?V0h1OThxMlRnL0tiQ2hWbThtNERDZ2REZUkwZ0taaTVkSWlUbmt0cytaeTFU?=
 =?utf-8?B?MGJRSHZ1dEN6Y2pSU2IreE83RGhINFZzbkZFT09qRDZwaHE5YmZYM2lJOVA1?=
 =?utf-8?B?SmxsWHl3eUVJbkxQWXI5WFlZL2U4OUZTcVhuZExJNTc0N3Q3aTBTZGxIeHBQ?=
 =?utf-8?B?dHppQ2lORDF4d0hFa1VVSlFyNFhtMm5TK0hBbCttNDZxaEtVWWY2VmdFd0lG?=
 =?utf-8?B?cDI2Q0dyd0NPc0hwa1NoY29rZ3JQcnNISzlZZkVDMm9Kajd0Vmx5OTJwYnJq?=
 =?utf-8?B?NDNkdG83RS9DZWQyMzR6bXNtSk12WmdibFpjZ2I4KzloQ281MktDaXNyZHN5?=
 =?utf-8?B?U2VXb3EvVjBEWm1DL0U3NmNWaWVGVzlQSExIYVNLV3pqV2lZZEFtWnd5TW5q?=
 =?utf-8?B?VTNybXRYZlp1eVhpTlNxcnY0WUJHUUZIdEhIL0lzSlJmY2o4SzNycDI0Ymww?=
 =?utf-8?B?bkpkdldmRlF6RGJnMzBORXhFZkVSM1hzdEFWd1Q5Z01sVXVaVkJVd0lvRENS?=
 =?utf-8?B?U1M4cHpyOWp5NmloL3UvOGJhVDFKTmlKdjQ1SllOUk1pSjVXcTlVQTd3bVI2?=
 =?utf-8?B?SUc1VlRrVXA5UXdhMW5VTFByTzB4RnhveFJZOE0wcnJodTBSa0tFRUF5bFdN?=
 =?utf-8?B?QWdLQ3dhZ0tKTzduTkg1aG9Mdlh2TGlQcDljV0w4V2JWSyt4eGRtbXFOaUdv?=
 =?utf-8?B?QzIrNk5TMzFkcWVqdW1NNFoyNDJwU2NuZSt5U3lkdEdHTDhmYWJyVmVHZ2w3?=
 =?utf-8?Q?Qcv7JKGneEMwgbxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e98ee7-3446-4bff-f3be-08df23b1f782
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:57.9707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI0TKN4edS8xpYR1MUs8Byj0A+W7GaAkjVvQJrkN0r2Q/ZlWBBG/kmbI5QtI7Oo8xu9yPIbilXK8emWCQnlHRikSkBlBJ0gxvQb4iMvetTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa4345886..c01ccc800cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2c..73ea130d7ee 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {

-- 
2.47.1


