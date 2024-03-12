Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B08AC54E69
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i6-0002Ab-Dv; Tue, 12 Mar 2024 16:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i4-00029h-Ii
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003Ae-67
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CJix4V012993; Tue, 12 Mar 2024 13:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=99jZ1PbsY8XqInEdiuKTKl/deCt5a3tVT/+s8lvC6
 ts=; b=o8jb9oS2NyWO6PfM257IDqPB6NxUmou5FUcgH9Brw2hEv6/hQpNzOIN8L
 tjhnbpz5cUcx3QES8qeJIj6/vIGo/8/rVbZbNh3kaLey10WFgUC3k35QZhNEAltU
 0Q5xot+eaXJBpxl99qkReq+gULStOaGzqXNkRA63FXdOsfBabWqudw8A48yrjGIi
 m68GmU2G5JFn4VUuQjYZUuSKEswNr2glxc8wyiZxfvvEp+FWkp6Ds6nu4lhllEw5
 sHqks7ePZX33CP3OxqnL2C3w5mvWDNFloZEtuWRrlXgePIk0qztCuh4UJitOSYW0
 AnSVOTuNFLMf7YCIaOoLLVKzBn+mg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygpuee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da1iOAbxasncypzBTSmUctBG3y+/zt3glLtxDN5fd5y/3tCNAueMuH0Dd2+8830BjqC5RTA4y+17yxKHoQ1eKz7+yO4G3BGIW9xKdb8oAkaYX+VcIul8ZFmorSaoWmQ5Fu8TcIa8qywDv/dqDku2S1humSrv/IeuXveCWKEBKYcy0aLkh+EIXJqop3pYos7kYjobGjJeLbzfmFX8UIz/y8CZdJMLWl257UyECiQbpuFp6zakevJsKxmtMp25TJAKXY2SLjxdX7+/sorPW8y4pcO0hT4Owtwlhqt4vlVpoq9hdoLHABEEl+OeDjnL28D7SJvmwRZliWDTaOSRpSbrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99jZ1PbsY8XqInEdiuKTKl/deCt5a3tVT/+s8lvC6ts=;
 b=HaO/V/9bfuvKO50wEhqrz+brDxjHes4LkM/k/7j532HLjSzqnjvT3yumhwcMZ9UUVhzsqaIpCYZ1FYM3NkoSvYKg/+LzhIg4uvud8ctyY+2CMhgQcdZWTpM1tOOdrs7fa4CyJwfMZ16XEF7QWuCVcB9//QY5F8W9359owqxLkUdEmwV4LttPn7nCvLBHHQpSFHS1BH9yh+/dikVjFhcbIm4o+EaTdAwKev+Evekt8jDP2KoREX89LGp21E2R/Kz33EWt/aFNnd6GqNul+1NafNTsl7MLsGkz6DImHElfRAJlM7ilysYuY0WVMYs2Rr0xHAlZWb+tIE93Qr39U2Bwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99jZ1PbsY8XqInEdiuKTKl/deCt5a3tVT/+s8lvC6ts=;
 b=gy8Apg/tXL7fSgdbvPmrKPOiGvq7geskLfnv7tU+vSy4miDipL66XLu87EWfzk1AoP7VuLNtl5TxriBleaK7Drpt8RrlmGsQbzXoYyc63W1pANCrdPgEbMw2/Pxtnpt6UV4KnYqQw3v/SudG3kZwvYjS3qH+vVVcHOiJHyT5SurzmfP0G26SPMQZSLFxU1htSKt1ud3Z1h0sLPr8GMJYY1ZLLTvEM282nY1zlTOCBUuzcE9e39V2bhxiFe28bdlqvA84hV+MTk4/0xsFTNPFGKD4quMyIZ1a4tZGoV/JOr9oMCPIVEm7523FjbY/jy/fb90b2RKGb+x8cuCV5OaJbA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:43 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:43 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 5/8] tests/qtest/migration: Add migrate_set_ports into
 migrate_qmp to update migration port value
Date: Tue, 12 Mar 2024 20:26:31 +0000
Message-Id: <20240312202634.63349-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312202634.63349-1-het.gala@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB10057:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8f46a2-6b7b-4a4a-43ae-08dc42d2bb60
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLephLe2mCGzF5fDKnmG53aBv9FR51lDlmM6Z9R8N+IMUi6vUCaHDPy9nBFCil8kS5j7tsyo0K0c4uepcG2D8cvxBk10gffQYsheuS45y41oJoFPISNcfPDu2HNxhr2CS4bRVUXBnJU0xKb+1ohGpknppM62kZTaCqylna6tSBrAzwhj3xtkeKMuMKkfJNFvkC2RZOmoxjygE3cfPqElRBCXwK9J5jW9UT5khRwfr0crmuBpEnklDEpaaXTAg76ETaTP3BhercTgiyLyU1+dx6X/7g+Xfst6T5dE00Cg8UAW8UziDsTVjAEdEDwGxnF33hr4eqgDWHpWEVH46OGXK6jiOgLtcZGF9NoVB2JZWVQm95fy1bhLnfgzzJd2qE3fUSN3iKu3Db/ZYK7/mlucrkQK4yaYWYO++h9b77nYQn6ptiU1UXhN9ZF9NxkR3cUPHRCFEwbCthqpgVcIkZth0suMWv9h4nzIZETRLMYrum9c86xUXHNk8Yp22sbpFRK2tduJmL+CmJUb5Oj7nGrgXzJ3Ct/LLwUBbHF/bgr3nh2ut02RiAgwr9KuRL+RUatS0D90EyxjZPLo11fTCNLb5LIDnK2k1VUjerzqsb8jdDtuUq9QUIfUcH4R4g8hbFHzM5zCqbcM9kyKuz+s8LUl65LZLkVJrxrGCpxfQpnZsbm4uzptW8OjDvr6JKnabz11q58Pua3x/RzSV3//2dPFR9G4sAPeFm4YLIIfP8BS3IU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0lUNOgKkmjtqaykZTOArMtPPvIrUhYBAQbP9SpnS2Bco+BRClt1VjhOiFAuy?=
 =?us-ascii?Q?f0Jr3kivyQFxnVP5kTK5PFOe8zZH6cMzQ7NAKHuZrgmXfL3xsQNEeZ8DtfGu?=
 =?us-ascii?Q?wZJq32SQq9LfuhrHz9yKCsJXHNzZwcG13SeMnSFxCoK40IPt5MsuJz5W2wH7?=
 =?us-ascii?Q?6lFUvCWDAXTxO1Faawm63lf7HRm8WK7IqqF/B0Dtd8wfR+nI2Ff+xcA8D9bK?=
 =?us-ascii?Q?N6MXC3jB/chorMLsEaStyduEyQgDJoB8ZqBRpip4zRGfN8uLkFC2ZAmN9zxv?=
 =?us-ascii?Q?GxVpoqPkul30xxUu9cVL6exl6yKatTmTqQUflBTHfIgfU1QrFoh69Pu587Ko?=
 =?us-ascii?Q?iWE2XqEFbIknOmSU0oX0kfiAYcsbgXFfLuTXmPW1+kNEsgAJkoND6pgHd9VB?=
 =?us-ascii?Q?CRjM58/By890xdwKgVecc319zWJGCWUl8U7kTefCl0x76uZ9Y7b4+hX0Dqvo?=
 =?us-ascii?Q?w9I1dQ07DuOEENxdYMp3Qiw4y5mD6uYxy2bmwKdodf2IFowv5PvS1AM3NZZG?=
 =?us-ascii?Q?m638wCSpijDVgmUU+lu66AtXhSLHjeqU+qyRTeYPBjO59KdZoeLj0Jd6g6CZ?=
 =?us-ascii?Q?8DosyvnQ8lT4V3B4txEPpLEqApjb3F64lx5cLSZfpp3Fe92y4dOwO8xLjPMh?=
 =?us-ascii?Q?4EuWsc7AaNNVF9PZd/wzmZNzQ3SCe9Z3fSvJbpYSrjPAfUXRqGkmtymmbUAh?=
 =?us-ascii?Q?Pj8V285A/a8kcJ8NbKRcvTp5n9aBBKaLGMVpLaoOaCk0+jJJVBW6Tl+5H7Di?=
 =?us-ascii?Q?PuDL1cXs2cseRw7PfwZr6/nvzyttcOLE04MioZ7EOF85fJGfqC2HgmJF9Lcg?=
 =?us-ascii?Q?axpJcbXgudtZsixweq0MnB1yirhkkYc8wy0aal4p0QmL/epjmHftBbYI+iKL?=
 =?us-ascii?Q?hRUirawlYrsDcBsmBsqMSuL//gmtEW93l8b9jX+9VWjkPbDLTBU+MTzy0EDY?=
 =?us-ascii?Q?CNxMitRzqNC5wDKwOgTmiUP0Skrj6U2+wnHaFQEUub+xO/a9f4HW5+yxqYkq?=
 =?us-ascii?Q?gadGzkaRpRYQubvTcbKCw7ae1a9d94Czj4JYR8zBOpmOXzlfcqhKCZECLN/o?=
 =?us-ascii?Q?1yz/QSkw3SkL6xhzpmc28tKw4+DIlZy1NlFr83VK/OjY1Vy8lSi/eiEaDjjZ?=
 =?us-ascii?Q?YT4Dj7XdLcLXzkSmJAvZ+15HxXsbY/F0ndqty2S5zlvbcw/2HXRUeIeKzpBE?=
 =?us-ascii?Q?oPnwOYJzj/Ry66Pruwg8YPlPlvzO7wI1R4M8S28rMpxbn3M2dMaHqxqlqCFu?=
 =?us-ascii?Q?TwBdStvjF5m47/VpOJFfQRfaUG7Z2JTWOCIl9FC9/kaQImvUGXS2EaQd/HVy?=
 =?us-ascii?Q?nwl+gfJx7FkSprcO9mJrzqTPxh7ePV+sTeaHIWu26ZQHmLX0e9R1Wx9UY1VK?=
 =?us-ascii?Q?dnxJ1sFSGMwPxjTcZ5ptiKpAyIbzfryP26ggVy2N2gKFk+SeAEgYCSOjFiaO?=
 =?us-ascii?Q?jHx7ubZ3ihWNQirE73wiC/gjY8UCwtulIkBPQwP9/I+6g9ZdzD3BnWKIVDMT?=
 =?us-ascii?Q?f5v0dnipwSZMrwqW5ujtPiCGaliSgmBjqKtTmdDDTsJ+QiJkUKG6lWy3AmmX?=
 =?us-ascii?Q?MFZ3GW7mKBgQvs7zPtULPFWePyCv2SPws1iHMGi8V0rO2hVxTijYDM1OBH+L?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8f46a2-6b7b-4a4a-43ae-08dc42d2bb60
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:43.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9CCFyDFIneuTNSKCClrMpGAsPp/BP/6Loc1YIJHSLjf8dAVrT0F15C8DAKRUjMMtKk86a/hpWr36gA3ilX+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: Rfdowv6nJa-1vBGFF1sepKYubos9ugpl
X-Proofpoint-GUID: Rfdowv6nJa-1vBGFF1sepKYubos9ugpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

migrate_get_connect_qdict gets qdict with the dst QEMU parameters.

migrate_set_ports() from list of channels reads each QDict for port,
and fills the port with correct value in case it was 0 in the test.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index f215f44467..ed8d812e9d 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -16,6 +16,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/cutils.h"
 
 #include "migration-helpers.h"
 
@@ -48,6 +50,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
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
 static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
@@ -81,6 +114,46 @@ migrate_get_connect_uri(QTestState *who)
     return connect_uri;
 }
 
+static QDict *
+migrate_get_connect_qdict(QTestState *who)
+{
+    SocketAddress *addrs;
+    QDict *connect_qdict;
+
+    addrs = migrate_get_socket_address(who);
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
+    addr = migrate_get_connect_qdict(to);
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
+
+    qobject_unref(addr);
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -139,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -149,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_connect_uri(to);
     }
+    migrate_set_ports(to, channel_list);
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
-- 
2.22.3


