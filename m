Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73673C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXl8-0008Bb-F0; Fri, 23 Feb 2024 10:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQd-0007Jw-3F
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:35 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQZ-00033B-O7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:34 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41N71Pds007010; Fri, 23 Feb 2024 07:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=wXm7FrxFG/zmt2dEvIAKX5g0Ckp6+sjWsoE5P0mI3
 qI=; b=WCzpMpv+fr66Erssy3Ftbr0IPT1sZARbaYgUH24a7l/CCoTyB/WXdjyXI
 lezNUmAVgSN4QAd+fbRHp8NtWIFrEBVfGhCdkbYmMJsdNNC+DLNv4IzvTdT0JWO/
 vCxyeh9DarbqgKeJYFzcgi58JKUeMr4p8jNhMF8UCUjPC0k2SohPOAErecAQn37R
 d9RCFITfH/vqJRDy4FvmuN/j0y2ThOIiIudVNxT7xBayGfqf6igC6sFuoigK+4UP
 EnHBXTajfwrg+Upek5WrEbUXt4wzBIf3selunkT0VtlHLnPeb0RfOnRpdLINKbAH
 jXjJtqRzszA+IhDztKQ3ts5UXcKsw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd21882g8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 07:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoNlRKJ8Vh9D3vQ55WhLD4bE9MPSZZr6d9i15kFvZIjTGwhiIy0FmfwA5UrO8bwpmuvJNkcDIGs5bzmMdftjzw13ClRWx16aPyP2xJ+6y8LevRaPNpjVsuuoi0rPKzwZdYkyhhnal141+YK6Q4hlhwuW/JM0yeOAdqmPqfCRKgYUB5w9hDP0NwGqfkHjLNgP/pmzKvvQwBBB/wt5Eyn6/m0VD+gwpAyujp299LsNHdu9Zwk3aWBcaVbqZ9YW05/yjWQ1ds3eHqtccZjP8IsBdvizJzVlBflQp3C+bRlPMTxXxCpeIJgANvGek1ssYdBwQW9Mmo9ejF42lyFGZO2KsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXm7FrxFG/zmt2dEvIAKX5g0Ckp6+sjWsoE5P0mI3qI=;
 b=K+6qzhMxhFEfiH9AOAzakhcwgp0u5H4Hkl700k3D0AxyVb1jvlpC+V/KeTOGGX0oylU+crgUpqSi6A4chgKAVMIdpeqj2oXXYAcnQ7JzkCnqayayneFrFCZkq1mLB9s0v1I4t/B5GaGIhAsrhi/IB6YiXfxS43bD4r4xB82my/hlU5kQzFkEJOG56GksdDdu2dB5H5ydOrfVDQsCdXv7MDHhAqNaVnJHdVfC7gYhe1TDuOTfMt0tbVL162xly4kPsCnBkiArV10S/2azmCHEwts8wsAE9iutMR/7KYBZMrsArLkvMFuWB/zm7jQtabWiNGXzA8+c1OmFqgFlg9tYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXm7FrxFG/zmt2dEvIAKX5g0Ckp6+sjWsoE5P0mI3qI=;
 b=yqCCWGnct+Hn0NljEG+04kI9idMha0C80KPm9KualRyAL60FKqIPkPz1M5DmlCfjrziIwEvaWqz5KQ4T1fNQz6NXaCVIRFcS3171aUnGJ/98nIOqc3mNnHQHJ9D/FueA2VImzuLyO+NkXNVGq2zB8jp/W/xNt2HRk7HOYlrGI77ofQr0zOOobJn4TCRjW+fjhpXWfPFX9APS7o5RY/V+3jv3iWbov7YFskOGB3OL0v5TV/MRrh4gQ/5C87a2PpB85wpwt7amzosopj+N2q1lECbpacVYAxl9rKGo9m9tVkhlTEh3uPYEed6YglU6lNsS7fr5TjwzF0bE+x+gqX+NeA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 15:25:24 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:25:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 1/3] qtest: migration: Enhance qtest migration functions to
 support 'channels' argument
Date: Fri, 23 Feb 2024 15:25:15 +0000
Message-Id: <20240223152517.7834-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240223152517.7834-1-het.gala@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c916545-8275-4870-54c2-08dc3483a7d1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XUIkdeNNkveEgYsnCLDPtcCfPo6qGOCXK+LYoGuq4i2Fqd8ZqVJQj/9l3c4eXcRnI/Sb/aLNwxar73UvHIYczxNtgfYmVko0yRpaUWreCPPDkWuH/Q9jtdnNpRpx8q8mF6pATnYclF+QNTZ+CqZPUmuzQFDy7MAJFjs1fyy1ujQpR7pZkq4Ucc/o6uW59JGs7RNgwQ8+qh3ikm3GlfTTyy2eD/VFvF8mtcnXwpPV+cXhLWF5A624nqmSI0fT1MbIPntUQVeLDvnbYNGLSaFAXcU3xoejkLiiXLw/CjpwC3w4yiGmLGGNfFriHyLvo0Zi9zXJL878haRy8lDG1OwnN2/RYUuKuLo6/RiPaVI4r2owC1RvOfD/7XNFxK5V7/tyJ8LMy5xVDj5tyxfT4Gdrp7DZy/vSuvqs5w+iAj6OMOy4JFRZ+SogYgwiNvrtXYSlcI4FWafxI+MaBJWLlRq2aKekVFzVOiTxtSi8UbQ0uIe/HJ7woKM1O6JxKIls2IxTHnV8IOpiwxV6zhfCR+jdyQIj04ntF31hCC/QjkRvLtAOdGqQ9duisSRH5IQJLI1UBNJ6uu4fJahfM6XUx7n6UzVg2CfGb9q+UEkbJYV1cV445z5FkCCEn6fs1H6CTEq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DD8LGwUXlFeDqyilN8OXwADJ6fHFK5XOHvSIZfqZXy7lZttRvxv1vqskf+mn?=
 =?us-ascii?Q?1fTIXzKzAHnUJXMiD5n0pjFp61Dvv2/GMuAdkxa1+3IIbFIfjERfEe+sYhw9?=
 =?us-ascii?Q?BihudmXNywE7zr3sDk2BD3bikwmdRb6VM8En1um7hVAI7hlkK/dulkT0HKnn?=
 =?us-ascii?Q?sIIXXoJ7RLCoG2W0W9sMgnkIiIbdKlgc+2kBYBpl3ICZWKBylZAWc3MMQjyy?=
 =?us-ascii?Q?GB0TC5a/wyI9UGAwSVP62dmr56L+D3/6t36hcE8iaBMnv7RnE1yVbRg2MqPI?=
 =?us-ascii?Q?FqhpwtWONrvsQ7TmIPpRqO1LnettATtWmM9zBYPxTAO080YeVuNspTp5HJJz?=
 =?us-ascii?Q?n4bIfdfwkKI6dGy0viW7s3xy2tIeQEuSVkO5z4feLwJLOwaQxzyc7nf/l8CR?=
 =?us-ascii?Q?sLMQTXrS3h1nCpVXobuCU+9Ue9qEE94u3GbMBTSzxQnR3FX5gSZXEFXL07qa?=
 =?us-ascii?Q?qiMHoNMX9VtV5usQImR5W/6Oqx2pU3T/zMIMH74WWBanYnZ7VyNd8/idTUmR?=
 =?us-ascii?Q?MJcsQG3BdOhbtyLl/KCbomz0HWQvb8M3h/JlNfNAUE4giE0u+VnD3r/Lz+2w?=
 =?us-ascii?Q?AP6WyLSjzllwc5VPC2Rm7u1Jz12VWv8DM0+I0KsA/XJTlxkT8FGpkGm1m57F?=
 =?us-ascii?Q?4eRHIxpP6xRjoGGa1np4jjOwx68Z4zHeowe03ejIvcZbxsYKpl2YFFeGc0KY?=
 =?us-ascii?Q?k2zmesIM0pgY1o7vA6HxH6HAGx2UnhDbobcfUVVH/BoRVC5BfeTCSVX1JMWU?=
 =?us-ascii?Q?WYMH58VxmHvzJ3jXKuy2RlFFEpd1ZdmR4+WLgbnhEMu0CaQCDCTZHawBSeUW?=
 =?us-ascii?Q?WnK3olEYIxq6HnBQXiHOyL01EzifPUqFJXBlUYDRiRdb9cJrRztQ3d464TQy?=
 =?us-ascii?Q?89VTVB6oBZSJ2fjFGRjLcg0w5Y82l9IHXEo2T1SHFWkFiTaoN8FLDX3evseV?=
 =?us-ascii?Q?PBMOGOF0HL9x2VHOo58rCWzqceYAJRK3BUWHWLeQtsxS12SJBPrjB9D40f0o?=
 =?us-ascii?Q?kxMorL37hbJk2/nnljb+7ys+obwFAHLgd7VUIyTg6CLOcWI3cTzYbQ73WOv2?=
 =?us-ascii?Q?SQuHgA75uO6XpjsTH40syTRsuM3oIajI34ati79crrbXZJyQVwcsLxu83W38?=
 =?us-ascii?Q?vwcQfrngxi0GFvGOXULr5IPeMMZp9oOs7r4moo3bE8SVTECFTy6MlSfHAoje?=
 =?us-ascii?Q?Qfu3OX3xdii4cDEbLnZw9pIhDisTTawEKDzF1WHRW9K00mCPfTvK/4PlNDln?=
 =?us-ascii?Q?c3us2i/jeRYIQueoXDHpDP/XRTetpcprZLPQ3/tU7NsDlG61jSn8Tsn3BOes?=
 =?us-ascii?Q?huVx2TwMSIRsIhooH60NkMs0wLEtuoDi+r26rFdu+yoLfKwP9M5Cm1z6Oyme?=
 =?us-ascii?Q?Vviv8Eej1wX4CVSm/jONAoO93QFyIWaIIgSVWo3/PqWuCQ51ClpD1bi/IMMK?=
 =?us-ascii?Q?3Vfli5yJm16ltQnOiOjlkpQTG+51y8HCtffXHUkDvIsteOwWlcik6USkDj0h?=
 =?us-ascii?Q?X9K194SmQlRyc3ipx/a4Yb4fZLC6tS/M0KAiuNZ2LKtTZXbT+IXWWIQ+VWtm?=
 =?us-ascii?Q?9PsArTVi7iM1xS/clde6IPwI3byrQrfZXa5IUFVq2M2cYTx0O3EycLIBnjUI?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c916545-8275-4870-54c2-08dc3483a7d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:25:24.1739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgSp7lCH1sG/RFqaCCZtcmXf9m58q6BzHCYqTvjzrE/MfSyGLja2dAKmtC3cvlauzu1iPgCdzi5EzsfBcOzW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Proofpoint-ORIG-GUID: 8aMY65Q-X3GKW3KxsvTk1j1H3PM8AUBa
X-Proofpoint-GUID: 8aMY65Q-X3GKW3KxsvTk1j1H3PM8AUBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce support for adding a 'channels' argument to migrate_qmp_fail,
migrate_incoming_qmp and migrate_qmp functions within the migration qtest
framework, enabling enhanced control over migration scenarios.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/dbus-vmstate-test.c   |  2 +-
 tests/qtest/migration-helpers.c   | 78 +++++++++++++++++++++++++++----
 tests/qtest/migration-helpers.h   | 15 +++---
 tests/qtest/migration-test.c      | 43 ++++++++---------
 tests/qtest/virtio-net-failover.c |  8 ++--
 5 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 6c990864e3..0ca572e29b 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
 
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
-    migrate_qmp(src_qemu, uri, "{}");
+    migrate_qmp(src_qemu, uri, NULL, "{}");
     test->src_qemu = src_qemu;
     if (test->migrate_fail) {
         wait_for_migration_fail(src_qemu, true);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..15c3650b55 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #include "migration-helpers.h"
 
@@ -43,7 +44,67 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
+{
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
+    SocketAddress *saddr = NULL;
+    QList *channelList = qlist_new();
+    QDict *channelDict = qdict_new();
+    QDict *addrDict = qdict_new();
+
+    channel = channels->value;
+    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
+        fprintf(stderr, "%s: Channel or its type is NULL\n",
+                __func__);
+    }
+    g_assert(channel);
+    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
+        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
+    }
+
+    addr = channel->addr;
+    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
+        fprintf(stderr, "%s: addr or its transport is NULL\n",
+                __func__);
+    }
+    g_assert(addr);
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        qdict_put_str(addrDict, "transport", g_strdup("socket"));
+    }
+
+    saddr = &addr->u.socket;
+    if (!saddr) {
+        fprintf(stderr, "%s: saddr is NULL\n", __func__);
+    }
+    g_assert(saddr);
+    qdict_put_str(addrDict, "type", SocketAddressType_str(saddr->type));
+    qdict_put_str(addrDict, "port", saddr->u.inet.port);
+    qdict_put_str(addrDict, "host", saddr->u.inet.host);
+
+    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
+    qlist_append_obj(channelList, QOBJECT(channelDict));
+
+    return channelList;
+}
+
+static void migrate_qmp_attach_ports(QDict *args, const char *uri,
+                         MigrationChannelList *channels)
+{
+    if (uri) {
+        g_assert(!qdict_haskey(args, "uri"));
+        qdict_put_str(args, "uri", uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, "channels"));
+        QList *channelList = MigrationChannelList_to_QList(channels);
+        qdict_put_obj(args, "channels", QOBJECT(channelList));
+    }
+}
+
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -52,8 +113,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    migrate_qmp_attach_ports(args, uri, channels);
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
@@ -68,7 +128,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -77,8 +138,7 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    migrate_qmp_attach_ports(args, uri, channels);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
@@ -95,7 +155,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+void migrate_incoming_qmp(QTestState *to, const char *uri,
+                          MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp, *data;
@@ -104,8 +165,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    migrate_qmp_attach_ports(args, uri, channels);
 
     migrate_set_capability(to, "events", true);
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..390e386274 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -14,6 +14,7 @@
 #define MIGRATION_HELPERS_H
 
 #include "libqtest.h"
+#include "migration/migration.h"
 
 typedef struct QTestMigrationState {
     bool stop_seen;
@@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
+G_GNUC_PRINTF(4, 5)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          const char *fmt, ...);
+                        MigrationChannelList *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      MigrationChannelList *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..e5547b8746 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
+#include "migration/migration.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "qapi/qapi-visit-sockets.h"
@@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1669,7 +1670,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1708,7 +1709,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1869,18 +1870,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, connect_uri, "{}");
+    migrate_incoming_qmp(to, connect_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2387,7 +2388,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
+    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2609,7 +2610,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     return NULL;
 }
@@ -2862,14 +2863,14 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2892,7 +2893,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
     g_free(uri);
     uri = migrate_get_socket_address(to2, "socket-address");
@@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc272..e263ecd80e 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
2.22.3


