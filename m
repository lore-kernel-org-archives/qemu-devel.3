Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993A2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkH1-0006rd-6D; Mon, 11 Mar 2024 14:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFJ-0005e2-6H; Mon, 11 Mar 2024 14:19:34 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFH-0006si-8F; Mon, 11 Mar 2024 14:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh8oHzXfPG/oSNLNyrPicB2vy2nYRImiCJOcndjYZklEeqZ/CrjH3xAUojRC0ATL7l2JrmVlArtrwQ2Q0zZH+2ech4sUNqw1SdIV2jL9audqTP9dQyRQzE+AeTOcrugGcCIZiHVuEo/Ke6c5oRxN/5AM02bP2n4JLGRMQFNrwwJp/7Ic26Rn97J5mpnqzwUwPgxbF4n21hR0vfFkqbBC3Ojwdc66mzNvWSHMtmPm1sFp2VrZbqEmo0/0q6ow762qgdxB0KbXw+ONIW9Oj0aPHLP5Ew7JQCutADRz53hBjHL+5qKTAIWsmY0RoXhp+33yp9BidpRtrqiPk2i73bcaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2/qOJFZR5+427Me3LXfCeK5ZdwEOw6KH/94DlzoV4=;
 b=eg2mXXlw72uImZww1jsx912jnSBy3jlREgOGmIasxrjx6b0dJVHHw6LnJB6U0L7RRMTXBcF6Hf4nFXBQnmZwSK0cvXo8JdZW8SWxh8n0C3n3kH3T8JZe1gzV5Y8Fx5ZTSMa02xrGt0S1m5Dm4s5vvXEXXDwrbSgy00ih3/+pC9O1g/bTyCukxays1d+h5uScI+mG1fm8y/B89j/1ngclzYagxMvNAKyJGG0I0OnS1WjEl2bOVDUEqpaVxjNXpqKXOsKzpAnVxi5OtIk0KSzzFyDKRsR66sS/8pjrSqPBEekeCGNHWf10xMWsJfrOxfW2HDKC5nCAHxCdAb+m6foOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2/qOJFZR5+427Me3LXfCeK5ZdwEOw6KH/94DlzoV4=;
 b=tKPnVUimToPfvIswscEWLoIjq8/Ja8Kp9GQhQQ0hRCKgQMlnI0RfmfC7T9tDTk0eay4uNyNB6Ve3YIYc8Zjqvzt1vxaIJxTdQzmZTqdwzRR/l/RpIM1MuRPiM614aNbMRu2AAqQasjx0kFk8+axSztLg/E6186fRRBIcYVia84pGG1QhCH0g9uOhecM/t4ng098kZeFWSqb0S0UXKWtgcG/MYfOIqHUWJRzIv3uRJDOhIeKnI90bLbY71DroXrAh0fIoTQKQjjqy2dDx+FHAOhfA6QtWiIavJDbZ+Ly5strfyBMNLTAgt1w2qJBWHkNjrwGH33tO4wSG05X3XMA6Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:04 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:04 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 10/22] parallels: Create used bitmap even if checks needed
Date: Mon, 11 Mar 2024 19:18:38 +0100
Message-Id: <20240311181850.73013-11-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f814a5-f990-4a7c-6e7d-08dc41f7bbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swVmbJl4qs69gFhkuf/H+UUfFpvIizUF91yolrSdm0Qorm+i/IOSUE+vQNLGOpjQx1rYwCa/L6JG1PWOsNkNbeG0EAu+26pRWIV2Kok0hTHrPN0pzkh1p8QAh6NlLqKxYwWkZKCqDLBCGFhEJlieU48DZBnjy6y3qu7Hf4AtwddGjVuv7dLa8KkB5lMPvwcWZbmdkiQf8Re7fASEKC4gM3dmyw27vuiZ6cJO9Z4cLqxynLLZL9YPh4gjY5BM5CNuZ0T+Y2Xq84Ss1rguT59t0esX3xdcK8qVkFy73cQUYt3749sU3F9cNvaeqeUnSvSx2kixs7NrsErAx5FHlfm7Pxze5k/VCAwZtoUebsjpxG80+Sp/xMiQD4qm5Q47krSxfksAIINZczZbHoeS7KDoTpLhD7B7AjL6fINVyzRvLlmJl6hNr6CcfOyUEJj0lLcmlNEJ/jA9Oa9On8iDP+zA0vQfM0Zt92fvebFbZ+kYW67GPCqjfvs4v4zDZsFeejfhKK+HYsV8F+vhdCA7Iu2Jm15+jGA7OdUKy7jvyx57Obxe/3hF5LY4gxOKmJhxa0YdlJsvGa/TGaZM1/gHid3isbqamfYqIV4kHTIUnio+IEtYFoqNFK3dlLA3aUNouZPqtyQkcINOg9un8Xr5BMnrOk6kisB+KMG6WXCgs55Hi5LLa+aB9b3QGAaTWniQTx8558B+ndUJHaZS5sadmqlkghsBJGrRl059jRrrCFcIbno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eG5T9KumuyNVk6aRIfeGBtMRbOXUmlk+mcgWQ46YeO39W/GgudM4HEynKnzp?=
 =?us-ascii?Q?4WoxvcUfB8WOenFIdafXopTkLvW2N7uYT8ZFJIbCt2NpjK/k9rQQ/uW5B99w?=
 =?us-ascii?Q?pNYomD+nVJbMpF9iWCjJ61BU7Cp4+v2iG4lON4JELO7OIC8nr70xctEJtyK1?=
 =?us-ascii?Q?nsPKCTtrTF4S4QpGddHe3YiLE0rpg3Grs13K5XHa4Pm6iCtEeLACbYhb5PWD?=
 =?us-ascii?Q?U4JAmOZogBj/VFrMX/GPhdNSMTnK+v07MPpRf59pbjnjsAWCK/6BONt4UXZx?=
 =?us-ascii?Q?4UrlXp9NOKLdDZi7lXrATBR6OB5QXIwtkBez32wrMXvOnRmaPLtib/Ej/tUe?=
 =?us-ascii?Q?OZEFDP5UDVF6nzbSJByxMzDqN1ILgZVB+LqM1eMqI5q3ieQ20b9YnaKRZhbA?=
 =?us-ascii?Q?sk+9Iw8dcWuiA7BACDVZAc5i8jgh1+QaznYcsbyx1Bp3xUAOflCXCk1qmt9z?=
 =?us-ascii?Q?vxFeW5E15wRuNjUBOYTE7WbKF1mXARejW2WafkgLcYawW53gPC1yrVcb0Q/Q?=
 =?us-ascii?Q?RXOBbmrIjeRC7xRRazuUS5i0Uvklxab8H/leRFF+kfwIacHomghI8GyHtjgv?=
 =?us-ascii?Q?Ji0eHb2d6hiNKqR6mX9eIL7a7wREt0pY2iPb/0abMBSbQLj3U6e/1GcwZy42?=
 =?us-ascii?Q?w42XGBRvjMDaqLQzKJOtHw+stsokQp1nQ4IEjVreMfsQ5VeywLBbcAOU2paW?=
 =?us-ascii?Q?wR/GSgdf0rgeFLfVxfoSDb3YZFhciykEgicYofmUvDVEh8RaoSVdHzbfuZtl?=
 =?us-ascii?Q?Qvh/bDdAdK6FJs4W262OD7pisHRWGgvH02iyIRDL6yUMtBzj3Z/jejGvzUIP?=
 =?us-ascii?Q?FUaUVbolZXX9c7wGKgnSb5JMn26HGi0j9pjuD2TDWOsZnluAbqF4OgB9XLZm?=
 =?us-ascii?Q?I1ZGnRl0Ym8A2jLD0yxBCA1tzVrvS8lHFJrG2dTweBc65JyOLm6hTbK5xQJD?=
 =?us-ascii?Q?AInsLjEKWkEXAaZdI1AjEBqaDREyWyb+Rj12GlMyHJ8Q2gUHzBW13o2GOG+S?=
 =?us-ascii?Q?xrNj00/q6lUqjyZccz+A0MRurfztIyT9os4djA3s7ZRcWf/Pw3ugThcFOA/m?=
 =?us-ascii?Q?MMuaBrpjAEdbjCFKlcrR9WKqy3G8k2GRORa6FFS3O2PdF9MJ5pphwsEuCEqX?=
 =?us-ascii?Q?BSx3PYlCyRqO5vYDBiu/TEv308gXMqcMXwb8oHr+kFPO3ykhGp/APFcjIEBE?=
 =?us-ascii?Q?k5TafNep2/uG85RaVzlFJion+/Chfk8Yr5ICnCHRxFtGp1UhTBditjizsgf1?=
 =?us-ascii?Q?J/AMYtbBmBFrEMYw85CBVlzUI6u63nFC1raOEVtT0jkYO3m3/bwXV3lrD7ic?=
 =?us-ascii?Q?eZm1WFkv2UtddDtyq/RoIc9J6/fQh+pzjJNMNu2jbpG3mLcVgOz5vCmxTsJG?=
 =?us-ascii?Q?5/43NLteugw2qdM6TJhHhLAEqL4QWB5w/7TZXB6U8wLbLTDDmD7kf5HyqWkZ?=
 =?us-ascii?Q?P8cTMLY353tqxqrsz2oS1wNYTaBoKiOGGortBn6q1O4FlQV/CS4Im+N1uco9?=
 =?us-ascii?Q?PT1wEepNVfErx4R5jh4LCxEFN9D7qoVDbsMolWkBtzvwd/ssvHJUihcY0UQ+?=
 =?us-ascii?Q?F0+SPY3u4As8yqo7Wq1Cu4s2HLjjQblIvAYRSIUgrzeHKENyDguSHw4XLWRK?=
 =?us-ascii?Q?+0aNVskJmyUyz0fNDXwQJzw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f814a5-f990-4a7c-6e7d-08dc41f7bbcd
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:04.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jhbtzr7KeOfS0WXs8FxyvJNwD9yN+PN/NpaPA01HNROdcPLnaI+iK0aWz89QmgqHBG8GpVjllTHL3tRSwh9ZLXFiz4DXHI452f8yJrXU8Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

In some checks (like duplication check) we need to work with used bitmap
so it have to be created before checks are running.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 66990925a8..86958506d0 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1426,13 +1426,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || s->data_end > file_nb_sectors;
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.40.1


