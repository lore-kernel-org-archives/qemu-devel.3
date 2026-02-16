Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF24E7BDB0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryCK-0007yI-Mf; Mon, 16 Feb 2026 07:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vryC5-0007v4-Uy
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:59:20 -0500
Received: from mail-switzerlandwestazon11020103.outbound.protection.outlook.com
 ([52.101.188.103] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vryC2-0000NE-WC
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:59:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDt42q0nibP9etH62+nCjMiGbHplCz2j7ID11MMbdoVPy/KochKBR9Z48PZHgpAq2YH03USu90/R3NNMxbiUMFNU6PHjkE4k7WpX3pe4Ibpv7Gx74TCpsA0CyytQHUQfI/MjfZXhhZ7+2i0EfgoPX8Q3bCUsD1LD2Iqe8Y9OuV72gXvBUFfGwo+MdkqgqWiymSZqFQ26xKcxzRbqCPM9BuscQqZuopyzA2WwkGwqehzv66X9Lw5UDC+tHyDPO1zYqC3JzlDyrPO2KDKRzWYmuOhjh4j7nprVJbNyi3L5F0G/fkjXZk6vPMBu3B7zEnyfGv79j9rn0PKasDB7beEyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RM4DQOfFJu9FC8anG7H30oRlSMPkyq2fMOG1v+o8qg=;
 b=VjwXPhOF9LDa8zTqopBbFFm4IxhbefA245jIAQB4erhga9YIx2eGnfLRnqCvGEqM5FE5Ont1MXcQ4ZOUVn9BaL2gc/i7BgfxPY7WcH1pjUI4Km48omHLo4ctEpuvPkv0DdgxeVXujLyEdDH0LXhoMEEK2M4etb7HhFrbcdkv/KqzeFx812xmyldIOOXDvaBCxSNkKvj/n5k3BZtll1zVTx8ntl5tjZnOTIlqSdfvvJdq97/EEiO8nKZ0Q0lRMc0++kQ+oOjrXuqpbSYsBYfgroeSyHrlgPB8IiteCcrts1QF5BbgaV+Cawct5vF9temK0eS0FRy+a5fkIu7yfbeooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RM4DQOfFJu9FC8anG7H30oRlSMPkyq2fMOG1v+o8qg=;
 b=WwdK5RBVrxavaNQaTSseefeAzTMAtTOux2/D8WZ4lpYpqHSMdRTM0hpYXL2LVpeRmydut97dNcUGs1UzY3HJQ6Wqy4ArVFUaKS/tOkxRploggdYLIG4Z6PZns4eOt3J/RQEw6z2mHLDqAxZhF8xI0AYgZjwlT3ua7eMUksw59BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1599.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:54:09 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::694f:37be:c37e:6cad]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::694f:37be:c37e:6cad%8]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 12:54:08 +0000
Message-ID: <7fc71343-095c-4dad-9cda-4267fc49b64c@epfl.ch>
Date: Mon, 16 Feb 2026 13:54:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
 <871pjcdt5q.fsf@draig.linaro.org> <87pl6wcda9.fsf@draig.linaro.org>
 <878883e5-7100-48b7-bb44-e0728c93ae72@epfl.ch>
 <7137a1e3-9f07-4a6b-8507-35bbfa5324e7@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <7137a1e3-9f07-4a6b-8507-35bbfa5324e7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::14) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffc8793-f8d6-4115-8b76-08de6d5a7964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|786006|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UksyUEgveG5vNDBiYzlKMmpJay9tcFE4elhZdlFFYVNLMXgwVDFDS1JITzRW?=
 =?utf-8?B?Y2F5dHFvQ3RsbXJmZG5uSGNWTmRuOWk4NXJ4QnJGb1FmT2JEWDY3dnJoSlNh?=
 =?utf-8?B?cDlhN0M3M2NvWFNjL0xlNXdVMjRqbUlJREJXV1FFYjBOc2NGT2dQd2srSHRZ?=
 =?utf-8?B?WE85U2EvRkNBL2xuVjhTQ0VxVThLa2phRWZQWktqWE1kOFdybjBHcE0xc0g1?=
 =?utf-8?B?R0czZ09CT2JnL08wc3FTbnJGdE5tb0hDa1U4YnFlQ1g3ckdWRCtPMzhMbXA4?=
 =?utf-8?B?RTF5MDd1OUkvT0NNZklkME9xMlRWZ3RTK0o5bFE2VTc1eitVNnRFYlFreDlE?=
 =?utf-8?B?bGVSdzlTZWUzcVRtVXBUQjczZC90MHdhQmtjOHlEc1BOK3FsU0hCZlpPS1Zu?=
 =?utf-8?B?Mk13UGJFMEQ2aVZKaGtvM1NhUXJTTTNnSDdya1JWcytlOGFvdWF5dkZTekZ5?=
 =?utf-8?B?T1BrM1NPNlFhYTlXYW80WHIybHNtVkJjUTdROU9jV0xwVUpFd0JUWXFRYTZF?=
 =?utf-8?B?eVd6R3RneTlCUUJSb3B0T09PeStxMWg1UHZ2eVVYOXQrK002WkpETmJHVFQ1?=
 =?utf-8?B?OFQzT0orcmt4ZUhvSUpEUDB6M0VMRmhYRlVnVFVYem80Zy9ocHF2TzhTc1lt?=
 =?utf-8?B?M01UalB4U1hGTEI0R3JldVVVK0luZXVUNzY2anRTcWJZclF0YzlPd2pOTU44?=
 =?utf-8?B?TktNVGN5akdVdE4xK21NWUJCSTU4SjNyMEdhNmo2UGRkdkg1UVZxOWNMZ0Rp?=
 =?utf-8?B?RklDN1BoZkdraDdNY3NHbnQ1K0VOczlrZHRZT3YrZFd1NUdXYkkwSDU5aW8y?=
 =?utf-8?B?VXFncTUrS292eTNLc0pFZzJ5N0FMd1NFbjVQZVdkOVA1bjlHYzhEK2pnY2ZY?=
 =?utf-8?B?ajdSQ2s2SWIvSCtQNlFkNmkzMHZNYmd3OWNNWlNGQXY2L3h4eC95OXZ1aWhI?=
 =?utf-8?B?MzE5Q01USEtCV1FBMXQyYTZCVnpmZTM5RGhJUDNiSTlFSnZoTDg5ZVl4NjB2?=
 =?utf-8?B?b2JNakVRSlJnRnRXdkE3RjByR3o5Ly95TEJPLzVLa0Y2Y0grdlBQMXJyMktG?=
 =?utf-8?B?MzNUTjlqT3ZKRyt0aDdZTTBBSCt5eUxLT1dTcDA5czdSS2d4VDN5bUlCbWx4?=
 =?utf-8?B?V0ttSFBranhxYnY2QnF5SXFIQVRCSVQrUHFmMmtTR3Mxa3VpMUdnd09XTmMy?=
 =?utf-8?B?d2ZjOWwwZVZEei9uOU5PbW5Va3lTUmxJdmp2VXpsOWM0RmR6UXJJNHM2N3VV?=
 =?utf-8?B?emtHTEp1MVB6WHVVQTByUWg0djZEZDRDL3hreVV3QU1jYnNUVHl6VkcrbWZu?=
 =?utf-8?B?NHVYNU5PNnl1bjY0U01DY2pWOUpiRlpMUWhTbTNhazVpN0tXS0ZGK1MzeUFE?=
 =?utf-8?B?amhmT2toaHg2eS9ITzNZeVNmZndHZDdmaUdiY1dsQkxPOUJuNmZXemdVLzEx?=
 =?utf-8?B?cmxNYlQyRHFjN3BhQlJLTGdhdnlLQ3EwRGlVWFZhRXdHblVqT3FVSXlBUVlF?=
 =?utf-8?B?bGxLNmxvczRYcERqU25nbkpWOHhFdlg3eU1nVUZrdUk1L0txVnA4dFhrcWdk?=
 =?utf-8?B?SDNyMTh2WU1LUFI5Vm9rS0VwQnJPSHJiK2txKzNMSWhhajhMeEJ1MWpTTkV6?=
 =?utf-8?B?WUJoeVFGclJTbE9TK1FGNnJwOXRqbXJsbmw0aVZiS0hvMTcxaFljd2JIZ3Nk?=
 =?utf-8?B?WmJNL3kxSVZHdWZKNHlCeHdweitDdHo1NG5oN2pyTDBNQStVdFJGOEJ3V0JX?=
 =?utf-8?B?b3JCYWV2RUFWZGpnVStuZUMyL0RMZjZJMTZpWjk5RWozR1VsTDRnL2w1RUwy?=
 =?utf-8?B?bmZBanhGbi92WW0yT2FhMTNHOXJhOFNCRk1MZXUzK0dEaERhcjl2aUVVdFB0?=
 =?utf-8?B?bDBINmgzc0JmbGEyRkhTM3JmaXp5MFVyWnBSQTdydCtsUUZlUzFWVWlkQW1Q?=
 =?utf-8?B?ZFhhUzBMZndOb1FmRmhXb1lubHhhN0JXbmhEaEZaNFduS1pGSytVN1hiR1dB?=
 =?utf-8?B?ZHJUVUlrcWpmem9tQVkwaXVkU2pwa0VKck9VZWEzZlI5aFlBbE42NndGREow?=
 =?utf-8?B?SXo3bEN4Vi9zbmVkSVIxekVEUUxRVms1V3pUWmswSFRKYTdpVFZhWVZ2Q1px?=
 =?utf-8?Q?sGZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(786006)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VLSVh6TnRQS0xibG83TExCYnczR0ZsMWw5NFNaMWhtVFNQemJrSkVzdmM4?=
 =?utf-8?B?ZmFtZ2JVTjlmaUc5UW5jaUowK1F3SXYvUmJpWll1SnBKMzgzQkUyYktETnBK?=
 =?utf-8?B?OXd6T2RaRyt3WG1Od0hEZ1R5RXBibXpZb0NDMmdyN0VvejZkeHVZSStpdCtw?=
 =?utf-8?B?ME9wWXE5d0swRnhycGpoNmszbStPVkszQ2J5TkNVcGdrUjRKeUViRkJualN5?=
 =?utf-8?B?ZHBHb0VoY1kxMVM4MjBxSk03T2hqVEd1YmtGaWtkZEpVd1haUllhQW1Jd1pZ?=
 =?utf-8?B?aTBvMEo1N2FyZjE4dk9kQ09KNUk3eWlLWlZjUFZIdHg3dnJCKzJVdE5FcnlT?=
 =?utf-8?B?ODBPOFVKaTZzdjRVajdYQWJRVFFoMzcxc1p3TnpRTkhFdk5PNSt2RFhRR1lN?=
 =?utf-8?B?WUtxMFpDMTJraFhNbU54clNiRzlINU9hb3ZENjFwVzBvK2VaQ2xuS0Viajhi?=
 =?utf-8?B?MjRjUkpzVGl2dFJWcUZ4cTFab2dIbVRzTDFFVkFUSUNTZnFnL0RwOUh5Wmxw?=
 =?utf-8?B?L3lyZlFaOHRGeUZ0WldLYTh6RnJPNnUreFA4YnZTY0oxSVRHYWFTdXJza1Ju?=
 =?utf-8?B?TlplaWZyTVlnRHhDY0hDc0U0SDZtM3BVZGJocm1OY2N2UUR6RnVXakVhNEZP?=
 =?utf-8?B?eEdheEs2SE9hcHlSMEpRVFZkRU5yd0dRUWFFbmFLeGZSVEZjWUZsV3RmSzUz?=
 =?utf-8?B?NzY5NklHb0dhTmN3OEVBTnhzY0xMVXJaUFZLUk01NFpBeGJtZnU0T2RLU1FK?=
 =?utf-8?B?Rkp3VlQzamRBUzFvWlRQZkdKcEtqVDArcnh3QTdXTzF3UFlJYllxSmVhcStm?=
 =?utf-8?B?VUZML3h4RU94em4yZDNtUVlFOTgrY0ZiQUZKbCtMc1AzTTZubHZzQ3Bkc1NK?=
 =?utf-8?B?Mld4TzU5eDdRRTVpWDhiRGtITkZabEowN3pwMm1RLzlxUFFlcVBUajd4eEpJ?=
 =?utf-8?B?Sjg1ZEVLNGVpWHY2Y2VsVzUyZllRRG9MUm5YbjBtdHNDUk9sVnl5SU9qYTBr?=
 =?utf-8?B?RHFjTHArOWhNbFgwWEphTHNvaWwrSnBDL1R1d1lHT1FoT2VGSXVJTDJIMGpa?=
 =?utf-8?B?Z2FsTlJZakdlNG9rejZmYm0xbHU4aDNzTzJTRVdMSmRxSlczZktnZHlNOElI?=
 =?utf-8?B?NzdwdkUrcDJJWEhHSm9wWGFmbkF5bTFOQWVYVUZ6czUrR2tkNVlXRGJENTBZ?=
 =?utf-8?B?UzNaUWlTUFR5a0JnMndFaURvQzNjOU1DWktkU1BQOERyaW9raThVdVI1UFBs?=
 =?utf-8?B?WDU5d25OV2ZIWmdZWDdhUkRYRlphQXpOaVI0cnUrWWhuNyszUzhZcTF6NnRn?=
 =?utf-8?B?YndXVkozUFQySWx6REtKcXRmUGtNM3NyV0RhK3hPVHBuSFhROGgwUGd4S0NO?=
 =?utf-8?B?VCtOUjd2VG4yUm13QVlYbTVLajhxZ3phL3puZ2tUMzZ2VGovYVdsZ0RGTCth?=
 =?utf-8?B?TVpPMy9zTzQ0RkcwNGlvRWVsa2xMVG8rVlNXOWJGbXRtK1BnZGN1V0RUZ3I2?=
 =?utf-8?B?TlYyUENLT2NZYTRnMXJyTDIwc1lSM0ZRSDIvWEloYWZwQytRemNNVFpKbHlE?=
 =?utf-8?B?KzRlaWZyVGFiNmovdXJmcDRyZTZPNWlhbmNKcmRERHRBUzVUNlQyME9QTklG?=
 =?utf-8?B?ZkY5NFBSZWI2VUQveVByeVFGUjhxSVVENExXakdqeE5EdVJpQ1dZL1VYL3dL?=
 =?utf-8?B?WStJOGFKc2RPamJ5bFAyRDNwR0RiN3h4L3MwK2FRN2ZrY2QxT2F1bThvTnJR?=
 =?utf-8?B?RFpQOWJDU1V0NkhNMjJwbU90RkorR1FxczhlMW8xSFNUcDNiM1VDeGpNL3pk?=
 =?utf-8?B?YjdxN2pqZWx2N2dKSXp6VWJGRXpjUy83Z1NCRXZNZTF4YldRRFU0N01NWmYw?=
 =?utf-8?B?VmM2aWx3NXI2YkhaSkNvTlV1WEVOTnZ2c1ZyOUVsYmVDZ2FtUUpvOWtIcEZZ?=
 =?utf-8?B?S2ZpVUtqSCtpYlpsZ3pZZHJFWUcyL01peHkwOUczeEZ2cnB0S1JlNTdEbjlI?=
 =?utf-8?B?QmhCVlRrZWdXMEExc3VRMnRmZ0NHNHRCTnZ0Q3dqZXRERUp5WW5nK3c4b2lt?=
 =?utf-8?B?SGIraHUxdHNZaGpuWHVPSzN4dkFUbFR6Qy8xUkFmaEpnT2w2TXcxS2VESWQw?=
 =?utf-8?B?eC9BZk1aQWsycm9NaEl4bUlNZGwrUTVhTjl0R21LU1hocnhmRVo2Yjc3eHpI?=
 =?utf-8?B?bFR1NFphOU5IQU11WTdSYUZXWWNKT3QwRFVpK2FnOHVuMllWU1h6TjZ6cVlS?=
 =?utf-8?B?Y0R0OGlTemcxZW5pNE9DRXd2UzNpVDRTZGRDUkhiUklyaktjRTZadUFaS1N1?=
 =?utf-8?B?RWJCQ0JlQ3JudUh1M0JDTTBNL0RjZlpndTUyYkxPRUpFVE9yWjZaUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc8793-f8d6-4115-8b76-08de6d5a7964
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:54:08.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSd+jFdgAT4AoULkWwZzHyEaeNolzwFqVffsNm+yEYLklwC0GD55g9NXnAV9mbn0jc26CeDgq/vENt1PzQli1RU8THeN9r/EEhClKw69PuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1599
Received-SPF: pass client-ip=52.101.188.103;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/02/2026 19:36, Pierrick Bouvier wrote:
> On 2/13/26 5:38 AM, Florian Hofhammer wrote:
>> On 26/01/2026 21:46, Alex Bennée wrote:> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>>>
>>>>> Some registers should be marked as read-only from a plugin API
>>>>> perspective, as writing to them via qemu_plugin_write_register has no
>>>>> effect. This includes the program counter, and we expose this fact to
>>>>> the plugins with this patch.
>>>>>
>>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>>> ---
>>>>>   include/qemu/qemu-plugin.h |  2 ++
>>>>>   plugins/api.c              | 17 +++++++++++++++++
>>>>>   2 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>>> index f976b62030..1f25fb2b40 100644
>>>>> --- a/include/qemu/qemu-plugin.h
>>>>> +++ b/include/qemu/qemu-plugin.h
>>>>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>>>>    *          writing value with qemu_plugin_write_register
>>>>>    * @name: register name
>>>>>    * @feature: optional feature descriptor, can be NULL
>>>>> + * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
>>>>>    */
>>>>>   typedef struct {
>>>>>       struct qemu_plugin_register *handle;
>>>>>       const char *name;
>>>>>       const char *feature;
>>>>> +    bool is_readonly;
>>>>>   } qemu_plugin_reg_descriptor;
>>>>>     /**
>>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>>> index fc19bdb40b..de8c32db50 100644
>>>>> --- a/plugins/api.c
>>>>> +++ b/plugins/api.c
>>>>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
>>>>>    * ancillary data the plugin might find useful.
>>>>>    */
>>>>>   +static const char pc_str[] = "pc"; // generic name for program counter
>>>>> +static const char eip_str[] = "eip"; // x86 specific name for program counter
>>>>> +static const char rip_str[] = "rip"; // x86_64 specific name for program counter
>>>>> +static const char pswa_str[] = "pswa"; // s390x specific name for program counter
>>>>> +static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
>>>>> +static const char rpc_str[] = "rpc"; // microblaze specific name for
>>>>> program counter
>>>>
>>>> It's ugly but I can't think of anything better as you say in the commit message.
>>>>
>>>>>   static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>>   {
>>>>>       GArray *find_data = g_array_new(true, true,
>>>>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>>               continue;
>>>>>           }
>>>>>   +        gint plugin_ro_bit = 0;
>>>>>           /* Create a record for the plugin */
>>>>>           desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>>>>           desc.name = g_intern_string(grd->name);
>>>>
>>>> Lets just set desc.is_readonly to false here.
>>>>
>>>>> +        if (!strcmp(desc.name, pc_str)
>>>>> +            || !strcmp(desc.name, eip_str)
>>>>> +            || !strcmp(desc.name, rip_str)
>>>>> +            || !strcmp(desc.name, pswa_str)
>>>>> +            || !strcmp(desc.name, iaoq_str)
>>>>> +            || !strcmp(desc.name, rpc_str)
>>>>> +           ) {
>>>>> +            plugin_ro_bit = 1;
>>>>> +        }
>>>>> +        desc.is_readonly = plugin_ro_bit == 1 ? true : false;
>>>>
>>>> And fold setting it to true into the if statement. I have a marginal
>>>> preference for g_strcmp0(desc.name, eip_str) == 0 style tests.
>>>
>>> The option of course would be to skip the register all together. Do we
>>> have code which will have multiple vaddr's for the same TB where using
>>> the TB data wouldn't be sufficient?
>>
>> Skipping the register altogether would basically make it invisible to
>> plugins and therefore remove functionality. A plugin might want to get a
>> list of all registers (which would not be complete anymore), or get the
>> current PC value. If I didn't miss anything, the latter might not
>> necessarily be possible anymore, as a callback (especially the simple
>> callback type) doesn't have access to the current TB data and can't
>> necessarily pass userdata to the callback, so it wouldn't be able to get
>> the PC from there anymore.
>>
>>>>
>>>>>           desc.feature = g_intern_string(grd->feature_name);
>>>>>           g_array_append_val(find_data, desc);
>>>>>       }
>>>>
>>>> Otherwise:
>>>>
>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Seeing there are some questions around this, I have another one.
> 
> Does it really matter if a user can read/write pc register?

The idea of blocking writes to the PC via the register write API came up
in https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg01671.html.
As it stands, writes to the PC are silently swallowed, and preventing
that could reduce confusion for plugin authors. It makes it clear why
there would be a special API for setting the PC instead of using the
generic register write API.

> It seems to bring a lot of complexity to prevent this (especially the string per arch approach, even though that's the best we can do), and I'm not sure what's the actual benefit. If someone tries something QEMU plugins don't support in general, they can always send a bug report, or even a patch.
> I'm not really sure to why someone would have a bad idea mixing register writes and pc diversion. And if they do, it would not be surprising it breaks things.

Alternatively, I could add a remark to the documentation for the
register write API that the PC can only be modified via the dedicated
API and not change the implementation at all. But I think I'll have to
defer that decision to you and Alex as the plugin subsystem maintainers.

> So maybe we can just extend API with PC diversion, and not overthink too much about potential consequences on registers.
> 
> Regards,
> Pierrick

Best,
Florian

