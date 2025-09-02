Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC6FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVQe-0002St-Ae; Tue, 02 Sep 2025 14:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVQT-0002Pi-2c; Tue, 02 Sep 2025 14:08:15 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVQQ-0005NU-0R; Tue, 02 Sep 2025 14:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNq33+g/ZobzpocmyfogFluT6qBoHILgs6AqSQRkEs4aekKbgP4RHAdu1D3j8vYNGPlin2hMasLIk4Q77DlfGVP4B2qRST3DtYJPxKm4/6Af0luuLjo7D8s3GM6t3WTB51HpOaGcZCz8Mei8aQ0MtJ3GA/uV7x5LdcI1XMmQMu7xPJdotPXh7LHkj/rW34JLSqUGgabyo8a+9POqRXPXNEue2IHuv0nH2++2Kjxhzd62hzQrk3ghbwy8RebpC6JmBO/PVp8Awnw6TdHL/+k2mscduLlGXeyMXzQkQjQq2dG2w1w18ViI6sbsPiU/T0lmtnZCWn8J3UkvNTfI7jVSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dimQ3wRkrWu3HzO6vlL79bh2YSgrTZ173guEmVPm9Bo=;
 b=qn9wRZm+oBFTCV0t6iRP+kmb4zeACZeSTFh5+fUBE+HU4fJTH3+seXWiX38nAhvmR7FgLQES7nCXW/hPynQtBq4eoHBhren3gHaXspKq5yHMA1md/DGxGYkBp47Ip4OqZOXPIHNNlKCDM8UofSd2R1T2Xpyagu4cc3F7Ip5k9S+cuBmO6HwPby5mnWDNZImHV3Li9226MzoKVHsxkyOt4bqbTrt6dgpdL1mpAOq8WFF63bE5P1rj1xeNmxdl/k4MaB8jEW0X9c2yNBtgHKm9ifkyA2oOwwBU9VZuuAM64J9jWCeqJWv+DpoRyCtdEpv9STcp0a/wRFuWjN75WO0/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dimQ3wRkrWu3HzO6vlL79bh2YSgrTZ173guEmVPm9Bo=;
 b=Dvr7wyuDvtQ1tkD12/J+73p0Lng/ZRlTC1niODRc63wkdUKK/LTjwRl5WWnEpqUorVtqF9IB85FQ3pNKTjvh2AS6bTcAb+52W54BdbnbF1+xKxcKXAhL6JS0ifYBZwrvAe5q+8uG4lBx6XA+oejQB+dHkKMnh0v8OlAR7ep3MAgp9nhf9VXDLmnNHiRW9RKkpoUYwWLXCVjFgVrB302CsUYr6YcnklftA7WxeRaQokLur4/Wsy51KljLjGNwmuKW/cowiGYxefEcMW47q/zyEkzCidEmbcAlLhLYkTlkxShmEsKT+cMkMZmb9DPU7X+mWSm59ROgsnNiyemNjcL7dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 18:08:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 18:08:03 +0000
Message-ID: <092484ec-c5f5-4a75-8cf9-13a4b084f727@siemens.com>
Date: Tue, 2 Sep 2025 20:07:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] hw/sd/sdcard: Fix size check for backing block image, part II
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 143cfde4-186a-45fd-4133-08ddea4ba8fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk55V2JydmVqS1A3Z1FsR2FmOG9vRHJna1lJK1VtNjRkcllYYmhlK2hsRkRW?=
 =?utf-8?B?RHIzR0hPblc3VHg5MUhWN0FOM0FtREFyM1hxOGg1dXA4bmlGSkRDMVN5Vkg1?=
 =?utf-8?B?MVk4R1RtczZWT1lNa0tNNFJINzdUeGdTMXBJbFFseFFuQTdsbTY1aFR4ajA2?=
 =?utf-8?B?UnlpSnZPNEQ3Z1FaMzF4ODI2UjA2NmEvU1RQbkc3Rk5lNHZOVHp2YzRCamNl?=
 =?utf-8?B?MWc2TmJ3c2JrTStxek1RWDlWdm42VkU0aDJSc3d1d0pOdUpiRUxhNW00SytD?=
 =?utf-8?B?eklTTU44cmZ4L0FtRHEvcE4weW42aGsvSk91aFNhUnZtTWtCK214V09hQWRj?=
 =?utf-8?B?VVdPc3B4YUZvcGtjU01xNlM1V3NVL2Rqd1RycEQ4eVhqc09GdzhGajlXdFh1?=
 =?utf-8?B?TGtrdmVHOUtDdFRqQXlBMTVMNXgzZSthdmZiRDA4bU9EbUp2S01rOVlFS3NB?=
 =?utf-8?B?R3VVdERZYjkrYmszOHdZWncra2tCbldxM1hwTkFWYlh1RlMyWnhKK09PWmo2?=
 =?utf-8?B?emVORmlNN2czc0ZxT0lmTmFNdlVRZlNkaHVFVURkOFBGZ05VWXo2K3JJc1ZW?=
 =?utf-8?B?S01ScDlKYVZSY0hUL2tMVTBXTkU4R3J2REM4aUMxOXpXZFVtdHdWM2thUUtv?=
 =?utf-8?B?a09teUM2ZWJKZm93b2o2bi9YS2tUS1cxUTZOV1BPc1BqdlJjMWFsS3QrNWVw?=
 =?utf-8?B?a29XL1lkVEU1T3lreWZSdkM4eXVseFpBa2NPVm9Cb2EwNFh6WFh4dWdXSXdS?=
 =?utf-8?B?VENuVnh4WC85Q0RwZ21OOFpOOWppdzF6aVI2c0phUCtYeFBjVVJUTVlUbmFK?=
 =?utf-8?B?dXhLN0ZIZlV2TVhxRmVvdWxjb1QvRlhRZVh5OWxyQkxpblhTNTd6Umd3WlVX?=
 =?utf-8?B?M1EwOVZRV090WGdBSWVlUE40aG01cWVDcTBUVnNVenhJcEpMMlEzQmM5WGxq?=
 =?utf-8?B?UHhNSVQ4cVo2M3V0MVdYMmh3dlZNSjJ4M0RGV1QzeEZGZ1U3VmNlWEFYWEdk?=
 =?utf-8?B?WUF3TVpIbVJKdXRleGRtcW1SaUcwZCsyZ0RRbVdOdjBDRmF4M2s0VWs1Q09F?=
 =?utf-8?B?QnRSckc0elBrRTZSai9iRE5nZ01HbnZKU0J5ZDBIWlMrbWIycDZDZ3FTZDZU?=
 =?utf-8?B?OTBJQmN5V21Jd2cybHk3QjlXTGlBOXJiTDBiR1FpTHdEa3pIeFhIbGxQUXU5?=
 =?utf-8?B?UXFDeUlLOE9pK0taWlViV0hPSDNDZXJuOFRZTVJwRzM1eExEVEdwcUNaMkpj?=
 =?utf-8?B?SlFxL2lFMlFxL0g3T1NrNVdJSTNPY0krN2Rnd1hqRzIyeDcxM3I3SzYrV09v?=
 =?utf-8?B?YlZvTEE5N2RaMFRhSU5FUFF1T2pqK1J2VUlaUUtiekd2VGJ2VjhOL0R3VDFi?=
 =?utf-8?B?elByeDRMMEk0L0tySkgvMzV0MFVpMXhCYmdUWWhnZmR4QzBsQks0TEpSOHll?=
 =?utf-8?B?OEgrZThOYVBIdFRkYUtITmlnTlh3WFl1VzFwYzlxWWxNSVlDUTcreU43NFFl?=
 =?utf-8?B?aXQ2WnVKVDN1a04rSklydnVBZGlJekxkRWVHVVN0dHJrVkpJLys0RkY3NktK?=
 =?utf-8?B?MjllR1FjZlZhanlwNWtnemlFd2xneTFrekVpMnhma01hZk9SWmFESUw4Y3Jn?=
 =?utf-8?B?NldsN0xycEdMTWNUYXJjMEFqSlZtemdmdmF4d2EvZ25kQUVwd0cwZ0FsRW9r?=
 =?utf-8?B?bk8ybTF5UFZtM0hnSmpQc3lzSmV0T2VkT2c4aGFHVlpub282MTRIYXJjRVFm?=
 =?utf-8?B?QjFqYytRVWU1MHl4WTZBV3piUU04ditBdFhWODBwSjRUaVJaald4Y0RSS3Rr?=
 =?utf-8?B?RmVlb3YwazVtQmh5Uy9YK1Y5d2pnK1NLMi9CbjNtRlJGc21oRVhzVUxBeEd5?=
 =?utf-8?B?WnRCeW9pQ2RwbCtYVFhaRmJNMGcxdC9oQ2hkd1l4SmxsTjI5THFWKytqVTNZ?=
 =?utf-8?Q?y0O0g8w+Pbw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lOR0d2akpNdlg0WXp1cFlTdlM3MTUvaDB3NGtpajY0djAweWNveGxrZWY5?=
 =?utf-8?B?TWFHQXhLZ0pmOEQ3NkJaV1NDT04vbXF2Y1FIY2t5ajNsejR2TkRNVVR4ZVNW?=
 =?utf-8?B?bUJSWTlUemhaalptQ2EzUlFpVjFtVHhxUXVqMzFZTjRHcGNXWUl5NHlxRHhX?=
 =?utf-8?B?eEI2Y05mWkVGbm9oTXdrRW0zUWFGODR5RVBqK3VjVEhTSUQwcG1vVVQ0OEEz?=
 =?utf-8?B?YW5rTFB1STI2SVVBN0J4MUdlaHBzVy9GM2YyWmk2VWNWOURiRkJqUTFyc1Ev?=
 =?utf-8?B?ZGxzam1OaWNJN0Q4Tzc2eTRhWkdXTSs2STdmZUxOeXZlRnlsOEo5YWdmZXFv?=
 =?utf-8?B?QmVzemdVcHByWjIrMENKZUEzdUUyWE03Z0ZkN0JvTStCN3JRS0d2Z3grZFVC?=
 =?utf-8?B?V3cyU08zVjI3ZGZEb3hDVnRjU0ZmZXIyTytwWitnRDIxeGFIMUJHZ0pFMnpK?=
 =?utf-8?B?WUxncCtORmZzOXRjajJweC9GWXA5ZDBubUdCMzVDWVgxMlE3SDMxeUxXOGlH?=
 =?utf-8?B?Z1lmSEFjTXpQUmo0RU1lYUlSUTMrNmF4UGRJQkY1RXdoMklpaG5lMWhOaThx?=
 =?utf-8?B?SlBSV2g1SHk4SFBJeDM0OG5UYW9GUERLMktOK2xvc3czWXg2UVBRUmRWYVl2?=
 =?utf-8?B?UzBqM1ZkSWhDSVB6R3V2aGo5VVdaNXlNbEFmRTNlMHJPWnBFNEpWdjhqWmx1?=
 =?utf-8?B?OXdHbnJ2N3YvMVVrdkFWU3QwRGRldXhjMjUySGl1TG1jVFVzRURzdGFDYTdK?=
 =?utf-8?B?OTUvam55RHFCTy85L1lvK2k0MDQ2SUx3WktzUFg4TmdhL25GakFQc1ZId1dw?=
 =?utf-8?B?aXVWdW1tcGlzdjRUbThoUFdNNmpqRW5QSllQdktKazMveE1TVjNSN2pWOWNh?=
 =?utf-8?B?U2tBajl3Z0tJR2RKT3Jra3VQV2o0ckd5Q3dvVHk2ZWtoZEY1cUR4Qkp4elZG?=
 =?utf-8?B?aDN4RnlGZ2JGbE4xY2NTbmtFc0R0MUxULzNlVDZ0Z3dNTmgxL2VtR2xhdTZk?=
 =?utf-8?B?ZDl6Z2E4bWwvTndXOVhDbkN2RllMUGdVR1lkRzdkYzl1NFdCS0IvV1NGWU80?=
 =?utf-8?B?b3Zqa1FhT0sxUnZacmg2VDBPL04reXFNTXJGSDNPbUNUNTFud1J5aVVHYU1l?=
 =?utf-8?B?TC9ta1FDMmUvVVhWakswUXluU1hmYWJLaVVjY1cxMGt6dk1VWHhtNHNCbUxr?=
 =?utf-8?B?SmZMNjllWU0wR2NFQkk5ZE1mN0ZDMXhUd3o1T0JydGJaSHpJTTdKYk9XTmpI?=
 =?utf-8?B?bEIrT004dExDV244RkNvQzRYN1FLTzdEdGxtNHpKaDNDOExrVnBwOTB2TjZQ?=
 =?utf-8?B?UGdVKzRMcGVjN2R0bU1kQmZKZklwWktWanRNYW1wSmhtVmhtdDJ6S2tRSFYv?=
 =?utf-8?B?cEFkQk0rTXBRaVJKUUtyNHZuS3g1QXpZUWFOZzY1UmdJU3pWbWorNGt5YXVD?=
 =?utf-8?B?eTRtZUgxTUswb085NEFnWGt0MEpxVERJQ1NNV04wOERzV3Z6d3lKK1JJcWN2?=
 =?utf-8?B?NlA2V2duTTEyQ0E5UnZSd1dFVEpwTGdmYUIyNXlSUEZKaUlMMjAxc0lzUXhk?=
 =?utf-8?B?SFhZYnVQUjlGenpEQWdtNnQrd2g2YnNiRG9ENDE4VXUyNEcvMEhQSXE2bW93?=
 =?utf-8?B?bnpnN1NTOHgvc0t6ZHF6dEpiVVFvcWdGMG5pVkNuaGY4VVo1ZWZrK1ZSUy9r?=
 =?utf-8?B?a0ZENFJkWVI0RnRmaXh1SGFMMmNGb1pCRDJlZy9CYXU4UjNTNlYyWmN3aUlX?=
 =?utf-8?B?bGZ4R2EraUQrRXFjRnJMYlJxcEtyaGV1RmVqZ0pEa0YvampNdDErY0RxWUxn?=
 =?utf-8?B?MkQ4VkNIYUZXMERDWWFBNksvdXg2aiswOGhyUWFIczZlRDluVm16OUJDbTE2?=
 =?utf-8?B?MFpQM1FUbHBqSDhYZzZhMmE5bURId2VZMU81QUtlMngrT1lCa1QyeHBjblYx?=
 =?utf-8?B?YzQzMXpnWndMOGFLNk85Z1UrV3ZNVUdVY1FOZUlFVUpqNmtJV1RHYk5BTXky?=
 =?utf-8?B?RFgrMEFPbklYYTNOQXdWcEZvOGxiUk91Smo2eGhOM0YxR0dwUFRQNmxMYUVD?=
 =?utf-8?B?TW1LMmNraC9EdUwwdW42d1VtUkxVVXhjd2NjK1cxSzg0QlB0QnZMdFpqeFh2?=
 =?utf-8?B?ZmJuVmdmSGRmNzl3TWRmKzZpVFB0WTRUZ0gySE0rV09TT3dGSFI4ZnJDOFZh?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143cfde4-186a-45fd-4133-08ddea4ba8fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 18:08:03.7068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KcLSt7C7M2wY1u9rA6lU4RWAgHHyYxZAQ55OJbQFEvvxlzFd3f9/WBqtJg4ggCP0t/VNOAtWfU6pppq9Y5QzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6748
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

There was another mistake in the size check which 8c81d38ea5ae now
revealed: alignment rules depend on the size of the image. Up to and
include 2GB, the power-of-2 rule applies. For larger images, multiples
of 512 sectors must be used. Fix the check accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Not fully tested yet, but as staging is broken right now, I wanted to provide this already for early feedback.

 hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2d34781fe4..0f33784bd0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2759,6 +2759,26 @@ static void sd_instance_finalize(Object *obj)
     timer_free(sd->ocr_power_timer);
 }
 +static void blk_size_error(int64_t blk_size, int64_t blk_size_aligned,
+                           const char *rule, Error **errp)
+{
+    char *blk_size_str;
+
+    blk_size_str = size_to_str(blk_size);
+    error_setg(errp, "Invalid SD card size: %s", blk_size_str);
+    g_free(blk_size_str);
+
+    blk_size_str = size_to_str(blk_size_aligned);
+    error_append_hint(errp,
+                      "SD card size has to be %s, e.g. %s.\n"
+                      "You can resize disk images with"
+                      " 'qemu-img resize <imagefile> <new-size>'\n"
+                      "(note that this will lose data if you make the"
+                      " image smaller than it currently is).\n",
+                      rule, blk_size_str);
+    g_free(blk_size_str);
+}
+
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
@@ -2782,24 +2802,16 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
          blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
-        if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            int64_t blk_size_aligned = pow2ceil(blk_size);
-            char *blk_size_str;
-
-            blk_size_str = size_to_str(blk_size);
-            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
-            g_free(blk_size_str);
-
-            blk_size_str = size_to_str(blk_size_aligned);
-            error_append_hint(errp,
-                              "SD card size has to be a power of 2, e.g. %s.\n"
-                              "You can resize disk images with"
-                              " 'qemu-img resize <imagefile> <new-size>'\n"
-                              "(note that this will lose data if you make the"
-                              " image smaller than it currently is).\n",
-                              blk_size_str);
-            g_free(blk_size_str);
-
+        if (blk_size > 0 && blk_size <= SDSC_MAX_CAPACITY &&
+            !is_power_of_2(blk_size)) {
+            blk_size_error(blk_size, pow2ceil(blk_size), "a power of 2", errp);
+            return;
+        } else if (blk_size > SDSC_MAX_CAPACITY &&
+            blk_size % (1 << HWBLOCK_SHIFT) != 0) {
+            int64_t blk_size_aligned =
+                ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+            blk_size_error(blk_size, blk_size_aligned, "multiples of 512",
+                           errp);
             return;
         }
 -- 2.43.0

