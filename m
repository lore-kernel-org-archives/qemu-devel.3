Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA032C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGeWH-00082Y-Ik; Mon, 10 Jun 2024 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sGeWE-00082J-04; Mon, 10 Jun 2024 08:53:02 -0400
Received: from mail-db8eur05on20716.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::716]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sGeWB-0002tj-Ml; Mon, 10 Jun 2024 08:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjFb3vqYX6DtjcB3A4fAj9C+KgFm0628VL6plTZySmkVwcuvz4p2SwvGBFOxb973Zmv26cNh0GKHda3TcVsQp3xFhIilp591eY+n1knvAZ8r4C2nVJdcwolPO6/X2x8C1dxRPSVN1AZFIg0ou0YQ4avEiVp1hJTfT2yB7d4qIurML7p1n87ZlRQjbrBpUA2bG88dSr4x0z+BkCGkyvJ+W2cn9bFHc3b0u/VuIpXOLw/RH3g0O1TdUqDqrSWCXi23oYV2u96y+9rur9E0x4Z0muhk1RkkB/5/8cvncvRak4/EY/c+MuFgQ0Tnpd9TokIP4uW1c3jkB+SduADMtrRjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0VX5m+uoFfyFBNFIHyYPItxyGfC9B/C5Y8+kAbVMtA=;
 b=n3KEQNFkwspQMmXh7ASP+X8ds4cUqmGn+yCJIwTfgtgKKvMzZpPPD9TuaI4dYyCWnE1J88yovDVIhYiFXTBJGQ3xQZ1hAuM6R6kp/Uma67F5CG5tYRTo8B+y3A0NoSEjI3285j3wCotymzpLIOCZu9SSW/FIQVgI5IO8sYWovukkeymHmFJ45+ugg+qetCJUnDEmaAzGJY5hTjXAvfZkRnou3XUpgyE4bBPZOfrZAUOkRgf46qCiqHphZ8Ic48AOLjNudgjadpFOFD6od0bnJ+vvDSVHsoETQoWiLxcXMk58rwlVMeMr8G5jw6lW3SHyWzBH4nat/cZAjGg4nLspRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0VX5m+uoFfyFBNFIHyYPItxyGfC9B/C5Y8+kAbVMtA=;
 b=t6ucRbaUJenpJ8wChvGcuexp+j7r8gk2gZoq6ySVvZrnhmGXLVo/K6uk1sdvgQ5HHWfolr2AZD+arRSKmb0HFc0dB8aBK1XJNJ8T3ss6x4ThSy6HQoL3koxNzMS63fgzFBJQIKudRkwQvZ3Qlbe5ooPSaY+K4Kpu5563R5iASmekRmFGr9jbL+A3Zu9Av4f6eoKcRAOXy4DKPOvPwkxfkPAVg6cczcRdtarDnjbYH53I18m7dpN2+SoCNbNQzDURAg1PP4C2H08O7+gWHjW7+h8mQwF7yMD51Hkynyb2sVpBHgD+A8yW9RIB/lk4VMnzDjAilV5vASdSkd1Uf9S1rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM8PR08MB5650.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 12:52:54 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 12:52:54 +0000
Message-ID: <9903a93f-76fc-46d9-9502-03f5a5a652a8@virtuozzo.com>
Date: Mon, 10 Jun 2024 14:52:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
 <810e4bf9-ba9b-4bff-976e-047e8be467ba@virtuozzo.com>
 <ooczxb5vojkt6blp2hhyfqcvltgzemtmwmigvgeg4utngwrcpo@2rolx5gvqzlr>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <ooczxb5vojkt6blp2hhyfqcvltgzemtmwmigvgeg4utngwrcpo@2rolx5gvqzlr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM8PR08MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: ec121955-8af7-4e58-df92-08dc894c3e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjN6UUVlYTVBVmduQ0sva1NBWWtSdEd6Nm5QRjJOMldCK0gra1Y4azM4b3hQ?=
 =?utf-8?B?bTJsWFdKSXJkY1pyK3IvcFhYbFZCK2xyTzN5SjdvUHBNUTN6TFcxN2JldjRP?=
 =?utf-8?B?YkljRzNiK2lqWGtoQWZ0WTdRSHFRQ2xqT0NsejFTdUpnejBhQ0M2OFIyaDEz?=
 =?utf-8?B?YlRlaWNzRVVYYzkxZC8wclEwNnFEZk8ySFk1QWpmMW12UndGZjN2TFVXS21y?=
 =?utf-8?B?YlZwYnZOME5sOW1JcHNBNXJjYVR0NGVibXk1NWhTV2YrL3ExMWtpdXY4QW9o?=
 =?utf-8?B?NFR1cXhWenVJbGZzbG9BYmtyM3U4SmdVdkFTVXhvM3pQVW5KUVlhSnNRMEdj?=
 =?utf-8?B?VmFTL003WkZSdGlsY2tYOXdlMmJ5S1FuRTcrbnhjUkI3Smp0QXVoeHdiR01r?=
 =?utf-8?B?Vm9tRmtLYWdLNTRDUVFteHRtdTRqWFhEeTN4RlZkU1JtRVJQMTh1S1BldHR4?=
 =?utf-8?B?czFaQ0I4RExYdCtiY3pzVmovM0dnUzV5QTVMdnIvRzYydjYyMWhoSUJPSEJh?=
 =?utf-8?B?eHVNVDNaZ2YxRERLVXcrU2lTVW1MUzB2b0pZU1RDU0RhZllaTm92MU1Vb3dp?=
 =?utf-8?B?cVd2VzlRQlYrK2wrN0pUdU4wZk12cnhuNjFDcGFVNG1jQ1dLdHBJcFI5Rzha?=
 =?utf-8?B?aDNjbXdrZkNmL3R1RTZ0cDNlRVlDQmRuUXVaR3EwYS8ySStQc2swYXRkbnhD?=
 =?utf-8?B?NXFtRi9HVy9WVERRY3lqTkM1K0pJcDg0TWlrWFI2cXc3aGpXeFhmVnVLNWpi?=
 =?utf-8?B?eVI3L1U1SFRhQ1hwWU5Gdk4wamNzTldwYVVNdUFETTd4d1Y4aWR4QWtjTHNt?=
 =?utf-8?B?cVhBd0hGa2w2MkNlVnlMMFRCMWJQQTk3T0g1R2tCMXJINEhlRldoamJxQURX?=
 =?utf-8?B?Q2tNVW1IanZzRzFnSVAxUFUzdGtKZjAxeDdsbHM4aE13a1F1TCs0US9WdXZ4?=
 =?utf-8?B?VGYxYlM4TVRzVFV5QlNjY3JSaDlPTTA0eHdzOEVRa2swcC9paFBHeFBaRExa?=
 =?utf-8?B?VUpSenFETEJCSW96YWNmamlscWF2dTg5SjZ2Slk1dmtqclFkS2ZPd2c1ZkpM?=
 =?utf-8?B?K1V6Y3AvUklNVUw4clZNTlhhY0FlNk0vYUNtSE53SnZkdXVpbDVpTUpKOHJ1?=
 =?utf-8?B?Rk93Rit4cVlYb01xbmRXQzFXbUduQ2tOVEpNcWFzSldwUFN6SWJEOGdiVlBW?=
 =?utf-8?B?SUZ2Z3dCbHFuMEVmWS9rRFlZbXgvRy82RlYzNjMxYzF2dlFEd2s5Y0JoK1Z6?=
 =?utf-8?B?MXlTRDlWVC80N3N0OTZWelpackh1aU1KdFlPRW9hcWpNNUxJOXAxa0dnRUJj?=
 =?utf-8?B?WDJyRDczdEZ1MGZWZ0U2ZDVhMFpHY3Nuclpma2dDT0JsVVBtbTk4QUNkQ2Jh?=
 =?utf-8?B?UTJ0MzY2dVlHVWN5ellPV3RHVWhIT3JGNzB5WDl0dzBpa0NvRy9OMFptWHV5?=
 =?utf-8?B?ZUdRMkVJdDB2blprRHNod3czR3NjSG8xYXRxYUg4eGxaZUFldkRDY0p4ekJK?=
 =?utf-8?B?VjJDaUlXUzBaM2NzVWZ6cUZydnpkVy9QbU01clZFWHN2S0hCNUdkNGdCdHBO?=
 =?utf-8?B?R01DZ1I4dXgvU2hpUkxCUldCQWk3NGt0VDJVUFZYcTgzUTVEVTFSN05wTEV2?=
 =?utf-8?B?ZlNpbXUzZzlrUDlqWDM4alpJWlBIZTg0alZBUTJMcWNIbVNxTHNyVTRKMGsx?=
 =?utf-8?B?eW8rb2kzZ00rakRyN05NYldMQ1BNYlhpc3JTUTYzVUlLRHplMWE3TUpjblV3?=
 =?utf-8?Q?A+4Zxz8BUvNVMzkAdgJQjuvz5lwMDX69hNHP1Cw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enIzSmNzcktpN2tZdHJ4Z3FZeGhOcXkrTW9udUhIUkJyMU92ZzVRcmRoZDJI?=
 =?utf-8?B?S1VTMmoySDVGSGlseG9lR3p6Yk1RcHFLbkNjSlNnNys0RmZtZ3NxdEl0V1By?=
 =?utf-8?B?b21OT1BLc0tIQ0tXWS9IcHQyRzBTWXNTRk9paE4zVmNveUZ5Y0xUcWRwc2pp?=
 =?utf-8?B?KzRDWEhkc0l0T2lUMzgzdFpBd2FBN0V6NGdUNkJpUUhmMUx6WVRNMnRvVGc1?=
 =?utf-8?B?QjQ3eEEwVjB1S3dRMlFDYXBVblg0em1FUndRWitDRTd3WU5JKzlndzN0a1FZ?=
 =?utf-8?B?bXNWTVlZbWowTmNxVU04dTN5ZG5idkNYVWR2bTArZXoySlkvUTQxeCtXR2F3?=
 =?utf-8?B?RkgxMVJZbnM3eTloZ3l6NlJLUnlZbngvODZqMFc5UXJtdTZtUlNVQjB1ZTFO?=
 =?utf-8?B?K3R6aWVLTFJrbWV2WXM3ZUYrL01IbVlKWXNibjFRdjV2SGlHNWVzR2dQNkNX?=
 =?utf-8?B?VlZXc3llYU1tbjY2VitTMHMrdUJzZjNCZHFJeUoreWk0dEh4TWIvV0QrT0lR?=
 =?utf-8?B?UWRaSlV0bzdjSkNnSEs3bXZQK0MvcStxb3BWZjIxemdoVzhacWwxb3VKK0h3?=
 =?utf-8?B?ME1WY1VkdmY2SnNFa1B2TlJaQ2IwOVJiWlBmT3g4aVBpVUZmNm1qblZpVmVI?=
 =?utf-8?B?ZDlEL2dzZ00rMERRT2Rvb0dveXNTWDNtL1hidWhWK2kyMWVKSjl0byt2dXBQ?=
 =?utf-8?B?NkRNNHhJYmlQSTBoTHYxWGI3TUZ4T3dHMkw4QmJ4OXJIMG81aDR4SGdDYURP?=
 =?utf-8?B?SEwvTHFvSjkyM0d3byt1YjRaRlRVMldTd0psa3AzaUFsU20rTzhVVDdYbFRW?=
 =?utf-8?B?aUlzUGluRUlBalZlcDM2MWVLdTMvNmFMZjllczFGTkR3TWFHRHFJcjJGakVa?=
 =?utf-8?B?b0ZydGxocHIwNllYWGNqSTZuMnh5UkRDTFJObGJvdXhlRkdBTjJRdjI4djF0?=
 =?utf-8?B?bXVHOE9ML0NjVWdpMk0xdVNXZzVlN1d5NmhOOWI0M2F5Wm9SSjIvOWIzK3Zu?=
 =?utf-8?B?Ry9ZZFM2UTRWVE84dXAycjRoQXNrZUVXTDF6Q2laQkt4Q2RWaWIxc21PcHF3?=
 =?utf-8?B?N0NsamtjVVRmdEtudlQ2bDNQMU1EdUlHK1ZxQVlZYmt4Y1ZvWTlONDEzdUhj?=
 =?utf-8?B?ODdxcy9LTVlsdnFrdXJIa2xJTllNSVlZanRNL1U2UGd5RkNlaEpramVaQkZo?=
 =?utf-8?B?VERFSThyck0yOHU5dlprV2xIOFNUMllROFdNVFVnYW82b29JRC9zTWdudzlk?=
 =?utf-8?B?K08yVm4yZGc5blY2Z2l1UHRmejJiaXBpL1F5cUhIWFdSRkx4VkJFb1RKUmI3?=
 =?utf-8?B?QWtIRVdZZWlEaVlFZGtzT3dkTHhUS0YwNFlxekVEVGpxNk1YSUpRT3NKNmhK?=
 =?utf-8?B?RUxjREVpeERVTGpMT3dpM29ITWRCTjVUWGFVbEM4QU9Td3BwVmpGRmhHcEFG?=
 =?utf-8?B?UzN4MG9PVDlaRDdIOTdWUHRsV2plTWRoSzQvTXhhZVp6Vk42ejdUekxUWTg0?=
 =?utf-8?B?d3c5MXBLazd5STU3UHN3U2JSblNucXBnSERYWEhlcnY5NFR4V2lvNzFPc1Ru?=
 =?utf-8?B?NTREdVFtQ3dJQ0VnZThOV2JtUU1tcU1XT3lRME9rNmdiUXlGRi9PVU5Kam52?=
 =?utf-8?B?dTVYOHp0eFJFelF2VjlMcUg0NTQ5c2hIeXhWWFdaWG5HTEFlNmpuYkQ5NnVH?=
 =?utf-8?B?ZHRwemxpbDROd3JzNGRxa2tYVk9xaXpjc3lJMklCRGR3aEd3empPdXJmV0NF?=
 =?utf-8?B?N0dpdkxaOWpRakU3dDUxWXJTT3Y2TW9VZSttWDErRDk1VVBqK0lLYlZISjUv?=
 =?utf-8?B?cElFUnlmdDdaZzlycWxtQ3o0QjFBNzBLVGNQYnNMM0ZwblNXMDhPeHJFcGU4?=
 =?utf-8?B?dFEzVXRNZlhwbkdYd3l2RnRSdGhZTUZHZElBc1Q0Y0txWS9GeGlNemdGeUJ6?=
 =?utf-8?B?WmFWSUVmT1pOVnJrUUJlTVljbnJ2dTVzUVYzUkZ6RDFOM0xkZldaMDJWUjVs?=
 =?utf-8?B?SCtrOGtDTGF4V1V5ZnRPQlY3SHNNTDZIUGpaRERZN2tzR2hsL3gvVzZ0b2xJ?=
 =?utf-8?B?cE5qeG56YkNIMWNZbTRwVE50b3hlOUJXN0piQnpHdlBSc2l4NFBNWld4SHo0?=
 =?utf-8?B?MVFIRFhJclZLSU52bkJqbUg1YThEVW5NUGV1SHgxbVJ6SmZuYkpjR01RNWt5?=
 =?utf-8?Q?obBmhdbHHpMEVxu25Idllno=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec121955-8af7-4e58-df92-08dc894c3e81
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 12:52:54.0425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPUg13D0sRz6LguCW1iudyX1KQ0ZUKIXqOBHW6/7Moe0axQHYutHzsi0pNmPwW8ajqXDpkZKamfvMLpBmku3w99sC5mNm6frI5CrSWGoL9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5650
Received-SPF: pass client-ip=2a01:111:f400:7e1a::716;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/10/24 14:33, Eric Blake wrote:
> On Sat, Jun 08, 2024 at 11:36:59AM GMT, Alexander Ivanov wrote:
>> There is a bug reproducer in the attachment.
> Summarizing the reproducer, you are repeatedly calling QMP
> nbd-server-start/nbd-server-stop on qemu as NBD server in one thread,
> and repeatedly calling 'qemu-nbd -L' in another, to try and provoke
> the race where the server is stopped while qemu-nbd -L is still trying
> to grab information.
Yes, you are right.
>
>>
>> On 6/7/24 17:00, Alexander Ivanov wrote:
>>> In some cases, the NBD server can be stopped before
>>> nbd_blockdev_client_closed() is called, causing the nbd_server variable
>>> to be nullified. This leads to a NULL pointer dereference when accessing
>>> nbd_server.
> Am I correct that the NULL pointer deref was in qemu-nbd in your
> reproducer, and not in qemu-kvm?
No, it happened in qemu-kvm.
>
>>> Add a NULL check for nbd_server to the nbd_blockdev_client_closed()
>>> function to prevent NULL pointer dereference.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>    blockdev-nbd.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>>> index 213012435f..fb1f30ae0d 100644
>>> --- a/blockdev-nbd.c
>>> +++ b/blockdev-nbd.c
>>> @@ -52,6 +52,9 @@ int nbd_server_max_connections(void)
>>>    static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
>>>    {
>>>        nbd_client_put(client);
>>> +    if (nbd_server == NULL) {
>>> +        return;
>>> +    }
>>>        assert(nbd_server->connections > 0);
> While this does indeed avoid the NULL dereference right here, I still
> want to understand why nbd_server is getting set to NULL while there
> is still an active client, and make sure we don't have any other NULL
> derefs.  I'll respond again once I've studied the code a bit more.
I agree that the patch fixes only symptoms, but haven't succeeded with the
bug roots investigation, and decided to raise this issue with the community.

Also, later I reproduced another bug with the patch applied and with the
same reproducer. There was an

    assert(nbd_server->connections > 0);

violation in nbd_blockdev_client_closed(). It happens much less frequently,
however. Think the reasons are similar to the original bug.
>
>>>        nbd_server->connections--;
>>>        nbd_update_server_watch(nbd_server);
>> -- 
>> Best regards,
>> Alexander Ivanov

-- 
Best regards,
Alexander Ivanov


