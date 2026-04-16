Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB9F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQAb-0002Yp-BV; Thu, 16 Apr 2026 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jerome.Forissier@arm.com>)
 id 1wDHcM-0004Av-NZ; Thu, 16 Apr 2026 03:58:30 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jerome.Forissier@arm.com>)
 id 1wDHcK-0004q4-03; Thu, 16 Apr 2026 03:58:30 -0400
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yl2qLvXwygkE8OdJRfdHs4K4lNGfYkB/68sDNo0UbHyJi/zN8gm8oJ1cw8zo8tHWpcf/UH5leC/HeJh+b83AZwAILD8kx7W0U9BS5p5exax2KTxLhJza2GifEgYoP979qasqoKwsX0rWfA11083XAdXXt5y4K8a76/oEb8OVlvkdcDdLR3wbcf96WUkllLWWQ5q3ym/eL9lginG3isHf2LpwDU46c+daSYHI98XB5AbFdePwMdGVDIEXokqxPfqMVxQm9nEoV9v29ZqQHnlg49GTPjLVIIhVHOO4oBlxlngrYeQWbBKhF5s2bgSKKPamEaHozc0K2bt7yU6QJ26DVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLxaYEwXh80ygWjcltfOq79ZJaKurBoo8/IaINn1jOU=;
 b=Uam0DXbS082U+BW/Q0x0RUctZU2CdchTnOxEtV/xfDUHzqWbfPSRbNgBG60xRkksCHok2FnNMZ4L4h6bOoQ4a4NWYjqa+BYZVSlXU4K1qbTiUf+IYHAOEiMocORAEcEXSFV5MY2pVUQN/zfk7AsOz87XNwm+2vdsW1izXH30HiBVqkJWg7GvVsAq3EPwc8kU0YwZhKGgzKwUJ+UrmZKxrVWxFNFiLgHSvl94onm0uDTR+nPkBTh0jLD4bHjlr7UydQYvE8wyYAUyhyNttoXTwstyZ8J4bMNdayLt4p4sjx1AkVYJOs7d5uRGb4xWprODXwGNZzjq4acghcK1Kt/atw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLxaYEwXh80ygWjcltfOq79ZJaKurBoo8/IaINn1jOU=;
 b=kod/Jo2p8+INmtTCSbYPblAs/9sf0WmkvgSUBKhzTAzsMFPr6QYvRWze4HITRbaUUktCzPtQOLcDD5PKBggi80P6chh2wZ/JTvT6u4Yft0qQE/++6k7n/7Jx5x9Gpkt5xO0H7gxuwC1/AlmeCMfKAHoWe6w+43qd/3mhnFj6Cvk=
Received: from DB9PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:10:1da::19)
 by AS8PR08MB5878.eurprd08.prod.outlook.com (2603:10a6:20b:29b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:58:18 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::d8) by DB9PR05CA0014.outlook.office365.com
 (2603:10a6:10:1da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 07:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 16 Apr 2026 07:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE7OVxk91uun8aSUwqNdxwXtreecOXZ9KQU5oBf6j2JiCeKgfoino4crifz9p+3aNipK9s4y9A6LH6DOksSE3MTTREbxwkEaYYw4Tkuoha6NxRAdnM27UKBGKU2H2ltDbELzpa4EFqHNtb4NBa5NQU/2IeT9QIQI5wfjQ8O1qw/9UAYVKRqBstA3MKb1gYRpJyNHjv/dSO1esq8MR+BqqBBsgAxXhR+0CKTvSqhGy3UGcBAaQexEVSNdBsbFnv4klmEb7sXPo1NkRfyq/G8lZ0GmdH5kH5Bu8rpfLCvjQo1A+leCgEZbaeHkcrpalAWyIQ3NqkXsGa66aYEx5O72vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLxaYEwXh80ygWjcltfOq79ZJaKurBoo8/IaINn1jOU=;
 b=fAQhDxifahtqg+qdBabrbL6cI10Ugv8kupsZM6Wo36U6YAlEce8BLAD7IdcmeLYchQ2zQ3jaXsQIq+NjuSVGwq16FowZ4yNKJ/S6ubMOnMzucIoZZLWTmYEpVhU2ZOivq+/qi8BUwRDmtsA1mmkNHVaP3Cj8LUSelyw5JAJcmeFDZklavh0SwHt+kH1m81vqud0hE+1JmQwBEjm4ZTMHYw7W7rF8AeC2qqHINYDaZBkRlA2MCLzv/uWh3jZSJdy1FVmnIMBbiKPJGRJDuptcNzRoY965j7PCPNY10QDzPJnKfOivFi5IBmoRTWkT9Z2lWCvuLiXrJk9g1+C5XaHuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLxaYEwXh80ygWjcltfOq79ZJaKurBoo8/IaINn1jOU=;
 b=kod/Jo2p8+INmtTCSbYPblAs/9sf0WmkvgSUBKhzTAzsMFPr6QYvRWze4HITRbaUUktCzPtQOLcDD5PKBggi80P6chh2wZ/JTvT6u4Yft0qQE/++6k7n/7Jx5x9Gpkt5xO0H7gxuwC1/AlmeCMfKAHoWe6w+43qd/3mhnFj6Cvk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB10947.eurprd08.prod.outlook.com
 (2603:10a6:102:468::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:57:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 07:57:14 +0000
Message-ID: <febe1e94-2611-4140-974e-52c502fb9d4d@arm.com>
Date: Thu, 16 Apr 2026 09:57:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sd: Small improvements around RPMB emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, nd@arm.com
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <a081957f-4d23-4aab-ba5c-e0ed2cb75c6c@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <a081957f-4d23-4aab-ba5c-e0ed2cb75c6c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB10947:EE_|DU2PEPF00028D07:EE_|AS8PR08MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: ae513130-988f-4001-2303-08de9b8debdc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: gkhAX8O7JpUkyj3IPMf6Du7hPfYSF5lc0fxEyuRwo4Olfjar0+BtEUV3w6BAzKWYhy/EKxS++5N7aybuUyk5eQhrYU7R92DmHqsxOsPofsj3oroh1fXphNp/HX52NYn8TMTI5NuTG2jAyOqwThAMyxkn+hz4ZO6S5QjK13n5GPN3HYjJMqaHiajkJo1rVYHF/FHtwg/Ve/vzSr27lTs7i3tSn4ygxJ++orCpU8MTetShsxzKhMsVhhJEYA6vK8RE1P6apDQA+tEYpjGgoBCH+XL/+HFNY7fhvLHc3a7qwlSL0rMS0kUjwZsuQFFNN+L8nuB+VPjNdMTXjV34c3wNScRVgyTTVTtn5/Gg0TqibgstM5dlhnbUNKli1c/OGmFaqCbNTxMtlkgsVhnMweWEnw20WtD1jRjtmDjDBPm6KjXuqOMBn3hrJjFAJVNqzN8f7Xw0hoaJz59VzHAztLSAG7VMlzFSdGTyJpTZlkxqn7EvbCvgxt9ZxAqt0EjYzG62ASQA88vgIiwAh4cpeQsPyIp2oANcfLdXjG8r9vF2kCXFtHSkDNNI5FHD3j4c+gT7vpleEByoxj+TIxrub6WJsLxNBkJufKp+NvJX3G0HB8XflEUfpiPxmaTejWJ+yX9bFyXREzRkrdKfAJdhO4CYrZghcReV/tlBECJlYwjvstKfgLez8gfnc1iYwjccbg0pIIhBhz3+EyUq7Ixz4ecrvYWWyAHmv5dF+Ql4CONsNt8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: swcDQTvl09pK7C+EmkDiA9AJ45MG+cP5yfLqLJuyXMIk7IFWiBIsZcXcPgRUmu5L3CFvyC/HEUbfvktMXBP2pl5O2nbdy5+AlayGJtKbK8rCO3DwXfu86iFZP6kolGwlHeu9EySbV9PYOAoPafwFIbGIdBWZf4Gl9G+xoCdlkvKOdH8ZmS1U3cU7oBGGpGTn77tFKqsodNU9xWtPxN0YqT9ITeSCsYAlI7BKtkW97v526n0sDH/J9Ev41NaT0GLhYp0O/ockHbeeMCZsHzLlBR2g5uZep34J3GwGbnpFEnte2XGWR1J6YYHc6yxCs9E1wAbMoZF5aZ1MGOQWzm76tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10947
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3c613d85-9e28-45b9-b4f5-08de9b8dc590
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|14060799003|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tONbjd5GXnc63VVhFUDA+U7Qh0WpgNKTFtShus2Ij4WVTh6iXLtYlxvQ0GTLVH7RDLV1KUVofW5IDwXVKPpc/PKeMJYO23vVtsfrBwqy5bMl8L3suLR62FJo8Jq5HvR0rdKrrRqBfhIL9kOf0Kdadu1bqXD6vd+aQtsECZ5iiIykmObZo/cuvV/KOuyyv1pPPpNYrxxQBPRZw2RGNlYp6ULAqKNbAWalu/cVPIXxa1o7PdTomkyXQt9N+FTD27+wwTNHUpKac27nY7OGJvsKFZkuj8J+JoVJC1mCL5hMMSzHfp+cPLEVvMlWXBDB0YpZzhQUuv594LMIi1T1zEOgUbmQMRYNkPfP+c6YdBeBAuNZeck54uRlUkZOpHTnY+wxD7tzcqQfx+vSi/CK3irX+oTr2oIasoDlN3ZgmZruzEE/rA4abycgP/Y/Ghxpwu1E9RXd2z/WAwRFR0YaBgkuuZYW1lLGwk2I6YdWZDvmutTnSZ7Rl82mFddKqlJrphHhg/0uEtY5HcL8wnpxKMk0ibAjUrWPjefLDSxQSWO7VqyuOm4jpSnQ/soZnFdg5ePE+I8TL8eKVq9cIHDj9b9uLG3ximX+iTkIY1nHak5GxZZUqY7W5psWpfFe1HPTAKRbsWm9VoDpJeKvagM0vaVcWZOKtCUr1k+WAotspAnypowxCwxfoJUC1PAWGUQ49PDuPbOrQwoOOAFlLotaFiZRnIQ8phWMqHRHMZyustYpOt0u2+D5TXwqEQI5lhY24AWX2b16esPXPb/TlHjY09tnMg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(14060799003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E7Zw05mKD92HqBXcBObNFBF4/S7ZZ2ahnr9wqrYk42YppTyQw+QTtcuHkg1ShlGHJpltEMtheCkidlRIuJP8q2taov0+9AIXOqweTCKI1vXQG/MtmfKeqaIq6iSLLx8cNlIbDIwetUgbm0DiUCHLwfFjLa65XqHbOj2weT02+Yb82Up4DnWoZ0n06ZfROiL8X7XlRX/3Jy+AOhE3wqQ7WW88f6AJgMJPKy7QuFjgqURrIUjzIQsCL+85U+Wq79EcpQpRCE7Qtt8E7IvpRJeBFbBLixB5/3rdLSowzZeAlf5N/q/oek4Wtvm0/eH4RpRXe5cjswg75qpgEFO1lY1jT06ozOlcm4ZsHAagQO/S9ltAQQpLj6w1Q+iNmvuZIbk1oFb+fxwv1IAy33Lrywvs4Ke5of9f8s1PCEFXUhHAp5IEXKzy41iQlHIgaH3/ruW5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:58:18.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae513130-988f-4001-2303-08de9b8debdc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5878
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Jerome.Forissier@arm.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 13:06:24 -0400
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



On 15/04/2026 22:32, Philippe Mathieu-Daudé wrote:
> (Cc'ing Jerome to his new email)

Thanks :)

> On 15/4/26 07:46, Jan Kiszka wrote:
>> Besides a cosmetic fix for the emmc disk image generation script, this
>> adds a property to the emmc model that allows to preset the
>> authentication key. And that enables to build OPTEE without key writing
>> support, bringing the related firmware much closer to real setups.
>>
>> An alternative to this option would have been persisting additional
>> state such as the key or the write counter on the disk image as well.
>> This is still an option for the future, e.g. to model also write
>> protection groups or other persistent states. As this requires another
>> format extension of the eMMC disk image, I want for this much simpler
>> and less invasive approach.

That's coool! For the series:

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

>> Jan
>>
>> Jan Kiszka (2):
>>    scripts: mkemmc.sh: Fix output pollution on missing images
>>    hw/sd/sdcard: Add support for pre-setting the authentication key
>>
>>   hw/sd/sd.c        | 23 +++++++++++++++++++++++
>>   scripts/mkemmc.sh |  4 ++--
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
> 


