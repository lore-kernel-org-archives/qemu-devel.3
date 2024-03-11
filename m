Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED51C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFo-0005ob-MW; Mon, 11 Mar 2024 14:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF7-0005aJ-Mr; Mon, 11 Mar 2024 14:19:26 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEy-0006sy-H2; Mon, 11 Mar 2024 14:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGqsM9X8S7WsBUnEaPTpWCbtQEa/crL7Ra/j2EvViXkgY5Zw1PUvGryhZufdHPR752Xq0pbEOtQ+165YFq4cFxC2F7gV4xXrIwV7W+taoEblWi+2conqBEmrF4AfML1jCbH+vXXKt7gRVy5pUNXXHQk2nGJUYDYuPcJPJ3yaxlB2aWi1NGaKiJlsFx/FxvB78+gSkO8jrt1gsmBItRsMu75lRm/a8nPicryUsXMNcyRqRc7x0+kji86ibm3A+YrJkkPBmn2nDMK5ekuMkZ64WeHs8+61KqYE5QN6vQfxApJVMtvqRoydaVT935Ik731kOEL7A69c7kKtoUZZkZi4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQYgHfJVsqtYmxcO5e5H7L3Ln/2tsxHvWxmclj8CJZ4=;
 b=BwPNo1dSn81dCVYwdW4++PG1hF8Ei5ujTGkysumZskpNc8XCzQNjhAiJ9Ua5pywGYNAOVkYkCTj0HE8X+RtL6GUcPZVdUtuewIfT1BfkOKB6IgzKCqFmuFSgzD/U6SfnNEmWMCRLvfdgyInwLUcnkk1FqCAI63hew5wxyZXCPSpp3DweNCzRUuCT5JwVODXv0yNsyotZ7tvgTabTesnEPFwgGXM5J27JF5c0BlrLFSOWWLFBb+iYk1FpgCVq7+1uoD8jaiqiSnIZROffn5t6R1dZFyRnD3H5o5jDCYtPq9ujp69djIkadwaVqYpMe3zfrGLQ9IpfadlKrZ+z/Gt0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQYgHfJVsqtYmxcO5e5H7L3Ln/2tsxHvWxmclj8CJZ4=;
 b=OJxfx0f2rVZcRGICH7tack9EL6JDGXAxf9ZuiMM4O8SV3Ri2emxHU5Bqxkekf+ZjmWfH5HEhbePtICj3do5aI5Wt8UBV6byrJ5ZYu7boOLS0iNeaW7Q0F4YsryEcJFSQ6gs/9uIs447J1ZFlIK78Fhl8pTTNW/ilysJRO1LJK4NXE8gSqFT1VpTMn7MXkNbl9TaU+x/cEW+t5eWC7k934gPmCG3cxzEP6seb7a3AEtsFQRaoWY/DxJ1Gy2hpFMTWnfTiYPcJyWKFSeepsC/OZzi7Y4Xq4tjdJKj/68KHL4VAEbtfTkTrrvHN74EsTtl4Geq65y6/+6u/vRf4dunxfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:06 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 12/22] parallels: drop dirty bitmap data if the image was
 not properly closed
Date: Mon, 11 Mar 2024 19:18:40 +0100
Message-Id: <20240311181850.73013-13-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: ce242b70-06b3-4218-9407-08dc41f7bcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G++j0c9BM5uZDVH9MM9MHbJFQGznRZ04CuU6zKLKIuKKhVddkEkFPh5KgUH73poGCRNngAmX6FSWORGJ9GQ52P8BLPtpHgZqXmaE84uLIFDS6sXXzjpC2Ji5bYKpsT9lTBr3wVrqpTjinisfVbmnlSi/dgDlpNcgJBy2SsLjhA1fOFXs3TQdZUxR32G4WQn22r/W0dRRdxMiLTczqf/88swij1hyFeVp7ewwhsd5u0YVE5QTRaxxvEO4/zaiPk7IUuHH8bWxmq+oTwEYk04dAZcwLIQbTJ2VHTCS0cjI45oUZOBK7pr1ABP5HO0Op1raFxWKqpgPOtS37DTIFY/Fx5dshmxwos8bOalr8Qu4wy1g1FsQcViUi4PQLFsM0nddMOApoSVw/xwxcTHd51XY1f+hxMCIX2i+nT46G0O1KwTRKT9E1Gg3aXqR6EdymTAFMqqEVtA36Chv2c8DecTATOY5fkqv3KavqCJJXbAgD759Cpsa7NzG8IGz9pCXaJaUq+x9BZayFonAOqamJyqnc9Z2AgVTzbPUZHe393AEWlt1TF/HcZrkzQzwMpAt9vQO7PsO+EfzlvIMvWJKqqnMWP3WCv79tgLWBuYCOrWZHZqaQCTOMCJa0hJUsAu+v/n5/MLKrscnSuk4Mg7CKHSVmCRHzmPEY/IEs9Ps3J1L7KDndffZgjlYioxjXb/apOm8JlTVbMdezF9VlWqZnJnMhseQK0P6fqLbDyv8Qep2dok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L258k9S6DbTEqxKACYnH1RwsAvh9l1N9ktvNXI9cATkcpKj1nTTxA/ZOBlp5?=
 =?us-ascii?Q?v4NDJsD+8hN3QZiO/7OQfeYYFsJx3SskgYXODoYDGrM5KI57CsIKbRSok6JB?=
 =?us-ascii?Q?XFWX3a87FkVmAtkAiugHNm8giyO7QEcyQFTfaJfYlfbFeB3Dgh5K99UURlAv?=
 =?us-ascii?Q?JkOK914MXmRn3RXFSU1M06AXhzqM0IrcYDIpU3jTlcqrpWvk9VNzSIN1gj9i?=
 =?us-ascii?Q?u6WYCP7epImYHoZ2xu2unU653PInZJhu9lA/zaHybxvA6lyEfzqJfgRKCtfk?=
 =?us-ascii?Q?eE2bCkQe21d6HbzjyxoSi11QthxyoENSogJgS0LvPRst5EBzhpPkiZ2etXu4?=
 =?us-ascii?Q?L76cZqVw9+v7OSihrSrowvOQABxqQE9SBCj3EqIenmD9iIv2tpgvxSnVFYEJ?=
 =?us-ascii?Q?HuoMDPlbsrH0pNKvsiI7hGfIa6HR17VyLdm/4Z5Xo2Tzr6/68A5ZqW9PdZKH?=
 =?us-ascii?Q?5izGcg6oZp0suynwe2tl9JSiDBxcW27erWpt0YVwu0DlL4E8nY1fkbdnkcML?=
 =?us-ascii?Q?fafP82humC5lDArHAf9ErsGPubfrSBTBx6DWaWT/9KRDKzDVi2LMfFGZi3Ma?=
 =?us-ascii?Q?3TF8ikxyCyEEfFaB0x9fqAL9yVJotau1n1PJOqpqTHWOJ7/rpKq39Xa/LC17?=
 =?us-ascii?Q?qQtdC1HRQ6cAvm/5UbboW/AWoB0fBjonGqy4L5U+GJQL3rHhZLARP8UWsqFU?=
 =?us-ascii?Q?qmHF+P3J25PH4OisBZh4ssxnR3jrNNRictQwqgJC7ghQisQPU6sHy6GeyIs1?=
 =?us-ascii?Q?qeMMW7Qs6GSaASlxr3ZmbssS+g6IhV9uRP+pw4Hr+AdEK6Y03MZ9WlOSWQpG?=
 =?us-ascii?Q?9QSt/ouvG4bEEYyIW7OOEM28lhLEFhPMovslgGxTtLf8V+9JWbX+UDh4/lxI?=
 =?us-ascii?Q?AChBvC9WDYu0ZK0XxYbLSy9XJPMCCjQCjfZ6/x9FzTCM80VquiaflL5aitT4?=
 =?us-ascii?Q?DN2aCxnJ1KzCo09fsS5SzBo1S63Xkfu804Q4RhQDdZ1DrB2ozg6IPzcZsDBi?=
 =?us-ascii?Q?C1Iby/aO7FvUp5OGt0wIXzPYJO67f12kVbITtzxwH1sGE4FW84/sApqj2cjN?=
 =?us-ascii?Q?VC+jDyppcvQJLGegHK5RfocToVI5p+VJ5jzoXOyQqEZa1H0Cg/AxbPcIttoB?=
 =?us-ascii?Q?GDZSsx9bwEvK2CdO0aU5zmQtwkrgpKNI1tkuzIRBqhj+TE8yxpD8Bt42Jx9B?=
 =?us-ascii?Q?PYnINVJFZ4X+FSG+b1cUvpABddtAMWNibBOltFvu45UcgB0h/ynja2ojofEh?=
 =?us-ascii?Q?v6SAOhfLyjrFp29aRA491hapOFx1KnqzLwRHjfhG47WPd3oO/zSeJkiFipoQ?=
 =?us-ascii?Q?jZ4q2Z0AW/t7RRvdZy+DlycpDXGW86SG09XDPNWAKdr1i9UDvasWgxMh1Zv9?=
 =?us-ascii?Q?jgi5vo5lo1GGAFfdX3kh3FZJbE6jubg3sGYBWMrdgPzsFAw6AGdvHrabXJLW?=
 =?us-ascii?Q?7lQ+5ffN9M0qPrxai0FMr545JEgnxL9UFvhGmw4z1Wij2/AP8py/bK4iYmER?=
 =?us-ascii?Q?LPuym60muRy6bKpunKA8wHBQ0i44uXoPdh/KOmaKo5Jd9NflYlmtC59KmFUn?=
 =?us-ascii?Q?eaLxUb3te5kx2lJA3rEm9t3nyj4301VyC7aHw4kqyPB6FogA3MybAd4IpOEI?=
 =?us-ascii?Q?+2po9llatNVtNtJZLK8PwgM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce242b70-06b3-4218-9407-08dc41f7bcb1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:05.9833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk78CJFDB0urzBaZT3R4l9r0xOL8o8+WTM4RhjOkFr1ud0mfusYSXFy7NDOnlSeZDS7zzNN1lj0NgyeMPGm15P21yW+O1qWWi0sn06IhRUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

From: "Denis V. Lunev" <den@openvz.org>

This data is obsolete.

The approach is exactly the same like we use with QCOW2.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 9cb8e65c0d..7fa14b057d 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -255,6 +255,14 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             return 0;
 
         case PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC:
+            if (s->header_unclean) {
+                /*
+                 * The image was not closed correctly and thus dirty bitmap
+                 * data inside the image is considered as incorrect and thus
+                 * it should be dropper, exactly like we do for QCOW2.
+                 */
+                break;
+            }
             bitmap = parallels_load_bitmap(bs, pos, fh.data_size, errp);
             if (!bitmap) {
                 goto fail;
-- 
2.40.1


