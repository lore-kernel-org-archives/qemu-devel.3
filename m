Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E20AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Lm9-00060W-G4; Tue, 21 May 2024 05:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Lm7-0005z8-A3; Tue, 21 May 2024 05:27:15 -0400
Received: from mail-db5eur02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2608::700]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Lm5-0008MW-1y; Tue, 21 May 2024 05:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1SwxzZViZtMcRBIh+IRUugCUd2pCUsNPctG0FZLsVqoyruNuMPlD+NYEivu84lW9TaR9wjf0LdfnVJX/eNXDRorPmP50bhlp+Uu7ZYmCqd6OtGebJOu/KJOTQ5/LdyzIkYZznRLiIP6yXKt5JO4ytAib6oCMDOGxxBrwBr36m5460jn+UZL2RUy7w6wSwUcU4Jve4iZhoimvF+MGEljiJ6d1/FkxUxC0UbBH7GG6ZVqLVubFBEUQZiwdm7GEB1UowYpQXopQznYauUCNxm/CPVea2rOqNpgUeGYvpwAUiQWHYNbpw/6Btb2rsVX2/Nm8mRICsYTgebH5NXzDr7TSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxX+lEqjvM1fnJDLSYot3V9cOzutEsuqisanT/2xxb0=;
 b=FXGXveIUpRrBtFCvWTQymuE3/R4FyJ6m7e7ukZkHgVjE+oJW+rOSbBeB8Oee3hHCfFs7/4nNc8HdA7avkfTUV7Kwqf/WaOlCxsPHzE7Xi30WO1XoEirw6Ec8Wo+PcBpys5TDj8q0Zf3htyrVEp4/cdSQq9oXMY1Mfhp6F0otQi49v07AeaOPPLEQyehxToAhliLic9T5sCvoJjlu/E6YWg2mrs9I73ikeD22EEZza7MUfC1J1FYfCYimTerE9hp20Ywxov/2iFR8AJORbfw2rSpiqaoG+meP4EZ77RsrhNql/UfILjTZG1kBKo41yt1sEpm+cE5BBoxayvNP8bf3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxX+lEqjvM1fnJDLSYot3V9cOzutEsuqisanT/2xxb0=;
 b=rqwzPNYEAi+ErqmsnG8qTYXgeYJ74MYpgZmMNIEEmigoYHOLULWs+VSPNXj3q6dplESYTvjxgwax5KM5SKSdikvv4IWaWnpB2h31C2gzxNHE1/cMyZ/3DpBSS3wXHROo62B51rQzcU2JOAw/kwoLYaOmD9Z95v6qjmaCuY9Eb/NIih5qL2tq9zdk9GtnEsmfV58nJF1qWGB9YC9rcMoynihiX2JmS+pdRYObJjyx00DhKAfm+sDd2ews4fHptna9bQyovuaqWqg/OUvVHZ6HJbY7C/Lv2qO56iHgWkwUlQEiczKRMPk9tjK9IO8qf6Q8/ywLFaHQYUZ0F1ZxaK9HpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by VI1PR08MB5406.eurprd08.prod.outlook.com
 (2603:10a6:803:133::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 09:27:08 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:27:08 +0000
Message-ID: <45df3d97-bdd2-46fc-a643-1037e7cf0ab1@virtuozzo.com>
Date: Tue, 21 May 2024 11:27:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] qcow2: zeroize the entire cluster when there're
 no non-zero subclusters
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-9-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-9-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|VI1PR08MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: d4530dca-1bc0-4d25-68cd-08dc79782f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkNPdFNnRXhkbG1YSml0aXNyNnp4MjdHR0JEa0g1SjdQb0tJaU0zSjRWV3Uv?=
 =?utf-8?B?T3dlUnU1Z0JWZDZ2dnJadXFkQUdBWkIxUjRmOUp0cHhRU2EzeU5jTWd3ZHo4?=
 =?utf-8?B?dytmVTkrb0tPbCthMXE5TTVqa2hyV1kvMGJSTnFZTEgrdkVmL1crcnlTcVFk?=
 =?utf-8?B?VFFFWWtTai9qWHlhL1pVZmxKcTBMRWFjWmN6U1FxbGFzek8yRG0wZmFwZ3o2?=
 =?utf-8?B?cDkrRzA4WngrS1Jsc1k0bzRzaVZLVlRYcCtZZEpDMTMrb29XOFZ3UnU2emxr?=
 =?utf-8?B?NWVVVXBOOGVsYy9DMXRkWTlHWTBaSndRbXB5T2VUNjFMaVZYd2krOXJIdFlr?=
 =?utf-8?B?ZGdWa0U4U2pQRUxsdVYrZ0R0OVh3U09ITG5MalB3RTcxbEdWQjVucEErQk5w?=
 =?utf-8?B?YXdpS3Zjczh3dDZWaENJekNtV2wybGRHdUVzTitTTXRZdnFaVlNJMmQ2V2pN?=
 =?utf-8?B?YXV6VElpNkp1STdZSktvTEZlYnplaVY2TjV4UXR2cDRDM0U3cWhtWVI0a2Nl?=
 =?utf-8?B?UDVxRmdvRDRwZFY3citqblhPRDRaTVFDY08vNkoxa1JTb2kwL21IRnpEa1NS?=
 =?utf-8?B?dytUaHBJSDRqWHVnS3lON2FDNTlVdG9MZ3U5ei9ienQ2by9YSjh6N3NmZmxp?=
 =?utf-8?B?cWY3UEo1OHdWaVY1a05aSHViSnZJTDB6V3FQTFZvMFk2YzgxbjY3MjlHc1J5?=
 =?utf-8?B?cE9vaGNuRmtUUU15L2tEM0N1V1VyWHU1dmNIaWdpMUZ3a1hzZHlKUXYybHh4?=
 =?utf-8?B?SFVxeHQvMXNqalZCS2V3YUxzNFZzUXk4SHBtV09IOEdpUjhMQWUzazVoZjY4?=
 =?utf-8?B?NS9KckxQbUZGWmREUUZ0RzVwM0NveVBHRHB3NWxINnI5WFBKQ1BvcElWanlk?=
 =?utf-8?B?ZldBejFBZWkxMXFBUVhzV1FJYTNMMW85bFA0UXd5UjhmR0dvNXk2a0s0bkVu?=
 =?utf-8?B?Y3VTOW9qb21pcDllVS8rRlAxbnJBRldxekR3dE1CQWJzVHBYTVI5U2VkcU52?=
 =?utf-8?B?NFhydjR6cFlRaUV5RDhUNTR2bkMveEk5c0pJZjcyUVAxeEpGa1FKN0hKSHUv?=
 =?utf-8?B?V2IzZDV6QS9XK0dPTWZ1c0Jxc2pUTHl4RFN1WjhVSU9LNlNKNVFkNGZ1OUs4?=
 =?utf-8?B?a0xRMG8wZ2V0bmNva1FSUTdDWHJsUFFqSjZMdDAwS1pJTXlrck80bFVDd0g4?=
 =?utf-8?B?TE00eFN3OG9MdnhzazJRdEc1cmhpNXMrZmJsSGdESTZRT3poWWZVRHhGR0hJ?=
 =?utf-8?B?OUlHSWFsd0J6ZEZxcnZDK0I2eXV6L0N6ZVErbHpGZEoyZ1krME9zcWVaSXEz?=
 =?utf-8?B?NlhLRzU0U0hBcS9SWjJITzZqOEdINjEyL3ZENTAxUUxLUUZGS2ZtSlNlSm9m?=
 =?utf-8?B?U1dNTDI3dTF1QUNhRFBMV1JlQlFiQ0J1Wm9NbUVPMVlaWkVlblZ2NkJJL1M5?=
 =?utf-8?B?NmpaUVI0WC9mUGpHUGo3eTFKWVFlWHpFV1hDYS93VmNCR3Zya2s0bG95N3hu?=
 =?utf-8?B?NUxSeDVWKzBmWS9nMDZCWkZ4SjBmbzhUTU1EQzJJSmlCSnltNGRjRG5FKy9X?=
 =?utf-8?B?YXQ0TEZGN01IaDRpc3hoS09qWHhJa3BSbzZUVTNhQTBlOS9XUUFZZFhzWFdP?=
 =?utf-8?B?TVpOa1o2M0c3bk5acFkvdFhEc3ZpWDNMT3ZGYWIxYVJ4aEZSWTJIVTZKMEVP?=
 =?utf-8?B?Z2tYeTJrcXhGS1VMZ1ZXN2lRbTJCbUVtRWRzYjNWc3FIOFcxK3VZeWxBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNDd0lGQUtzU2F1anpCV3BSZy9HbVNDajI5Q2srclloclFSU1gvVGFzZ28z?=
 =?utf-8?B?a3VJbDF3bnY5VXBYcXl3SC9zYXAySG5aV0JCbFpjYjE4OEpaemU0SW5TSHhz?=
 =?utf-8?B?WFJOVE94VnYrSThWNUtMVCtkcGwxTUhhWndqemdscGIwNHZoTSt3SEZrQTZj?=
 =?utf-8?B?MXpXZ1A4QXpGTEU4OHdTN0c3YWFuUkt4VE02WG1ZR1Y4SzVOVDhQWGh3WjUr?=
 =?utf-8?B?QWVveDVnVVlaTENjcW83MllYN0hxajlOQm1xWitQY0ZsVWFQVzU4V0ZBMHZr?=
 =?utf-8?B?L1RvaHljTmpQVTVZRnBtWVBMZy8wakt3blRGYkZqemNHaTljRXZQOStkek1W?=
 =?utf-8?B?ZzRtUG4rVVE3d2dGQWNsaVJxK2NpSUEvdEZjY2o2bU4zMEE1bTFVcTdxcms5?=
 =?utf-8?B?Qm4zVlJoUUFqMUZnOU53RWttRmZIa3lKSHJWQld6NitadlFkU2ZxWEdsZktx?=
 =?utf-8?B?QXJwZ29rZXJhOFk3UXRBMkdkRHBZSDRMSFkyZzR6YXFSNE42VFlhdi92allj?=
 =?utf-8?B?bENNc0RydS9Sb0xNRGhQZTlkS3ExK1NUK1Q3eit2Zk4rbmVIbFVxTW9nMVE1?=
 =?utf-8?B?eGo3MlRtUVdFcjdNQkFlZXc4dWRTY29zamNQdGtKaVFQT1FEV3BsM1Y3Rmdh?=
 =?utf-8?B?Tk9nUGh4aXExMjJjaTR0MEJrT0VEYlhXeUk4NnR1S2JqZ29tQmVKcWNpSFV0?=
 =?utf-8?B?RFBPbjFiYXRodzJBcWk4RmFZTnozNjZOOU15dEF3dUxwRWg4Y0FlR2JOa2hk?=
 =?utf-8?B?VGVWZkJVYVNLeEViN1h1Wk9wVllxTDlGQy9nQUwrK3Bidzl0UGhGZHl4dG41?=
 =?utf-8?B?elJnTlFTMDZHYlN4R3hVOTEwaDRvYm9kMUVPcnFtNVQwYXhaZTB0eVQ4RjBy?=
 =?utf-8?B?djJIdTB5bkwvOExBZ0VSVWJKV2RJNW5ZYXZLZ3JyZmlHVEIwY0VzYkJrUFNP?=
 =?utf-8?B?Y2pyQnROVVRzcDFCUHpJK0ZhY0Z3M2FwVWNxZEU2THpTYkZHOFZwUUkvV0R1?=
 =?utf-8?B?bndtTUwzOUFoVTU2WHpvRzZFbEdFaElWbGc5U0dIQ3pibGR6UkVHQ0xRZThZ?=
 =?utf-8?B?enpnaUR5b3ljeTdUeHVnZ21GQ09kL2RzSENKNlczMjAvQWhVNGM5aVk1ZDVG?=
 =?utf-8?B?SGNyUUFQTG5yYTJZcVVrUkFWMEprWW1XLzdTS2t1NG5sQVZaZDZDaU5UZG40?=
 =?utf-8?B?dmdGOHptYmhkYlRqa3dGa2RqNmt3Qm1FQWhYMTVaMVQ3MGkvQTRDcVVDSjEv?=
 =?utf-8?B?U1JGSUJJblRZaVZLQ0RUdFczOWxxQlhmbGdBb0hNVXBlMHBOUEozc3M2TFR5?=
 =?utf-8?B?eEN0T2FYSzNhRVpxUGw3YStnREMrYStidzl2WG4rYzN1bVBBWllpaEZONUdJ?=
 =?utf-8?B?OEZsN1hNbURiQUh4c1lsbFdrVzBNNXdsMWNiVTJzOVJOSEpsUTNlSHVPS1Nv?=
 =?utf-8?B?cjVxakUxMnJyTThVVitOKyttTjJZelV5Tzg0emtTMXJoWTRZNXJDNUxaa0N4?=
 =?utf-8?B?MXUvSjk4bnVUd1VqTElZNmNkRzFvOGRKVVlKaG5KeFBwcGlQMStoZUFMK1hD?=
 =?utf-8?B?dm8xNzc4M05zbE1wdEFidVFoWkx0L1pObWlwd08rNzJUWnFCYlo2S1RIMVEv?=
 =?utf-8?B?c1pqZjZHSFhiWkEvV0NNOVplYnlQWit1QXFqdE1nbk9adE5jRXF0bFl3MmE3?=
 =?utf-8?B?MWhGMkFMRG1wWnNQV1Z1MWxFUWdJZFU3ZXZHRGVmV0JsYUhqd2NwMS8xZE9E?=
 =?utf-8?B?aVBORkF2aVVKbnBiSzFCUGwvcE93bTFabGl1LzBDTFhwRjhuNVpWQ3V0VW85?=
 =?utf-8?B?dHhzVFdZd1A3aVdPT3lTdFcvQmp4T09MN2VpWVlaTnNVYTc1ZmVMM0xQTElB?=
 =?utf-8?B?bjJ3eEdmME1qaGIvZTExR3hROWxyTU0yMjNlc1JGUDNkaUxqTWVCZ0pwMWdB?=
 =?utf-8?B?MDBLalJGSTFuU2RKQnNScXR3T1VKYnhFRUN0K1pJU0dKYWUwQm9BU3o5SlJL?=
 =?utf-8?B?eVBJNjlrYVFubTMxc0tKVXVZNkh4OTVVcXBGcXBBNS8zSUpOU3A2QVdBQmsy?=
 =?utf-8?B?Wk93VGduSmdOOGQyeHB4UHlZd2Qwb0E4bDZicXFsZEUydDJLUnM3cTlCblRV?=
 =?utf-8?B?emtpM2xjenhicW4xOUNvT3Rzb29VejRmeW9EZ3lKdldYQlRvYmQ2Y0cwRTUr?=
 =?utf-8?Q?yBJxuUHr65vRyZ7p2KH9J3U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4530dca-1bc0-4d25-68cd-08dc79782f71
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:27:08.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5ctS7z5w04paMCXwFLd1mKxdX44uTsawahDuwZ+UWZXRw5BtyQ566pHiy6uLMG96Y5sA42LOmj4esYmhENFsZaHFC8GAHHT5npQEXj9jJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5406
Received-SPF: pass client-ip=2a01:111:f403:2608::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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



On 5/13/24 08:32, Andrey Drobyshev wrote:
> When zeroizing the last non-zero subclusters within single cluster, it
> makes sense to go zeroize the entire cluster and go down zero_in_l2_slice()
> path right away.  That way we'd also update the corresponding refcount
> table.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/qcow2-cluster.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 475f167035..8d39e2f960 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2221,7 +2221,7 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>   
>   static int coroutine_fn GRAPH_RDLOCK
>   zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
> -                    unsigned nb_subclusters)
> +                    unsigned nb_subclusters, int flags)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       uint64_t new_l2_bitmap;
> @@ -2237,6 +2237,16 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>       new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
>       new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
>   
> +    /*
> +     * If there're no non-zero subclusters left, we might as well zeroize
> +     * the entire cluster.  That way we'd also update the refcount table.
> +     */
> +    if ((new_l2_bitmap & QCOW_L2_BITMAP_ALL_ZEROES) ==
> +        QCOW_L2_BITMAP_ALL_ZEROES) {
> +        return zero_in_l2_slice(bs, QEMU_ALIGN_DOWN(offset, s->cluster_size),
> +                                1, flags);
> +    }
> +
>       if (new_l2_bitmap != scri.l2_bitmap) {
>           set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
>           qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
> @@ -2293,7 +2303,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
>   
>       if (head) {
>           ret = zero_l2_subclusters(bs, offset - head,
> -                                  size_to_subclusters(s, head));
> +                                  size_to_subclusters(s, head), flags);
>           if (ret < 0) {
>               goto fail;
>           }
> @@ -2314,7 +2324,8 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
>       }
>   
>       if (tail) {
> -        ret = zero_l2_subclusters(bs, end_offset, size_to_subclusters(s, tail));
> +        ret = zero_l2_subclusters(bs, end_offset,
> +                                  size_to_subclusters(s, tail), flags);
>           if (ret < 0) {
>               goto fail;
>           }
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


