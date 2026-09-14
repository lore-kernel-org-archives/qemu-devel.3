Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F7DC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FH-0004HK-9R; Mon, 14 Sep 2026 04:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FD-0004Gk-Sj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:56 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F8-0005Pw-TJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5/Xsld+hwMmyx55n8zbDHwhFXmvknOADfxsyw2WkyHojUkiRimT8OPpyZXSBndNXbMRm4nc12VnjKxGzj54BBoQGGELE/XYK+/5Td0AVg5Aq7hqxDFOSAebv8FE6FotzVq3dg35cFFi3D3XnhV+VpNQjrdKvHLStMR3chPQ1B6Fu4uBZztI7T38VLDOnKRYxZaIC7Daz422tfxaRgvid7CI3av78ohV7LYtw8mPtrMch/Gk3amc304hd6ZBwb/hbapK6YVvOJYfy4sPOC8WXRNg6WURL3DjtTqT0ge1xLvSwL+KxByFUm6Yi9A1zlCHPFN1YEiTT9J1ontoixDA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQsJ0KTWNLp0OJ7kXGs1faxhgmR2rW05Le4fZX94OTs=;
 b=O/gXablmpRnsfozs/qjefeKo85RrcxZWJqAqHkMcyM27nePvOSMV7AchzQe9JScFixkmK9+2pcdeZpfRKjYVBswngnww50XFclAHu7EKkfAYX9JQitndlYPU2YhSQfmLGurIlN6MyGcGLAV23+uqBpK0bekeNHPFQiEIoAmHGHfpW4ZTD91OXHkNA3RG0Rkx4MuADhwdv9JrRE8GuvRbv5xYPT+xkzYVxaXLp35A9j278VQq+b0G5hWVKEnjPIGaMHMR3Okr+HloAIkKiuftw47qMvP/2l717b0phxQTbGtNOAj/pbMSvuFzySZ+tmjF7La3k4Ablc0e0w5wAVbl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQsJ0KTWNLp0OJ7kXGs1faxhgmR2rW05Le4fZX94OTs=;
 b=zmsn5syyd8OSrIDla45KNleaKPXRqcL/leTf8IRT2CKsr3wgXLfL5vCozi2sEPJvjmjuYQnGonf7L9afHa8oy3SYE1Xg33udqIpDvdCDfceEZAb1Ojl34enWt/QH0xBPaky8B7NxPgMbf1V7IDkwqOkJ42q+G3enhPX1Cr202Fq1KVbDBxXuRHoIjQW5/EjE1ZHLYYY2co4zW3FbCe8jPS5FKplvAu1U3LDa9tgZ2zgSvBKnNAelJ39UmDkeUCOsCVxX5nnkOZWdVJvBlrg0N+oLnQ9ZsR+H9BffubII4xOefSRkgo/l4K26PS9m6KNJu47RaDdOY9QhMbwMuhi73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:32 +0300
Subject: [PATCH v5 01/14] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-1-d17423589f48@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bbadd7f-2a7e-4158-f1a7-08df123bcfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: IL6qh8vkHSLwz7YGFC7Ghpp+ZcS8slBYduQ+JIOS+wfpRCQ7gXhCH2mYmxnLf78CI15P50huGObO7nYqrydXihtmNb+fbRccZWqsBWdDbcLiH32VA9y3nBevZdLTRIf5U1WtTz/a7sgp3rBxW6ZDknJ0PuoMtiU/iQ8KePP/FkFwoGxmv5Rq+R8OAkJmRSIZhztrNnwTQ1WZmAmGIzRQ9aKnPzviPXPs3hn1f55WlQQ4IinH7JtAgBEw48p3nkLc1wxTjWSZ2RvlkeZJddznbbMMrIkuaUYKvw4D/x3yEH7Ab7+cbzEOSdkONCtbiYturbBv9V7Nf0GmPp33WhYmyaPTwHt6qb2duW85vdUVqouFuAkw8NJFWHGalp4pBsgcupM1VkdewHrFz2xwpXWPK8aOnTxoK1WMzas4J9n/2KxHdUuO3bCeZn54Zn2ohhkGzfBJu/3wquDCQZg5jPgjujj07BhU4my9FfVwXa8Jmj3chT6cs+JW1dUxpSkVyuNd66h/XXWcsi11ap3axdIiWpNJ2tyU5ShtDl5SRHnAczHqLBmWB+XVJN6Pz+yNUmZ2mkYQdynpYvSYcq3v3rr4YQQW9miRzuWdaKznZnzz84IYxibKhY8jil3DidGetgpiHntyZqmGSZ0CFVijEj4K/lwHgTBFeXkjqazszn45ZKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU92QnF5V1g1eUxUdC9QWG5DK1ZPeUl2Y2NCQmN2NVk0b3VCbVF1aHJLelJs?=
 =?utf-8?B?Mzg4TUdXQlBpU3ltY0JIb2xZdkRUTnFldjR2Um1wU3V4ZnZCUjFjemFzK1R2?=
 =?utf-8?B?bkZEZmJYSWRsY01OVElnUW5qaTI5eHRhWGc4eDFZTFJqR3owNzNiV3lXRXdx?=
 =?utf-8?B?N2QrbnQ0S1FxbVcwaDljVEtwYTdqNytreUdlVVVUNFlSY3NCM0M1NHV4WXpO?=
 =?utf-8?B?NHNuTE1zMFdGWWhBR2NiTFF5U0JuT0V6ZGc4SW9UV2hmNGgzOHB6dTdsdGx4?=
 =?utf-8?B?UTY3UTZmSkZHWS9WYUlmTjB3WW5TS3RUU0pjNXkvQmJRRVcwMTFoT3pESHpo?=
 =?utf-8?B?cGp5Nm80dTJpNWlOWk1hOFlmR3Y4L2ZESm5wTUMyaUh4Qkw1enYrUlJOZ2xL?=
 =?utf-8?B?VCtvMVduUUlCampkbUs5WUZhQjZrTDJwTitKQ0tsS1RuR3RpMnlGbXRsU2hy?=
 =?utf-8?B?R0JwdnFlaDI5ZVBtdUkwWjBTditVRUI2YVc5VGRONm5MblVCRWJHdkd5aU9E?=
 =?utf-8?B?bnlnNTlqeEdXMDhnZk05N0dZRVhlbEtRdTlKUlpUeTNQQ25HN1Fyb3VNN1lJ?=
 =?utf-8?B?UnF1Vjl1TVVJbkJLcHlSOWptVk5jdEN2ZHJPbkkzcnFpQnFQaHBmNzMybEEr?=
 =?utf-8?B?RVpKSktRVzlQRUI5YjNLUGd6N0hqZXVNQ0NEOXE0ZFI2bGZFbVB2TE5EUFhH?=
 =?utf-8?B?ZWtRZTFQSWhwNHVmZkdYSHQvUE50cE13ekZ3UzJTMzRGb21yRmVyYXNxaG5E?=
 =?utf-8?B?c3RDSjFjSFBXMTF1ajJtZWVhNk43azdubmtHclFtTlNkdUM0V1FuVlZNVzFl?=
 =?utf-8?B?QnNlL3VBRFdHU2psRlI4VXUyczU3bGU0YmY3UFQ2bGxBMElTbU1PemZaby9m?=
 =?utf-8?B?L3BoYlVTcG5jMTROWVpibWJaWllOYTN2NE9wak4wWktLUXBzN2p4SkJlZzhq?=
 =?utf-8?B?SFBjWldmdnNkcTl2V2JZd1hOODJHM1NmdFl0U2htOGYzUDkyYTVXODlRUVAy?=
 =?utf-8?B?RnhVTXFBKy9aVzNkWWQ3Wk5rK0tsQ1pzdUNWVmkxRVgyejFaY3NXTDU1cCtY?=
 =?utf-8?B?RzRsMGJNREJGbStsMEV3bkZnaFQ5MkR1TmpNRDBrNW5oeC9aWEpnVTdSVmxL?=
 =?utf-8?B?TGNWcWlyNmZMcjJjK09iZGUvM3JoWDRmbFZjSkVEc1lOZGFQOHA0bWovc09m?=
 =?utf-8?B?MFZ6MFUwNEhaWVlmNk0xN3orUUIzQ1V0bkxiNXlPVG9iK0lDRXJ1d0pVMUw4?=
 =?utf-8?B?TkpzbzdVWkdGTzBteCtsVkFZMGVpTDdIUGRRZUdDUWNvZjFsai9uNVFSMENL?=
 =?utf-8?B?c1VBWHAvaWU2Q1JMMmlmclFjZjB2TGljYmE1ZG40QlZvdFphMVZRbFA5aEtO?=
 =?utf-8?B?eDh6L3lwQVB1eFpKUVdYd2hVQVFseUpRYVdoanFBbEhHYnZUZWtSTlZrbHlX?=
 =?utf-8?B?WVhFM3luNTVURnUvcTJDNlNDU2FFdUU2alA2TytVM3NTZWV0QTdieVV2bk5Q?=
 =?utf-8?B?aFpMMll4S3NPRVVGajJKbkd6Wmx6dWhqNFdXa255L2kra0RtWkRVL1FwRjc1?=
 =?utf-8?B?Z29qZ0V3Qjc1cWltaU1HR0lzK3hJZGZPMEszRUxURDdxYnRxQWJFVFRleFN3?=
 =?utf-8?B?NDIwVlBZbkRxMjFuTk9oZ3kzcys1MjNoTEtTK2JELzJOYzVJMnpQbTlndi9h?=
 =?utf-8?B?TnRvS3YwUm90N0JzR0dTTGI3SXRwY2dTTm81ekk1RmhETzlBZlQ2a1JleTZy?=
 =?utf-8?B?SmFaVnNyYTlGcUxablhpU0N3NUNqZkFCdmUvSnc4NDVEWmpnakhabzVaWHI0?=
 =?utf-8?B?Mk1HZ3lWd29BQTg5aUlTRGMvYno3Y0NqWit0OXZnM1NzaU9keUVLYWhWdGZ3?=
 =?utf-8?B?Y2hQMVBGQ0xXaHBvcEpueUlndnFmaFBJVkF2Z3ZHelhBaytGcjA1VG5HQjE4?=
 =?utf-8?B?cW40Z0R2akFncFdRcDZvZklVQkRpL2NEZUYyRUNQVXNyM3dKZDN0eG9CVFpy?=
 =?utf-8?B?c05mWXpNYzlvL1RlUmFVSVZ1eEtEU3dqMzhmQjk5KzNLSDFGVU1WVFlnMVd1?=
 =?utf-8?B?NnFJazZjb0g4UFZoSi9aZEVpQ1hnQ0xvcW1NUkcrZzFvek1FSjBsMEpDaW9E?=
 =?utf-8?B?My93MVo1b0VENExFYjFGYjJpNlk3KzA2bGRRMGhidUZIUUZPaytiaW5DaU9G?=
 =?utf-8?B?cTZHdklCVnZGOEk2NlRUb1dsdnZkQ2Z2WG9NUVU2cGVJajZtRWl5VHVBalpk?=
 =?utf-8?B?VE14YjIwK3dhUGRxVFl0YlRhU2oxN1ZyVW1SRkRLcGp6bHRMeFJXR0VCT0JN?=
 =?utf-8?B?SEswVmRvMnBXUW8rUkRPcFdSbTJzY3J1dHRpWmVRYzBDNm5GcG1vNWhXUm5C?=
 =?utf-8?Q?vzRY9/6oB5rbzJvg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbadd7f-2a7e-4158-f1a7-08df123bcfb1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:20.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaeXXkE8+PIRNsv7zfSiPSLTDKpOgX2LWdc6Fm1LHABbmKqERcGL5e69P9c+rkkXEyKZmjiQ02u17OsPtpoemaZ8/N5eou1ovX4qWPuC41Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 923239f9cf6..a072115216a 100644
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


