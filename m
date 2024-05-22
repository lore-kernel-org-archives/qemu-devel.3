Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8859C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ndZ-0003l2-4o; Wed, 22 May 2024 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9ndY-0003kg-Ct
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:12:16 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com
 ([40.107.20.137] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9ndT-0002kp-QR
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipaXLiYQHgXA3cZEV2KUAeJum2cZcUi7Q88zn+3cBQSJz4hxxxLp6JBt0x9qgnnBSSCk10mGoHDp+aTOxYR7n5J+Cx0HNVawx3kYlBSXlLSkbHQOJEFwDFMcMSQtfKxjDijzmA0fTIIaqcV8Ezw95L4jX/CbhHxXY43i7fJCRdsP2XDnCZw+CXPh4HDXdLbrab0WiI/cNqOp7SDun2lzXYl8qZr5T3FUBPxRtQIY+KQoOrBNW5HrQRJEi1B7hdTneAHVuKPEo1RZDJffZddD67ZoxuzkCcjER3QXnldApF+13D9Bp2SdAJ/4hnUW/zd7h3rGEGcH+VOBnbh5KaN/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+C5aG2ZB63y4k8TLbvmzQsjcIYfSfITGu7DGbvZNiU=;
 b=GDgoN4cvswaaGE2Rpb2AJhjI5VYQtLTFIDbz6nyByvqUxWXQ98bydBtJ+nuW8+JX/UxqXpfj7QmHC5lmEszbWZbqHJl7kUHH3RJkaOsk19+pYshSGJ/gydrHpfPmjKmIt00eOq+AAwj6R0zxeazQjbWCua2ARRQ+BHOv93jY4OKyaxLY8A+dY/rtqDJ6e1RDvrWc5srE6xsTO4GlxqEfPY3MzucDSUzAuQqt+shNuCTIpJH17RINOpQwdcpfuI7UD+OhRCQ7+6C79+4u/zZ0mz9y9bIw3/MT0wcF24R0hNPVUezxXFe8JT3bJalJl8pYVQdTJy9fZR2mc7XY2us5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+C5aG2ZB63y4k8TLbvmzQsjcIYfSfITGu7DGbvZNiU=;
 b=FCS9sX/eGdICfj6/fZtfoiLY6jzqWC9eUcNozP3L154OS2+9E3DJB0hp64CLm4rIaIuXVwPbLQd8FWrk9LepvsvoDfr9wvc8jbwy6WJFZRWqi5aJ2NCCledyTbyWxCUGNVUby2h1MUBxHBUPK/KvyhtSPuPF7CMY3+SFnG8YnMuiP8K4EGD5n6oJQQIyOK8p4ILifeqXUlCftonkaFLdY0HIFxZNODot2yXAncH4bljDU9jZevlO3fYR3dEG5UrUBX0v2J6JHZhC36OIaTlqh3RF44jM2I3sgTFlGQD4xVUi1Sn8A237oxeBChSbREJFC1csQ/rL6WVe4xR1E4/Asw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DU0PR08MB8207.eurprd08.prod.outlook.com
 (2603:10a6:10:3b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 15:07:05 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 15:07:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH] qga: Add an interactive mode to guest-exec via VSOCK for Linux
Date: Wed, 22 May 2024 17:06:57 +0200
Message-Id: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DU0PR08MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 882a0ee0-b06b-43c6-914c-08dc7a70d79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|52116005|366007|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1F2Ykct5vUpVrYb6Ltsf6+OXXV0NZZ2Btmb8fRcSMvHwIGfkYXwMSoJeR4z?=
 =?us-ascii?Q?YKzxlgmID0/lisw137fE+cnXA3iQMVHS3s9oyX+kmpVf6jvkRRlI2ot/M3pO?=
 =?us-ascii?Q?iUM6GLEX2SJxOnBlaEMNP/vVUL2vDAGAay5LuylsgagdOaqlrR0gJtwO/lKS?=
 =?us-ascii?Q?EalF0wknQmzr6knFw+RYBh14ymUByNUn1qIhIHtTMbMvmZ8z4sibUPR4fguV?=
 =?us-ascii?Q?zwzepaYCEFLW1FMsWoDNpcKKC3ScKVXm3/MN0UBD+0RDaZNnBYT0AZPwRJEF?=
 =?us-ascii?Q?P9gY4/F6Gbk2wsh7pPqKrnaZAkyGcIlrN0xF5DSZYQEGgDw4WDMDasHn1Bvj?=
 =?us-ascii?Q?rVnZv3s35Xjqcey6oUVw4/pUDX/4g5bgoW04tJ/wCPbObN9e3yK24bfh29sn?=
 =?us-ascii?Q?zi5crui+SwjOdDdB4z5ghKhxOwcKOTD4hMyQLVxBoYTrxjRFWxfixSFYAffx?=
 =?us-ascii?Q?uwcgr9I7TRMmr4f1rTJt332ijjostaAWi74Qr6V6r2yxOE9N9MjsSVHfMl4H?=
 =?us-ascii?Q?Ok15ye5hIC5MxybEINRzvSdrdkSbd9yKWlttHcrpdGDGnExc7vsj43XBMjqa?=
 =?us-ascii?Q?jS98FwEs9umjPAswqxU1qv7pfw0Eq5ALZBzLj6YnDqhpP2gpTbn+F8WAtaAa?=
 =?us-ascii?Q?Y6DV4sf9TVqycK9Y3bqrg0y/iDZFrT3Cj0s6TmCunrvf0dfnPkprqbByNdPR?=
 =?us-ascii?Q?gBS2OmLLppv/vQzv/CwwNgjJy0x3qZ7XplAhAfmvmNa7zVsYuwwNoAiBcVQZ?=
 =?us-ascii?Q?bYJGP4MtqjOJzqmwQbhJEZlD0hGDPRwieKtLlKjf75gjHOH8VqBFTgvSjrXW?=
 =?us-ascii?Q?6XM2HPSHk9rS3RxTc2EpCn10CNdjGYUnedvAR2gSAFSOcXFbudFitrhU1AwZ?=
 =?us-ascii?Q?AvFOEomgRgQzi00mQ44n36/zq/GBTCIK/kPkoS+mS6erUYuWuprPfnCPDR4C?=
 =?us-ascii?Q?hPhvhQxW0om68wOh+jWo8BBshV8IDj0LeFOa8fiy0ZZrefnjKpwBAqesSnku?=
 =?us-ascii?Q?NY4S12y+Wo60bcoEtqoMt/o6SI3xQWl3T4HopBHHInyTcJieCfV5aoY8JeRP?=
 =?us-ascii?Q?Gv0izI4x4MkYwprPedV9wJ6+DgExgKDra9O/UuTdf7h9KV+jeTHZ71ihxSx5?=
 =?us-ascii?Q?sO+c7aV51eAjnk1O3g2p+oiYg31tjxvNMTeHZUUSAN9AxacMs3o+sErYAWn9?=
 =?us-ascii?Q?GT9WQnE/aZOLk1eVAqRdF2WEhAwCcQDgdZaouqb+pVXwYyf/7EIXxAw2tPRk?=
 =?us-ascii?Q?x76ZFEjyoAp+W2whqB6TbR2Ai/whrhEyCmniEN3BPLRLw2atKXxmjcAGqUMv?=
 =?us-ascii?Q?3YZVJ4c2kLrgd4D/OKsiOPGMiE4f2TOKS0weEkQO6bSyQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29zaXbaz+XoauW9eYYHBVT/7NgO+jTJ3q3+/k7q7OxOY8QUon7ewQneVJFs0?=
 =?us-ascii?Q?b7RL1DwmoBqmWBDUz/g5gcwdgDhvw3+I8XDDMaYr0DwV+ctVdR5A42vQR9/X?=
 =?us-ascii?Q?X9RBbXaKWyBDZScdtpbMgHI6qKrsU7dWmOrc6v4gZZoxIpTrmLof2FO5RsG9?=
 =?us-ascii?Q?inZw0wTuo4MuaDxt2ysgOrMHffERgaF7TU0/Ya33Wiwo/QUuBgcdSaxcE2xZ?=
 =?us-ascii?Q?bMn6wz+YX8/PVD0ySueJebhqCFjv2/BjpDTeVz9D+x3yJCQid3pfOsuqGKTm?=
 =?us-ascii?Q?kT9sUb2pbp48zLJC6LcV6GgKPmGHHEE3byVGbEoq0FR98dclmzHOH+4BydTy?=
 =?us-ascii?Q?8TKgXRLaJfqbXCtkWoNVIGhBTsBj+lsld55Fc5S94f3BlNiKhmJe0XSz/AsJ?=
 =?us-ascii?Q?G2K8IzkDkdaO0zY25j/0AXP3IrQgdHqUiWyfks7l1lM6oujwU21fWYN777dG?=
 =?us-ascii?Q?3l/jTgrEzUBGRbpZ+8L8Yqso4M+sFO7tYcQREscKR3WZ8afCdj9M4cJtwfCp?=
 =?us-ascii?Q?gvJLdKyR2WbCUvuZapIEd3KOLx2wntXvfrGMSQXc/m4T84dJCMihbCEnLiaN?=
 =?us-ascii?Q?yc10/SMoavqgF81nRma/rZNgtnpDLUFgi+ngyXvEs7MrEkGZSa9Bf8nWgaMT?=
 =?us-ascii?Q?itpDXZEtLj6CT6ZCnhPLfGuElnMEXT+ur/MzZpR7/yKwiuqMdlzbBPPIZH+x?=
 =?us-ascii?Q?FKXwEa+jNeQZDNk8g+1LUEg3AXiPzljs5yeTloOTE9IILbK0z1I/NPUtGZ5W?=
 =?us-ascii?Q?NCTfX56Qb5SY2m0U8Mp3Dy8TRGTLrrt8wZF2HET2YMVf6TUCi1yabDxroGDj?=
 =?us-ascii?Q?x/2b7uTSksBVlqy3kIyp9oJ1hKKoDQSDn+pvXC4IRz7H/czUvvD0eLaOzno5?=
 =?us-ascii?Q?Nts9dAIFjI1notwt0wCRpGXb9uFoMijCBHghU1FIG+7Xh3DgPXShXVEBcR3Y?=
 =?us-ascii?Q?4CgZs2FMlcrfA+4RMaVAM+bb75dATWRQj4nM1blL6pgiJGmolNnn1vxWqnXc?=
 =?us-ascii?Q?5Q6ElajT16ngT0aMQWzUr2J25EwbU/z1T5bPhEtMP3txhbjmWUyINjzyfzGn?=
 =?us-ascii?Q?62aZ9FHmL0Xt/b6I26LMsE8IK+X6J+FiUelrEqFxaLNbixQaHwfygAsOvs01?=
 =?us-ascii?Q?UT1CIRNeZatwJJaiiS2m6UG8qzweHBDnSs0H5FMWkX2VrybGZjyTdMgqCeyt?=
 =?us-ascii?Q?3UX+TSQdSnA7TA34rTsecdneiSyT6GMfhRd4GCLvIDLqpsoKHsgOIDFFgi3V?=
 =?us-ascii?Q?kKdYeuH9yGrJJGhZOYM7eOAKzqdKE+t0xET6sqDGuc03BykvARCuxoRQH/jL?=
 =?us-ascii?Q?snrXFmuhqczc4TB8TSNgoun47adaA4IUKlvOK80Vkvtn7rgTLXMhCnqoli+T?=
 =?us-ascii?Q?58kSm8aWDxftJog3fxXkqumvavIGxSlM41tFPZYmsk+iGprgElwKzGuDkWqd?=
 =?us-ascii?Q?5Bt+HAptnpPk9GA6gZwGOg6JBB59vf3gciHrTGCYZGrjo66hIsNmwWWOpP7n?=
 =?us-ascii?Q?uqc+3UZBd5ffPKKBOVLmrCrNTUEW+ICUa1D5aUrxiCa5NKLVYIU6QFMjFqZy?=
 =?us-ascii?Q?x58ViUnGLewb3tmqcdonGMsie6BLTzXYgjcJKCTiohKFEi8r+tvTm/bRWcAa?=
 =?us-ascii?Q?b//U5xUbTYQvtynkLG71c2k=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882a0ee0-b06b-43c6-914c-08dc7a70d79d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:07:05.3637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD90phvv85SIpaind7emHZ0JRAANFoicvqTDtsf082zVT5ceScYg/SjBudvdqP/gm6YX3tFY6BED7Sfs+YoK6oZHk4YmhV2FDnxU5uTW3jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8207
Received-SPF: pass client-ip=40.107.20.137;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an interactive mode to the guest-exec command in the QEMU Guest Agent
using the VSOCK communication mechanism. It enables interactive sessions
with the executed command in the guest, allowing real-time input/output.

Introduce "interactive" mode in the GuestExecCaptureOutputMode enumeration
and add optional "cid" and "port" fields to the guest-exec response. In
such a way user can execute guest-exec command, get CID and port number
from the response and connect to the guest server. After connection user
can communicate with the started process. All the data transmitted to the
server is redirected to stdin. Data from stdout and stderr is redirected
to the client. All data blocks are preceded by 32-bit headers (network
byte order): most significant bit contains a sign of stream (stdout - 0,
stderr - 1), all the other bits contain the payload size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands.c       | 272 +++++++++++++++++++++++++++++++++++++++++--
 qga/qapi-schema.json |  11 +-
 2 files changed, 273 insertions(+), 10 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 88c1c99fe5..377a79c816 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -20,6 +20,11 @@
 #include "qemu/cutils.h"
 #include "commands-common.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vm_sockets.h>
+#endif
+
 /* Maximum captured guest-exec out_data/err_data - 16MB */
 #define GUEST_EXEC_MAX_OUTPUT (16 * 1024 * 1024)
 /* Allocation and I/O buffer for reading guest-exec out_data/err_data - 4KB */
@@ -92,6 +97,27 @@ struct GuestExecIOData {
 };
 typedef struct GuestExecIOData GuestExecIOData;
 
+#define GE_INT_IO_SIZE (256 * 1024)
+#define GE_INT_STREAM_MASK 0x80000000
+
+struct GEIntPacket {
+    uint32_t header;
+    gchar buf[GE_INT_IO_SIZE];
+} __attribute__((aligned(1)));
+typedef struct GEIntPacket GEIntPacket;
+
+struct GEIntData {
+    unsigned int cid;
+    unsigned int port;
+    GIOChannel *ch_srv;
+    GIOChannel *ch_clt;
+    GIOChannel *ch_in;
+    GIOChannel *ch_out;
+    GIOChannel *ch_err;
+    GEIntPacket packet;
+};
+typedef struct GEIntData GEIntData;
+
 struct GuestExecInfo {
     GPid pid;
     int64_t pid_numeric;
@@ -101,6 +127,7 @@ struct GuestExecInfo {
     GuestExecIOData in;
     GuestExecIOData out;
     GuestExecIOData err;
+    GEIntData *int_data;
     QTAILQ_ENTRY(GuestExecInfo) next;
 };
 typedef struct GuestExecInfo GuestExecInfo;
@@ -257,6 +284,194 @@ static char **guest_exec_get_args(const strList *entry, bool log)
     return args;
 }
 
+#ifdef CONFIG_LINUX
+static void guest_exec_close_channel(GIOChannel *ch)
+{
+    g_io_channel_shutdown(ch, true, NULL);
+    g_io_channel_unref(ch);
+}
+
+static void guest_exec_interactive_cleanup(GuestExecInfo *gei)
+{
+    GEIntData *data = gei->int_data;
+
+    guest_exec_close_channel(data->ch_clt);
+    guest_exec_close_channel(data->ch_srv);
+    guest_exec_close_channel(data->ch_in);
+    guest_exec_close_channel(data->ch_out);
+    guest_exec_close_channel(data->ch_err);
+
+    g_free(data);
+    gei->int_data = NULL;
+}
+
+static gboolean guest_exec_interactive_watch(GIOChannel *ch, GIOCondition cond,
+                                             gpointer data_)
+{
+    GuestExecInfo *gei = (GuestExecInfo *)data_;
+    GEIntData *data = gei->int_data;
+    gsize size, bytes_written;
+    GIOStatus gstatus;
+    GError *gerr = NULL;
+    GIOChannel *dst_ch;
+    gchar *p;
+
+    if (data == NULL) {
+        return false;
+    }
+
+    if (cond == G_IO_HUP || cond == G_IO_ERR) {
+        goto close;
+    }
+
+    gstatus = g_io_channel_read_chars(ch, data->packet.buf,
+                                      sizeof(data->packet.buf), &size, NULL);
+
+    if (gstatus == G_IO_STATUS_EOF || gstatus == G_IO_STATUS_ERROR) {
+        if (gerr) {
+            g_warning("qga: i/o error reading from a channel: %s",
+                      gerr->message);
+            g_error_free(gerr);
+        }
+        goto close;
+    }
+
+    if (ch == data->ch_clt) {
+        dst_ch = data->ch_in;
+        p = data->packet.buf;
+    } else {
+        assert(size < GE_INT_STREAM_MASK);
+
+        dst_ch = data->ch_clt;
+        p = (gchar *)&(data->packet);
+        data->packet.header = htonl(size);
+        if (ch == data->ch_err) {
+            data->packet.header |= htonl(GE_INT_STREAM_MASK);
+        }
+        size += sizeof(data->packet.header);
+    }
+
+    do {
+        gstatus = g_io_channel_write_chars(dst_ch, p, size,
+                                           &bytes_written, &gerr);
+
+        if (gstatus == G_IO_STATUS_EOF || gstatus == G_IO_STATUS_ERROR) {
+            if (gerr) {
+                g_warning("qga: i/o error writing to a channel: %s",
+                          gerr->message);
+                g_error_free(gerr);
+            }
+            goto close;
+        }
+        size -= bytes_written;
+        p += bytes_written;
+    } while (size > 0);
+
+    return true;
+
+close:
+    guest_exec_interactive_cleanup(gei);
+    return false;
+}
+
+static gboolean
+guest_exec_interactive_accept_watch(GIOChannel *ch, GIOCondition cond,
+                                    gpointer data_)
+{
+    GuestExecInfo *gei = (GuestExecInfo *)data_;
+    GEIntData *data = gei->int_data;
+    int fd;
+
+    if (cond == G_IO_HUP || cond == G_IO_ERR) {
+        goto close;
+    }
+
+    fd = accept(g_io_channel_unix_get_fd(ch), NULL, NULL);
+    if (fd < 0) {
+        goto close;
+    }
+
+    data->ch_clt = g_io_channel_unix_new(fd);
+    g_io_channel_set_encoding(data->ch_clt, NULL, NULL);
+    g_io_channel_set_buffered(data->ch_clt, false);
+    g_io_channel_set_close_on_unref(data->ch_clt, true);
+
+    g_io_add_watch(data->ch_clt, G_IO_IN | G_IO_HUP,
+                   guest_exec_interactive_watch, gei);
+    g_io_add_watch(data->ch_out, G_IO_IN | G_IO_HUP,
+                   guest_exec_interactive_watch, gei);
+    g_io_add_watch(data->ch_err, G_IO_IN | G_IO_HUP,
+                   guest_exec_interactive_watch, gei);
+    return false;
+
+close:
+    guest_exec_interactive_cleanup(gei);
+    return false;
+}
+
+static int get_cid(unsigned int *cid)
+{
+    int fd, ret;
+    fd = open("/dev/vsock", O_RDONLY);
+    if (fd == -1) {
+        return errno;
+    }
+    ret = ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, cid);
+    close(fd);
+    return ret;
+}
+
+static int guest_exec_interactive_listen(GuestExecInfo *gei)
+{
+    struct sockaddr_vm server_addr;
+    socklen_t len;
+    int fd, res;
+    GEIntData *data = (GEIntData *)gei->int_data;
+
+    if (get_cid(&data->cid) != 0) {
+        slog("Can't get CID: %s", strerror(errno));
+        return -1;
+    }
+
+    fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+    if (fd == -1) {
+        slog("Socket creation error: %s", strerror(errno));
+        return -1;
+    }
+
+    memset(&server_addr, 0, sizeof(server_addr));
+    server_addr.svm_family = AF_VSOCK;
+    server_addr.svm_port = VMADDR_PORT_ANY;
+    server_addr.svm_cid = VMADDR_CID_ANY;
+
+    if (bind(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
+        slog("Bind error: %s", strerror(errno));
+        goto err;
+    }
+
+    len = sizeof(struct sockaddr_vm);
+    res = getsockname(fd, (struct sockaddr *)&server_addr, &len);
+    if (res == -1) {
+        slog("Can't get port: %s", strerror(errno));
+        goto err;
+    }
+
+    if (listen(fd, 1) == -1) {
+        slog("Can't listen port %d: %s", server_addr.svm_port, strerror(errno));
+        goto err;
+    }
+
+    data->port = server_addr.svm_port;
+    data->ch_srv = g_io_channel_unix_new(fd);
+    g_io_add_watch(data->ch_srv, G_IO_IN | G_IO_HUP,
+                   guest_exec_interactive_accept_watch, gei);
+    return 0;
+err:
+    close(fd);
+    return -1;
+}
+#endif
+
 static void guest_exec_child_watch(GPid pid, gint status, gpointer data)
 {
     GuestExecInfo *gei = (GuestExecInfo *)data;
@@ -424,6 +639,8 @@ GuestExec *qmp_guest_exec(const char *path,
     GSpawnFlags flags;
     bool has_output = false;
     bool has_merge = false;
+    bool interactive = false;
+
     GuestExecCaptureOutputMode output_mode;
     g_autofree uint8_t *input = NULL;
     size_t ninput = 0;
@@ -465,6 +682,11 @@ GuestExec *qmp_guest_exec(const char *path,
         has_output = true;
         has_merge = true;
         break;
+#endif
+#ifdef CONFIG_LINUX
+    case GUEST_EXEC_CAPTURE_OUTPUT_MODE_INTERACTIVE:
+        interactive = true;
+        break;
 #endif
     case GUEST_EXEC_CAPTURE_OUTPUT_MODE__MAX:
         /* Silence warning; impossible branch */
@@ -472,8 +694,10 @@ GuestExec *qmp_guest_exec(const char *path,
     }
 
     ret = g_spawn_async_with_pipes(NULL, argv, envp, flags,
-            guest_exec_task_setup, &has_merge, &pid, input_data ? &in_fd : NULL,
-            has_output ? &out_fd : NULL, has_output ? &err_fd : NULL, &gerr);
+            guest_exec_task_setup, &has_merge, &pid,
+            (input_data || interactive) ? &in_fd : NULL,
+            (has_output || interactive) ? &out_fd : NULL,
+            (has_output || interactive) ? &err_fd : NULL, &gerr);
     if (!ret) {
         error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
         g_error_free(gerr);
@@ -485,9 +709,14 @@ GuestExec *qmp_guest_exec(const char *path,
 
     gei = guest_exec_info_add(pid);
     gei->has_output = has_output;
+
     g_child_watch_add(pid, guest_exec_child_watch, gei);
 
-    if (input_data) {
+    if (interactive) {
+        gei->int_data = g_malloc0(sizeof(GEIntData));
+    }
+
+    if (input_data || interactive) {
         gei->in.data = g_steal_pointer(&input);
         gei->in.size = ninput;
 #ifdef G_OS_WIN32
@@ -499,10 +728,14 @@ GuestExec *qmp_guest_exec(const char *path,
         g_io_channel_set_buffered(in_ch, false);
         g_io_channel_set_flags(in_ch, G_IO_FLAG_NONBLOCK, NULL);
         g_io_channel_set_close_on_unref(in_ch, true);
-        g_io_add_watch(in_ch, G_IO_OUT, guest_exec_input_watch, &gei->in);
+        if (interactive) {
+            gei->int_data->ch_in = in_ch;
+        } else {
+            g_io_add_watch(in_ch, G_IO_OUT, guest_exec_input_watch, &gei->in);
+        }
     }
 
-    if (has_output) {
+    if (has_output || interactive) {
 #ifdef G_OS_WIN32
         out_ch = g_io_channel_win32_new_fd(out_fd);
         err_ch = g_io_channel_win32_new_fd(err_fd);
@@ -516,12 +749,33 @@ GuestExec *qmp_guest_exec(const char *path,
         g_io_channel_set_buffered(err_ch, false);
         g_io_channel_set_close_on_unref(out_ch, true);
         g_io_channel_set_close_on_unref(err_ch, true);
-        g_io_add_watch(out_ch, G_IO_IN | G_IO_HUP,
-                guest_exec_output_watch, &gei->out);
-        g_io_add_watch(err_ch, G_IO_IN | G_IO_HUP,
-                guest_exec_output_watch, &gei->err);
+
+        if (interactive) {
+            gei->int_data->ch_out = out_ch;
+            gei->int_data->ch_err = err_ch;
+        } else {
+            g_io_add_watch(out_ch, G_IO_IN | G_IO_HUP,
+                           guest_exec_output_watch, &gei->out);
+            g_io_add_watch(err_ch, G_IO_IN | G_IO_HUP,
+                           guest_exec_output_watch, &gei->err);
+        }
     }
 
+#ifdef CONFIG_LINUX
+    if (interactive) {
+        if (guest_exec_interactive_listen(gei) != 0) {
+            QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
+            g_free(gei->int_data);
+            g_free(gei);
+            goto done;
+        }
+        ge->has_cid = true;
+        ge->cid = gei->int_data->cid;
+        ge->has_port = true;
+        ge->port = gei->int_data->port;
+    }
+#endif
+
 done:
     g_free(argv);
     g_free(envp);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d5af155007..77efa847af 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1262,10 +1262,16 @@
 #
 # @pid: pid of child process in guest OS
 #
+# @cid: context identifier for interactive mode
+#
+# @port: port number for interactive mode
+#
 # Since: 2.5
 ##
 { 'struct': 'GuestExec',
-  'data': { 'pid': 'int'} }
+  'data': { 'pid': 'int',
+            '*cid': 'int',
+            '*port': 'int' } }
 
 ##
 # @GuestExecCaptureOutputMode:
@@ -1284,10 +1290,13 @@
 # @merged: capture both stdout and stderr, but merge together into
 #     out-data.  Not effective on windows guests.
 #
+# @interactive: stdin, stdout and stderr are transmitted via Vsock
+#
 # Since: 8.0
 ##
  { 'enum': 'GuestExecCaptureOutputMode',
    'data': [ 'none', 'stdout', 'stderr', 'separated',
+             { 'name': 'interactive', 'if': 'CONFIG_LINUX' },
              { 'name': 'merged', 'if': { 'not': 'CONFIG_WIN32' } } ] }
 
 ##
-- 
2.40.1


