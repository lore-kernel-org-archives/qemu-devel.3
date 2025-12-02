Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A7D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTIZ-00047h-NT; Tue, 02 Dec 2025 11:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIY-00047A-PW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:18 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIW-0005yG-94
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvuWKPyauj2kahQB4g+oSXLK9gnheQvi0jGZ84fOX5xSNZs14zB/c0hkuLCUBMaxZtfRRKltg5Nt9A194lY9WPzqhCt8ipA0f3MZotsyjuzx3i1JEa9LFcjEcQrb6T8pHYzSbUD3AR3dpOCUr4wS9QAtWV0erOVt0ecWHxZ9bLqrNc7GZRr4jNsnz0jrijObqVfPrRfMDWluh7X6Fno+lGOTDIoEah7CH/K73RiQ25oT+3vTcDWg7a5soFAw+YaUVgaCCR85IRiFuUB8Zgdk5tEQ8enfUm7VGD6RqqKeE3bGv/PeeLoWy0S7KcES/nxSpOZouYT1ljm8Uznk/pHodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkdLg61EAjLiGyTPzAAR9Y5JdjmyslZNraIikIB4ltw=;
 b=b+9biMHjfiD/SBAe69YccysndBKSrvWDUxH9HjtYjhTUo49C5Efs8DbruWUaPH62Esh9dH0MA8OX3vQVU3yNnPyG56YGifHbzsTxps9p39nHfwUCp+77oOo6WkNoQsPlky+BxVVc09sqgbAUpJVN2+N4Qf/FNg7YL8bFF3Oyq9QERS638kQVQfY6KKJ6zAorup8d/2oWJR+tLddGlP4lazbyonDsAKpaqTvR88ji4a9tzbO/d97utkJQJ5Cym4dLBFTVWZpQNjks9wBGrwMfgpY3pIknYwF4sa8krRReYqjrfoKKF68rnbU9jAXFv1jXQz/OFc456NIkLGq21B32Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkdLg61EAjLiGyTPzAAR9Y5JdjmyslZNraIikIB4ltw=;
 b=TXuMmTntWV0B8kNTUusW7JTivHp2sm0HV8ZLUk8R9wQEsm+Dlxz7Ep1mcyAQQo2EXUzhAw7GznkDtXzVh24OZBeIg9Di38EahVhviZsygHcW3Od0oE8dTrfbS9Lf8rkloeAx9Qh6BA2m8hLyI+u7baQDjqyI9w93jZI2s6HDsSL42XfhTIqSeO40swF8m6ESE3dVQkyHV0LtCHljI04enemhAwp4t/xSGNJMgG2OSj0PjKySp9xaOVe0Mp9WsHicQx9AIFXIiIAdJJXJcbr6kYLHC2xAeniCSXoMl98zfud0qR9y5+qRCp98FiPixCGx1uzUJwQfirdtTSZgyPUJqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:40 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 1/4] scripts/qemugdb: mtree: Fix OverflowError in mtree
 with 128-bit addresses
Date: Tue,  2 Dec 2025 18:31:16 +0200
Message-ID: <20251202163119.363969-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 691c5c4a-8bf3-4e00-fac3-08de31c04594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2FbuY3/qdyq9DwzbTZdzpFL7Vve/Zj5ldTw2PjnUn5s7gUwcsjIcjs9ozn+6?=
 =?us-ascii?Q?IfEA2IGSoP1A8+Fu2KIe25ILMuz9XEM0h8HVEW1wGwLumzrrhd1I4SCeaiUP?=
 =?us-ascii?Q?rpsC8W6QDi/bkWuVdKXhAdTD3rA1BuAy8zOf4Qr6f0qFtGjdzgC7xENFIAjc?=
 =?us-ascii?Q?PSK/0w4Apen2xyx5SdPJ7ForQDnxzGHUv01k4KJ9ZwC0UH3T5cLe77U1L82h?=
 =?us-ascii?Q?ayAY6uTLfXfxlfb56sqArYymBN/1K5qrVc94nj2IKhOJ/vzC9jC1LnEheNjz?=
 =?us-ascii?Q?Y+50vBhh7K9o/l8ans8O/yWsPo04kQCJFy5HNtwweUNIO8ZOn/5ZJbXGJj8k?=
 =?us-ascii?Q?Kq7NXmsRXOLnRy0WjxWvxGemmWC95PkSKY4P3DnthWdVLW6RQwPDt7oxLWwN?=
 =?us-ascii?Q?aeqSlFgQPeFI1EMHcOXk6Lj40+t9BBLFYb/kXnFp5zX4cTzfx7VPUWa/giae?=
 =?us-ascii?Q?ReHmoV/Eq8mBynwF0V9KdfwCGyoopG/xdN07/kXacK0/k2sqzfpJcWYKbnhp?=
 =?us-ascii?Q?+qn/fXnwVRqUewoIhzkk7KN8LOrfTjeasMgsSekDepcxSyA+2OVOfoRzlHOy?=
 =?us-ascii?Q?dV7nj+a/P536xatsuOWUCZTWXs12WX85LPZ8+PW7OOydl/XiMFyDXKfpuMmP?=
 =?us-ascii?Q?sov3nFpc+IRJ9WahGbsY/x1k1Bltigt6fG76I69H4oMuuFJ80aeTa8Dch5Ud?=
 =?us-ascii?Q?GCDM4NAZWAoGIc2OW72rCUF9h5+F4v5j9EFca4AKce3G2j87uPK7hFmire4I?=
 =?us-ascii?Q?1dCwCkL7pMmOR9ru487mx17WCM6eQojcwMhSDlzJ2mX5FOcC0Wc+yYNmog6Q?=
 =?us-ascii?Q?lPLEpQyW3BrGNF6cw9R+ksWeq7q2JZ7peSUehP7jV/OtVHsDxMKq/Jc5CjPz?=
 =?us-ascii?Q?wj6atLonwe/Mx8aD5a+qzZ6dKkqTLAxeZLXQRSEjuSScaPaSYyukZXasASiE?=
 =?us-ascii?Q?2G4ftgQuPM5VmMFT8/k4jVyVbUew8R2bTAMI4LTZm6YOEGmtSa4UDo/uI87t?=
 =?us-ascii?Q?lVGJES5PEUI+iIgesT7EGHPMLMvPtTCPJXJIsjSCRIlzwxHZZz7YNIlD8juD?=
 =?us-ascii?Q?1YpAIReisfJlvVeAdanIZYTCeXEZXTSuIhWBt0lQkxL5Mw25MynoyTbKCAoK?=
 =?us-ascii?Q?sTcAdYRV5wec3kRN+GREL2NXt21LI5dvpj46dnrbRJNTws8ANW+NA0BPuqw1?=
 =?us-ascii?Q?Z7rWAap0MnJXPfMwQvzHNN5ezWX2g4TxMeez8m4oFPIfEMI7qI6y1bBAmreB?=
 =?us-ascii?Q?OXg6PSpTd2r4vg6qWq/4LeGSOBWSYhqDTWbeB3Ven4s/7tDh84cPNKrmDCgD?=
 =?us-ascii?Q?nI6fDzThy5gbSKgtBPukUTgwrRB1j+cA5oEXlymuiqOmWVAEp6EGbDnGCtaY?=
 =?us-ascii?Q?fea7xtMzmR6lz5kMSAtJdTOdBv9Fx2FxESXeGa+pSx65QRmc7qSdxnB53uaU?=
 =?us-ascii?Q?Dl9TVdgobYQtwF7aC0u97uyPX+5Vf8+l7VGH+ocCFwZKP58DpsZpV7PSArYw?=
 =?us-ascii?Q?3zGl4DR9bOwSEIERvqNqN/X8DRNNTGqp5R7X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEWQ3v4VdOTl1RsxAIp7ySboP9YkNzspcAEWg1fJCpuYizyEniI2o9s0jsBz?=
 =?us-ascii?Q?kCPbyjAG0aLl4vDPDsSpnAn4d9ElctHD5KB1jgudeaUEGysOKHPXkg09pff1?=
 =?us-ascii?Q?HwGz0NW1HgLe3Ensn0ohtcHRWxAyxkQAVTt1sLzmOnW4q74uj7cyywYhLFcV?=
 =?us-ascii?Q?TKfgRAO7/TA9RrFOscU2uL4O9SeMhbw//o1Sh5wVFZvHGz6B9dn3+spkubQU?=
 =?us-ascii?Q?nzVxtbCLhM95x1J89cn/5AOW7EcKWd1mycv1uFuNVOLoRvcAZYBzOrEKszlI?=
 =?us-ascii?Q?c/+9ko5F9Qg6mivh5ZZ9bKBc49ByGNrNqiy4XWwSjV7TAi/LDSvKkM/IBfle?=
 =?us-ascii?Q?iD1LCyRlkZwcKLNrvbHpoisCKP1YQrCjj9suHAtwY2kojo2FAV11yGJAEaz5?=
 =?us-ascii?Q?kM3tf1Z27t+rLHzy4HU0dUWAo+YK0fIrcWa6q1tkOO1uznQuS3+DhClgONOv?=
 =?us-ascii?Q?5m9Yscaml9tNj/1DH1lEYXgMJ16iFf8htgbSpB1NE8dZOk6RSa+tZRmf6Lza?=
 =?us-ascii?Q?zw/k/esv+wJVGZHJNHm7bZkBEBnN0Cr2rW9QzT09LSXHW7EOQiPpBPtxwfU2?=
 =?us-ascii?Q?P929HdZQavY9bA7I+Y75BP6gLqj86BZKBJqIHoUaUUgIdchKmMf2QvdMBICS?=
 =?us-ascii?Q?m0ZJxglXi2cyWtog6DSKIG5u5J1Q9TAuFq8OFGvloyWZIdJn7k0E7lN52O+T?=
 =?us-ascii?Q?BFkpoDCRlRb8wcHuC3/E93DF5EmektcAzX0BXHmGjv3DFtt0FewK/5Q6aG0y?=
 =?us-ascii?Q?6Hw87j7Mzkkq7ZaKo3mHINtoQX8fjrGuEGMrOhQ/bkT4CUcduYxmMksYzzFs?=
 =?us-ascii?Q?YI8lBIGxUX6TtbrR0Sf1aavlDP/RcgdYeKfcsr2xl5nHg99uocQrBfmDe2mn?=
 =?us-ascii?Q?F6mi2n1+XTEc1V6pJtU8YY+vY9WcbcBWzUp3ako2zgZzJFPuAOvy/05nXwo3?=
 =?us-ascii?Q?NZEZq4z+wRfOhjk6cMq0Y2H0Is3eNMMuXJWXphAUm+K6KoCb6EjyF5GSH2II?=
 =?us-ascii?Q?oGTeYVCJvT0Ad/Ub/tgPKM7tMsl9DmVZBv2cVU/aafUCufObeZ9rb29Vc5xm?=
 =?us-ascii?Q?4B49e/JOYo/7jBlr6AYEX9q2p7zXn9AghjQ0WI0UA0KlRI4fEe5FKQGp4oqu?=
 =?us-ascii?Q?0CmNLXJ0PE7DbepVJh8frhRrWCoH/ji7syMskIq5zGQWPG7HQ+Bl5N92K476?=
 =?us-ascii?Q?obBJJ27TZTfoiMYxMg0iGZvCd0Y6D58NC2ouuv3Pkdp/phoPDHLXR6ehMVWC?=
 =?us-ascii?Q?gN07vK1L4jfBaJaM+Zwci5B1WJhR3wGdJERGTkLekWaYlnWPr/Er9q8kPCle?=
 =?us-ascii?Q?2gFOtre67ly+kz0yevl2EInkgJ056Oqmypo5JB+TkbU/PthYc+zE0LCCbi/N?=
 =?us-ascii?Q?/zfLi7P1h/iTxwxfX7dk4bpZheoUiW8PuJUpF417/Ha/mpuz90ybZX2UoozZ?=
 =?us-ascii?Q?6meXkuqwmD6nfNPw47k7ljoc8Q1ySxyqIEibe1/wdPLDZwhSBP7dsFKEkxr8?=
 =?us-ascii?Q?hRfv7DH1uE0rdLNx0GaajGfWsCMVmr5oNyATdoOhcMusbwVdjhCh+2xSuNlN?=
 =?us-ascii?Q?2hwHMStsptSaHIkCbySTNwIkCwAEexOnGfrRt4qqha08gtrYd9jY85dcf/AP?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691c5c4a-8bf3-4e00-fac3-08de31c04594
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:40.6798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4r+qvPK8qWMuhpIK3Tv9/0jWSSVQwYiQCVZUtJJWNn8wWsQ0h8/AkehPmty0imRLqdfTLTMqnfdIRGRVqMyTkKnGB1w0Gz1A4EBuVtQMCv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The 'qemu mtree' command fails with "OverflowError: int too big to
convert" when memory regions have 128-bit addresses.

Fix by changing conversion base from 16 to 0 (automatic detection based
on string prefix).  This works more reliably in GDB's embedded
Python.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/mtree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 8fe42c3c12..77603c04b1 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -25,7 +25,7 @@ def int128(p):
     if p.type.code == gdb.TYPE_CODE_STRUCT:
         return int(p['lo']) + (int(p['hi']) << 64)
     else:
-        return int(("%s" % p), 16)
+        return int(("%s" % p), 0)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
-- 
2.43.5


