Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7900CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJj-0000kd-0I; Wed, 30 Sep 2026 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJg-0000jJ-PB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:36 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJf-00045p-3J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqY7z+elJYjapvsI97MaTogOZ80DkQcCp+BQDiMNiA47cARqcEzhCCkyI6ufuGs5dQ6DzpfsDeWqSXM7RgV7TvgDwPBH/GWsNLXi1XIOePta+NnsBAzSp7X//J+caAOvJ9EAyvlQkIxvZdRwuBC8KvjeuxD7O7Iei5Z/JTpo2DqFaGhq7Dt/aOydpPgscICdroNr0EbrfdbWwznb3IgydO+ihcCF1YCSUvfj92fp9FdcwcohpWl3c9YaDph5x1v6DMRHcprTFgM2ew9VSa7UPhmz9uptO9abdnnAlz3GJ14DcHhvAxKvYuC3rLkOMy9iUJHijevl9WuRPjTAPb0e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=cCsEwmgE/kgHPEqjrs9PoFgLyfuP9OTf/wgT0W/3iMLK+IqAfuoptsqqc548O69llfjS1rZ4cb6mucIFnh+zmBakVf8CafpRbCJ1swe0SRDGkEshxFQMGogVOLoU+LAGVy2B7PRW+b5aACXxEhCVQIXME+9Ig3IJj91n0nn/znItX5/Tdwui/ToyY3kjdeNjhY2a/F1SR+GxnOHCy+0MDHGjVz3Z2DUSndjIH/OLMoexOWalpg4enNH4m900zjX0a0Gexkiv/5QCVVV5ByibYWn/jtjbJ4aHsAS8aiQbuzyUu1F/so5gOU0cbfWBzdZ5kqeIf6vUxkekjqs5kI+cWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=sGQuEUrjx8kHscxI0yTkABrwvLvpaLM97m4DkktDmW56eVNi7VTTiW15uHXFUeF8FqQfso6DN6B3r1Lblhs1Reokk5d5nrSME1IzQG3QJdiGCwcszuKSsm2GDE2FOgZwtHiL0hat4QCzh5EXVQ2CvadiGB/F41QALTb7FzK6K0uTYYMTZTxekcOnwwflX5/0Vz3CcKWJrjWmDUQNI5A6u2MUAAcTgB94GRtH/TK3kvEdMx8c+H+FT2wovCPtUM2yfn5O1ABhQVzO9weg5JhPLjIzuFJpRwhCq/YBUWc8K00sm9qxAGhEtATeS8q7WedeA4JkCf5L40NbC5MTAOdcNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:12 +0300
Subject: [PATCH v9 13/18] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-13-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8c39ab1-be17-4678-7a23-08df1edb76c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: lFAYiYg6d4wx7u8IiOeM7VvC+hE3+fv151xr4EYSmodfjOzliqQUanfTcdCUCO+G5s1wxRl1cbumadZhHyZDDuMydslzZYyYVoJjECQhCSw0hsElQ9y7FC2HSr1T/EFYXN1z7/pISxaiQVQQCTL3kUbcOnByZ/GNo49JsMMP9oVan5rQvaKPWyqqNIr57pjdo02UKu6IPwyLVF1nYzvChBSTyvJtt//6AwPdF3OE9p2LPZ4LehQIiYPsBwGUAQi7dg8vr/oGFBRlYQovmlUn37bicdHdFYxc+h7O6KE6Euot4BPejXm0gQPSr40/iZkgDaw8h2A0sqCdky86xmYKfyVBqFIGuaGEhsCrPGLb98MnTEBkT56o+khM6Nl/tcUZlg8/+g1PB0hevbZGEBz7wQmEGIuRVM89c/19HItZ0syJJKstlAnQafRrJg/BawpWpruNOncGBIUAC4ciHh3y5TS/McTLpeELslISJIlDS3EKmqNfCp2nzfpmwPFyvfECmuRLl+3063DVOuClyiogNlcDXbJy7ncbmgDElBc7r1U7MdvSo99NrPuSNPqdyNkT7YWOIU0XXp6N1Iiuf7XMdRHmH55L21KIZYjAE+bwSAGFTEUsPWiN6bHp1ZFR5XcLHDvNkxYmvgy3BXzBCa8n/DB66ZXZBOhpLqUjQLNnocZTz1MhwJFTYuidSxWy66IAYBoopf+TSrtm5gqalzZidReRk2GEKKO+dCd11Mpbhm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUd2V0tVUkxtcEdob0hMcFBTZUw0K2Z5MFN4UHBJVitybzRhaWxPaTB5Rkha?=
 =?utf-8?B?NWgvZlFnZnVLcDNybGdGam5CZE1RRkR4dEJBdnM1cE1CcEhOSjF3c2FHbG5Z?=
 =?utf-8?B?dktneHkrd3pEcUdsQXBYQ25iYjJwTXF0SDFOMnNWczI0UFNLV3dJVjVFQTRz?=
 =?utf-8?B?T2poZFdnUkJhMXBpQi9ZZ3RHWmoyNURiNDMwdkFJelZEck9nUlhScFdRa2tt?=
 =?utf-8?B?akw3ZDVBbGhFVmhZaXZNNWRYTWZnNkQyM0FCZU51L3VIWnQ5cncwODl0RVdH?=
 =?utf-8?B?ang3ODJyUThJLzYyS094TEd6U2JEbXFzN0JLdGJTQWZaMHdublZhV2ZxR0N1?=
 =?utf-8?B?R241NXhlejNwMlE5OGhjRFVISnMrd3psVkFSa0FWV3hibEFXT1J0OXM1MkxF?=
 =?utf-8?B?SlJYTDQwcUhzVDJnRHBoc2RSTGVvbzM0eEQvdkI5USszMi8vV09Ta1JJWmpz?=
 =?utf-8?B?OHZaeWNtSmd5TnNyU1ZaRThvaXc0T3hOb2I2WngvaThvMjBLYzJpL28rRDF3?=
 =?utf-8?B?M3dkajJpOTJpV3h1K2FkVWQ2TWJ5bnlHNWcxSWlFWnQ4STF3ekNWWWVUcUdL?=
 =?utf-8?B?VEVUQzIwaHpSZ28vSk1GK1gxK3ZHRVBxelQyUUNQTk10MlhtUHo4YXNXTGln?=
 =?utf-8?B?Y0xiUllDQzZGb29vQTJvY1Q4c1dCQW11N1Y1bkFXTlJMdm13UnQ5WG9rU0F4?=
 =?utf-8?B?cE9DMm9xZWl6KzdNNElHVEUyY0lIK1B0TlFGYkttRW5JT3VTR2JWV2JaQytL?=
 =?utf-8?B?bkJTNGNEM0RIVERGYmhhemF1MzF5M3FSQmVhVFM0Wnh5OGZXeVYyQmRwd1Z2?=
 =?utf-8?B?S3Fha2tNRm5WM3l5Tm03a3dqRlh5SHYyNjl5czNMeXI5VjU0aUhtZzRJZEF5?=
 =?utf-8?B?aWNrZFdTbTZ4Z21DdFl4MmNIMGxWYXNndkgzUm9FQWdmSkxzTkRPTWJ2UTJM?=
 =?utf-8?B?V2V1VEU1S1Aza3Jnc0E3c2hWWjFPVDFuL2tkNUNRREVRSlM4RUo1cCtkc1Bh?=
 =?utf-8?B?ekJCMU1nZkNNc1NOMTI1VnhSUVNuUkxPY2RPR3g1ZFIvU0Z0SzM4RUJobE54?=
 =?utf-8?B?d0FRbjlHWE1VZ1JORDBDejNwc2lZVlpXVndqUUpkK2xjaUNXYStlblZzZmJC?=
 =?utf-8?B?SndlaWRiTFZRNlpOQ2h6dDV4VlE5ZjdFdEZidmVtTk9IWDdIbUpPa2tnamdM?=
 =?utf-8?B?OXRJN3RCLzRJdXBSNWFHcCtMZi8zY1VvYWpMNjJUZ2ZQcE9TZWxrL0wwYXZt?=
 =?utf-8?B?OG1KVnRtNDZqTGdQekdFZ3V0U0R3SGVaOCtkTE5MbTFHU29hTjNjV3QzenhW?=
 =?utf-8?B?VG54cE15by9WamVkZnRWY2xTL2YxbzZmU2pZMjlQQTZGelVVYmV0NkM0RHZO?=
 =?utf-8?B?bU5vOXpzS3ZRVE1kdU41a2xvSFN0cVdIZnE5REEvWmZWZ1QyTlU3emRpaG9L?=
 =?utf-8?B?OE1jWmhQUFdwYkhlbXlMaEhWOFJpeXBOcnBSTS96cjcySE9tV21DY1lxYURO?=
 =?utf-8?B?Mzk4R2NmL01TSndjRHE3WDFvT1ZBQ0R4L2ZFai9uQk9WM3N5dUgxQ2RmY1Ix?=
 =?utf-8?B?UDg4S0pOVUV2cjVrYkQ5Nyt0d3lNNGVZT3NrOUNrM1IxN2p3aC82RE51RXZx?=
 =?utf-8?B?dUNCWFBlT3U2Z0ljejh0cmJmZW9NL052clVCY1E0TVM0Y2dQYTlxYlppOFBR?=
 =?utf-8?B?YkNGYmJFYStKazRTZk80NnpJSHNYQWM0eklZVlVmTmd0RDNtTm9iUTN0RW10?=
 =?utf-8?B?Y0hsVlowUWdtMnVpanIwb0kxaEI0K1dndnRwd1VpbndRaFFYKzZyTVJ2dnhx?=
 =?utf-8?B?dUdqRDRsZGRsVkR3ZzRtcjZIRTN5eUV1dUFQRmFKVDFERTIxZlFpOU5uRFhY?=
 =?utf-8?B?RTJFeDBKeXlrMjNmVzhLYXhCMUhKQStNLzZsUkVsTmZ3YVFiVGt6UVU3SGpa?=
 =?utf-8?B?MmVLK0ZjbTRwaURmdEVEblJuOHFyc25tK3hXbHExVkRobG9lTlkweTRMWFQx?=
 =?utf-8?B?eTV3V1lNOEowZ3hjOGZsZGxHTldVSys3RlplcnhGK3VGeWtGNmhNZEhHV1R0?=
 =?utf-8?B?aWFFeDBIRlIzYlFMOTZFelYxdW9oY0dWVFZLbEs2d3c1blVaTmZvZDlNVnB5?=
 =?utf-8?B?cHVPd2ZlSjN1VUJRSXhOWGlJclk2VFZFNlU5anIrMzU4K1lrZnR6SnFHdVJw?=
 =?utf-8?B?bW5VckxQQzdYQ29uWllNRXhTbG1LaHQvTnZoV2ZnYVBJUzVLYUEvekdUMEEz?=
 =?utf-8?B?c0crMHNHVmpzSHlnKzVsV3lDSFA1Yi9hS0JTUS9udkhoS0RMTUpWaU5KL3Jq?=
 =?utf-8?B?VEZjRFdjQVhmQVVBWm5hRk16YjlTUTBGT0hzc2V3ZW5EdkNTNEVodUdSY0NG?=
 =?utf-8?Q?LvI5NeozkdYVg4dE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c39ab1-be17-4678-7a23-08df1edb76c0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:24.9824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcbavs1dwCiLvughiJFFdVoPQn+Zv7LT+dGqa3Y5szJywasKy8wJQapizZ+cU4MQbNFiVx8+UNObBezWy4JPkY/0lUBqeOUYb001n6cDnww=
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


