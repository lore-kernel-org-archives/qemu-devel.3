Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643A3C25B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3Kb-0003Gi-MI; Thu, 23 May 2024 03:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sA3Ka-0003Fa-Bk
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:57:44 -0400
Received: from mail-vi1eur02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2607::700]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sA3KW-0006PG-Oz
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:57:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpzYYN4+hL//h+xLvtxV3iBI1VPX8z80yABOo569rGKPn/rXEyBAs6tAwmtPiMWYE86licv/xRhp8uuSeTpaod1JQpXkimQaqYvKLabwUXpPA831uDga6TW1TnuTBmjLtRCd84KY46tTa9BaiOd7ygpBV0iEg8GRD30XNRarAufUrXfPN515Pr6ZjalB9QCqrug288GFp63KJAUJiRYjgwMUOD56Ky+7IiO2H3LmVVKw+4j2TzlViIc1LrwXVXoc1zppas3NrPbNMx1v2sR0bZsc/Yn66M0XzpXrlTrieUt13ZTc4Z8wif3lgjaBkP8QsonF/c+nsseH70gSkIgsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYpovZ8tlg4nKKoj7LY5jXXGF2Vk16kJTL6VTKfdIAo=;
 b=GCe0Ebe/0gc5BrsjyPKVp1uWK2kbotgb2ajBiGQpFFktoZdvCEwM2V1WhVNvhAFNMdNsdX+VZ5AC0UAAYaHCOkgquBsTA5xTHzwrewBqSaU6hwCdxhjDaSBX28sODgGCdev3eJs2PDmsdY9/uWzBm45adqKOh7INN0RYy7jzyeKbMYG/4fueFu5c2/KIoMMHv+T9grKNPnfLnugIOGDhUcEKFn0bo/UgFAaUA8rzH0S+rzcf338M6dKYwkU3NuAGG3g97sTWooy5c71bdmsJB8hBkuomlwoWQfMJQKS4HMfPePacNv6xKg1R+m2Mu2L8kMMbeed0ERHSYo6CLLlzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYpovZ8tlg4nKKoj7LY5jXXGF2Vk16kJTL6VTKfdIAo=;
 b=GjUs9dGy7QQ/EqLbrHW+oPsN/EW51jOXKiLVqsKo0hIIcwJlWJ2nAk8qoa54Ed59zD5z/CHcUG7Y+OvGegcLD8yVcWOITcRzYpH93Zer2h8v2EkwJnLCCYv0G+jv83bBbI9yUHLNb5V5VbWTLfeKFfGUZMieW9dp0xVPGhYlinB7xvP5UvmoNmhYTR4tr+rteKcv+j41uDs8sk7jE1dQc9wfDIo7AqBgDkIl9Z7SUUuNhGoa0leC061HcvIw9ehDPTXEJry2AjOsrPeascV6vwAapIEUvgqijV5c/T1SZQsJ3hVV9fcKmuHpgSyuh/uazz0NULynmigwOcstq5vONw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB9549.eurprd08.prod.outlook.com
 (2603:10a6:20b:61e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 07:57:33 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 07:57:33 +0000
Message-ID: <0ac4bf62-8ba1-439e-af83-1dbbbcfc5aa7@virtuozzo.com>
Date: Thu, 23 May 2024 09:57:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Add an interactive mode to guest-exec via VSOCK for
 Linux
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com,
 kkostiuk@redhat.com, marcandre.lureau@gmail.com
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
 <Zk4Y3mw2DU1KKeGV@redhat.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <Zk4Y3mw2DU1KKeGV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7cf173-69bb-4540-b19e-08dc7afe0078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRiYXYrUmVVUGUwRTNJVm1sQTBnR3lRdm1wUWxjNEQ2Si9JNHM0WXN0ZU9F?=
 =?utf-8?B?LzlxbEw2eXlrNjB3RmJzL3VXdUtPVmZ6eGlzU1dVamxsdWg5ODZidFprRTN1?=
 =?utf-8?B?MktRbWhDdURiZ2MvMkQrK2ROREx5aHh1Qkt3aS9POXBXMjdDMGowd1g0QnpW?=
 =?utf-8?B?SUltUVNLKzNxaEZLWjQwS0ljV2YrRDZGejBLSnB0MHFmWXpqeEZTcjJNSi9l?=
 =?utf-8?B?YW5Yb1gwZ1lFVHBYYjBDeWJlMldpbVhVU0ZhZEp6WUs5a09uYW5GMHhhTUkz?=
 =?utf-8?B?eHpvNFJPTEg1bHQzdm12cElXNUZpUjI3ZXl5aHdQRHNPUHpqOUFIRTNWVnFj?=
 =?utf-8?B?R0JiWnZ6L1JjblRXZFNZOFEvcmZzNFdMK3lLWnRpbkFWVmp5eTFaRnI0ZzRM?=
 =?utf-8?B?Z0dKaUo5a08yQzVFa1RldmppSUhLQ0E2K1VRQnNYTC9IeDBCMEIvQ3FYbjdm?=
 =?utf-8?B?VG5ucmRaNkVlYXh5aFRSUWI4Q2h4K0swNXBOYlc5OWx4cSs0eUpJKzJ0M2hG?=
 =?utf-8?B?d3lLZ21rS0pybWs3aUo4ZEI0Qzh0NjJ4bGZaemxPdkxLZWd0OENBbmhCMVMw?=
 =?utf-8?B?VnJsQjdrR2VIbG9YQ01wdmFVTTViTHhlK0E5dmhEK2hucTFQUWd6bDFIUVNi?=
 =?utf-8?B?a3UybVZoZVJhSjdZa1VsTG9pN1FiaGtlRklFVWJ0U2h4d2JFWFd2MTdVa2xp?=
 =?utf-8?B?UlF2aHd2ajNqalMvL2thTEFFSEdPRTZsbUVqMTV0WDVmMWZvemd6S2UvdHd5?=
 =?utf-8?B?VE5EWjV1ZndMSCtjOGxBZTRDakxCbHVES0NSYlh6M3QwOXFWejcvY3d2clJV?=
 =?utf-8?B?Vi9hV3pGZVNCcU82Tm5Xc0pFcWMvbHprWXl6bUVYNVhXRUtTN0lUejZXQk5a?=
 =?utf-8?B?dnlLYVNuNmhjdEc0eWVqUzdweTBBaTFQcFczQVArOVBPekJpenhzWXVodGFW?=
 =?utf-8?B?Z3A3S1pwOGpLWnY1bUZ6aHMySDNDTXY2NEp6czJFUW85TGxNbXNYUVVHMWhr?=
 =?utf-8?B?ZWhsZUtDNFEwQlRuTUJ6K3pzYmoxZ2JoQkE3RTBFUGtXdDJDK1oxSXZEQlFY?=
 =?utf-8?B?VTQ4NG54Tno0S2xmTGhFOFE4Y0NNTkxkRkttMXFVdXY1Mmkwd3E3ZjNVM3By?=
 =?utf-8?B?bDhQM0NLQU0yK1B4a0lERERBbUVKcUJmS091cjM0TE82c0o4ZG9RcDNrbEsx?=
 =?utf-8?B?eVA1MjZsSjU4VjNUeWljTHQ0UU5LSWF3ODl5ajFkM2p6V21VRVBZVzRZemZz?=
 =?utf-8?B?SUxPVXNLY3dWeDhCWk5hRVkzWGhlMGhUUGhnTHZJRGFtNHA0bUlGZGlVQkk0?=
 =?utf-8?B?Mzd5dHB2TVhFWUxMNldZQm5PTlVXV2VZb3o1QnlqTk8reTJtSU1vVENCV3BM?=
 =?utf-8?B?bU1CS3hCWG5RVXZoc1V3N0lseHUzaGZFMWFVbzVkaVBaQy9hN216QVpNYi9N?=
 =?utf-8?B?RjY5dW1vK3FqazdqV3hNT004NU5CSm04QVZVZzB3anlzeU1zOTc3WTJBaFpH?=
 =?utf-8?B?VTJRMTk1L3NWbXdGV09RMlZ1ayt5S29QdFV1bmZtRFVveVhYUjlHV3VRMVBO?=
 =?utf-8?B?ekVEejAyMHA2ZG92UEE4TXkrcDA3RHlUakpIR2VJb3dFTW8zR0FncG1MTGNB?=
 =?utf-8?B?NlBrMURpaWJLQkY5YTVUenB5YU1JejJYbkRLL1IyYy9EVUNjS3FHQVlXSUMv?=
 =?utf-8?B?MlJDWXFQbVBPTHBnQTRVbkl1dllIRTZSS3U1UE1TVE41cEdjQk5JcllBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGFmRy92bkZvTVNZUHJBbjR1c0FVdmpGeExwSkFvSkl4SVNDaURCa1dPVTRv?=
 =?utf-8?B?eDlDZzdPSlBOU2xsbm5xYk4rNURnQjlyZHo4V2ZZVjZWeWNDTEZ5SzQ4aHRF?=
 =?utf-8?B?cU82U21VVVQ1V1Y0bGRkZUF4VkpsNFRwT0F1Z0d4TDYweU9aampjeUZLUEZE?=
 =?utf-8?B?UWZOS1VQOWpCbnlZc2s4eEhkdmZWbXZ3WDc1TU55RVMvUlJRNlBOb1RLbjRQ?=
 =?utf-8?B?aWlBR0h3NkphUlJMR2hQRFU5cFRiSHU3RTRHY2dZK3FaUUFBNW1iTUpoWlFE?=
 =?utf-8?B?VU9aR2gwTElrYlBnWnF0ZTVBK3ZGTFZzVU15Tm1heHMrVGNNMUM0RTRXZ3lK?=
 =?utf-8?B?cGsrd0dPMmxQMXF3UGNFSFFNKy9FT0NsTjdHMXZvbVVmUFh0dzhNekQvMGdT?=
 =?utf-8?B?Wm14WXd1VE10ek9EcHY0SHN3eldIU2tkNVBjVkp2Qkw0Rk8wU3JYczgrc01B?=
 =?utf-8?B?REltV01jQm1zZEV0L3VYTnRSb3o1ak1jbkRjNGI2K3piVm5vemVGQVhPV2c4?=
 =?utf-8?B?a0VzRkZOdG1zNmhmdDU4bXUyMmpvWUlzQ1ZHOEhTTmlWMVBvUGhwRktxRFFF?=
 =?utf-8?B?ZHhiL1VNL0lFcFV2NHg5eklBK1hMSFhzMXNYc0ZSUHBaTzJXWWowOS9sQnYy?=
 =?utf-8?B?cHRreFR0V2E4YlFHSUFJcTdkcjM1SjFrN0UzSVplOE0vS2tIT015RmZsSHlv?=
 =?utf-8?B?ZGNRL05zdjhuTE1jNHUzUFQxM05OdWt6MkJoZDBPaGhTL29KYi9uZ1gzZzNP?=
 =?utf-8?B?TktBaStEZTVWVk96QXk2SHVjRXBHaW4vRE5OY0pZdmsyczFNSWVET3NZU1Z6?=
 =?utf-8?B?RzdKL05RK2RkM2M1SGJLQThVaFJwRVJSakQxaGxNY1BSQXJjemVTNzM4Z2JJ?=
 =?utf-8?B?ZzJLUzdJS3JHODh5b3NrM2dIa0p3MnNmSDU1Y0NCRDNTZkdTQ3psSXFQMWQr?=
 =?utf-8?B?d1E0U1JSRWN4elErWk5DUGlybHhDdmdLcW1jTW1wTmJCZWsvQWhLOEpWU3Z6?=
 =?utf-8?B?N0ZRcUZBT2Ftc05UN0Y5VVpvN1VNTWtBcWs2eGpCVGdLS1VEWEpNN0pLN3Ny?=
 =?utf-8?B?K3AxN3R5RkFtWVloUS83RnFOMURtc3dxVjZkM3N2dlYxWlc5V3BMTGpwMUxq?=
 =?utf-8?B?cTUzcUFoRkdCTjNWVGI0Tnp4Vjg0NStpNGluUFlLTHU5anhmck1NZXZYY2dh?=
 =?utf-8?B?blZxZkZPLzlyOStmZnJlM0lkM3ZQVGY4a3h1THlPK1FvMUpFT0RBNDZUMU1Q?=
 =?utf-8?B?WHc2MUdiNjFmS2pFT09JZTRVdjZHdURuWXErSDQwbUZUdGNWTHB3ck14SHR4?=
 =?utf-8?B?SUNMMUIxdjVHWFNBeEtMc3pZenNsSlBrSE9VTU1DZzdmcWE2bER1czltVlJv?=
 =?utf-8?B?QmlxZndyQjRlMEVzcEs5NWtRc3R6N255RXlMS2NpQ0xnaXlST1ZjSTlwaEVD?=
 =?utf-8?B?SHZ3VGFuOUczcVgyWEE3ZVoxY2tZT2xBYWxrek02ZHIrcCtsNmJncGhkQXlM?=
 =?utf-8?B?VUdiZVpRamkvaG1YSEJTRTBpYndsWXA4Um9aOWp5amlGRkRUYkNZVE5Qdmw3?=
 =?utf-8?B?M3JtTlE0anpDOWM5UzJEOXhkaFpkUjQyNXJBTkVqd1dzaDkwU3dJNndUOEZO?=
 =?utf-8?B?aHRTWGdKWVJmTGVqb2FMTzBRN0JyTG40NHpsSDhwaHpoajVEUW9MWWhVMUcx?=
 =?utf-8?B?SmpXeWZvc296enFVZWxYMVpZYXNQZkFlOWM4aVBVTytUOExFTUJJeDhaV2c2?=
 =?utf-8?B?YW1ZeTJONXJicmVpaUc0VjJJRkZZZkNUZlBQTFJMNWw3dnI3dm01U0hvYXo3?=
 =?utf-8?B?RlplUWRFcGNZcTZLbFE5SzRQVXF5Z1JFYW10MkswVS9yNDA1QlZZQmFxWW56?=
 =?utf-8?B?QWFybCtiMUtyS3p1OGJGVXhNVXFBdXkzc1dic05XcUFJWWRDYWl5SFBycHRw?=
 =?utf-8?B?eTQvTjB2NWNXc0lJTnBZaUdrQ3BBaU5vUCtsbTVqMit3NHkwVTVrTDRFa2dw?=
 =?utf-8?B?YlpvbGpUOUNwbGVhdnhEM3VldlNGNTBJYktNTjFCRUFzcG5KQ0Y2MEVNcWxU?=
 =?utf-8?B?Q0RJaHBCQ2gvazhUbUhpRHBNU1lkenMyT3FSTzhWUFd5amRnaytxVnpkb1pV?=
 =?utf-8?B?RG1ZT2ZxQVdYdGo1V0cyWG93YjBlalpKakdOYnJNZXdKT3BDMnBiTGptUy9n?=
 =?utf-8?Q?sT/WP0n84d9eZyN4la2Gkfo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7cf173-69bb-4540-b19e-08dc7afe0078
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:57:32.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3txeWGrtSvxQMs1/BocUX6i4sDCG9jq4YBPuxGYhZcPCH/1I9WM2tVsoK1wsvfKQ4mT5XZYXXw6ijutLCZkb2+Q+lheOLl6g7rz5QORFio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9549
Received-SPF: pass client-ip=2a01:111:f403:2607::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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



On 5/22/24 18:10, Daniel P. Berrangé wrote:
> On Wed, May 22, 2024 at 05:06:57PM +0200, Alexander Ivanov wrote:
>> Add an interactive mode to the guest-exec command in the QEMU Guest Agent
>> using the VSOCK communication mechanism. It enables interactive sessions
>> with the executed command in the guest, allowing real-time input/output.
>>
>> Introduce "interactive" mode in the GuestExecCaptureOutputMode enumeration
>> and add optional "cid" and "port" fields to the guest-exec response. In
>> such a way user can execute guest-exec command, get CID and port number
>> from the response and connect to the guest server. After connection user
>> can communicate with the started process. All the data transmitted to the
>> server is redirected to stdin. Data from stdout and stderr is redirected
>> to the client. All data blocks are preceded by 32-bit headers (network
>> byte order): most significant bit contains a sign of stream (stdout - 0,
>> stderr - 1), all the other bits contain the payload size.
> Every patch to 'guest-exec' takes us torwards re-inventing yet more
> SSH/telnet functionality, but a poor simulation of it. For exmaple
> this still lacks any separation of stdout/stderr streams, just
There IS separation of stdout/stderr. Receiving data on the host you can
see from which stream it is.
> interleaving all their data back to the host. There is also zero
> access control facilities beyond turning off the 'guest-exec'
> command entirely.
>
> IMHO we should really consider "arbitrary command execution" to be
> something to be handled by a separate process. Let the guest OS admin
> decide separately from running QEMU GA, whether they want to enable
> arbitrary host processes to have a trival privileged backdoor into
> their guest.
>
> systemd now supports exposing SSH over VSOCK, and provides an SSH
> proxy in the host to connect to VMs, while libvirt also has added
> its own host SSH proxy to allow SSH based on libvirt VM name.
>
> For windows guests, there is something called PowerShell Direct
> which exposes PowerShell over vmbus under HyperV. Possibly that
> can be enabled in QEMU too if someone understands windows & vmbus
> enough... ?
>
> With regards,
> Daniel
Otherwise, you are right, it makes sense to use SSH over VSOCK. Thank you.

-- 
Best regards,
Alexander Ivanov


