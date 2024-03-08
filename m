Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71ADC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKM-00041v-Dp; Fri, 08 Mar 2024 16:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKH-00040k-9e
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKE-0001OA-Mc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:20 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42879VxH027209; Fri, 8 Mar 2024 13:00:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=oxXS7ilsFL7Qmb9HQn0iaf0NcFrcYOnRNDxX/B/1O
 G4=; b=vGjhYnZZUiboUkfUC3E12jCJ12cKNb+n4B7Rdrhqnbdb0S3+S+pUlAMpg
 qoeWToSSS57+JX6g2JD2mKSUfpB9+S82sGBetuG2bmwuDViSroOeCyH0CPjD+lm9
 3wGLhBBVNUUUGqOu0Eeqfo8h0UWONfZJNrUuHSlv+L+IEe3bBz+YIUt6Fwy+wiN8
 cAxPe0xMfqXxC42SGTvNQbjNqi+yFfxX7h/eIZGpREwQGvBHcPF2KKip6n9Ef2LY
 +MzKhEy47OhYIf7XV2jpPN+2P/CPc3loWQIWQyA91q6uqt1quVdP1+GkjVLV8wEQ
 7X4h9xBHw4AvTKelm/exz8qqedY7g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hp1m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMHv4wey0svVCZXPxIeZ+E+mHomTCAhmesgJEjz7JgSj2D+bzzWf7BUUk4mAoDvLN46mr8ZSN+TjE3naKcj68FdednY6zI5uITxcNbjcq29RS328NzRhntxyxUdMf78J+1EyDUO+WgOfM66EwcqKJ+GQ76/HXZZGUYoL1iY2nSuWdAK9ImKoOCryoHmgRbR2ltTOqls1CvwJ5k7Y2143CJN5verU26ZcDet8PCg3sNpjLP6oVv5Mo44d+zMnt2v7A6Lhyzb9Of95Ax4EYwTmTzVNF4Ksheq7THr/kNrkq0CQLTdOVl4Rg55/fK3NVEO2v0MwiiXZkgC4gPPlkNBPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxXS7ilsFL7Qmb9HQn0iaf0NcFrcYOnRNDxX/B/1OG4=;
 b=D+bLnq7w5SyH5bJPGuMPrKgNd1AlCfXr/OC7fcal2LWhch763+PwhEELYuQp48LkNpnlPvJBgoqr5Ip05sEE1qFBZT/pK8H0raeoHFxmLPdQVdK0VVc9pgr2j5eeDSDkvJ0quIHVvp8yfHEwgP4zs3jNqYX7BS3xgSit1uIBLRRgCtTNeU+hqNPZoGQNivYdKGUN16y0mZ+xSsZI7/rdgGNAXAX20nZxU40ajaa+w3GIuwy9FP4j0wlWkbF7xmgzIu4/eeIUCq405/JYvbZe9H2m5SwemBZwS7SkGY3yDnqd//qZCcJgCt6G3Tnx6vamZc2ST/vdCFmdRTkX/ppQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxXS7ilsFL7Qmb9HQn0iaf0NcFrcYOnRNDxX/B/1OG4=;
 b=HtURYn6ogF7ECmye3APtK3TKePTugisUfc2g+hqbShcuiMrCrZ7DPVzD0cVFsJglp5NsMufq+epdHqTiGEAzFPsSntBax+Qu+A54i/G1B0LH7dl4C/UAGYybI5/cqLGuFqd7mgtl/wXrSrLZuAe3l1+NNSiCKSQEEj4WlsuSgRZV6jov0CsqBrfKQ1IoDCSaM/jugMWMUCw/ZoGgtDYCMwcgMgKDt5BrpA24AVVLBrn3DUHIqxkWVwAHAn5ki2mPEld685x01w8Na6b7J0jEfR8dG0IGhIcROjlc2aCn0UsaiCAzLwcdaHA0bWMP/agtzdpXwS+uBDmy6IfNmGCF4A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:14 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:14 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 5/8] Add migrate_set_ports into migrate_qmp to update
 migration port value
Date: Fri,  8 Mar 2024 20:59:48 +0000
Message-Id: <20240308205951.111747-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9b7d8a-8029-43d0-46ad-08dc3fb2c02c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfqe8zS5e/QAB9o9MBKU7OQ89e0abfQiP5xrEn63uQw7T6N9vxAGgZ5mTMXOB/fRHQ4Xl5vbJc7gDMLu1/J8Vk5Zvhe9vwkmMX38Lji4+ZroPTwLMm7/qiU5oAdMeZSlvGlFGF0eIGi/t/Tk2UYvnV5gRZfZN3JgoAU26LuhiGI688QeCIgS3nEowIwC/7RZvHDnEe7eOp7rD9QkrnHCQC2PSkvqnFgjdzNIWZuXOah1q35fK8O/Ka+naqXc6wo/35uClnX/C3dJpf6bzgAUlEICDSd4/qVoW5vAnvgdM7udFWHrwdOJd/8KhZw/Rek/W2bzie4nsq32DZJgtVxkleUVdk9QL9ArPICCnlwL53AcivtYAj4btGXWJjzBSprTXidM3ISnFg13Q7LUjCGzCvBo7tbnHGd6TGSvOFfhAbzbiSvBebVQbxHpLICPVjGKXrzBX0BjJ3a9XB8KTBej813T1QRFt1dHumATyd79BzMx5dVLwXskAMg4iX9YaoJVxUqUs9eZQBwCyMh96S1JFMnjfa+swuuM6UdWpa8Kg5+FnjmfH/ngQd3DhR1B7a7z2Tzxi/kiWfR5hwRE49J+ZZrmLXXbtsrTkksHkIzuAJ58KjdZ7FcQGR41hkKUYzYnOVFqY1cPIcWWNQ6s6Re8JwKWTmlE5/wPDQhal3LIRH51cuNc2p1k3Jpjwkgw7TvOwso7g7wm+nui9/Ieh9hFo4/1K+YMub5Ln5pq56ezklg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrDJcGd/LU0nKnu+Dhb20BjF6FwnAHryPDPH79ig7sWfVRbTkjN+5LJU/K5H?=
 =?us-ascii?Q?Yo4/c0l9NqDx1ycTsl7rIAq5EPD4KQAeWadVAvpde0kJx8Y6uTxUwqsxUasq?=
 =?us-ascii?Q?aWtpic4kjtkjDi0YGjMBKYRpQEoOp4LD1GDyZ5vO/Ffs8IxdWBqHlTlmATn5?=
 =?us-ascii?Q?eYbnJgXa0QhPxXW20ypPZzlF5pUQe7RY7e8I5sLar7iOH/2XY4vDqO1+ertz?=
 =?us-ascii?Q?WbOiY7LFe69+vUiVhaeHPNxXhTKslu1nyhO9qTWMvLkOtE8OqMTJPXU5h3e6?=
 =?us-ascii?Q?/YBcNjH7Lxr9qnI9k5xetiz3fBlCcT5syu36RRD8j2X1sg6qC1bRPDKDVy3U?=
 =?us-ascii?Q?W1kr8BLFPAt7DWgaCmzkimbKzCCvB+qhK1dOgRBWJBDz9CGPHQ0vExsD1b25?=
 =?us-ascii?Q?Yla228X/aK5j38WNxcE+bWHSYJWdi8xMT3uNYsaDgCJqHjySvrbxOgzoFha4?=
 =?us-ascii?Q?eToaHrnsDV3nUnZ1x6/Mrp6jS0u4fgbowwgae6xe0e/8g0UZkH5Uti+Ts7hH?=
 =?us-ascii?Q?HP3VaADVsF2IYDt9WLqsSI+rCgkaPnJ95w4dm57F1V+0mdurg7LjlWm4wDbx?=
 =?us-ascii?Q?UovTTbte1toqSl5TOcV9Xp8gbQ87jr82HTZ5omJQBZtPF57D4p158j6kwtsL?=
 =?us-ascii?Q?SSP5T2y7OAM2PcRgF94XsWj5eD3Pav0bFjve3LgPZ0kRzLAcDMJywUcvDFAW?=
 =?us-ascii?Q?/UGK3xxu2QLDN9EecAvSFluDCcFZDN/cC8TrP93DPc6Y37flE2+nf0PHz0dv?=
 =?us-ascii?Q?xIZ2aQAdjdkouYy3jMRqNutrMEfm2vfTtp7gncVFfHDhKeDPLqhmZtIPnfqF?=
 =?us-ascii?Q?fqSYfqlWvoTIHdcEoVkZR18vk/4j+vWkZ4/a1ye7QklSUYax2oFQCS6tRSVo?=
 =?us-ascii?Q?E98l9Qkw4/qVh0CmGgOw/1HfRxD3Cb8qLzeu30PBzRE4NPncE4pykMtLwWhO?=
 =?us-ascii?Q?9+Sna3kjEyh5g808eL1F35ne/TcsZ8WwMxskIPiVF+RfDLGK7OgFZUyIoEwd?=
 =?us-ascii?Q?+fmpaN973XOo2EprfiIzSiS1Lmrh/aOD5zpl61gLJAmOQTSz+N5jtZJsiPFM?=
 =?us-ascii?Q?zxG8/JNFLhY84oXh0Iy3NrHzWcP0FtEsstLZjeXK2AFdUILDTadnO75BJxRm?=
 =?us-ascii?Q?eZ0LYpZVQCCFNMUumfnSoOe+dZhssXqHEmZsyodIaGu/3P1g7VnMSdG9DIj6?=
 =?us-ascii?Q?21+ljjs+gRYWog4ILIzLnW1xLvmlq/UF0fSzsOd4QrRUt2vUkkTcbFP/6NbW?=
 =?us-ascii?Q?24sRQICJnJYSOC2MsxbUrDXMt+NuL0wsba7rf2BPY/Dj3QsbSwcM3qs3zKaA?=
 =?us-ascii?Q?A0t4rnP4wAs4pwDjfctECHeMDVbwPCj+kHpleo7oD6DuSnXs/ssaHivoNYiV?=
 =?us-ascii?Q?znk6hQI4wvU4WCWWlVrfqLiTVgTpCkWCebMPx26xl37gjnzh1swsiIaQlq4X?=
 =?us-ascii?Q?XLX1PCZQvwkrp9Ro3xZu4m/5HDFYvN+qs2zO3h6vHXV8e8Srp/fQfsVSWFFF?=
 =?us-ascii?Q?CH2eCrOS9VYE5gsjCYd4y9f6EQfSKdYJa/nrDoT2eW+1w55z1CdVETG8YI0b?=
 =?us-ascii?Q?GHuiCi9R9n19TNzzhLcLHl6BpKZWk0inF62Dcqo5c3XzPntN6KFyLjmjsV1c?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9b7d8a-8029-43d0-46ad-08dc3fb2c02c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:14.1981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLulECEwtKynMOtUgzz1TSFIwPaMWPKomrYpDDyL8bmhzzhb6CWzHTqalAT/GLVJJt/MbYPbkrzA56DYTuS5Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-ORIG-GUID: Oz1YqmSKND1zKSpgW7G1zeI0m-OKua3b
X-Proofpoint-GUID: Oz1YqmSKND1zKSpgW7G1zeI0m-OKua3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

migrate_set_get_qdict gets qdict with the dst QEMU parameters
migrate_set_ports() from list of channels reads each QDict for port,
and fills the port with correct value in case it was 0 in the test.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 91c8a817d2..7c17d78d6b 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,6 +17,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+#include "include/qemu/cutils.h"
 
 #include "migration-helpers.h"
 
@@ -49,6 +51,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
+static QDict *SocketAddress_to_qdict(SocketAddress *addr)
+{
+    QDict *dict = qdict_new();
+
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        qdict_put_str(dict, "type", "inet");
+        qdict_put_str(dict, "host", addr->u.inet.host);
+        qdict_put_str(dict, "port", addr->u.inet.port);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        qdict_put_str(dict, "type", "unix");
+        qdict_put_str(dict, "path", addr->u.q_unix.path);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        qdict_put_str(dict, "type", "fd");
+        qdict_put_str(dict, "str", addr->u.fd.str);
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        qdict_put_str(dict, "type", "vsock");
+        qdict_put_str(dict, "cid", addr->u.vsock.cid);
+        qdict_put_str(dict, "port", addr->u.vsock.port);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return dict;
+}
+
 static SocketAddress *
 migrate_get_socket_address(QTestState *who, const char *parameter)
 {
@@ -83,6 +116,44 @@ migrate_get_connect_uri(QTestState *who, const char *parameter)
     return connect_uri;
 }
 
+static QDict *
+migrate_get_connect_qdict(QTestState *who, const char *parameter)
+{
+    SocketAddress *addrs;
+    QDict *connect_qdict;
+
+    addrs = migrate_get_socket_address(who, parameter);
+    connect_qdict = SocketAddress_to_qdict(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_qdict;
+}
+
+static void migrate_set_ports(QTestState *to, QList *channel_list)
+{
+    QDict *addr;
+    QListEntry *entry;
+    g_autofree const char *addr_port = NULL;
+
+    if (channel_list == NULL) {
+        return;
+    }
+
+    addr = migrate_get_connect_qdict(to, "socket-address");
+
+    QLIST_FOREACH_ENTRY(channel_list, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QDict *addrdict = qdict_get_qdict(channel, "addr");
+
+        if (qdict_haskey(addrdict, "port") &&
+            qdict_haskey(addr, "port") &&
+            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+                addr_port = qdict_get_str(addr, "port");
+                qdict_put_str(addrdict, "port", addr_port);
+        }
+    }
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -141,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -151,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_connect_uri(to, "socket-address");
     }
+    migrate_set_ports(to, channel_list);
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
-- 
2.22.3


