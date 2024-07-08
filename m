Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A07C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiQ5-00020n-QR; Mon, 08 Jul 2024 03:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sQiQ3-0001uQ-Rz; Mon, 08 Jul 2024 03:04:15 -0400
Received: from mail-vi1eur03on20727.outbound.protection.outlook.com
 ([2a01:111:f403:260c::727]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sQiQ1-0003dr-EM; Mon, 08 Jul 2024 03:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzMwqWX04r18X+PT0MPnHiqp8hgCB6QuRC1DQXcudr2rkG7e1QrUs4pcAlWsDRsb/kZKuZM/GHo0foIreIoXBc0sStK3wDHBtY98/h43zxzbUgodJ4uIGrRVg8g1t22yhMB4sd6l9VRKZMjwXBWwEgqvNaat8GlQrAz+SKgnK/46k5ChYrP37DMWsHdI9BbepsWW5lBrUo2xVkpNnn8sugVZ9N5G0qNfBiX29dLSp/FbToDR+y3d6OkAkarKpsOKp6/S+HDXY8JuCU8J0PrjqftZ01AWeU5w/YNBE60EWsHGR/iVLCxcmmmYjSnnpIPJyvPHxiYFhzS1GiBrZzgTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWrYCXCKuewsviC4dzzHiIGPGOP7pKjJRzs/gQIpyLs=;
 b=jxn9aaVKuAlwEa6n/Q/WkGLygedcs502AZmvs+ygYYVgjrzEcnysXZFX35OJrWQdEeVZ9vZeByG4l9buS2eoo6NFthoZyFMZ81XS9SBjlHVbjgwsow3/iEH+87tGoj8bOZM41W69IAuzj/m8qJu+8Ba6pCw7IXUMESsRY6fT7zddVqmjGCGl+7KcbJtTw2b/2Ip1iVhdkHglO3xM4Bb0aJ+KGukqwYg+RUlbGH5AGFsciEgfbGk6Krk+jeFnqhibN1MSCVNflz/S27hFfSOOSQU4AxtaRpsm+Bh1SnXmfbXabzy0IgXUkyR/ScnMzUFR/ysz65Bm0h6z3KkmzFCuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWrYCXCKuewsviC4dzzHiIGPGOP7pKjJRzs/gQIpyLs=;
 b=A8G0J5qJ9fhB/tZaaUbnkzRxuCfWqSB1+mq47I9nCmBpGKUfRthBnuvzM5C21op0TSQofpCLXsjnsfgjCxDW/0pPtURknNBFkUSzdZtZQGitYq1jNHMPMy7jW/It/M8/vf7p8/N8duwtgRTX1sz6U25b4qpeKCbxP6tEYxRAroHgNBjCvI5LuozE+2hbPiWEt0Ax3j2EFE00xkXwcyks7IGx20xhhAWUGVDCwJ2WemCBWcEljkqZOEsPWM7ubAxS9p4D3cvDmI4t878mNbN8UVL8K7o1SQfXGA0NNNIRXOjR2iFTaor6uXTcTYOfTCQnwHa7qXWf/Hu7rSat/+TSNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8875.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:04:06 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:04:06 +0000
Message-ID: <87b54f1d-aa46-4553-97f7-784dd74e700b@virtuozzo.com>
Date: Mon, 8 Jul 2024 10:06:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
 <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
 <126aefc2-de33-4b37-bd58-9d1079914ae6@virtuozzo.com>
 <f73e386f-643e-4776-8d16-2a43ee1b56aa@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <f73e386f-643e-4776-8d16-2a43ee1b56aa@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5724da3a-9285-415e-450d-08dc9f1c2803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q292TGVtZEFhaXNkbGZqcVk5Z3dVNGtHRllDNWNnU3BPOWNMeTJsQW52TGt0?=
 =?utf-8?B?eGdXTW10bTJ4YnZOUHV4M2RTaWNXSGl3R3lWbHlva2pyaTV0ZVZjRU9VVmJ4?=
 =?utf-8?B?TWZlTk9iQ3JvMGpBOW1OUGhlOFU0NEduS2xEUFpkQmt3K3dHK28rTzRRelh5?=
 =?utf-8?B?WHBZbnFxTmIzYXpqZGs5Y3c3TDZQeE53TjU3OEU5UTV6ek8wL1EvSnpFbG9z?=
 =?utf-8?B?WlB0TFBvSW9Xa3dPNzJSTUw1N1Znc3A4S2lHRERPZlVpajRoQ2tHbE94aGVp?=
 =?utf-8?B?QmNZS0JaL25YQjFtQ3VQMUNTSUxaUTRad1FoN1BNZFp0MzRSSXpOTkZWUkNh?=
 =?utf-8?B?bFE3RFF0amZTUnlWbXhTWksrUURzWnN3RkF3U1BBTm5NUEtWTGRVMU9KMDNz?=
 =?utf-8?B?WHkwMGF0bDh1T01RdFQyc2Z0SnZ1T0hocnZUU2hRWVVDMmhrRWF2OVJGbTNO?=
 =?utf-8?B?YzJLKzdFd0IxcVF1b29pUUVab3dUTTU0d2FmcDVzVVhRNk42NFhTWkdHZlps?=
 =?utf-8?B?YUdoT1o1cjJQajYrcGxiRC82TWZpWklVM1NzWHVsVXh2RXVkZnB1NGtVTGdi?=
 =?utf-8?B?VlQ1V2Z1T3FoeFZwemcxcFB4c3UxcXlNbjlrbnBCclg2enFNZThJR2ZNNmd1?=
 =?utf-8?B?S2VNZjRLSXp2dmxiSE1CRk1wQUo3ZE1lZzREMUtYSXRTamJsYnFteGZZb0dT?=
 =?utf-8?B?eXBzK0pxK2JxVHhHQTVYNkQ3WG83NzJtOUNHemtKcUhsV0RzbnFIdTFPTkhY?=
 =?utf-8?B?VFdtSGZSM2owY3luVFhIRlpIdHF3Nmk4a3FSMU1RMk9BaEJKY3UxWU5meWsz?=
 =?utf-8?B?OHJFRlU1cXBoMlBJU0NDbFVTTFNTenZidGpHR3g5TmRRNjJoQ1BEZzY1TXI4?=
 =?utf-8?B?V3VwbUROTEZiS3B3TlJzWDQ5VlR0cS9rWnNwWG52L3JzLzBuK0pmL3lsbmFj?=
 =?utf-8?B?V2YyQmJJQ1JRNmNZVU96anZFYXhHRnBWZnl0bWQxTFNkUXp5YlJEZS9QdWxS?=
 =?utf-8?B?bit5QVR6ZDUxVXJDdTZBa0xjYUdEcnZaQ1d1ZlJiM2lKc2xzREJEdjgxUGVm?=
 =?utf-8?B?d1g3Q0cxc1Eza2hWajBTcFdya25tNklDL1RJckdVbVlkZllIeSt5dzBET1c3?=
 =?utf-8?B?eGIrb3pYd2JON3FwQUJ3V25UZlhHeXJWelAwM29UeXVHNnJ4OXd2SGFFOHlS?=
 =?utf-8?B?aEdMVkNnNE5uTng0bnk5Mk5ROHB3TVlmZzZyT2s4OG5jVnF4SUVBcTlLc1d6?=
 =?utf-8?B?MnlLSnBxam5MMHk0WjNIb051TVFWOE9HS3UrMkdWTTJLSVFGUmRXS2xrVEFQ?=
 =?utf-8?B?U1FFalU4WXF3UkdPeFBQdWJ0TGd4b3NrR1RLNVJOMEZKTWVWYW5tNEMyMW9t?=
 =?utf-8?B?Nk1uMGJEdnNKYjN6MTYrU0RJUkFIYlVTNjF2OWp1MnhNZ0E5VFlzZHZYOC9M?=
 =?utf-8?B?endwYTFOTktoZ0h5ZDhVZlFVQTJ4UmU5RWw4NXI1ajFhK2E1bGpaalhLYXFQ?=
 =?utf-8?B?VEgxVkJnRkVJVmJERXoxYUpHaThZTEk1WGJmRUpqaG9KUnVINEJ2enVKUnNk?=
 =?utf-8?B?eTB6dnBPWGxJcjc2TjVHeFhzTUFNVzVySXZUdlA4anlieHRIdm1LcTdlTEcz?=
 =?utf-8?B?NVJ3bFB2OEViV2owRU9MUHRqWTd5c2VDR0lpbXh4ZzZPTTZXeEV1YVFLbmRj?=
 =?utf-8?B?a0dLb1NXR2dsY3FTYzdONFY2V1JBdEo5c213anJ0ckF1S3ozUlRGelpIYWds?=
 =?utf-8?Q?Ms1ZpAliTBoyzJ4nX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHIwbW1mZmJhdGJmdi9uSitTditJSEhLZUhYWjVVWTNqMWFQbkowNzA0QjNq?=
 =?utf-8?B?Q0YyaVBWeXVKUFloYWlJWjhxMTV4bkxUMHZOMDQzN1Z0bzJzZGEwcmhQa29i?=
 =?utf-8?B?bXd6QkFraHJRQVE3QTVXaWZQK2VDZklMbWdsN1p6dEFQcVpQYWJhYlRiQmpN?=
 =?utf-8?B?ZmM5RlpjSEp3SWMrTGd5eEJZTHdEUk9ZNm54eGgxTmxubEIvM2htWEQyS3hD?=
 =?utf-8?B?akFRejV5VDlKNm5RVGlaaFkyRWJVMVhPVldJL0dMREhiNG5XMFhCUmZoYjRq?=
 =?utf-8?B?cnVoL3FaYnl4RFBSZ3Fka2drTzZtUkZ6Q1NNRHhEQTRkNzBmL2x6UmhUNEZT?=
 =?utf-8?B?MzFnY2RYQkg5NDRsdnNHZDlLcm9sblcvN3Z1Q3JnODViYzJnaE1iMWl4RUwv?=
 =?utf-8?B?Uy9vT1RYSjkra0g5NXZFTTRNV3hMd2ozV3EvZjVZNCt5SXpxUjZCOFY1WWoz?=
 =?utf-8?B?U1pUSzJFMmErejkveXJUYzVlVGpxSFErdUJrS1NYWjJlL0cxNjNUdlpnNWZF?=
 =?utf-8?B?TnBad1lsQzlaZllrdm9wL29HTEp3M05VUjFDU0J5UnhYZkNVa0xzVVlhcGZP?=
 =?utf-8?B?Y0lqRnNLdWdSK09pQ1drdTkvdlBXVTdKelRTZE90TmlQZmhSQlR0aFVyTzZt?=
 =?utf-8?B?T0dTZmN4UUUwd0psc2hsNmZudG5sVkFXWXJLYVAwNGwxeHhCMXFkMlI4dG54?=
 =?utf-8?B?WCtwcjlaVjBJZnN6WS9oNWtVT28xMTdYQ01JM3Vld3VVR3B2TFl2ajJ4RHRT?=
 =?utf-8?B?SXdWNHI3MGxodnVzOWV5RDB6ME00cE4wT0hCbVJRaVN2UnpiUSt1b0lGNFVj?=
 =?utf-8?B?ZDlFNlFZaXRKZldKTUxmRzAwWkFHK3NPNWNldjJFcHRIbkI3bTQ0SmpRdVNX?=
 =?utf-8?B?MUIyOUNhSGxDQjZ0RDBHbTFkTjNxVm54STlnZVJmc3U2SmJiVElEZitTY0Nz?=
 =?utf-8?B?bUJHRGlUMnc1dmVGajZyY3dmbUI2VEZaYStnUzFqMUlMWDFkQlZoRjNYS05V?=
 =?utf-8?B?QUJhQ0FKQzZjdnBUNEc4Y2hMOHdQODQrUXBwNG9IMTcwK1g1cWpZRlR4ZlNG?=
 =?utf-8?B?OVZkSzltR1BiZEJsMHUvcllEdjlBRzBhd0lmRmIxdWdhU09KdjdpMnU2WW1m?=
 =?utf-8?B?aVJrcFBFaEZmRWd4eGU3R0N5SWNDK0owK1lVdGQ1Uko4V0wwdG5lellhdTNP?=
 =?utf-8?B?azNtalhRckwrNEJwSVRXUjlXb3pmbmYyVFEwK01MMVBzQVpIV1l3ZXJSUW1F?=
 =?utf-8?B?TDgrbzJReTVCUEdhU3hUZCtWVm40akNDV1BNbnhqZHMvTGI0S3NkWnZQZDRZ?=
 =?utf-8?B?ckpSU3AxVkJNejl3WXRHQzNlaHMrN3QrcHBLTi9LcEJVOWlYK3I0VUE0ajRE?=
 =?utf-8?B?dHpoUU11cFN6bzZCamdQSmRDUUd1d2Y1Q1hUQ2FxM043b2ZTMDc3eDlPTGhB?=
 =?utf-8?B?QnY0TUtsUnRRcFU4eDVHdkdHbFlkT0RYeGRFTnRVdzN0L3dkbUpHVWVOVG9v?=
 =?utf-8?B?MWtkSTB4ZXIzbU1zejNmSXd3NklhdkdjREJNbmtJYXFKMmxtNTFST2p4ZzZy?=
 =?utf-8?B?T3hla2cvL0xGT2J4RWVpME5HUXhkVUhqc3BwcVN6QWxoUTBsQ0RlM2tVc1Jm?=
 =?utf-8?B?M0hveWt3S0VXNExjMi8rWmh0WW4vS0hDNVg5bEZTUGpLckczdk91US9lV2FI?=
 =?utf-8?B?WmNjby9kYytFR0crR3VheC9xbEVRcmpaY3RUellYRnVTWHVjTnNRRnFIelI4?=
 =?utf-8?B?YXlFMURiY25aS2l6YW4rajBKN1V0Y0w3dlpKUUZSbDFqN3JDSkhRN3MxbkNH?=
 =?utf-8?B?ck8vRXFXVE5UUlB3dzg4algvRlZRUFgzZkdraUJUM1o2a3VNSksvWkpHZHRx?=
 =?utf-8?B?aEhFRStKK0J0ZnZsOW53UTd2UEpleXBDVVBrNW9ESUNVVWUyMFlWZ0hwOGlP?=
 =?utf-8?B?Mmdqd1VXMXFCNFNNcmk1b1Q2a2ZTejZRTkN2VGNQTXMyQ2lIV20vSzBWZy9H?=
 =?utf-8?B?QStiNmZManpvL2VxeWgwdVg0UVdndjRCVEhIazBCalBWYUp2KzN5TzBqc0FF?=
 =?utf-8?B?bllFd3p4YVNOWTNMMmZrNHU2M3AxQ3UxNW5aWWdpaGk4TFgxWVhzNXd6Q0VR?=
 =?utf-8?B?bGI5azBFRGtWNG9iMFhmQmxMci9CQTZxUXNwUnlxMGZJUVpkQzYwQlVrTG5I?=
 =?utf-8?Q?fMISCFszqY6lgkXswg2O5Sc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5724da3a-9285-415e-450d-08dc9f1c2803
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:04:06.0979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsyJx1Iw2RTFSFHjuB9EjCvOTieYKnTjecWwgKUo0WbvKMoqQVeraOThsdtwGo1BdNCLbxfyfrlRhmqSXYLp+0JMkt/5Vx0ode6UbVIA2YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8875
Received-SPF: pass client-ip=2a01:111:f403:260c::727;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 6/24/24 10:43 AM, Andrey Drobyshev wrote:
> On 6/17/24 9:39 AM, Andrey Drobyshev wrote:
>> On 6/10/24 11:53 AM, Andrey Drobyshev wrote:
>>> On 6/3/24 12:19 PM, Andrey Drobyshev wrote:
>>>> On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
>>>>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
>>>>>
>>>>> Andrey Drobyshev (11):
>>>>>   qcow2: make function update_refcount_discard() global
>>>>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>>>>   qcow2: put discard requests in the common queue when discard-no-unref
>>>>>     enabled
>>>>>   block/file-posix: add trace event for fallocate() calls
>>>>>   iotests/common.rc: add disk_usage function
>>>>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>>>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>>>>     ranges
>>>>>   qcow2: zeroize the entire cluster when there're no non-zero
>>>>>     subclusters
>>>>>   qcow2: make subclusters discardable
>>>>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>>>>     requested
>>>>>   iotests/271: add test cases for subcluster-based discard/unmap
>>>>>
>>>>>  block/file-posix.c           |   1 +
>>>>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>>>>  block/qcow2-refcount.c       |   8 +-
>>>>>  block/qcow2-snapshot.c       |   6 +-
>>>>>  block/qcow2.c                |  25 +--
>>>>>  block/qcow2.h                |   6 +-
>>>>>  block/trace-events           |   1 +
>>>>>  tests/qemu-iotests/250       |   5 -
>>>>>  tests/qemu-iotests/271       |  72 ++++++--
>>>>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>>>>  tests/qemu-iotests/290       |  34 ++++
>>>>>  tests/qemu-iotests/290.out   |  28 +++
>>>>>  tests/qemu-iotests/common.rc |   6 +
>>>>>  13 files changed, 490 insertions(+), 117 deletions(-)
>>>>>
>>>>
>>>> Friendly ping
>>>
>>> Ping
>>
>> Friendly ping
> 
> Yet another one

Ping

