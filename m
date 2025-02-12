Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567CDC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 02:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti2F1-0008QI-F8; Tue, 11 Feb 2025 21:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1ti2Ey-0008PV-A7; Tue, 11 Feb 2025 21:12:40 -0500
Received: from mail-sy4aus01olkn20802.outbound.protection.outlook.com
 ([2a01:111:f403:2819::802]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1ti2Ew-000344-5q; Tue, 11 Feb 2025 21:12:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMxKMXvDxctWdh6opJuAwVstSdmZ1UrtGANoLH8xRN5PZziBoN6tlUPmL6/PmiRhgd4TZ6WRFAYvvpZLOeWKN7DKV7GAEPmLx2OL1FXGlVsDLQuZ1sU3sqryq/kMCYBW+KopOR8t3y/CVOKQVm0klsI69AyJ/uUZv3aQ4/3VmZxcI1WERsI3YmKbao4JDACNrUSCK+91Fg+F7ZenShx6CYbiGzZUJ7BY8tK2eoRMv8sk18hd0hWtk6dCcJTbDPvrzWE+lPOZ6+3s+8SKVQi+y6HjrmBvl8POQjd1ISGPkEe/hFKi9r+eAo/MwJg2u8hlxOXQ9UzCL5WP0g/El/EQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBA9AwGTiPG2rOC2+N6LdqtscKbFkp+DCdyfOdCIO8Q=;
 b=sFasNbq71LZ7UsDRDjDnVjv1ZCGFtLrwTOhAsS1vP9DZ6JZg63VP3M5wQv67KVyJHGhSSiKMZucRCciDNpRd6yUEtAQKdzCPFbf4g7Qx8LROS6QFdi/BSPpu7JUr+qN2Q+EYbJoGLagjYwHnmV0j6NkXG0M2Ye3E9r/0frzTeC+VtKVXU0o6TE1KfqDhaeB6IAA8QVq5C1sdl/BVmHAI6pg4DMtccloTjxWxdk22ve1JPDbYvaZCSonEJowyer0dX77y6OMunD1iEkuQg+A91qq+TkiBf71kN/pXxBS9TY9sqEuHVifGWNveIxoOkM4xlDNfFgTUi8Mj97377M1RNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBA9AwGTiPG2rOC2+N6LdqtscKbFkp+DCdyfOdCIO8Q=;
 b=gN5AyjKLjgXcey+nCsngqGhm+oTp9eEp6o6PfVLnx5wsecTEJnE/o+6g7rcxZkjkFg9wRYsdSmOhRR1upCCM1wOY9NEBeLl5eBoYKy8eBVnNkbv0YIRB67NbQk6zzOU4CtZB/OYzSPmMDyX63pcvMbjeipd5FmTe3w2xmKfrE4bCowgCu9dYRYYm+z8L8sAPwp2NoA6+XYnAcassEmsg5+bf5fXEQ/j3korNpfXvpe6VHoa0KfQ7Tee6OiVEhiAZV2k4NgfiDsZWBlEU41dCYarDa3nby9D/UsC2/aIfylxxxiBvGLXGfQFqL7JI4voqS1Vp+f4NHeQ1NKye0oQq3g==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0505.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:290::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.21; Wed, 12 Feb
 2025 02:12:29 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 02:12:29 +0000
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com>
 <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
 <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
 <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfaYNZ1JZddOhdGfMhPAVK+trX08B_wBS5MbvrUNdCGebA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, qemu-stable@nongnu.org
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
Date: Wed, 12 Feb 2025 09:22:44 +0800
In-reply-to: <CABgObfaYNZ1JZddOhdGfMhPAVK+trX08B_wBS5MbvrUNdCGebA@mail.gmail.com>
Message-ID: <SY0P300MB10267D822107EF0CC5402E2595FC2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KL1PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::9) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87a5arsygt.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0505:EE_
X-MS-Office365-Filtering-Correlation-Id: de9c38dc-edad-4904-df5b-08dd4b0ab396
X-MS-Exchange-SLBlob-MailProps: vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrXKwfPSZNHHFrBghl2DH9YNa4zM13vnZIYTa1PqFe6u/Qkx8Y9l7rNL7gEhQ14HwxzKE8Bb2n3GaA0+ByMwRqfYsdMR9IgzFstDFwTuXz7im4RVcNwYNXQYID0QE9Xfpzkdr9WopNBUwoKnMOkjrRx9H3l7hSV+AxLgUgJzouiaSn7yoEmqnbpW9d2znCoW7vrAo7iNAQQC8ePGZI+xcd7ljWhKpvf2s1egIjECtIgxGo07UFg6LZn77UEq+rhlfOdb8Gamv0OQjk8aUJkHm7LMchgx78oS+Qtci61D8SXxbYO1XfdKEOpHgohBpE6EyVtavrEYHzoaTpds53NgAjFgW5z7gKi6+kTwBAoYAxHp3CoKhdMirDr8FGDNHWAbDMv0o1hS6G9VCtt6ZSAe/IW9ZZxjfOM4oGp/JrnUznUbG6Ht9U2lVbBoAlOKMtethzD2aQquoIz8VNrzFpCLx83TRpmWnmHmhxG4XN6i6PLTSYcFEgFz0zJtjIeTF40bTVmrl6KbiwLewq2C+V0/WT9yJzw9YXLn9J9tk6JXGeK00UWIMc+DuEyQ7H7pj8qc/CRoOP3u+hGA192U9Vx6k1S3Rw771J1UDEsQizNPgY08+qWKVXN290pxhW0wg0vDM614P+TgR3exTHOn/mda9+BDS/sILnRlyp9uaBaojZ8i7jt6+XP/ww0BzedAr6Q4YZ2qKAoXU2TqADfOSZyPH/v6HsyNO6+k0gof6p40iVmnHJ/Br8nEwCqFfqUXbCeJBopHP3+4TBZTDO7eCp3pMfrDebyKs+FYxI
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|461199028|15080799006|19110799003|5072599009|7092599003|6090799003|56899033|10035399004|440099028|41001999003|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGJ5bFdpNTVtZWp6RmVPUjdkSFJOM1IxWmE3N2MzUXZ6QmxBaFZWRmJqcStG?=
 =?utf-8?B?LzJSdzNxVFdnZUR3dW5maU5PcUVKVmorZHVYVFRRODE3UHk4MkErTlZoUGxt?=
 =?utf-8?B?bEF6RVFuKzZjNlVTdVVsUnhRNmxxTnFaMkNFV08wemFrL0Zyak1KZEtwbkJu?=
 =?utf-8?B?TlJQb25Zd3MrV3B2WWYrWnozZzN2LzNBTTNpMmFCNWlEczRUV2RRSllucGIx?=
 =?utf-8?B?Njg2VnpsMXdvQ3VkcVV5cDJhTW1VcFJjL0l5eUFXeExMWnRTaWN6SlJRU3Az?=
 =?utf-8?B?MDltdkdhNGlYRmY3Y2pZZ3B5ZURNME9xWUllSVRlTGxjd2pueDZkYjNwWEh5?=
 =?utf-8?B?eXJyQlJybE42RngzbUpMZTJwME14OHNTYk10ejYzTmtKYXg5UzM4N2lOVXhx?=
 =?utf-8?B?UEJwY1JMeXJWQ3BicXpybFlVM3o2WGJsU0wwdmYwNzBGUzk1T1hYTy94aWJI?=
 =?utf-8?B?STZFMWNja2lXUDh4cUdublRTUmt4VzFjVHlCZERSa0liZTcycDBxK3RqZlY5?=
 =?utf-8?B?L2tPRUJUNitUMHVjMWJyM002L3VTRGlaSGZpK1hjZ29sUVljT2c5TUJhVE9u?=
 =?utf-8?B?eEtjeXBDRHFtQUYrNHRWT3NmSks0VnUvQTladkVKNWNDRTRpcSsyQ1JHUWZn?=
 =?utf-8?B?amdwR09LZDNieTViWEpjNkZPVFBMYUdLbW5Sa3dhVk80TDZQT0ZsZ1VacDEw?=
 =?utf-8?B?eHR3Y1lHRVQ1ak43OWFiZW9Kb2x6MmVya3JyWmJETlFqcmVUM0gwbm1WL0Ur?=
 =?utf-8?B?RGdaSzZ6blRwREt3SmxRZlg1aXpBMlV6NEludkpsTGU0SkJUTitVVlBnY295?=
 =?utf-8?B?WlNETCtEWWY2RmRvNENiMVppVFVGRkRYcHNIWFVJdFZHOWx1TGtXNG1rekgy?=
 =?utf-8?B?cllKN0xWZzl0c05ERXRKYWs1aTE4Z1ZRR0NOOXZVWjFmMTgrSU10T1grSTF3?=
 =?utf-8?B?cnFmUHVWZ09oMmlGT2NtdWZyWnVXM04yV3BSOStXL3VBTUlKcVdQaGtaUkFC?=
 =?utf-8?B?RWs4VW92MmN6a1VvaXFQaGppeHFxNXU5NnRnNGN0eXo4ckMvWEFTOWpzRnhT?=
 =?utf-8?B?dVJqNS9yK241U1hzbEhLTlFDRWxVZlpJUGtJSzlQYmRwY2owZmZCeVUvYUVO?=
 =?utf-8?B?N1Q5Vi80WGJNcVQwZzdHSDU5eDFYZ01pRHNicXdUYVdsTWVKMmVMd0c1bmVS?=
 =?utf-8?B?U0d6K0NDdE50VFluL1VLTGRaUE14WWU1WUVsRkpibzlSU3ZPaDVBS3FhS3BV?=
 =?utf-8?B?RC90MURUMzU5R21heENhcHVoQUI1STc4WWh2dm5vem45VHBLWHBIK2kvNGhW?=
 =?utf-8?B?UEZqc2NUZnEyZm1Pd0RZQUZaT0lMS1pzWE5Malk3Wm45am5kOGoyLzdsTEFF?=
 =?utf-8?B?MlZiaGoydXpKcnpCZkoxeDdYSVNZRmRzL0ZOZlJZdW5WK1BGV2hXZlV3c0d2?=
 =?utf-8?B?VWdHT3V4Q2Y1clMweDdYcFY2SmdqUGdNNVZBdWxrQjdpeHJzam9KMmZkNkFS?=
 =?utf-8?B?djZBQzY4aVhvK0hzbWs4SnY5L24vdHVMODJUSmVQTWFJUGpBeXBtK29qZmRC?=
 =?utf-8?Q?N4qagSoHcJZ9ltB+74Ii6YaxZTNcsCLgS34oeF5Em9ObqY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNPN3JpTS9laDB2QTY3elBtb3loNXF5MGxDMllReXB6SFRiQk0rbVZuRjBw?=
 =?utf-8?B?NjU0eUErRHZGeWtFZzUxZDZDMkFlOEwveDFOVlBrT0R5U2U4V1JFa1h4QWU4?=
 =?utf-8?B?dVEwdXNjcUJQWnhXRnBJb0R5Qjc3VFArS3QvcE4vWERiQTd5cENSNi85aGdp?=
 =?utf-8?B?aUw2Y1oxUWtoVS9pcm1tcHNjeS9jS1JCRExqQmlEWWZQM3JqaEV2eUhYYWZj?=
 =?utf-8?B?cm1rYmJENVdOUm9uRHpmU1UwQWVHditYYlBEVGdEVjNOdThMWU02SmcxYnhX?=
 =?utf-8?B?ZHJ5cjE0cllZZ3FWR201MTJWZExXRXpEVnZlTUZ4NlZiUngzMlJMRHN2bnVQ?=
 =?utf-8?B?RWVDaXNHTFlldXY3NHUwdEJubWtuLzcxcjVMUEhmNm1EN2ZoalpKWmZTa2lS?=
 =?utf-8?B?bnR0Z3kvZWkxMTJQcjArNnZIVGZYWmc0cy8wVG9XaGYxUjR2dmt1cnU3QUwz?=
 =?utf-8?B?V3Bka2g4TnFxVGp0UzV5ckp6ejVWWHhNSkNlQlFZTlpJYmlzUk8xbUNsOFBJ?=
 =?utf-8?B?c01XK3lSMDNmWHZROEN5U2dNNktWSGRSQWtQV2JBR1VETVdtMmhiSXZYYUVY?=
 =?utf-8?B?ZUVNMitXYTU3Z2NJMnFmTWVlZDZ0RG5lUzhObzNMZEZIU0M3cU1JVFVOUzdq?=
 =?utf-8?B?SGdBZlJkUUkvUXlkbEtQZU85aTc3K3RaSWdzbTFMUm5NMGVzTHdjU29PNWlO?=
 =?utf-8?B?Mk5qWDdkOTh5NmN3T2M0eGUrc1E5b1lma0k2Y0cybllIKzlqWXF6QlQwenlT?=
 =?utf-8?B?VytLTFYvMEd3NHpwQVpCdFY5UkRkZTZzRXNoNjl6MUpjb3ViUHFoZzQ0NENB?=
 =?utf-8?B?K0I0OFNxQWRuWlU5eENXZEdZbThiaWFBVmtEUk1KTlErSyt5MzA3RGh1SEpw?=
 =?utf-8?B?em9QQnhCUTdxNEcrd2JUY0x1ZytoTGVMR0pFL21vNHFLcEJKa1hySS9ZK2Zn?=
 =?utf-8?B?RzVaYUQ2MnBqUTRuRGpabXpuVklsaDlFenRFWVBFOG1xWksraVpBR25kMVFq?=
 =?utf-8?B?ajhCcGsxOWNGS3NvK0w4RXNTWitWZUFad0JIMnVBSEJpTkVFQ1ZPSlU0Ty9k?=
 =?utf-8?B?cEQ2SUV5YkFqUHgyLzZpK2VNNmhycVRwYjliMUxTUStKTDlNWXV2QXp4N0Jp?=
 =?utf-8?B?TzkyaWpDY2Z5R0Zmd2QzeDRoY3VXbDFaYzJYU291UTJPbzczWVpWT0E2ZE8w?=
 =?utf-8?B?SGVXN0FwYnZxTitwU2s3L2xYRm55U0ZoRFQrWDJBdGhMeUlrRXZieEZVNXZ2?=
 =?utf-8?B?QXI3Q3NFRXNxSndiN2t6WUE5SlpQS2pTQi9MYms1OHRoK3oyRGdVaFhsSkdB?=
 =?utf-8?B?aHYwVWxLUldmMURUaVdxblpzSk9xcTNLV0tjUytCN2N3OHlHSm5EeVg1aXFT?=
 =?utf-8?B?SjlnV1pESkZIZ2ptZFluZEo5WkVKNkViOHBOTjM1T0M0NUYyVWlrNzZ6Uk43?=
 =?utf-8?B?N2sxTGhDeTlUeis4VTV0ZE84OXUvTWNxdnRDd0t6UWdTbERTSzJ5VERvcG5I?=
 =?utf-8?B?bHJCejc5YWNGMzh5a3JSa1J2RkJMQVZyb1BDWmdtbVRRS0xsRHJDK21CaHlW?=
 =?utf-8?B?dWVPdHFpMnNSbVFYajJJeWNaWm16YnQ4czVJZ1hVR2xsQUVPQXdEOVhtamk1?=
 =?utf-8?B?NS9UOTBqSGZzYlZFWEdJbXlDWW9QVnJnaTZZSFI3S3ltajJJR2RCRXdZVFVq?=
 =?utf-8?Q?cjb3cApWFdXVVM1oDYXh?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: de9c38dc-edad-4904-df5b-08dd4b0ab396
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 02:12:29.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0505
Received-SPF: pass client-ip=2a01:111:f403:2819::802;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_BULK_SIG=0.001, RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> On Tue, Feb 11, 2025 at 12:34=E2=80=AFPM Junjie Mao <junjie.mao@hotmail.c=
om> wrote:
>> Essentially we want a naming convention that (1) avoids any potential
>> name conflicts, and (2) applies consistently to (ideally) all APIs. For
>> goal (1), we need something at API call sites that can resolve the
>> potential ambiguity.
>
> I now agree that (1) is more important than (2). Adding a function like
>
>     fn realize(&self, bus: *mut BusState) {
>         // TODO: return an Error
>         assert!(bql_locked());
>         unsafe {
>             bindings::qdev_realize(self.as_mut_ptr(),
>                 bus, addr_of_mut!(bindings::error_fatal));
>         }
>     }
>
> to DeviceMethods is enough to cause an error:
>
> error[E0034]: multiple applicable items in scope
>    --> hw/char/pl011/src/device.rs:714:9
>     |
> 714 |     dev.realize();
>     |         ^^^^^^^ multiple `realize` found
>
>> So instead of dev.realize(), we may write:
>>
>>   a) dev.sysbus_realize()
>>   b) SysBusDeviceMethods::realize(&dev); dev.realize() is still ok if
>>      there is no ambiguity
>>   c) dev.as_ref::<SysBusDevice>().realize()
>>
>>   (any more options?)
>>
>> None looks perfect, unfortunately. Option (a) introduces inconsistent
>> naming conventions as mentioned earlier; (b) cannot prevent confusions
>> when a device has both a "reset()" method and "dev.reset()" calls; (c)
>> deviates from how wrappers are auto-delegated to child classes today and
>> is the longest to write.
>
> There is one more, which is a variant of (c): use Deref to delegate to
> the superclass, and traits for interfaces only. Then the default would
> always be the closest to the class you're defining, and you could
> override it with SysBusDevice::realize(&dev).
>
> It requires more glue code, but creating it could be delegated to
> #[derive(Object)].
>
> I think we can use (a) as proposed by Zhao and yourself, and document
> this convention
>
> (1) whenever a name is unique in the hierarchy, do not add the prefix
>
> (2) whenever a name is not unique in the hierarchy, always add the
> prefix to the classes that are lower in the hierarchy; for the top
> class, decide on a case by case basis.
>

That convention looks good to me and does keep the naming simple for the
vast majority.

> For example, you'd have
>
> DeviceMethods::cold_reset()
> PciDeviceMethods::pci_device_reset()
> PciBridgeMethods::pci_bridge_reset()
>
> PciDeviceMethods adds the prefix because the three methods have
> different functionality. Subclasses of PciBridgeMethods may need to
> call either pci_device_reset() or pci_bridge_reset().
>
> And also, because there is a similar name in DeviceMethods,
> PciDeviceMethods::reset() would be confusing.
>
> (As an aside, pci_device_reset() probably should be implemented at the
> Resettable level, e.g. RESET_TYPE_BUS, but that's a different story).
>
> Or perhaps pci_bridge_reset() becomes PciBridgeCap::reset(), which is
> not a trait. That's okay too, and it's not a problem for the naming of
> pci_device_reset().
>
> but:
>
> DeviceMethods::realize()
> SysbusDeviceMethods::sysbus_realize()
> PciDeviceMethods::pci_realize()
>
> Here, DeviceMethods does not add the prefix because generally the
> lower classes only add casts and compile-time typing but not
> functionality. The basic realize() functionality is the same for all
> devices.
>
> What about confusion with the realize function on the struct? It's
> unlikely to be an issue because it has a different signature than
> DeviceMethods::realize(), which takes a BusState too. But if I'm wrong
> and there _is_ confusion, renaming DeviceMethods::realize() is easy.
>

I don't think I'm experienced enough to tell if that can confuse device
writers. Perhaps we can keep it for now as renaming is easy with the
support from the language server.

>> Just found the lint: https://rust-lang.github.io/rust-clippy/master/inde=
x.html#same_name_method
>
> Almost: "It lints if a struct has two methods with the same name: one
> from a trait, another not from a trait." - it doesn't check two
> traits. Also I think in this case it doesn't fire because the trait is
> implemented for &PL011State, not PL011State.

I thought that lint can help warn early when a device writer
accidentally named a method in the same way as an API. But as you have
pointed out, it doesn't really help in this case.

I'm still a bit worried about the potential ambiguity between API and
device-defined method names. The compiler keeps silent on that, and it
can eventually cause unexpected control flow at runtime. That said, I'm
not sure how likely it will hit us. We may keep it as is for now and go
extend that lint when we find out later that the ambiguity worths early
warnings.

>
> Paolo

--
Best Regards
Junjie Mao

