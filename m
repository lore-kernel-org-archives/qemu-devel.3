Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8FAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeC-0002U4-6C; Mon, 11 Mar 2024 13:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjjeA-0002T2-MG; Mon, 11 Mar 2024 13:41:10 -0400
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjje0-0007Gj-Ar; Mon, 11 Mar 2024 13:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O73+mssJaK7Vex5HwZKDtiI6Z88A663FHoTWuqPFgGq31C3++35kM0kIbNsbJ5qgWL2zYdQFiZiAJb32lBDZLfVAgZdRpsZsYEQrPy1ssqyM1rZPl2TnDeziw4k8PKUHeTLSrcJifEj7n4Y13Gkty4EDBdKfTsaKOPmWMsdYIUAKkEuaiVHIfgtJss6zjO5sbUR56R65L/6sd16+wlhIBHQyWdT42lEKddkNMBMRrHYSzYZXfl2k21jOvZf9pq+veWCJRhQKkOSbCKje2zoj++7LUmbybJksC3vTmeBmPnsRmD4S94PKAUPc4F7iQnQDfAiaFc+6pPW1beIN0KL71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK2Cj6njlDAyGObEKdX2inmYPA18t0n4TwcjCXYyBa0=;
 b=j3iPSA3b0ULtEozkjfCsjNM5YZlFw8V39a4GqLtFIdCttw4ReZDWRO/2HCt+wFflZFP8dzQI2KQ3f2fDPJB+HBCSGYV7q5O7h/eUTuyb6uvbvXS71p8IzFQBv1kdcYvqUt2VjjQG4cSp1TiKMIxmXJ9qF7A3O+56x+rIfWi6zEOd+x3+MrQoNLqXUlB2SqGAA9AP2JNoGYogCWC1sNscmYbLLRpWjhd1M4vJEaVl1btIcIbiS0FNl1SmPsfk6Fi99Xv1D68YlA22ULMNZ5TRMPaHbZWsq6YQUMGOPDqYPL46ys4K4TlK5kgbVSP+v1IuQFRdnWMuuF58axvUaiZn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK2Cj6njlDAyGObEKdX2inmYPA18t0n4TwcjCXYyBa0=;
 b=URbQtf0wXuvh15X+X6tC5FSP6HDjCWf107/ls2ffQeG2Cbcx9Kc5LGrWNWeaN7zG7y5K4pp1mor9VRZDuFETXSUT/dbfvVo+oFJ0aHRgSAw9yprSvEaEWw/4jeyvdSYXtAX8jRCpH2ZhxZv6JusTnoEppsWzcuvJqLTZtZ4ooOkqBp1UxH7xubbhuxb2CfZ1UTgYfpkBtAhrJSreiIGM94VM2FYyHD3BiiAnB++ZqKzyj53Xk3GgLUFDpK0ik8a8JCGpwvZ5dmiB3C/bzTbFii4tNMlv7rCMg6NZQFqU8Yngq6fgIzhmmrsWrP830tFAeSuXJxti9Han+ihvrU50jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by AS2PR08MB10322.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:40:52 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 17:40:52 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH] block: Use LVM tools for LV block device truncation
Date: Mon, 11 Mar 2024 18:40:44 +0100
Message-Id: <20240311174044.67094-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0069.eurprd03.prod.outlook.com
 (2603:10a6:803:50::40) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|AS2PR08MB10322:EE_
X-MS-Office365-Filtering-Correlation-Id: a38f4eab-e176-4858-ba70-08dc41f2659a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+EvtvhI6MF59Z383udXtguhxgfawVbKV7g4HvCgoMAI63tbtOsJZlsDlBEZJFg6ayyPuoLJUXDw9aag99rzaB5iDEZDOSmgfFjQDHeBtiArmh6WUxRDqRc0aYs+A91Sr7m/9uhuxprdX8XCpBHLStaZXMCHmVWGmCOdnI4vqcE800pIxxHmigK2o4zKZDckc4wfDlTnzgnI73QdiOE7735XnnBWa/E2nNZnX9vTvlNG5ELKtorStvkgPmHXV0gRrguZWe5wWML4QzydV9rBrEC0bL+pzbZstIdjAoN2FSbc3DKPb+GNOqchxp6vxsquGbivnvbBmFS7BHR7w5Zbs90uorqSn9rZTnkeuoYcbCTdtDzBLEL70GfDTNGLXfXlEXD5+z1/lnT1OGxyxIhj1ZpiyTdup3GEgUBzZWKotewpkbVnGTBQTy9/fs+g+Ap2VtgxyAoWvxaUu88WmmUZxOhQSZMXHv0aUT94oROt6SIURKe1f0h3nd0lIud0uxsQXGfSdBpwIQZETQrlTEfJgf84fJZXzEaZKWhe35hXBPyRJHf7t7eiwQjIZs/ObShhuglyMz3BtSDjFlVlUkMMqA9bawIg6RBpbEl2vxwo975DzI+cOn8RW/0bQTRm6kIx0bvSOYpXI4vwYq2NakrOVk58SsMH2auaPjQI3luETpmeUJ1qLmcM5xXpGsgMQ51ttXK/9wfKlWGlFl/uYfdwVAoPWf7sk8l3rzgcp44VUMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?68L6UDfHi7tdjHC2wtBFXDnEH8WxLSd87ajl2UKfb9XqrLd7MJizMFoOldlo?=
 =?us-ascii?Q?tkzCKg+wPUxYI8x4A8pLsuL7WYdtdvvaXnHrjvH2qDkcV+5FYbcRRtNpacy7?=
 =?us-ascii?Q?PImex5pZ8ZS4do8HPgC9sT1MkLpVjAInTG9eiC5P5AMtusqJd6oCca8IptWb?=
 =?us-ascii?Q?e0VRuFDiAcZ1Qs/qUKAm4EjHgKants9eaE2MNtolecIxtMZJtrZqHOui3x1E?=
 =?us-ascii?Q?fbs0nlDl7EBHG0bXVVZ8eErDlACEWxINOQ3zJRLQlTTGEu9ZCND2Hx82oUmm?=
 =?us-ascii?Q?Gnzzhb683oMHHjYv+KenCRbnC7osvtR241iaeJx1iFWRw40TyvHr36XLc1AV?=
 =?us-ascii?Q?Y+UiNxHCI+JFuvHv9lVYmV7cfa8gaaGz88iqTAjkbv1bg82lgYoduL4x57GP?=
 =?us-ascii?Q?ySdzZOHAeot8nNZLa4rLjJwxNwKyr9wdeXpuKySO/10WjEne7eSU4X7ifTL2?=
 =?us-ascii?Q?tCvfEjuhw3AgFNuI+BwtuJu9Y/+jTuhUm2/QSl60nj0WHHwYogYVu9od7cyC?=
 =?us-ascii?Q?8PYD12JPS0BD0S6ncGanuWMY5B1oFbDeAH58mJavMI0gwhNQtNdUih3yXk4t?=
 =?us-ascii?Q?UYesrayiZaxbBaR3NB/ayrqx9bpR3S43Nf93YbP/uTJdY08+wgmyEl5+EKqY?=
 =?us-ascii?Q?or2lCqbQ+qVvrBnCHQXQW4q4TKzPbD0uA38E/aax5ixXpa3sG5sSN7bsr5H6?=
 =?us-ascii?Q?CEn0gQsbtLZv6gWiyc515QTMXf7jlDqnRs2GD/geZUQrpKEQF4c6v5PmZ8kb?=
 =?us-ascii?Q?NqRKA6ls106z/uJnoRIJCEjyQyMFqJaSZt/nTfPw8O14rCLb0LQizSRo8mhA?=
 =?us-ascii?Q?IWffB8UB8UDu/LPa/M5M5VpkkmyYDjen6nNItqFwgYGmZENn/WYEUt27X7QZ?=
 =?us-ascii?Q?4in7IBFbbDwXXKaIvWkd+ge/trLdt/kiJdBHsFSAYL/H5nEZmln0OmoTJ/Xg?=
 =?us-ascii?Q?yVelBs5tZOUkw+r4rMF4LE73Lji9r1hoGP0lV2+v34wy2s8Mrg9UzqKWWZt1?=
 =?us-ascii?Q?BU08PbsspVObUT3VlDgPFYdgCTBNkhFBbUQYbUx9ztBT9ELVtd4YkFADijOZ?=
 =?us-ascii?Q?oB1hXTnBR+hXrGAPf1EO4RHpI/WuZirAkw2ORQPzrRwMtV+n7iw3e8j+7a+K?=
 =?us-ascii?Q?TL9m/KXSlewW0T/OTiYgRozIuTevrWGWQ+grmfhdaW5XNZ7LT8CJy77iL/rJ?=
 =?us-ascii?Q?QrM2Twugcbz/rO2hkZgb4Sz/BXDYrHuoKfmmwb3rFVXrFMjjvTEGAAMjE5o6?=
 =?us-ascii?Q?z7i6Acob+WKlHFS8Zzq4o98HeDKfvD4m8yUguTWjJ8LyOk/twTvnFSSG1iZO?=
 =?us-ascii?Q?cwxHhzHyztD5GTcxbFQw44Amv4iYMQF9HBFH/27FmNtayeuc8CCqHvM1smz0?=
 =?us-ascii?Q?8rqaxYf/8/darYGKjjRlpq0BsMz5u+AzJ6dQuEGnTJ/CwvMi+O2xCv9C+x3h?=
 =?us-ascii?Q?+mIlqG1oM+nzYOm0OFxNGChiCFSW1EwAvz2pTGz9d0DQL5PnR5PLerKfD2+q?=
 =?us-ascii?Q?FloGZLL/svvewCPThpuuUHelanm7QIRLxAoDKhnUs6dmD65askwpxvTzlV3R?=
 =?us-ascii?Q?kBkqUSGG0ODx7OJM61mzhjZlqkcmZrxQwPYxco2FX2OuwrFbdxiS6sAzy6sO?=
 =?us-ascii?Q?LWAcxm5h1mlBpihVVgPZ+Fs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f4eab-e176-4858-ba70-08dc41f2659a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:40:52.3697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qocuhjB1p0JTPRtPmLWopu25QxxCIKSqY4ISXfC897DzUC3YIzL2WpdwSpMnYh5QzEVsED+9NgToNh9ulqg9HP/xg/fJrU8VzofK2gNTnmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10322
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If a block device is an LVM logical volume we can resize it using
standard LVM tools.

In raw_co_truncate() check if the block device is a LV using lvdisplay
and resize it executing lvresize.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/file-posix.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..cf8a04e6f7 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2670,6 +2670,33 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
         int64_t cur_length = raw_getlength(bs);
 
+        /*
+         * Check if the device is an LVM logical volume and try to resize
+         * it using LVM tools.
+         */
+        if (S_ISBLK(st.st_mode) && offset > 0) {
+            char cmd[PATH_MAX + 32];
+
+            snprintf(cmd, sizeof(cmd), "lvdisplay %s > /dev/null",
+                     bs->filename);
+            ret = system(cmd);
+            if (ret != 0) {
+                error_setg(errp, "lvdisplay returned %d error for '%s'",
+                           ret, bs->filename);
+                return ret;
+            }
+
+            snprintf(cmd, sizeof(cmd), "lvresize -f -L %ldB %s > /dev/null",
+                     offset, bs->filename);
+            ret = system(cmd);
+            if (ret != 0) {
+                error_setg(errp, "lvresize returned %d error for '%s'",
+                           ret, bs->filename);
+            }
+
+            return ret;
+        }
+
         if (offset != cur_length && exact) {
             error_setg(errp, "Cannot resize device files");
             return -ENOTSUP;
-- 
2.40.1


