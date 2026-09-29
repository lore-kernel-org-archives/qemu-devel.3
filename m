Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CADCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYh-000677-FW; Tue, 29 Sep 2026 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYf-00066N-Sw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:01 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYe-0002l3-29
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgFtmqDjt9Nf83D/hpeek70hIvGK/8cljwbsiV0mKfH2prWISXKkYXKvD6zeal2KpsV3FzxEyydVOORkocipFELIg/C73OkK2u/Rcu5zxGLrF+pOSGA7UolxkJQlJyZ3CcE8lnpQryS+M3Sw6iqdvBmkpWYG8p/0fPuq+jPv2am6SL4/AZNMH0qVXjLK1owJPN7B+ifYZA60mnqQ0dchXAYZB8gpZxML/m9UGPDD77NPmvDCxC0hI69G+mw8c1NS3dcRgQ3A767XjqcE+miLkU6AdCK9DztzwGHcNzXE4Xv3KVgONl70aHKCxhz5H18CHUtC2X3Ww56lrW/HJqRIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=JIZTSBROgXRNsVvvixBF3CaGdlKXm4qqDAHlD6ZEGd0tacdTJDONrCDfy/JZuncIjEySc+HBqgF/RIS2ZetTih9frdAZFIwTgBDKGsXaMChQFrpKMAvnNOMPBjfTA5g4aLNvblF2mW2N6aQ3IUpruF6JBxhDnc2aup0tNr6gJqOoRbwTuggZZpxllZKPuAPsFNa0GAwxmp5gbcnWP7injSnyJReVLuFP+KsC+3Q9W7dab3mDAJFrt7fB4iZvHHbmbh8MKohrmVUh4F2U56RsuQ2DSA9ZNBUNY2J+0wRDVW47NldDpAxlok+/vbfejiAsajl/tV6IsPDqG35j6ygcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=uxIs578pHbEZsAFQgY8thWD1DWvrPtWoMZHIFwIEMrZZ+c5i7D66xjk+x1Z9JS/e8XgxvQ7sW1gKlhCluaKdQyjHRUoeZkCWJ6JRem0xXMJPe2EtlUEBEiM5p06rnf1pVB+82W5+/P1kswKrjIoDcOZrq260iffaoJJp+SVEXECK1ovd5HcfSkmPlEM0FJbtm4KwBqUtyC0RLfR9Y8wuGWrZhe/eEPddxCDq4bw8hDXhyf3wfDeimM59fXCUO705hJdniOVeSPi/NqK6xyJf8td9IOcOjMcSgX9BtaTdGZftFSxT5gMFnrGX/uloFm+fyQsgHPVN9M76/gXphvSIhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8801.eurprd08.prod.outlook.com
 (2603:10a6:20b:5bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:23:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:25 +0300
Subject: [PATCH v8 06/17] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-6-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 16feef21-6c4f-4c23-432b-08df1e4e6cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|52116014|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: hvsk/Uz8HRjX4MWNQM7d/oxD70LFAVo3vDYPLiBX+6ejVIVJ6NAruHAIlBTONgSvCJiTCD+gumo4LKGwAL6hVqTkCATVAXVoSb6g3whmDcDHkfX2B8qKF1ljpkO3zPApoEcRWApfCcQezd+O9mF45moIgAxmBZgHu2+M+yhrimISrc+1Cl9qDppW8tKiM7ofIsiflvaFQt4UUvaqOY9bFzdPX3rudubqJhaJYvnVDcTuCdfcm1K05xMAJve3V0/r9Fx60M0WNrmWRPNYnyNRPUJfcfK1sErYPbhzIoszqiFnsWgFuOYcvlEZHB0AhQeuMqFn4V8dK/EfYCEflT3B+2BcjRce5Mx7P81QZA7/csCGe0qzlaf03dJOQG/qVdoMzlF6ftgMsDTDsKFK/ZLjHsb+undtgGdeVmkJV+Q/HxznWO0LStTPbTEpJRw3CBeSqaUD5Os3WuBSbCOpJQQBAn2Es63+GGj+QfCo7ODjx9rWUa97IhUzsmIEqk9x3ImwjbWkv4FFUsp+OPNWPAhHfnbV7J2fCcOm3fv/DYuRzzl8zAzJ+FkB26hqsJ5l0AgdLYkmD/JlfShU6CcZVwoxeHZ2dUqDCsSvhGbYiHSeJ7eQ/+Yvo0XcMbDAWZ7mpDfOB0rhk9SS0wbcC8z2OaddOAv9OOYHxtqEXBYnql4uilxMQ5J5EHOPuSI/VIpuKPQPHNDwyA/+hrEV/Db2Wn6Y0uW5tNpoyH++pBFWEnZ4Vdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(52116014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRvL3Yza3VYQVR1SHYxMzFVLy9JajBucFRxYytaMjVtb0pRWG5QblBEVk9w?=
 =?utf-8?B?ZldCM1ExNmt5TklKcEVnbEttb1UxbDduVERLNUllL0Vhb1BtUE81Q2Mzckh0?=
 =?utf-8?B?eWtNUENYOUZuQ3VPSmJIa0xISnNsZUg4UFNjWWQ1TWJGRnRUSDFGWmJsZUJu?=
 =?utf-8?B?d20zekNnU0tKdnhrRDlDdElENXBEckxXRUtnMnVxcTYwYlZnR202TGRUZGxQ?=
 =?utf-8?B?bDh5S21MM3VRc1F6bnQ3K1NOYVpMMEdkSmMycS9NYW42Y1d1RVJGMUZZSWp5?=
 =?utf-8?B?MXZIdVl1ZU1nNmtHdmpUMjAwQVhkdGkxWkhQaDluWkJmeVJvSVp2M1V0S3ZW?=
 =?utf-8?B?ejliZmNmdlRnc3BBMEVxL0pHUXhwUmtjS1lqeFRWenBqWnkzWTNHN2hhblZL?=
 =?utf-8?B?WXpWNGxBVEVHTlJBZUNKcXBEUWp5OVhDMW1DdFpZb1Q1bUhranFQUkpsMnhV?=
 =?utf-8?B?b25TMmRBd0pjcXFKTU9LeTVobkpLNFhxeXlvVDFIRFI3My9YTk52T3BIdUk4?=
 =?utf-8?B?TkpONVNlaUJKWnZJZVNsTHNEOGZuYThpUnZQSEkrZ0xQSm1kWkRjSHI4YVJM?=
 =?utf-8?B?bFM2Zmc5bVhKTWpsV1hQS1V4THRQRjFOU0JTbldTT0xvcDJDU016YTVGTnFl?=
 =?utf-8?B?N3JkL2RaL2ZXVHBtcnpqb0loSXV6bHZIVkxiNnk5SjZkRGcrUWRiTHdZMHlj?=
 =?utf-8?B?YzloRm9HUEd2dGgrUXZGdEVxYW0vSnZpZjkwV29yQlV3ZEFhQkJNaVlGS2g1?=
 =?utf-8?B?QTc2V1ZoanZjWEJ4dW5YTnlySU1ETXNDY1ZGeldFSGhUaDdkdnh0NWlDWEtq?=
 =?utf-8?B?MGgyek8vT3FFeEhIeUwxNkNlZjZNOVVoVHByWWp3NGdQYjUrMnB4WlZLa2pD?=
 =?utf-8?B?WGRHcWJTQm1BMUlYTGdUOHJkcDZpL3lwaHM0UmNSZW5DTEZHbXBVdW1XZmdX?=
 =?utf-8?B?K0NmVHZJeWxvUWlkaUFxSTljaFQ4REMzYVIzMk1LV3VPQjFkdDRqNmN2Ymcy?=
 =?utf-8?B?NTVTTVZBMDM3dEtadSt1Y29XUDhzcGVmZmloT1I0TC9jdGxXM21sM29wdHJR?=
 =?utf-8?B?TmhmelRoczcvWXc0TEtibEpMZzF5TStjaXpwWDUwd2FQRll4Rnc5eVQ2K1NQ?=
 =?utf-8?B?QU5FdWJNRytyektHTWEvakpCY1l4bm0ySlM4aExJeTZlOFRoellVMFJUenJT?=
 =?utf-8?B?RVAxSXQrT295YkFMemZXUVQ0dG9rRm0xZ1FKUGxEZCtMNjdKTFVWWGtaeUR3?=
 =?utf-8?B?MlF4dDMrSTR1T20vYTkwVy85WTAzY2cvRXBNdkZ4OVlLOU1vUGxrelhrZWdE?=
 =?utf-8?B?aFFELy9DWDcrWjB1aGxubVppTndZbmsrbytOWlhZRktlZ2daWjQrUGxBSGRF?=
 =?utf-8?B?UWJMbkRwRGZ1c3ozSXZYZUF4ZThHcGY5bnd4L2MvRDRlOGtDM1JlL21aVDFy?=
 =?utf-8?B?cCswWHhxcWJnT09jeVRsN3ptbklEV1h1MFQyVWc0V0xScHZ6YkJnUzJ0bzBt?=
 =?utf-8?B?SHdqUnlFb3h2ZTcwZlkwVjNPeDQxclk0end4RTd6SlJMZjZKQU1yS0dYaGpI?=
 =?utf-8?B?UDV6SW9XSDgyY292OGtmK1MxOGh2dmEyS1NqUDBPQ1hZRmdzblYwNjBnRlpq?=
 =?utf-8?B?OVZCTDNBYjNNSGMyRW94dkErSFBwbU9YL1ZOSUw1b2htZDYvZkkwa1BMd1F0?=
 =?utf-8?B?NVNFaDlHS0JybUJ5S3VaS2s4YVJZTVU5S2twL042RGhKZTZ3d0MrT2tlakx2?=
 =?utf-8?B?SjFMNkxJYXhENHNSRGdFMEd3UGRtOFBzNXhDd3R1aUxkTUxxM1dEVEpxSUx0?=
 =?utf-8?B?QzlZR2taaTM4em1nYkZMM25OWEFSbE5hNGVDUHJPU1Z1Uk15b3F5SzQ5VGVS?=
 =?utf-8?B?QUJ6WU9CVXpuSVdUZEMyVkNXWEJ0eS9xUEVLaXVnK0E4SlNuQkRoZzE1Zys0?=
 =?utf-8?B?eWYzekwrYU1yK3Bxb09wd1h2T3YvOTFISHg3V1dKZFZzdVRUeWdpTUVFZEho?=
 =?utf-8?B?ODRaeGNUbm9VWXR2cHhVNzdnekJFaGJzZ1pteHJhdlNKbkNaYjlSTmVRbWhO?=
 =?utf-8?B?WHFwNGZKZjB2Q1lSVUZXclNoVFdTUkQyQU1SRS9kUys4dW5nU2RvSTNrbTBs?=
 =?utf-8?B?YzBIRFZES2VpcDR0NjdhazBqdUFUSGMrUUhpTTlSRksvRE5BZjZ1eWtLc3lL?=
 =?utf-8?B?aWFUWmdvQUtwWHB0WmwyL2FsQ0d4dnQrdlZGTnBUcTBOUStaN0ZtcVI5enNk?=
 =?utf-8?B?ZElsWnVFMnplQTNxZzJhcmFndGI4S1pPNmxjeVk5YmZ0am51TGpOTlpNeDRL?=
 =?utf-8?B?YnIzZDZ2S3hJSXRNV3hVcElRVEdOZU5CM0VZdHltWkpQSlFaRFExNm1hYWhW?=
 =?utf-8?Q?qV9O/abd3FBSeqyY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16feef21-6c4f-4c23-432b-08df1e4e6cef
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:49.4668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyUeUW6jTkewY270C0AfCi/xAXGR6ykJdKG7OeoqKArDnSgxjEULN9NrNwFUrN+kIa2iMb2l/sQycE9CjYUJVZIHn8+qidHyANadQZT0+FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8801
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


