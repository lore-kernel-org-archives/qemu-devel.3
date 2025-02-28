Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F4CC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4RE-0005SM-9V; Fri, 28 Feb 2025 12:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to4RB-0005RD-3I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:46:13 -0500
Received: from mail-am0eur02on2121.outbound.protection.outlook.com
 ([40.107.247.121] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to4R6-0005CS-A3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWdSu88NtpsPpSKAVCZ6uZp0jqMbDk0HPsD8mY+Gv4VxKLAlxFZtTINtxkzQiKzdkUQFv7dbfnZpHS/26zTy2DeWDk11u90rJ8AoHm7Lyx5EBPw6OLPaHU0Gy8hJzbosMHBFk/mH1muvwFn9VRPdXe9IRAaKtIwiilgUODzb9QFMkaDs5ZMG/qgMUSvDjgD4e5+mk/YpGiZqTXUl8j+BBZOHtG4aiXqd1LGhCuh7599DEJ64qLngvSBMEN3sYWfWz3lWJS1Qtah/1484Qu1fKN5B1wBbBHiNvmy9TV/uw/Ybdl/aptczCrO1uNc3RJvb2L7BbNffz3S6DGNaul24CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERprXTcW8GeO4lgmiXvknYcp0XEaslkiFmMVObXWCPY=;
 b=KyvetGETKeCyU+KACRN0sGIK4Bwt5BP/V+sw2C8R/p+ogCYlrc9HKBLaXJsXUYu3Q+Y+VsQ1+m0B0WSn5m7C2g76yQfnMdrLUM7HLWEzjCtNjxZiEHUM4MoGbaJENMGCq7bxVDD9aL6qr6lxTr+PsW/XohRwPFNe7hk2Kh4SZ0PsBW4HcUAuvTN+OCFWfPDSA+6HUIjKenIrK10xsGFZsqc1y/rJQQnHb6XnNSXBDY4b7bbF+SRmcFAE4g9yOkj1msDzmlwryDPFLRj/yAOgG0MLvG5OTYxH0iwWbUIfCCJRHj1redMKJwfi8812pRk+k6864LqzUDi+bfsc3DO9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERprXTcW8GeO4lgmiXvknYcp0XEaslkiFmMVObXWCPY=;
 b=g4W/bu0o48lybajkxKd9iEaW6POwaCq72tuARV/8HWZxyc8YhQFCymMpE+2FQLRrqMfUTRYIPE4RFitzvulGjs1C9i40kD0Y3Yd0DalSTZI+Vx3WoTwRAEDqcwmImLCb65VcpwxPbeylcoxyZiWQKMUHpu2Mc1wnC4b/Mps2hNq/++F1iPEcFhTWGq3s5gnCQFKgr0pBL6MqRnAD67hfnsWXLU1Q1eF9+vwthzOfLr7E1ki+WvWZoP84ZEj5214zFNr7VKvwmHb5orLmSml+8lN8dU0jej8iorQiCK0d2KMCrTQz3KqmOypCPlsN6n4nvzC6uJSt98p+wDfpS67ZOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9667.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 17:40:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:40:57 +0000
Message-ID: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
Date: Fri, 28 Feb 2025 19:39:57 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 William Roche <william.roche@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, andrey.drobyshev@virtuozzo.com
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: c377b6eb-9808-442f-1b27-08dd581f0eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTRscy8wQVFvRVJja2lUcy9JVU1tQ3NOcmg3SjNnaTJJYmN1TmxWTDU0Nkg1?=
 =?utf-8?B?NVVDUER2QUwwMVBLYlRwMHYzZVZxeTVZaDk2UFpTWTEzWHkxZ2R0UlREOGln?=
 =?utf-8?B?T0RVbTFqeExOUm5ORGljeEVTelBKQjkwWHg3cUlrSWxSR3lna0cvdHFuUjVy?=
 =?utf-8?B?M29mcnRaRU9tR1ltcnF1d3NnSzlzRmVSUjloOXZaNVoxVWwrUURZcEhvYktk?=
 =?utf-8?B?VGdwYk1mQ2lmclRSM1orNmNxNkl6WHdEZjNGRGNuVVl4bmdyUHJsdnFnTUwy?=
 =?utf-8?B?czFBR2pqZDlvRzRzdzhSb1djYTd6VmdUK3cxdTlYd3hia0pIOFN5V01Xc3Vy?=
 =?utf-8?B?b0NLaEhGOFFQV2tnd0RLVzJhbWlzSGtjZS9lS1h6YStqZnQwM2dpUnNzK1k1?=
 =?utf-8?B?RzdXaE5FWW15UFR2SzgyRkZsckduTHcwV0NaVTk3SUZKWTVzdStET0lDaTkr?=
 =?utf-8?B?alE4aTlycU9QMUlOYjhZTXc1RzJtLzdEdm5SNmtjMWJDWGI0MWgybkJQWnpX?=
 =?utf-8?B?T3I3MUd3N2N0Qk81OWovdjRlbHlEUkxTdWtuOTV2dHVqa2V3eTliVXRSdXFW?=
 =?utf-8?B?QVRZMW9xR1RodWt6M1NabVJGVVluTDlDcSsya0VGbENTU2hyTnVwVHdzQnJo?=
 =?utf-8?B?NlE4QmltZ2grNGNrMzBrc0xoemRrMWMwcnFEdU1abTgyUlhrZk5CeVg3cHo0?=
 =?utf-8?B?NitWV2FSNGtzc0tXWFZuUEpxN0xlaENBbndiNC85Z1pKc3NiMmdNUGl2ZnVr?=
 =?utf-8?B?VGVGWnlSSkdNVUd4czNDbVVQc1ZXMlhGNXdoM3k0RFBydUhyVmlXOXRSKzEw?=
 =?utf-8?B?WXkyZjR1WlFjWXFyV2NpZUc2TVovOEczQWtERnNobnlGMmEwMGoxbVhuSGhp?=
 =?utf-8?B?bHUzMy9Xc2U3T0E3UXRoZFVhVTAxN1B6VU4zTUd2YTVLQW56ZnFPeHNNRG1N?=
 =?utf-8?B?YU9WMzVuTFBuRmhDSlBIcStlV3M2NUJJbStWTGdmV21zNDBxWHJmbjBVUEI2?=
 =?utf-8?B?TExnYkxIVGtZK2RjQ0VSZ3JhVk9hbjVDQjVDZWJGdDROdEt5V0JMSnpRZFdM?=
 =?utf-8?B?cDEvdm9PQTkyTHhlOWRaL3BCUStsbmRLRkoramc0cS83Z2ZYMDZsL25Cd3l6?=
 =?utf-8?B?RU1kb2VaMkpOOHM0ZTluRG9DQVdyaWtWaXgwWlhaOEdYQ3QrSFduRkRXYjho?=
 =?utf-8?B?eU51elFGVTllN3N6WW83VW0wZ2pEVE1GalcwcDN5N3Z6eWZVcGtzWUw4Y29M?=
 =?utf-8?B?VjErRllXeGlmQlNpYzYyemJRSTBkb3g1QW5ZQmxFZFpERzExZFJjcURTaTFP?=
 =?utf-8?B?WWZ4WXlpdXdtNzNFbzN5MFBHZlU2OS9LUkhaK1dmN0ZpN2F6S1pSeWoxY3lM?=
 =?utf-8?B?TDd4cFBOL3NaUk5IUVNsWFlhZnh3QnkzMGdzakoxOXNrcDFuc3lCeDJHL3ha?=
 =?utf-8?B?ZmoxbnlMeURpKzh2cGFiYW52TFVQWklZT1N6eEtrVGU2QVppU3RZUWhnNFZR?=
 =?utf-8?B?Vno5NUh4QWxSYnpjNml3WERvZDdiYzdpdVNQM3J0RVVLa1BiSU03ZEN1NE42?=
 =?utf-8?B?eFZNaG5tQnJISUx6WHFxMS95amtVOUZkdXh3QXhJVVczY1Byb1kyZ2JVOWZs?=
 =?utf-8?B?R1dEeFB5K1cwUkdqNVVZYTY4OVZ1Wi81V2s0K0tGbGRDZ3pOUGZndnlaenBS?=
 =?utf-8?B?dlJUd0JzYUpHaVR1WlhsOXAwNWxvbUVXcUJ1SlFSaGxmMlhEemp2KzNPM2Nz?=
 =?utf-8?B?cmxKRkFPWEVnUm5UcVBXVW80c3hRRHlKQVVyM1Vqc3B3c2xqL1BkNjdYU0tS?=
 =?utf-8?B?ZUdKcC9ndEE4QkUrQU9DZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NsUXB5ZUh6anYzSWVOUlBtZlZ1UmNiZGZKd3I5QTdFS204RURZNGdrbjJz?=
 =?utf-8?B?L3ZqRUlWak0yeWRvaExjTGpBTkF5Rk51dmhKWEpuODFmWWVUeVZUWUlqcFE5?=
 =?utf-8?B?RmJSYXNXSUFsRm9PY0RiM2VqdEloL3hDcmNiYmVBRDNSNCt4NGNwSUlycWRO?=
 =?utf-8?B?TDZCOHJRdFF3T3R0QlFrMG9yclJyelpTaG1kZGNSbWdra1d5TTFRcUllY0JZ?=
 =?utf-8?B?YlNmMHZTVkdBMDVlRjBJalRSWk4ramxoeFF4ZHJrdzFFWXV5alJ2SWtnaE91?=
 =?utf-8?B?N2pVK3dSTE5NM2twRkVTQWs5cHcweGZESHJ2RlErSHpyL3JxZDlGZ2xUUGps?=
 =?utf-8?B?Mk4vWXluV1ZBMjVGR0xTZDFCdkEwSm4zUXo5V2ZEYVhrWGVabXFlVHMzbmNW?=
 =?utf-8?B?dS9lUVNvSFh0aHNSWlE5TTFpRkp5QkRRZGllMGdMdTArYXVzWFlRMEVVZlY0?=
 =?utf-8?B?U0luU1VPNXNhdlBiWENxaWJoakoyKy9nWUQwdXZmaFo5a1N0SkdnVmRSNTFs?=
 =?utf-8?B?eEMyQzFFR0tHZGg5UUJvNlk1eURKS0t3TEZXelZKa3o0T3ZuWUNYTmdEUnRJ?=
 =?utf-8?B?NWFIa05EN0UwTFpjQnJFakk4bUx5QlRrU2JiZXZpdkxBNW04UmM3MHR3SWFR?=
 =?utf-8?B?RzJBRC8wSHY5TFZFVE9ORGdacGVqd0U4amprMm5WQldLTjd2UlBSZ3I4cjdQ?=
 =?utf-8?B?OTFMWUw4WUZnWmNjb2VWK0tQOGhiNE5SbElLL1VUWnhDd3MvajhZNW00YVZl?=
 =?utf-8?B?ZnpxZ3ZoNEM5OFZSeEppc3NkVlJGbVZDdjdpYXFBb0ltczdNSEdyV1hhdDky?=
 =?utf-8?B?UkRqZVI0Rm5LOEk3SmluMFY4Mkt3aEN4MWlRSmNuSmxOVXFMczZ0amV5RHJC?=
 =?utf-8?B?WXNhN3hDQ1hNcXc4SXRsTGhFSnJYdy9uSU56Q3NwSWFSVFVQU2NBZThLN1VJ?=
 =?utf-8?B?K0dDa1U2MWpNcElFSmlPazBIdXB1d1AzV2JWeWFlZGd6b0wrNVB0UnVSZVFl?=
 =?utf-8?B?MFArSnQ5aFAyb0tnOFI1MVdVbjN6a1ZheFpPeWZUQnlySmhhUU5HT0VyZlJ2?=
 =?utf-8?B?OWZUd2VMbnhzVUdodVBzV3F3VjBIODBGOVhrVnFuQ0hNQ01ueDE0eHhjbEsr?=
 =?utf-8?B?YWZwdndZbC9ma09mYVZkQUtIMzJ1QjEwdmtTeFBYa3lFdkZjdmp0Q2x0NXhF?=
 =?utf-8?B?SW5TTjVSdVJNeUJsR3c4bFd0RzlwNmt1UWoxT213YVdPSGxZQlNKc0toSGpG?=
 =?utf-8?B?NXpkMUNtbGN5UlI0TG9mS3VwTjN4cndIeUxqYU5RcnJLZStLdEMvR1F1dHlk?=
 =?utf-8?B?SFZHbitLQzViVlF2eUllckthTmpza01URDk0TFcybjVIWkdDeXEvaDg0cnNO?=
 =?utf-8?B?U1VEMzhjbTY5N1VOdHRxNWF0UVdQcSt5d1g5aVF0NWxhMk9vMGVCaDlrTFl0?=
 =?utf-8?B?S1FxQnhSMk1QN042QktCc2VYcXZUc2FiT05QalRiZ2dSWGFDU0x5NG41VExv?=
 =?utf-8?B?V056d1pqTEJLeVNvSmdrRURFSlpwckNPZk4vbVAwSFF0MVYyKzVLY1JlcjFs?=
 =?utf-8?B?Z0xKYmU2bGk1a21jSkJ5cFJCY05FMXdvVU9kZHRSb2F6TVFVVjFmbjUvYWtP?=
 =?utf-8?B?R21EcGgzK0wwSzNCdkg0ZVhBemJmdnVWZU9iYXZoYlhjOHR5NjJzZWRMYktK?=
 =?utf-8?B?dTF1aVNzODZKOUlMWURleStTZUE2U1k3cDJFZkJDWGovTE1iekNULzFzRXRi?=
 =?utf-8?B?VTFNaE9xYjFic2NGSEhPczBSbzBtdllsNTBENlhxMzMrNks4QmNYYlNXdDJW?=
 =?utf-8?B?eWJXdHMwbnJSSXRDclAxaVZtc1pELzNtYmRHUUdITEVLV0hENlZlcDc4aVdY?=
 =?utf-8?B?NnFodzNlbmo1MTBTcmtuY0N0QWJVRGt1VEJXSDh3THhlMWhFNy9Ja3JlWWhY?=
 =?utf-8?B?SW9DVGZpTGtzT2hRcE0wUVhscFBUWi9hMkZsWmNrZXUwL1NEVVlrOGpxenVG?=
 =?utf-8?B?UldwNWtHRVJzR2VvdVJmTzdJQTgrTGJVN2hhWVE5eUlpU1VFN2p1L1BXVjN2?=
 =?utf-8?B?dzBYSnVWTnF6VWZtb05NRHliRGxWbUdzeE9VTG5HeGF6TldtZnlMZEM1dDl5?=
 =?utf-8?B?ZExEU3BIU0toVnoyNzQzZkxQdCtEOFFETndHUmZOWmN2bDhaaXJKY3NxK3V3?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c377b6eb-9808-442f-1b27-08dd581f0eda
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:40:57.5006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/LyIxt/NSg5oZTQ3Zr9klup5MjB9RDKJHkgb9cGVTiYydgUsjRQcdzsrZRP0p8xKSehEX6BUZRMOse+/eyqjc2qzoJtGzIfs/HxAFQG8/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9667
Received-SPF: pass client-ip=40.107.247.121;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi all,

We've been experimenting with cpr-transfer migration mode recently and
have discovered the following issue with the guest QXL driver:

Run migration source:
> EMULATOR=/path/to/emulator
> ROOTFS=/path/to/image
> QMPSOCK=/var/run/alma8qmp-src.sock
>
> $EMULATOR -enable-kvm \
>     -machine q35 \
>     -cpu host -smp 2 -m 2G \
>     -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>     -machine memory-backend=ram0 \
>     -machine aux-ram-share=on \
>     -drive file=$ROOTFS,media=disk,if=virtio \
>     -qmp unix:$QMPSOCK,server=on,wait=off \
>     -nographic \
>     -device qxl-vga

Run migration target:
> EMULATOR=/path/to/emulator
> ROOTFS=/path/to/image
> QMPSOCK=/var/run/alma8qmp-dst.sock                                                 
>                                                                                    
> $EMULATOR -enable-kvm \
>     -machine q35 \
>     -cpu host -smp 2 -m 2G \
>     -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>     -machine memory-backend=ram0 \
>     -machine aux-ram-share=on \
>     -drive file=$ROOTFS,media=disk,if=virtio \
>     -qmp unix:$QMPSOCK,server=on,wait=off \
>     -nographic \
>     -device qxl-vga \
>     -incoming tcp:0:44444 \
>     -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'


Launch the migration:
> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
> QMPSOCK=/var/run/alma8qmp-src.sock
>
> $QMPSHELL -p $QMPSOCK <<EOF
>     migrate-set-parameters mode=cpr-transfer
>     migrate channels=[{"channel-type":"main","addr":{"transport":"socket","type":"inet","host":"0","port":"44444"}},{"channel-type":"cpr","addr":{"transport":"socket","type":"unix","path":"/var/run/alma8cpr-dst.sock"}}]
> EOF

Then, after a while, QXL guest driver on target crashes spewing the
following messages:
> [   73.962002] [TTM] Buffer eviction failed
> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824, 0x00000001)
> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to allocate VRAM BO

That seems to be a known kernel QXL driver bug:

https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/

(the latter discussion contains that reproduce script which speeds up
the crash in the guest):
> #!/bin/bash
> 
> chvt 3
> 
> for j in $(seq 80); do
>         echo "$(date) starting round $j"
>         if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" != "" ]; then
>                 echo "bug was reproduced after $j tries"
>                 exit 1
>         fi
>         for i in $(seq 100); do
>                 dmesg > /dev/tty3
>         done
> done
> 
> echo "bug could not be reproduced"
> exit 0

The bug itself seems to remain unfixed, as I was able to reproduce that
with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
cpr-transfer code also seems to be buggy as it triggers the crash -
without the cpr-transfer migration the above reproduce doesn't lead to
crash on the source VM.

I suspect that, as cpr-transfer doesn't migrate the guest memory, but
rather passes it through the memory backend object, our code might
somehow corrupt the VRAM.  However, I wasn't able to trace the
corruption so far.

Could somebody help the investigation and take a look into this?  Any
suggestions would be appreciated.  Thanks!

Andrey


