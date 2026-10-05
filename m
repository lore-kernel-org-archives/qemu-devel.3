Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB8FCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCI-0008JS-FR; Mon, 05 Oct 2026 11:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCA-0008IP-AL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:38 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC8-00058M-Fz
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGisgrBupBYqsjgMKvoiS30Z5zJ3JgzR2cXaBRUQ3834iWWvT2p0DCh13RjeQ/3wwOxX98LMEXZNAgLdGLFxNvjJpbpTBMjyaOYviyGmHnho4KracGdFKi6QbJManeP5ge1v4QBe7p/sTcsxQZ3lqFLYUBrPpJt0p84Ggtd0JipXG4faUrOaYe5b3B8RVCF8TsP1QL4rRQauHUuP6Vj/5ViHIGKphkSaclI3kRO0EJ6B5Sx6OieLBnh78DFNEQOrO0DwV6HlxiRl289gABNsFsyHhPd02xzm677MEYZovnVpXIOOV+D5ZJFWEwcXmt9Cr8rGfpspCCsntRT2WMsjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=ZUeSVs1ZeLr8L7yO1doKeiiYoaJcO7/9XhD30kdIYEdV/8I91DaJwe3vO4EM5lHMKDpm+aS+P/lY4DkV4LGEYNOgnNji3yQ6+9V7DA8PVfIbw5lPwoKnIptNPQoszxL/NCf+ukvyf2fq7HV7XEy5sCDWuhIyiXNAAzFTv4oCAD25/o7iFC8Im+BtmJUI/3s7uGLETdk/WWyeQxpfQzZ69y+VqFELwhFtteYFEA2oUVFyU/j1f5KVteKcVceWI+HfHqBIulMEUuZBk8ZhTLnd1YWrMpWw8Mm0qBNgM0pCEnOG87TYNBU46cvkrJ3Y0waQOlYNP9kIcJlemRpUD7/TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=X5bjaAHPPsav3/Ypna+W/RugYUVAmF4QMgqxO/cRoDeFjPYZa4KQuWYt2WAOcuLgYJOqGU2LlzujzVxxAWO3H3iudXBfHMIF1qeTUn/cS3hZzbimp93tI0xNV1/GGm3/nTU7e7VdfCX/UdGajlHeTKmaDZbjunuNlZ7bGXpBQW7TuKffto2WcXr+ueHXUKMwBpewF2onnEZPWtpD1xva9PiJCnOj6u/elmvCaS9DSdSAZysi7zt53ubizHZXn327YAYQxn3pEJPbzKiWDy9/E9rR+287eKZkTA+0551Zt6xvT1f09741RJ/uciu3EemQpksYRNKSYXt/DrLyDp7eWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:21 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:52 +0300
Subject: [PATCH v12 13/21] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-13-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: bd67eea8-4460-409a-9257-08df22f18486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: efFI3QCL+uWExqcwzlhQRyjo/ySKJ15/2awbtmKeWj7jXr+uVGGFfFWgmynHE6Hlj51LUdHnCFFnAXqf/Grd2l3zqoTPa9q/3m/22opdRkewuIxChmIcNpIwwdk2yXSK1qLX9YdNHaqKDmpofBmkSG10eDVrljH7zJCRb+G0Q3FuB9CCxxemhoxodKxqF+JkMQGpAPWERGERkhoNNPX2w9Z8oD91d6hLPVXI7H8lsl8WvPe4TQiz3QCEGOeLEybnudEyEe2ZTYuiqbOhmwr0beh7gyPEWMlZJWd4NAUU0YLsUQ/CRmb3I4Wj5SnHgTDDT4eZ9NvE1T5RtKpOp7f087rD6fr3KSzBAw4ESYAG9Bo3o4ElGD7PJ+STRD9DPSh6bi/GTRcFR6D2A8PkX6+yspXILuQO3z6mn+Ep4bzLiMW0A5jYAkvTJFwCzAJrbTZodHOnpVcNEj7OK107aEjIp2HWbDllQBeIfL8DWPhJMyD0CL00YUFAsJ8Wa4svBUSEzULay+lQio+oczusmbEqavwF3+QazCK2QIB1VNIQ30wC5+4wz8CNw51xUSx/ryWPF2Hfwn6Cd6FOwnhkM82LjGoqx6sxDD3Ep6pqltIigQ4h4JCaeHUawgvHmZj7d19KanlICFnq/SGRm2/qF3qRje+UsUsjYmKJG2AWESlj7H3G4olk3lDw4H0WowLvuLkQhdsOy1ZwkRgXvnW+yUwczkWEQkcXtdJk9f50q17MKPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXN0b04zZXJRMWRISGcwVTVDVysxTFpIRjR3b0hMTU1keiszUlF2R2diR2tp?=
 =?utf-8?B?NnhwVDBLMDlCVkVyNU01M1dkb21oY3JDMjlKYXgvdHJaQnNLLy9VbnpPK2Qz?=
 =?utf-8?B?UklFSVlXZ1l6NXZXTjR6Z3h0eUNwVTVCQTlsZmx0WmxHdVFFNHByTDc5MWF5?=
 =?utf-8?B?NnQzWUZhWjRackhvUjIzOXdiZ0lLTG0yOGVtMlJTYm9XYlhoV2JTckZRY2lS?=
 =?utf-8?B?OEIvTHA0NTI5QkEwNktnY3NuZmtXbEtiUFBWeFVoUXZpdElTSk1TbklmdDBQ?=
 =?utf-8?B?QUxyN3NPaWJPRDJrNTV6MUwvOU5oaFVWeVhUUW9JTlVlMThDQ1BGZFA0RFll?=
 =?utf-8?B?NlFhaSttbk1KMndnNjRQRzE5dFllOEY0MVBaV0NkOFhXU3BpYXFGVVpWemha?=
 =?utf-8?B?RUJOMGdkRjZpN1VIUG0ydjROa3ZxdDl0RmpjTnFiYWMzM00ycU01UHlHc28z?=
 =?utf-8?B?OXhrWUt2cjIweVE0Nml6SWNPSjducnFRWFB1SjVBdlovNE5RN2YzbVFxTlRa?=
 =?utf-8?B?dnQ2WDQwRlRJM1lybFZ5aS9wNUdVVzBrZExkWXNUSE9EanVZNERsSkNZa3FD?=
 =?utf-8?B?WHc4eWFaZ2h0YUE1MWR1akxHZTVCanJQYTUrVmxVWDBoWmJJK1JIb3pJZ09i?=
 =?utf-8?B?NWJWYmJoLzM1Yk5hSjIyT3kvd2dnU0JIazlrV0dGblIraEFXQnArVWhGS3Ns?=
 =?utf-8?B?RmFBSC9mOXkxNTJKVkc0eHR5bWJoZlJDaGVTcUhQMERhUFlKcktHOW1TbVBO?=
 =?utf-8?B?dVlxaVpIMnJBd3c3Q3JZaExIMGxydDNBcXVkSnNXR0tuUDliVjJoakdxaTZD?=
 =?utf-8?B?WVlIMEs3MzFqTzBmNVl4T2FXQ2hsQXpRWHBlTVlnbkdLZFRjVjg3SE9pZ0R0?=
 =?utf-8?B?WG81eXNrbzAvSzNyRjJ1R2lNMkN3d1FLVjlxeHJaVXBGS3RXaDFJcm83eWNo?=
 =?utf-8?B?bU1vQmRTUHY0NlMzYW5MaHB1ZEE3ZGlEc252bFM1c3YzdDBuTkQ0aDdnQllS?=
 =?utf-8?B?VmwrVndpNmdLaGlPMGpaZGRpcTlpYUVWYWhhM0lHTzQwY3I2TGNhb21hK2RN?=
 =?utf-8?B?MTY2bks1UkV0V2hoUEU3WkJvV05JVzh5YVZQZEd0VEFqaGpqYWh6VStvdGM2?=
 =?utf-8?B?N3hLd2gyZjZ6SnJpd1dDZjF1WWFwWUNydThvYkxXK1Fhc0dQS0ZUT3pTN2N1?=
 =?utf-8?B?RE9GUFFuZGFRTjRhRnowQUlPbGdnTFRqZW9xb3JZcWtrZ2k4eU13SlFpejNM?=
 =?utf-8?B?U1cyb2RaV0h3MXhYVTlrVkt5Y05VemhzUW1UTnNYOXBNMjFMcENhSW16dGp1?=
 =?utf-8?B?cXF2djFvNFk4NWJXSWZGR3hIcnc3TUdDUE9nNWYxV1l0MjJLVzkzVGxsVjh3?=
 =?utf-8?B?ZnVFQm80eVFRNXBtK2VWdTZ1ODg2MFdhNloxZXpVcFJyMThXakNXakJaYWl2?=
 =?utf-8?B?OXBOWkI1RUM2UHlmYVBZa3VqUzRHK1UxeFJvZ05Nc3c2K3JyQVd3YUYxdHZK?=
 =?utf-8?B?bloyT3huZTZvbnBzOGtQYVppdkRibW1TaU1lRGphVmtUZHgzM2l2eTgyS3py?=
 =?utf-8?B?LzgrcXhMMVozRE5XTjVaN1BnWlJVc3VNNjhwRkJnNjR4eUcreEl6ZG5mN0du?=
 =?utf-8?B?MzN0RU5qSFhTNDdmaGFCdnl6K0F4UzdmVzV2aWN1SDdtVHJ6bkR4SXhleXRR?=
 =?utf-8?B?TXVVMnE0YVczSjFVdG9vRHk2cDB1dUwza1VyN2RmTTlsUGk3YVFiL1RHSFhZ?=
 =?utf-8?B?bDdodlZxeWkzSStOcDI4SS9JVnRXMmoybHpGMk54VkNGdzFvb1ZCY2gxOXl6?=
 =?utf-8?B?Wi9JYWZ6V3A0bGQvUVppL1ZBRi9ERk9aZm1CbFFzMXdBNlJ0YjgxbWV0elJZ?=
 =?utf-8?B?K0JHVVYzakhObHkzQzJOcjd4R0dCb1pEYUcyNG1ORTlodUdlMHJxQ1FlTkZM?=
 =?utf-8?B?L1k5SkNMS0ZvOVR5V2lIUjFNaFB1Rkt4QUJQSG5zMnE4T0dKSlNZSVA0S2NG?=
 =?utf-8?B?UXJZeE9LbWtaYmdNN1BPV3JRSHhoUGdmdUExcUhDOEdITm9QcXFLemQ0dmhX?=
 =?utf-8?B?enRPVnNwdVRuZC9pUXdDRmhsZnpVbFBENFJicllaMGhHbUtUSXhpVFRxakJt?=
 =?utf-8?B?U1ZQN3cxZUxtejNZZ01OamMvc284M1QrSEpFYjV0dHJ0WXVZSHRDaytEam1N?=
 =?utf-8?B?RGZ4YVZ1N2hyR3FQNFl6V2hVSVFGakVCemFPOUZxUFJzYk51eDQyN09JdkRZ?=
 =?utf-8?B?TWVkcUJCM04rZjhIK2dPSmVVUFNmL1U4S1ZBWDExYTkxbXNKdUNva3JUamFR?=
 =?utf-8?B?L2dMOUZUcGJBdnFLR2dtYTRYSk5ZZzNyd3dNdW9SSE1IU3NFamJqOVB1cnJr?=
 =?utf-8?Q?jsVrVqw0bWHj3mzA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd67eea8-4460-409a-9257-08df22f18486
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:21.7762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmQwHKK3FfGTk2wbXMa5FzNilbkpNriKHncHqArTxjoKgvpsZwdZiLi7eMlK+71UITau+nRHWKeepQD4iWvKyIUFhL0wIVAmD05ufgjdyko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


