Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C5AC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aHL-0001XG-4I; Tue, 15 Sep 2026 17:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGd-0001Lq-HD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:42 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGa-000102-0i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqaewO6VaEgHOgyk6/Hlp2bY+AJPHjj6yD8QtAGL0clUm2boXYGC22WZe5xQIn0IOx4LzJ6aVHQmpxPTdvCi09SVEGvUCPYlu9HvcT1kaS7wk23O1hJ6Gp1DhvKajMJTX1Wuc//T5GkkYYBm6hOSlnP88ANapkiuVMXFB1ls1iVsrfkZhfJtfknsKVcZJW5qQqdPxqG0jJ1V+PsfrxURWhGR5yMIxD9IbfqZhGn51aBA0iqnJMmsavQXYKoinCPqG/EGkJ8TNBZmjJqdnqie7n10YuElLvKUYpk76LIKP1ItDjt0nu1I3oyF2a2kCgrmQ5ovTbUc0hyFkre0JAGqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwW+ZplXPw0xE/qitXvJgoZNLwFKl0DDdrlr3o/ktzg=;
 b=ykywRYlwkfAWWPypvpL7nIMSVFd79urDNRMyiuc1KgoTUkCPfaNHpN+vZYgqA/z0KPwqB2lNLmSkylCx66FjLrb3L5fzrvURx8lIPsK02XaYEdq4AWtzmSifl2CH+bUJlrSg81h3j0sgOT/M7KJoRVzmmDOi35DFx2pvKWR4H+87c6c8AAc3Z33L3itnYe/Mi2G3TcqRuRS40PUifwNZm/uLx7HpHIcQji7TVrthWTWib05EI4ZfAaWPxv6CzxW4AcJJotAGmWLsTT7s1LkL9V/+ShP515WQgmDfgDoQ1bQrolhNZvt8qCiCntByifhsbhoWIJULir0ZjBMpx3vYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwW+ZplXPw0xE/qitXvJgoZNLwFKl0DDdrlr3o/ktzg=;
 b=DXTLnmo29tfaYKRbSQNk6EWYgDzf7G/Z53g2iYVYoaYVW8VHiAOAE9tESNstmFjv/JNqgnsCByMQNv6xFDXPSPlprDARj2kZ8s2fmADmyr/omjflPe+dgKN0JZ6J4NnjVPV6S05q5uYo3I0sbdYuQqDFC54DFbb2tF4sQtJXioYnM1/ag5+Xcyik6pSeO0a2ZNAXVNBMgdhOg3T+eaVpOEuP8QY+7IZJp/ZEtgBbpobRwHY8rULVpPN8Z97BAY3B3pG/RUT4sKoj/IpKDUyacsmTkRnw7aJ7ds3jZQX9BqjoC1URh5iNQr0uH7SLs/qEawNura30lgRoW3R7O3so4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:37 +0300
Subject: [PATCH v6 01/14] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-1-4d31b2dc6afd@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2128fec-2133-4406-275f-08df136c6063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: MYDCAr47jlcYQEvRawJsO09Lexn1JvVKNQhXVDwwMEUWq6Mo1bKTZz+/J0J2LA5kSDdGWPfws0ysSWkp7zYZA6S+9e2cOiWLMAugjAcf2r59GCvMIMWpe0Fw6X+r5zx+MGhD2SS+h9VVXqzIc3Z/0d8Vu3VWYo7ookPoWNEPwcaA60tGFX/ZGxiZGXrXOzqfzTR+e05mF+9ix/i61oLWWIf0iM41pGciJM1UaqlgAEdG53bEKJgWg5CNbIAtxc0JUCQPSxRzCMibSVtq40KGiYFsDMwfO4JSZ/ckkAAS5I0V4jxsLJ2vN/CX6R+e/tgjC3aviFB9n2k6NlKTKah5ghuWDMJFdWjo9dg8djot0ikugXkugU6vjW50JUFYqyWtuGIoLc51NfUI5oflxH8EporjtD4TY1hUWHbroGTCgriLTx5wZJbp62ILvM52NudCFOREwukAIFk2UOAtux6TVg6OZOQ6QBl3JiIlBl/rZ+WQHaGPIdGNIDSebDOqCnv+w/agzO5BE2Bu7RTF5rsi4JTh34vxw9ciCl7OyTKH04rzyiXhl5GmpsN4S7hoZFH6i9POaIvbQ/wyBICN802sB6zBkR+VbZ35Np6jb8grKQTqeH3uXGY5jQzumzo7GmITd6xEKz4D35PjiSGCwEJUMTmsXjGpsuQj+19x2wyz0Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhyQlJtQ2kwcWF3TS9qaXFoYlVLTjRvTE9SSVdLZGlIWWdLZDhOWXZsZFd5?=
 =?utf-8?B?MWlOYndobFRJbHhaK3pUN094OUNkTnk2N2hrY3RaUXcvcTJEc3JEcHM2U0hu?=
 =?utf-8?B?YkQ4SGdqek5CYUgrUWJISDM2bG9vMVZJMThITmljWVV5b04xZ296SGMrUkpu?=
 =?utf-8?B?c1ppUFFybzF1R212TEFYQi9mVUJtZk9PampabFB4VG4yL0JMOTRjT2FtRlNH?=
 =?utf-8?B?V0JpZjU2YndTNVRIY2NleEdHLzhTWVVUeTJwTkpUVUNCcENVYWVKblM0UTJw?=
 =?utf-8?B?djV2UndmUXlnU3BwQ1VITWRJNlhJbnI1V29mUjZEOUhTY3A5RHEzSTMycU5j?=
 =?utf-8?B?QnFpQlA0dU5FTTRSMy9RcHZyaU5mWFJvaXlwYXB2UzJKYUZLcXN0Q3RyLzZz?=
 =?utf-8?B?eFczTlBNUXAzSTFGWVRZT25wQStmZUs3TVZCYjZqd2ZrK0hxUEY1eS9YbFN4?=
 =?utf-8?B?MVVHeENxRkp1M0RhR1ArWnVCbkJTcmZsOE5YcTZmMndQd0svSCtxNXppbzk0?=
 =?utf-8?B?UG5KbitsV2JsaUNxaENMcllBOElqSnAycGlONzFua3hwa3Zua1ZNOVVRdkhw?=
 =?utf-8?B?ei9aT3ArUUs4T2pPdjR4QTM3Q05GVFBCZC9YVUpyL1lFNmdGZXJrU1lrVXBt?=
 =?utf-8?B?TXBlSWR1c3MrVFhmTlVRR3EzS3VES3ZoMmFtK0IxNWl1TWRyYzhtek1yT3pu?=
 =?utf-8?B?eXFWVnQzYUdYZDU4d1hSL3NmSmpKUTg2d21TK3loSGptRUljY0VvM0hCMkNI?=
 =?utf-8?B?WFhYT3FMVS9WRi9CNFh5dm56ZWVOeE81ZFlteGhkNXk3NVlYS1NoZEV2ZlJt?=
 =?utf-8?B?NzBLc3RYWDhxa3Jjai9wYmtmUWxNNk1JaXByNUlpNnAxWDYxVVRBQjNWMG1G?=
 =?utf-8?B?YXV2Z0x0THZFeGVJOUtoc0luWW5VZ213YWdqSmQ5cnkyam9hSEdRZzNJYURt?=
 =?utf-8?B?RkdXdmt6d0ZaRWllSzF2Ky9rLzRVT0VZeEhHMnZqNWJTRTNhOUpsODIxR01v?=
 =?utf-8?B?ZVpXSDlmR1VmQTFhNTFVcjRVR2ZLZFdCUFV1Zkc3RkVSMWNTa3UxY091SThh?=
 =?utf-8?B?aThJT1FmdjVWMlZXQTlsNFVKTHFGa3BGMlhPL2xrbzh2cUNhaDlYaEcxWExa?=
 =?utf-8?B?WklGd0h1dGVEQkVZQ1U5QjBRTzdyc3Qvemh2OUxkZGdhRVp0eVUvSUh4QkxT?=
 =?utf-8?B?NGEyK0hGRXNRZnRBbGRlRjVkQkN3MEpBZjQ3U2Y3RmRPb1pkNkEwK0p0MlVU?=
 =?utf-8?B?ZWNobnc4Rmd6OXNsRzJudjE4QUpoa3pGRkM3cSswemlpRFdobk5MbGtYSldL?=
 =?utf-8?B?NUdMY0MvTS9ERHEyZGtzczRKYmhyLy83aVBJajhIbFEwWWJQZlRUclJ3WTdk?=
 =?utf-8?B?VEVhVGNKSW14YXB5S0VSbUE5cFJQczB0UzZ1V2h0OVBJNG1MQ3l0MHNRTHg4?=
 =?utf-8?B?L0xsaGNVOTQzMFlYMjM5M3NlZThyT1hPekg4YytxMHdOMTB0MWhFQWZBd2RP?=
 =?utf-8?B?bzJNcjgwYkF3d0xyK001MzkrRCtZSTRadmNudHRDZmlGemdVVFFHYmhid3Jl?=
 =?utf-8?B?UjNxeUF0QmpEVzFkdDZCN29vQWk5cDZPVU0rVXhFTVg5OFBkeFZBZStsOFhJ?=
 =?utf-8?B?Z3FGeXRNMGNWWDhXb0daZ0V3QWlEWG9tY0U5cE1na3VPbFZ3ZGJ2aGpEeHJR?=
 =?utf-8?B?T2krbnZWd3BLaDhjNFlRaGlUMXBkVkFwbXZQbGswb2M2aGNlK2Jud3VnRitP?=
 =?utf-8?B?azF6WnZxVEM4SFVJbi85VjJUejZldU5MajRBNUc1c3dNc1BjWkZaT1d0cm5z?=
 =?utf-8?B?WHllVjdSTk9SMGRLWWg5T0ttNFdXOXczV09HREVqWEhVYzd5Y0FlTStLb1JX?=
 =?utf-8?B?VldCamxKK1p5T1FZQmszWEJzSzRvMHVMT3F2ZjdBZnkyc01rMXBWdVQ2aGhr?=
 =?utf-8?B?ZG1CdERTdFpNS3A3TjdNTGtIYWtNSVFMb1dmL1FjMGpTK3pyU3RDVmZlWGh3?=
 =?utf-8?B?YUtMeWJwSE4zWGhZSi80V2ZvaWxKT1E5WGtua09vT1hWQWZtem1CNG5lMlFm?=
 =?utf-8?B?akxhYXFyOU1XWFlqKzRxQ0xRN2I2SXRNVWU5Y3NRZ0dCalJVY01tZEZYMHZq?=
 =?utf-8?B?R0Y3ZDFoYTltUUhBbHEzYkZ4V1pMeVIzUm8ySGg5bU4zbjBXb0pmeWx5Mlgv?=
 =?utf-8?B?NXMrUkhSM2NqZmpaa3pub2F0SFBHb0U2eTdiKzhLWFdGa2ZzTVlrNzhXVGlx?=
 =?utf-8?B?ZkpuNTdhYjBNamVYNmhFR2tFandjSzVLVFlsajNIaXB4ZmpJZ0R3dis5NE91?=
 =?utf-8?B?TnlFdW43eU43TytpNEVQeFNGTVJsdXVXL3pGSnBjVzI2UTczOTBCSytqakVy?=
 =?utf-8?Q?dJi6d9iXm/GMzKtU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2128fec-2133-4406-275f-08df136c6063
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:30.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR5nrUnA17SFN1FQ4o2mdC7YrZw//WtjZnHpEqqtxfxLnIrGArcmArfv/VXSx8TFY/+pVCYDEnqqDMco3wMLCqhgzoR7MtEAO9BX5KRI2hY=
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

In its current form, the mechanism for saving CPR FDs into hash table
has flaws.

The CPR fd hash table uses the same CprFd for both key and value, and
is created with a key destroy function.  Inserting a second element
with the same (name, id) key leads to a use after free.  According to
GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
value with the new element, and destroys the new key.  Thus when
inserting 2 CprFd elements fd1 and fd2 with equal keys we get:

  g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
  g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */

Any subsequent cpr_find_fd() for that key then returns freed memory.

This is reachable whenever two CPR-aware objects register fds under the
same name, and it happens long before an actual CPR, since cpr_save_fd()
is typically called from .realize(), i.e. at boot time.

Apart from the UAF itself, when the user decides to perform CPR migration,
on CPR target we'd get corrupted FD from the hash table and fail somewhere
in .realize() for affected devices.

As a solution, let's altogether prohibit adding CprFds with duplicate
keys.  Since FDs are being registered for a subsequent CPR right at the
startup in .realize(), that'll allow us to error out and exit QEMU (or
fail a device hotplug op) gracefully instead of delaying potential
problems for later.  To do so, let's make cpr_save_fd() return 'bool'
instead of 'void' and provide an 'errp' argument to it.  That way caller
becomes responsible for checking the return value and propagating the
error.

Also update all the callers to use the adjusted interface to keep things
compilable and bisectable.

[1] https://docs.gtk.org/glib/type_func.HashTable.insert.html

Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 backends/hostmem-memfd.c   |  5 ++++-
 backends/hostmem-shm.c     |  5 ++++-
 backends/iommufd.c         |  4 +++-
 hw/vfio/container-legacy.c | 17 +++++++++-----
 hw/vfio/cpr-legacy.c       | 10 +++++----
 hw/vfio/cpr.c              |  6 ++---
 hw/vfio/pci.c              |  5 ++++-
 include/hw/vfio/vfio-cpr.h |  6 ++---
 include/migration/cpr.h    |  2 +-
 migration/cpr.c            | 55 ++++++++++++++++++++++++++++++----------------
 system/physmem.c           |  5 +++--
 11 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index e21c5a3f2e2..a95a4368a9e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -54,7 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd == -1) {
         return false;
     }
-    cpr_save_fd(name, 0, fd);
+    if (!cpr_save_fd(name, 0, fd, errp)) {
+        close(fd);
+        return false;
+    }
 
 have_fd:
     backend->aligned = true;
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 806e2670e03..2fa7b823a62 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -48,7 +48,10 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd < 0) {
         return false;
     }
-    cpr_save_fd(backend_name, 0, fd);
+    if (!cpr_save_fd(backend_name, 0, fd, errp)) {
+        close(fd);
+        return false;
+    }
 
 have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 15f2a513501..45fd2e44c7f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -85,7 +85,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
         if (cpr_is_incoming()) {
             be->fd = cpr_find_fd(name, 0);
         } else {
-            cpr_save_fd(name, 0, be->fd);
+            if (!cpr_save_fd(name, 0, be->fd, errp)) {
+                return;
+            }
         }
     } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
         error_setg(errp, "/dev/iommu does not exist"
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 7ac7b372145..1d2c8356189 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -844,16 +844,21 @@ static void vfio_group_put(VFIOGroup *group)
 static bool vfio_device_get(VFIOGroup *group, const char *name,
                             VFIODevice *vbasedev, Error **errp)
 {
+    ERRP_GUARD();
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = vfio_cpr_group_get_device_fd(group->fd, name);
+    fd = vfio_cpr_group_get_device_fd(group->fd, name, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "error getting device from group %d",
-                         group->groupid);
-        error_append_hint(errp,
-                      "Verify all devices in group %d are bound to vfio-<bus> "
-                      "or pci-stub and not already in use\n", group->groupid);
+        if (!*errp) {
+            error_setg_errno(errp, errno,
+                             "error getting device from group %d",
+                             group->groupid);
+            error_append_hint(errp,
+                              "Verify all devices in group %d are bound to "
+                              "vfio-<bus> or pci-stub and not already in use\n",
+                              group->groupid);
+        }
         return false;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2d40d8baeaf..14a06a1fa59 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -254,15 +254,16 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
                                                 &vrdl->listener) == 0;
 }
 
-int vfio_cpr_group_get_device_fd(int d, const char *name)
+int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp)
 {
     const int id = 0;
     int fd = cpr_find_fd(name, id);
 
     if (fd < 0) {
         fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
+        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
@@ -291,6 +292,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
      */
     cpr_delete_fd("vfio_container_for_group", group->groupid);
     close(fd);
-    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd,
+                &error_abort);
     return true;
 }
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index ffa4f8e099d..6e1659dcddc 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -32,11 +32,11 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
 #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
     g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
 
-void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
-                             int fd)
+bool vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
+                             int fd, Error **errp)
 {
     g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
-    cpr_save_fd(fdname, nr, fd);
+    return cpr_save_fd(fdname, nr, fd, errp);
 }
 
 int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f0698..ad13f2306f1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     }
 
     fd = event_notifier_get_fd(e);
-    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
+        event_notifier_cleanup(e);
+        return false;
+    }
     return true;
 }
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index ecabe0c747d..e57766e7e2b 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -60,7 +60,7 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
 void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
-int vfio_cpr_group_get_device_fd(int d, const char *name);
+int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp);
 
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
@@ -71,8 +71,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
 bool vfio_cpr_ram_discard_replay_populated(
     struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
-void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
-                             int nr, int fd);
+bool vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                             int nr, int fd, Error **errp);
 int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                             int nr);
 void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 56fb67e6b4d..3ad084d5bab 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -28,7 +28,7 @@ typedef struct CprState {
 
 extern CprState cpr_state;
 
-void cpr_save_fd(const char *name, int id, int fd);
+bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 void cpr_resave_fd(const char *name, int id, int fd);
diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf35..aeb9ad12392 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -82,10 +82,27 @@ static GHashTable *get_cpr_fds_hash(void)
     return cpr_fds_hash;
 }
 
+static CprFd *find_fd(const char *name, int id)
+{
+    CprFd key = {
+        .name = (char *)name,
+        .id = id,
+    };
+
+    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
+}
+
 static void cpr_fd_hash_insert(CprFd *elem)
 {
-    /* Use the same CprFd as key and value. */
-    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
+    GHashTable *hash = get_cpr_fds_hash();
+
+    /*
+     * The same CprFd is used as key and value, and the table owns the key.
+     * Inserting a duplicate would destroy the new element while keeping it
+     * as the value, so a duplicate key is a bug in the caller.
+     */
+    g_assert(!g_hash_table_contains(hash, elem));
+    g_hash_table_insert(hash, elem, elem);
 }
 
 static int cpr_fd_pre_save(void *opaque)
@@ -127,26 +144,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
     return 0;
 }
 
-void cpr_save_fd(const char *name, int id, int fd)
+bool cpr_save_fd(const char *name, int id, int fd, Error **errp)
 {
-    CprFd *elem = g_new0(CprFd, 1);
+    CprFd *elem;
 
+    if (find_fd(name, id)) {
+        error_setg(errp, "cpr fd '%s' id %d is already registered", name, id);
+        return false;
+    }
+
+    elem = g_new0(CprFd, 1);
     trace_cpr_save_fd(name, id, fd);
     elem->name = g_strdup(name);
     elem->namelen = strlen(name) + 1;
     elem->id = id;
     elem->fd = fd;
     cpr_fd_hash_insert(elem);
-}
-
-static CprFd *find_fd(const char *name, int id)
-{
-    CprFd key = {
-        .name = (char *)name,
-        .id = id,
-    };
 
-    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
+    return true;
 }
 
 void cpr_delete_fd(const char *name, int id)
@@ -176,7 +191,7 @@ void cpr_resave_fd(const char *name, int id, int fd)
     int old_fd = elem ? elem->fd : -1;
 
     if (old_fd < 0) {
-        cpr_save_fd(name, id, fd);
+        cpr_save_fd(name, id, fd, &error_abort);
     } else if (old_fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
@@ -192,8 +207,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
     if (fd < 0) {
         fd = qemu_open(path, flags, errp);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
+        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
@@ -400,10 +416,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
         }
     } else {
         fd = monitor_fd_param(monitor_cur(), fdname, errp);
-        if (fd >= 0) {
-            cpr_save_fd(name, index, fd);
-        } else {
+        if (fd < 0) {
             error_prepend(errp, "Could not parse object fd %s:", fdname);
+        } else if (!cpr_save_fd(name, index, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
diff --git a/system/physmem.c b/system/physmem.c
index a4a6a4710c6..e94fe5d4a4a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2445,8 +2445,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
         fd = qemu_shm_alloc(0, errp);
     }
 
-    if (fd >= 0) {
-        cpr_save_fd(name, 0, fd);
+    if (fd >= 0 && !cpr_save_fd(name, 0, fd, errp)) {
+        close(fd);
+        fd = -1;
     }
     *reused = false;
     return fd;

-- 
2.47.1


