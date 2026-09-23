Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805DDC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Pk5-0001M9-FN; Wed, 23 Sep 2026 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Pk3-0001E7-3r; Wed, 23 Sep 2026 12:22:43 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Pk1-0004Nz-7b; Wed, 23 Sep 2026 12:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLJipVWnT2xOI68rnibkukUhsq+O04kGnytHnxiQpMM+grH1lpUax5LfDgtyhhsgBM8rYQaUn5yLt+7zk4WCQfEkQlP95QFkks85ujMbJ6N+UBqic0OfTXzb2A0TQlHey0n+tiaQ6wZB+q8ZVSZv5/b+O0Vib5DaSMCaKVem0nRER8WAaD5DUrWUXQ7ZNhjiiJaaE1CNp+M9UcKapnbCKmgGI1c27yROLoj/fI7LUhJiOEZQCleuzDmIq+pYgXcPk6j4IQFkDZ1fEXBfiXQtEEfQT95S+Hp4GMSYPsg2YK/WB1N48WPLSyGww0/FMW1Ku99DqSmRj7SEfli3VcEWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdBVVSL2OTfpKUgWBqjglmbAnUZ8M9bLPGg1lP1xKMU=;
 b=LQqc2FYgfcCSBvPt9++bZlzlOlze1aEkFWMMPsYKyiH5fKYSQ3UNYSWfeypC1np34v1VVEU34egcFsEOiLutd3An1Ae8AXjo4BLxvajqglhc7BBpqTc0x/LWxdeGO7klN0cuqfx2yFAOeZFrTbg5KOey0FTZIckBtXH6t8vQa+r9xnfhuSsnF2d/XI/7jKmepKuUyQmAvXzSb5EP3Jx+ZaKzb1NbMaB3PlHW7iFyITEq0Qjv8WicyWiI+iU5qx+SaK6yENg8RBXmrX5YweK3ndV33vAHkvq+XePiYaVc3ssxLnE4Eyn4MkeAmBqJpHBsdneA9arSmwIcUo54WjVQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdBVVSL2OTfpKUgWBqjglmbAnUZ8M9bLPGg1lP1xKMU=;
 b=ZWMOXovonF3azpTRJEcKJJ2QJGqHtRT2OAYog48C5AvOh/I+4aT2z//RPj0h2/PaIKUAZOdONdNUjhdjwST3QvZE2+fF2TSZxw5lbP/pMEJJmfbdUACg1bB9K6KqIA1b140fGC4F3pMqlyFied3iY8qtviivLqV+xpuNdfhtcVoMhv+anuXzwyp05BLLeLg8kTh02UjI/CSr+JryoMAF5IAhMAt6MAUwtSOvEcSAULrFQ7YrCaMRWNbPaoGajDS/SkEGYl2gF7fBS7B9d7lFGj1NSba6zgqhHYhJ45d0ESv7v9ipI+658QS4eH203dfBGmgpE3cIUyieSbSkYM40vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6635.eurprd08.prod.outlook.com
 (2603:10a6:10:254::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:22:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:22:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2] block: allocate aligned write buffer for 'truncate -m full'
Date: Wed, 23 Sep 2026 19:22:24 +0300
Message-ID: <20260923162224.34946-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0287.eurprd07.prod.outlook.com
 (2603:10a6:800:130::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 458db3e1-400d-443a-6a56-08df198ee079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|52116014|1800799024|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 03udcEvBtCmFMohmbIkiCgBHIqauUtPVaPDBICcd0/LDB48AMVdJJWfNh4MQAIdNiKqnC4c9TGstFioZ6A21LGvxeJ51IVdmkdJHPthHquTdqY9M7PaFzSy4zUvwNeM1GAF4YoaCexhtfCkci3cIRoVwl9rqw+E32TSKTp8KvKFoh/thfkk8QRP+MnJLltGlRrALhiEmT/q6fQZzknBBp6kjaP6UtUwN7WUzQrn42NO8L0/btUgD/cwKN/4Rlt9YhOQGD6V3vtpmfmArRUIcOgtubBMVJQPPduR0GluyM2ddkk+yixRq/9pQVnlEnyJGEbHgCOueaOUoXlK46KrgxLfW9AqdPcHokTlpMV3wics4neMzzC0+2r56pwlGEeLwfzSWYSreNF8kJM15gpNEP1H4HDfE+/nGe7I/w3hlbW12eJ67LlaMV91M6tURmud62WTgf1UIyg0tbsgJety0UHtIGKesFOqVQ319k6ziRtlmGPxEdxvqGnD8+1VfJQGEoI941LeFLtOC3Jf1Zic4vr+R5Cwhcl4zCYTuq/8c8Nyx66KeAi3gGjMuuP71NWQjPKBOcosmstssbxPAbwzQz67Q2UQOHjua42fAxJEZIdRjHsaLrth4qHXskayWsnzF5l74nzI1rcu8nwnHVtt0Mw8Dyx7SL4M4e6ZWh6ygTBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(52116014)(1800799024)(38350700014)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3nHfg6PmAZfbnzH+xRqigKJh0a31J9CUkhnVozoX9g9bg/Rst1KVidoUUf5m?=
 =?us-ascii?Q?LF2qQGQzUuTTP0MqHw7/Fn10xOAFrT12QcGSSqXEouYplaprVX8Skuc1Ood8?=
 =?us-ascii?Q?8JfvWEwic3lNgUrDyGiRF2KorM3un7skoFzDHRwx2HiGSnS4KRNpANay1Z/7?=
 =?us-ascii?Q?nkUIgIkwo/pmDflnSscb/av/yRMbTuFTY8aIrCqZ55trQ6P1Rj8ep8OtCWap?=
 =?us-ascii?Q?WL/pgmglras4DrCk/jBUsuEi7qzR5qrJy0JPuc1tn1FDKs3sUpPlrwSTvxOB?=
 =?us-ascii?Q?I3S1AZBSu7ggUgJOPCRZ+J18YbPBrLS9/eTQggg4XLygtgnZ/2pKLIVxOtUo?=
 =?us-ascii?Q?nXalj7LsqNK/+b/legBzVmG44uA7tk+pNvYg03UdiOKi+hCiEwl2lzUS0iio?=
 =?us-ascii?Q?kGK0/xHYxcCPKdxBgWIrzZ3IX/wnnVHKXqC67EZhuZIPFd4Kxk5iptXowJCH?=
 =?us-ascii?Q?NitOu/Q5P1kyP0SqDUITNF/Y3bWmM+ay4RLw7r3mt4gEBRnu/M9VcQquhbVY?=
 =?us-ascii?Q?TTyr5TGRSdBoCnM+CuqznEG7tr8jKvZ4KpGu9A3rhVASBmdE/0X1XVEF5SUo?=
 =?us-ascii?Q?1zJfyME4wcVXyXI28qzIX030DUOD4TtH/T8pGag0l3Qvvm9HCidFGMmt5zWH?=
 =?us-ascii?Q?u1PxY5LN7R9xF6bjolmXkS8p7/7ZMp5PZlmpot+0gARxKJNu9e6RNzkJIJIY?=
 =?us-ascii?Q?Flg4MooAOdJrxMcPGbUVA6eASXGUoXgHDYqxT3Nc/Slt9FrvKr6cv70ytHMT?=
 =?us-ascii?Q?1Rt3+onUbjmgoh5wtyFerqrlu5l10CJR8bv/nOOEuMN4Vt25wmdk8O9JPqKa?=
 =?us-ascii?Q?tDhqMzmmBGEAYYcLNM/xaZe7YBUTlQ/Bpf4HVldXTP7DgstXrUJJz2KBJaYU?=
 =?us-ascii?Q?hoLnrAdeAwZ1nqbeyXchEPtljlU+duMNCExLlwQueXS4wCKrMCHB39/r+Dxe?=
 =?us-ascii?Q?qt5b6+1ln6gigqrRbf35eg6iHTtHQi4uzBgEZNc/yp9Fd2QUYxz5TWeeXjbB?=
 =?us-ascii?Q?6Ruiu21ZdBJGlVwZO7SHRHXRPBuphwBgkBEWY7EueWfg6xIlbaB2PU2L93JN?=
 =?us-ascii?Q?4ZQfqqP7/1jrJ7faNC3IyuZzFnQMOVHvyS2l1bhytw9XZVwHWg1FF0lg0ukB?=
 =?us-ascii?Q?t6NIEfqa4YoQvmg4DYaVbIWYVnPfKiweMBP1gt2w8NtvX69Ohc0TuX+u8IRt?=
 =?us-ascii?Q?RYCPXpcz6ht0zhUA50evEx23DK88Sq+b51FoYX5Twc+D3HLNK+kPRw/JOq+E?=
 =?us-ascii?Q?x/r4TJdQYP06qK1PNAfOOWUz8FkhLKnn6lIi69RLw/2gjxZsPNg+ewGTQyJt?=
 =?us-ascii?Q?Coig/FAKswMvoSWI6S3maRkxC8RznaJKngFKoVfALmbsN9vvqgPslJ1nj9rx?=
 =?us-ascii?Q?GwXiiF/eiFCsCEanOuvzSTw+suR7+Zih6+ETIZrixHRx/X94u3/sR5KE+YdI?=
 =?us-ascii?Q?HHYTvDMj3LMpKbwUMbeqw8/ypsMU3UThpKeWcwhO/DSEOLejNZzjyYdyz3aK?=
 =?us-ascii?Q?nsVW2NN0g5JkntlH2n7xrlOJAHo8Dcrimka6+487dDItbMPU3sWlNRumLqBm?=
 =?us-ascii?Q?0JkHZiuDwXUyePhrXeyHaHVtu81yxo+3HfzU8HMCGAwI1nPOaHg/JBv7r5Ic?=
 =?us-ascii?Q?98aAx8xTMNY9U/KAI7XTxWJ0jA1/tyQEu5576e+OeR7+KeSpLzpPR7NkQ91T?=
 =?us-ascii?Q?biANhGBFIJjrozcfGKkwtRsJxsMjuNgziqp3txbppTrFSREgm5KLioum1wMk?=
 =?us-ascii?Q?BcEbC7cItLMz1/DTqaqg+AE3nNrGaOc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458db3e1-400d-443a-6a56-08df198ee079
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:22:35.4875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9C4KYNTJqY+vgruMTrLbzw4zpWlrx33WkwuqZ4PDdanunuKkf8BRSahdkP5EBwZP1AQIlVtyaJMM0MupniWK6aPbxXdFaIqI6eB10eKj9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6635
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

In case we're truncating an image opened with O_DIRECT, we might get
-EINVAL on write with unaligned buffer.  In particular, when running
iotests/298 with '-nocache' we get:

qemu-io: Failed to resize underlying file: Could not write zeros for
preallocation: Invalid argument

Let's just allocate the buffer using qemu_blockalign0() instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

iotests/298 with '-nocache' is still failing, so sending this once more.

v1 -> v2: use QEMU_AUTO_VFREE (Vladimir)

v1: https://lore.kernel.org/qemu-devel/20231211105559.316897-1-andrey.drobyshev@virtuozzo.com/

 block/file-posix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9aad156aad4..39d6a34456c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2366,7 +2366,7 @@ static int handle_aiocb_truncate(void *opaque)
     RawPosixAIOData *aiocb = opaque;
     int result = 0;
     int64_t current_length = 0;
-    char *buf = NULL;
+    QEMU_AUTO_VFREE char *buf = NULL;
     struct stat st;
     int fd = aiocb->aio_fildes;
     int64_t offset = aiocb->aio_offset;
@@ -2433,7 +2433,7 @@ static int handle_aiocb_truncate(void *opaque)
             goto out;
         }
 
-        buf = g_malloc0(65536);
+        buf = qemu_blockalign0(aiocb->bs, 65536);
 
         seek_result = lseek(fd, current_length, SEEK_SET);
         if (seek_result < 0) {
@@ -2492,7 +2492,6 @@ out:
         }
     }
 
-    g_free(buf);
     return result;
 }
 
-- 
2.47.1


