Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA7CC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aHL-0001XF-4S; Tue, 15 Sep 2026 17:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGz-0001R0-8w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:01 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGx-00011o-QF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txYHLsGL8DYBQFVBV4lF5KKFBXyalg93cl+EQ1iwyJa3TUHA6+6aLNniLJu5ji7FJ2kvGYUpngz0j5/0xkrhHCnFbw6uenAkjMgQue1aP8IDtor3hjlYqz13vXyKTsB1U4i7AUaocHJYWYyOP1DBx5D3aIJ3zP9MNQS8RXIQHVM8tYupjzvxSIMVpj9PXu9KRXyIUdSblW0lqNRnk3EF0/sN1VkfvvV50ogg+UkeH94INkoeVHgO7UreJj9jIIkhfcqRAHY+N+uJj99gV+pnBU6GgbP1am7j22r3kdUlpcjGllA+FLbOr51gtnYabrzZN3a88oGPbAQhtLYl8jyDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=PXTEkFTVHdm0p7SK5eMBTgaTn4RvT9Jvzj5X6FnyQO4Qrm0oZZL2ucgK3G52NoCJcAvfrOmER/rVxOThpa1t9dX2Sr/kf7nueLP5c26WCNH2a2hZeFGhjOPKx3qZ6zuYPQzu6RHr9sa5QWuEt0vwNakzz9wz7GE7/wI+59LpOvEx3CkJCfRK30K70Nrk81TPRsn6ei0vphEWcBrzeLiXEyZzxVh9FhrJgz3/J0FmZUiEZa6Q4KNQndesXJo7e9qGw2j9hDGNI6FkkALpbSoEcJZTmTT13JwCEQMrV7MS28AD1yFn0GGZrYHFyZsfjSyKzwwSJcEcwshkad2cxGMXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=M21L6lbJDqYgn+SeYgt3+juCnL2RLGiL4cSErGvkwlQoFbdFM+VpeW8TlToHdniLeHYpNkV/6cEsJXiKGroYkvXDQHaXuhmJ3e0HspKzlA4rh6mTEniR52gJ4/TUi1GBsuJMfAsiMzPO5Jeu3rC8ESdTfwrciyhscXQT/DFNQk8q0CtocFrtOO4bGKYTOZbylpBp3ZHKqwr/J3qxWLLXWIBPYeReQzr8J3U4Kd7aN7aI/csuiiFqmF4pJsiTie0PsCxdai1Rv1J6yGIre7F7fUOJy+8KQnG9ZQWKLypnvRNHVc6R2Tnl1/TMSph50CsODeOFgYQLva0JYWb3s3WE1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:38 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:49 +0300
Subject: [PATCH v6 13/14] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-13-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7685162a-4cf5-4ac7-d57f-08df136c64f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nIPW/VigsaJFVnXxi5D9vrwK3rI7Q6mA+mJCkewXlwBfBd0/uhJQ4beCXei7RbBwG/g5vjrhVzgx+5F1+fhVh2HxZC1icpFxL7mX0T+0MufjS/zwpCOe2Z+cxLQCZaqGqlcdXGQnz6M34OVDtF6MkcR7DiI+ZqqWfnNUbuHqKQ9DZwCw5Cfdm+dQS9lZ4GOIE5DldqMrTtA1IjyBl0yfk+4YAjB0YpRzvs6/3uYyzAB8LW1RC79BOygq1jA+dvIN6Ve0dwcpxsQ7geHMQfoOtnWGyw80BPhwjvydv3EtVC8CGbQ03CY1esq+n7S2aEhTmASB5KGzFf948ScUyVSvtiIJMui6YqoBqgjuXR0hnRTWmr0CKVGwsxsQ05ZgfOofZAqjeC8DZkokq1He2DP0S2TMxHdxi+d6UZywVoA/3xSsvV6SJTklDLRPY7R+3Voic/KlFwb7JxOnJeSRxSy0T2G8zwc9AahpDA5Eh8hPl3VkOAKGgDMrrOagY57GQOnYVP/Us/IKkSxDvzhWnJ3yOJESryJMcXEFPxqDSm1TrOVzsMY/4hnN65YFRo8UCPQMMOll52eGJO6XFLbpRSnGsihdEmGDUVEl4fWJjVs+KXe+21NZiCr5vpSTvodlL7LXMuPt9gL4bvHmyK+XOv14PxBzs610wprfL04VIJkrkug9hNYKXqv8PG9r0Sw+TSsQ9l/6LsJfQ5/cOt9NBZz4cTE/sDTkfWHDptuLVzoVTfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHRxTzNCeXBhczNVTzd3SURWYUF0NkUxSXV4eXBsb0psMHE2bW5oaTE3VVRt?=
 =?utf-8?B?clRUakcrd2x2SHd5aVVyLzhaOFFLOFY2UDhYRm5RREprTUVnS0FvRm1nT0hE?=
 =?utf-8?B?K2Y3M2EwdWhWN2RENzNTUFVsY2xHU093a1cvV0pVTmhNQnJLYWJvMWlJUS9W?=
 =?utf-8?B?eU13anMyUDBUUzg1WGU3MWJZeW9QZHh4YUJGY1lTQll6RWkzNWI2dFp5Z0Nl?=
 =?utf-8?B?VnNsM0JvVUhkODNIeTlla1JKQ1lxS3JicW93My9NY3VWZnZrQjVLeU1ZV0J6?=
 =?utf-8?B?U2l1SnJ6eXI5Q3dWK2NqYmlkbkJiQUlkQUxHTmcvSHRtUFd3ZW10VDZEckFs?=
 =?utf-8?B?YUl0enRsZFZsUGZXN2tIc1pWOHFVMTV4VDUycExBTXNoallxeUZKNVZFVXFP?=
 =?utf-8?B?U0xJL2w5cnVaWU0zMWlxMFl4aTM0N0lmcUZhczZxT2U4bnBRNjhmdW9IcXhE?=
 =?utf-8?B?VlJsdGIzWC9XU0NvaGR6eVhRaFhMa01nRzhodmlTN2NnZHdxZ1lzZGhESldo?=
 =?utf-8?B?RzNnSmVDUy9namhMbGJkanJLYzd1QlhVbHB2NGo1SDRKN3Q5U0ZxMitueGJj?=
 =?utf-8?B?a0ZTWlk5TzJhWXNmME9DNWN3VlJLVERXaGw1cXhEL0pPWG8wR1R1cUlUUFFM?=
 =?utf-8?B?cEVLdko0OWt2NWVxNk9FZXowZGIvTUUzdTU3S21KSFJsY0hDb3lKczd6Ums2?=
 =?utf-8?B?RDBrOVhXUG1uWWFiazMxM2NnU1g2L0FINCs2WXBxYXducmg4U1V2WHZTTU9D?=
 =?utf-8?B?dU4rMXJpTldlUXE0N3hvQUlYSzFxV3h4bExxRmdua2dWL3kzaTlVdzNMdm4z?=
 =?utf-8?B?VmFsQ0d2TnZQOXdxY01ZQ2N0c0pEemd0RVVIUUEvNGMvRVlpNTFJTjZLMzZ0?=
 =?utf-8?B?RlpHNktmczRKUkgzelVPN1V6MXJodENFSnoydzN3U1FwYXMrUVcxMXE0eFlN?=
 =?utf-8?B?NU1VeEl2RUVoQVJzQUQ5aWkzNnJSTnpvTjF2Smp6VkRQUFg2RnlzNjBsZ1Ey?=
 =?utf-8?B?MlpIYllHcSthUTQzNE5EUkJBRG1YYzJFWm1GNUpPdEZmL3k5Y2w0TUs4cnN2?=
 =?utf-8?B?ZWNrNXpmQ1FuL252YktsVnl1cWtna3RaemxrMVBCT0JycVh3UURMWllBLzQ1?=
 =?utf-8?B?T1o2eTJEdUlTSGptOHh5Z3dCQXpXTytocm1nWkNTcmlXbys1NFNBMEtIbzFj?=
 =?utf-8?B?YnFXc081Vnk1OG54NVdMU1d2bDNxdE5sdzlvQ0YyZDRDd0pubGVnSjRmc2Nq?=
 =?utf-8?B?YStXam5jVk1OdFZFZlk4aGF0QW1NcmdPNzZYcWZxWVFwUW9xK1Y2NVN6a08x?=
 =?utf-8?B?OGRlcTBaUUFjcFFKblZpNFZGYXBCZnduWEFzRmxZQ2Y5cXBETkkxQzRON2pa?=
 =?utf-8?B?aU8zVkp2V2VmSzg1TzZreFNzclAwak90UWZmeno0amVVQzlPOXEyeFRDYlh3?=
 =?utf-8?B?QVBMOFo1V0tnTnZ6bDBYYkd3L0lkRFg0MzFhTDgwUTdFZW16ZEIrWWhuM3VC?=
 =?utf-8?B?WTlER2t1NTErYUlBam5TMmpoRkpBMkRHTnBtSldzUGtWbEcwOHEzTzVHdGp2?=
 =?utf-8?B?cExWQXpRR091aisyNG8wSnRtajlFeGlsR1VPU2RHM3c5SUxtbzArRTV4SnY5?=
 =?utf-8?B?SjdDbFFzc0dzOEF6cjlhcGFMNXUybm9tU0R2R1J3YlNJaHRmcEtCSUVpeHV4?=
 =?utf-8?B?Vmw4WWp0VEZOcGJ5K1hXY2MzYXU0eTZrSllXeVdLN3drNGEvaXFlNjlvVGk0?=
 =?utf-8?B?TWViWjFTR2ZXNENJZWxiVFRtSCtURXJzQzZkUWNPWjVPb3hPOEdSbXhxTjF1?=
 =?utf-8?B?VHlvUm4xRllVLytZYytZbVhrNlVaQ2o0algrVDM3WWVYc29sS2puZ20xdHcv?=
 =?utf-8?B?R3hxZXVWalJXTjYwRjIvU1E1VzEwMC9LNFo5MVBJeUl0K3RzcUkyZksvUENa?=
 =?utf-8?B?RUlldjk0QmR6cnpndFVnYVhwSFZsT0NUaXo3ZFkweXlCLzdSclJZaElXcHJL?=
 =?utf-8?B?NDErL0d2eHcrZ2NkRlhES01iOWtUbWNsTmtWOVVhRFh0LzdaWlhQZVpGcTN2?=
 =?utf-8?B?TkZGWmdpZldkeFFjcVo0QzJSOGVqKzNjOUhZNzd1dDFkVWZISWFwdGVzNkhh?=
 =?utf-8?B?SjQ0R1FyaGhQaS9lYjRsSG50MUFsT3lCWlhDYzVNTEJlRUhmc3MyUkxvS0JN?=
 =?utf-8?B?SzFnSDlnNDFXU2o4cXo2aTFTbWlQMnNrZEZBRHdUa2NUL0x6RlpIN24wZlJS?=
 =?utf-8?B?WkJMdHRwZjZET2dMdmxmdWxmQmFjRFFSTUhTWlJSL0RjNXJCd0FhUjRndEpo?=
 =?utf-8?B?L3JUY3BnWS9uNEZ3d2FBNFhHNjdQVWxKM3NWREtTRkYwb2VXOXRtU3dYU1Nq?=
 =?utf-8?Q?/0oWQmQxkrCdi3fc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7685162a-4cf5-4ac7-d57f-08df136c64f3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:38.2290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNoIazbzw9LWofXRUsBo6NXFs8S8hqB6Ay62bSVboNczUn7m0VJ81HOma+lpdZimSOrZKFFC9LWSmcCuu6CntmBwbky02h8tB1EhLY1K15I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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


