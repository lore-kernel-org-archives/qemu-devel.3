Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBD7D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTIc-00048j-7N; Tue, 02 Dec 2025 11:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIa-000483-NK
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:20 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIZ-0005yG-6W
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML6dnsW9JhDKe81bwBM+l4HLA9+LvkAoKS8FI8iSvT8yxaW/6f8IPnSwjoDgynglc/73uz/rQmJnshNI/VdrFBBZ/h9MiK8sw/Ma0/j9MJkJ/cEd40cBZ+0O9LuA0Hm/1uHX5mt9rRy79ByeNcCLicFeR9l9B0HVEdA6x9r4Qvc1lu8whIn9tOL+sOTSWmFucUByyLl9FGhM5DX1phwDs4hAFyHTYnU7xR31F5RrrS5DdIvwRt+j2RwCWk252bS1EMIT4dXtj/0B4iWDDOiBX0HtSDIKkuBHMay/Vsdz7GRS4bUPiQAmWF7S97J+6TdXo3tY6dGFI5XH5tdILMG7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4FwUbISpFx0edlczaa5j1jU5/j13QFpVh/CjI8nHfM=;
 b=B1rM7AUDnE9Q6gPM2tAm+E808XDDdg7yZGvgf5sDrDg6LSd5ouw2Y/3pc1UjoZtsxLy8ehhf17l4bouDVqFysoOwNVkGALJmwJlFoViXlJhuf04gzZisN3ivXXfz91WWZvd+qz1AYt1RI0BN9Asx8PxJpHoAxU1PhatzhRZ9geIjcdGxealCElvLHD6ZeHqAotZUqGolEtTqs0Ax+/5P23nEtVdZh04CZ/8S3nXYXicvyKCgdI2KCQGe5LmO8UB9U7HmRm4aygMffb8sKzi4p3j31y2wi79nAgwQu+YSEw3tZqGFR8owMbSfQB2SUapG4/K/SX2WsZxZ1Ss11eVwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4FwUbISpFx0edlczaa5j1jU5/j13QFpVh/CjI8nHfM=;
 b=myJoWPxAviYmkFbt9VC4fMjBwfj6Nbq2IWwNNM/YL6watZCsbX4T4TFUTwUAlihFqJ3zwLP/8rkvinE57BiBOdLbVcyD5T5/t3GOVoSqkDuxoyJk1soAEi3krFWacotnsoyXLUGMfwHEchDba0CsjLOBDSBuUIm6TFSxYCbfh38kIjy6Y5Eyrak+qZK9rr8ROBeDHhb4PtUAIlc+ijo3NNFxFCaRmFuD3lSMcIosPYKH432gV2Dy++VsZIWFeRg1YvPe0Pt+5OjML4/tSV2z5tnQy1FwgMZNG1P7EIPkHx+3aDwOxb0ApsqDyOnKhC5Bl+PtmoSQO7izo7GrP8r0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:42 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 2/4] scripts/qemugdb: timers: Fix KeyError in 'qemu timers'
 command
Date: Tue,  2 Dec 2025 18:31:17 +0200
Message-ID: <20251202163119.363969-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: eb69b59c-f553-439c-aea7-08de31c04654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ew2M01/doGIQbihPYZRnLaySQfB22859HDZ6cBY3NJtMFBRQq+BGFCNewWn8?=
 =?us-ascii?Q?WE1iEzs5achwVrtDvjV5yHPb/a+CG16jdHV85EL48O4t1EPB0Q2LQQ6WT2qw?=
 =?us-ascii?Q?HrJ16cllJGmNPpZerxIcIHo3VKlgu16ao3MuvJ1dRWoESVsFh42/pquewHdn?=
 =?us-ascii?Q?6c/9YwQ03DYzaq0KnWJtIjAiykCSl+h5vBWLAI9yqtDToqr0jwZgibu6Uyey?=
 =?us-ascii?Q?2lzHFw0O3YQWFs25tEvHOhzEpib+bymlrMbY9BW5C1W8YmD2Kc2xgoueR0A0?=
 =?us-ascii?Q?omx/zz54IHpaal480wkpS3Fvz58AuEoMerxeXlEobQ1qUspkloGAwzJ4zTsd?=
 =?us-ascii?Q?mUvg1OKI3eXmO1osynDECaeI3LoQXSvom8+7KyA/D+usmtpuJ+G3sLX4LN86?=
 =?us-ascii?Q?CyJgDC3MgcRLuoeASsbipsZGLxBjsnR5gfzlpPi5jPTBGOvnVIRb6pkbk+q9?=
 =?us-ascii?Q?INWqOe0rbJKSMNvYtgMjjzL2ax8+lmUDlq460O4G1qBlXZYNpRgfCPN4GnLK?=
 =?us-ascii?Q?IXnRhzgSh+EwTmBOaeudaGwd0vnF9k8bzQdedoruifFwNUvh9QxcP/vqX7il?=
 =?us-ascii?Q?p2Eifub4+CrgdBmAjSZSdL5xKJ1r/ZsjCJD3hE7KLVCyqCRNU8KOqvi64Inl?=
 =?us-ascii?Q?NLHhZsabsKH5QteRwlCl9DxnSEfsCQT8llR/wV1J1aPtkZZORqax6o6ETsTq?=
 =?us-ascii?Q?9LbfHyXMjmDPJ/5NQlyK/cfs4kTTTR3VF9X9LMUt8apSP/OpXu5+1NhyfZ08?=
 =?us-ascii?Q?H0XrepPluvEcaXyD9BIbGskCyBK9iA13ppi5PCUmqa40u5iRdYsF9Svuli/K?=
 =?us-ascii?Q?VFG5C+P0kmR4F0Fw2Lk+lVhXP/Xa9IxQcE/yaHC8RGY1sIBosiynNlpSbHxR?=
 =?us-ascii?Q?iWshLUdiuh5J5uMrTnCIhQQw82b+TgYFJG7WcagDBtU25X6yklqASlWIaWMS?=
 =?us-ascii?Q?bDi46EvzRos0SDzUD/tn3C7pqJlkaLahmpIsidqcTGA/qLKZpIEH8onyt0Yu?=
 =?us-ascii?Q?/XWT6bFPx0izU13BEWbxSSwPEX7SUJL0/O5RjgqP5bbcoK+8WbQ0yAQw7ame?=
 =?us-ascii?Q?myekEoGWziZCRgyfUGRONScKgPXnBVZkRrxXtqTlrCjIGWnqAES/VBedAeu6?=
 =?us-ascii?Q?uNcVM6AkXPUwM9tJZf571b4SKQXn6eV2f0hOFyuGisGKSDtB1sLixHop9RhF?=
 =?us-ascii?Q?Fzh+NSRU3m8A6TOD/uD7PXCjJwNUC37LchhhO5qAHtmJ5fXfqmt5Oyf1qqth?=
 =?us-ascii?Q?TiKt/XxR6AkwmYEpebXKCh2mRUNu+2o9HBDgHgonRWtGikhxWCz8/YvEDLCK?=
 =?us-ascii?Q?NhNK+s+fnafPsnb2V2IYzvrMDiLBAXt+E3nRz5tdKATY3hNmrU5mNlX3e9Ft?=
 =?us-ascii?Q?BNYTteNWjCuVKF5eP9J2C0SV4FXi97KzaIqCHIyl+U8pCIzxXWQlXPhd8mNT?=
 =?us-ascii?Q?BSE6Sfn5a2BCEhFwCqAxfHR5wq9nIWjKWu1NJLELoikIijiBmu790SJwInUL?=
 =?us-ascii?Q?DVtI1I2VKiYtpObjdZdxN432CWIXiC2elRls?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uqrc4RnhFxkzPnfktQAXS7Nmb43Za2pRtmuM6ked2DQzbhe4aC3VLKqkvH0E?=
 =?us-ascii?Q?9eB5cOMVzPYSSFlgJJQ3VncXa3LytIt0YdI8Xcp+3mA/g8x0IfN4LsRbwvHI?=
 =?us-ascii?Q?/7AjJe+U7Zl9QE1xN0D5Uyvmx/UV7azzzjXuj7Pn3nPRxw/G4VItzzrBaC7/?=
 =?us-ascii?Q?GDaZ2TkEsHH0DdW+0VTtqTHX6p7fCUEzTXOTi9MYUMrVq/BdrtpjixdvahsE?=
 =?us-ascii?Q?hsmxKk+cJZrXHWt6gUMuBAN58RJNEq/t+ohICkwMGEiykGUsmC35CmWlHCCq?=
 =?us-ascii?Q?X06Yd9orG5RmJ0yKasNqZE7efPea6pqwlotU4JPXwcmBlrNVUzyAX+StMjyE?=
 =?us-ascii?Q?wfZy7fdQunUDqZKa9c/7fnEee+rJ8rIJTkT1gejFklDUJwuppbK8cedKuHSa?=
 =?us-ascii?Q?1VbEGx2MM0fW5WhXrNg3VK/cIXNXb4zBC24yxJIW1H6zzzs5tmbU7KdJbAQx?=
 =?us-ascii?Q?08v2cW7pgLznR7a3n+A6wxkPPQnsilcwuRYu1hdeNrC6lRa8O3AC62F+rGYE?=
 =?us-ascii?Q?1kKAeDfHQPYBy29Q2ZNzGor60W9/Q8bLuIwPkCfS5uOIOE/BEMkWWbBf2/6Q?=
 =?us-ascii?Q?jq4KSBS1/9YWm5fvWqeG9iK8TlDkPdj/jkPJuYLsHElK14hmI+J8fFVrgQoi?=
 =?us-ascii?Q?SA+qD1g/vr8+yWIK7m1/C0jHRNOJulGqN/EtxVnPKrx9MOZYe+2FJLWOB2ar?=
 =?us-ascii?Q?H79iMsahPIcZ+zAyPo/nZz/qIcqXNmZyMvHij/pw9iDlovBvUirehh1HVWvh?=
 =?us-ascii?Q?O+eWHxkReq26bTeeW4/BVUGONMqtWcjBtl52klNrN/8xSvkUPUsHf8Afn8YK?=
 =?us-ascii?Q?onFpphxMivAzuVDJIwNM14oxKyOB1dWpnvlbND+3uLB45OrGOGY0+GOLi4b/?=
 =?us-ascii?Q?bQlOzCE6zpXApiG0Tj7klyRfkq3CuWt/Nk8YjU2HkT+hpqqpSKpSvFuEDyI4?=
 =?us-ascii?Q?L5AQ8FKy7BKsjQYcqM67jwI25T08dawM1Vyzoe9szoxfRQ45q38QuSDAmvc/?=
 =?us-ascii?Q?81kWWjpiSz065RRGWNn6JjE6iSY5Dk0Lp7C5sAWX87/DJ8edyUlt5Ce2kr8L?=
 =?us-ascii?Q?JxepuTY3Qn3U/o1BSez2efkPtwaEbyCfO7s/EwvlF8ke+JFfQJIiQwg4uuCl?=
 =?us-ascii?Q?NunBdMQX8AcSuy+6e5sy+dvbQ07V5dxsHHXH5C24wqhWvgbhPk+X8TTQNWqD?=
 =?us-ascii?Q?gEBLHVYTu/ns37ReBauoLhS7l/tawLYuSAE42KK3oabPbZRgPSVq/rYBbR6d?=
 =?us-ascii?Q?6mCIWZB+NgOzggz/Ncwt3qr/Q6LXjCnP8i6nsDj2I0dp11nRipaNb9P8dN1g?=
 =?us-ascii?Q?LDodiCBA4AK4gaxKAHT0HfGKNFc2I+goPG1RTkYZgabKlwT8zhhPv+hI5scT?=
 =?us-ascii?Q?hP+WR+69TpREKRUKcHBpuPBFDFYIAG+rss56nSVo0V04tuBmKVL1kLJMuwJF?=
 =?us-ascii?Q?s6hgttN+J7bXswickuDOgdxiU8p5gpMQN1KnEkFaIZ6ZWjbBvyLH0dPbSe6y?=
 =?us-ascii?Q?u5nAonfUVA3YPHVs7VsEv4Ti4LTI/RBkqd58JBEl3p+lYAu2+iaM2GdKoj5A?=
 =?us-ascii?Q?5n7kWdBkKuTOGZSgWOi1G03v5gD60fecI/NcK9r7xI7JjCd1SGhGN3pRIbta?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb69b59c-f553-439c-aea7-08de31c04654
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:42.4209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYAGMtd7xAVaOO915GSNtcc1oSSmSb258S8qRoxYVCptFHjfo3su3gxNkbFHl/rGcevmFVS9688JzDYZ62yTgCQBp6U5ouw8NILryKf8lnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently invoking 'qemu timers' command results into: "gdb.error: There
is no member named last".  Let's remove the legacy 'last' field from
QEMUClock, as it was removed in v4.2.0 by the commit 3c2d4c8aa6a
("timer: last, remove last bits of last").

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 5714f92cc2..1219a96b32 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -36,10 +36,9 @@ def dump_timers(self, timer):
 
     def process_timerlist(self, tlist, ttype):
         gdb.write("Processing %s timers\n" % (ttype))
-        gdb.write("  clock %s is enabled:%s, last:%s\n" % (
+        gdb.write("  clock %s is enabled:%s\n" % (
             tlist['clock']['type'],
-            tlist['clock']['enabled'],
-            tlist['clock']['last']))
+            tlist['clock']['enabled']))
         if int(tlist['active_timers']) > 0:
             self.dump_timers(tlist['active_timers'])
 
-- 
2.43.5


