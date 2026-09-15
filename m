Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D5EC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIu-0003Br-2D; Tue, 15 Sep 2026 17:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aH0-0001Rn-KU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:05 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGx-00010d-R7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ5oYSakBQk4xVSUTzQwhvsSFSEnWBRR3yxKVbLvlKuZsaF1Z4BmGXD7UUb+d86obm6FaeM/1MI4sILu2W3XbLskexhJBbqUhXaZDBRG7icnJBtIJUWCgZvR/wCyIRaNKzy+MdWI0u8PaXqzIVpgo65v0Jm7nxFfLfZWb0mRO9DOL4CGo8TJiQZSirakz4mCZI0fO7mQDIPBQ0elfDJezjxv24ka7/iAUdWwF7H/tkypiQyB4TSQWHZ+j7IQf1BWdC0yFncal0qZla1751k+iDFQYnwOdAldmzRMRFLOfbDtsDVjDyH2Eh7y069o229yn1ESra6zOOIbX7WeP4qYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=fcMx2Za/86///zyJ5wL1idrEWHBxaWIT1VqZRLY5wmKwP/oTrqIpGOLfLI9YTiZpQaK9AGzq9SKhUYkmnSqptZA6qwZYJMynQ5cfX17QZ2iD+hVL+HxIiwMCDU+KUvDQwpfApTlo1RxoiFK/SfFZYbPA0ZETDN1fi4hJ7BU/pOj2T+NyalHCFKWmfDMriQZMjQCLqlLrObBZhtcOSOKYAvP1NwnXZNcnA2uXaCAfT3iELMA7J8L8ayAoSciwmnCaXPgllx1Wl5HQMO7IgwOyKEJT/uJGfHGbv+3GOYATJ2v2bu/aH1jgUVF3Q1wsjXPTKAW86J/zr9VYxszn7NHdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=hco9pbzKUgENVhZjXue18AD/DoSvho/3Slt+W/Uim8E0dIcYTxUdAowVP8JLNBkqlh3guoFNGXeznNOfuXE90033BsfJkOssDtcEezTJqZnbne5i+SQ/kLRUfFhakUMtPdJLl+6hCUk/3sVAVS5Fr20sRbzkKb5tThL6/ekAufvA3HvBEABeJ9yVrNvVkG6N1RNunb+pDG2CiyuBLhmgq17icHx0gg302h/KYDvyOFyCNSh/iCKx1FF43Azh6DWQDOl5qBnsuRV4CJswiT59XwHBLn3Wqt9upaIOfT2uaZF58+SXCy1lxy/VGs2fR60H6UVrfQKyjXgYLAXxcaJ+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:37 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:37 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:48 +0300
Subject: [PATCH v6 12/14] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-12-4d31b2dc6afd@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: df8b8c53-cc5e-4ad3-0645-08df136c6495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: cOswmBOy1p+6ysAbwIfUld8dfG8IPoxkDW/OfuFhg5Kc+DYaRVu3pXeGJ12msynf7ksTGY2uSr0B1LU2Oaev4F0DT6RJgc9mwdpku0RY0KZeP8P2iBWu9xuA9q+M+4gEr7oPs5eylk2wjhAP5039yKqZFt+b13JkPMcXodolfcK/9GUD3v5g1Zlwr7behU8Z87l3LPAOaGjvGpXkmrYFvGL6JBCmHhWhPGTwOYix/6bzatMrLbmG4D7f81S2hIVpEPYSMOQTfSH8eaExzJEg7XXye3FJkI5ShlN4N/aXwLxh03EIQv8ftUrVJVvvJc2f0OHf8Dni4MuWX7zgubeH8wlu5it9qbyKlEba7/aWZeMzeJdfNTa0JQ/WabPRmb8p3OdT1HhTT4GRHDyOPz8FBTk3BLQp7xIWxa+bI+NtvZKKrqOO1p6MfNC38I/ziwNzpABMIa5TOahxHBUwHSnXfnr3AeeL1NyUTizIcJFXoHM3d7qs5UGb4smoCghSJxR1JYJiuFpdvD2AbYXqgszpNrkMfyKWhSiAs8UJtthLTikzqVveJ8stpMpiBjCrAzSbyz7doBaR/RSY3TrvFTDbK+8jt5m8T0I51hN5rPsxoQAJvRh+Gw9MmQLMGZ4aLsNtSPJmjXQkmvQoXBXdsuPSVbKY/6M9UH0y0h3EF3MC3hRkjCNBqQ4zVVBx09YQH9F3l44Bvzn7RkYWy9k7cY89iPqBecPlrZxK8Jpz4puegEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dCS2Vic0RkSWF6ZEdXRFBDM2V6SEZaK2ZyWXNiU0RIcmRrWjRZK3VVQUJD?=
 =?utf-8?B?Q2Z5ekMzU2ZObjIxU0ZPYmJMRmVDR2N2N0k0WjFCa1V3aUl0VUJQSW5HbWVP?=
 =?utf-8?B?bHVXOXZUaXR3eGcrZmoxUFJPc2Q1bitVc0JFQ0J6NHF5RGYxUnpaZENxWUlo?=
 =?utf-8?B?emllZmtkTEJpMnNnc2lOak9KcXpwRWU2OXN0SENoZEZlUFlQSUthMS9CaEFF?=
 =?utf-8?B?bnlSL3N4ZXpweHh6YURWTzZKaFZjRmJZb0h4T1psR1NnM0o5MUdWa2VaRTJy?=
 =?utf-8?B?RS8xc29DL2JYRDNJaHpyTWlKbUZ4QkowMXFLVFhCTW5NTUZwMVZSVFJsS1Fh?=
 =?utf-8?B?NXNFRUVrZUF5enRXeEF5MDcrU3Y2bUcwNWszc254OUpsaDQ0Lzc5ajlKbkRF?=
 =?utf-8?B?T3Y2L1NIL2doTjlydkNiMWR6anpQUStvK0FZL2hhamZwSndBS0o0clNheUxv?=
 =?utf-8?B?OVg5QWs1dTFPK25UTURWbVRzcEo2WU5qNEs3YlRKa0JIY1VGVVNnVFBnTWtz?=
 =?utf-8?B?MTA2NEhJVkFYeUF0dlEwa0VBTWt5NWxselJOWUpYMitxcDFKaW1jNXR6c3BJ?=
 =?utf-8?B?QkZNZ2JtdENmNHNkek9oeGtqc3JZVGU0V2Z3QXhNSnhwKytYai9hMjM5OFVZ?=
 =?utf-8?B?SkZTbmJDay8wcnJiWlBVaDlrRkdYUkNXODNXb1NGbFE0QjlTS09UdXdXRXNG?=
 =?utf-8?B?UHF3cUNuelBiVGpuOVBMMklRWmRwbGVEMDVlRU1jQXNsSEJQTXhXdEhhVjV0?=
 =?utf-8?B?N0hPWkZ0VU85ZHFtU3czOVNiMHErN05JQmdzaXRJcWs0blFNZWFybFZDakJ4?=
 =?utf-8?B?dDVta2VvTzNpZHlmUXNaQ3JGaXJGTlZLZHE1ZFlUWlpGb3RDZit3L2RwREl5?=
 =?utf-8?B?N2dNeHAvVzBHZUhyNHh6RmFSYTdHZ2VHeHFRTFVnMTBZS01jdmpyS3h5ZGda?=
 =?utf-8?B?dG5OOVQ0Zk14TWhmeDl2ZlhLcFpQU1BEVG5oWGkyMURFa0VQOHFnR1hoeE1F?=
 =?utf-8?B?cUpzd2xzUWxadmorU1JoYmdNeEVxbkpzeTBSUmZtZ3A2T3ZIUWx5RHF1OFR6?=
 =?utf-8?B?a0phS1VVL1YvV1hIWFNmNlF4TUV0WHpxNzRNdkxweE51bDNtc3lMVy8vdFlG?=
 =?utf-8?B?R1liYWFXVmpwRE1ENDE1bEUxMGpyb0V5aWdDZWp0T1ZtZk5CYjVOQm12QUhs?=
 =?utf-8?B?L3E1SWlGOWNxTXJMUFd2RmRNeHVFYS9RN3FnM3ZWY2p1bUxuNGZpb1poRW91?=
 =?utf-8?B?UzRtSDRFcGwwZVVIeDJ1ZUNxZzlqSDFxeTdmbzA5OU1palp1ZE1jYWpaMUNP?=
 =?utf-8?B?aEorTWdrZUo0V2h5ZWpnb2ZmWEc0WjU1ek83OFBFTW9idUw3QkkyRE1XU2xB?=
 =?utf-8?B?TWlNaGt3SC9KRjROSnpNYUZPRS8vKzF2TFNqejR2eGNCNzUzT0UvNVFaakdl?=
 =?utf-8?B?aEp6am53ek9RbnIyUEZjUWt1OFoxcFVQWElYakdSNTlaR0JxZ1E1dU14TDFF?=
 =?utf-8?B?VFVsL08zMzRXTTRiT2YxeHlHMWU5Mm9zZjE0TXhZOTNMRWZBQXA2bVNYV0li?=
 =?utf-8?B?cWFoT2pCMjUzTmhNeHI1SkFMeXZ3OTBxcmNkN3Q2ZVVVNVdzSUhTZSt0UmUz?=
 =?utf-8?B?dlFwVEpKR3I5TTJZZHhEeXV4aTZDVy9tRm1DQ3J0Rm1uZmpEWUk3RjlQQ29G?=
 =?utf-8?B?NS94bVRpVjJZTTZpWWdFNjV4eDRvQ25xNzZ5VzZkdXVGVnYyczBQbEJYU0Nl?=
 =?utf-8?B?a21lL1FBQm82M1NVV2pzd3BMTXVOMkNPZjJQQW5MWFdoN01MOU5uTXJnNmcw?=
 =?utf-8?B?NWNyRWQxWkpIQkphcmR3S0RqMW5DdHVzY2JWdElFcFF4dkFHbi9SVFEwd0k2?=
 =?utf-8?B?T1dXek5MVVNmemI3S0tRMTdib0djYUxWRElYVytGRmljbGRFZ1pHbjZ6TTAy?=
 =?utf-8?B?R2lDQ0VwYmRKTVFpVEt4UUFSRHVvWEMwa3FaZHZxOGJhSEw0THVvd05Cb1Zy?=
 =?utf-8?B?MVc3NTliSzhpcjVWN0h0cG1uM2tTalJ2TE1oU1NLcDI3dlJlRE53N2pmczNi?=
 =?utf-8?B?ZndqNlZ0cnJHbjU1QXNhaGVnUHRVYktBbjBFMEExMmpBMEFCeFdyRllneGVa?=
 =?utf-8?B?cDVVcy9qTXlGYjVDNThsVGJhbGNTamdHYXVUd3JPREZHczd5VHFQUUFSV242?=
 =?utf-8?B?RkFXNHNKZmRLTUNacHF6TEpEdXBzRElQb1o5TW9wcTE3Wlp2MUtwU0JxbE1l?=
 =?utf-8?B?dUFGa0dKaW5kSmZCc1p5ZVdGdmdrakVFK2U0SFlQOXdmWWtvU0tFdURmSWJm?=
 =?utf-8?B?ZEV1bUZ1QmY5WUI5TlY2VlkxTjAxMHhGMzV3TjZRZkM5b0FSeEJXcHI0azl6?=
 =?utf-8?Q?bkIsX9u7CFBFmmOQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8b8c53-cc5e-4ad3-0645-08df136c6495
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:37.6055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2od7N52WOeJ7yqAoV+e553QgzIIQNRgl3VwZZ7W1WngGAHK/75zBKpaId/o5VDnuiebZuPxlIp4EkEI1TTNhBJ7MlMkDh85ZQifv5AHVGdo=
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


