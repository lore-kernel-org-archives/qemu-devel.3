Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F390C71155
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPiVE-0004SW-5o; Thu, 12 Jun 2025 10:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPiV8-0004Ru-NS; Thu, 12 Jun 2025 10:01:54 -0400
Received: from
 mail-germanywestcentralazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::4] helo=FR4P281CU032.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPiV3-00032I-Nr; Thu, 12 Jun 2025 10:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZW1PwWLggiGzNn4OrAI7dA/2MWJoFgZqybm2PnyGQrLtep96KARlwKyg8bBHu6/AggkrbGBC0ED0l/suw0/7GxV/MccYaNeGbWxeDn+DAEzRPx21VkBL5kmVr1h5v+JmuKDjQWoM77a9zg5xq42/oQy0XWPAMZuyEE7Z10MZKj0zH2CbKCbxT/7fsLQraQkLhWd/cVvvWVcowf/87LtZjQ4xTRwh2wA1nnZmr5cgDUWGlme8tGawzaC4Jsr8TH0cKWQ81SaZHE3eLnfIOp7ohVhq47z4O7GFd4Ahqrz/QTZc+bhSWH6y3igw/JukG6kkiePmCyTkNa1VfRExgXMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q4dTXMpjYg42OBccdCHFD6Au9u+dHwzf8BJA/4GcnY=;
 b=vT9PGxEIbrpVamwb5AP5NJueC5h3drKhlEOWLtaxDwPC9EoFcU47yBcd1Te+GMUNYrNPDu6tvbfO9A5Sew2ILIbh7AZ4ue8A2v7TS2xOTbdH8tHgvVsCarwhnQg7vQ78T1mI6daT+ZvmqwfD7RDl/7omMBIizzXZbD51Jt8qD3WCXgCdilhDNb5lJ46IiGZDus1cdIdxqHB5LRSN71KSxOCCD4KQ5h+iwVyI1mwEmPEQiz/7P4kAtpR8dg6JCZwk+Nxln1qLT87QhQb3MWyHIVqgJPl2M4Y6Y6tZq/hjJ5Izo89NOgCmIXqgZxRe0YtzkqgOr0tfFxzklhLymw864g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR3PPF8BB5EE012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::166)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 14:01:40 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:01:39 +0000
Message-ID: <e898d975-d03a-4858-a26c-5f6c9a9c80c7@siewert.io>
Date: Thu, 12 Jun 2025 16:01:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Content-Language: en-GB
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20250611234350.40507-1-tan@siewert.io>
 <418f66a3-f7de-45d1-a076-9f14447c6bd3@kaod.org>
From: Tan Siewert <tan@siewert.io>
In-Reply-To: <418f66a3-f7de-45d1-a076-9f14447c6bd3@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR3PPF8BB5EE012:EE_
X-MS-Office365-Filtering-Correlation-Id: 9990364d-0039-4dc9-547d-08dda9b9a6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW9HRTY3SkxOVkV3VWRjTTA3N2h4bzlDU0NKY3FoN2RhK1pEOFpzN1JPenMr?=
 =?utf-8?B?ZzdWVkZIOUl2VzRDZGpHaEdldkJobUZUWG5BVFNKRDZDekxGdEtuMDA1KzNa?=
 =?utf-8?B?Rzl0SkdJSmczSFMwR3hRT3dIdC9NMGpmRjU3SFZaOUVJNXR1dW5DcGc5OFJx?=
 =?utf-8?B?VjRoZkhSWkV1UlI0YnpZalp2eGZFZE9jcFFuRHBYN0thTHU3OHRMcjFzd3o1?=
 =?utf-8?B?ZDNrUmpaM0Jyb0RySTIrTERUcHhtUFA2ckF4YzlCN2dBdUtGeUZUdUZEdDlB?=
 =?utf-8?B?TlBwaXlXU0lWU083WVFxTFk0QlN2WEpIS0lQL1paamNMTjU0azZDU2Fsa0Ey?=
 =?utf-8?B?QXVDdWdNUmNrb2VNZWlxQmE5OXFlUWptYjQ3TDVwR0ZSVmdTYkV6cWdYeTNP?=
 =?utf-8?B?SWh2czg1VWs0c3M0TldGSDg5Q1RXc3pyaUtzeFYyMmZCR1FDNmZiQWJUaWFO?=
 =?utf-8?B?RWJTdnJTYjYwUzByMGJyRjFPbWZZYjl4NFdnNU1zaElSb0F3WkhjVi9TZVhT?=
 =?utf-8?B?QWRZUDlmOUJqcGhlNXJwRk9hdktkbTJpN29GZ1o5SE1rdVhDbHdRN2JrREZj?=
 =?utf-8?B?RHhPZkFKTmhlZ2lEdTRDUGQweEhEQ2xid2NHUXdwMUptWGNmZVpyOFJ5OFZH?=
 =?utf-8?B?bEtZODUxdjhaVnc3OTlLV2ZLUDV0SDQxcWIwMFNSbEc1ZjZVbTRZUTNqV1RK?=
 =?utf-8?B?cHRhR2NQS1FpVVcrMmlkYUlqdDJuYXNaRjRQNHd3NWZVSU94ekd2NVVnVno4?=
 =?utf-8?B?Y0lVSjdkTUtuQUdkUksyUm1BYkdHVEdKcWYrMkIzZ2diUlArVWl3ZEpWMFN2?=
 =?utf-8?B?Z3pmVTltcThNbnVYb05hbmtuSEk2R2ZFTW1OYS9QWERIdWpVYzNHOFdqRDhj?=
 =?utf-8?B?c2VZK0hwdXMrZTUvTFFQbnA3cEd1bmh6ZlNMYWVQUVc5ZktOSXZjRDRDN0Vi?=
 =?utf-8?B?TE1Qc05XeEpQNmVOU2lsWVUrOWozcWtZRVdVZm9valFrQWxhMENhZS92Q1RP?=
 =?utf-8?B?WGZ0QjY4dXRJcVZmYUpTbUpzcmNqRlBRZHdlZ2VFTnFlWWZMb0JFemdRcUc3?=
 =?utf-8?B?dFhMcE96Y1dtYmd5Qy9jbVA2RFV1Wm5heTB3aTlRcDYyWTlsVDRQNHFUMjVY?=
 =?utf-8?B?KzArVjExbjNlMDB5WjIzM2dMZktGZ3JtNnJvaTVaR0VXTWFHQkNvUFBPT3o5?=
 =?utf-8?B?Y3pSTFdWNURMVEYzaHY1b2t6eVpLSmIwblJhWlhFSWhWSExmdmwyMWtoRkR0?=
 =?utf-8?B?ZmNuWWlrazhYTGJrVm1pUE5WWmRGK0tNMStGRXB3RjEwSGhRRlIzcXlDQyto?=
 =?utf-8?B?ZWRQeWZ2SEFtaDA4bzdiLzZLajFsUnJyMDdFYVdpSE8xRVRRVW9CQ29mNGsy?=
 =?utf-8?B?S29GSy9ZVWZQSVgwb2MvdlUyT0ZWV08xMDlGcE44dlYvb0pKYkY4ZFp2aWor?=
 =?utf-8?B?WGZtMFpXUG5VNGFtVjBPMDNPaEkrdXhCdTUyeHJhaEpGblpmZjJqMFpKNmNS?=
 =?utf-8?B?MGVvQmgvYi8vaFVBR1VzVytwMVJLck5aZnpSdEFFUHlKaWloV2xSa0RLMGls?=
 =?utf-8?B?UlU1d3BmampKZnFjUzlzWjV0M0dSdXFoUzJpMlRKODRpWGlDTm1vTXRwZnJV?=
 =?utf-8?B?Zy80YmtROUpwR0xaNklubjhHR2t3dlpKakRkY1J6VkF1UXdZSnYvWmo5QStI?=
 =?utf-8?B?eXZaekNzSnovc3RMZTBHUWhUMkkxdGR1QWhvMHVGQ2xjU3VhU3JwSk9FcXk4?=
 =?utf-8?B?Umh6VnduL2FSak9TTmZFU3BEVEpyUTVoR2U4SVQvVTEwVjloOTROUkpWUDd6?=
 =?utf-8?B?bXdjSmdyemZWbW1nSHdSUFRLWXN1MkpvQ2NreDcySFl5VVVDcWpsdUl1bCs1?=
 =?utf-8?B?R2l6cTRsU1FaYWlaUVlFUmVVQS9xSzZmQzlhbUpuV1RBeXVocjdKSVZDWlZr?=
 =?utf-8?Q?vmC5UxzMJdU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGU2VDQyQW9WZThPNCtKSGZ6UlJURkR0OTFXVHlPeldGdHEzQXZOT3lwMlQ2?=
 =?utf-8?B?Z2NTWWFWTGRDR3NUQTVJd3ZIdDdVUFF0NnBIcmZpK2d3MXF3UmdFM1BjUWdV?=
 =?utf-8?B?dFVDMEEyK3AwWkYzK01zZE4wZllhbVJKQnJMSVM0WFljVHdvUTVxclpxc3Q2?=
 =?utf-8?B?T3MvNWsrQk5Yb3diWTJpUU4rc0szMjNuNWpLRThXbDVRbWxtTXMvaElLbU53?=
 =?utf-8?B?WTUwK0tNU1ovczRSSFh6Z3JIRnJwTUhIbnBTakQwOW5MN0J2VmUyOHQ0N3FS?=
 =?utf-8?B?a1V5bGsrcGhxc1VlbG1SbXZ6OE1FWCtZR3Z0cjl6ZU9MYTVWQ1BJWmhXN2lI?=
 =?utf-8?B?VVRSRFNnNmEzTFl1UFlWZHdBR2xjRHZ0eEgxT0xFWk5abVZ2TkkySWwzbEpu?=
 =?utf-8?B?OWRpZldvcERlSWk5VWozeGJkR3B1K1Y3emprMUQrdU15eFU5anYrSVBwek5P?=
 =?utf-8?B?YmpmRmtjVGtySnlKRXRNaHdkYzlOZ1JyRFd0MmZBZHFpMTg5NmlnSWpia3N3?=
 =?utf-8?B?SU1aZUdFSUZpck1xRGRuY1lIb1U1N2o2QTNmQ2tLOG9nd2hNZlQzWVFOZndv?=
 =?utf-8?B?cHpDaWM4LytnSmducVRBVzJpMU1BZkJ2U3BISlpoMzU1MHV3SDRGWnA0UW1X?=
 =?utf-8?B?dGtsdjllSWdYZmNzM2czUEtrdGRZYWw3UFBEbXJ1a3ZXeEZlT2xNdDhmSVZa?=
 =?utf-8?B?TGFRbktMTnZVQ05MSXRjSWh4ZWJuNjltWEtQOFVPVWQ1NkhqbnhsLzA2dHho?=
 =?utf-8?B?dkdRNVhYNnp4VmNvaHA4SzZWUkh5SnMxNVNOMGFwNlNGUkNKdnl1MkU0SXB2?=
 =?utf-8?B?V3h3aFNSdzVqWEdzeWlaTmQ5a1E4VnlhcTRzVGJPOWoxK1EyY0VUUHJjY2Ju?=
 =?utf-8?B?MXZQUVN1YkxlSE80Y0VYUlEzV0JvZFdhejZNVitnRW1BQzAxK2poVkNYdTEz?=
 =?utf-8?B?OFZOMWFFeVk3alZYRkRDZHVDMXFYbTZlUDRNSFJmNWh0ZlVsTVUxakVNT1F4?=
 =?utf-8?B?cVhRdEVtaXJVaHRKaWY1TVg1NFFBa1o3VWd2MW4xMHBXYzV4VGx2YlZjR0lG?=
 =?utf-8?B?OFEyR0tKR3N5SDhzM1h4dEVZaHovcGsxY1BKdG5ER01kdncrMjNZS0RCVUFN?=
 =?utf-8?B?VVZKMmVFL1BjVHhXUnFia2VJL3BuaHFKbHhyOUgrTzNreWlqNCtpVHpJcSth?=
 =?utf-8?B?MXhsUHpvdFo4dXhuNzNPZE5QYlVpaXUrblh3M1dQcjJ6QndvcURDc2VYRm82?=
 =?utf-8?B?U0ZNNUNCM05OVmRQQlRQelVDeXZ4T3ZpdU1ML2NJbmEvUDZDMlI1REV4UWxr?=
 =?utf-8?B?NEtMTmo4TFM5bnNpZGp0SGttOW1lSVE2S29rck40akQ4NWoxMWtXZ0lvdXdp?=
 =?utf-8?B?WGZEazNIVWcwUnQvUFVWaHhLL2VKcG1iN2UxSmxqbHZrN3JoSmRPemFaUXc5?=
 =?utf-8?B?MHI0MDlMQm1DTEovWkFIVnJFWC9jZU1HNGorR2xOL2RMMnJIUjY3c0VxWWQw?=
 =?utf-8?B?RFFiL2V6dC85UW5IVGc4eTk1TVRXTTBlYVpFMmRtQysvQlp6aFBHQU1Ld200?=
 =?utf-8?B?UjFBd2dLTFlDV3Rrdkl5UXREMXYvL0VtTzdQYlZYOHkwc1JoNkgzMjdEbVpv?=
 =?utf-8?B?cUdjeTJiT2NnZkNCRDFUM1NXNGd6dVF6SGFYTWw5Qi9ocllYa1ZKUGovNS9J?=
 =?utf-8?B?SWZjdGhoVjFKbU1COHBZcTB3R25tR1hucWpFMy91UHBZWGJCanZMT3d6UjJ1?=
 =?utf-8?B?MlFXWEw0VHRCTmhEVU1oOWpoWjh2RVYwR2NnVHNwRERPM2VYQ2J6djJERGov?=
 =?utf-8?B?UlB6NVVvY2p4bGFkcWlFZVNNMlluQmFCOE5CWWcrOHZ2TmlUNmVaNHRZaW0v?=
 =?utf-8?B?NTY0bnFnSDErVE5ocHl0ZW1tRmZKaVZBZWNjcHdQZWpSdWk2MGVPb3BNYmJ3?=
 =?utf-8?B?bTZQU3FVWTJjcW1XRUp4b2FORHp0UTIrdnZLTTZXTXJMNEYxTVp5akFKcUd2?=
 =?utf-8?B?V1pZaElpQnpaL3cxb29jTVYzcU5pT3ROWWFVaFNqMVlhWWtCZlVMbFowMm9H?=
 =?utf-8?B?ZlZBTkRJbUhRZHhUMVZIUXg0RDErRXVjeEpLK3VQZ0dRNVp5d0lJSGN2eHJU?=
 =?utf-8?Q?G/d0=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9990364d-0039-4dc9-547d-08dda9b9a6cd
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:01:39.1767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJc+3uA31wOJV8hr6RLKKwJ7fTmeZ0vL/WsEoLuz3LbeqCshuKoTZhqJADzDw8a6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF8BB5EE012
Received-SPF: pass client-ip=2a01:111:f403:c20c::4;
 envelope-from=tan@siewert.io;
 helo=FR4P281CU032.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 12.06.25 08:58, Cédric Le Goater wrote:
> LGTM,
> 
> Jamin, Steven, Troy ?
> 

On 12.06.25 01:43, Tan Siewert wrote:
>> -    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
>> +    if ((reg != AST2600_PROT_KEY && reg != AST2600_PROT_KEY2) && ! 
>> unlocked) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", 
>> __func__);
>>       }

I just noticed that this never return when the SCU is locked, meaning 
you can still write to the SCU registers even though it is locked. I'll 
send a v2 in a few minutes that addresses this issue too.

The AST2500 SCU handles this correctly here.

Sorry for that!

Cheers,
Tan

>> @@ -738,7 +740,18 @@ static void aspeed_ast2600_scu_write(void 
>> *opaque, hwaddr offset,
>>       switch (reg) {
>>       case AST2600_PROT_KEY:
>> -        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
>> +    case AST2600_PROT_KEY2:
>> +        /*
>> +         * Writing a value other than the protection key will lock
>> +         * both protection registers, but unlocking must be done
>> +         * to each protection register individually.
>> +         */
>> +        if (data != ASPEED_SCU_PROT_KEY) {
>> +            s->regs[AST2600_PROT_KEY] = 0;
>> +            s->regs[AST2600_PROT_KEY2] = 0;
>> +        } else {
>> +            s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
>> +        }
>>           return;
>>       case AST2600_HW_STRAP1:
>>       case AST2600_HW_STRAP2:
> 


