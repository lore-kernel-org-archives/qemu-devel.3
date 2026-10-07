Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6657BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwV-0004Dp-Tu; Wed, 07 Oct 2026 05:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCK-0001MU-8N
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCI-0006wV-Q4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl9To80LwSFSwcAPsN/kfdybezEchDXa7T8E1Ftca8uMuAAijC5rckxp+8ZyXWyAHaE5omFeJH0K0FEZSH4Z15H+Pwt4kiXxSkXiLy+1mcUrBAAOjmfLTukvDA3u9gW59ykYb0VCUObGdEXnpRqk2O77WuRGGBz3OFAwQpGFad1WMp+OTsX9wm1wFX6CjuJxPagwjZlmotGAB37ivv3+k7NI+o3dNSdUfveH/342jpRc+qkkL0t7Vl6Wqzx3wV+2H1GLzLHaxZb4CBrolb3ljId1TYcptALqPEk4YOPIGUoGg0PEIlYWEKGOmseSHfCM8vm7ff6f24WcaMPdFXLZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=xt3UL9C7r2hPZMLXKoPoM+Khr667BUQbQwlw4gl8QgHxu7HTDmeR1Lptu07KA2u1T0XZH0T9gSYsWogCuTHmk4A5FIId1rqbRnY9WTMqktQYksvf1IKTGkSbHP+fm7JhMJmWpz8pdXjb0YBWgtJa5k0qV2Xu3APxemHyycP4bXPQWBIW7QhulfvxVc2LsH/znItUr9KDFcHU+mCMe2ruJR9OEbt04BDTPVOqhFFp0i34HQ3LchONRUHhQS4EUlAX2txX7V2tuMZoK5Kc8idNdQrfvErMjgp1nW6qH6Ago/uXBKTAAd9NSD0tWMSYsAb0zia0lRgtoqyisKP6vXcjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=EHMlRBATCpXZQfsg9eZWOEmTnIxA6a4hB5XYbFqupuBh2duc5E9bnBCaW5vqld6csi7+RIsZzMcGL/ImRJ1DD/KeKSZiXEHogbK2jCYYcPeL6m7c49ecHVRykpzSAskP3p/JE15SaD4+WYE8aT7BGDxtBAdGTH8PR2qUVPlDWHUf8J02NYgQT6VVH4/dAXgQ0P/bHBIlb2QEm9zPP1gR7fbPvFdA9meZ7tKZVmQEgP7uXNO4m9UiFHEFwZlCXpN1o0CQyUnSEbxkgjmNhdCweafur38RqL7Nb81dO2Tlw5mYLQyOwwGtYJ/osT9HG5MzsMyntRJ036Miaqt+knu4Hw==
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
Date: Wed, 07 Oct 2026 11:40:07 +0300
Subject: [PATCH v14 14/22] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-14-e16de9962df0@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1ae4aa2-7f6a-42a3-5f7f-08df244e971a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: mwSWQRAY7pK3R6XqyoT3Mu5ffbAgUnGUqPmT+Rv0xOd9G8DSA/ZfSH7CUw909Op6nkGgWCXEJE/RRS+zvITLu5RCLAy4QRGDlh2n43uacyC4VLLEaO+XlJhvdHMy6w+EdNIa6ZL7bV7iZZRGYXf9RzsizHiHvSEdlvBpWFy+mtI2sNNK3Gr3cWwlxvags7yrjOLEr3wz2uBO/fv9mIlr9q0KEaFQGQUeuXMWmrfuI7uuyVVZ5NBVWy/hio5veWzgFuqLysoVQGoSg7agVG6huu/Ou14ByVP5eGDsDQCkZzhNuhbCtFzxwhoU1UG4TO/0mFcyR3pjA5BTxNwH6SOy7vsPsy6xZETCB5I2iln0sUe1/Rn6Alcb4CJ1FepqHfNn9/v/vhXzm3fHf7vVOlotPuyUE9P+rUOK2AosfhKHAd7oYW2+Q+Iq28HmbkKy5LvfMk47hKFFGP0IeKKKDqkwqz/3F6hpG+Aq5+XUYJ3dGy63q+e5YEfAGnlSm8k7rayUZSh9Gd2On9GYe4UWOVlBh2WMlqM7cEOrdxuaCY+Oxg2nXr0gXdQVWzHi0iLeaMMXL1lz42MDwSOVi937KmEjM4CTZvsmh/ijkAUKVSzibbDisMGFcNJtfFMPPBBSxzSGSNN6tSqwv7eXtzLDKsrHkbbpCgDU4BB31SFHXYYoH4iPwE1EBnahhqyx1bzyEI2BdQNYNbT6V/6GABJmoLlW2kbHH983fBt/0qStGNd3e4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRCUUxoUnlXeEI5NVJXb3VIRXkvMCtJUnEyK3BwN2JjSmZsd1h6U3pLczlG?=
 =?utf-8?B?aVh6V2FaOW1IV2dDSnFya0tuenFhcDBjMFd3b1VsM3o5bnEzZHZGeFpKdkpy?=
 =?utf-8?B?R3dUM1ZqRmpScHBFU3o4dEVBek5SS0E3bE5XL3J2ckFHM0c0Y2JOdTVnZ3Bz?=
 =?utf-8?B?S29UOUhMU0xESENkMUpJYlhBd3NKSmI5ejZpM2xoSlhBQ1NIMXluKy9sMk1r?=
 =?utf-8?B?VHF2a1lZcHo3Y09wVzJMSjl6YmRUdk9PNDRGMlRuQzJSZHYyZEtqck0ybkla?=
 =?utf-8?B?RFZHTmF6RWx3UlgvZWxQWFhNL09uNG0xNVBLS2lJcTVxTkt4RjhHY1JMK3Nq?=
 =?utf-8?B?NG14UUtHNVZLYk8zTkY4czRtdktNa2d3a3lUeGswdTJOZ0RRRTBRZ0hvL1Vj?=
 =?utf-8?B?VFJSQmhVWjZaeG1kNmZZRDBwRXppbG5laEU0Z3lBVGd6L25lWWdVM1hYQzN1?=
 =?utf-8?B?YWZ3SzZBT2JIdjNDU2tVWktoUXh3bUJBbC9QR2k5M2tzeW51a0NrOTVTUEVl?=
 =?utf-8?B?eThNSmI1ck5oTDlaQ1VoSXJoZERjRWVHQW9EQU4zY0plVTJYeTBmMENaQXgw?=
 =?utf-8?B?TzJlU0RSSnozUGFkOXFjR3pUVXNyeExkNzE1emRSYnJTZVp2UXNncGRyYW1D?=
 =?utf-8?B?eGN5bVhHQUswME15c2cwRzNGK3dRZzBYQkRsSFBrbko2bmFvL1Jlalk5ZWJm?=
 =?utf-8?B?QVFPSFdST1ZUOUE1aStuR1ZQYitrcFNpNlNrNmVsWHZZcTdGQlQyZXFlZUtk?=
 =?utf-8?B?NVYrS0RHa1FyWmtON250bG9ON09OT0ZHUEg5cVdpK2h0QTJUTVRzUi85N3dn?=
 =?utf-8?B?dW52QmJkZStqc2d6OWFhS3lBaU4wOW44Y2JTUktQZW9IZFZadGQrM1VwaCtI?=
 =?utf-8?B?WjlYa0JuMmhsRWFrcGlsSUdmTE5IcE83WHlTVmNGY1d1c1IwT0dTc2xDcWVx?=
 =?utf-8?B?eFNVRXRoK1NFcS9COWRBb2FoY1RlUllob3pxZkdsRXY0TWpQTE8wa0czU0d1?=
 =?utf-8?B?dzF0T2E2L1dkMEpMa2VxSmtTNmF3eWR3UWRSZzZHL21FQjRJcWlTd0JQcm13?=
 =?utf-8?B?Q2NYT09FY3FteWZHOTRqdGJhWkp6cFNxRWozUDNIVnZxOFFNbGJwZUUxbmtW?=
 =?utf-8?B?YmdmdDU2SGF0QWN3S1dyRDMvV2VCZjQ5RWphSE9heE1KUEJwUllEOGJWUmxH?=
 =?utf-8?B?SW8yYXI4enpvS2g0dGV4SHk0bll4bGVJVzh2M2x6L1dXMzBBSCtyUkpWeURu?=
 =?utf-8?B?aDFoUWVRV09sVVNKVFJVUFBhZ01KaHF1eElmbzlkS2FOYXoycysyQjFMK1hR?=
 =?utf-8?B?dkFORzJtdDA5M3lSaTdoSW1kTEFUYUxsMDVKMkpEa09UN29ZZGRnZ290R2pV?=
 =?utf-8?B?b0RHTzAzRXFLeU02WEV1ZjdQaG5jeW9wbE1abWV5MXlXZEVwQS9yVEM5YlBj?=
 =?utf-8?B?bnIrZk1LUmlqNWhsV0plMytBUVQzMjZ2c0VCR05MT2creUtKcnlzandRT3hM?=
 =?utf-8?B?bDROMTZFUnR4L0F1OUk4SldnOTF6TDAvWHpXOTk3NWJ3MG90Ty9YNnE4bmFX?=
 =?utf-8?B?OS9tQUZOaVMwY01DK1NCSkJQZDZ2dG5oZEhUSFZEaHliMWhhYkVGMGV0Q0J5?=
 =?utf-8?B?dWs3VThmczc2ckYrSkRUdEx0UTdETjZoVnRzQzMveXQyZ2FNanlyZFl3dU9o?=
 =?utf-8?B?ZDA4NDIraUdHRU1WcWJ3anQvdnUyWWtvM2pZb2trL2t3dzNuTnhWdjFLKzRN?=
 =?utf-8?B?ZkNWcmFBWTdCTFo4aHZiWngxTHB0ZHc2c0R4NUxnQVNMN0xDTjRlbWxEOFBa?=
 =?utf-8?B?MWlEY1V1YlhyL2t0YUFPelRqMnZ0NHduM29JNWFjUFI3NEJhQlpMVVN0M0s5?=
 =?utf-8?B?ZGdYL1FremJXNmdQVjE4ZzBFWEFJYmJzYXJqOUg2WGJXL2dkbENDdUJRZjVP?=
 =?utf-8?B?MEFEOFhmSzF3SURrRFZUUjBZdElSNDhXNDR1akxEeWJnSGlaMDZDdS9hc3ZH?=
 =?utf-8?B?TERBWkxocll4VFBXWXA2YlFpejdTbFpiZkVGbVZTb0QrSlJBVDdpcW0xMDJJ?=
 =?utf-8?B?TFB0eHlqdEpSa3RvNXgxM0tlK0ovVVJzWERoWWpDb3ZNV05HaEF6ZWVjN1A1?=
 =?utf-8?B?Ny85RkVxRFJXU0dndzZPK3hqMDRxUC9DL2Z5ZzhNS1FNMElSTFNaVTlhSnpx?=
 =?utf-8?B?TFJET0xZekVNekRBWloyU2lDZDMxZ0FBZktlQ0R6cy8yZnhZUXZTY1pMUm5x?=
 =?utf-8?B?cVV4MjU4SXlOQ3BtUWU3L1h2d05HdFYwRzVUeW9GbWhBSndPQmJLUFhpUXg5?=
 =?utf-8?B?RHpKNkdhOVExc2VpVUZxcFAxYlRJMFA1RC82bVVXdmdRb2t3RmQvdFBGTmZP?=
 =?utf-8?Q?5VpE7XXUerC/kzdI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae4aa2-7f6a-42a3-5f7f-08df244e971a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:07.1893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRTToD6HtIEYC9sEZFwG+is/D44jGirhtx05avyFlG0HfpAh4XWBSey1fGrAsyvyNwGLDyQKJ2hL6y91t21CZesQJSnMECmqnvfTCu5wg5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


