Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1DC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FV-0004QS-6s; Mon, 14 Sep 2026 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FS-0004P8-UO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:10 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FR-0005PZ-7p
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrduYbOT6gJFqgnwc/VS8lD5ZuxsnV6/yzmszxwHY9rRhbBpR1tAzSYUZ1gK+KHKx95wj1zsHzX7M1gqQf8M/bb8KHMLwpxjiNrSIBynZnmTZH/nIslVeGh0SPwg8XMYecJyXElV+H6uW+WihOSlAOMWPBEokPaiswBkXLctt3Elzuy6ItrUdTGxYdDXsHYfV7ghrdmXpJf1GuY8SuiBQKGvy/ZbXk6BTUAVyTztbS1TTnsGi3R8GoPLFWgGl7BgtqsGBuXKH90kslyU3bKGADAelpRTME7VF4DxcS+YOTCRsb91S9MPJRKYExpb8L9qNZJwrpH/i2KNt3cjSH2GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9iW3avXufVWmYGC8C1uyWT8OqARai6s44TEZ4MTbfU=;
 b=whQ2X19FN5e96kg/AZsgpPVz3YMk4rpAFALtPc5BnDIhOwIaZU+s1/aHPcJJUBWSKjpewlGo3kM3CNevDw/QveQph5OwRRQRDt3rJ8Hb19EL+E3h47fB4vVEq/8TX7a3sOFA/QpXLEjheA8mPqQPA3BL89soK7b3gySmUmy173m62+IwseNPxhUn60U++QVInsNbWqi6ljyJopKQ5Ap+dOin9glLGb22ClSGI2I0DrDY6IMUOgY7RIpT4QZ8iyExJEj6J7e68BhuXabdi8Pt+Ry5l86Mh7mcp5587RedoDcQIaCrPwp8C0MEPDwd5lDdGIDLSvT7peBRrT333+0TPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9iW3avXufVWmYGC8C1uyWT8OqARai6s44TEZ4MTbfU=;
 b=y/J9P1GcwMvy4OnDeH4d3LU99dmYejqyN+A6d0WyWfpxRV8tcYakJRcYi9kPt3kKbhkVbfuhaUm3pv7P9mhM+erL9NgLbygCgsRhwRGDX/1eNqBQTH1LXaeuhJ7AuL0oOAXO31JVZRH5UGNTB2OSs1JoR9kS51gNvOrfP+ogeNk24Ev2ZhXdPuylzOi3fLzDMOUmWdLhRhUVS7l931QKoa1LnL3xeMrCMQapD0/ZIbPlY+Nf9SIJEU/f3HL015yAQIge3e1Ja29TlyHy77g0R3UtdmXleuUvGuKjfTGb6ERgHyi4pZ9uwI673a/lM/W7U33gjU4TxKj4zq3NV9cJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:44 +0300
Subject: [PATCH v5 13/14] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-13-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8ee7be-45c1-4564-006e-08df123bd3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 2bFWnDwjZ4XQWnB2PBIxsk+1lEFF32d1b71j6CCPDteL4Du3SNDOrncyZnfOSSf7f6lm/Fu9kq1QPijNsVNpGhW2lM9WrXLgk1Ky1ZO2Nt4of+8VJHeRlVy6BglnMnj9GU9/vovpkMNqNgYI0K9CoBqZ7fxLIsVetX5EhcXfTi3X++4nS5i8O/M2bVRHoFQnADRVnByCxR8+3oVXheEsqFGAN1JYEc1Cw0osgpyZ6WKkLOIfWipjHFkZBlA1B33pN7/ARuHhKxaulzlr84lS9CCZRG7oLHjWvOfRi6E1NuyDZYCNLBivW9FJwWuhoLuPDYJwAg8WNM+ikeiTmCE39FmWhVzmTpHSNrJoBs5sdyXFKrE/SNto0OGboOQCUht9fboHduv7R4lyXoruUU7jTGHXX8WPtoUAr4Ap18JH5Ta2oCZuB1mMq79q1/mJWUJCvLJk0q7PAaaqVmL0N5V79+qSp7Va37cxwrgQKfTFKFS2UahapXfvkxHCCScybiLF4D6V80dhOkUU0uAcxdXYEfsxNWlxxmxU01AzMcyof4S6iK0GYN26GFK+TH+efP7gP6jShNtJPUOkl/jZRc+urqweIx4caH9DKNqCqry33YHbPvBO7Hc+MoJpdSA9+bKXxi4nyOtO9ko6XUxM+sE6QYIOmaIvZBEv94kdsCdjaYVBbMYO/ihu/HVKhjgv9Ne/itsGqcmO8fkM1NZ1sikC8SjJ9WkPOEHZAmXgZLSvZFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhSUm0yTXBYU0lYdDZGYy9PdDA5bUNpWFpuaXV2TnZoRm9UdGFFU3NHYlpZ?=
 =?utf-8?B?NXVnT2lnbW5sbEl2YjgzaVBOZDhYS3JwWFBaTG04V1V5bHlkakVMNGF6MzNh?=
 =?utf-8?B?cW9oaTJoOFIzSnIyTnMwYWRlSnNPbGF5VmhGcjlvS3o4SVUwMzUvSDVyaTMy?=
 =?utf-8?B?MHUzZE9meFpYREthWmc1OThZd3ZXb1B3Ymg0Z0VnWkRqSDNERnJqNWpWMVpP?=
 =?utf-8?B?MGV2ajJwZ0x4RXJBR2RCQWZtUEpvSGEwUlBxNjhmeVFJSUxrN040eU1Uc1hz?=
 =?utf-8?B?Umc0QUtxNXoyalN1V2NHa2VocFNRbm8rbVk1dGVmbzQvSWUxRlBHdFJ2NGJr?=
 =?utf-8?B?TkpUNWp5dWcvV3VhT0N5Si9pZzMwK1k2dVYzYjlBVU5JYThEaHJzdHVrSVBG?=
 =?utf-8?B?QXRlNGNkdHFvZFZ6WEVWZmRUWVBYSXlHNUg4RmovTHk2b1QxMzVCVTZWQXFY?=
 =?utf-8?B?d2pDblpXTWR3SzgrNW5FVmxoNFB2UFlHN3FpcXRRS3hCTzhOZkVQY1ZDUGdo?=
 =?utf-8?B?dklRU0VNY2dkVTV3NE12Q1JyaU9qd2JRcHdmdGdlQXpvMlFsSEFZRXNuemVI?=
 =?utf-8?B?WklMQXd2QnRXQ2tEZmJ1SWcwK3ZXRGR6OStrMVNIMm50WS9vb2xyWkNBVzVx?=
 =?utf-8?B?dklzYTY2NmpER01qUmczYXFJUkpsRUM5a0FDak52eWp4d0tpRWRvbnp5V1c4?=
 =?utf-8?B?d05wQm50dllJN0syZ2hVdHZGVlFMWW56UWIxTU9kNmxKL0QyanBab25SSmlT?=
 =?utf-8?B?dUkwKzlzcndoRnkzY3c3aFlFY1psd3hZcWZJNEdLRmQ2ZTlSRjJxYnRlWXQ3?=
 =?utf-8?B?Uy9YZndTaG1WaW1tOWxOUUZSVHd0cDhtRVNlbE1oYW1UTlMvSFpXVXVrSUtG?=
 =?utf-8?B?RzRlSE1RVUR4RnE4MFZtaVdKLyswcENyU3VaSjFybDVZVHV5YlhET2dQcWo0?=
 =?utf-8?B?RXJuTTFjenlsNENGeUNhdmhCcDQwVUFsa0xiSDFjTmJhbGtjTVdJS1Z6NXB4?=
 =?utf-8?B?Um5JTDM3MmM5UnF1aVFnVi96Y0o1UVNUZ20vWnBHOU9oZWZEdHhJTHJiSVBS?=
 =?utf-8?B?ZWIrVmptMFFEQkZjSFhuS0xGQS9vRnJiYi9lWmNMckx3Qm5CUmNNcWFRWmxC?=
 =?utf-8?B?c3kzUUloL3hCUFJJTG1ZNU0yUzNuSmNBQ20wLzU4YkFkMVZJdzNzWFVYd2x2?=
 =?utf-8?B?cG9jb01Dcmo4bWMxRlpkU0RYQTVrK3R3RWFkWXFFYVZDekRDbXEzVXJtejNw?=
 =?utf-8?B?RDZ6WW4rZmJmclNWclQzNllMQmpydHQzMVBBbi9TU2czek9TajZxNElnUHZq?=
 =?utf-8?B?Mi9UR3ZyUC9wQmxVZFNCbUxmVU1CYmMyYU5sckkvTVVIM3B1dktYOFdSTGpQ?=
 =?utf-8?B?MzhNV09xT2FST0dzbkY4UU1sQm1UbG45a0E0QnFwaGxTOGF2Sjh2RjVaQyti?=
 =?utf-8?B?UG9YUDU0YWdkWFdYQk9GcS9PRFgwK3dueTJveTI4T0VPdWczZWpQOXR2VUIz?=
 =?utf-8?B?ek40eXJDdlExMHJSa3FJbXJXYjN1cU9LRkVNTDhmQzNhbHlKdzByRXl6Qmhm?=
 =?utf-8?B?VlRsN1hTNnhGa1hubXFiVzVEU3RpcU43R3k0YXBrc1YwMWw2VUJCVkRvSVlX?=
 =?utf-8?B?OElua3dSQXF1Z1Mrdk9tU2FzQmxBQzBHWFpwdFlkaFZrUVN1NFNjd3dRTmpU?=
 =?utf-8?B?ay9ZaUw0ak1FUDU0R1liY3VOQkJmcmRwS0NVNGY2OVBvYXlZcDU1RGtwUEky?=
 =?utf-8?B?OVNKYTRIRnNhTEtISDhPTEs2VTVadFVDSTFnVVNRSU94SXoxWTJqRTV6eVgr?=
 =?utf-8?B?VUxrakUzWmxvSTAyQ3NOazY2Mys5dUZhMmVlRURodVhYL1h0ZmFVSUpLd3JY?=
 =?utf-8?B?R3VPQVAyU1VvS0xFdHo5SlBSZ0V0elZxa0VBd2lBeXZSWjVDdFBmYWhxSWdX?=
 =?utf-8?B?dmYyS051bWdsWWE2Tk8rdTlyZGw3WVU0dVB4emg0bXJoRHNPbzBkclVDVXZC?=
 =?utf-8?B?dE5oVTE3TkJUblV6YXNHakE0ZUVPcTRxNVRnVkViQ0gzOFZUL05ueE9KdWJP?=
 =?utf-8?B?aVFybVAwVDIycS9YdU85aFhyN2VXNjhseDBSOFdkOG5nQnRHZDNXeWZ5VWJJ?=
 =?utf-8?B?ZXJOa2xzYklxUXlRMFMyVVBrbmtrQ0I4ZEgyZVoxNnhhb3l1S0MrYlNCVWNr?=
 =?utf-8?B?S2wrM0VzQjB2bnpqemxiU3c0cENWRmdaV3piTGNodTFZYStPcUVBeUpXRUJR?=
 =?utf-8?B?QmNpMWJEYUVkQ1Zqa3FYejQvOWZHYlJDVkRaUG1haWV0V3ZRTXhrVVZwczV6?=
 =?utf-8?B?SmJoZ3ZVRHIrdEhlSXdSeFVjSjhzc0VCdU5lakh6UzlIenlWWm9XZC9yVnBn?=
 =?utf-8?Q?TjgFq1hk/sMFx7VE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8ee7be-45c1-4564-006e-08df123bd3f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:27.9400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym+yd2L6RazdCdl7B048s2xjQlIsQbUaEieV8wRWWSON9e4x/kOLxRENXg4GisfkTyYjRFSMuERNff0vxSF/eNvXhmjeMb/9hOUdZIGFidY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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
index ea17bf01080..a81cd94f900 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1821,6 +1821,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 94cc52f870d..7fe1a79d5a7 100644
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


