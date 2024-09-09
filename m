Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24728CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 03:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snUzV-0007DG-TO; Sun, 08 Sep 2024 23:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1snUzU-00078R-4p
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 23:23:00 -0400
Received: from mail-eastasiaazon11020142.outbound.protection.outlook.com
 ([52.101.128.142] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1snUzR-0008PR-LV
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 23:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM1LR3cLQ7nX4lzGxOXpBF/pyWg+xS9uxpPwxRwNcqapC6zOg3SMU13yaT2zasznyTckyZySV5M4tAMqCExZsPU925hh7hPqJxS0op7SN5gE5Q50foDc6l10+XWLA6SiQgRGnasAFCIKw+RBA9dFMQytfdoOV7lNxnp6IYBZUXTH+RfPhuUsRC7GpN019xJFoQlslp6WaqF++hli+aS1yCy7dJ8GnPeDOp0CRnWg7Cnkeh8GHVeHhZBYbS7ZAGDq13ttka6bQIXLH+4R5QM7YrK/m0MhJ+cCz6V02kRU19LomGe6+EvfbVo1YFyeADiPhsrjhTI+4cpLpKRlfQ+9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQWzVbAU8B8P11ybTQhKS/+f3xU1Jo16bFN+FLNrXfg=;
 b=CV3lKNVf/RUXPx4STPso/qZ9gIoxxBfT5QxS3Dggz+OhUGCuzdPmezZIlROB5/kVvLlrja7eUDLpO7lOrz6QVD6mos6qNKAHqO/jKRwZJIBUFb5XC6hFTR/pPr6yRBlCjKKpXIdvI9KH46weIFxxCOl3U3ovqcZmMCvAYQiewaz6QS0xoGEem+99NaIViL/mtQlMRJgMpo15i32V6PZ/wKzwyHGXvCuVhNflXa4JkChl7nr3X4WtnRr9cViMYAsIjo/dkeDHC4djioC+KumZHoyLEpS4Q3t3+rFEV0aecn4sWOMhf+Q20ieTjOdIVGiM6LfLxFJer1uTEc0UxQqDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQWzVbAU8B8P11ybTQhKS/+f3xU1Jo16bFN+FLNrXfg=;
 b=rE7GWd18SD1bRDuurprOW7ybBxy4QOwF67ytAKVO14jAf8MkQNTOySNZi3dSDt34Grd9S7AAMGRNEFFtf5OQ2elzq0m498u/lURBoCiPuJrOcw8ffLHa0ifwMtaLxpE6EmwobXd7SX65YDaOYJdzCJ7hhIBNevb43yvV2dpqHdsnI1mx3Qgtpt7/rvKLEanJGOMFAsLgZCbCfOfJae34nIM/UVaklQB1mOPH4hQ5pHcJiPvaQ/vW+QTgcuagj3c5HLzJxxZbITzk/YogPVZhxAN+OPG4B7JpcnJvrCCX8TRRHeuvjpBu8cN9bBbjw2ItKUfY5JQaRU3dU42ZRdslyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by TYSPR06MB6390.apcprd06.prod.outlook.com (2603:1096:400:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 03:17:44 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 03:17:44 +0000
From: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
To: philmd@linaro.org, dbarboza@ventanamicro.com, alistair.francis@wdc.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
Subject: [PATCH] Remove unnecessary code in the interface
 accel_system_init_ops_interfaces
Date: Mon,  9 Sep 2024 11:17:36 +0800
Message-Id: <20240909031736.1881-1-andrew.yuan@jaguarmicro.com>
X-Mailer: git-send-email 2.37.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To KL1PR0601MB4891.apcprd06.prod.outlook.com
 (2603:1096:820:ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4891:EE_|TYSPR06MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb20e8b-6dd9-4198-3781-08dcd07df89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mFp28dJGEsWThBf99xlkHnZHt+tPSDlT5wGhAtzNwzg70XaKUotgXgxw8jhk?=
 =?us-ascii?Q?jN5jzCe0k1clLw67reMKBSU7tj7uGYiW9k+KMP+T9sAu4PvXKgI0zWLmBbKk?=
 =?us-ascii?Q?Phv05AjWhh+MR9mc4vKXit5JoDEq+bx6/wmDxkiNoJdpkFmKQcTC8GOX3LdN?=
 =?us-ascii?Q?ufaCHcnEEyq8OKt0uJeoLkr9YGkWyY9cGQuN+3FIS8ORQ7TuIH1L5sHmzeUX?=
 =?us-ascii?Q?g5kYYFRU56/TLO2tsoB8vELatvv2Ye+1lP5tndaTXvjuriRxyeHmNe0ubbUD?=
 =?us-ascii?Q?QJQCHaycPR0qlRNHjZsV3soX7kJEUC+BxhE+6vEtbAbHw4+yjGAALD+zOX3h?=
 =?us-ascii?Q?6B7UotqI9boXZbie7ZaqSIc4Hh3Cz6sr9oZpwAYITeJqD2ksjcsQQjjrHJ96?=
 =?us-ascii?Q?3tM/HFYhfTDV8QeyoD/IdXPZfrmNNzvymL3yzjt18ZqU7Trh3KD3xGiQDzph?=
 =?us-ascii?Q?cMVPAwbKb+vMJwEKXia3UtpasETITnrTh7bASX9UycgNmPyeRd6RsO5L8BQF?=
 =?us-ascii?Q?gGOIpGTOJT5tDl3kQzglIBFNGzuqijMBZRknziUY4v2Cw0XgAZKCCv/dc3BS?=
 =?us-ascii?Q?wyuQ1PHnkCidgCKlJdbgRDKCPurpv0+P4o3mdCpJfvdun5h60Gn8IMnFObdV?=
 =?us-ascii?Q?+9fcDFrMX2pAtxx0MxwwblZWhienh+3lKXLTMsNDTo6+L75Xr2wqYzCYrKov?=
 =?us-ascii?Q?UpO6E8RLupa2tKqIBafHu8rEKlN7r4QD0yV5j7dE/mNsuH88lz1soXM6J+Ut?=
 =?us-ascii?Q?m4L9JM7pH4EdCT6Xqm+AEsW5+THEJ2/dPaVplxsFCiZvB2VVRZ/w4k3QNV6L?=
 =?us-ascii?Q?tDxRRN/bKd8eWhL7VhCMjw5yYt1oCM32OchfiHycaWRYl2v8rSSWmTbsIrRh?=
 =?us-ascii?Q?oQyClqF3efDSnaelTlWG7Ryw3ynejYEWHPGYqZO3OqkrraznuSSiT0nzigMC?=
 =?us-ascii?Q?UnvpXTTVVapUM6WO5g6A3ji1rlZ2zoPLhOApMOB6Z8tgk41A6KnJIPZkFjIp?=
 =?us-ascii?Q?pgiXBZhj9Rl54PMutdZdOf6fcdVi9V+N2H7NjkK6BUfc38VzO3KC3qRIbgAg?=
 =?us-ascii?Q?EHkxh4PIwqYtly5v4gWrFHdlo0HbxAHxv8Vmw12Y5Po4Jpcft4TGkAeg5ZKa?=
 =?us-ascii?Q?L6RxJkCvh4Y5kVKoqgse4uUJlhJS3BVCHUVVtha26MRa8xIZW7dECXnlG6B+?=
 =?us-ascii?Q?Ao2+rr/hxPdpcRx5ql2ZqCZUi65jXLItZbSF7NosyoYu4hlgx2JhBU4BJSvL?=
 =?us-ascii?Q?iTWNylP/Ok9I4KSbVnKbD4WsFYeiMtPKqLI1H1/rUI5o3ckwogbhWraVVGl7?=
 =?us-ascii?Q?UKo6c8XcEU1j9EqRNvvPA81/vajmE4J6rXYGf/IxgV+HjECBYiHfK/8zbYhq?=
 =?us-ascii?Q?PT3LcOBAZQaC0W2YW/x+XOoaWJl1j7NwvZ4I3lHeSFYjXiVRlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huYaM/2AFABDyMsJvTzuntyXGWrZmBVZt+3QND6PRdo7WcOzyvIVDufDEX/a?=
 =?us-ascii?Q?tVChVBXnAtid9rmlnOfMVsowldht+FdJa9GlLlL0n3lK+gxPt3YlQwQpgGxq?=
 =?us-ascii?Q?X815a0EPPVyLEidudLmNQn+PrWqTNSp1hSgTwQQ48yW6ON4MgCrjCiEpDzrU?=
 =?us-ascii?Q?4GPFs54cG2tjgLvpQRD7M2ciQi3x3tmDjDtwjWshl+aG9TqnuX/BI7HyKboy?=
 =?us-ascii?Q?MG/3orI1v/1SpD7Ly1O0Fq0jisUxxTzzdJSDjHivZvxdDvifiEu5FM2Oq05W?=
 =?us-ascii?Q?JTacZ2E9FmPepexCg/jPxTEHNhXNjk2DHmCG1bfsiZYBEYp7zaaajC1HrnR3?=
 =?us-ascii?Q?yP68kDMFIPR81Ap9SaYyA3MzXWnaZppQEnmiSVgQQnZmphhY6MEWXH6Q1Kyi?=
 =?us-ascii?Q?TuU9Td054BX1DS6bq47hRqYNDfnUK+CJ+w61PK/mEcSg1kPQq2umX07WSorS?=
 =?us-ascii?Q?kPrcbOqmshSmlMYnvtDP7OuLApv4u3pb/Ju0zzFYV1q/oHqTwz/F3X8tToYr?=
 =?us-ascii?Q?N9UYRMbjaeHK9Zdd1qEayWdO//0eG+lQ0B/OB8S1VgdG7H9vM17Y1g9HfgeN?=
 =?us-ascii?Q?Jru0Iy1qUUVB4gOXxwCd2qH4uEyevV5FiMWen92PsEaiSu4HoU7kG+7lH9ko?=
 =?us-ascii?Q?mq/QMVINH/Ed+AG8MbW9muJQ/pYfsQYXo/a9/oMftfmT/eCwqrS/2msFGOTd?=
 =?us-ascii?Q?MKqkP9ZudxdsjMWcv12le3CQO/K4JowKKPdgdU9L7nEVYq3/GAAC7SgvGKfi?=
 =?us-ascii?Q?3QtpSccrlvMzOkwYAyns2uAa9XPAZ5sszkBgSgN+yIGiNhfraBVuniQZBF5E?=
 =?us-ascii?Q?xEp6UMcaVQKTiaTqf9ArEiNhF4eMdIS1quHUW7ovRCb/5ZkOvJNlFbYmRffx?=
 =?us-ascii?Q?mVbcDDFZkefRskcztDfEuNLEkE0wS+9x3pGJf2hlsZwFcc3DN3h+zS56TS5t?=
 =?us-ascii?Q?ht3Kdj5Bm9+esV3ntgwdhpGMPTkHYyojb2iIeljBYSwM2PE+fQ2wwqM4EZ2e?=
 =?us-ascii?Q?jRdF0T687/74yvOLlAPgFPRbbWQ4KrHmIlWmbcI6p3n5+lIS1pQKzNbcLptU?=
 =?us-ascii?Q?bLlXgLMyGRF+ElaTHiV6hSHJVLGpbk1T3xokZvbvcXIsQqoI1dw8MrsX+L21?=
 =?us-ascii?Q?CLikKgvV2crT5CVPAodjuvoH6S022osHqZmtOzjptJEKuxiZZeemdRaE8/2W?=
 =?us-ascii?Q?ZX7wdzSWPjsLCtP6SO4R65mjt7xDw4LIUOBFyeJkx3C+d8HeL3vBV+w1bGlB?=
 =?us-ascii?Q?+qD5g1FgV06OkPgj3pMMNDJ0pIgxsSa7E04/mgI0eoPqUJm8wcGBVdOnvkLV?=
 =?us-ascii?Q?TE3Z+pgBiBYv2gzOnUN7c95FdtYCsSjU0LE9TQrq5UufrMK5AtkL5nWNI5cK?=
 =?us-ascii?Q?Uqvhx3kkWpoco67QeANwkUt6RN164FzehxpbHYfiNa0lhANS0vb0fK9JhU4m?=
 =?us-ascii?Q?nCnGIluNJX00na7Nuo90qdx1ntjsACckcui1trhKDEK9EFi79+TllnysTXaf?=
 =?us-ascii?Q?oNy/Q++26yiU8/ImfPFpIO31q18DuiwupKSLPgC4xaQ0BExSaIbLG87sZqkU?=
 =?us-ascii?Q?Kiw/ayZn4O2mR4IXkvhZd15hcDB4jnLFl1GGOLqBk8rAG+DsJ4SmhoZYD6bi?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb20e8b-6dd9-4198-3781-08dcd07df89d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 03:17:44.2491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvuUFljpc4ozdFcAGA+SEkqa1f+5cDK63u6KVrVwfFSG/+y3tqC0Xkfr3zNXhtVJmtiI0fl6dwR3xKsLYS5eX9oWp9gYiVgJrh1ARvxBe0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6390
Received-SPF: pass client-ip=52.101.128.142;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

The code 'ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));' is unnecessary;

And, the following code :
1.has the same functionality;
2.includes error checking;

Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
---
 accel/accel-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947dd82..5d502c8fd8 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -73,7 +73,7 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
     g_assert(ac_name != NULL);
 
     ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
-    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
+
     oc = module_object_class_by_name(ops_name);
     if (!oc) {
         error_report("fatal: could not load module for type '%s'", ops_name);
-- 
2.37.0.windows.1


