Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40952C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIV-0002Xl-Dk; Tue, 15 Sep 2026 17:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGr-0001Px-Cu
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:58 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGk-000102-SW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmxZOu2vUx9yxLui3IaH4DB6l2LSNJJok4puN9ZsyjrnjJkZlhLfkKC3G7gPWw6wwUjqe5KVAz05o6MeVUSkhWwCsuW0F/TOPf0N2Tppj9S3I8gW7expsMn22ohSt5Ro0XQ4UScvWTOnuoKRpKbvz6VNltYVP4ZbKov2bTIjvfhnCm9or8UaRd1V42wRCKlJ9TF5ZDUxl2pxVWgZ52La9MyAltd7wfP+q5JFgnKIf0x9Yb3P12GsfEYKfsHyXQnTjTsfm77Udkg+w41839QM7osBG7fxPwAndXtWd7B7iqG7zzla6Z/tDwkl2GcVXY9BApMmDX9FbRh9BhKjQv9gZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=wsRwDe8iQ1kaxQwH1XSee/pOQVNI9TYFKG49RknnumdI/xlgc+sF6k8XHherWFoUXT6ovrGPV0EosDmcSCMqgNjcd/ad6zqPIc/bgJM1hGIm92EpN3C2w8mfRmI2K7okAgoGpFXAkIwDLWp1QY6RE1kM58boqog9YjM1N1v0Sf8xG1O5H2L2cQxLs/LevZ2gOEDUMo9FzryoLVAv0iq73gXqOuh1yinrzZakpH7HH5Lb51a0/fAer2+475i8vrI+/NJ/J6tjjUpiZ+4b7XQHNe5Z1Dx6XVHBbVKZ94tDRHhtKAtVUX5mffPb9erlgERNph2hFSYbQZtqI+ih/4tang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=C3A4Tv+ecw+DMmGa5IwOXh9p/Gw8e+zs7XDrCkTaFU/FbMNxxq/rkH1uViWrwWfvIZmwoLS7idcwUJqeDFAPlrGRFLcJbOCnzRmihY28eLlrEb/bVPimEqInXD4CzGzpg49lBMgyGPlNQPdr/vE9g/VT+syQDJypYzgXhm++4tJ/THDFmiBNEuwzefKQ0zGhKBEPYDcJS1Nehks6lRI3b9A8+cM3vC2+V1YtPLzfWqcewQ1iRZvTewl0DuB7uiimf0JgZL7jOMcyi/JEOW9Al87o/VdrqxjdLYbUheb03Gze3bm39WtK9G0LraD+dgIBTS/JLC7YO7NnLjKnMaAFUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:42 +0300
Subject: [PATCH v6 06/14] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-6-4d31b2dc6afd@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: a6629417-5993-4db8-0b05-08df136c624d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 2Lmj4jvMQ/gSiyAZCUibqjxPLV8UNl7R9UlbcqNep1f+fVra4H35/lvP2lc+cKxZvEQzDWJYwxsLoHbtyr9uImheoHpAots3yz8FfsOhcqxidlnrparz4fdoVtXAqrl6kjhNGvRyq1bdvS82WGGEQ4wsHmKxkCbqSc9rqxh7QMMfdJ7yW20rVENh48Z69Hpp0Nhljteh9sdBg6u3eNN7XzPFOavB9Nq1HWF4Lvvjj2O5r1BC48AkYjUdnKZ3F69H2hat1jE6YyNm38X7PrqaXZN8z6HrNdCdhXPDiIIi/E3Oiy+NyTeQJ45JSWOLc5tJB8D5phxL86yXvtNDID7KfuGUEDxBzBP7BbFvrc3BX3sszBfL7aR0VdpdyU+dE+LrPGs/6Kpob+e0dfdj5hGUCg4j6jotzV+2Hir4uGAypbal6mOGcvMDy6C1pOCUKU5F9CzifBktPA0v2rH8fH7D67/8gb1j+6Hazt3z58DU7ytbM2Gdce6r9M9J+j5Yg5fN+5QEl4qgO909cLuIT62qgXjn/csioknKf5Dcd+EsRQszjEgIwP/McruHgrLzOkblDoRIrxgXs+YR8L1EOeaYnUWGa6gIvUxpg5o0BrHbQZluoDuGA30kJgopt7FtgruZZGUwOwAarSOreJ/3l00j8wrPJ9FG+q0MGd0iYtZJxiXb6XFqDgaRZszo32yVKEIHYdmXY3xDcgXxsxOUMS1wyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1uTXNNVTRpYWNQS1ZtTVk0OVRtTWNpb0dhaXA3WGxTMlRDNDlGZ2pKWGN4?=
 =?utf-8?B?MHpzdUliSTA1NklmbmVvM2wwaVo5TG5tR3IycWxURW9EYmhLSGt5a2F1aXRi?=
 =?utf-8?B?UUNoMVVPRktJN0c0aUtPdDlOMXNHRkR4cmRlOUJRVjlQM2laTFpoTUZwbG5Q?=
 =?utf-8?B?N0JwaFF3bUtGazllVHJlRC9nZGJ5NThVR2loa2QwT0E0cENBeWFPa3VsV1V1?=
 =?utf-8?B?ellzVEI5eE9VTm8wRm9PWVJpZEpvblFFdm4zSGNnSExndnB1NFBmTW1mYUZO?=
 =?utf-8?B?T0pEOWZDdEFyKzVzTkNGRHRKU2xCQmtFdlZDRm5wOXNndVord1J5aXZ1dEVG?=
 =?utf-8?B?YTdiODZZb3h4SllDQjJJRWlXc3pRQVZmNUVCUW45cXN2NDUxWTNTRnIxQ2J4?=
 =?utf-8?B?MXRhS3YraTFERTlHY2YyQUlJUjNSZmdZSnA1NHZCaEhwMUdVQWlhaG9pcWJ1?=
 =?utf-8?B?TVhiOHdUb3dFdjRCSGVGSHBXbFVtQ0tXSGxmTm9xdFh1SUdoVGhKTGJNUkIy?=
 =?utf-8?B?b2FMMWhwcjhORm1ZcjZuZ2JjMTdkb2ZnK1VQM2Nac2pGZkZ6SEE4d0ovWENX?=
 =?utf-8?B?SUlBRWVuRzZkZFQyd2VGTGMrOFFLbnhJZ052YmNzN25GOTl0em9KNHF3UXI1?=
 =?utf-8?B?SFVIWnF2T3dGRmM3UFhtWDFMNnVpUXpJUEZiallocjJRWDN5eHY0Q0hWTTV2?=
 =?utf-8?B?U0ZTUVdWOTR5ZlNRU0VUNGpJQnR5dHlETmVNc1ZldTdZTVpYNU9XRWRENmVN?=
 =?utf-8?B?OUZRUHFZZ2QxZnFTWVd0WXVGSDlRUlA0REdFeW5pRWhZT1pmOCtGQk5oSkR0?=
 =?utf-8?B?ZFMwSEJZK3FvYzhzSWFDR21yKytDYU1zbTJLVlZOREZ1TnFhalZLcUhCRnd2?=
 =?utf-8?B?MmhrQkJYQkJOcHNyUElDSThvaTF4Y0ZnTVRzdlBjb1dwb0ptNHd2Q3k3V1Rq?=
 =?utf-8?B?UDNXNVg2K0lYbVYrVFN1SUFRWkpVTTlzc3dGcmU1L0czSWxkdkVCSjNGR1NJ?=
 =?utf-8?B?SVNlUW9xSVVTbUYwZ09kMmJmbjJRdmN1em8wblMzME9UcFZyYnF3UCtuOExV?=
 =?utf-8?B?VUo0azNJbE9ZZStCSUpiY2U2YmNPSW8rMnBYSUVHWjNnQTZralVMbmVDWGxn?=
 =?utf-8?B?b1dTa0MvWTdsalJtbUF2aHcxQlBkUXcwNjVhWFMwWUljb0E1WVVndlVQaEVw?=
 =?utf-8?B?MXNOYi96QVVIRHU1THZvdkhudi9pckJ2UnFVb0gzendEb2xEQUV3Q1cxSXBq?=
 =?utf-8?B?SXJkV29BYUhPa0VMcHBBdDhPemx2UEcremgzZnd6V2thbEVsbDAxSWN1U05k?=
 =?utf-8?B?bDRRemExSnhtb244cWVLUndOUjNNdDdCd2IzdmxlZXhLeWdtWWRJNDRRd2pv?=
 =?utf-8?B?bGUrNk1uVEx2Y3V1OGlJR1pBRDQwV2h4M2J4bGdUZGRqMkJTRXluUldkVi9Z?=
 =?utf-8?B?cktxdUNPK1hqVXVvbUlOUXpRb2RoQ3o1a1R2N1RkZGQwK093a3pUSjJ0U0Ev?=
 =?utf-8?B?YncwdjJFelVyd3RlaWRoV1J4WXpsVlVpYzRuVW9SWXpkQlIxcDYzNDBoTWMw?=
 =?utf-8?B?Nm5jTi83blVtLzVlc2g5d2tvdjZVZ2NrdXdIdUltRzdxNnVNMWw0WnZOVkxn?=
 =?utf-8?B?dXorbkZycUlNdk1CcjNGU20vaHV3TnpCRHVrdmdrU2tJUkV3MVJxSGVjMlcw?=
 =?utf-8?B?U2VaenRlM1hPYnpxWHN0dWRRcUR6YWpKRndTZ2ZCT1ZpUm0vd1lNK3pSL2Zk?=
 =?utf-8?B?emN5ZHhKWWlEeW1zYldHZ3RVUU1SU0FhbjlYUUE4T0hFL2Z5MFZIZ0wvb3VK?=
 =?utf-8?B?UTRocTZYZFlzYjlqa0JLckliY3p3U2xjQkNsaUFQdXpQNG1TT3h3Wkx4TXFs?=
 =?utf-8?B?eXg2VGZ6b2I5VTJQbnNNSG1RY1FDc3kwVmpTQ0FJTHp4UjFkdU5ETEhEU2VU?=
 =?utf-8?B?ZTBwK1FXakpueG1JMVFDS285ZjAvNHZWNmxRVms3ZERCLzlzRWF4SWp1a1NO?=
 =?utf-8?B?bkg4aVVsNG5nYVNpSWdJSUJmWkovWGR4MDFCdWpMSlRLYXJvYzhFcHQya3NQ?=
 =?utf-8?B?NUllQ0pVby9ZOEZUalBJaWV5Z1JDWTRmUnErNUtUTzFzczdMcWZjQm96YW51?=
 =?utf-8?B?OTJMV2c5VDZ3NkU1Y0ZNY2x1M2V3Uk03MStWQ1FraTFYOVE4ZSsyelZraldj?=
 =?utf-8?B?WCtFZ2JCQkZINWZyWGtOMnlwQVNLMmFmU0JvWHpoUktXVmhFdEV4OVBlTlBI?=
 =?utf-8?B?cDg1aG41d0R0SlpOMDQ3aS9uc1JXZW81MjdFa1dxMkZaMHVaU3RoTVBEOVhT?=
 =?utf-8?B?NThvZjMyaGoycDYyL2VaYXpHRkp5Q0tyd2NHQTZGbGJGK0tROHhacUR4RWNs?=
 =?utf-8?Q?rAMQ0gE4W6f+/4bs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6629417-5993-4db8-0b05-08df136c624d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:33.7687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6iTV+htake3HR1f3eNeElTPh78yGU6Jq6dXp8gRArEOdScUsz5+T4GNsZo2mDKvyO7aDKBzHxIW5uzr1OXX7IJoKPFGDRxkHVFCTuI4TCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


