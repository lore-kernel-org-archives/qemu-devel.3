Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AAFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMaz-0004jp-57; Wed, 07 Oct 2026 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGRv-0003fQ-Ng
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:28:15 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGRo-0007CJ-Aa
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:28:00 -0400
Received: from AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) by DU4PR08MB11031.eurprd08.prod.outlook.com
 (2603:10a6:10:576::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JanvwSdH4vqFzSI4OWOhM/0h2+JI+EIhLaZuP+18TpTTEDZMislUSrEOk3dd3JbnG+8RtkycC9r6xTFP5mtoKIFuoAWb6orGEdMq4EJt4Prh8++ZTwLY6BY0xo1EF9C80NMDObVW3LQUlqZgJafVTpZMuXXkt2V79aUmwxQu/NtvCN8pGzDhjdsEdpqcniNrn6XlTpPQVssjMf/ctyoM72m5svKmMswFZK0qyh+Cvr1Hxh48WknJZb2HJUw57PwhT6Rk+pOE2Y/1cvlTHBDl/hjU72NnFgx6Tb0+HsFIFq03O1YSYHDWbp/JM8dikTTlNE6oJajMocUF81yy6LZqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=Mv4ezPv5CzhyBzVDU3OSYCoj9PTN+MBVbTOaHLdE9A1+juPdpGsSHVVhjH+YfXHaI/Kwio1BMJz9rxsb0n4pc7oZoM+Oeyr3B05izAe9GtV4/nJ8L3eWvIbvNC3SuWG7uuUyji2hIByVDgytSMl48iddTcy/g4WP69KcLHynoV1SV1dleo7QKGjNfpVmnQa0Aw3nXQLXqp509ycjvy8/4h4egD+iLfLX2HFlk961zbwV4q3LfXaZuKYtmuUFXXtoNcDpFVVRTOoMg3MMUv4obTgk2BIEA7Fpm2P/yxSFnWSRjQnnR1ZswzJwjuaMAruEF3hvkfD91oU3bCUCY+2v4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=brX5zsBnA30GoGMp0fKwfsbhVWarV4HvLEEhC/NcaRAr0US//o0+svHYhuiGw03gxO9hXJNGAw2Zsl0EKn7pR+XR5ZvBX2DLvHKZ+rXoQcI//WCww+rhNd6/h58p1Mk9QSh5M4ikOJcONQjOStG/IlyCWGTSiVXqDxuZUsABVT1A/4b3MQjgI+YSAABHiqqNRHaCdUke7oU95rd7yKEQmkXwjdbc0OFbIeUoanNqTE9e9lsE7fhePRKpt1NxZmCt9sAVrPAeEXstWzTW0TFGhB5Qcu1wn9iDpg0+vKyUrUxrYa8cyS0jS5U71Zxzl9Bg1j7/SfCD7N7MDQyB/CSSVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:24 +0300
Subject: [PATCH v13 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-1-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB286923:EE_|DU4PR08MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: 847b5339-bcd7-4b8e-6813-08df23b1f227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 8rLNADbnKxwTm9lbEi65jceb+kejQT7nJcAcx+IsAX2QXUVW/rmZh1/1Km9cxuHCYHs8C6BxrDTqIUYlSC3J9HVd2hqiGBVLdGr5OA4iBz0ddeTkn5GbQDGOJlUhKjxLfCHe8csK9GZfhyZ3uSEQyQWalJlvRdiV+ciRs2oTJrwswP/bsr/iZfS2Pcxy5a9JFWLRjqg7ibXXKu9iOCggJxIcotNw6Qlb47Dtc0Z2M/WYxiLVheKc7QqcdKpTv1vieuHBz8nRWuoj5SWhNPPH55Jn+nPYgHUUtxxJ1UAM8oJm5V1uRBMflrjguzYDKvcAuBQL0oIX8z/oy3T+Ou/5N1kumMgytkBsxxGMCDbjDGS/DV0Hd1vMfrtJ8+Q31NRxudSPhdent6Q6H60jSdzh4PzfyUIJW6ZGNUDvNYBQXOXo1vqcwbtxpj/AkUNEf83Z08IaU2hwv9VcQvgqVroHVjetRpiGQ9s/JmGR0ccINxUVhTOaA3fK0hPvQFoP87WjYz11gF88SS/2OWLUEmHJw2qfJJjbjL3YmE9E5sDV6Sud2+jFcOayhTHWUkV2zlXIlMD+ubVvD3dZNOx/nNkCKuFOnvwWdSXGtnL022kvKq4pplViZkVRXFxYSU8roIaRlYdH8d9zcerX4J3xQoJO5gC2+YK9O8NunBedXl1rvUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRRTEdrN3RhVTRTR2U4dHN3dWJySmxZT3B6T2VhV3Qwa0pEdXNIMm1XTWNo?=
 =?utf-8?B?QjFBaC83ZXNkdjFuTkJ6bmhBVWU2RzNxVFVxMkxEUldwem53QU0yZW1vZ2RB?=
 =?utf-8?B?ZFJZbS9FUlRQaFNxWUVXQWUrQy9rVHI4QTRzUFNnSXNGTFN6MjVLUGtsZHJG?=
 =?utf-8?B?a0tTcFA3YjFJK0RycEZLcFIvUTdQekNqUlZXKzF5akhhd0gxOW5rYjBub2Iv?=
 =?utf-8?B?UXZzSjRha0Z1ZU56TDhBVGZVWmFicFozZ0EwMFBNVUdPd2RZTEpUU3M3RmVu?=
 =?utf-8?B?ZlhCT01pOFJ5bkQxR09KNE1LMCsxRUlmcjJJMVZhampOdlpXenZBVCtXMytw?=
 =?utf-8?B?QVdMMGphZFU3ZkcxdmxlSU85U29KOHBMRVJ6NGQ3V0w4dXNlVGRDNnQwb3Jh?=
 =?utf-8?B?QUhNc2E4b05rVW1NOW4yK2dOVVU5WFhveEJSSWZxcEg4QzdCb0JqMm5rekg0?=
 =?utf-8?B?Zk91M3pwSUd1dVFkVk1VUTMyNEFVbVJoZUNVNFBnQ3JuWVlDMkl0Qm9NYi9U?=
 =?utf-8?B?K0g1VTgzRUIvVE03Z2I5UXgzKzlGa280b0dvVWx2U0xNc1piTnAzU0JHMkc1?=
 =?utf-8?B?NEh2QnBvMHlFZytTVmM3MWtCRHk2OWYzK2tWRXR5MGVEYmNBc0MxTmhZYVdE?=
 =?utf-8?B?V1lteE1GS1p4RUx2M1VaQzkyekZJQ1BEYWgyWUdVTjhPU2xKTzJHVVlya09X?=
 =?utf-8?B?SXJYcnZoVERBaFViUUpJYXA3NzRzSzd4QXVpaXRoVktWS0dHYXZDaXpSK3E0?=
 =?utf-8?B?QmFCWFpDNGFIZzF3TmxNRGR2VWpmM2ZTV0I2RHBxNGpNY0t3eFdKbkUxNmQx?=
 =?utf-8?B?UjE3eVhMY3c0b0RzWUhrVTRVSS82R1BSelhEdVpVNnRvN01QOW5yb0UyQUtI?=
 =?utf-8?B?dk1walhvaTNqVjdWbEpHSU0vd3pJUEdaRjl4NDZQTTlycThMcXI2MVpWQzIz?=
 =?utf-8?B?VWhzdGZwMzVlSU9KT290OTRjVWhNckE2V1dmZ1d4dlNiVXpuQVNvTGRWbUpC?=
 =?utf-8?B?RFZUUXpjSjNCZ1RTWWlRN3RFM0dadG1pSTBmR0cvVGFsR2s2VTZHMXRyUUJs?=
 =?utf-8?B?YTVnZnNSbFdiMkNTZXEvQlRJMzY5N2x1QzhMZDJqVGZPMXlpREpOeHFMaXRk?=
 =?utf-8?B?MjVOZWRrUjBaWCtKZHhDS1hjS0dNVXJYZ3piR0ZoWERaYk9DSzhCSHJkNVBq?=
 =?utf-8?B?dE8zVkp1anpqVmdxbUEwck5xUVRId3FsZUhXdEZWVWJrWjUwbzJUTmRnME5G?=
 =?utf-8?B?aHVvL0F0UTIxaXA1ZVAxNmY2emV0RHdnaXUrNkQ1bVdZQk1sNEtKSDlqb1ht?=
 =?utf-8?B?QmVjQlJoQnhET1BsdVpxR2tOWXF4MGsreHdSWlZxNjBheG9TZmxaeEhUL21t?=
 =?utf-8?B?dmVlcTI1UElxMVl5c0hJamZwMUxqeGNJeGcyRHE3M1JkZld1SmlnVlpyZzhG?=
 =?utf-8?B?UDVtcm1rMUFobnZRRlk0RnprZkdCRk5iWFNhOTl4N1UraEdydkQyd3o0eFEw?=
 =?utf-8?B?WUg1bGh4OUlPZlhML3pkdldXeDFEa2JUdlllSnlrL3kvcDI2bFJ1NVVwNVlC?=
 =?utf-8?B?c0xoRUxDZXl0S2w0R3FWMzVRSU1zdk5IeVk3cDkvWk14OHkySkpHaVYzNXdT?=
 =?utf-8?B?Sm03ZjByVitpUk9zY0praFpZazN2OXdRa0NhMmgxM29QM3RiMlFQQjAwcmZP?=
 =?utf-8?B?cmNZSWZPTlYwcVpQM1dQcTF2ZVFMLzVOa2NmY1dNWHk5Mjg5TkFjZ1V5UTdG?=
 =?utf-8?B?ci9wTFJlUmo2NG5ON05GTkowTXdyVW52SUEvYlQxajVWdW9rajdwWVhJNVVn?=
 =?utf-8?B?OUJrREM4OWlFZG1wVzlYZUcxdEgwUkY1ZFVkZG9jUEJYdTk5OERyWGdSYnNz?=
 =?utf-8?B?dUg1MHFXenozYTRhUG5CRGplZjh0cm5kQmMrMjk5bzFSMWsxd09hZUM3L3Qz?=
 =?utf-8?B?enJXdkZwTHhkNnpWcDJIbWdMQ0kvY0pWQmFpOU8wajZEZUFJV1dBNlV4eXZV?=
 =?utf-8?B?NEU0b0VOaGJNT1RKSk1rNjAxSllYVXgzcUZ0SjV6UXBQSkVMaHdpNlNjK0NR?=
 =?utf-8?B?OHg5ZkxCQ1p1UndKSUZUZVFuMDJLMEQzc1ViUXZIM25vRXNjV29XNE9ISE1Z?=
 =?utf-8?B?N3RpTGhuODY3bmhCL1B6OVl5cFl2d3FaSzU1UVJIejZSMzBXZFBEekI1Q1kr?=
 =?utf-8?B?Y1h6YjBPeHFObzZzazZYZFY2WWU0WXhHOUlMQ3FCRVJQZEtoVkZhV25UVTRO?=
 =?utf-8?B?SzJhNkJaMFdyWHh5L2ZvQlpENFBiS0VFZEJWL3hrL25uQ3lza3lTeXRnVW9V?=
 =?utf-8?B?VFlIeEN4bTRMWEsxR1ZVYm9uN0tubHI0bTA4Z1FEVXBKR3V1SzFYb0creWtx?=
 =?utf-8?Q?0foJ+8HTzKijNzuY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 847b5339-bcd7-4b8e-6813-08df23b1f227
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:48.9934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL2g1+akCh7yLH4aOv/RYctc0PaK4hMOlum1SlgiL9KK+8HUkgmuZSPCiKn2wqHTeShEWvgdIeRtZguzoHEESECVVKDy9zjAdo5IAD3o3L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB286923
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
index 666593ff6c0..67f1924a369 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -84,7 +84,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd < 0) {
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
index 4766db6aad0..adf60957c3c 100644
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
index db3dda563d4..a7300bb9d97 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2456,8 +2456,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
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


