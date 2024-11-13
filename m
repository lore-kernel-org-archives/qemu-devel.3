Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA81D41C0B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 06:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7FG-00032S-Up; Wed, 13 Nov 2024 01:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7F9-00031f-Li; Wed, 13 Nov 2024 01:52:48 -0500
Received: from mail-me3aus01olkn20809.outbound.protection.outlook.com
 ([2a01:111:f403:2818::809]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7F7-0002uZ-B3; Wed, 13 Nov 2024 01:52:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9et5s6DjmkYdhNnrdMZRAfUL8g9JEOSKYNvbQSLnIeiwC7xYBNcyWYTbuQGK6IUudV4ckqtrZMDyHIcve6uxAaUt0/EiytSb7RFzEjlYBR1y+AfDkGH8BB0sBVCnC7SqkvmpThDQ7UtbobdGX0GbTMfSoyWXBGcjT9v9Zw3I6Jh2ejgsXbu1Dan9r5gf3R4DszsSe1fdeMp+5XxnCTXbfSG8Nmr3v74xU1C2hc4H2r7uaZB4syWlsLp8d2FLh3fbLbK3/ffyq3co7VR48UNHzkpqxXg1M54Ej0TIfsHheIGxJim4YyiIAQV8ZNN5+tprZTOSNepfohwrHMjRFZ4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC2tqcjie+1uk1fcqaJ0I+XRs8fYVqYKRmRBv+s99w0=;
 b=j1P1PA5piNXgWPnEvZJhO84r3gH+LOFqIn6DWuhwBMxMGAo3u7jAz7iPbNqhpVRa0a0RRz1HvDMgfKTNOnZ5PQUteOfXZeYApjAZMpwmkd+uc6aPOwMhocon5KbhhoushEzQjUi7xnywkd9i+vxN6leHpRDf9PVNEPdLcBMMTsgMM55WoV/rRJgYQAiiMpsbXKwu5NzwbBinqK+A989Fno6Du12jT+yMphKXP0JtO4NUp4utIXNFa8XFgH30aAayyu8Jfitzt8/ecsM9pMmcQOBGoJ6zZOrdXl9kV+McEFvXffBuu9mBriexHN3V0BvDgYemkpUJvvYHoezvVFd9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC2tqcjie+1uk1fcqaJ0I+XRs8fYVqYKRmRBv+s99w0=;
 b=UgCVKbFwE3mmjJRMzQlQzBGRWzSy9qJ5wu3MYXYyL4uvVMI1RZ5fHkyfypx5r92I3L/L3fd0JaFlMgS0p4aaQoI2fE1zqUN5MEJUeI680MdK2Tzhae+X86At8kVnO/9P3v7WUunyutNeMHI7B1+9TqTBZG0UTTUKmONLWePbBtS3fsSJ2ROeO0hzM6HmRmCepnbzI3Uh0VVXtnRr0DoxntnMt1qQ3UM/Gchsh9WXlMpgClSik62xt6IDuAUA2tlW/IRWlYnctMDSYYAAlb/dWGPlzgUFDRS6LXrVV5Hy4v8/S0nJ4VZzvnSee4p0HwoD0QMF+3Jw0b22cdmbD8dfMQ==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by MEUP300MB0045.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 06:52:37 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 06:52:37 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-2-pbonzini@redhat.com>
 <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfb9ujpoRrNUUqyiAefSfTOWSV-SGmo2YrSoMdfxBeAD9A@mail.gmail.com>
 <SY0P300MB10263A5B33FAAEDCB04CDCD295592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <6e1fce37-4a22-4f36-9798-a424e4ba43d4@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>, "Wolf, Kevin" <kwolf@redhat.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
Date: Wed, 13 Nov 2024 14:46:24 +0800
In-reply-to: <6e1fce37-4a22-4f36-9798-a424e4ba43d4@redhat.com>
Message-ID: <ME0P300MB10400DF22DE6A86AA4E121BE955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87h68bfwwk.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|MEUP300MB0045:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e3e0b0-da97-494c-bbd8-08dd03afc2a0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|8060799006|5072599009|15080799006|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B1EbL+vd/8B/1VShae/a8UFhTsxmJMTanmTQCkQwH+9V4EcHWo9JvaQwHgLj?=
 =?us-ascii?Q?vXJMO+O6Q7uO/w2+PCGBlk5weQCJteKAUHJfSBI0NwB+qAQl1qkxofIR007/?=
 =?us-ascii?Q?rTmyD9LvhL0mxK7iCE4/pXsq2w3SHbgPzMaQfLhBK3RWelRSzDylW4cZWFOy?=
 =?us-ascii?Q?y1PjS3DolNTkx9v+3EvhU1pJur9nJo1xFRexo05D7YpXbmJEA+FhIc9pRrF1?=
 =?us-ascii?Q?dZ/wPGjWiCFJU+UBzEOcTXsTSvzIZblMMxI3+TJHupBnfigyNYSm+s16gC72?=
 =?us-ascii?Q?vbLVSyUCYSq5/Cp0SJRZGe0FkZ5qXROHXDc1yW16OHK1agSFGFJo5IML8miX?=
 =?us-ascii?Q?N3wirPcu3d3ia5ABRg84ZxdCREyA7Ot9s/CuwHLRcinh5SVlWrn2R3eUSGqv?=
 =?us-ascii?Q?FQ4wTYwTA/LSA3g8PmFes53wbZ/1Zk+LqMKKhleUlEiRVS/yELVrtk1/n+PP?=
 =?us-ascii?Q?MGGjOetVD6Ne8/JJ0xvjqIMORwty7N/1XErzeFjUtDEKRt8064tjl6z3/q5p?=
 =?us-ascii?Q?X9lozOCuD1D6KfG8NHZzCi8XIyR8zpLP46NkRRmeNAw/txowwzWCeGruCu6K?=
 =?us-ascii?Q?AOr5AT/WH8lcbBZWN4FNKq6jJrKHQj6oSISZwV5ywUOU9s36yvN9/zOqiGFh?=
 =?us-ascii?Q?TB7UF4g4Ty8xweFwQhI40RHqcxe/T91TZCAnspAQIZVPdZ3yHwNlBdIYOsye?=
 =?us-ascii?Q?soH+AG5oTz7wkSwPZGC1Jhuly/D+63cyYpabneENGUED2PWRPoegRvPWy7lH?=
 =?us-ascii?Q?T+AMzLRr62aEpcD+u52qYcdyOIgr2CyrZuQSdCpefovk7ncwzv8x/+MATNCK?=
 =?us-ascii?Q?UmOola/B1VgiPnBn2BU8BuU7pbXfjAo5VzkDU5t2FBaUnV0CSD6en6jb0V+Z?=
 =?us-ascii?Q?xsheCMXC4w2hyCjzul1JSEhgpjxVRDMZGtj9xN0T59HjMRafZSHr3yJYDKzT?=
 =?us-ascii?Q?OsidSKC1BgVPR7Bw6B4UQOAl9ybv3v3+T6aO8zUbMg4JlFoLWIHi/qhSxDmP?=
 =?us-ascii?Q?GdxloLWCt3uTe1RCXc9W2bhx96taxhI9wgawQskTFYDAI48=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50ukgy5/obAEq8ESrsLg/OQXB9MkqEYpI6LWfPe7ayr+MHdUykvvgeZaevd7?=
 =?us-ascii?Q?620zl+l9eV9AtNZsNdl5UBPBVXLuj6Jt2iP0/QjrFga8g01UZhTH0ssUQk62?=
 =?us-ascii?Q?eVThm9zdRZ/Y97A/85amHFCI+skb3TxmEWzI4lumPRyzupsZ0RYqU+5vLdHh?=
 =?us-ascii?Q?P5bn0N1t/uPE+NgnVL4uM1iHj8+LSu2YR3MM68yM7xlY4iegUOd1idSqMWNg?=
 =?us-ascii?Q?sC4HqqhfPBEbBBFsRY+K/wHViwHQswL4EudUaIYXSHo9+SiwLp3Z+dNtkBO2?=
 =?us-ascii?Q?2NGFLopfevSTj5ckyyBMr7Nopa4vSMxwfHqMbhbsBOKbVzdRhiH0rP/N4KwZ?=
 =?us-ascii?Q?j88nesroTqdAKXeOVQPoBS8mCBG9E/Jv8uYS3WatTj6UtU4GiPv78q8H5uIN?=
 =?us-ascii?Q?k+OBeM8c4rn8lOPIoqaS7C/UjikJAynCKyJeCiZxVHEQCOWiXg3clGea/nDD?=
 =?us-ascii?Q?2H9fg/hIRjHS7AjZVlLAAheDcn1nbS9+5NTHVTqrchAUkLw3gO0ofLNFTzbO?=
 =?us-ascii?Q?nM+bwrkl2YYKe3r7/AZ2l4LYU4Posb4xbNPJ6XvBlyjQBcedT68SBqKkxnBa?=
 =?us-ascii?Q?uCC5hIFSD4ak32zx6HgVn6jrZr8WKTZ2ikqHwQ8a5bpkVKYBKHrP66RrrMD/?=
 =?us-ascii?Q?18VM+BKnRWVrV8rgNbjwq7zX4UtNWmogkMjNBO4CSGaQiMEGQIQwU6nYS+iK?=
 =?us-ascii?Q?yashnpbnF2xlWNBbp40rlRTJaoaQ7+n1Na134A8zpo9CxPN9ytUp+8yccX/i?=
 =?us-ascii?Q?2fbmQnuEWDG/uNnaJzskkhZmgVBL6YLuA2u/9/R2VV9zc7znPjU/JRDhLfly?=
 =?us-ascii?Q?3MwWoqk5p7NgOvAuYi+n5wUMfkcZsICzbhIciG2KYrPnEa73JEmjbZxxzUxi?=
 =?us-ascii?Q?nQoVb9H/pmhCKtGgk5xp0BAx7JMEs+eO3uhI311UqGTidizMn5J1AWqzH9Xc?=
 =?us-ascii?Q?9jWrwa3xqTBTvQykUZ/M4D8p6XmLEecyVekjqfqjAlJKxkt/X0weHc4zu5On?=
 =?us-ascii?Q?HvRV3JbhfjD919c0TdedKEfqlovml5dq2aLxCZoIS9BUwcqDO21U2dqXO25L?=
 =?us-ascii?Q?U6SevnsDWq/rOovqRv2I40+9Yz/ZMMP1eXPTHCOFgvrcMctBA0V9ovYOCfoC?=
 =?us-ascii?Q?fmGyTuXYnBYtnbE8UpXPcBE+/XlbCmcBg8E/wF02BdjltWVpeQ9ZWLTxuZX1?=
 =?us-ascii?Q?fTPG9d8hN+nY3QWC+M+M8KyZbZ8clzML2R5Hf7VCRmVGFduOOmWcBcmsyVM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e3e0b0-da97-494c-bbd8-08dd03afc2a0
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:52:37.8615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0045
Received-SPF: pass client-ip=2a01:111:f403:2818::809;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/12/24 11:10, Junjie Mao wrote:
>> diff --git a/meson.build b/meson.build
>> index 1239f5c48c..8cea09ffe1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4,6 +4,7 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>           version: files('VERSION'))
>>   meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>> +meson.add_devenv({ 'CARGO_TARGET_DIR' : meson.project_build_root() / 'cargo' })
>
> I think I'd rather avoid using CARGO_TARGET_DIR, in case someone forgets he/she
> is in the devenv.
>

I should have dropped this line earlier. It was from my first attempt
where I wanted to put the generated bindings directly to cargo OUT_DIR
(so that file copy can be avoided). That didn't work because OUT_DIR
contains hashes that are hard to predict.

>>   add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
>>   add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
>> @@ -4083,7 +4084,7 @@ if have_rust
>>     bindings_rs = rust.bindgen(
>>       input: 'rust/wrapper.h',
>>       dependencies: common_ss.all_dependencies(),
>> -    output: 'bindings.rs.inc',
>> +    output: 'bindings.inc.rs',
>
> Needs a comment, but I guess it's okay.
>
>> -    println!("cargo:rustc-env=BINDINGS_RS_INC={}", file);
>> +    let out_dir = env::var("OUT_DIR").unwrap();
>> +    let dest_path = format!("{}/bindings.inc.rs", out_dir);
>> +    copy(&file, Path::new(&dest_path))?;
>
> A symbolic link seems to work too.  Thanks for the tip!

Linux-based hosts should be fine. Should we test if symlinks also work
on W32/W64 systems?

>
> Paolo

--
Best Regards
Junjie Mao

