Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37448CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xELhq-0006Fh-NB; Wed, 07 Oct 2026 03:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGND-0002sB-3A
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:23:23 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGN6-0006OP-G3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:23:09 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0yMGuiujlA3Tr5CLfC4kNzZ2y/TeeCph3Atn5qhwLmWZR6daTNsUDWLec+w9Jgzxz3XIAI1r6NeJS09E6d/Yi7YrdTOanEPIqseDo+1c9yfB5vEn9iVAgZPbffRG3AhUymlLOxGbqk3vufYTn4YTAh354Ug6jSENZiIfcaq07aUfQuy1mRZRzQshEafTXuZjH/Ee9xEo56yE0Y8uttw+zbSfLInrHLY30G0Y3+2Jt3mVeTqM41udDJaVtLOmFIVFIGQJFWZ4T3rgb/I/MV49Ek6VtX7Xq3Opxo4T5wRA7hZPpmafPRFudtJPqfTXj+huFi5FRM+/IkqFZe2a9YT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=BjU5NKhhJ4wpYV+8ceMb1vFlAwoyQfe1JD3gsGXb26DzK/Cek+wHcASwfqVzZdE7A3KoypEwcfI+fO3DP0GN2Ypwf9+66ufHvxs6hDqoYmbdFweZpn4GCmY2Ejb0AggWLQevIhzbWnHK9p8HJ19X8YUXcB5+4Oa/nesOeN1p3zB2iudC845XVTqjVPTB1rxyqqDdEEFo/oTaYY2/p7G8qzD7isOKm2J1jjzh/6+sljIADGHCPU+qn13fGYbdSAELkM7U2L2dAA71TEFwbVRo7EeLGAdoHfnMbsZxuiL7xs79OD9ewORcK4tyhxc/r1b5pX5fI/SEdD7LFox/gEqLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=sC4xpx2ipGXETU2HesU1K4wJfJSXrK3oi15PAaYb+yvi2PVRGoTJxZ4xRd1Giebn7zFt8d7qqENKGHtdpIg6006VhdVjW/G7Y8+nWSBwZ13ZbPimdm7zdca3lVZMeLLU3D0pWjT7Xr5t/YGeEwY0mCnLevr/v6vR549LbiBCkc7DkEqAR8a/Y0vVmMcMxUPINwUAEg+q95YadL2uRuXP/0uO/i9Z9y0bI80Ff0QTwd6gCs6GVGszlqpt9I1uR1AYXLimvJ8Mow9KvG13XuYc+qTffn7wY0Sh6Gc2L7+WZM8NgKf7mX4yWQfcZW64/OZmyYR29h11mLnnrBVaobNjIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:55 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:33 +0300
Subject: [PATCH v13 10/22] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-10-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d435a87-150a-4c6d-e594-08df23b1f5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1G5tCHc6waGLi2fd8L3sbUXKHh85oRabhz0QTCI0KtoM/PJ0Ust6zFs8gkBddFVnUt2E1RzsShgh7ehv2HgG4vViSxGB27zjZYf8CHyw55pME2yTPtlNYhph44cYWnNCkM68w0KL8jPOg4icIbptNOaWiaMpAwWKhJ7kHfqPhhtOWENskrMKa8l0SkEAfmuSf7ktwBANsNIuUwhrwqwU1Fx3vCd/sGzYPmytna/QPCBf78i1Mm3kloxKYaMmG5c30VerlRvix4dl4yjCZYHb45ktESQVLEX5TmIooy4GIWnGnWlV8suf0qVkEoKXoFHHvtAoGjo5f5RxeUGae0QGp/aNS5SEbqqB631sh35hIQIWy1WaiG33G03rzWBh2LC9K1wTJ0w4YZuqpurArR4466uUOQ/yE9hTW50dz5wXcZgaUvaIFbQe5T30dxRrCN/26ebqr+J/8aRYY++aoGyV9fWrdl6tYvBO96U5N5SpZqnIuhtTWjctJwVXZvUZTqHtqpRPoTj3BZcbp6+WkSOcFfRP/rVUp7cazk2i4PJhOyPzx1B3zvcsAtDaz6vdOseXRDTPJCwRB6acXTQ3jKHaV5YL7hGzui3Y/eXQnWV7/eWnG2dadLfNgNafpg/uyorXCd4dF+OihZwdMUVh6QFTt1TNN7C7VOvHAVpIh0ca5OpCQlQ+Z9EKR9GKanLiNXjNs3kUA7eqjND0CrVNAIzDVvKlENUjpnu74TkOz6G/vn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZEMWZQeDBYWGVZczhkWnJXOFhsWnN1SUovQzZmZk5vMVIwUEw5SUNwVDNQ?=
 =?utf-8?B?bVgvaklac05ZOFdxekJ4WDRucVpUQmlMYm9qTStGVGJBLzZmZnJ6K2xoSWZr?=
 =?utf-8?B?NVZaUjFLSGZnR3B2WVcxeW1qMExUOUNiY3BsQnlwbXRTcUtwUGd1TzJkNVRL?=
 =?utf-8?B?Rkp2YVk3cVl2cE1KQWVEYjRjUkUrd2hJeW9tVyt2Y3ZFZWQrMnR3WFROT1Fa?=
 =?utf-8?B?ZWsrS1ExK0kvQlhCWks5cGNyQTRFUEtPemNEeHdxSVNodmJhTXc3bnRaeW0r?=
 =?utf-8?B?WUtMQWp2eDJKS0swSktYakdRYTdiQVNObkVNSVk5VnE1djk1TS9pSXJuY2U0?=
 =?utf-8?B?WEFEQTFlTGtlOVVRbGtvR0hESmk1ejMzVmo1Ulh6Y05NOEtiZktWVU5tais2?=
 =?utf-8?B?KzBwS3FESTR1TVZUd29rSHc0bURCaHRMNDZRTG8xakZUNWhJY2FPWTVQTnU2?=
 =?utf-8?B?L2cvb0FnajZwZCszdHk4Q043WThVbDFCOVZMdVZkUFhjTEo0QkVzb3I5dXFY?=
 =?utf-8?B?b2tFLzJVbXJnRVh0Z2lOUTgvRXZ4TGNXV0RvRkNTL1RqOFlkVVhMSSszUWVR?=
 =?utf-8?B?aVJTRXdTS1ZaTEVmMUtYZ3crTnd4ZjRWUnhrOW11bW1xaEdmWXQ0V29oL0JF?=
 =?utf-8?B?bDc2N1lrazRub1hLTkpRekJJeVBScXlNNm56ZDcvWnhiUnVlTitNaHRsZkZO?=
 =?utf-8?B?ZGRyOFVISm5WcnRuTEgySXZBL25TMGIxWmExWGYwTy9VYVB3U0pTOHZzaDc2?=
 =?utf-8?B?eUtYT045Q0xEREFIMnVuUENFcjNST2UrTm1LOTA1ZGNUbWUzL05WL2NMbWNY?=
 =?utf-8?B?UU53ZWdnTG02c1hXK3Q1Q2hoaDBocWVnejdCbHlnaXI0TXRBOVgrdEpIY211?=
 =?utf-8?B?WGY3UzZGSndpanhpQXZlVEtnSU9QUzZOb1cxRHJzWTZmNm5oNGJBOEl2QXFr?=
 =?utf-8?B?blBpcHZlenU1QXZIZExCd2VNYUNURUJ6TVF6am1TZzlwYmFubXBvZkJTOTA2?=
 =?utf-8?B?dG8zdjNYUlVTMlptM0M2NS9scktzUFpjRHc3Vlg2SU1zRU53c0llaC9YV0dw?=
 =?utf-8?B?U2EyMnlYNUVNK2FpbkZ6dzAxVG9yZmpHRkh5Wmt4NDg5bFFPZjhLRTdKZ2lp?=
 =?utf-8?B?VmZuTy83OHFhTzQ5QmdtUTFaV21XWDVVT1BlM0orZ1QxOFNYOTJZWnlQUjl5?=
 =?utf-8?B?Z0dNaUU3SUZhbDhJelRBbnpZcFF0dHhLMDc1YlEzcFZabTRCQkhLNDIyaEdm?=
 =?utf-8?B?bDFBaUFSRS9LY1U2TzRITFppVStCaFRib2FZVlc4a2R4eVA0SksvNklnY1Iy?=
 =?utf-8?B?aGRLSlMwVXpteUJTdG1JRGFCSUc0T1ROSU5lL0s1NHNBbSs3WXRGelZFMWth?=
 =?utf-8?B?emFKNU90VkJYUGFlR2M1dFlzMzZjZlNWREZ0U1gxZXBxVkRHZkRkZFVYc2lO?=
 =?utf-8?B?cjdtNnZzYlJQMUFzSFkzNmw1eG8vNTJqR1EvMjZHWnhzRnZRRTVkWUwxMWFE?=
 =?utf-8?B?S2phRndHMGRMMEtBZjJuVXUvUisxbHZRQm41K0pRS1FsbFgweWdSYmNvNXdj?=
 =?utf-8?B?UUhNaldPN3l0OURObU44c0t4QUZ4SXJEeDJDaU9NL0JjSDI5Z0dwTmFhaDRI?=
 =?utf-8?B?R1M4b0pXWEVPb3JQQm9GODFJcHlHZmxWQVdqOUFuQnpKMGJHQ2lmb0M2bWhU?=
 =?utf-8?B?Vk4ybUhKWklFeDQwSUo3UE91eW9YbktuSWo5S0NiSHNRQWFtalVhMGlEVXNt?=
 =?utf-8?B?cGdNUG14NWNIajlYYlBCU21vMEV0Y21hL0VwS2huMXByNUtwalRVei9CV1Ri?=
 =?utf-8?B?VlkyRW1DTm1HdGRrdHRRNCtranU2QWZiQW5ZQklubXFhck93QWhSbk5Qb0Vy?=
 =?utf-8?B?SG9pRzRTQlRXR214TDB0RWxWL043RWVhYTc3YVJ5ZDdsZVc3VmdzcTdLK1NV?=
 =?utf-8?B?UzJoWEtSMFNlaHhmcTFUMWhpNlhWTjcyMFRGWTZmcFpkT1FtUTEwbitUaGlM?=
 =?utf-8?B?Mkh6V1BUZUNuUGtYS1d0RUNtWFZnRmlJQlBjbGJqWGt6VDJrMzJ0VFJHWDFz?=
 =?utf-8?B?UUZUcHRocmhmOUZWakcrdHBWUWYwU3Z3VmlnZjd1NnFsZWtoT0VNOExMQW1G?=
 =?utf-8?B?bDdDUUlNOUhkQzBFZm5VSnEySVFUcnFvUlptbDU1b2Q1ZnNvbU9JVVFCeWRj?=
 =?utf-8?B?WDRIc2RVcUk1VUV5Z0oxTmxhZVhrYTh1MDViOEpVRjQvVWNCcWNNMXcvK1lT?=
 =?utf-8?B?bDVXMzkvcXBQV2ZaaXM4bFRLRDh1TWR3Y2wvMUlLOWZEMnVDZDB5bzNmWjlP?=
 =?utf-8?B?a2hjQUdETU51aS9iK0ZYMGszUnhwVkJSVkpTWnNxTlgxTUVaTW52V0tMUnls?=
 =?utf-8?Q?w2fQr1feXr3TnEcA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d435a87-150a-4c6d-e594-08df23b1f5e3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:55.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEK0eZUm4fQciMRvC33KXmsxLj5yxhe95/HBZ5xQ6shV4Sds9vB8AQi3jNxriv3jquWlGnWbsJBZsms8lfJdMOYDAp7WsI1RhMcYBdPtGlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


