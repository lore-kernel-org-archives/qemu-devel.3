Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88C5C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhor7-0006Pj-4S; Wed, 06 Mar 2024 05:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhor5-0006OY-0W
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhor3-0000F5-Bp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:34 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42601p7S003955; Wed, 6 Mar 2024 02:50:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=dje5I28MVmiUtcOmBA4JKLc1xSAQmSaRXgku8Ibip
 S4=; b=xQrAODXWnDIw5oH0SmrfC7Vy90E04ghU6SekYXAkqEWhAoHXTTDKevt+t
 YKzQgDxU21FWPK/oKjR3zlwDp89Agqt32W3ao1WpuTAVi28cBkukRnbWKPFffozg
 WhGsf4fiDi/1WtKm4gX8tXOlJTM0/p5su/1fcdNqk/u1TxhP+uniD/b4GgXKotz+
 Vi1Tm5lAyUlL9sRM9GPH2+4hnbE0lPLMDy1F1PUA+NbmGySq5ESYqphQvF08koL/
 Q27XtzmVwnAEjjkJvpv0dhDTRo7scbxIZZTP/GKb/396Npa5eDKj0IgvmLVOEVL0
 4/nQPi8yClD8keQlm3EeJPXGKTG6w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hgg65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn2/LuW/Dk4K1v7qQf2t9SIVkAR3UAMVQNCnv20PaY3lJweV6ZmKiUQLh4E48bgOrWInYc0AupT/bD8uAjddUOfGMK7upK0byfxY7B7Fzc45S/RnMJ+Co1hwXfGPZe0wVSjfaSt+XbQjlVux4mGMO8n8G9wWLi3LiCiwWul9sGowm4uVH277wdsNwxzh+8lN2uWhaC9JgWq7ttBwmLqxGP2r/Lhi0wii/XqmYbfKpDxIX9Gc0DV01LRxGo4FJSJl9a8LjdBtVx965OKvijeOZW3rnnj77GRmhvH1NN9HFCJn6SXFoGHqYeDTJGjlp5AS2ZzVacE8dnxdCQCyZ9jEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dje5I28MVmiUtcOmBA4JKLc1xSAQmSaRXgku8IbipS4=;
 b=EFokf9Jahmm6zHVqBLRxhyVrcGR7nULY2aJIgw4g5+E37YAbhIi37OLbuFLQJo7UgdmDNbGRR1KZzwA4eqyVK+UVVvHAv46di1DkLqPb9Pcv/IoRUMORMwhDzwgjivM+V2fRk5cuYnMxEUt00sjPGZy1xMqERQj4JGsYh3gQYKcZq2r81JPA0LoyxTBWlvue8F6WsyZI7SSB1H9hTlFQR5QeSu2RY0O2S3Bc1i0xGu5+1g6edIFvTUAEZ47okSs+rQMVEq8QIojqomPnkudoSZholXUuLZxu3Y73bKYMpb+elzr1VMarJAJIsQj+p2RT3VdSQSU823K+WfCShmSFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dje5I28MVmiUtcOmBA4JKLc1xSAQmSaRXgku8IbipS4=;
 b=YdyHqvruJfu8D+8A/iZrrtWYhGGcjWN+Mur+UegRWcCVJbbwutAVwgODWLcciE+h3mrC8SzL4HH6iPuNGa2xdM3uRIOEeaDCRTfzEGY4+C+FR0oF0+5z9qEltoWBUvV3ivKlQVeg9e2bkLNIPafsFEQ/4tURoOdMK/X23qjHoxtQkJHgofbYdJKeT9AEnodf8chH2+BaxDYw/67C3kRixOmQALdCAWL9xA7SCvXhBP1TlKb0uJtOGZe9OF9P4XNfOXaqhA/XRlwkFfkhew0uAPdPDnKtm/elwmt1LGVzYvXpXAOAAnP5lZa0vRmcuj+U5J7z+ZORd+K0ndx0ZYv1uQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DS0PR02MB9617.namprd02.prod.outlook.com (2603:10b6:8:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Wed, 6 Mar
 2024 10:50:29 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:29 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
Date: Wed,  6 Mar 2024 10:49:55 +0000
Message-Id: <20240306104958.39857-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DS0PR02MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: d9327cee-ba79-4c95-26b8-08dc3dcb3d4c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QF0i9OqgjLC8ij6M5bu3Uhrs97sNHg9w768oXd/QbQ5xWsr9QDH8vndU4zc442xNzpjR1M62O1Hw25C9J94JFxcKwwYOCx8DVZ/vTE6b4Twij9F5vBitSy4E3ar0p7RHv1j8WEL3X0Tbcb6pHjb8bpWFLEziJpEtqgJUqIr3OuwFbTjQtPNJ2xjQ58WK/tt5ysb+zGjj0ZGyRqFFtdvliKbeQIuxxE88VL+MB43O4REnKxxNh510uzXrGS91p9ri/cyd3QrLzgevoB45Q7uRSQ0vd8YC/vqHXuwpXcZ+LIpdH1jm+dWZdnPDWIHgq5cpuVCvvN8y/auENT1BSGzeRX72fQR4avE/wfpqytygvwwtKj51aO2tCbPKuYKJBqXGIfK5PnFoQPxz1ll1RQiWb0lp3PZ4wYIo82C663FQ0GhODwDbKY02W6oonj3K+iL1OTEATSKrqgCKLGW6S/cH3vsn7sQTVXc7DZithG+7IlCkaL+aPMCN7sVQqcMMgFrwcMYpeJyZGJAkzKxZcFVUMabtN3OUtG9183N05KROQNZzAAduAVYJqsmE3M2LAPsR0Y+p8TQeONQmHtyW0yKUl8nuEW/MH19H36dsVO1+WvGXb/SQPeYrb8uCbvtth6ljWxWpV6I1QDj6t8nkR7xz5rQ1Jm2Vk75woAeWb6+oDDINjoSuLhwoqD4aKFDvLRoSFbhNk+rtC/OlQf26tOqV5zLBHhbrVsBFzfHib63PPeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WCQ6xAmrEPsSbSQ5C1n+ElicZ44ZBSS2REFMP9kM32oBIkD/p14GXRfGcs7c?=
 =?us-ascii?Q?YioaVmjKy0Kr4TBELaQdQ2Hx/kLEi/ygFjOW9XkHkZv8ZsIMtuonnoSBGwBa?=
 =?us-ascii?Q?bIWQEuVz4huuZgvy3/nwfiYEQikS64lJDg7euzwDws/ZbETbR8zjVcHBf61H?=
 =?us-ascii?Q?LA83XvNpy70oEkzvUVcj/XcofgzUAg6zd/T93752dBoDx1RX2VRlAWjs27oz?=
 =?us-ascii?Q?h87PT8ZMincy5VOut++zvJnUthdjSIaf1y0T4F1K9vSA7spIG2SAD5M5tVmu?=
 =?us-ascii?Q?rpK1+dQDCsgHCLayP2TIY5XgcMnLRKnMypBL6ZuupqfNDWviIDHR74Jix6ZR?=
 =?us-ascii?Q?MOzo+vak15Er/5ZcoDuptyimi8eTbJ+b/ktra+0h3zM7i3KhzRPumCPEy2Ye?=
 =?us-ascii?Q?djb3EeY61AY/ZG27QOZzyM6fyqvNpKicHqWSAL1Az8rlBVv9vF2iqYVLK4dK?=
 =?us-ascii?Q?/PVw3SoernjFP2ECOtm+/Cvwf0rmkYW58A/vTnW+hp74j3LxAdJxQ5qpIr7c?=
 =?us-ascii?Q?sEadQsoO9L7xWqZbBNiCbIbMLenZO8k7e33s2MUMW2/Yh1QVzZwPqBFmLvli?=
 =?us-ascii?Q?8Xjx4EG5Hl61MeFD1xT3mTTsO+ps9t3ApoSEOxaa2lv/acxPEARSJlfhoo0h?=
 =?us-ascii?Q?HmsYVk+Z3ZhTf4X8c6yLBXJ5EHMnZYC2HF50kwYfiXsXdiwuV4ViFZlSGz07?=
 =?us-ascii?Q?FdWvJ4YU6i2pAJ5dVRuOYoMNN37ccKLGo04RmXMYDQKrEvgHxE6QxMx9C6ha?=
 =?us-ascii?Q?i7ozwfjGFWFPBk1H3nuBXLUTMgQQFa6P18k1NByD0ctmfyFfbIOCEM0yagpm?=
 =?us-ascii?Q?F4OYCzxt1g63MFyl5yEMNP7bqT0RMvOQTqvlhu7WiXSqhhCevgU/NF/GqZJ4?=
 =?us-ascii?Q?X1lFqM+c/ftaKpDoY750fF9Pv6V+wf/qqGnAgL+l9mwDzuCr/MorRz66SgS0?=
 =?us-ascii?Q?aKu7E4UekJsrGkU+xLVt3+G/sCn5cK+v8LRb7Cn6fwh8XzSEkxAXLGZvnhWy?=
 =?us-ascii?Q?thnmMYvv9Zrzdgwc3tfhyAC2B/QRqTayPx9KAoGLhSkELRRjOBZMwffBf5QJ?=
 =?us-ascii?Q?u12DAudWm5QKYRBqYmBs5rZNfPnqDAJk0SbFyHejtc3IAf0tc5dOD6ha9j7u?=
 =?us-ascii?Q?lOEwEaD7ZkQDf3+v6RCh7sevkRsiUR7lUNh4nTDz5J72Vfzjxg4urdfNWPzr?=
 =?us-ascii?Q?wOxFwy7Z6UJBdqDpBjy8AaQNtI19K/BzDEk+LLhEtBebEqCW2z01OJ7qT+0o?=
 =?us-ascii?Q?ntg1xt9iBjWSaaljqePsU/LNYJeQEXGMaRU1rr5PbRk6j8gneJ6RnBggnTri?=
 =?us-ascii?Q?FgBcmZGdj6SDyeLkEP0dP3WmS8FjIeMw8agMmjGIIiimXd2hJJsfqjI1WHUO?=
 =?us-ascii?Q?O5O7rj7Z9GjqWHJYqc1z9Q3C0wQSCxP+1NxXSWJpXtfO1DHvwqTUYioi63jL?=
 =?us-ascii?Q?+IqBg1VeJTfrNXFL9ae0zYOrAOPMkGNtDkNW4hgiSJz+XV/JUQPn9APjXFLQ?=
 =?us-ascii?Q?oZTToOBMwsBtwE1ygq9xd1g8IkJ9plvLlKqDbEF/u0J1VKCz8wo4Uk+glTDM?=
 =?us-ascii?Q?K665rwtyfMRlXqFBwFKNNytW5lkZk9RIs3R/4d8EjH3ZzUxmFCSgHs1cVhCT?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9327cee-ba79-4c95-26b8-08dc3dcb3d4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:29.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC/TuukKc3X48mhFaB4K+9Q91k6/JsekSmlrDLeiIBQrcGCNMBmnbsNXXRzJOz+yRxrPAP2R9yEsWYRphlisnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9617
X-Proofpoint-ORIG-GUID: eAx_JguV4pgWF2ZiZp6nWW2Cnrho-elk
X-Proofpoint-GUID: eAx_JguV4pgWF2ZiZp6nWW2Cnrho-elk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Add a migrate_set_ports() function that from each QDict, fills in
the port in case it was 0 in the test.
Handle a list of channels so we can add a negative test that
passes more than one channel.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 478c1f259b..df4978bf17 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,6 +17,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+
 
 #include "migration-helpers.h"
 
@@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
     return result;
 }
 
+static void migrate_set_ports(QTestState *to, QList *channelList)
+{
+    g_autofree char *addr = NULL;
+    g_autofree char *addr_port = NULL;
+    QListEntry *entry;
+
+    addr = migrate_get_socket_address(to, "socket-address");
+    addr_port = g_strsplit(addr, ":", 3)[2];
+
+    QLIST_FOREACH_ENTRY(channelList, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QObject *addr_obj = qdict_get(channel, "addr");
+
+        if (qobject_type(addr_obj) == QTYPE_QDICT) {
+            QDict *addrdict = qobject_to(QDict, addr_obj);
+            if (qdict_haskey(addrdict, "port") &&
+            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+                qdict_put_str(addrdict, "port", addr_port);
+            }
+        }
+    }
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_socket_address(to, "socket-address");
     }
+    migrate_set_ports(to, NULL);
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
-- 
2.22.3


