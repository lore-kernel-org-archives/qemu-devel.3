Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19845CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC86-0005C1-0B; Thu, 01 Oct 2026 04:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7u-0005AE-TK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:52 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7q-0003P8-U2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/rumRg+8D2Y32W2AJ6Cm08Vudxc5tT7aSBf8312OXhuyrTxNhF3qDj1tIZIf22qE9JEuxBxWlI2yLYQ3boz/L1F2gvK//aucAOd7hF+YrFMGERMGMc5clEs/0NhhtC4N/YFHTfauARvoO1dbxKTIZVjMxAU/K7hOw+SthXXGCPx17/zTYSk7YCzn7HnGn/CiywbZz17HY8DzAnjH+ST5SwMRWVe998wzaoLMkHI4MZmsir2aAiJnHtz0gVVtzIVX90JxkS6bxZWdT/uJhuwWw7CvQfcrGnaxxt4f++RNpJNL0HiLzgLml/Tzy+b+jIZCX5IkD6lJudf7xBsYWDYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx9awxMhMB2A9zDewAD7duOTTce88aBzJDXdNbYa4Z0=;
 b=kEq+htg3eLaZ2JT8DUto0LcKvlSjCvzsmosPYkZofq5PqNkCy7iLchlaQtov8ESUPftHGw/WONYP5XYmGA4MDUdcJvr2YjBFpjcpmG/TQwg5KOovd7YnpLOoI2vPZOs9HMXAbjrqrqUW0DikzObiUPNM98InZRqM9XLIdGYY0+RwDYi3Nsm0H800JlIR/HFfdHXCNo3Mxji/fhMNyUsQbHWFUvZyUmhQTHCoR+1mPsq2RoF9OeDK0vZVC7H2tUY+TQagXEhfHeNtcuv7dPN5v0wyosX/6K/34PgHzNBWKZ4IXXhlihzq/y0uewz/N2SW2dd4mgqOxH4HOmRrjCgGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx9awxMhMB2A9zDewAD7duOTTce88aBzJDXdNbYa4Z0=;
 b=ZTF5PjrLxF/U66H7/SlKciqCvm+LZ41AH+L2CoBHWsq+Vo6NtXn65kOcGKr8WptqHIU4delHc2kMNEhFwMIKQRyVgRoxj2FXlSwgnqNuK0Dtt0Bv3T1E9OMEC2VFhLENfGWSTjNKgUdjaHbWWJiFANn36D1I+8wMPCXNjBrOg5h0FZIEw8vEXIMBIQMRhGS7eWj753EzCSc1drSlY3ReYpaKatv+4qHP0fwQ/MzLNVdoXhSxlOFfpnPrIaGO7v7IUba5NIazyodpTKgnTX5+98esFLXBsFJRb6PTz/G28IfxbhYuu/1ARY/plq3RNMz0uR16lClib407ibJiDR3RvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:38 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:01 +0300
Subject: [PATCH v10 01/18] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-1-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddf8536-d0b6-4d95-9e74-08df1f95b670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: XDCosPA1+d8CpYW5TlxOaqeaC/FLOFz9uWLw4MEuJ2p9yGYVwMKAv/v9a+pxq6ZorNosyz/5n1cYDR4mSeVYbBhcufdTjoBtlg0/WjT86CzBEBqSctH/hXBPIXWiVOb7vtXoT0XByTT+ZI+v1sWQ2s1jPt4OaDBsjh8tXuGPyQz7RocrNLhev4fUDDFinS7RG2uTwCYgqfSE9/mFYnwQjcuGbuUZ9+OkaBi7A9liKdTUU5hW6WjktIkwaj5O8scNfzD+tUqA3v1FY5YSGfDkRRrMCWT8C/1QsgmmKzGvK5IK+uPJnoWA/lGU9E6MFKdyqdt/AaZai5QWVzChE1v1RLZEyV25gmwNYS7EWsCGKP+pA4q9gslTp8Glo4/1Yq3jLkxMJ0g7A5y1+nFd5yYjNfr+jb28PFkD/gu1C0EOUIhTxboNQLXeH7V3kzISVDKcnJC2NDN4krbmc6p6kIN3yafJvSVXUFcKG3lCqLsr0RLfMGMmqqiO8+ywNJwEiatbT8lfX5V51VnbBCT0HWmlEgwPujT4CdOAbXxfLdkwWFgxf+KsF+c9NP1yQertKBAGOlJe0s2XIpPt4PudGxBbNsnGOnZyTCZRq8T63aTDfx39oDsJ21ZY0FkV35gSa71vzC0s5d3BrMx49uoMSseR1h7vd14tlqkmC2eIIV1ZY+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEoxZHlyMnRtL2w3NGxUSU1ZQlJUNVhhSXdrRXI4L1l2ZUFOalpkSFptM1o1?=
 =?utf-8?B?TEpBWjlkM29EaWxTMUxpam5NLytqa3JteTczWmV2VUF4eEQwNVlqeVBaRy9m?=
 =?utf-8?B?Yzd4OHVWZytXS0R3K25UdWx2clFPOWhXanAraER6S0FvVWsySC9Fb0FaVk4x?=
 =?utf-8?B?cDdFSWhZZ2NwUFYxemtTTk91RUg5KzByNmtSUHVpL3FDZDVlRWc3dmxncTBy?=
 =?utf-8?B?MnFNWjIrUDVhVlJzd0JOWU5RRU5rVGMzbGdNMG5peHJhdkdwd0hnL3llTDVo?=
 =?utf-8?B?N2RxdnQ5N2h1V3lBM2NReG1RT3lhQXEwcHc1aEJaQjVLbXRxcFhpYzIrRmor?=
 =?utf-8?B?UTNwRGp6Z0lKYWUzeENaMGUrTDJxOWcxeDlreHJtUXNDWHZ0UzVHc3FjSXl1?=
 =?utf-8?B?TDFFMVpKUUgzeGg0V2xTWnk5VUJvaEtUUHF5bzZVR1BibFBhU3N1OGg3d2RR?=
 =?utf-8?B?bm82RkZGOVM1SnR6d0FoaHhNQXBMUGNpeWZyS2lqemhyaVhiRHkzNnhJWGQw?=
 =?utf-8?B?N3VQdTRwazlrVnFRYi9kaVZYcDJvem5BejVnQlgwSjJFZjdNQUJvZVlvc002?=
 =?utf-8?B?VVp4blFZR0gwWW41dHMzRHdwZlBlNDE2Zi80V0lxakc0dXE1c3VzYzJGSVVK?=
 =?utf-8?B?bW10UC9KL0dnQ0djcTVQcGpRZGJ3MFpXL2J3enQ2OVhCa0FUR1NURXV2OXNC?=
 =?utf-8?B?M1hCYmZobmhDN3hub2FvckxBSCtpRWlocVFldGJQdTVaZ1hCcE4vclc1MWt3?=
 =?utf-8?B?bVJWMUR4QzFyZFVTcE9xRm5ReUR4MDMzelVsNHY4NHYyZTFuY0ZsNkJhNHpu?=
 =?utf-8?B?Mm1VOEVyYTFESThNMUhyL3VYOU1aTXBkTG0rdGVsMzZxSDFqZXRERDVQRFpn?=
 =?utf-8?B?TUVSU2xLNFVMTkJneTVFN01ZN0lUcFd5TmJSLzBsQy9XdmZma2IxSUhHKzNw?=
 =?utf-8?B?dllEOEtkRmc4N25BUENkYjkzYmtuNCtSYSsxS3BnWTdwQ2s0YzU5aVNZNkhK?=
 =?utf-8?B?UmlWRGplRTJUK2FPZFBoSWd3UDk2NGtIV1pFWTEzZlA3V3JoUjhkQWpKS0N4?=
 =?utf-8?B?VnZ3VUYva1VlUFFhRlIxeUhLc2c1L1ZqMUdxVjg5T2hLVkZsUDJsTm1JaUNZ?=
 =?utf-8?B?R1VxZ1FkdXZjRmRucHd5OVBPNlZEQ1RmOHRReFNtMFBpWHNqYlJBNzIzVmE4?=
 =?utf-8?B?bzZoZ040d0JmdXQySS9uQTJCRllLdU5nU3RiWFlXblQyT2VLRWI0emlIcjdU?=
 =?utf-8?B?bXp4U3pOQUxKc2tYT0F1S1VGRWhyS0hEeUVOcXYvZ3VPaFF5aHNrRUZTQ0xB?=
 =?utf-8?B?WUk4MEs3eTl5bkdkalppUVJYVFo4M3hNWmRtMG8ySjNtVjRXUDJjV2dVbThG?=
 =?utf-8?B?Nzg2SFNSWks2d1dCYllwNHVtZityQU5WVTBCeDAvWTlDU0plN3RCSlJkNFhi?=
 =?utf-8?B?Rm1nTU5jTVRvU1d6WkRjdWtZMG5va09ocmNjWDJaclVvQUpJZE41RmhpeUJQ?=
 =?utf-8?B?NTd1L2N6UTRCZDVzU0hFSStHRDFHQy9PbkJOMXUwaU5McmJaYWFKYkl3ZXpV?=
 =?utf-8?B?VGRDRUdXbFlZMmx6QmN2NWNoY1hvc0pqSklNWWVWZlBTZzdxMzFDSndxV3VQ?=
 =?utf-8?B?NlBaRFFra3pDQ0dFckYyTDBYNnhOM1dNbTZ4ODFKeE55dmtWbmFudHE0dThG?=
 =?utf-8?B?TGdVOGdlNFlqejJlS3VsWGpRMUtsN3hxMXlncFdCeVgvZHozTlR6RTBudEpj?=
 =?utf-8?B?bHdJNEhTaktPdnhoaFU0bDFVdVBEdEhFZ3ZONERPMnpQQTZPeUtqYWVHVmNY?=
 =?utf-8?B?eGhJQmVJYzVZSXRTUEFzRVUxbVNsdi9OUFlBSHowVCsxWE1nV2k1WGt6bEVE?=
 =?utf-8?B?QmRzaC8rdFdSbHFLM09YWjdDc3pYQXp5Sk1KM1VoanFGeUNMeEhkUldkRUti?=
 =?utf-8?B?bzY2c2kxVmpnRXpLZ2U1QWF4bHVMZGZkQ3JtZ204dkxwUklSUXZlN2RlTy9G?=
 =?utf-8?B?REZCRTIyV1lHRm0zSnpsRElFL1RMVVc5ZTNXc3RteFZuTGd0aUhrVXBLa1Yv?=
 =?utf-8?B?MlpXZVQ5OU5pY0xFRXNpWThGWHJ2SytLMWxRQ053VFdVU0FNaGVvZ1ZaTVlY?=
 =?utf-8?B?UGFTVVFaUnROZitOUnViODhQcFY1aUlJNy9IWUp0WmZwZzZ5bnZVNVdiM3NX?=
 =?utf-8?B?M0x2cTRZbjRqcEFhU3FLUlppbVFiNEV0UGVHRTV2TllJYXEweGZkRnBmL1RE?=
 =?utf-8?B?QVhscFgvdW5DdUJJM0xNSE8weDhoSnhuUWtGV2ZzdGcxd1ljczUwWUtNYVRq?=
 =?utf-8?B?a1gxU0s0bncwSW1QWllvWFUzWUEzY1JKeEVWYXBPODJKb2k1M3lNQUphMmVr?=
 =?utf-8?Q?KNa3MTPv8XEp3Vls=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddf8536-d0b6-4d95-9e74-08df1f95b670
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:38.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNmprc00vtRuzxHsrIa6s8Hj8EmBHz5zQCmxdbAUo9KDg1ikZMVNw7B261gHewgsdl9CPYmJ2w0Z0GDo+IJfi6amCaa2Ctl9QaCFhqBYaJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 backends/hostmem-memfd.c   |  5 +++-
 backends/hostmem-shm.c     |  5 +++-
 backends/iommufd.c         |  4 ++-
 hw/vfio/container-legacy.c |  7 +----
 hw/vfio/cpr-legacy.c       | 29 ++++++++++++++++-----
 hw/vfio/cpr.c              |  6 ++---
 hw/vfio/pci.c              |  5 +++-
 include/hw/vfio/vfio-cpr.h |  7 ++---
 include/migration/cpr.h    |  2 +-
 migration/cpr.c            | 64 +++++++++++++++++++++++++++++-----------------
 system/physmem.c           |  5 ++--
 11 files changed, 91 insertions(+), 48 deletions(-)

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
index 7ac7b372145..50ca5a3a7ea 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -847,13 +847,8 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = vfio_cpr_group_get_device_fd(group->fd, name);
+    fd = vfio_cpr_group_get_device_fd(group, name, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "error getting device from group %d",
-                         group->groupid);
-        error_append_hint(errp,
-                      "Verify all devices in group %d are bound to vfio-<bus> "
-                      "or pci-stub and not already in use\n", group->groupid);
         return false;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2d40d8baeaf..807ffacdbc9 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -254,17 +254,33 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
                                                 &vrdl->listener) == 0;
 }
 
-int vfio_cpr_group_get_device_fd(int d, const char *name)
+int vfio_cpr_group_get_device_fd(VFIOGroup *group, const char *name,
+                                 Error **errp)
 {
+    ERRP_GUARD();
     const int id = 0;
     int fd = cpr_find_fd(name, id);
 
+    if (fd >= 0) {
+        return fd;
+    }
+
+    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
-        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
-        }
+        error_setg_errno(errp, errno, "error getting device from group %d",
+                         group->groupid);
+        error_append_hint(errp,
+                          "Verify all devices in group %d are bound to "
+                          "vfio-<bus> or pci-stub and not already in use\n",
+                          group->groupid);
+        return -1;
     }
+
+    if (!cpr_save_fd(name, id, fd, errp)) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
@@ -291,6 +307,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
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
index ecabe0c747d..9157a4ac649 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -60,7 +60,8 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
 void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
-int vfio_cpr_group_get_device_fd(int d, const char *name);
+int vfio_cpr_group_get_device_fd(struct VFIOGroup *group, const char *name,
+                                 Error **errp);
 
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
@@ -71,8 +72,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
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
index bca43e9bf35..cb027bba504 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -82,10 +82,29 @@ static GHashTable *get_cpr_fds_hash(void)
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
+     * We prohibit inserting duplicate keys into the hash table.  All callers
+     * are responsible for checking that each added key is unique.
+     *
+     * 'elem' serves as both key and value, and a replacing insert would
+     * silently free it.  Therefore we assert, not overwrite.
+     */
+    g_assert(!g_hash_table_contains(hash, elem));
+    g_hash_table_insert(hash, elem, elem);
 }
 
 static int cpr_fd_pre_save(void *opaque)
@@ -127,26 +146,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
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
@@ -173,14 +190,13 @@ int cpr_find_fd(const char *name, int id)
 void cpr_resave_fd(const char *name, int id, int fd)
 {
     CprFd *elem = find_fd(name, id);
-    int old_fd = elem ? elem->fd : -1;
 
-    if (old_fd < 0) {
-        cpr_save_fd(name, id, fd);
-    } else if (old_fd != fd) {
+    if (!elem) {
+        cpr_save_fd(name, id, fd, &error_abort);
+    } else if (elem->fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
-                     name, id, fd, old_fd);
+                     name, id, fd, elem->fd);
         g_assert_not_reached();
     }
 }
@@ -192,8 +208,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
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
@@ -400,10 +417,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
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
index bd5f41cb020..d54eb21fc01 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2447,8 +2447,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
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


