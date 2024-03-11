Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B112C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbY-0002vE-5N; Mon, 11 Mar 2024 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbQ-0002tn-MS
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbM-0003Bm-NL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGn009722; Mon, 11 Mar 2024 14:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S
 /I=; b=JClZZnoip7FSUr5r8qijnbOkoJVgplFhBBJzKZauJ4yan89FTb+yL344m
 x0pjlqyCotYSKBfon/Rg9I2ZICGmgo/+KLB7U4NVoHLrFu2J2I5exTx64QjztrRm
 VmxgLAXi8Aj2CCSSyXY8UnuRl4b3l2okWRUrcVEZ7EeG0XLZVMZB66jb2tEd5zJK
 O6HPSxNKD2EQUxcF1j1NatjNohM0WVoAzCpHKBGDTL85yaeS4kA7zqkjsfrMuA43
 R6ARskjisJf0yqr8fC9/ZMuDO1gW3mTlLU8KS3vHqidROrw33eJHRI0+tOQGe6Yn
 7clu/lFdQyOf4bWnxHDoQ4FEetF3Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUHd7URGtW6Dp7o3jO7dZxP6J9bkIfa8e+8SUCUJQ8fsSzXT0omfcsgI6wF2NFxNoSiN8E4ps0xNcBA1BZov+1GYQtr5XFLxY6euWLy2oSpBSBepYQLX505bdem6aLo8U2wjHQaJKqLD0bNoTokScNfVqQcQzR8xPJDj4zpoG4riMTz7yNDDWYt/+PJGbxwit0vWVo7UlqOkF22O9QIQKDnQzdnIke+y4Y7D09Ima9LUCWIviJ4YcGAGip7z8adIMI2v1LcGtRb5zi1F3RmnV2CIcRgJ1KaSX9aWgYsJp8/RJNcFLl5Oo06xLU80LVEtMZf/5z8I96kfW0bN4VuqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S/I=;
 b=A0bfvo0iB4BtBmlymKK3K45b5j7le7Z+ZiCU2G5z5fSVy/heVSmnlt8LfiV1yEZ2HaGZ4R4lGjnpKyw8NHYp02JlEvi81MDMVD056zeXVQ+ebfHHU3hX2mfwKcB/VG0b0Xck0qFOA3tiZxMBV+KD/20JhsUfqUCXrm8c5MZTN4gKnYpwEZeSYnm0yLE26xpwqPLfBiLoh/MKMuRRePGJPoVAvt1FJtWYTyeKWmGT423ZMN3xZ2r8UdNZqGsiRpZc8aQRxdTBWTgEgaWimggVIaaHSjGKB2h1F0rH0EHQ7AhPg0kVvLBus2Jjp4cWs6uocN2zYwlKX0oSkT/sznIpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S/I=;
 b=fAvMIPYyXg0+CByE+P3H854A4in1Gyu2OvPRGhAB3NCWGo/bh+p+ThGWWB5fGtLUx+WXFLZQVYl9aUCTbFYHMEpAWytZZAh5mgoi6ZgGfUITiU+/P/DW1OlH0K+5I3rzF/mss2nxpJN+cmpnuWOupLqAEwM5Z75zrAsx0I3bjYsUe7wtJAdd6NyZ5i0cHM7ElTYSF8DkXzXo7Lvu12PCEgUujoFsuX3VupohZLwJDO/2n/9jXss7vhbUNJvrM0gpS9QgINbzzPzpo5w3o4kroL+XSF1DlPP81Z4JTZDVpjTy38cgGkXzR02ja/bR4MmNUv22Rr4ahbKjw2YGljVMiQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:25 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 2/8] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Date: Mon, 11 Mar 2024 21:53:52 +0000
Message-Id: <20240311215358.27476-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240311215358.27476-1-het.gala@nutanix.com>
References: <20240311215358.27476-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf7aa2e-52dd-4116-3c8b-08dc4215c95e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/etBFOJJGH3C5ymPrnpEvXeBrZ8sSOubw7NNA86pYWzdZ+Eu83GH6HcnKzOnQaWFdi8UNou3rXUg/OCjwb853trks7AkB5Q7ijL2EQg4tfrmA7fHWcsD7dJu495U+r3mJVn1y1kV/C00mYi31Jt0lPlky9fJEWPVnZekMQzlfe09U5rCxTGrRwTT39zzs6O/joCNixA33WMVSY3mB7IppTKDsa+AAgcFXrOhVtfwyE8NXPK88HKjrxkVW5f8gCz7f2eYpr6zj0PsLUIaFNxS6gb6cnYMia0HiInTublDBIrJQ1S+KATfrRjlX9TbNbg8NWlSTKrLTXZxrcLS9c4eFi42BkzmA6OevtNaJUt/DxrxZSq8IAo7ySxpO/jMoQ3Z7Iut9K7bPYmrPbDWcdvG8n7fqOABwgSXcOBjzwttxM6xGcAZsb501I+/2Qgz8OCTVYjsgPNLYt9vQjJ7VgZ5cGUhO57sgaPd2g3tEDBoZI9wLnK1fl2yNjgv/oelas0gXi6L2Yt/Cd51V5X41zDXFkwsEuuDexfotFqwSFBvWfxMG3aRzNSPF2VtpNuiqPpNw4KOITJ/OueB9D9E/+kvbBRWW+GBlRYKMXXoW9/HY+3QCqbk6W6XG/lvd5qkOnGsiQi9QU9j+nlLyCl/PQUTHylqUUBdpnaOSdz9DR6VFGbxRFhlhrJjl+WH+mDGYNieFQgZvxZjuv13/lcDIR3Z3w+E+pxwuNPoU0aKnQ23cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8R8dKWK6BYgbGaiKRKtT7w+3VRCZsiZXVlLH0sZgEx+BvzC6CSHd7hA9wnP?=
 =?us-ascii?Q?B3a4+9XopEPhdIf2MsvRhTOXGS4118OvNM24dsUYRd/VLC1tuKxR9Tc4bCGA?=
 =?us-ascii?Q?4K4ufI/47b5/5WE9LiCbzju9C/4Hac9tupOzLQZ4OCsnZhBoxbArZzf+eqWS?=
 =?us-ascii?Q?FZ10YptVh3OZaRzvQOhO5yplRZNSWhi3mFxFIPyfVbbqcg0jBzdrxDIKiDM8?=
 =?us-ascii?Q?+Cdzur5yU9H824HZZF0Bz83swEyrnEUow3Gv0ZXCXBU7Iq1K7qH/xKeIEP/1?=
 =?us-ascii?Q?qhKuhMZxBzK3/SNLID5IDgi9e0kQcVYWLHikaQvP+5oEO3drg+DQbctTaFjU?=
 =?us-ascii?Q?Wy8opwtVHfVqcs6a7TaugbAgmfL3wwY/Dp27F7GOCbFnmMz9poFE0PL7gP/y?=
 =?us-ascii?Q?zUALJPS3DGwl7SHH1zJ68j9Bi7qZTnE9IJKbwccRMvkE9ngd+M0AKZIZfkmO?=
 =?us-ascii?Q?+TulRk5SgpjudiFmMvS+JRvgyK6ZV0ysI028JUioXUjbUqUvLYvlI4iOL9uB?=
 =?us-ascii?Q?Ls1dmf3hIFmO+eb7ow+NPHyYf4TE4VjY7Aax5sy9Fj59ltjJjvN9IZrsp+NI?=
 =?us-ascii?Q?uccVjuOY3kDHivVimyKlcm0PGTLogcOm2AM2JSJalVH8LvLKKxkpf9LkZOsz?=
 =?us-ascii?Q?TbVHbdAWwZt5Arfjbmk7YRdzMgYOwEVOU3i096U2GOWX3jjg9MhVEt/yjtP6?=
 =?us-ascii?Q?WbplgRkWlZ/A06e7ndbtL8sV2PW1B+nGrQD2acb7V5YZUVXmFlHryVfcEtTr?=
 =?us-ascii?Q?6jyrMkBa/1HtedRPkP5NwEpnb3xSHz/bXoVqrNCLsyGY8Y+72Jo+WF2cHr9+?=
 =?us-ascii?Q?PAZo95hk3241KWVW/sjymTkiO4iyl9sjEsDR8u0niXSwaUOucMhXE8Mlxuzt?=
 =?us-ascii?Q?RAH2RqA8uDxsn61XzrB2lD3mruWRproRuibYmnXMWpFoORUNp2mAreqLe1QG?=
 =?us-ascii?Q?pXS/oxvU/7ZXXQ7YhC9mRBBNRJbSq0yUXEv2zQG4wFOxjtP9yMsDvOsI9Q1j?=
 =?us-ascii?Q?BySLfNvcxLNa2Lu+s4mIjBOvUSTrnNLHRbW9P4pUe1l10B5iLeue4gTOJmgN?=
 =?us-ascii?Q?0hrWUHXWfCAnAr0aAeTvFCXKHyRtDSsSxhhG87gUp9q0iO+PYLxXfiw3UHOX?=
 =?us-ascii?Q?07IKg+BF09wCKj4/YQfNB7CanWPQEz922OpSdL/Wdq/Uau2aDuvkDtkavbH4?=
 =?us-ascii?Q?MhCpoQQ7YgIn8tCven9oy+Ai4KoJFsOsvgdGZMAQhD+gmy6D+UO4t9sI6Qy8?=
 =?us-ascii?Q?lnamHooUYxxkuwnzJYl0XQbJX5/4sUYDV+tXA+tVNzAWBxkDkUkglvtmW247?=
 =?us-ascii?Q?Bo8vy0O/UucgGC6/r5FXKTtb6/Qmj/b+tLx8OezmF8z6UPG/l3633Fhvg/EF?=
 =?us-ascii?Q?g8PoozY92wQrm4EGsbVRm6+cp4hr+hL/pDQ+ctijWfqfCNk5bNtTLLAR2RwK?=
 =?us-ascii?Q?Lq7VWKroh2m4/ZhMC3rpjZc3tNYS6AzWmnUKNGzAzu67w279U135qJClgBEN?=
 =?us-ascii?Q?JhzTK9s+1ZyRHqESsPNa2KaQsVWCNK31QA/QagoMG5r7getIRjXWUFJ+KPs1?=
 =?us-ascii?Q?P1DdoDczZkjAmqwc0UOyk4sZs3L8cs5s+QC3bqP0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf7aa2e-52dd-4116-3c8b-08dc4215c95e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:12.1059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGOk3H5FvFcKoIcnzKVCvXgmYA/Zcrr02Mgxi4VaVLye4hxBn20fMgLtQ7oblRqeTYCpuqfHR7o8c+OzmFnStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: I-XBIL4jrODivGsLvLMIVyTP4CjRwXD2
X-Proofpoint-GUID: I-XBIL4jrODivGsLvLMIVyTP4CjRwXD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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
 tests/qtest/migration-helpers.c | 54 ++++++++++++++++++++-
 tests/qtest/migration-test.c    | 83 ++++-----------------------------
 2 files changed, 63 insertions(+), 74 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b6206a04fb..3e8c19c4de 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,9 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/error.h"
 
 #include "migration-helpers.h"
 
@@ -24,6 +27,51 @@
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
@@ -73,13 +121,17 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
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
index d9b4e28c12..9bb24fd7c5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -13,16 +13,12 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
-#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-output-visitor.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
 
@@ -369,50 +365,6 @@ static void cleanup(const char *filename)
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
@@ -1349,8 +1301,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1733,7 +1684,6 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1766,18 +1716,12 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1843,7 +1787,6 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = g_strdup(args->connect_uri);
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1869,18 +1812,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
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
@@ -3006,7 +2949,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
         return;
@@ -3027,9 +2969,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3054,14 +2994,11 @@ static void test_multifd_tcp_cancel(void)
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
 
@@ -3394,7 +3331,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3372,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


