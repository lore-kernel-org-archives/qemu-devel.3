Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B30FC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdk0z-0007Cd-8x; Tue, 13 Aug 2024 01:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0L-0006ju-Mw; Tue, 13 Aug 2024 01:23:34 -0400
Received: from mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::701]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0J-0001ZA-2V; Tue, 13 Aug 2024 01:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNyQlc6vWnaDyvfbmtzVvR2T02UfjRGcBdtWSHek0nqlgjhdGuX9tNxzuum/9Vb4NF1Y9D2HiLYUhlAqT1Sk2+hu1llGCtEamlu2bqyFASlO3cmmFvX4wUNM2tlRXKmKWWkFflimdum2gOwxqZJBXnqmSNHBlCnpLk5RyWiGsKyIO6W3yCday2y0WY7DvpWN11J+PT4kdJrQbWD3fYhsMAEZnGdsFqH5HF/PO6oyd7zFIcGF61YHV3c5LCrlatwSTn+NJVGr7co1TdJNdAj6anX1bPylnYyBoAgL9dVYGwcCkPf4AzTKVpueSRgSJnfD0slcjQ/XEkWkr5xWcLmebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjpdt9HjVDmOgTSVEA7jOdueh23prjUfwBYu2bsM5vM=;
 b=NM71UqpuPu61meejDhaRujaL0BNMcFl81R5y2JDXj+rwkn3G2sKEqi1ffyFdFE75gEdysrU0wm8mAmxSLpqpN84Y5j4M5CijVN7AFAAQ6mgLIvOQx51ZP9n/fqY5uBuApjCR+Lx/MCHzu8S9VJhLf6eRCyXiUp7ukZ7Av/Y9nvnkE3iuMYMoVWPNd21iDbLKsVn9gfIt6+/YJvOytEq/J7V35zyEXj2qMczkzj9JG8/zZP+aG/PO/wXQ5pasW9z4qehJEwAOKzosnPabTVCcBF6hKvJ1c5uB/iEQsGI3ce0OUmJ4ZKdhhLnW9bHu6SVgXQwBhe+fRw4+ENfjPRw26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 05:22:50 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc]) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 05:22:50 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v3 1/3] qtest: allow SPCR acpi table changes
Date: Mon, 12 Aug 2024 22:22:21 -0700
Message-Id: <20240813052223.1033420-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
References: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee2d85a-b40c-4710-56ea-08dcbb57f99c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: e8Bu2iX4AOPDq0uR56lJL74Dw27UR4lNMGpN7f/dDX8s4bCBbr2SZiw1ZUllzSDF/Q5xmrQ1kiQ0HLsJhoQVtnDo22oxIpBuDsXQ0kSazlQydn/f7iCmr1UTosUJhCSHpcQXWXdxtd1ryJ39HUPk/3Kw7IcY88Syse/1v8gEYSbxq8442ahpeh+R8dbfXYLMENfllExBkGySdgalPuW4F5+hLJK3OqL8piIwfVEFeTwL21PEM1v/FnyeCe7F9N2Pm8NmDpWpF/zuC5DIhF3zyIPn7/tolY+FHp1ewpp/LCtZ0SzmIhnALXvVZys3XHEHbStp5tOGnHq5nEJr4qkzIaP1R3+jeI9PP/jLJhxIjRRLyiFkkrPvEtYgOwc0jqVV1O0b7B541PgU3qYkjE6O2R0wFBvN460og75sYqqOOcb+T/ffc0y5UE1AjbHxmSO9eZ+QwcYR6k8mDQg7ExtPG99iFp/rNR1NIvcgr2IE3Vx0hPPzMzoAHdqWGVat81FiE2OH+UkKbCuHKWfKdNKf56ZuDs09UrkWMKazk3NO5hVt5Xpjz4xgFE6lihNg4oSV9w4HMkUybK3eG7NaaBsDSXsbRqcBrqksQbB0L6pincg/4Ecn3o42RooxbxnaCneR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZzTRztM49R+lhoLjJwPWAjmK6VaGjbsQ0HQsprcM5p8zNOQj+ffEySrvFRW?=
 =?us-ascii?Q?/ay4W5KOl+Q/MMIyy1taSCOeUY2FFe/9qgIAlOuALYlCmNhFY+z1xKdekJDv?=
 =?us-ascii?Q?FP5IQ0B1yqTh7iZ91Ngs7ZvY6HlfGZEupGOI1HQzVByGY4Ev/pNh0Tji8vVP?=
 =?us-ascii?Q?lTQnNR4UJbH02a1JjOETfCIJhq52U7EUAVTCi5PZOTTmP42gZj/+Al0b4r0I?=
 =?us-ascii?Q?2Qur1/xuyJ306v0WCyEyT3lB7HUIC+RLrCs5Ypfn0QC9caHGNiK6wwhIcTp5?=
 =?us-ascii?Q?AVRhcw8HdYVFnzurx6Kp9uVECCSykos40lxsh9A5xmkUgR7WcMnEHXmWPR9B?=
 =?us-ascii?Q?MKrs0aC97QQVuwdUo4J5tPT5mRSI4iaQcI3RZ/NKd3XAQ27OMCUQX9PCUH+X?=
 =?us-ascii?Q?4s5EYzKdUSsi9XWEzLScIHNLi7kjljgNRbOs5KmKHo0btG4kVp2cC1bEcTSc?=
 =?us-ascii?Q?AdvImLrLH6Z6uxBqa5H4eXWOawrcTOpoOHYYlWs/EqimR98iKMn8l+HVCwZZ?=
 =?us-ascii?Q?LKZt3IBxvjYssgDA1e92pJEYtOcJJ0QlboM6TejXs3uRimw2xmTS7BgBlWMt?=
 =?us-ascii?Q?emdAEInrnxEeQ2HkLyIEGmkqCx/9WiGVE3ffv4EViAcUEL0ZSh00bZFQmGW3?=
 =?us-ascii?Q?0PTf4pkCkTdNeYSUwTBb7WtfuT/EAlzqLusyK9ZoJcm84ddcqm5Kdhgx9KhU?=
 =?us-ascii?Q?MU7/WRXxcfx8IBqg4+0pzk12+P2XUEBurcV74U7PQMSys3zD5cUOVtIv8ee/?=
 =?us-ascii?Q?S7PE62pIFeXmz6RFqYacbY7809XmotIFWesGFNE0BVS6bl9a4o2vfyzK8q9l?=
 =?us-ascii?Q?7JEYjyqF0nwvRwGFJVuIXZVHU9lZohQuW6oxD8jXcgrpT/cJit7R0xH7dFU8?=
 =?us-ascii?Q?Nd4ZCKYamzM0aefyeerHVFDqtGtygGxECgMi8yCMmEkseV1WfA62uS0kupEB?=
 =?us-ascii?Q?xNO6pqFgLYEqNZklJf79Q5M+KX55Dspixq+EmwtTdTnlI4H/2JR+4sau3wI1?=
 =?us-ascii?Q?LREQ54Q0bVeAsXUCL2/kR+Y0nWWSM0rgTb29Im0E9JYRrwsJ9nw8fhMOBC7D?=
 =?us-ascii?Q?W90velSMYDFJMwnQv+lTcVZneEpXdLdWx/gxpCOlhuNiKwRa421qAdNcF4qF?=
 =?us-ascii?Q?H/GsldBinfCe3dWXt+1egmGG9Oyb5pv4/fDGSw6x77bcS0TdjG12dpG9uj42?=
 =?us-ascii?Q?T8gdZKTs+0JW1bWq+1esLjhUFMEk2ebQMQ9kXCIaWgUo4NOGnZ2ckNyEExx3?=
 =?us-ascii?Q?eYUEfWASeLhBWleIz0izk7Bm5YnMs00CzyYx+y1KciuVhicvMvlGcDIKuPZO?=
 =?us-ascii?Q?mnfmHkwM3w6Elqd2jJe1QnEOYSaQm7tv4TrEEjDX0TXs5iBJAImIyCDJv0yG?=
 =?us-ascii?Q?wZFcmjYlZRG5wigHCY5td3mPK4LmG22f5DdS4CC08BLNQEq/bcH1J3X8F+GU?=
 =?us-ascii?Q?95Hh1KneToAD7s1Rxv3fc8m2MLON6ZQp0qUFfCVPBDdMz6uTlNbEAXIuFK0K?=
 =?us-ascii?Q?CfMBGumGIkK2Wikbr4b5YxQH8A81Sx3tvpZusPnGeZo61JYtG4SHmkt3E+kn?=
 =?us-ascii?Q?H+WkzDo+gM7GwZTjOxma7TzJsMpQMjTA9LbQyGlopMp5s9RlfJ6+7GtQWE7S?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee2d85a-b40c-4710-56ea-08dcbb57f99c
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:22:50.6241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m8TWUg0d3SFt/td3uWUh4hSymFuwts4GBWBq16Oe8aj8Y15GnEFXviTf2wR/k8Otqh/ByfCPmCrM8E1DVaXVWnHM3MSS1sLqg3cldnPjJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976
Received-SPF: pass client-ip=2406:e500:4420:2::701;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b2dfcd60dd 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
+"tests/data/acpi/aarch64/virt/SPCR",
-- 
2.34.1


