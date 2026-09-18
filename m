Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B97C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwF-00033m-1F; Fri, 18 Sep 2026 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwB-00032h-6D
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:36 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw9-0003Dj-J5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWiAN9rOHpCy1aLjBnTo8qvfFN4NqURmR49nAqYpak3BXLvBAfSFkCEFLLp85AN9lnk8J9/mxWnTFUEpL2Hxmrz3kW7CtrVHCOSjBBVJoYU34wukEXnLYpqCsYTQ4Kojfq3W2873ThoOzNGN77vwUZVS3dfKJvkU3HOZxVYD6wl9XvOSDy+NfUzo8kwhk5gjv0n5eKmVmddfOUMRg6XYNpPCQPqXHgl+y8MTqYkfNuRg2WCNnwaQ8LsXGlatmSlOYwT6C2Y5MrIXqCkrkpYF698ZTBwc9Ji476O2cZ1avC2BDsPUGZO5Oehz/0g1V6/fOkQFIZxUh9uvY+356i3IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=iHNh7GiFH1SbFr0Vsr4btmXN/R4IITTRJstlcYDSu0J84JNCLSeCozzBsunAIWDIFfsR39lzdk7PkjavHUjv0smbstiqT13yHfvojbGSC+Hznsr9fUF4khQBLS/An++uwC1SdKLCOKrFRADDpr1D8ygX0z5FYznRIpzW1kKGMOTzIEBfdwwwScekU2zxLR4HC1Ipdp1vAQE17iiylLIVooNOi86xa64aI/LTKFJ0NUTEIlAWA/8St28qSo5mmDMaSCbALPWYBn9j1AuJF8+jzrDBBuynVC7kI92T2J77N6UzYxlYkRGc58Lc+2pFKCkiL2MQ2qOj4C7Ptnue4P2S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=I3rYHCvFy8rLK1+5mmwGnsp4qnwrF9CHBZAXwBHslDG75XEwYZ9WFG3HU0acNJEwBmiBVWSBgqc9kvwiUm/aDVCgbyYAHd5xwtfhWIqreJFe3Kt000sdqxtTqavLYLmyfRxIul2RWQCN12ICO3+kVnvtGi4zzi0aHEAn0lwos3tjSt/XhsLr35WVBJxWAHmtj1ijSiDhUHiTiuT283GkDMrfwhJ2jdYmEqa0CpzUFbWcCRyKevaYRByHeTymq3wF6LaiWviqdWkYCMZWmkOhU0yj9fIfTG9q47qsyDyIKER67wyHO+TdG6kWOTNPAEpTvEtQpU8xcIvMSPBAENYAlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5483.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:28 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:04 +0300
Subject: [PATCH v7 13/16] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-13-6ef9ef033c35@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf93293e-7927-4639-e6b4-08df158b60dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: tpj1VI21CvXBGh1fLEe5nMFi7RCTSZlqYYlY7i5hHODxsq1X2/i/Y+zC/3gJksJMH34gHKHNWAuUySmlp6xCubdKC1DRT0S7UbaJw1TOuMFRE17OIEwpOOf5FwjDVhwJRMvUnDu2CCNzmFNW4grNDuCfVlKbCC6cBp4Z4m4hv1loCRZ/3XnO+EzaAJdAavn+vMDARXaRnzGe6L88n/zvAYTaOnyuMzaHPKiaquGg3rsXV3o9/K3iqtPt0WNGINqAUol5F/qy8gdO3xlfUFqLUcnNfPohiewJFE+3XMT32wD2nfAX305YjwNcS0SiZg9NfpvZkQNOGzlgZD39emsim3F/FE8ZCP0UdCpGBQp2P4GBWOJ76kuLhSw+1/R+RprcHTXGrbhmo0H9/ucJKunexW/O+TEuGlbBt4j3RhYNdssHA/KLdV8JTyWUZRyB1DaGIfGdNr6CKKDSLbc+j2sVDh3G99V8UbaIjjEMAM6hRCY7I0tnEgNTWg1OopXIqVksSMW8u0yVXBav64/1H6aeKLJf6Xrfld46ojncezQJ6b4N6+C4uaEhlD7QLIia+tTN1r2yZcLTpnl3f5x5Ite4Qxwm9nph/e99Nx635qGbAeGP+lixLOvS5ILPO71+4blfiagiOtocgKksbtKA3nalOO5mcjbPMmpGR9WQZOSw2jiJvCMLkryFBkvqEOJNJsovX4XsvVoDfaT/UMIvd6YP+yt+BRA/DxqhkM8DddfhXgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RJbUkydXNkdWt6d2VBMzNzZ3BvTy91RWNiWEdaUWZRZWRyODhNOXk2a2cv?=
 =?utf-8?B?UkNLMHJPQS81cXlhYkZzSmtjcDNsL3BsWTJjcUlIKzkycm1Lcis4T05hdm84?=
 =?utf-8?B?bnBNOCtLbmlIZlcvVi9ja1EzaFZSTlRTSWkzS0VMWHZhMW1mSHNTKzNLRHRJ?=
 =?utf-8?B?cE9wZ1FVRUNXY0lpZkgvWGdiaTZKeFdENWEvSzN3T3JSRm9sZ3crZHRqZ2Ir?=
 =?utf-8?B?WHpRVkVIV25tWDJhdll6WU10WHJIdTRrNnBCWVNrdmRHTnArMXAva2JBbHdM?=
 =?utf-8?B?VjFXcVdtVmZOVU42c3VKWjZhN2ZNZHQ1YThNbzN6N0xvZC9RU3FLOGEzQzZL?=
 =?utf-8?B?VitrWElyTk80VDU1YlVubHFaeTF0VkdQQXRFVVBCZ3lwRytsOGFYRXpIOE16?=
 =?utf-8?B?TUxpdFBqVktPdjVKcHJhZjllMEcxY0dGSzdyMmNzMmRKOGJuMVlGVTRzY0da?=
 =?utf-8?B?NlhPYko2RXlyWmlJN0JPTUZRNUJ4amtPUERPamhucVZiMm1HSThOSjR0dXla?=
 =?utf-8?B?ejY0TEF3cGJCT0RrTExJU1YrNGJERE9HdXpNT09ta3I0VytKSWNwemsySDZR?=
 =?utf-8?B?U3E4MFZNem9TNjg0VW1zakwwT2pHRkZWaUU5b0F3UmNGSkFIOTVycHZjYWVu?=
 =?utf-8?B?NkZ0OG1KcFhtQnZWaEdyWk5MWkFKVHRHb2lBb3kyWm0rZlNMV3pkelVkb3h4?=
 =?utf-8?B?MTlTajU0UDd0UWVTM2dHYzRpbXgzbHNHYzFTM2JFTDhNUnZVQmRZL2tKVjFa?=
 =?utf-8?B?YldZRzZxa3VoYzZIQjNHMk1obWdPczlJaU94b3lhTU51bFY3eFpMWC9Tb0Zw?=
 =?utf-8?B?WTRaKzNmYTNyTjBxZFNWOWJTcEowUk50cFVCb1h5OEcwYTJIZ0JIY3E3dUdL?=
 =?utf-8?B?dlE1N2F3Q0t4MlE2empndnNHKzMzUURtYXIrMDVHbTc1WGx2MXByWUdZMmp5?=
 =?utf-8?B?ekhHZXo5NHJTb1pvWDNIWUJTM0YybzVSeEhOWmUrWUJvOTJtKy80YWNwL0Fx?=
 =?utf-8?B?ZTh4SUVtRnF4aXZaRTRwQ0FVa2FWUHhFV0kxUVF0T0ZBL25hMUxDVjRXczB6?=
 =?utf-8?B?Z3FRVllkK01SWXUwQVRZU1pCUnBJVHRLZGFOV0txaDB3YjZMdk1naHBjajJm?=
 =?utf-8?B?QUlFbDFXcHFBWERCMUpEcXNISFJMWlIrMHdWbG1Pa2dOdFp1aVVMKzdZazBj?=
 =?utf-8?B?OUZOYk9qblo3VXBzd1Bhd0FPaWdudUFJVDY2alNEZXBuOUdGbnpuR1U4WG0v?=
 =?utf-8?B?YkpjaVQwYUJvZW5YYUJsSkVWUkM2U0MrNnVnQWRpbTVnakxxY0RvdlJncnBy?=
 =?utf-8?B?S1BRVDliK1hyVE5vdXJkQ0VJU3ZZYk4xRWV3Zlh6OTczWmR4MUU4b0d0bURw?=
 =?utf-8?B?aG1TeDYyeUs1dnhvM2E1YnRUV3J6blFyNGlpU1JXRWt2dEZjT3A2VDVoR3pQ?=
 =?utf-8?B?MFlVbzFrZlY4aVFkL0JrNm9maWNBUlo1Ui8rSU9VYVBWWitpWkFZdVRHem8x?=
 =?utf-8?B?UThRZis5bjgycGNtalNsY0VZRldZaGY5MURVSDNhZTF1QjA5elFkLzhEVkRv?=
 =?utf-8?B?MjMrUFNFYnNQa0xIbzZtclUyRGFQZG5zUWVaQTIzdmpyTnltOWdZVjdtKzQv?=
 =?utf-8?B?RjhYVjJ0bGhvYkJUa2tLYVdyck9CbXNZSzArT0ljWFU4MlZJWVJEbTFndFNN?=
 =?utf-8?B?cS80SXFYMnVoZm8yL2N6a2hRSTJlMEl1bnIwSHoxUVZDeW1iL205elhsOWsy?=
 =?utf-8?B?SFhXMzlrWFUzKzVuNFUwUE1renBibFJxaXUzU0NRMnhlc2R1NWZlbUFqaFFU?=
 =?utf-8?B?ZTFNcDhrUktEMFFEZEdEVXpSNHdla20wRkVWV2VpZ01rS2Y4c3ZtWUFrQmkz?=
 =?utf-8?B?QzFYREVNRXFidGEzdVNVcDk4NFdtdDJHUDFjaDN2VlE2YncycTlJajZNRktq?=
 =?utf-8?B?NnJ1Slp0WWY1RWRZTWp2U3VwMVl1ekxsNEhRY1Z6NFVMZXVzMFNRMk5ycEJX?=
 =?utf-8?B?OHBQeWZZNmxQbEhNdDFIcFNCZjdJRENLRXVPVW5KS0lsa2NFMXE3a0tZV0tp?=
 =?utf-8?B?eVZrS1F1SVZXeGpadndRK0FZd21QK3ZiS0dYbGgwdWk4QTl4MkgxNlNaOVdm?=
 =?utf-8?B?K0wwbVh4WkxFb3BaVWlMaXUwWTR4cC9QbmpYZHlPQ2RvaFg3RytYOGVpRTAx?=
 =?utf-8?B?TkpMc254QkNsVi9ocHByazZzcjBhUmFPUnFqZkFGTk5PZzZmcUFJdlZxMTlN?=
 =?utf-8?B?SWNaN2JmYUI3OWxxNUZHaHc0eWhudFpMKzFkM1JZK2ZXQkFEVVo2aTNIR3hL?=
 =?utf-8?B?VTdQNnJFa0pqN2hSdHU2NlU1TDBWclh6SVp4ejNNanZsVC9jVG1mdU5KWmdz?=
 =?utf-8?Q?eT4dbNtHn7//kXXc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf93293e-7927-4639-e6b4-08df158b60dc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:28.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzk0iaIbtBXHp+71PBKjP6WjkENd0GvAA/ymLQoE7jjoMGzfyvAKspfAEaxFv9qhR5PeqjIgT4P3LIPm+uqflgBojP8jZInPIGlH6mijUoE=
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


