Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8827E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7SS-0002Jj-4W; Wed, 18 Dec 2024 22:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO7SM-0002If-Fy; Wed, 18 Dec 2024 22:44:10 -0500
Received: from mail-psaapc01on20709.outbound.protection.outlook.com
 ([2a01:111:f403:200e::709]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO7SI-0004d6-MS; Wed, 18 Dec 2024 22:44:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD2F5Zm4Darl79lfMN04Su8ybZx6bAZM9SDbMOWOv0+EhckJJsU7NU1PC9y/Fn+beF+1gM3CbvslhdHhyEyRli9seQluB1NJmqtH58YGQ4Kc5VjhgDnP4nRfs3zpxiEDGiWXsxN8+DLRNtrpz81nVmehGuD5Q6UWD12Ibce6QEO0g5SqNgvhEe6fF0SnL1+doApiVqAvPlyy/2AHi6rvFbf8GcREIUtmFFx6yJQ1F+9l/U1bK/u9Mdp1MY83LbXKE8yNB5hbrVSfiwqK0FRIFrjWl7oQkYfmBuZQBRzhdNLikgulnkDewGwqX0iVhmdGvxHKM1u2/4MFE1peO0Xh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZjyjQN0TffYB9GY+3kasOF64l+SxEvW3lWGSIyGP3o=;
 b=WOTzJDkzTZLzaVG8HHA3UWo7+4EN4eopeWKJmmLJwesCZOne1kjlp6RpFpVVpGqBaZLcQ/dLvx0DVeofuRy+aIkmReIQZJMs8hY7KrnH8CSRT3E8XjrUaSp1OsQixysFOO8tgp0N2GrxcEKnj3eIc/qxqwXbWzHGt2sO+0sbrT7UQkkoNj8VYWXl8NlwaB4hZ7BbkI6Y43weIO7mwjRF0SbUIDE9pA02wooeRGZt63/KjWbe2wqy6ioLgCaDW1V+7bTVDhn/bSJjz5WlnZzzbBRtXzBpAi8Tybom8fJ8lvHzx2zuhwhV+RYqwKH+w6tZloXATBNVEeAt7ABp2num5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZjyjQN0TffYB9GY+3kasOF64l+SxEvW3lWGSIyGP3o=;
 b=h+T2xSM06uM+SJaBa9KnbXg+i/jzQ4CKiLqUDirhQfZBjcu9//AELv3tOsXZz5yltgdDruByXjm80SkvdVmHm3G6AmZBIbndEB8E5q611b2QdU2cNJcabHp5rbrlGne17VMRZhWKkavAPnhGBVeEO3TWHhcINDq/3Y55ahLrld/iIwYjTsLxgcv/UJBhDZVtchJfB5UdiG+joTj/Z/Ll8CLQIiVEu2dbo4vSUau9o2s2Gs+EFkec6y0QDlzACfA5V836qn6+sagnD3MveonhtFq6tCz1G9cPNy4XJ5IKPM3fKsVFn/PI/STv9WVhcrMN0dsJtpLJ0GlMn5MDF1NaOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by KL1PR06MB6963.apcprd06.prod.outlook.com (2603:1096:820:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Thu, 19 Dec
 2024 03:43:50 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 03:43:50 +0000
From: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
To: philmd@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me,
 jasowang@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Subject: [PATCH v2] hw/net: cadence_gem: feat: add logic for the DISABLE_MASK
 bit in type2_compare_x_word_1
Date: Thu, 19 Dec 2024 11:43:03 +0800
Message-Id: <20241219034304.747-1-andrew.yuan@jaguarmicro.com>
X-Mailer: git-send-email 2.37.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To KL1PR0601MB4891.apcprd06.prod.outlook.com
 (2603:1096:820:ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4891:EE_|KL1PR06MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: ac25409e-d666-4721-3e05-08dd1fdf59e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkFWbUdNK2dCalZxc1RZb3dwWU1lUjJadE1PSWxJYUR6RWNZR0hkMHlnVnha?=
 =?utf-8?B?ZFNXQkRQamY4b0wzYVI4RXBwUGR0UUpKeGVkSXY1WFJycDlRVm1VdDVBbVgr?=
 =?utf-8?B?UXk2SHB3cHZ0N3pianoyV291SmhRVFNtSzhmeVZ3T3o1TjkrQlBDb1NSMXN3?=
 =?utf-8?B?eWhNcDRIYW9ERmtjZi9HOTdwSHZIa2taLzk2enhjTkRORXNVdWdpYXdkcFNQ?=
 =?utf-8?B?eVBPa2d4OHl5UkN6VGlDWXdVZkRDa1lvK3p2VUhqUm5hZDJHSlkyWXdoVTN2?=
 =?utf-8?B?a1lIWjhvbjA1YzhNM2Exc2tvRnFRVTg1YjdQWmxweldLcW4yWU9QS05uQ0VO?=
 =?utf-8?B?MHJ5VWxUS0tjV251R250MDRyb2dXcE0yQmpIellabkdaRDZwZW1CK0JFeExR?=
 =?utf-8?B?RWh3QUZCSHBhZWxCc2VlOCtCOVVMelM3RXF6U09iYVJKY20vbmFGZ1J3YW1C?=
 =?utf-8?B?RFZDVXRJTkZySXFvQ0luTnlBTURiOVdock96YzY3Z0xqNWJWUXFqOTN5by9J?=
 =?utf-8?B?VExZNEJLNWpUS2hSWkpvY2MzTWZZdE9OMjVKa2xFMWdLTmJlVFUvVFRBbnNr?=
 =?utf-8?B?TDFJOFF4TWVpVkxOSkZ3M1ZoWlhHRmkrL2M0Yk1wSXBGUU9icUxxSDNKQXVY?=
 =?utf-8?B?c0lVR2h1eEdsSXZCRlZxOERDdmNVK2ptdFk1QTBUay83dTg3MlZiaEdZRzc5?=
 =?utf-8?B?bWc2RVlrQWdYdDlOVHpPR25WTWtHVzhTRWNXS3NubGtESHdYcjVBRFdSdGxN?=
 =?utf-8?B?aENxaktJMitpM1BjRVJhZ2EwOFFqeGdPbVJINmQ4a3hySFdPNnArVFJQcy9H?=
 =?utf-8?B?MUVFN2p1Z0svNndxSlNnckRvVE1KaVFUeDlmclJ2bkJsZmkrZHlvTUxGMkZs?=
 =?utf-8?B?RWhjTnRBWEw2VDJkVVFTd1JvM0lpUHoxenRpdWphQTJxRFlJMllpaDFoOStN?=
 =?utf-8?B?Y1JMSENxekpIc3pqbnltZldRRU9sZ1N3TmRWVFcyZE5FcXBUaU92ZDFBaVFp?=
 =?utf-8?B?bUI2TGdwMmp1enk5RXphUTkrd0Q4WERVK2tLZVp6b2dJb0RIU3VHY3ovMmNK?=
 =?utf-8?B?YmV3RlA1b0cvaXgrNXEwRHNhZ2REdXg4K1I4dGtOSVFpbS9mVmNxTE5KL3Vu?=
 =?utf-8?B?Ylp0bnBEdnpKME5zRk5qSkJGYzVhK0xKS3lCak5rL0N6YVJNVDd6NE1vZU9o?=
 =?utf-8?B?NTc1VURqWXRwQmRONUpKa01WYStMcTJhQTdENVMxOWltc1VYcVhOQWgvbndU?=
 =?utf-8?B?NnZsd3dobEVodHQ0My9DV3lJRU5oNDVXb3VZam9mdmNlekhKb1JQM2taTzQw?=
 =?utf-8?B?VGNqUGQ3elNsaVp4RXRENlliY0pTZ1J3WWZvNkFZMllNOGNpZG5BenRNZWZo?=
 =?utf-8?B?eUtnYUo1Y3VPOEhaY3Q1ZlROWmdubkswZmF3ZUZjU2hNdyswbDNtUWkwVVRu?=
 =?utf-8?B?QW1CRWFSangzRklmQXZYNmdNOWRDU2VMVzl4VVFJc1BVZExNa2JnZkowRThZ?=
 =?utf-8?B?bG1GbS9IZm9paURRMzJ5ZnNpU3oxTU5zTlE2ZERQOW1iRGpIVFFRUEE2YUhx?=
 =?utf-8?B?c29pcEdReURUSnpkaDQvQzQrZ0c1N3hRbzQzZEdYRTlIUjc5SWtybS9mM2ZE?=
 =?utf-8?B?aXl1TjEwTXBCYWJLR05lZ3VFclMyT21GSnJRRjZNeHZJcnR2bnJUVnhsQkM2?=
 =?utf-8?B?bHhSQjhhcmtuOUw1aG1JTk43SVVTV2NPN2x1NEFWK1ZyOUM1MnJFT3dmSWlW?=
 =?utf-8?B?V1R2ZUhOc3I2RkwzRnJFS3VJa3NTRTU5SEZZZzY3V0w2YnU2MnlsclltZTJ1?=
 =?utf-8?B?RGpRaUZSSG42bW9sTnVKQTdBWFlUNXIvRFBXbk5uek9JY1d2ME1BaDd1K3Rq?=
 =?utf-8?B?YnRITG9OSmovTnhRd2wzdEt5b2JsbGZFL3FhK3ZyRTNrNFlMUzBLdmh3Nkpi?=
 =?utf-8?Q?RNGpaO92PS5ozWHX07AlMZumo6Y05ev4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pGTEV5MjRpUWFlSlFncTJnV0xEN0RyUzRxeHRFYjc4N0I1dUljSTIyM0Rq?=
 =?utf-8?B?c0xvNGVvb2hGdWpDVmxtZ2EvVEgwdEkveTR3MWVyMGJPMHpMWXlFVmwwdWJP?=
 =?utf-8?B?ei9xMDBzSjlRRzZKWVRjRjArbFFQYm53WUM0MU5SbUVCQ3FrenFtUUdvbFBV?=
 =?utf-8?B?S0s2YjhRU2hybW9uRXhBUFdSRnpzRjZTQWFXRjJGRktjMG5NeitDejFpOXhU?=
 =?utf-8?B?c3BydGRaYjFPZGxFNWNJb0lyN3NFd3hJSG9MUmJNdVlVOVBid0pNdzgxS3Bq?=
 =?utf-8?B?SmxNS3BPVXB4WWxyUXZXN01LanV4cDQzUkhBRUFmSFBmYTNTRlVNWTFPRGky?=
 =?utf-8?B?Z29aSkJYbHJFZllsVmErN040azBBY2NFZkZ2ekVNRnJrSklMcnFqaytxbDl1?=
 =?utf-8?B?eHpLZFBqdm9obi94VHdEV2cwUER6S0FRUEJDbU1TeGFnYUd0THV2Nk5PZ3pN?=
 =?utf-8?B?eVVLdXpRNjB2bndCUFFNdGZkd3Z5c2xBUGdha1NpSy83ZnBQV1cvdmRtdDVK?=
 =?utf-8?B?S0kwWTArdkczVyt6NURhVENpeS8xTGNMK1dRaFFNYklsRFhrUlVrS2lQKzhU?=
 =?utf-8?B?Y2pTZi9vMjlEVjVyK0FHRWozaDd6MFYrQzNHdy96cVFiQ0diVWRTSmdPejhX?=
 =?utf-8?B?dVovM3pKRHNHWm91VkZueWhrVHlzYWVnSFhsNWpiMmxZZ3NtSUdDcnE2UXNo?=
 =?utf-8?B?Nm9lRU9LeFFhWnBlMXNFNDZGS2xjMVdLUmpXRVJGU1d2aUQ5SW9RQVpobHdk?=
 =?utf-8?B?d2dpR0ZIejFXR0tXcjlsblI0aHFxd1dPQy9sczZZSzUzckljd1pZeS9Jemgv?=
 =?utf-8?B?K0wzTjkwOXZUcy8yU3Y1Nm81ZkQ5QXFMTTQ5dU9zaERjR0tZYkY5OVdmUWNP?=
 =?utf-8?B?T21qZTRoTGxsdktuWDhWa3BhQ0ttV1Z5MkM0cTdtb3ZML08xRENpMWtseFU0?=
 =?utf-8?B?TFUzZzhtdFUzZ3h5aEJiK2FsSHRQSWZNSmlFeEwrOXdpZmt3TUxmRjFLMWJZ?=
 =?utf-8?B?Rkg5c3VybkJLRm4vV1JhK1hhMDc0M3ZOa3lBaGM4VXdiMDkyVEh6b3loYWRn?=
 =?utf-8?B?ZXppVTMyTmpjSUhLZ05rcmduT3pEc1I2N3JmVzZMYUNCS3lXdzdtNTFqM2ZK?=
 =?utf-8?B?Q0FFa3g4UElHM3QyUzRnVkRDOGpJQzNhc3FDZjY5YU1WcitNcExiU0VEdXdz?=
 =?utf-8?B?YkJtendSKzJWN2JvTXZGdGxaUzdDcGhKWHd1SGhwTzFXMVo4ZWw5TjlWZnFr?=
 =?utf-8?B?OVZRNlBHQitDd2FybjBhYW1vdUxRKzJqNlR5Rzk3VkxvWjZJRzhjL3NVdkZy?=
 =?utf-8?B?LzFpdm5hcy85TjRobWVLcDljS1dtaVVEdjgvNlNHbktFUXQyd3hCL29uODYw?=
 =?utf-8?B?cE1FMmczSFJISUtVcDZNeVBZUEJjdzJGVDI4cFF2enBpL0owRGF3M0J5N1hw?=
 =?utf-8?B?bkFycEhnMFVtVzNmNFpxZ2RkZTcyZU5wV3FMSGhGRHlLR2F1U3Ntci81Ylda?=
 =?utf-8?B?TXlQZHp5VGljWFNiNUhxenVPV1F5dUNXUUh4L2JaYTZwR1NUWERNME42M25J?=
 =?utf-8?B?Z3AyZ1QvUkxaSjNLS2J4Mzdha1VPRGFtaTl0NWl1NE9zNFZWc1NXeFVmWHBE?=
 =?utf-8?B?QWw0NnpmRTE4bnNQSXhwNEI0ckcwclBoOGszckMzOFA1UHdRZUY4SVcyRFpE?=
 =?utf-8?B?MkJ2TEMvYlFUZ3k1RDJBTjF3dWVhWnJTanlEVnJ3OWd5L3J1Wk5EencrRDlq?=
 =?utf-8?B?UHRMZ2dseU50UXQ3Z3RMRHZpNXJ6RVV0enZTOGxzWGF2dmY5TlRJSXl3aDIr?=
 =?utf-8?B?QjZla3FLaVMvT3BsUzByajVlMlR4eFdIZktXVm9hdTdQM1RwMHhIb3pvVXFH?=
 =?utf-8?B?UkZvd2RrOFBEL2YyOS9qdXp0My9YTXRYQXRHaHdUcXdlWXYxVFlOcXFxRXlG?=
 =?utf-8?B?L3BNWjExK3lsY2h1L1VESkUycVk2OFY2TGFQa1REWUVWbXUyeXZWQUFxTmVZ?=
 =?utf-8?B?STRkWGUvUnlqeDhjeEQxTThjVm9ESTcwaGgrK29wbXQ2M1MyaVhKU1hWNTVw?=
 =?utf-8?B?cG5oanZxSnhPZjFoK1BtT3pQL3NudkloY2RkUjdwd0FOclFPa2hjOG1DVWF3?=
 =?utf-8?B?ZXNRR3NpcjFzTUh3NzQrT1RKREVaY0Q3a0N3T1lGTDI5cVVBMTBxTXpsa0hs?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac25409e-d666-4721-3e05-08dd1fdf59e9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 03:43:50.5225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKSf9BuENNvQN9G3fpQ+iaazb4am1jm2dAjduh2dCpNBlqyTYKJKHY2umk0if/QDfgRucHJeoIZk1UJYDhB7FJjP6+JHq1CDiAokRexxT0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6963
Received-SPF: pass client-ip=2a01:111:f403:200e::709;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

From: Andrew Yuan <andrew.yuan@jaguarmicro.com>

As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide,
if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
mask_value in type2_compare_x_word_0 is used as an additional 2 byte Compare Value

Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/cadence_gem.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3fce01315f..897331c5ef 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask, compare;
-            uint16_t rx_cmp;
+            uint32_t cr0, cr1, mask, compare, disable_mask;
+            uint32_t rx_cmp;
             int offset;
             int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
                                    R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
@@ -946,9 +946,23 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 break;
             }
 
-            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
-            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            disable_mask =
+                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
+            if (disable_mask) {
+                /*
+                 * If disable_mask is set,
+                 * mask_value is used as an additional 2 byte Compare Value.
+                 * To simple, set mask = 0xFFFFFFFF, if disable_mask is set.
+                 */
+                rx_cmp = ldl_le_p(rxbuf_ptr[offset]);
+                mask = 0xFFFFFFFF;
+                compare = cr0;
+            } else {
+                rx_cmp = lduw_le_p(rxbuf_ptr[offset]);
+                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+                compare =
+                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            }
 
             if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
-- 
2.25.1


