Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976D1C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoqt-00066y-61; Wed, 06 Mar 2024 05:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqr-00062Z-NE
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqp-0000Dk-G8
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:21 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42601qBR004026; Wed, 6 Mar 2024 02:50:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=9earbsqya7o7Pap8AYQ1MU3VmfxHwpI6bRfmuPK0D
 Ak=; b=uxZ9Wc6ehwka9SJaOM2jzcznpIXsKe/j9kIWKTZnvgFiQKN9Ao/mt+xsp
 Gpnhf0lhSdCGMPXh5fdsOEZgPvm/KSM+hFsTa4LLB7DA8Rj5e/sD9aw66vUP6Dbi
 8wtXPN/utiqikhDTMzotUbLxNernr/O9+cOjcWhJ7KCRLxcpV77ajTIwJJKviukx
 oU03ruCNZL5llXvYcapSx4ZEf0bYObDUlV5LuAEyyvRmxEM3hP3MtWqGiusu2vCA
 IbbkRCS+opLXeXlpKgp/pltoCx4ZRGP88suQh0WGTJPfXrAFWCs6PiJAO9QxL/JW
 oDrT8OVKuZ+s/an4Ra2wajkOQ+LSQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hgg5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKM2Jgdpq6iQfABtAe+8Hym0+0dBH95FN6Jv3ess3P/1rW1ESCMb7lZsnnwSrd2RCsFxlhOGH9DS6i3ZfkgD+YN/z0kw72M5i/k4RoKqlx7CHWWGNRzRdI+eB5Q3I0Z0RvG9e2l1EXeyI5KWKjYCB9KBkdn3Ycw149l6nUl/JAM2BGiUOwnlezvc+F7KqI7LkCevnS/CGxptiiBUP/5IQBxKMMUnwA4xVldLLm6nIkCbcTwX9XnMCeyoslxc5AvArqCwuQrObSS0cELbzhtPWLBtZpwnU+k9tDQ0lWm2KaQR5VqSTtdFSPzMw2WdpHJmXJZC/YrJpUt+XxBqSrIvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9earbsqya7o7Pap8AYQ1MU3VmfxHwpI6bRfmuPK0DAk=;
 b=P6e7UhMBwu3w4+VS7VYj4ratyRyFFHgpoPbbi15aDpRFRfvOjQ2iVlkzfgz81f7FB1WclOF+BBfJXQsikFcueFjpSFMDakEaKAMVs3RYpb1mhvDW5JC30bWajIp5ulvmNSs8KlPyVQ1juDopTrrM9WnTdB7E78f4xWNM4F1nPW16ixY+rXT4C7hJQX0UquZst6MDBGvRwMHX2glpE13raBPacE7/A1WjG0/iHrY+mdW2R3nzPPYHNbWpD2SDL7JnCVzSdDGIFcINvQYyy12FWtUeSswTMgBKnRzNxJwQjeC5MAkMIMnzwGfD8czcLJhAhMAmSTJS7GWkeWa7qgaGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9earbsqya7o7Pap8AYQ1MU3VmfxHwpI6bRfmuPK0DAk=;
 b=SaHKQA6Ig9DJrlQ+3PlWdgW5EwM9tlgu6d6k5Q/SNCvp8I/9ldTNBYhmAhXOIFSOxc8B9k9pyqfJrIFbJzkxxnVU1JsqaQfUkLzPwpTP6JdbM4PXnxmANVoFZQPvOU6DRVU+pTne1dvkbkgqTLGKO3yKqEoOfkQq4lzXRLXujE9DRCI5+3qriYmzqJGrIRn4xnYU4XhX2mTLfyCZhrIOnFWy2gObqqwWpj8ixyEml1Ox28laUE2nr/63fndp+Rue6nYXx75ExGf8eYDKD2E8+1WncMBCODAAGrCpOSjUlvgn9OJzAa+XwA6JHrrNkrn7/SuXVb0Y6cddhcc+f/MieQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9594.namprd02.prod.outlook.com (2603:10b6:930:79::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 10:50:16 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:16 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 2/7] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Date: Wed,  6 Mar 2024 10:49:53 +0000
Message-Id: <20240306104958.39857-3-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: df63c096-d85f-4321-2112-08dc3dcb355a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNxFbCh0K3jmVce49FiXQqTYY+furPWVcjTVvFf/u3eUxiGfzkE2LCTcamFqcNqyJYz3A/jeC3v6k9FdaYzcFrgdzj6dGQfYwxYRvnf8xsjHLzEnLqvID3dMHnulcWWU+1SmxXdft0DkeMFqlD/gM3090VCkCyr3D8WzoE/bbQLoQ8I4v2W3r2Qh9fGqHfbWheaON/7r0Pw9d0YsxJYJ0pxAlw3MijmCr+TqkLM4m/d2aA9KJCP14ZmkVFVLkkWmU37ydSc6NU4aruUkRjobUpn6KYJWlf0VyE04gtn9dMUiz3n4EyIMmny1uvuDcEAxoAzPjPCCJ/ZSvCFlMMG65XrWTFWeASdjtIMpCXAZ5ERcQQh34Tg/QcxsbPW7VnB07tZXdN0iAOHFcPBxh8HUcO7Z2XKH4JIiaCdDmnSwnpE3AAVx8Y2/R5ITYCWzQw7XpQ58OecWFIW/y2P1QW818ze5G0WiXqcCxv8f8Zxt9jr8YAhzFSY1jbMos6dzhQGUo8MYpapmJmg6PHDx5OLxse17gbpZTqxC80aiDmXdDwa1ePbbn9Z6isKUfITRlVFb1TCYgX713UhPCEm4m9PObhrCC3Pz/qe4RtA/rmsZsU7gcWzSmnhDC7cQZe6NSK1TaJOA1A/tQdz4E4LU4P9GgxW5uBQwmIJl7kG9Yi7eHaHpnOPjPQV+34Lgap8GKUodpAeBKX2vT66Y0useL+7apV7ige2yktZY8Hoi4fOP2wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCqQjg4Yc1xGPtkPTEGukn6wG2VSBNDgYrKbfXW1djzNRPM/gIkibXE9uP35?=
 =?us-ascii?Q?pYdQqHHGzWpdrvnz2pSqzlGoiptm/9fe6qC2HeO6ExOjRgXZdSR31WkQhI6k?=
 =?us-ascii?Q?UFY/+vK/FHqM1M8l4pO8NEPD8/rUySXPVLxE6IbZ9jBb2nyZNWNTFLDL1Ytb?=
 =?us-ascii?Q?JCDGJF3liTdH3sNatPeSnWnru9Ffe1/nDZP3k8wzgSxY/VDGv41eVviIINiP?=
 =?us-ascii?Q?0xz9HZutJrbFYtpSoIhHWjt62FhfJ+SnnYrnVLczJNxf/HKMYOJzjO+ywVtm?=
 =?us-ascii?Q?AOOA3Snp3xjd3fO4deVM0lKJlUtFhrTnLDtpQdRWXv02l75I09RZ1pCKWC08?=
 =?us-ascii?Q?hlRVShzUl3VrDOBgdnJ8uSj/Rec77FJjL+2P2WSBRPA/7VfiPWWgeXAvctW3?=
 =?us-ascii?Q?OUI4MZFRCz3/CGvqXYY/47XXVNQCNwhjlnWzPs/ymoKI0SlKZTaz9H9me/0C?=
 =?us-ascii?Q?KCBywi1kQcxbB+9QwVn5GG0X9jNg+sVYt1tw7gcn45TjAMnul3B/ez3r6Fgl?=
 =?us-ascii?Q?vg+AgIOpJsAc3XfbcIz6+7/f+VhQoABQwrohJWX9YylLuhlHCQmDUKsRqq8+?=
 =?us-ascii?Q?j2+kpxqUrzDvWhtfwTAuh1JBJmM9t4dwX93i7abK+FeMufgODJ+jCV+x56hQ?=
 =?us-ascii?Q?epD4bQ0whsyUJEMTg9HNRnMjbnoaii9z8X884gEpuwbGDugMRSbh5CEJWvYM?=
 =?us-ascii?Q?W52sjO+xxunVwMX1CxWtB+z/ayY+ZzM+LBZUrYfbyjRu0+mfpcYKxKPo1U7+?=
 =?us-ascii?Q?+C2tndmBfiabB0RUp8hs7AEWVxBLxCqO97AiovT3uqHNkqLHWfzg8fWBe9wj?=
 =?us-ascii?Q?LQiOiqwf0bo2yXvXVlpa0TXBPx083egz3UdysD77s9J9MKORBOte0gKVAiyG?=
 =?us-ascii?Q?P3TnIHNEDlBHVbW6VY+chb0XeDH+kjZc2t4DK1qQbXTOEtzZ1AT8dX1kUe0+?=
 =?us-ascii?Q?ChWGbq+ZQuW+n6REpLdXE5OakeZn1ANoZJO9gksGCoapYvrIHnXxRd7SZ1oU?=
 =?us-ascii?Q?9kzexhlj1K/VO4WQGbqoX1EUr11uPBVA7V1iYYfTcIniJydvUOrsjrTQuwZR?=
 =?us-ascii?Q?KeUaz4KlQO9QrnUv3d2pyeA6IAsz5axFbcrRD1YmNVJjqG/AxHzSqj/x4Plp?=
 =?us-ascii?Q?oVxU3oNQQCNMSk+K3FVAPHjPZs9FIQjtg6agqoRcpvRUuLmgTzC1jgKXiCcE?=
 =?us-ascii?Q?ugJLGsBz2fcaBHTjQXBClJVvWxZ7fFDvhkhsRXibfARIqGCKNwr4L4yvubA9?=
 =?us-ascii?Q?gT70e0X7Fml4vhufRnlyp0/RfH/TUtgPsIEWQeS1fC39oeSDUQPxnXE+770C?=
 =?us-ascii?Q?E0iUXFleJmQnm5cWVjs1h0y/v/NuEyFcw1CN23LxgJQ6F7O1PXLNCzEB5ePI?=
 =?us-ascii?Q?NtJ5cy7DEbBNZgQUsEU36vHjAAddDT4gKiraBA9PCKYk+jVzA4IT4BGGNtU5?=
 =?us-ascii?Q?ra4fG9Tdgi3AR3gKTEW5JDk0GD8NObezi9Z2RV4BoJaeuLQDenMceJS4OZLh?=
 =?us-ascii?Q?CXg/9km4hK7o9xuVyOxS7GigM6A9iiITNBsYhbOkwQomKj0L6SZezJTOJs+M?=
 =?us-ascii?Q?swsiZ3uH+308L+SoseInYiKiPsUJ/f2Dg/3I9ps2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df63c096-d85f-4321-2112-08dc3dcb355a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:16.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Paw6bUKweL/htiEnmKTiQ9AYYhIBBwb9t+su4VbkBADE8Yg4tRlRS0zGnsISscxsDPDoIDBpGOnMvObdGfrrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9594
X-Proofpoint-ORIG-GUID: -NM7jSbbV6BsBkIwPrycaNVrZHoi9xo0
X-Proofpoint-GUID: -NM7jSbbV6BsBkIwPrycaNVrZHoi9xo0
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

Move the calls to migrate_get_socket_address() into migrate_qmp().
Get rid of connect_uri and replace it with args->connect_uri only
because 'to' object will help to generate connect_uri with the
correct port number.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 55 ++++++++++++++++++++++-
 tests/qtest/migration-test.c    | 79 +++++----------------------------
 2 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b6206a04fb..9af3c7d4d5 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,10 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qemu/sockets.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/error.h"
 
 #include "migration-helpers.h"
 
@@ -24,6 +28,51 @@
  */
 #define MIGRATION_STATUS_WAIT_TIMEOUT 120
 
+static char *SocketAddress_to_str(SocketAddress *addr)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.inet.host,
+                               addr->u.inet.port);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("unix:%s",
+                               addr->u.q_unix.path);
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("fd:%s", addr->u.fd.str);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
+    default:
+        return g_strdup("unknown address type");
+    }
+}
+
+static char *
+migrate_get_socket_address(QTestState *who, const char *parameter)
+{
+    QDict *rsp;
+    char *result;
+    SocketAddressList *addrs;
+    Visitor *iv = NULL;
+    QObject *object;
+
+    rsp = migrate_query(who);
+    object = qdict_get(rsp, parameter);
+
+    iv = qobject_input_visitor_new(object);
+    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
+    visit_free(iv);
+
+    /* we are only using a single address */
+    result = SocketAddress_to_str(addrs->value);
+
+    qapi_free_SocketAddressList(addrs);
+    qobject_unref(rsp);
+    return result;
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -73,13 +122,17 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (!uri) {
+        connect_uri = migrate_get_socket_address(to, "socket-address");
+    }
+    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f645ab26f2..20b1dd031a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -369,50 +369,6 @@ static void cleanup(const char *filename)
     unlink(path);
 }
 
-static char *SocketAddress_to_str(SocketAddress *addr)
-{
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        return g_strdup_printf("tcp:%s:%s",
-                               addr->u.inet.host,
-                               addr->u.inet.port);
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        return g_strdup_printf("unix:%s",
-                               addr->u.q_unix.path);
-    case SOCKET_ADDRESS_TYPE_FD:
-        return g_strdup_printf("fd:%s", addr->u.fd.str);
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("tcp:%s:%s",
-                               addr->u.vsock.cid,
-                               addr->u.vsock.port);
-    default:
-        return g_strdup("unknown address type");
-    }
-}
-
-static char *migrate_get_socket_address(QTestState *who, const char *parameter)
-{
-    QDict *rsp;
-    char *result;
-    SocketAddressList *addrs;
-    Visitor *iv = NULL;
-    QObject *object;
-
-    rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
-
-    iv = qobject_input_visitor_new(object);
-    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
-    visit_free(iv);
-
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
-    qobject_unref(rsp);
-    return result;
-}
-
 static long long migrate_get_parameter_int(QTestState *who,
                                            const char *parameter)
 {
@@ -1349,8 +1305,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1733,7 +1688,6 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1766,18 +1720,12 @@ static void test_precopy_common(MigrateCommon *args)
         }
     }
 
-    if (!args->connect_uri) {
-        connect_uri = migrate_get_socket_address(to, "socket-address");
-    } else {
-        connect_uri = g_strdup(args->connect_uri);
-    }
-
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1843,7 +1791,6 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = g_strdup(args->connect_uri);
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1869,18 +1816,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, "{}");
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -2885,7 +2832,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
         return;
@@ -2906,9 +2852,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2933,14 +2877,11 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
 
-    g_free(uri);
-    uri = migrate_get_socket_address(to2, "socket-address");
-
     wait_for_migration_status(from, "cancelled", NULL);
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, uri, "{}");
+    migrate_qmp(from, to2, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3273,7 +3214,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3314,7 +3255,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


