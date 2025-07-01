Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E1CC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWhgF-00029x-GJ; Tue, 01 Jul 2025 16:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgD-00029D-DS; Tue, 01 Jul 2025 16:34:13 -0400
Received: from mail-dm6nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2417::610]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgA-0000gk-K2; Tue, 01 Jul 2025 16:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddG6vyN/6A845AcHKEm9U7+v3qZj6Ohr4bV/Nn5BXZpS203n7SKpE4bOFaFXQQkFNRT45COUi84Bqo74bPn94OCP0vRfZ4dAg6P0iQRhUWztnOosB/39DtjLcVFyZjXm6WtYOCzfLVsIi7CDOPMz8SoQamhbquTwLWBmshQ8dz6dkMxCUTfSaEyU2N1xVvHYVEzTq2gxSLInMxfqGZe7TbRqW9zBgTfNj/JaCj4QJL/1ryPBE1sqFZ7Xc2UR3cNH0R18pYDclL4gEc4TtdGqGJ/lihvRHcs13q46HPP1y2ngY4Udpb0NKuN5OR+GgA9tqCXyRZa2bIU7seeSJCjplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqGZ4Iz5DnweoWSeQYVC6GVEHlBwHC5bKxz4PVh0YS8=;
 b=pMOjw75Lf9IpZLinEuQ7d3FPbnE5AjOhyMAUOliMfP816yKxiOtG/uy93TQUhFSPSv69bmdGE9+8dhuDQRPFb0iG0seRkjpU8bl2QOGw50NB9ppnOm9yY/ATdDPCMaS1OCUe2okwptyPZ+/I2mTyG7uakWKtgkxjC7M/uZiJUU7KEH3vlB5C1d3YYktR9qK1dP8Wllv7I9eXAmnOnFPAFtuZYg/Q13T93ujTPvHT4Uh6NcKVvUQxAQyMU/8HxfRy0FGMZRH4xhMK/XHRgTL91GhsJMQl/8ATAFnbIpdWUl5Uw/pDij9F78744WXSlYEIyQdDGR+PUvutvgvhnxXVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqGZ4Iz5DnweoWSeQYVC6GVEHlBwHC5bKxz4PVh0YS8=;
 b=VMF13ggcL1410H7GdRfmwiOrWdin0jixsfNsQMgW2cXSdvgqnUmoFMfGDTkND73cMB1aSFf+JEu547EbgDFbrLZ1ey+RijPOJdjzJavT38YIG17uT45Dt1wqSCWK6E3XsYfFyzEXJDKG+RNq/VocLxQ74zrkeRYp2nNTlHA0Mg2XkTLbTA4Vrmaj7Fw8FjmsRxVHNCk4ea3xT70UNS3M29t3ly6NdNWRV8+3EE911KIAJhTcHOcqLIR2AZt+Q0Tg+ryEoSo3OmijAtNdRmjH90nhRt3guGM4Pc8FlrSJfC+ECeZYfAYPUdsB8MxR6vXxpKFXpOXyA5CY7rtDc9md1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 20:34:02 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 20:34:02 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <etanous@nvidia.com>
Subject: [PATCH 0/4] Add support for gb200-bmc machine
Date: Tue,  1 Jul 2025 13:33:56 -0700
Message-ID: <20250701203400.71677-1-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c42915-2049-43bb-95bb-08ddb8de9d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjNVV1dwYlRNTGx0emdHaTByODBPaEFVQ2dOL2Zyd2FUd05JOTR5QUtDc2pi?=
 =?utf-8?B?TjQ4OHBDWU00L2RqQWJLTGdvNDVZclVlVHhIb3RvOTlGaVVvVkRweHR1M2I3?=
 =?utf-8?B?Wnd3cUxzaXNnRFE0cDd1cmxUL0paYVM4MUd1Zmk2eTJSOC9aczVSWGErS0J5?=
 =?utf-8?B?UGhVSlJxczVzdjVVT0s4Y2xYTFJWeno4cXQ1OEFickZtS1R6azFFbFU3QU5z?=
 =?utf-8?B?NmRSOFhLRk9nc3dLOTVHWVVZRnhiUG5XTWQwMHA5SEM3Sjk2WkJEbSs0Zmlj?=
 =?utf-8?B?OXA3YWJrUTNTRlVDNDZ0c0RLR0x0NGgxcmZUMDZMb2YxaVpVWUFNdkx2RHNS?=
 =?utf-8?B?dnBSSFd4aDc5eVNzUnRLYW5oZjFHSmFwVmpYSDk2aWJyakx1c1lRV0JPb3Fl?=
 =?utf-8?B?Zlo3NGdKSllTbklGd3ZnR2RWZ1N1MHN2amw4YW1XQXBxZ2xuZEdMNVNVMEd0?=
 =?utf-8?B?UDliVFYxTVJrNG1BZTNEcjBUU09nb1QrN3kxZWlqVzVteHRtZ3hRa2g0Qmx1?=
 =?utf-8?B?NG9yemprUVl3RjlYcTNtUHBaZFBTR1ZJOFV3Ull6WXl2NzFNSkZIYVJ4OEtS?=
 =?utf-8?B?S2ZVUnhNbWl0L0E1Qk1rZW85d0kvcUJHZ1JYQ283NGZXekRpcnhNeVJLL3F6?=
 =?utf-8?B?Z2NBZmdMMEhwa2NjTFVOT09HYklDemJQRVVISFIwU3l6ay82d0R3cnZXS2Ji?=
 =?utf-8?B?M0IyR0FVUm5tMEdycXBTdlk4dExGeUc5REprRnNQMXAyd0dLWkhYTVRYTW0v?=
 =?utf-8?B?TFYxa0NWNnpPQ2VES1cxT3d3b3BWMllpQTRqaDhSdmM2Q1k2ODJWSlhMMStJ?=
 =?utf-8?B?VlJGMWVJdk5lZS9EWWZxMDNqZ1A2Y245VjVCWVE5SFg5OG4wZVh1NG9rTFRq?=
 =?utf-8?B?YlpXMjhsQUZBOXFIUDkyZmpvNngxeWN6MXBKbktjYVh3U1JMaEIwOE4xRi9G?=
 =?utf-8?B?TVhESm5IVUhQQUF6VnZpSXNJaWZsOWRoVFpiYjRVMkJsd3hMOVNQQ2tXQ3hx?=
 =?utf-8?B?Rlo0TVNneFg4WUw0aDNUWUU4MFkreFFIb09zZmZuYjVnOHlsamtYREZqMGJS?=
 =?utf-8?B?eUNkc0lLNTRHd2R0T3Jnb2tDa3VrMVF0WG1SendSeWdoazRTZURUeEYyYldw?=
 =?utf-8?B?SDQwcGpaamNjS0hMRENvdmo4b0tWYmNENWhOUEFtTmhLeWdsK0huSzd3aElU?=
 =?utf-8?B?QlNQNmN2NWtGdGlKOVBVYi9Wb0xUZURmT0R5VWMwTzNjNFM5a0JQY1k2ZVBr?=
 =?utf-8?B?VDNxUDRlZk02R0FGQnFHQ3lXVWNNa0RibUc3Y1QrQnZjTU9vdUNEOEZYa3pN?=
 =?utf-8?B?QngxeHp5cFU4SnlFbjlueGJKUmJyMWJVTDVsMFdyb3RTV3d1b2NwcWZsVThz?=
 =?utf-8?B?eG5GeHlUeXQ0QnRQeFJHSm1Xd0tlUm9sR1kxZm8wMm5BN3FnNkF5dUxwMVly?=
 =?utf-8?B?WUVpREJXdmpDV3ljTVVRME16blVyWnVMV0QzUEZhaXBDQUF1NnJjRzVYbnhi?=
 =?utf-8?B?QjdBczdWSys0QnlkWUo4cGNPQXltcHBFaENmd1Rzd3V3R0hHTmhjNUo4cmIy?=
 =?utf-8?B?TlYwNnBNRXY5QmI4Y1JmR01acnlBSjNHQkdDSDMrZ3Q4eXpDc1NkbDg2MzBR?=
 =?utf-8?B?NXF0c0dzckM0cm9ib0JLV1hhTks4WjkvTCtMTHdQYk0vYi82UUIybHVwOGRo?=
 =?utf-8?B?WnFYcXNCcEt6aXlCMEdaV1M4OGhHS0ZWYklTSHJDSWxBS0NTTjM2VEZwYVlG?=
 =?utf-8?B?NUFGVEVKT3lVdDN2czNuelhXdDJoQW5kVFN0WG5VMElvZVJLWjhNZ2tuZlZ2?=
 =?utf-8?B?eGt4TEtZSGdOdUszdFZiaExTbk84QlIwWlF0L1EyczZ2TXBlQmZ3QnB5Vmho?=
 =?utf-8?B?MGpFcTFHK3QyQ1NQY21zd0pMTVJEenFtQ01ZZ0lsM1F2REJmSVJOUm5OQzlX?=
 =?utf-8?Q?/jTxyzT0brQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFLa3FBTFZGcUliQ3BVSC80ZFpnc2hqOHgwaDhtekFmeVFvV1h4cmRHS1Fm?=
 =?utf-8?B?ZzBUeDBPMVNUMFhhWE14ZWFRTXdaOUJoaHQrRHdHTXdzKzNWUUxYWFVxenp6?=
 =?utf-8?B?VHllTTZsamxhdm1vOTFVTUlYeVk2Z3h3azBEUkxHTzM1dVZmYjUzMzk3azRW?=
 =?utf-8?B?a2lra1RmZUVnWmdpR05jSmR3VTFlWlVWbS9wMlQyZEpKaUJmMmNyUTlYeTJ6?=
 =?utf-8?B?Nll1cWh1Znc3Q2ptczN4U1ZsU1ZxVkpyYnV3ZDh3WEYwVU1hdndRTkZieXNE?=
 =?utf-8?B?TnNaL1djdHJodjFFUUEwV21Ddys2WjJmODlwZ1VJeVlEWXN6OUVITy9HNito?=
 =?utf-8?B?SkhHbjQ3M0NrYlhXNGJlYnRmQ0NuVjBleVlqQXc4YVUvNnJXWHFJc3NsaXJD?=
 =?utf-8?B?Q3ArYnR1am42ejZpNU1iY052cFFqTkRhY1JCczBVYXlnM0FOeGxFRlhjUjE5?=
 =?utf-8?B?aS9nSXVPcmtVMEg2alUzUHNNK3ZWd3QvQzRwS2RvZEcrTHNzTVpyWEVYY3pl?=
 =?utf-8?B?YkZObDdEM3krSjBVVjZzb2krYjlyQVM3U2xXN0xQQVNPNlRiQW1qRm1WcEVJ?=
 =?utf-8?B?a3ZrY3dZeFIzWkhzQ1QvcldBTks3UnJzcUV3SHNtdTVRb3BBL0twYjhXcjVG?=
 =?utf-8?B?cW1jNlVlbVdEUEJJa0E4T0hCUjFnV0MzYlBwcElOUUU4cWVNQ1QwY29BZTN2?=
 =?utf-8?B?c3Nxd1VsV1QvZk1OSFlxdFEzc202clZhU2UyOVJBTDJwMUJCYTdGa3RXS1pM?=
 =?utf-8?B?aTJHTHc2ZDBQM0VVZFQ3RE5pc3RBWEFWVnBzSSsrb1UzSFlReXJnek53c2o5?=
 =?utf-8?B?VkZXRDJCdEVRTW9neURmdDM2aHgvZTVaOFk5K04wTEFmWVNWL05jejgrNW5o?=
 =?utf-8?B?RE1JK1ozWGZxc0pJT2c2ZXJwbU8zQlc2MEZYWnN5Q3ZjTzA2Tkk0WXlaWWNa?=
 =?utf-8?B?Vk0zMGpCNlVtNUdpVWpIakcyS1JvZVdZakljNzF2N0ZuYUNCT0NIUlBIWnhN?=
 =?utf-8?B?L2ZnWjNtWE9XSjVLbDF2cVJWVWFzUXNrbzBKNGFpN1k4YW1DVFBDRi9LK25p?=
 =?utf-8?B?RlFvb3lCS0NIcm9sZUhUYi8zekZKSFBLcTVUQm9KNDQ4YjdveGFUTm1pckkv?=
 =?utf-8?B?RnJkSDBPekwzRUVHVUlSVHYweGFyWEJaRGtRd1VEc2ZocDFrdGtMaVl4ODZT?=
 =?utf-8?B?b2g4RlFrUWJqWm5iM0lvOENsTksxbXNRajZ5bWRkdlpGbmszMkV2dGZvNVNn?=
 =?utf-8?B?bkZMZElscEQvY2JRTnluaExCTmZCcnE4QnN0ejcxUDVZaVpnQTFxNDI1ZkRO?=
 =?utf-8?B?RjR2R0ppQlZVdXE0dWcrRkxCMVh0aW5RRU10SDU4STJCUVVpN3NYTzBTaUpF?=
 =?utf-8?B?WkxnSFdUSzVBdklocHJIU09LR3VoTlR3OFNHTjFqZ0lHUVVuS2JVcW45NSsy?=
 =?utf-8?B?RTJxZHZVZ2k0VnQvNjhXaWxNNUd6ZUZVTHdZNktrVmN0aVlRUGptTlNzSlVO?=
 =?utf-8?B?dWJITWtCVXdvWnJ1bUYyS1VHcndFYXJWWkZPdGhKS2Jrd1FlSzdPNndSQi9q?=
 =?utf-8?B?OXY1azdZeTIvcFhBY1RndW9IQXRXeFFCRVF2WmlUOUNFUjVhNmpEM2c1L212?=
 =?utf-8?B?akFkNU9oTitEUHp4M08wblZ3andqZ0lhTzlsb0NFdEhJbFNRYmpsV3p2QjIy?=
 =?utf-8?B?NXNzZ2h3RHYzVmxRUFFXc2JVUDJ1UElhQ3RidW94Rmc1UGNQUlZTeVFId1Ez?=
 =?utf-8?B?eDB1QWZHT3UzV1d0VTZ6dENPRWs3U2pFZ1pMazR3Q0pZek9nbkEvYjB0eSs3?=
 =?utf-8?B?dmcycDQzcnpTRTZoRzJrNE0yWURkUjdwMjZDcmwzQzBUZHRmenpQbG5pZllU?=
 =?utf-8?B?bjdab0xrVUlTejdMQWVHR1UweFo5NC9kSUp5RmRpeXVzTDVBWUk1T2VYalhH?=
 =?utf-8?B?aXB3US8yeXN6SllMSjJBajBTZjhya3p0K3Q1SXUvK0ZZNHc4N0JhKzhzWGtB?=
 =?utf-8?B?RGkxeHpmRjlMQ0J3OHB5MkhweWc0YWFZdVFOQmlYWVFMRUZhUnZ1ZE5zTFph?=
 =?utf-8?B?K0tieG90YWtZSXNORVhHV3M4OVQ0S2Z0eUtkeG9mVVZmK0xYY3ZvQWJ6NGRi?=
 =?utf-8?Q?aFP9gAG867oNu6n45EUIRrGRL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c42915-2049-43bb-95bb-08ddb8de9d92
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:34:02.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4d6JvopKk/8bWYRFhipznoJkQVSFprKpAggaf6rMM5l1BBvJrZug6r/Okpp8q1x4O5pRuH7HGrcX3Q9JHflUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
Received-SPF: permerror client-ip=2a01:111:f403:2417::610;
 envelope-from=etanous@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds support for gb200-bmc, a baseboard management controller
module based on an Aspeed 2600 SOC.

Ed Tanous (4):
  hw/arm: Add PCA9554 to ARM target
  hw/arm/aspeed: Add second SPI chip to Aspeed model
  docs: add support for gb200-bmc
  hw/arm/aspeed: Add GB200 BMC target

 docs/system/arm/aspeed.rst |  4 +-
 hw/arm/Kconfig             |  1 +
 hw/arm/aspeed.c            | 81 ++++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c     | 21 ++++++++++
 hw/arm/aspeed_eeprom.h     |  3 ++
 include/hw/arm/aspeed.h    |  2 +
 6 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.43.0


