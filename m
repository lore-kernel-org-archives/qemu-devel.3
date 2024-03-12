Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF8AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4ru-0003KA-Ai; Tue, 12 Mar 2024 12:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rr-0003JX-W4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rq-0000j7-2i
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:43 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C8KOtn002774; Tue, 12 Mar 2024 09:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+Y
 Nc=; b=fkx0rvhJARfP8Mdkl2z2n2War/q17p9T/5CQnccUBmOfca+8ejE1zg7w4
 Myfviga20sTO7xA8b48TL1k4SibOHH8oOBd2cA1OI+xSd3ftynfx+phxRWxbc38B
 BU3F+ITword0VayNKQ53oLTYbxhkQu95bWzUbIv1utS9m+LUn1wzDHJWXtftZ6P7
 UQaUPd0wyTpA+UARvB2c9hwDY0R7T+4/tu6y6QdUQRvswkf/Iz34he5EHcwkPf8N
 BtGUwkH3RDDGAHDDKRaDIju0+9e+3dRaY1j9W3QqlLBNFKa6u0rmblzWU1L144Am
 TeNibaYWsDZw+zhpLN2Ad89Sn7HIw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9ph0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecLjdD0llD9dv1XpDpXRfLrze32a1+ukEd0zOUQY7++M+SpCsYeKHOBfUsqfb2TMIyagLRm+DNz6dTogIA9b7gF5e/z0q1LkdHvaCQ8UYIHzbQ03o7MDNiU7meGC3lVQnsslxcxzgaGHq9vMbOQE6sRtYFwgdMtTzK1dWWcqlqwjb2RFrgKOf4h+trmEPPEC/6kmzvyXl6K9Yk2j7aLnAGqRtwM/dXoIa5Qg+JGlg2iFy5CaH3VePd3rNDtYU/cGnhG6VTz8dDHZ879tPMZunPsY6LurrSQic0mCItSG4kCJu4NW5l7n0BCqM2yBRnXr+2FQ5miepRq0Nk8GaYqNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+YNc=;
 b=dURoTgpTVT2lK+GAg8FJdfvmZr4rAXCdgojX0p3kdlskyzEMgkDXhEV7+KJ4I6fOd3xTGyFT+uBTfhGtky1Idj6f3neBexnLRdBXakx3xeLhHhO3eOFJbLBYgZofX94ly/A7bhTpokZbFvbqjUxuYQh2lytcGK6iKuKI2/iaiQee2fVCTBiM0Uz4/Agvv2KZO8qGAgELRWS8hufDc8dCRtemi/T/2oIgzbF20YoSEHcPf/zFJ4R1eH3L9JRoLdysgXC/DKxMUXQDU1WyF0+Tc4/8thu3iA4CKCnZ43LKWixYBKDOL3aBp4UpkwfDkqUPl8SYmB3rPEQ+zNip4CEr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+YNc=;
 b=PlZ4+9r7S9HB566jR77OQbcsgSDowCxfTriwrnRhdhyYbu7FjHrgC85BxJW0muKqC6KmMvPWSNduiPeCoE72Hin/JnAVeMtQStipag/SYlRTyi4VdqT8YZSdONElITB0DhsOVtCn4fuqKjTQ96xtM1WGqW/HQE5Cqz/OcpBs8n3Q5kgq92IE1R4R5JL29txkOuyBewvHYz5AqCVOWiUu598yZxW0ZXOThHmP4oXPNj9A9ve9YW7+FTTX60if++kUF/Ui3RayH2QkNFSEuTVGlVdYSACuV6QJpspS4k+d4qmnUg00ml/TMVT/r1qIx3DwgQi9clKLR8cmdd/ialeHfg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:38 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 5/8] Add migrate_set_ports into migrate_qmp to update
 migration port value
Date: Tue, 12 Mar 2024 16:20:22 +0000
Message-Id: <20240312162025.44212-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312162025.44212-1-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO6PR02MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1f12a-ff22-4fb9-42a5-08dc42b05a9c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldtqCLlj7dsRPCLXqguwNNhuMuODMRKtL8SSHdTjozoLYWWQQV9gdbM2VmWAWSrvCZ9vBgjrq7EnU/H5oXPIyIB64XACYu3htdMBumWo1WfUrLhbAIJzM5Ydco1In278nV55omAFyRJ8VVjfcu0ImYSG5szZDJsLn9NQUBm8v6zKiaAJEO965rEWJuJAcCNG4r0RCECMHlXKE7u47COAeg0UZkObRvGjEpunDxaVRCo8r5isnkVhBbggAxjmEBklWYcOKxVpS8e8kO/DI9rmGo9EQ+jF4dvv1QQ40YCeZFos5Oawu3u5ScLv7xs/LgUS1AKZv02gLndj71q2/vSz1uR7aNSByk9fcQWUMvEiNPEatGCFDsnposjGBtlTZmHjBxIcdPqQYyLJwbn/g6KX7+BFX/qNhWlo9Wli6HLboFB87jYhssedc/oUmcJfHsS3VDTTt5PkzNMzusQ011qrItgZsuD4XCpdga79tOBPqJrdmQrXHP+sJJ9pTDfSYgSpDZ2jhvFY1ga6ITsHJnXKUtuicrfgwrg643sfstoA18mKuW+PyvG3aYN/Dd84mdCi0JiQ9e4Gnn7BFWVRyCMSPNsuufT+KeUHHoaCbCaKbYtlaBAZrlKtj7W01KC9rDwNuHZIRfhMR4D/ZHvX/9f9sQkzX8z1pAaNY+n3cLEuyKE52r7KS2BlfQ7q5ol8q4WbbWNKmLRn0h9Fg1mahbYSB54t3VV6sISoeW/oQU8j00c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPpqUhBxq2fdkojhuEMdhRn5Jf38GLpo9/DOoChXg/gYEQ2bWmnMt8Tln6p6?=
 =?us-ascii?Q?4NZ6D5ExolX6nJYxIM9RgbjUEkKUAh1w0CZTU9H80L3ao+zPOuQ66A8D5Vds?=
 =?us-ascii?Q?lPNUJkx1DEywYgCw4/l0VPcFKdDPPmb7dfW3TLO+OcGsnPlMp9K5+l7OPCIG?=
 =?us-ascii?Q?Mv0hgbUNrz8kYZpuW+NV5u5dPCv5WQQrHxk2LcbYpXajux0SbRDlR2OuvjkY?=
 =?us-ascii?Q?V0MyX9awnwVvxXN4DzUPU8Dfmm5h06fTo1fVo6K5DIgEVRoEr79g9m/5n3oZ?=
 =?us-ascii?Q?1s9vOXdl45n0gRjLET59awm3uGtjUbCmJhJxNsOWubj7ZxiI7byEylyzIxgJ?=
 =?us-ascii?Q?Nxgf+c83Q105sNHMN+oqN8yTjguq9HXaY4mOkO24+VsyWZxgHtP41x5Xu+rH?=
 =?us-ascii?Q?usdOMgEeTdJ68O+OXYtSZMFo4vlJgflzzEPgQdtVWkn2JxPePxVSeYRTEjKZ?=
 =?us-ascii?Q?R0yRC5OSIfFrRCk0lvwlDBqVSkZg3LPzs5czdHg+Ui9MM99N4F5CD2UMz1sr?=
 =?us-ascii?Q?sXY/47EpzMfMkrWawLR7pjmITE4UBIQPtqPQQ804AZyBpLBDjbDnK31/bi61?=
 =?us-ascii?Q?KzsusfHxUdbxusjCBjcgC1NSAdCqwz03p1KGrOWiXrlNQpE0wpQwqMOW5MoS?=
 =?us-ascii?Q?oMKSM0lHcA1aahgOdT8bajAEPi3NyFCp33IGQ6Ba+QEurpG37l0kYwIrlAGB?=
 =?us-ascii?Q?Nejrfd0uiA/Xr6IR92+CXFUJlyzPfG75sxDfiHRO79gqFKEnSY3bcshnZe2i?=
 =?us-ascii?Q?nShoovqe8D6NKviRnmUZT19vemkMOsaA/gTwoPu1GSF3NTe/G/KRHRhtE2XF?=
 =?us-ascii?Q?mymYOig5Ew1C5zXGP3kaIWMHB4HinVpNzMHd37IWQm0kX4QhkQaS5hQXC2je?=
 =?us-ascii?Q?p6IOsX3uuOCSO93MjoJQkyxlbUdWqzPnyxa8R/TyDdZedDfSSzRPszzh2BCA?=
 =?us-ascii?Q?lGu+yjHbzcz8i1lasXcE9T/DpcRUeijow8HuDQiw13rcOaOXhAKDanHy5vY3?=
 =?us-ascii?Q?Jwip8vkxyxZnW5juup+8PJgpWNJAuQtYWZTNei90gv5gL172JpWYEPPudKlo?=
 =?us-ascii?Q?DjIKzP/awzHnYZML0Qbpbt9V3wZeLvL+WSF2zHOot8JyT6RSgTZfaAgMJqaZ?=
 =?us-ascii?Q?RvPCjjmLYB4ytcLJPozXcqptudoEwa0/bLyeGXD/QX645lTdGXyJrQ9cPDRA?=
 =?us-ascii?Q?8CvySbxPXPPJ5zHhc5dAORjUWfeJxO4ozmvoIZSC8hpHg9Tnzk2VDxtfc+d4?=
 =?us-ascii?Q?5yiKiD4EQlF3EY9uKj9LLJRM+0VUPRH1V0MhW6USj6AC2OprLR1YZs9NKriA?=
 =?us-ascii?Q?oljg5GchDyVPB/2ceVl18MdtGz8I/B7xag7s/k+EutibGwGoTFx0WhZIvnk8?=
 =?us-ascii?Q?wqUMu2DrRjOvH/23hIdGJ3SXqgwa5MXYDFdmNhizvVO2x0JvNWKS8Bz4tdYW?=
 =?us-ascii?Q?JQYhzzk8keYCM5zFDA6RcN4cpM5un9YUW6CuCRW9OSgXbano1Pb0soonn/GP?=
 =?us-ascii?Q?qWPMkv+kl2bY8TQGcvOyXTGe0qoxgYTEU3i1S1SuPEXosBbJrocjOlp0n+1S?=
 =?us-ascii?Q?Fk2r6u5ql1zv21cFs31IarUvhqHtFxKI5dqqoUD2vnQ30g9+P/xRR0KmC04t?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1f12a-ff22-4fb9-42a5-08dc42b05a9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:38.5869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2ySMO2+dXd4Whplu8br6XtmqoKot7RvYhakdeuh0fGffZvXfs9mCf+sYWU0CTgKI2wBdd4MWoRN+UH/vT5flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-GUID: ffVmO5Gh4NGW3iNJxbjZOwK5liM_yPru
X-Proofpoint-ORIG-GUID: ffVmO5Gh4NGW3iNJxbjZOwK5liM_yPru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


