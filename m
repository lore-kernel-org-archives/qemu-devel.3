Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CCACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKSK-0005Tw-B2; Tue, 04 Nov 2025 12:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKRs-0005Ef-34; Tue, 04 Nov 2025 12:04:19 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKRq-0002i8-5E; Tue, 04 Nov 2025 12:03:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+IwPaRzmrwiWYPQpxyx3u27+lR7UJCGEAGQMg3coRyBn1SziwRyD6NadGx7gRHY1RJlbqy9tLWDVETFVfJRDks59uQcnmdimdoM0dB7tgrkCdYlCAxfHkQX570l7FvVmhbPVpJ22h/OQT3QccDJISiG6APT93QgqqgSGQGX0qaX0a2d4g5ESipD5EGRTNrSAOEgQqgJBr/xUVM2ZaPxFfE9f5oaOv5ovc2r4OiXpBM5BiM6C19g1nrX5XNejiJCIlhOv8JDS8iJHdiscPtBd7vogztIl1JGHaEpLO99k3W99uT8jpHZHzMnaf5pqMH1/MbIvShECe21ZYuezKbEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNCAt5h90Wz3ZGnGCS81Cs7dHAyqxAte9m3L+Hx5rxI=;
 b=QnqADfNvkAYUiBYwcG1z+sf8d723LlNcZb98lXzdC1OcqG/JcGNcN4NytvxXqfyfRViwSr7zs/xoJfG6/ryFG9o74rPomUd8uN7QCOsCxdbYiZZMN6DDgidCCv1B7CXuUs+JO9CvyyoJMJsgeG3UN6zPzEzCsh7vcZ62yjFlpPG5HerszFtObhlcpIKE4aszpqwSIosFr2gzszYTcfRPn+iMAfTX2/xl23xcUz1VvOPBknrabX54rnaKAhxUADZ1XPDlxlTBl2Dps+rpTpdw+/pbfceKRHDnowyM659HRImJGkjnOdGY52oAYZ2oKIiz5aaca4JFfD8qkrc+f+4z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNCAt5h90Wz3ZGnGCS81Cs7dHAyqxAte9m3L+Hx5rxI=;
 b=eRdVk8tNN/tt5vnzx0FkAL70BS7d6J7TwSjL/mKMKMLp0BVMKbxRpog18aqU05Q/vDyeHUTW67QmIjA3+CaDh1Qw1v+gjuupGL35hxsP3AW9oPxfkTMC4CZLKFc45N+XT3NX22EKxUKk3hINvxzEfdB85oKHLUsw9SdaBlCs1bq2VTaijxIoEebGp+VtkJ6iijwD+GIgsZob/A93rO/pejAnA5mL77HEQvNYCeIFT4LLiAoSay6eGJSYlShvBNH3P8iVn1vMdrgEoCd5bVhZZlIleHTnEitXxQLl7m6VRTtMHsGTcptJOmIsfu5W1BxziqVQ64L3uS8o4NhImhQruQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:308::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:03:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:03:53 +0000
Message-ID: <ef255ab4-fd8d-4f8a-9944-ae5c348bbce1@siemens.com>
Date: Tue, 4 Nov 2025 18:03:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] docs: Add eMMC device model description
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <b9c3ff21e7170fef5d0e7d08698a113d2a64e649.1762261430.git.jan.kiszka@siemens.com>
 <b9121cd6-75b3-4c5f-ae13-ba995de34872@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b9121cd6-75b3-4c5f-ae13-ba995de34872@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 0040661b-9c7b-4809-90bd-08de1bc42236
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTV2LzFzd0V5OGVRSTlmWi9mTmJqeXlmT2NRY2d1amhqMDJiYWpxSlcwcjFP?=
 =?utf-8?B?bWFJTFpnQUQrdTRVOHlxZU8zSlpvamh3d2w5UythbUZhSW1FWUtXa281NFd0?=
 =?utf-8?B?M0tuWWZEM0c1c254K2twUVN0eXA1NnF3bUVRc0tWR1lteHdUeS93L0kwa3FR?=
 =?utf-8?B?SnZZd2hsQitiQ3ExWkpKV2FKUldydU5ZS0lxOThRUU5GUG4zcGVueFlBWUtq?=
 =?utf-8?B?L3lGZXlNcjdEajNQYmlHVU5LZGt2Zzh0N0VRSklMb2tGYVJ3ZjBSRFZaNlYz?=
 =?utf-8?B?R0dvQVBHdDE2QkR3K01lYmJ2cFBhdmtHaVppVFZiSnZiZVlQQnd2QTd5em8y?=
 =?utf-8?B?RjMzUm9QR3ZtZ3JrZjc3ODlBdmlaaEpKRzNMQUtPMjN5cnJOVVdtWmU4azlE?=
 =?utf-8?B?UUxuZVNrTVVnaktCTThDT04wdzVFdWZPNk9OY1dxZDZISjV3clJDUEtOY0VF?=
 =?utf-8?B?NUZLM2c3bmpmUERMcHF2NDV2MS9lOTRqaWZFbW9SRlRweEhjRXR6V2xCK1hY?=
 =?utf-8?B?VDVJSWU5bzBxa0l0MmN6eE9CWFRPWENFZkpWSTBKckhPdWtLcUQxbTA0cExN?=
 =?utf-8?B?eHpsR3cwcm54U0VvazJMa3VFZ3dIenNwbnpDUVljM0N0SHEyV1pCRDAzQlpr?=
 =?utf-8?B?aHJLeFRHQjhldml2WW5HTWtqZWlsTEtERUFvUnBDSVRhQUhTY0k5eE43L0V3?=
 =?utf-8?B?b3pyTjhCc2FaUzFmZXFxOTJlWGh5MVJFZklFbm1jdVhiOVJnMyt1blJRMjRL?=
 =?utf-8?B?RXNhSVhOYXMySjU1d08vaTJqSm9qa0FSdkV2WmlGNDJaa2VacU9FbHpvNzRZ?=
 =?utf-8?B?Y2U2TWdLWEhySkF6aXc5TzIrWjNtS0V3MkNVNkM1NStkT1RIY3Y5NnF5aW02?=
 =?utf-8?B?QlpJVmRqWlAxWmw5dm1OemZUZWMxczRHb0p4Z0tyUGx2T2VMK2IvYy93OHpX?=
 =?utf-8?B?YmFTclM2blhSZjM0N0pVdVlydVZaWnNlaWJlV2Q0aDIwMUJEZnFISnJNWFZu?=
 =?utf-8?B?bVk5UTdsWU9TOUZkR2RtMnUweGpvb3hCb0t5TUl5VDh3RVRuN2Q5RC9hVmtJ?=
 =?utf-8?B?TFhUcXVNWGJlL3pxZzZPbGlBMHkxYjREWVhmQ3FJY2pycFN6QUhTQTFJZktS?=
 =?utf-8?B?UkhWaTVSbHBaV3Y5TG12T2phNW9MdHJTamxUUWs3Z3Q4d2J4QmNLanlFbUcx?=
 =?utf-8?B?MDEwR0JHYlgwRTRBSFNja0k0cGZrSzMvTnluOE9oSTFNeVhyQ2lUUU9LVEs4?=
 =?utf-8?B?NHhFMFN2M0FtZUxJM2dLTmJmTGRIamlRRkt2eWJZUjhsSm5UZjArVG9lMVVh?=
 =?utf-8?B?S1JnRWVIdDMwM2E4RFl5TGMvWWpWRDB5SFNWUXo4K0g1NHpPdExoZjV5MzlQ?=
 =?utf-8?B?aTh2VktzNWpxR2RQUlI2Tkt3ZFY4QUkzWTM5emJHaGx6bjcreWZET1dUTXUy?=
 =?utf-8?B?cnVWTEVFa0Zic0VHS0I4cnJtREkwaUV1cXNaVG1mbmdQRlZqTmlKZnJ3UUNm?=
 =?utf-8?B?RXNkOUNzajhqWG5KWTN3ZWN6ME5LUnY5Z0EwVy9ob2hIVTdvVmJjWGgxK0Jr?=
 =?utf-8?B?SElQclFJSTVDY2NIaHVhU2ZyR0t4dm96aTZNeWlxcDFZakZUNnlzRzF1NFFr?=
 =?utf-8?B?N3poUUFPQlpOSWxRRFlqWmQ5eTJVOW10c1RUNm10b0JRc1FQUGM1RVFDQ2ox?=
 =?utf-8?B?b2xNOHVIY2ZYUHpIOXdzMG1SYUxjTlM3aHlsTWRPZE5OZFU4QktaWjJOZFJq?=
 =?utf-8?B?T0QxWkN6WnJNYnRHTmlGR2NWYnY3dlJPbFM5OTVqRkIxWTNib1poRnYwSGhZ?=
 =?utf-8?B?Z1V0TE10SGkzcHRxRVJiMStvOUtpRE9uUHhzQVZGbUllTXQ3ZzQ3dUVXRCtQ?=
 =?utf-8?B?ejZKVTJnQ2tjVE1WeG5WZXkzNDNYOG05YzgwamFzcURHblZNOTdPOElOV3FG?=
 =?utf-8?Q?w7r6ckC5MEbi4y6FVFS8fXRWoVME7MxN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Z1UnZhMnIzd1oxbUlNQzhWQk5tWjhrMHFsb3YvdGw5dWhrbXlkaEhKLzdi?=
 =?utf-8?B?aFNRVnlkU2dUVzk2T0pucTQwa1YvOVpxckdlSUpqRHV5Tlk3K1Y3YnJHL2JD?=
 =?utf-8?B?VmVvOUkxbWt0VWg4cHdzcG03VytoSG5INENsVjBhVkNjb0UvSDFTNVlnanNC?=
 =?utf-8?B?dEZNU1JxV3Qzb0Z2OTlMUGZCaU5VUnUwMlVpTFpZVFFnV3BOS3cyRXduQTRP?=
 =?utf-8?B?Tk1PaFByVnNreERRb0tINlIvVW1mNUxxNTF0T2trbXQ0UFRzam13bGwxbjBh?=
 =?utf-8?B?U2ExV2N6UnhaN2tEeW55VUNLTWVpZWdBaHFGZlkzYWt4T0lEdG9CZ0MrQ2Ez?=
 =?utf-8?B?MUVyRnNaZHFBeHBUU0hhdXBxcUVRL0dwT2t5YmllYWFDYmxQTmFYTkoycTFN?=
 =?utf-8?B?Nm9kdFBaczZkdVhYMUwyT21XdlF6Q1NCUzR2M0FNRThtbFdIekFCb2o1UXY4?=
 =?utf-8?B?bWNJYlFXR3Z2a3Mxc2M4d0d1eW5tdEZBQzdQRWNTc2NuYkpFazZoWGNGTkNW?=
 =?utf-8?B?eVBWRHd6U0VVY1R4enR5dDRYYXltSDUwcjZsWEUwTkRyNDRtT3NIbW1tdEQr?=
 =?utf-8?B?TisxbjdaOCtESFJyUVBtWWNHSmZzU2QvSXF6aVI1RUI2MnZSNDUwMExlMGww?=
 =?utf-8?B?TC9aSGdPZ0VLU3dzREhqVFVZeisxTHlsWG5IUXRKZ2xEN0d1bHViMnFPdjJt?=
 =?utf-8?B?Mk1pbkdCT2tDbEc3STFVaE9Wem5VNHBpdWNscnFkSFZKVTRNVFQzT1VSN2FM?=
 =?utf-8?B?T2lFbFFUeGQxWHlwdjRMdy9BME9MU1p3SUY1b1dsam8wTHppSFlwRWRFWG92?=
 =?utf-8?B?K0FQUmZxY1hZcjdLMVo1MzBMeHRzZ21uVTQ5alZOb2JaRUVHMi95SnJTYUI5?=
 =?utf-8?B?bU9xd1NDQ3RlOEw5YVZCWTRVMmtMY2pmcDJXakZ2ZXkyQ0Q1RzVXZUR1UjBq?=
 =?utf-8?B?YWo1bElFdEdWNTEyY0dUdkI0YW11K2syUEZMQ3c2M2pwU2czVkhxbnRWSUpL?=
 =?utf-8?B?bVVNUURrNk9UT3NpenJOK01maGMwYjl4clNZdU9BbXMzQThWVHVEMk9oYytK?=
 =?utf-8?B?MCsyNjVqb2FXQ290aTE4SWNweEFZcng1RHFUMER2YWhUdG0wMjJtaGdkWGNv?=
 =?utf-8?B?b0JFQzV5OFFsS1RtMHN6Qm5SZWhYRjZlckNUTkJvcDFyM2VsWWxhaU91TGk1?=
 =?utf-8?B?N05ITklERFlSdWZkQnhaSWFaSUszLzhjMDJ4RnQ4YWg2UENqU3BtZmxmR1My?=
 =?utf-8?B?TlhaZlgwM2FPNXJIRUo5S3VDTHhkUEZNY1B6bXBsV0JzWXZQeWZFZ3laSUZC?=
 =?utf-8?B?WjdwS3p5R1N3T1lFalZnak9hQUNmTUxUVFllYkdmbVQ2anFob1dudGdLRG5a?=
 =?utf-8?B?N0pJQm1FaDI4UkRXNXZWSldmZTA1a1cwK05YaWw4Y3BoN2Qwc2UxbEswL21X?=
 =?utf-8?B?ZnVzenpmWksySU5RSlBiN0NXZ2F4c3BRdWtUdEJpTmxkNkh6WHlzckw1WG10?=
 =?utf-8?B?ek9VRlhFOUFDWldJWm02bE5ad3FVaUhNSEpzVkdRakcwaDNGWkwwSFhoQUNw?=
 =?utf-8?B?ZE1zQXlxN1FkaHRtbEt2TU9uV3Npd0IxRFljd3hIUnRTV3puS2tpbkRKV3Zs?=
 =?utf-8?B?dDRXNjAvSW16a1l6OTZCUlRGak9YOHVmMThZdTFOeGc5bmNFNGMycyt0R3Zp?=
 =?utf-8?B?aXlSbTJUdXJuRzZKa04wVFBaQlY0WGJKTFVOM09qYWhPd3BkSCt3Qk5CejJn?=
 =?utf-8?B?K2NiMWFXZlFYMVNLa2ZkZUhzUzdRK0dkYkg0QWJISE15VG4wN1pHc0JEOC9s?=
 =?utf-8?B?cXBIRUZiMU03eTd1b2RVUEZlcXp1YTEvV3lKWCtCU0FsekVWVkNIUjBaVS8v?=
 =?utf-8?B?akx5OGhDYVphUG9Zc3lHelhJSEFFOWk2aE5zZkxZY1RDUVZ4aGNlNVRpRFhu?=
 =?utf-8?B?ZlBrclVGd0hOaE1QQnk0NStDTjU3cG9qblhtYW4zZzBCMktiVVJNWm1RZVNH?=
 =?utf-8?B?RUhUZXl2STFBeGtSL240RnMyTEd3bWZpa1BpWGNBQmV5eVdBb1ZYTmkwV09Y?=
 =?utf-8?B?RUNlYTFvWkoweDkwZFVyMzBiM3lBbkM1aUhGOU1lZVM2WXlNZTdRK0xJcWNG?=
 =?utf-8?B?RWtoeDU0ZmJmNWZ3Qm9qeGJQN2RBaGh5dWhOMjJET1NKbFcyd3FRZy90OXZ1?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0040661b-9c7b-4809-90bd-08de1bc42236
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:03:53.5834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a4pDhoX6JJguGz4BGzyxNt2QBT+OXc5j4I1a6wSD0vwtIWdlHDQirMtMSx1iuBE5euw4HmAdPdXxhP/JspgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9499
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 04.11.25 17:57, Philippe Mathieu-Daudé wrote:
> On 4/11/25 14:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/system/device-emulation.rst |  1 +
>>   docs/system/devices/emmc.rst     | 53 ++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 docs/system/devices/emmc.rst
>>
>> diff --git a/docs/system/device-emulation.rst b/docs/system/device-
>> emulation.rst
>> index db714ad47a..971325527a 100644
>> --- a/docs/system/device-emulation.rst
>> +++ b/docs/system/device-emulation.rst
>> @@ -88,6 +88,7 @@ Emulated Devices
>>      devices/canokey.rst
>>      devices/ccid.rst
>>      devices/cxl.rst
>> +   devices/emmc.rst
>>      devices/igb.rst
>>      devices/ivshmem-flat.rst
>>      devices/ivshmem.rst
>> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
>> new file mode 100644
>> index 0000000000..7e15b62270
>> --- /dev/null
>> +++ b/docs/system/devices/emmc.rst
>> @@ -0,0 +1,53 @@
> 
> I'll getting:
> 
> WARNING: Does new file 'docs/system/devices/emmc.rst' need 'SPDX-
> License-Identifier'?
> 
> Should I add (on your behalf):
> 
> .. SPDX-License-Identifier: GPL-2.0-or-later
> 
> ?

Yes, that license line is fine here.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

