Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594DC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbgt-00055M-Dp; Mon, 10 Jun 2024 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sGbgs-00054R-5n; Mon, 10 Jun 2024 05:51:50 -0400
Received: from mail-vi1eur03on2070d.outbound.protection.outlook.com
 ([2a01:111:f403:260c::70d]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sGbgq-0008TR-1B; Mon, 10 Jun 2024 05:51:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjzeARgx0vO8pF1NClDG9/VLLlIo4Agf3fY0kxasS1/e7l4eH1la8AJfaJaFh9Kja+zwizhOxdpLhmDg3oVVHyeaQCNkGJs+jZFcCyHK/D8kmCt81zEQd2FcZVJQ3A8qoWbzvZ1IR49u2a2fs9Y4H+/uDyXw7N6QrCEupXxtMc7LaKhOtTQ64KO/sqnOLcmjh7IWVPb9YFLQkV6QBZCK8YznMCR/gWSroe++s9mcbaF4AP5ydMhGY0IcqA3LJI8FaYVYcArGPsRrRrdDdHD65UQagQYDZ+cJsbNetRxuWkjbIyVYidsc6wND8rHKOwrjXm+JFcr9tb+DB82L6xk9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6nDcqDR1CbH8gR/D+sTDjvA6SvjiCxeiTpKE7H9sSU=;
 b=jaOJpqGENAs0WS9LfJOOr8Lg/ZIoX4jiyBGIGPVcgdAoAegaZ3fARiRATOj61nMcuhaYL/Gsd+CsPnB28TS93o1QFumL9wDImn9BuW3SMSCNONv0ANPZ5X+eDE31zP4gv28M3mXauz13ccIQR5sLwvgmMZkkbA6/gYn9p/vn3+0awZq4dHXjTJV6tvC17nXtRHdyvwGIRpTwIqX3wb0G1OaVfFmFmPJQqPv1mnUJYnarvBZytzx+0V2FouTIB6kfUrQOVXz0PuUumxIhynq6i2aSZIQeg2rJ6LMz6BVzp/9vVPUR1wunGfv+8Y6oXqUuGmmdyHfSPYCDQc5K5bCu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6nDcqDR1CbH8gR/D+sTDjvA6SvjiCxeiTpKE7H9sSU=;
 b=fJeg/BHarR0hYzNI/eA6ALS1fDLJpxcBXWfO39Z1eHN0IpUqdSY6sTc1UrB5pistWmrwlDnUHd7fvaM2/35a4bwJ7766MN21w1VXyh85ITDZuOuLTtJqxDz2HiqXS9FGUHKiNh/Fe/XESiEcmfS4TZ2YQl7qvquqdPVisD7ul+yWRWKLqC1CTgG+8zqhVXSrjAtUqjPA+1zieuKOnLyXJWQvESmPWfTbnNNwUd1loswP4OB0pIcnoph4C2feHFEvIjV/9yiuzumoysP6aDSpKbdLSvdqXC9GBAjUFMGf9pDH2hziw9/ram80aCx9Mv/LeF7Ou4v9horiXsDnneSZWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS4PR08MB7578.eurprd08.prod.outlook.com
 (2603:10a6:20b:4fd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 09:51:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 09:51:39 +0000
Message-ID: <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
Date: Mon, 10 Jun 2024 12:53:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS4PR08MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1fb18b-d376-48e6-6e87-08dc8932ec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGhyVzl4VW1BMEorR2ZIQ0drZTVIbkxMSVFHeVpzSTV4ODZjbUkxcVpYSVVj?=
 =?utf-8?B?aVZxVEhZRkVpVUNsN3I0WkJ2YkVjeWZzMXFWQ0xpY3AxRmREY0cwdnlrQ3lD?=
 =?utf-8?B?dWluTGxkeE1DRUQrY2M5SXFuaTdJMGVsYjJjN2UyM2g3UGNlRDhsRkRHWVFF?=
 =?utf-8?B?UzIwVkpXc1BkU3ZueHplVU5EdnNlbHlFQ0FZTzBnZC8vWDd0UXp0em01KzZH?=
 =?utf-8?B?UzluWjZISVpNZjRDRGYxM1BLbkVQVDQya1RBTFRtaXdQVFppejNVOVk2RE1u?=
 =?utf-8?B?d1BTYldCSjl4ZFpoOWFjTnVjMTEvMUxINW5TKy80ODkyTlBiSUVxTWQySTMz?=
 =?utf-8?B?OHZnNG55QTdFWkV6VFFuS2U2NEdkN2tIeHBRYWQ3ZVNTbmVHbjcyU1dIZnRm?=
 =?utf-8?B?VWNjOGc0MHFZYVJpRXpkdUxVbXJEczI5dTMwUHNzS0lEV2tsQ08xeVhoK0Jh?=
 =?utf-8?B?NFZFUkNuUytmaXd6K1loSGlvVzFZMWJMY0ZlTTR2V251ekpkYmdZd3NxSlVj?=
 =?utf-8?B?T2FoVm1kNnY4MTk5WDJ2RkJ0S29PaWxOK29pVGJDRU9mdW15VFFtQjh4TWht?=
 =?utf-8?B?YUxwZld0aDhIbGhWQnNmQ0RjdTdiMnZWeFljMksrUlVJbW9CbGtRS1VHd29W?=
 =?utf-8?B?TGg5OW1uVDVMM0o3dDhKcG85bFQvU2NtQTgvdWQ4Y2tlYmd0blltUXNnOUpP?=
 =?utf-8?B?STV3NUQ1ejZzek44d2g2N2ZmV1JBejk3VXBGV1kycTJ5Sk90czl1QnZOajFz?=
 =?utf-8?B?VVZkeWk4K2VMbHVNQ2VhSnN4bkRKcVYzWjRGUTdTVnNTUUVmdHQ5Z1ZvSmcx?=
 =?utf-8?B?STJHdlg2NVFqSkdwNEExZDM3RkZKaWdEUzB6R0ZuTTM1TGNJM3Q3RHBTWTJ3?=
 =?utf-8?B?aFJvUWJ4SlFZeVRXY05jdWNKUy9DTURvY1Y2ZzJjbVVMZm9tOFdsb2RNdENV?=
 =?utf-8?B?RjZLeWFtRThpNU5neTRvQXBlbEFQRlhRQmFNL3dDbDNxVXptTGJWejFDQ3V4?=
 =?utf-8?B?VVI2aFJlT21HbnpWdDRXVlE1N0djREV4ZlZkQnpRRnhVY3dzbUg1WWNhd2hC?=
 =?utf-8?B?bFFjWTkzRjJuMVlDYlZsbzZlTjcweUxPcm9pQlcxdEVGcEYyYWZOcldwc3M2?=
 =?utf-8?B?Q2g3M2dVSzU0eVBQQUxoejdJckNoZVJIbUFDTDNHMGorV0dDTlNOMnJ3ZTJO?=
 =?utf-8?B?K1QzZnZvbkFtWnRjLzRqdldnVnc2MEJDVlNCY2orcGlMaWV0aWFrRU0zYkpG?=
 =?utf-8?B?TnhnWng3MzVtdmZmMmJCZStCZDMvbUppMjlmdnBVdWZtRzBFb3BlTHgwS3gy?=
 =?utf-8?B?ODhlYkVkL0NRd0ttU1c5eUovb0FMZzB5K1dsNlUweTRWTnk5MzFjZDJXWHhI?=
 =?utf-8?B?Y3Z2YW01TEhWdU5YVVNCMHJ0UTh2eVZreUlJSmxpWVN5RWtQUE1pQmVMOWFM?=
 =?utf-8?B?MmdwRXM5VjJXUUNjaU5zaHNpazV3eWowUXVvb2E0eGRscjlwRlhwdVVZZHZ5?=
 =?utf-8?B?ODVQeEVOKzE4cEJkWXRrdjZtdyszNXdLN1phVEtjZWYzQXplUGRPcTdabHR4?=
 =?utf-8?B?M0FrUHRiL0ltMHhBUW0zd0hGNURqSExTZU4xdTZtaFI3M2NlNVoxWHJzR29I?=
 =?utf-8?B?M2lKZ29EUjE4ajROZHFDcHlvT2s5ckNFS0tjK1lLbGphZDFZQ2NVcmROQ010?=
 =?utf-8?Q?VEZE5ewtueg3MBGp03Fh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5TV1JYZnIyU3lTYUJGcWs2T3FTR2kya0VqL3ZFUE5qQXBOUXIrdG1OS0tT?=
 =?utf-8?B?azg3b0lsYTlWbzFJOXhIenBzaytjK3Q4bXc0L3ZUZ0VnM2ZUYmNCdXNpb0dL?=
 =?utf-8?B?TmE5MFU3Y0ZVQW0zVVJUNXJOZ3NKb3ZsWE9GSFJmRno0eGljYmE1SVl3djRi?=
 =?utf-8?B?OHEra1lWajVTbDgxdU1BTGg5UXBhN3lNUHpiV0dSQ2ZoMUF2S2kyQUlPVmp5?=
 =?utf-8?B?YWZKSVNOcDJIWUpFVWU0RnBtTE9hemRoSU96YXptblBoeFh1NS9HQVhBRXcy?=
 =?utf-8?B?bncvdDJNQmJ4aUlvTlp6MWxUR0tkNkE1UHdSZ0cvbGJMdWsweWtuQlZkcTNp?=
 =?utf-8?B?UVpJa2o3RWtqTi9wb2k3cU13bDgxMFhSZGU1eGM3Y0dFSDUxTTBIMm5VUW9z?=
 =?utf-8?B?Sm1HMGYxK2FUUHRhODdJamh6cDh1WVRHb2tPTlZBMjlRblFDd01FV2JPL2dP?=
 =?utf-8?B?a2s2cStHM3pISU9GVUtvL2MrOVIvMG85b1VaSTNxRlRweHYzd3ZtVnVydWdR?=
 =?utf-8?B?YUxKR21NbFQvMSs0UmhjZzRnc2NTT2hxaG84TEx1NFZ3b3ZvTEdLeEtyU1hh?=
 =?utf-8?B?elJSaHJLWnhNZ0NVM0lFWjVyYi9SOEJyWnp2UXgzNTU5QUl5QWd3STg0Q0Zq?=
 =?utf-8?B?QWp5aHpGRjgyV2ZKenA5STlzMWRtbDkzanh0OFRuRjEvZ2xnazB4WDZpWGRQ?=
 =?utf-8?B?QUdtWlhXZUVkemM3eS9wOFRJT1RRclFYMW5NY0ZYV3FRMnh6dmc1QnZwdkQw?=
 =?utf-8?B?cjJJd1EwYnJ5N2N3dkY2eVI5V3NDT3FHdHk0c05GcUlXTjN2RlEzc1JmTGJR?=
 =?utf-8?B?cm53MndGRm5vdnBqM3BXZjRObG1HeHhQaEg2dXNBbDAzTmxxM2ZpVUtoMit1?=
 =?utf-8?B?S3JIK3IxdW5VbEhDaGJWSS9yeDRXcnFRTkw4UmF4Y0hQVVVjY2VkUEp4bm5Q?=
 =?utf-8?B?T0ZiWWc3SUlhWGNEZnBtM0ptZEVsQzJMdjZ3R01wSG00TWZid01NZnVYZDh3?=
 =?utf-8?B?eVkzem12MkpDS2Nqa2dZWjNlRk56MlVQMW5BaFg2MzhYbUJqNWZlRkxVN05B?=
 =?utf-8?B?NVlpV1ZMeHdCeHphTmx3VjVXUVN0NUl2elVPbHM3K3FxT3FyNWJWYjRRRHJH?=
 =?utf-8?B?NkgzLzZydUV4WDZkZWNNSW00MkVSSE44MGsxMno1UldPYnJvdlFndXUzK0JQ?=
 =?utf-8?B?S3MrR2JXdHBCS3FlWjVWOVQ0ZmxzaVZPTk9uZWliMjFUTDcyM2NSM0lyZkVz?=
 =?utf-8?B?ck1XMmlCSWFiVS9ITjFnbVc4VWxENVJOTkV3MWVRSnA3c3JBQ1dSTHNyeGN6?=
 =?utf-8?B?MWdxSzQ2K3ZRczhzdUxaVy93QnpUNHE3bHhMZk9sSkpQNjBmUnFCVXNSNFla?=
 =?utf-8?B?VGlMdkFkV0YzRjRHZDFCVERkam9ubmZFYnpoVjV6MWl5ZjNvb2hoR2pOVmw1?=
 =?utf-8?B?RUlDV0J3TDNJY3BVQnR6RUF1aU44ZUtRczNxMm5JbWdqaWpLUTdacFJEbG1q?=
 =?utf-8?B?clRZZnptTm5qVWZlbGtmWFRGZFlSRzBCRGE0dlJNM1RTQ2JYcy8zTWkxQ1oy?=
 =?utf-8?B?VDY5TG92RWNUbDcvcEQ4S2IxQ1N6LzUwUm1IZmdsUWtzcE4xU0ZLNmx3dmVD?=
 =?utf-8?B?VjJmS2QvTTAySnNSYW82UzZqWE9mTEpxTWRkQzI4a0dWdm9DbTlFQksrVkVM?=
 =?utf-8?B?S1E4U1JqZ3VzZ0xwcFJyUnRGWXpoUExyd2JocENNVWc5UWx2UXpqV2tlb2xZ?=
 =?utf-8?B?b0QzUXFXUmhvalloNTJQaTUraVFsUG9uY3BKVFlRV2hQVjVyRjQ3VUgyRGRI?=
 =?utf-8?B?VjNOWlMyT3V0Vzd5Mmcza0EyWStwd2p0UWtvRzV2TTFhV0txYi9hRkZTRmNS?=
 =?utf-8?B?bmlqTk05d1ZiMkZWbzF3NEdmU2NibklRRkhlMTdMU1VQaUY5R2o3b1pOa28r?=
 =?utf-8?B?ZjQwbzc0L2VrLzlESmFXdWJJZUYza1VNMzNxTUJXcXc2RWxZSzBURmVOSCtp?=
 =?utf-8?B?MkwyWHp5c0RiNjJEYzRFQ20zYlJhdXoyL2Z2SEtQakRDUGR2N3FXRDQraW1T?=
 =?utf-8?B?clR2czlvOThnN2RmRXhScXhEQ1doamY5SExyRmdxRmZ5SHhxWkxvY0ZmeTRJ?=
 =?utf-8?B?aER5MjRpSUNmelczeTRGcXlvSG1XTUd5UWxJa1FhVHIvK2JKa003c2ZWb0J1?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1fb18b-d376-48e6-6e87-08dc8932ec5d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 09:51:38.9251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jYGCBEnQ4O8+jh5HIzDnB6sC6L/tplkkAn7GfLbBfgGdByC/yJzlopoiFaAeHlupLHK1qunX/yFhAmeOUmQMyGPBanChARxXD0rebr6PFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7578
Received-SPF: pass client-ip=2a01:111:f403:260c::70d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
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

On 6/3/24 12:19 PM, Andrey Drobyshev wrote:
> On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
>>
>> Andrey Drobyshev (11):
>>   qcow2: make function update_refcount_discard() global
>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>   qcow2: put discard requests in the common queue when discard-no-unref
>>     enabled
>>   block/file-posix: add trace event for fallocate() calls
>>   iotests/common.rc: add disk_usage function
>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>     ranges
>>   qcow2: zeroize the entire cluster when there're no non-zero
>>     subclusters
>>   qcow2: make subclusters discardable
>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>     requested
>>   iotests/271: add test cases for subcluster-based discard/unmap
>>
>>  block/file-posix.c           |   1 +
>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>  block/qcow2-refcount.c       |   8 +-
>>  block/qcow2-snapshot.c       |   6 +-
>>  block/qcow2.c                |  25 +--
>>  block/qcow2.h                |   6 +-
>>  block/trace-events           |   1 +
>>  tests/qemu-iotests/250       |   5 -
>>  tests/qemu-iotests/271       |  72 ++++++--
>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>  tests/qemu-iotests/290       |  34 ++++
>>  tests/qemu-iotests/290.out   |  28 +++
>>  tests/qemu-iotests/common.rc |   6 +
>>  13 files changed, 490 insertions(+), 117 deletions(-)
>>
> 
> Friendly ping

Ping

