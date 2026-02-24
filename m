Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D276F3C9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuqF-0000VX-7a; Tue, 24 Feb 2026 11:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqB-0000Uc-Sx
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:52 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuq9-0001WE-3B
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOdYO4Vou6zr6uJWvj7k87D5sN/C3sJulNAQIobUU33REzsXx9+5sMs61/JoCfm0bS86yOFLuQTdS/gDHoPIney6Yr3N20o8f5XiCN26IJ7/vH1/fGyG9+F83uVe6V2BDJg6H/RZ7YuJTP6zXGGDPecXyT5MdjW7tUwKkMZav5PSPpPqj/0A+D83a1BrEGC+8h6/rPV6jb/iC1C44MQGULSFNF7447Pj96BD/MB4JXUZCxLYnxRwS48N42mILljFu2KPwFl4GqgPCKlWvC27BGd3X53ovK4p2SYGZ1e5w0i8mCfUjOlNSblolk52DYM9W3Lhv0Uu+iLknMmCcgFo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDuRKnQDy9smGgk+ZpvD37zFwMgHl0iIo3Yvpps20ig=;
 b=OiX1S56EYXensplanIQFfYmeSuxCeJEU30ak1t49qJFf8/J9eN4tPx1eA8zB2blcC0HcaZfp6V+l5XLDExv5ddHiS+1sKvvhLnVvjbul73H7RkGI2IzzH0O/cTew42WFtJx105M2PrzxBUlrt+wrl/qf4QAeoygVEj0FuMye8QuZVeoGVuWB1vYrOG+vdMWJkC8lFyrJi2nf0oLburOSr0TnKjhpDQdhO7Nk/j6OLKGsVn37c3CupxVfhdY5vqx7N7+9hFa6Zy/9ensARvt4/dLzwN3u01rBx1b/ALSxQBdqkcCN1VFNpszYVKqSViazfuTTuZJOJkV/sVarK3ZjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDuRKnQDy9smGgk+ZpvD37zFwMgHl0iIo3Yvpps20ig=;
 b=HZcpUpkzXl/SZ/UEhkMxfwhTOzTwA9TCLRUgyIlf6rPBpvntEBTBPC2B8hnevJ6wHTCxHL84EY96qYxYnoiOfV6y0fHbH/HMlwnuMMgqi4lUfRq2yb6b0OErtOmWXULjbjLrXy5VpvCXth5wqFs3JwFZx/qqNvTJZx5/nGPe+No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:32 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:32 +0000
Message-ID: <33eb2408-b4c3-4ca4-9555-b2015fa38630@epfl.ch>
Date: Tue, 24 Feb 2026 16:51:36 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/7] plugins: add PC diversion API function
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 432f8b04-021e-46a3-9a28-08de73bdd5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDEyZnZtV01QT0Y4YmdjZVR4N3FvNkNkSGhnQVFNMVJOd0JhaTlNSzBjV045?=
 =?utf-8?B?VlhGc1Z2VG5qdm8wb2ovSDRSY3g3TE5jd1h1Uk1nQ3N0VjgwblpJWnhHU0da?=
 =?utf-8?B?TjlrTkdFZWNvVFdTQU9YSnJkOFFlWWtZbkZ5RVBPWkM4Vms0UnQ5YW54TXQz?=
 =?utf-8?B?VU4vOWUxYzV1WVRiMEkvdmNTakttclF3WFNrWjE2bjdYY0NvTUM5Q1o1WlNy?=
 =?utf-8?B?bmE3bVJwWlE4V0t3amU0b2xjSlNyRGhmSHZrQXdzZFVORU40UjlvT0h5S0NP?=
 =?utf-8?B?U0RJdHJuWGg2NkFSUlFrVWMyM0VQdGVRbHB0Qi90ZVpBTFlBWXl2RW1JV2Z3?=
 =?utf-8?B?M3pVSlVIR2ZSd2NkbGNPTDhmYWlmVmpMcUl2YUVoaVhnZDBLbGhhSmYwK0xW?=
 =?utf-8?B?WDkrMFZyNysxUXpia3FoWXFucDB2bkg3d2ZHVlpPMkJwT284OHlxTDNRWUdr?=
 =?utf-8?B?bFA1c1QzY1lvZXhSWjRIWm01NUtWMU9NYkRlY2JhcXB4Rjh0UGtCbWZjN0x5?=
 =?utf-8?B?Q2tpWGR6UnNVOUs5OW84eVZIR0JJSGNyZm5kdDMxQUFPVy9EYjJwcVlPa1hM?=
 =?utf-8?B?MjMvYjRMb2NnWGp5eFRjNnFmVmVCaXVuSHVaSVkrUC9wSHhQdEJ4OXRCRlNh?=
 =?utf-8?B?SUp0WmpVWUo3MXVQamdhdDVrS1hCbW1WRDZLN2hZaTFmYnU5OTYyeDJRZ0dq?=
 =?utf-8?B?UklVc1VlWTJOdHozQ214bm9HWkhVZDJlRXoxVytqRHpQTDM2NHV3NGVoZzVF?=
 =?utf-8?B?dzg0TXA0TTlKeFJtRlFkbXlnVUlnVHZDOEdQelBWMVpXL2tVUzdSci9ESDh6?=
 =?utf-8?B?dFVpNjBHTEtiYTJ3WUxORWZMWmpEM0t1eVViRm5wc0NXc0Q2bURRRUx1NWwz?=
 =?utf-8?B?Y1k4Y0FZSXFrVjNJVUlrUHpxTTZVQ2Z0ME9GMy80dm5oSi9ia3ZvLzBJT1Vt?=
 =?utf-8?B?ZkZrcWFuZE1CVXN2NDBWamZRck1OdW5GTjJybGh1U0ZtRXpRVHdLMW5lRllh?=
 =?utf-8?B?QlVZN0dCY09UN1lKMlU4SE85NitKSFJncGhjLy9Dbk9OUjVpMVlQQU9MMmdn?=
 =?utf-8?B?VjJTemdURDdUZEZqNGJKcU0xWGZFRUlvODNPZTVLekN1Zkdpd3VLYmk0ejdQ?=
 =?utf-8?B?b0VQM1U0eEx2WWpueUk2cDR0b3k5MG9kZndnOThLVjNLUmlGOXR4QTFqUWlH?=
 =?utf-8?B?R1ZpVk80Q2NEY2gyRW5ydzUxdVpVSWd4OXdaNDIvMVB5RWJwWFVRK0xFQ04z?=
 =?utf-8?B?OXRsc2FvSEN5emZrdWUxK0sxZFJob3FGMFV4QUtraG9TSnV4aWZ5Z2ZKV2Ix?=
 =?utf-8?B?VkFYMWlpU3NKU2tMaGtxNlNWT2dIaFZ2RDJNTDl1MlkyMkdKNU5ZNVZqVUlJ?=
 =?utf-8?B?Q1JiejI0RWNGVDA3aktUajg0eWNOZXN2L0lNVDd3NmpTRWxxVm1HM3ZmbTFL?=
 =?utf-8?B?TDhUcU53S002NFRzSW5zVnNjR3JoMXM0QmdDeElFOFhGRWx6eCtSSlVYU0VN?=
 =?utf-8?B?Q1lieEM3VUNUU1h1V1dXd2sySW9XUVBFV2UvRlZ0NmpEVDkwKzE4WWNreVh6?=
 =?utf-8?B?MzZvc3VkQkROd0w4aHg0YWtqQTEyOWJCNVlPZ3FiVXpMZkRDalRjSzlLR3JJ?=
 =?utf-8?B?WEx6M25FNm52cUVCNzNiU2laellROE5jUlEvZTFZWGZtNHNOUnU0aEZyWm5B?=
 =?utf-8?B?KzlQaDQzOThCUkcrVEVwemZSRzJtTkRzVS9KMFk4b0hXT1h6L1hzZmw0K0FJ?=
 =?utf-8?B?bDRUVTMrOXpadmora2F2M2l3SzNCYWdkeHpvNTY4QTlnK3JTWWlKblVrVllB?=
 =?utf-8?B?MG9RVGlHSFVFQ2ZkY09PTmlwVHJic1dBbXpkbWgwbWh0ZytWWkxSS1hXaEJN?=
 =?utf-8?B?bWRsK1pOWmRUanJHbzAvMkNQcFMvVy9CUzgxMUx1NW9kUjhQY2ROUCsrS0x1?=
 =?utf-8?B?WDRScXByUzFZcmVqWmQxYUlpREhMMitHdzlnczFRZmRwMWkwcCtBM3dwdXZl?=
 =?utf-8?B?VlZzRGtTTXh4cEFNNTJ4UVFvdDNnRmxmMzhmc08zODlSUXNGK3VKMnlMR2dy?=
 =?utf-8?B?ZmRXREY2NjFDaHFzajdFalNzN0I0YldkNDZ5K05KZFhUb0x4eEVkUUF6M2wv?=
 =?utf-8?Q?u8Gw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBHTy9yUUpIa2xYMnQzbHdxVzdRMkxad2lzd0kwK01jNmwwUHJwL3lseVNa?=
 =?utf-8?B?N2JKWXZMazJPSDFNT3duWkFEY2w0RGZUd2JiMDZYWTYxaGpNdVM5NUViM2dX?=
 =?utf-8?B?ZEdhcGV6VnBhdnBJWDVMRUhhbCtUY09qSWpMSFh6OTJPanMrMEgxUXhYbWEz?=
 =?utf-8?B?aytCcDFFcHg5cTg2TklqTCsxbmszK2w5UGFLeFN6cTFiL2VhSkFXakhDaldR?=
 =?utf-8?B?QjFySGJ3N0FYZHFXTjhTZHJlVFJVWTJ1bTY0aWh1TGU5QlpTMEpWY0RtVmVM?=
 =?utf-8?B?UUtseFFTUGlkckNQMnRBVWhrVFo2RXVrTHBML0hEUjNMMEpEcFA5NVpyN05t?=
 =?utf-8?B?dEdBTUlOZ1VNM01SUnBtVTdFMjRyMHY3QmFyVHZ5aXY2QkthY3JXTzFFUzRr?=
 =?utf-8?B?alh0aWdZSnRLSk9KV1JnMmJGblFBVXRudkF3Y3lFUUtmWnAyU21rRkJnUEQ5?=
 =?utf-8?B?Y1pqYlFaRko5bFBQZzZya3BVRUt0L1ZyWEtxLzlOblk2VzFVRys4eEVwMm4v?=
 =?utf-8?B?VDJ5U1NSTWRsSWphbnd3anFTWjQ0OHBEVmMrMThabUU1dmptUE9sOStiMHJV?=
 =?utf-8?B?S0dUQnB3YU5WQW9NZXBoTyszWUZhcVR1WGY0QWJNazhQeFF6dmJRZ2tBUTJw?=
 =?utf-8?B?Yys0ZUY1dVlVNUJid2Y2d3RObmZLSzRvUmRaWDZvaFM2S1YyVHNqVjZNUFhk?=
 =?utf-8?B?cDZLOFJGUWM2STltaklOdzFUVG0vdjlmUjJobkZXY3NHWngzQ24wWHVCQjMz?=
 =?utf-8?B?T3ZmejVSWU5uS2UrNHBUeWlobm5kTzdMbklhWVlYVmdvOHN2YkVJUGtneG10?=
 =?utf-8?B?SHZYbTJ3d0ovNFRBeUs4V3hyQnRzRHNJWmpXNFpXcXg4ZHlPUW5oSUREc2Va?=
 =?utf-8?B?MjI3UFFsUVg2KzZsMnBFV0l4b1JKNTlZWnU2SHg1cys1a1NoemQrQWpKSlFs?=
 =?utf-8?B?czlMR3hmb3RuWkN1Z0pYQ2Ezc2pqd3BPRzZGVUFoQmVoUWU0V3NsZURtOTU3?=
 =?utf-8?B?cHBsODBocEtKV1VpeUEzdTV0MC8rZ1NZSWM4ZHFqSmVwYnFSWWFwSEcvODBp?=
 =?utf-8?B?aDZFd01lVi9oaks3ZldDazNMNFltQVRvRTc4bUtVSFFaL1BWU3FRYitBcXdr?=
 =?utf-8?B?ZTdrSXJqMDJ6OUtLZ2JieTVpSWZvQjRlU1hUV3pnZEJWRFZTeFJoTXJQaENG?=
 =?utf-8?B?Y2s1ejJUK05SRlZqU2dQZWFPUXRZSDFwWko3TDZjU2FXK0Q5WWZ6b1lWWjNO?=
 =?utf-8?B?bUU4RFpZK09pWjN5VFlsU3pSa1FrWktsZmUybjFNZHpNS0d2Z3JHa3ZXZDZD?=
 =?utf-8?B?Y0xmT2tOQzF3TU4xSm5rS1dFQ2VvUGlobHRlZm5tQWl5bHZ6OTY3dUVReXdp?=
 =?utf-8?B?a3lybE1TNkFFdHVWUkhFbzBjZGk4bVF4N3JiNTIxTmJzYU04UlJYZGhCZW04?=
 =?utf-8?B?NlVXc0RGNkQ3NUJ0Z2xFL2FOTWRnQyt4YjRSeGJPcTJxc1dSUzRHdEdJZ1dJ?=
 =?utf-8?B?eG1NZmV4Q0VuekpmaWI3VlFwRTVnaHdPdXVaMGdBNy8xVzZUd0Q0T3NrK3NQ?=
 =?utf-8?B?V00reVp4anNhcExTRzhQTHJpbGRWRkI0TnpaTDN2OFFEcmlEYjRtOTNEdWpm?=
 =?utf-8?B?aUJzb0IzSTUxd0pwNjhqUWkzMFY0azhFT3lVelYxdWtLV25xVEFod3hCTEhZ?=
 =?utf-8?B?M3JkRlI0R1UrOElLMU1tZFltazRuNEp6czBiUlA0dUsrUlNqL2FLd01vdmVM?=
 =?utf-8?B?OUlEcjJRZkdYbXNyNUgyQ0xHUTdwaldWRW4rQThzME4zbjlHT3JEQVRBeCtW?=
 =?utf-8?B?WDZKK3Q5SE1HSnJIdmxPT29uYUsvOUR1Yk1TNlNCbjFtNDFTbTB2b2RtT01a?=
 =?utf-8?B?Vy9ESk5jYVV1UGFxWXhkWXQwZXZvSGVqbjhsOTRPbndIM0ZyMExjVlp1SmhU?=
 =?utf-8?B?VkdCVXZnNkZ2V3RDSDh3amVsaW5EMWUxYTZrVjZRYlhUcnV1RitWUHZsM3lO?=
 =?utf-8?B?VFlyYTFJa1B0aGo2SW96V3RFc0dhL0RkVWdsS3k5OEtZZlNkOU5tcVhHTE40?=
 =?utf-8?B?YzE2K1dENFZyZGRPTmlYcTk4eGM0YU0zRDJKVFpQZXIzbHNESkpSOEtvdWpj?=
 =?utf-8?B?SWx0Yll5cGh2M0kzekZ0cDdyNUpUM2JVdTV2MFJKekFmTXBJZ05sQlRRMUpP?=
 =?utf-8?B?cGhWaThVZ2hqaUNPVDZTVTFndHovM1N1V0xyQi82bERaWlRJRVJybVQyV2dL?=
 =?utf-8?B?RWFXMmRMaFlKZ2U1Y2prOHdoSUFOSnpMR0k5REJndUhYbnpSM29IUVZVKzlD?=
 =?utf-8?B?Smc4YnlnenBHNUNYeXlwd29yL0VsWmFkWml5UWVXbGhiZE81ZVkvZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 432f8b04-021e-46a3-9a28-08de73bdd5b1
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:30.6313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fx9LM8ouqoEbNx9qDcKjMgbNu1V5TXt7+ljPKrYeOaYGfJeohgQK4ttvwwWdxXrPRtmk4RUwMaI/0CjN9vcktIfViPmCPeFOtv/KkGyK2vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/plugins/qemu-plugin.h | 13 +++++++++++++
 plugins/api.c                 | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index a6ec8e275d..04c884e82b 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added qemu_plugin_set_pc
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function only returns in case of
+ * errors.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index e754b7c69c..ca3e93a194 100644
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
@@ -466,6 +467,18 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    if (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC) {
+        return;
+    }
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
-- 
2.53.0

