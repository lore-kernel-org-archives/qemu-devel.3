Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8ECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwf-0004zQ-Q2; Wed, 07 Oct 2026 05:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCB-0001ET-9G
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:23 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC6-0006jK-G2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBTIQGBCXyZR92sMQYSDqcrOgkxOfIqrwo2t9YOifuWy5gNBaWlvbR35aXAhPCGoD5RZ2zIWs3e1B0o4WLec98Sue94tkndfTz23WVSLXxFUorCVpduHMiYkdbFzl7tdSLwY7pRseCcJKykUqvR2mnBhArPZHGcVDIwMwL6NvCn+/oORaR6vkKIDeVj+WhTqZklnN0wiix1CmbPxvzTxrqQFZD1pP1/z0Zq08iAmGGcdsFP5gnE/nzV06EihjDQe2+p9I9Vi8ZdevYfxuQeIZzmwlX3Ms0YnGRt657oNbZmeQhkxLoxk/Obycwvrevkodb590Kh854Kw+Aoa/mr3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=NGdm2HPwcoxbNsrjB1vkURxWXnj3ubN75ItVTlnV++lJH+iY+dW+UXocRgL6QbLke78dkTXwO7CxLQZS8miy4xWbOo37dqgKY3rtX334qkoXaSkFC4rHgJX3FDIQDvX8VuT8SnfbWQ+32ABtvi8ODoxq67PmgPHUNcsuuH6dbfoJDrDI1Jguv0FfUYySxIVkJavTSOH81om6Zl4xvicNVIeJDry/HKklfhz1ouxnR3ivqlyVVRE+/ImGEi5fKZy8ULP6FO5T8SHAPTFvWcQ5vhHmKx+Fy0Kc8r/OBUdbgKGvP3XdJyts3FtzWmZoepj/TD9RD1aIsBIiCbEivOTsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=fxI4hCumzIMwTYRVxYW7WK2aBsbd2WtfQLzb8rfuk2WO7d9YYChvuB1j4iTHeAVaSphahrDFVpThWTxH8lwjBkXkfUrQELKW2dNKqVUE4CvYiSd4Ild/rIUPp5VQLS/7j5+bw2DcWBZIbrbevsxz7AtXb6r56h69sp5zlrmqf5rs8AuWHMEUAYfHt6A8kAa9ukSS+DBESu+tEFDkt5MXAZVbB4vJ6qGR9pYxBdDy+RRHafNa1hUwVqt7kIrJRrjYc9INNx9ymQnH6+ow1XdYX74KqrlEv/2Ut0BM7ttPJC0XOIsWmAx4ZBv+e1aEmbcBa5VMps+7okpPycNOLXiyPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:39:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:39:58 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:54 +0300
Subject: [PATCH v14 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-1-e16de9962df0@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 44638345-feea-498e-7805-08df244e919e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: U0tgdfX119ZiMq1I4bw8mPhEIxs4i0O+zTIlUthwnVVhkZjbgN2M0kZ1PulTMMV/Ngh3hCPf/pWkc6a63ptmneiuYs7VYZ2iPpJNU84SmJej+4h9/I2pw7JYUZDZ7+QMEkgIr1RLRwPP9lj+nOe+cISClHXVxc1KpON7t/6SSseAiFjDG+v+LEu4PEUY0hq2OdYiQGG0aPbOwnGRcLQmdAyTt/eXZhg8Ry2NsLBVKWVM7UYiDDufaQ1VZcYCh9V+/ZXd4SYz6uaJT8wm0zZGzFl4R8WmLw60b85nv2agfxqXELKwYOv32uW+q7Tb32DpZ7Ia237mZx1eXt3+5dxbtNt4UQRcGyk3W2i7OcBngy9Rqf38st5tnUOG05XNeA0n8QXYZAEe7Rr7WgLtwm9JFPKpTkxt151+vHiIflX3fxm7sPGK7uhbAQw9x3SBtnDwg/eejj+c0efhbNctgvBv+nrnlKidfTn63FhBvHV8jzg+8PMDqwCKiksKj8SRpgSdeUAJ6t/1eF4/atHb05qxDVszEFtlII3rxLuSknsCGa8OlaVPVbNz1k1TBp2BsNNtl4h49eQ2KzhIdwuMM1uuz5mCYZ93KE0K5ddM6vM/lgVnk4e9e5apfeLJTRypd5kbeiV1STnda1ZZUi7C66MggxYTEQfwDYomWIvBlbMBhi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJ2MXdnMWZUbkx6MmorWThqT1kwQUtFVzh6dlU4T3lvWXNRUDg1amppZW42?=
 =?utf-8?B?Z2l5ei9YcDcxY29RT0VVamRybG0yWDZxemd0eTVPU1BDa25mTUlsUmI4c1BO?=
 =?utf-8?B?aTVjRmt1RTAxKzVpNExxVURiRWl2TXJVV3FGVE9WcEF0Q3lENmxJVGp0NzEw?=
 =?utf-8?B?VWtYUmJBZVRVSjJ2SGJoeFU2VDdFcnBYRmtyVmFHazhjMkV4VzlBMW5ka2tp?=
 =?utf-8?B?VnZkejY5eDc3TnViMWUwRVJWdXE2OTNqWG54RVpqVXBncjhKdzdJMW1EQzlU?=
 =?utf-8?B?R3NYbE1SZGg0d1JQcE9KMGE5QzlkUTJMTkZodjdwM0xzaHZPTXJpZWMxaFoy?=
 =?utf-8?B?Sk0zY2ZFUXpMQWdYcnFCWFJIU1RDN093YkpJV3dwWDhUcDNEYXdyQmcvRDRh?=
 =?utf-8?B?MVpuZm1JUCtoZzcyQTVRRjBrZm5OK2FXQzJuUzI1WDJndUhtTGc4aVphM1d4?=
 =?utf-8?B?dWFVTCtYWis3OXlqVTlQZlNPNDBlZjQrcnZxSFhMZWRPTysrQzA2eG1IL2NZ?=
 =?utf-8?B?UjdRTENzeEF6Q2x1cTVXVkpXaEYza0pzSmpqUUx1VloyMzV3bGFkRjlDQnhY?=
 =?utf-8?B?LytrYkN2d3JjTDFZaGQ0U2hOK3hWN0dIbVBqVkIrQmtsYmFNWVM4U0ZkQUFp?=
 =?utf-8?B?SHJKQTdpTncyN0FjeUtub1pvOUo3V2hWckhJV3lMN25xdXpnRkZMcTVYY2JT?=
 =?utf-8?B?S1IrQWNuWnlJbUI5UjNXaWlBZFdRVktCNUxjT2YxQ0hpbC9rakw3bDc1TDF4?=
 =?utf-8?B?RDlIcHFjWDdLcU9QT0I5aW1Jc2c4bWIrK21pdUZwNGIxemV0U2w5VU1JQTNu?=
 =?utf-8?B?SnRGOW1FWWYvckprL0k1VFN6ZlRzOWx3cTZpNHJXUlMySHBHVml1Z251MnJh?=
 =?utf-8?B?ZnpIK0czZFFsWkJxY2EwRHVEL1NWOUR0U3pKSnE1elhBWmN2Y25UbnVlbXht?=
 =?utf-8?B?NHl0YVVjNHkyWWhwMkJrRFpDVGJoVlhFeStsSzdjTXBFY3dJQ0owQUs5eUs0?=
 =?utf-8?B?eUw4eVdZcEovbVVTQmUyTUhkVDR6UWZaT1VNWEY3cWpUOHZuVFBuZjVTNFZE?=
 =?utf-8?B?OEs5N29zcGtiTUlWbTJnbHRhZ3Bwdk5jeGpoTGZqcHRTME9ZcFkxZmxEY1Zn?=
 =?utf-8?B?MGprMmk4Z29GWU1YUW80aW9QZWFrMjJ2N0JNU3h0cTBoVng3ekx1NmVwa1hy?=
 =?utf-8?B?a3ZTZGRvTDdqTXY0VWlCc1NnNW5sY2dlRXlIQU1CSFlZa3J4aS9ZQ1REcERS?=
 =?utf-8?B?MW1nd0xKNTdaQUZVZ0ExdUI3bUZwajJMUVVpTU5BVXArNkFFYnNMbDJWbkoy?=
 =?utf-8?B?MUdIOGkvWW04d1FkcXlZRGY5bk9ZNUxSbHIzenRQb2VyL2psWjlQUU9sWERs?=
 =?utf-8?B?SlkzMVBwSDc5Vm13bGtvUmd3dGlZZlpIdmlEMEg5cXF4dEF5WHhhZC9tY3RX?=
 =?utf-8?B?aHdadjhRTG9XdlArWi8zb29HdHkvMDBJWDZSanYveHE1V0h3ZWlsWGppRTNx?=
 =?utf-8?B?V3Boc0ZIZmhJeEFBUGJHNnNCSlB5U243WUwxdFpMZ1ZVQ2VjcnMyTzBYVXNp?=
 =?utf-8?B?L0hkaGQ0Z0JzVEIwWHZwU0RFaGJYc1lWRW1HQjJxQUh3WlZ4QUUrYm0xbTQ3?=
 =?utf-8?B?a2ZNNlovRUkwMk5iSUw1cWN4dU93MlJVRkRCZkxzZ2lqLzgxVlk4MzEwMGFC?=
 =?utf-8?B?WDRUckJESTkwOEcwNUhJbG0wb0NXSUFYRUVaaldPUHpSR3hwdHZRdmNxS2NF?=
 =?utf-8?B?Y014R1VtWm8rUm1VWG9jaW43NTRpUW9OK0Z2VTVSSlUybGRwWnlLYnpVN3Rx?=
 =?utf-8?B?U21XRDlLSnJpMUE2dGJEaVhFWEF1b0RVeFhLTlg4UFAyb0lRSVNRdVVRN1V5?=
 =?utf-8?B?NW1Pa2xTVCt2elFtNHMwUXEzSUkvNWsvcDNwbzRUMktaUzhQS3VMdDBwNDFu?=
 =?utf-8?B?dm1xalhEZFY0bnFXbjFrYk8wZ3NsR3QrcnR1OXF4Y3cydmFrU1pZRGJDYVlW?=
 =?utf-8?B?Q3BISkkvd1E0QnZjczN5c2taUUlsblNOZVlrekZvNmthZlhPNUYydDk0MkVo?=
 =?utf-8?B?Y05DdWhVR1Y1OUZLREs4Vyt4QUVuZTdoNUdHZW1EQ05wTEo5c1RwejNqSEZH?=
 =?utf-8?B?WUJJS0pFT0lOakNLWkpEakhLQmtpSWp3cDdObThBbDAyNlNtQ2xMbGpwZ1Jt?=
 =?utf-8?B?bWptckMxbUZHck9pZmNTZzI3VVpQNCtrQ09ZQm9qOWdlTUJmVzk4Z2hBUnhX?=
 =?utf-8?B?T2lwMlI5eko5R1ZwTFVUTDN1MHZRTk9aY1VEdm9NcElxK3dVVS8ydmRWZllp?=
 =?utf-8?B?SmxRTitOWW5BQUQxbHpINUo1TDFNU1dyOGg0MXB2UHJ2TVNWSURrSVJqeTRk?=
 =?utf-8?Q?wp1rxfL+xO+nlbao=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44638345-feea-498e-7805-08df244e919e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:39:57.9938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejtOKx8E+b2dxrCu54v2VcTx7o8VgdsDRCWyQArUfdGu4MxBml/yjh4AOvCnNKVv7d1W0bxHuynZMdpbsjCSjc3D68kFCWlz9yMjmqhAiUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
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


