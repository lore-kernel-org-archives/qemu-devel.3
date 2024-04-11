Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF24CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup3l-0008DN-C6; Thu, 11 Apr 2024 03:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rup3j-0008D5-GV
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:41:23 -0400
Received: from mail-sgaapc01on2092.outbound.protection.outlook.com
 ([40.107.215.92] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rup3f-00082x-Fz
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhNemYYDGgEmi9xCrITH6/psz+vGrtZFCoHgiF5WHQwHuNax1eId118kSNBsjIPqMvUfFk8TzfPvfKHWgt/bZY6Hluz/70w04CvSwKOdUp/Kbd86juC7ptiAuQ2RCM3ewxRB9Oz36y9lBuAPg7VMxQ4k6YuSP9ws7rpBGMf5VavcKq78H+L1YTs3wtOtBpHfdSF39n6ngX74A0dzMSc4jQYwGN/yz9TFHIfMXw8rHBRkKGeYUcvsMUECjQcc2LGW2QbNcLGNTlK6+jAZ9t+dH9GLn74e335popaPuadxr2S2YNzycHzJiunPFGZq0vTonBFVOKu4TCBS3ZxhFCoKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S0m/1Q3+hWLIlbmMxTvF9GS3aOlSpD4ajaDFILnIDQ=;
 b=Dw0IiausOFr97lPBBbDhnpoYnlm1m3IFhsVcpnTasXe8IgN/wGJm+jPWIWKa2ACCgMVKVaRGg/43gP3CAmwvqsSxxGqfjUQ44ENqz+fWN0s5BoXuD4qnJvS7Nr/7akjCO0HocoSCA2A2g/NiaY+B8glD8bVhV1AG3C60NPHMjO3hRIJMCBHM9KzA3eF95RW13c/fWEagcZhKYxtcABSF9yCIljCdxW7nd/rHCrD4/THcIaLh0IjmHxt/WCBQ2R6ZgHvaGpY3P+yYUgW0CbKhCdOF7nA0AfyqnWfbnPxYFWqix1REl9ts6/TntgqvF0HLcHNJbvZJr34ai/qRS6xnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S0m/1Q3+hWLIlbmMxTvF9GS3aOlSpD4ajaDFILnIDQ=;
 b=hjkzs2d7pjXEkp6JvTRDTApHZllyR6Apv3MdTSd9Ws8EsZ2bWVJwrIHFXbGC5rfVToZHuM6bsc5uLiqqulBdgh9eHo+qxaUBtTRZcUgh+qksqOo9kJXdre4ERHMV9rDtxZ5hDcbJI/Fwummsq4w2SrhsJt5yf9baV7DEsddxAoG9vVSfkipk5LicL3qsmNXL8rJtTnkiIyURnq2lFyyFu/UdW9k5xaVz/skR+RLvPUbOllOOTqV4Ensec5fGOOPw9lhrc70BwvlmZDGl5/3X0+tCjgJQeKs9Af6ObjNlFl7yJj7D1HAwRp3XZF3uHzsXt06kXwPkXNzjCm4RjGD8IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by KL1PR0601MB5680.apcprd06.prod.outlook.com (2603:1096:820:b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 07:36:09 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:36:08 +0000
From: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
To: pbonzini@redhat.com
Cc: lvivier@redhat.com, thuth@redhat.com, yuxue.liu@jaguarmicro.com,
 mst@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] vhost-user-test: no set non-blocking for cal fd less than 0.
Date: Thu, 11 Apr 2024 15:35:55 +0800
Message-Id: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|KL1PR0601MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c3b7c9-6d66-40dd-7a76-08dc59fa0db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhtBDQKGucJZtEYDHr6/PBj6K42TDizpaAfmjp5t40IXJ5mjKjeRUrBjLppCZ3PC9Dq7LrNJ7QCLwXYqMtVv1pE6W2YxGBZGCyikPZGwzVaKO8U0WCiR6Tnv/OjeBpxhctSvTwmt9URCcqAigU2linMC1PjUmNgJMlmwLVFIpMM45F35uMthh115ZizJIxWZkJC0MQdAOkSRDTWXpOVRSGgt7+Ss4teksjLCvomT+Co97LpGVcPx7ifOV+moGaBI1tRNbzhsm4iXzP0+c9s3tQExGYBaL8xaVEi6FDDR4TWOAZFQYuFZ2F9nIaMgpt9EvhaKLlLn4flXAxwNAkyZrfvKOOb6hDWVbIRPE3a6XBb2lb+o3fZV1W2EWSNyIMt3GT6vguNYVksVVQDVZ2TZkmHb4OigifKQcWXJfXUWe+BX97ptJCoi+ZV1/o+sKcWcpS0Zd4duj1DnefSaPc2M1r7jBUz5/GjV1CrhijGhFvvqrW5bi+nOXlvoAn1mM6WI6/JFt6kHRcAp3nmFSBn5WoJy8yx0RX9EE3k2uWgY18kHBsXmqTJIksvRLCsENJf48OpRV5/UukLqyaVPfNYc0+iBhZdz1nXoGaxWAfUOZ9DdaUyJjI2LEpM7zdClt2cD+aM1KSmTNjqQW1BsnmMbF237jjFQi1WXgjJE5c1tJ3daZybCWQbN7sUd+2CK9QyPiMpY9lJ3dUzz7/3fhiGztN1icq5OomUT4lRrjVWi96w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5fYY4k3edaFJ46EHyu1aQ7JOihishLE7qXiJU8oQ7Wbyh8gEWz2wGwZlFCh?=
 =?us-ascii?Q?NOJf4m/a2XtGaepxN46jlMuU9L+aB64hvdJEH1SshpXeYeqCcvPMtinQDDuq?=
 =?us-ascii?Q?XGhznGZ9oOvfJ18VlFNmI4fgDzsgmm9Mb4yqnO2jGC6jXROPEc6pyCnxYBkX?=
 =?us-ascii?Q?bIiuKYKJpDyBrGqoo9Fppp+9nB50Du14CEBTKrLoSAiRZH7tZfWyt+Cab1rS?=
 =?us-ascii?Q?NnE9XjI07DLWimkuHw7Frs53yVbeg6wPBmZYqyzek8go3HZ5iFm5g0lalezx?=
 =?us-ascii?Q?RHocSFEaP5d1+0/joKOo/qOKeHWvozXiCTV4r0/GxOqYvNcukBrUo5HtbfAX?=
 =?us-ascii?Q?SCwJJjNvzsoqeiEPHnIvGS7m1PULn8MFr6Vv8KqWHn5UbpwGA3kIS4y9PVoK?=
 =?us-ascii?Q?u8rZ22pVgBmUprAIoA0ToXJloZmfkIgzgJ50923qaJ6f0XyDaB+J/2aHRvWr?=
 =?us-ascii?Q?E7ug73ZH1ioObAvSlTzLuI+0V5hX1cHMuGs3rKww5xNG+Ka+zVcY4XeAroRl?=
 =?us-ascii?Q?/Uhl25b0hSBjOe6ATVugJWti7L9z0yTVoY/NpzQVKX50JEVj4JTYrtzpKfYj?=
 =?us-ascii?Q?x0T7SKoUFk872/AUIdHSX7fFhxIFaMylCF/DzVJ5vAzTN2KuOrJogyIyJrWT?=
 =?us-ascii?Q?iNdyrYbisaNXUSgCSgjq+2oqewhPM0AiLDdgpFOmVgPp89BBb7rfq7OIMxWb?=
 =?us-ascii?Q?73tdpSKRkooRx7PTvc0F21yxeNiTSLUZMxFwzl8T/Yq9MO0aoF3pfgTMmLLV?=
 =?us-ascii?Q?/FCaAxDNabrTdc1gOayHbs20p+pVWjP9eES4xfpS2oSemvNRv8R5ft3aeGpe?=
 =?us-ascii?Q?WwKyzDrNZcet4U63rwFcvWAEnlTaSUGbGQ2nNB2ksZtZ9eyDme+wQ81UrmdH?=
 =?us-ascii?Q?sVF0afUdO/10AktPL2rS9LTd38wsaBfGoKxwtXH41OfiYbDLz2owxkDN12vB?=
 =?us-ascii?Q?Yeit8BlWwr7VVHnw7CXTocuxJlgFsgwoG5dZ0rsi8WJfJHOzXmS/Am2eJ9ng?=
 =?us-ascii?Q?yuLXopJCxEJXjmN/5BPat72uHQBJ/rRGnURaQFKJ5qfy5jJHV/jGgZnuOkch?=
 =?us-ascii?Q?L2bR2f4XibchJXuiP7+kuwyH77JV0qohOJTYGIk0xs55EYwMoc3xjd3HN0Gt?=
 =?us-ascii?Q?11W8NR/pXyEI6eHU0xSVG/S20TWP4rIuLpKdmDghHxZho7te73ztIOThi7v/?=
 =?us-ascii?Q?4Y5P4BRBK2RPICfkyR+2IGCj0OiJlFEusffuzkcEMdEhVxDL6tnJNHlyKzTF?=
 =?us-ascii?Q?M/JbpnKBNzhJyNXt4Emuzo2GheYh4EiRSXSJmGXdMmY0mvtBXllR/F3O7zvF?=
 =?us-ascii?Q?OzuN6/VW0O3emzOYX6xWVqz4N1zSG9SuIqsjr4MJo2PW3RTZHyFi2n+z2bsN?=
 =?us-ascii?Q?RVVdjy9thswxu5KYrs+7OXqzvmudrvhlkzHnfrsey+diBJ7/Fx7t18ccNrrF?=
 =?us-ascii?Q?VS11SSlWO18Ux+MZ3HSTG0WBn68B2JpUobF28Yn2oUIQ8jSz3Kef0wEn0Ubl?=
 =?us-ascii?Q?VT01+2rhgsWp2HBZzcnm4XWAB7RzZfbXBq0MgtLp0omIcA9+YWv2w0bWEl1l?=
 =?us-ascii?Q?YsS3bYF2OSZ1rji2I9+Fph9kJzfsNgRDIjdJqrSrc2fZMofdu6ibpn+8oQGx?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c3b7c9-6d66-40dd-7a76-08dc59fa0db6
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:36:08.8516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xbTjpqH7oWepWOnVnlC5dGWoZQe0YfxQ1fHIa1d0oEaqeao1uY5prfWkcyq8JEiNYzqYrGxShTlvi9mpoxOk9DCo8FytIRWaWULI1Y0LXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5680
Received-SPF: pass client-ip=40.107.215.92;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the scenario where vhost-user sets eventfd to -1,
qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
receives, it does not perform blocking operations on the descriptor
with fd=-1, so non-blocking operations should not be performed here
either.This is a normal use case. Calling g_unix_set_fd_nonblocking
at this point will cause the test to interrupt.

When vhost_user_write sets the call fd to -1, it sets the number of
fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
be 0.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
 tests/qtest/vhost-user-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..7c8ef6268d 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_KICK:
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
-        qemu_chr_fe_get_msgfds(chr, &fd, 1);
+        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
+            qos_printf("call fd :%d, no set non-blocking\n", fd);
+            break;
+        }
         /*
          * This is a non-blocking eventfd.
          * The receive function forces it to be blocking,
-- 
2.43.0


