Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF69ECAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwj2J-0002NL-Qb; Thu, 11 Sep 2025 11:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uwj2H-0002Mq-9d
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:16:33 -0400
Received: from
 mail-switzerlandnorthazon11020103.outbound.protection.outlook.com
 ([52.101.186.103] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uwj2C-0008AR-SU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdPbVeXFGnOHoN/qYgiENIlY0Zr1tktHi2S7CVX9Iv5PTNY7uDpJOA8xOqgkBq1iPo5vLYxEdFegXDc3NLQXLyDT4NT0JanHT54icZ3c9Uumu8r2niEQrg0j/9HW3s71egaduBNiOncLVFCHfp8xfGVf0yVlJoJ0TgkC08VAiE0ACx3CcYLJLPYXUQMbKF3tPi1NesdGuXXRpfX4d4OFNvPeWJFlwGKO/LDgI/g2ITSygypqD+FD/jKKefBmB74zHVof+pekNkhCF092xh7ptEqoknMdtajPwtZh1w74PqvTOlgmJt+xuayw61h/zCj7w4GC+6ypbHnFOul7Hsdt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GMfNHqOS3xJrxhZh20M8B5AXBwzMhGTvkdUGcjxq4o=;
 b=QNg//aityVZttRU/sXQyO2zMWXkb/x39YmgH8RLKhJ7JiD94cTGGWVb3A1iC2vUomguHhseQBNoEGsRXaK3TZY5lEA+U+A8QV67mNsKUDlJP8/kP7oLRerq72GVM7hY+g5nUc5tM1g+EVZbOs0Y0KmzpWWr00pJvClhKFiQsQp30KVDIS4VOTbezUPffcsLl5zN0RHLDvCi7mJ2SXV4b6ptDck1Vy2LZ6sD3gaRLQ0tK96jqTJmb8+ZMSMlGO9ct8JlHQfpCBzjGWYQYniOVOIZ4O6VeCTKzVsmpZg0obLm6zRbO1Exoj2QsujSmH5pRpYblF2ErxGohg54i+ih3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GMfNHqOS3xJrxhZh20M8B5AXBwzMhGTvkdUGcjxq4o=;
 b=ZhYYt6usVrhIsF9ZLp1JByhXL0//3Tqge3CrGzpf3lN8YuwY5NXqWwJlYwTsKfO6Jdr0k2DWFnW1cIjkIwn+Y5OnfWkZGX79BCXxJnOM5DieLtmb2jk64YRi1jpttABQGQR7AKDKepXeD1ZI7Xhv/iDmoQkB+f9ARcyS3mkoEO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1P278MB1643.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:11:22 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:11:22 +0000
Message-ID: <f56b02b1-3b50-424a-8b20-c5e5e3e0212a@epfl.ch>
Date: Thu, 11 Sep 2025 17:11:21 +0200
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH] plugins: Add PC diversion API function
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@linaro.org, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::21) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1P278MB1643:EE_
X-MS-Office365-Filtering-Correlation-Id: 097df01c-5253-4c2e-18b1-08ddf14577f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2ZkSlp4SjVSRDNabEVtU2pHbkhISFJLT29YSkRrbTNNNWY0QlU0R0h2bHdP?=
 =?utf-8?B?YytWY2tCSjhzdzRHNW9vbmFQWnhScDI1c1NxcG9wM056Q3pHTjRvaFN4eHRZ?=
 =?utf-8?B?bjVVaXB0YlBwUVl3eE1ZTjNsempaTUdTOExnNUhhMHZITlZHSEw5c0plY3Vn?=
 =?utf-8?B?THZQN1lzVHU5QTFnMURGWHkxZHFhS1Z1VzFrYWpKS2tteTJoYkhGWjI0NGcy?=
 =?utf-8?B?ZDRqUUtTUkt6OVNQTEJLNjRGdk9pYUpFQ1RFc2FZcmxiU01zdldVWUx1dVFq?=
 =?utf-8?B?NVRLL291cXg1RFlQVmt0NWtoVHBzazBaOTlDZzJDbUpNTmhLSkhGQ1lqc2xh?=
 =?utf-8?B?NXQxZ1kxZHhoalJ1M2wrS3RmTnFwcTlGZGkvaVlUWGZTOUZ6cWtCc2l6STdy?=
 =?utf-8?B?WVNraGJjRTc5dHZMV0dHNG9tTkp6d3R2NWFSNm81SGtSVFFrK3pPK1R5THdB?=
 =?utf-8?B?eWlDZ1Z1S25HM2lRZmtuUmJTYjV4VlZKL0hucVR2ZzJkcXpERHh6b3FYK3Q1?=
 =?utf-8?B?TDVLRHl6MHI1ZGhlL0VDMHA5SWV3QkNSNDAwRWdaaVBVVzY3Z0k1cm92Mm9m?=
 =?utf-8?B?a1prYmp4cW11MGNQMXEyaks3TloxejZjL0tUdEI4THMwS2Fqd3VON3BXZWt3?=
 =?utf-8?B?T0l2Rm8vN1puUVBKTVNYY0R3OGNEMUVwd3BTRGtIdFFpdnRwdUtobnprK1c4?=
 =?utf-8?B?VksrV1NTY29yVkdhN3NTTVpobWpkcGZaSjlJdGRFOSs3dWl1SU9mcE5QY0E3?=
 =?utf-8?B?YmFMNlB5T3VVcThxaGU2SnBsVHJZdkU4WHl5Nnp0aXRUZkoxbndDeVFzajA0?=
 =?utf-8?B?aXJEd1FNdUkwUzlRekdBQU8vTFM0cXFUMm5ZankyVWEzcTBBUzR6Y3F6c0Fp?=
 =?utf-8?B?dFhGUUJJYWdPZ2k2RWVRa0JZYnFOSEVoeGp0WXJtQmpDYU5qQTVoQWhUZi8y?=
 =?utf-8?B?NVkrTVVkZzBNUjJ4RUZGNlA0WHNuWFNObFk3aUQ2UFBMVmV6OGxxWTIvUnNU?=
 =?utf-8?B?dXFWVDYweExlWHhVaTZ5VklMQ3BtK2dBMTF0Z2ROdXpxYjFTOWFDbFdidmRR?=
 =?utf-8?B?am12Qk9scWFGVFEwV3prY1YrV0Z0UEdmRUdCUUdoWUtySzFGQXFXSDZnSW8y?=
 =?utf-8?B?Q0h2dnBPSFBMTEYvQkVmUnNpWTd0N2JOaDdWWWhwckpObUhnUjJKNHZuSTZx?=
 =?utf-8?B?c0tOTWtsVExjd3ViN2FiQ1NxVEliT2ppdHpnYnZMdk5JRGV0VVFBRnppM205?=
 =?utf-8?B?dTJ3SzFCQi9HMVZJRjZNWUR2NUJqVWdHQ3NoOUpibkdobUh4SjN4cEVvbklh?=
 =?utf-8?B?dTRKbVFCU29sZlJ0Q3Vkb0VnSDM0elpMeXFXNzZlUm9ZbEtMUE11eVl4WmZK?=
 =?utf-8?B?SytnLzJRcXVtVytndGRuZWZ2VnE2YVpPT0VRNExzbFhmVVY1VjlidUZnS2s0?=
 =?utf-8?B?VGlRcjlxcXZZc3BMN3RiSTVtZHdFazVJaHBuMGlNNDBMa2VCV09PVTR1WDNi?=
 =?utf-8?B?ZllySDhNYzZrSTVPZWhkdjlZdUtVbHplMTFPOEF0MUxjZzF3WXplVmFDaXRF?=
 =?utf-8?B?Vkx1OGJhQW4rQzA4MkpibWhBbWR5aHVTTDFVZCs3N2lheWpDbHQxYjM5Yk9Y?=
 =?utf-8?B?R0V2d1dIRitDd0l1TVVqd3Jlc3dXdHBaM1dmOEt5bnR3OEducG5YekxoMG81?=
 =?utf-8?B?dmh1NkJvelpINmZITW1xbWhLa3NRUExZT0xOQkFpdldHbTJxN2xzMmVDSk5l?=
 =?utf-8?B?R1N5MW5PT0h1cGIveVZEVzlNZUVDclFvdlp0ODRNTXVuNWxTNFpHQ2kxd29k?=
 =?utf-8?B?V1NaaURsRDF1R2lLRWxvZTQzU0RIZWQxcUg1bk1Vc1B0a3NMWWpPTnd6RTA1?=
 =?utf-8?B?V1VOZWFmVEFCTEljcTlPdnkwdEwwTnpTdFFwSGEybUxzTElHeXVYbFVaSHM5?=
 =?utf-8?Q?54f4wk9qt6Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNDUTRoTlYyaW96aXRGbEJ3ZTFJS0FCQnpUOXJRendNUTNkeDJ3WUs5WVJi?=
 =?utf-8?B?YWZhUWI2WHYyVFBkdmlHM0tVNytHY21aUjM4cFdlQlZRSERDdzN3Y1k0MTBF?=
 =?utf-8?B?QVVmdjFiaEs1VnNUZDVRNGR3ZWFvZUwweExUaFRyWHRuWUtMdFI4ajRXWU9K?=
 =?utf-8?B?ditzVU9qb3ozNFZKZGhwK0JsNmNWNVBUQVNoajZ4MXJJQStCd3JOditHbnNC?=
 =?utf-8?B?MGlCODNCRkgxRWR4STJ6b1R2bjloK2tzQ0VWTzM5amZCYVV3M0tqcUhuSUNm?=
 =?utf-8?B?SHh5THFENDZBWFZJSU4wbnBpVURydEFZbC9tVHE2NHExajFvU2ZDVkVIaDR0?=
 =?utf-8?B?MExsYmcvN1ZVNTVlSVR2dHNidERVZkw1elh0dHFJTnFFRXQ4ZElkc2NNbE9J?=
 =?utf-8?B?cUFsdjVWdGxMcFhaRzNpUUc0eFJpTDBaWDJlNHlha01TMFlUYjk3NmdQMjll?=
 =?utf-8?B?WW1YVjdNVkxPWW9sTUkveWpHMGhCeUx6dWlrUmRqa1R3SFZmM1k4SnB5RnJH?=
 =?utf-8?B?MkZ0SFNoQndPbmZlMmpjZXVOMTN4YVNTK0VoczBlaGg1bDVUVENId2ZWRklv?=
 =?utf-8?B?UmZnWk9tZjIwNFNLQmFqZG5lQmdMS3lZMTFLNTVqWXVqanpEUWk5aGdqUlYy?=
 =?utf-8?B?UVcrWmYwRFJ6Um4yMWxKU2dmSEhaakVycDNzNEMzdXFCbnc5QU1UT0l4cFRw?=
 =?utf-8?B?cERmc1NhRUk4bEJGMFA1bEtQMlFqUDNnWTlVYzJZZDBoeHgveHhFUWdHc0pV?=
 =?utf-8?B?TVlXRHhmZk54VDFrOVRRZUZIdU5IN1c1ZkZIWVZHUDFXU3B4N0kzMFlLKzlZ?=
 =?utf-8?B?eU9TTk1Sa3lGcE1HQmdtdmJIMWY3K2VXWE1ncnVnVStMdTFGMGQwSlE4a3lY?=
 =?utf-8?B?TTVUaGdCQ2ovbHJVeElKVWxGM2FCdElaVHBRb2hkUFVIVTNGeC8vTW1UY1Za?=
 =?utf-8?B?cC9xSER0MTNranBOWmNrVXF2WHlPSDl0TXgrdTBPbGtza21rSHRnUGprQ3Vs?=
 =?utf-8?B?Y1dicEpqWHd5TGdLSUI1cEQwVEFaME5BYzhZelFKbi9FQWxRUzBGVXR0MzEr?=
 =?utf-8?B?aisyRk5vZTlYNGFYVERuNC9JbDJpQTJZNm9VUFhsdloyY0RwcGIzdUF6MXR6?=
 =?utf-8?B?TnQwQ2hZWndHT2VPYTRta1JHU2VKQlNobHZOeEZQUWFTazRiakZqcHk5bitX?=
 =?utf-8?B?MG9yU1FxOE8yaGVTRWI2Wm43SWcwU0xTa0NqTVlRaWJLaGNLZU5ocS9NdGVt?=
 =?utf-8?B?R3FwNDBNMUhkek16eUNRQjROUG5XdEFZTnhBZ25vQUpxZ3ZudzZ1TXkwbzd5?=
 =?utf-8?B?c1hjNzdEWk84NlkweEdJMmhMOGNkNms2L3VGKzN6K3c3VHQrWnBUQ2lYeVdr?=
 =?utf-8?B?UDB0MCtyREN5UVlpZ2NGZnlMUDltNVhzSDc4akRBeGhsWFpjZ2ErWjdTRCto?=
 =?utf-8?B?Ti9VcEduSytWL2QyOS9Dcm5PZzNkaTlSVkdnRkw2cExodFBqWDNMZ3FtS1lT?=
 =?utf-8?B?NFluOEFFNGloVVdwRGpMNHNTYmxQN1NBRHROeEMrSnowK21TMllTK05pSC9V?=
 =?utf-8?B?UDUzelhxVGpkUSs5SXZwSjVIU3lRSDgyTUJ6WWJjdjBoNjg0cG5na0todHE0?=
 =?utf-8?B?RTdBYndpMmNlY0poaWo2UGo0eFVGVnQ1NEpCZVBTbFg5WDl0VkVjeFFwTlVE?=
 =?utf-8?B?QzhmNGd3M3ZLMGxBSG9qS3ZwbEtOWjRoNUl4bUZmUE5hSk5MTzZkWlQrM1ln?=
 =?utf-8?B?VVpUVjJRQmZaS1N1cmtDVWVuQ1l6OWRBVVFYbnA4ZnNEVncxRGhLaVdIQ0VN?=
 =?utf-8?B?T09hRUJlUTJ6N0VaK2ZFYXJMdmFuUFB0VnRjQUNPbElRb0tQb0p4MXZ0eFAr?=
 =?utf-8?B?eFUwYkhlUXowMVlWWng2K3NrRUJPZWwxeEY0NzhvaFZRUGJqQUZyV0hoREJB?=
 =?utf-8?B?MXcyeTAzQ2oxa0ZXZkxCRXI0U0lndnZZQSt5T25nMlV3NDBsMjVNNmRBdU01?=
 =?utf-8?B?R1Q1VzFqdXZKYzJGcGR3aWc1WWlybmc3aFZEUVpSbG1GaDNYZDNlVC9iRTJJ?=
 =?utf-8?B?T3djSmJCRVFMeXdlcm5lQ1BTSnJTMXlPVURJZnZ1MHo1ZVVHWDJwdUdGaERW?=
 =?utf-8?B?Tnh2djJxcDJVaVdRakpDZjRBTmhBaUJrU1Y3SWZPTE84Sk1KZEd6aGZQMzhM?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 097df01c-5253-4c2e-18b1-08ddf14577f5
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:11:22.5596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBhkUROcQpkdT+pf4qdtRBZuAwvy4Zf3wYh5MG5ZqCDZ5X8Q/dJmbDhpVfNjRQ/FeHbBoqBTKmT1tzn1/ZoZZJ+BUYup+dZwvshPoUMTVhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1643
Received-SPF: pass client-ip=52.101.186.103;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/qemu/qemu-plugin.h | 12 ++++++++++++
 plugins/api.c              |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c450106af1..fe4e053c52 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -943,6 +943,18 @@ QEMU_PLUGIN_API
 int qemu_plugin_write_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function does not return.
+ */
+QEMU_PLUGIN_API
+G_NORETURN
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..0511b72ebb 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -457,6 +458,14 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
-- 
2.51.0


