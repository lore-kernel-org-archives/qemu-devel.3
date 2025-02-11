Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB16C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 11:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thoWu-0007q2-1i; Tue, 11 Feb 2025 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thoWo-0007p4-MF; Tue, 11 Feb 2025 06:34:10 -0500
Received: from mail-sy4aus01olkn20823.outbound.protection.outlook.com
 ([2a01:111:f403:2819::823]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thoWj-0007LB-DA; Tue, 11 Feb 2025 06:34:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ebA4o44UMFT1ByQ6M8Fip3K6E3BjBhTFwe3qzY9g+R+Yux4RYbuKN6eNkLGG3PR/v+74FuQtxjBd07bu7JyKRyAi73Wum9GkfyECWm0q/Q7EXTNtonaIqSzNAysVmAe1z7qPCg8iFUhQVLdrrzXQ933ZhUDHpoSOZ5sRnajVygvGs6cQhAoR4oBWeZwX7fmpk2US1aMBmeDlTJY0LW09LekBL67caNjhxSvVWqmIT7ESYPrT6ABo5M/XWaP+XdIjZmubIHCk1A1avxdkrdvgu6XYgSfD7gQOR0D5I0m6J/e4TPSPM55vFmIIkg72YXGQZ/y+Hm6wlALTDO2SM6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u//ap+z6PFCc7J4sOgEqmgDd80HbJcbAd/SxH0kl318=;
 b=nKTDX4IMvXuT65njhKy8ofimn8jF/2VO4tvkL36rH6cE+jbW08rxELKD1Nk1MqgIqCoLyu1ihsRkbfxK6AiL2YBViBK/wvLCtXg+q1Pc9/voJpI/+dEvIOMIRma2UJMyPhdYdzGbPSlWflQmzGGlYIPe1wZImRhnHj7TUHaUqrWnO/kRSqwZJMUPGX/LASafYPASOBmsn13DYhafcmMoZiZaN2V9wur+7ZwpeFCZ/7GzetbzczIY04m2tkoLRKHoi1AUEqGFbkJ9gcDyNuTo1+LruoZEYNcbnpYVr/+NLA88UrQBWNn3/ChOmaxa9Phxcx+6sVW3ENWaVB2iXL/VRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u//ap+z6PFCc7J4sOgEqmgDd80HbJcbAd/SxH0kl318=;
 b=fEg3n2fZZWBQxnEUXwg029QT7XuVUzdP/lRPcFCBwe8WHgN6SiKVvlkjpCWwsChEV1RAGVYbz052mavn52C2aOgHBTbvcP34eIjQafg1iL1pW3Ab1VtZiVYKBiIulXQUC4xQM+iPi0nd9bqSe19GhBGEKlyx1ZtB163IjZPXLRvMUvwsu0rU7TyQ/LuJr81Xr6HTUgB+5JHwZvKLabSu/UHnMtpy7yItHOoFR0NncJTSVyysKeLNM5u1MEKvz81VKfv0B9mU37hZYLb0I5nAFmjUC91pdIyvPrtQBiKq2cNl46k6vQTMot/tDF5MeW+fqzoFmtksxul+HrRSRifnyA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0485.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.20; Tue, 11 Feb
 2025 11:33:56 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 11:33:56 +0000
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com>
 <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
 <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, qemu-stable@nongnu.org
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
Date: Tue, 11 Feb 2025 18:31:14 +0800
In-reply-to: <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
Message-ID: <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KL1PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::16) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <875xlgiulj.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0485:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b7bb46-c4fe-41e4-e138-08dd4a8ff83f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|19110799003|15080799006|8060799006|7092599003|461199028|3412199025|440099028|10035399004|56899033;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnZLZUxiSjl3ZnlkRkpKRTR3NTJvNmhmYVh6RVJlZ3VDV09tQWdPYTVyQ1VV?=
 =?utf-8?B?YTcza3lZTWdQSlBObmFUbSt5S0NEeE1OUHlQRlFFYUgxcGZHckMyUThCT3hR?=
 =?utf-8?B?c3VaN0EwTGdaNEs2ejBORHFFMjdYUjhvTjRyak1yS2hoVnpQY3BmVGVTZWVP?=
 =?utf-8?B?UmV0Mk5uTHRsdlRJUzJXNUNoVVlMUnRWUmFpZFVJRVRpWURjY3pBMkJlbXE4?=
 =?utf-8?B?VVBkZjRHV0Z1RnJpUFNTRkZqY0ZqbTdkaWdvSWNibFFqZDFLYWE5U2RMRGtm?=
 =?utf-8?B?WHNYaXNqSUN2VU5lZWJXRnNHTk1pYVB4SXpVUDUzUzVvVG9selVVU1o4Q2Y4?=
 =?utf-8?B?ZFI1VytwSjJvOVVEUXp3ekRtOWx2TjFaVUlETlRRaVRIWW5mRTlTbElLb0lJ?=
 =?utf-8?B?T1dNLzBPWGs0bTNuQitOcWw1bVhuUHJNV2lPSU9Ka3pGYzFHUktuS1FZY2ZD?=
 =?utf-8?B?UmJUT3JCTHNyRWZzRStOdHJPRzRQSzJuL2swTjFBREt0OTdUUXNkcXEySmRH?=
 =?utf-8?B?QTJXanRJNE8wbFp5dDNhWTQ2Y0N2cGg3K1NXcjk2QlVIdVd0TkhzcGYrQ1Jr?=
 =?utf-8?B?WFdJNHd3c0plb0pHcmhXSnFtNE5uUE1HUmpnN0NBRmhJS1pYVEJnaWMwdzU0?=
 =?utf-8?B?MHpHMTdQbk8xMWwvSmtjam1ENWxFUGlVaDZPbUxGVUw3NGdXSzR6ZDJyb1dD?=
 =?utf-8?B?VGs3K0RsSDlrenpud1B1ZzNMNFNkNHMvQnpMK3dvMEY3MEJyQWQrWEh0TXh0?=
 =?utf-8?B?V1FOaUk5TW5aQitVb2QwMFVZUkp0SEtSb2VjbmhhRkhBOTZhYTR6NExpM2E2?=
 =?utf-8?B?VlpwVXZ6WnN6NUpuSFR2T1UrUEpiczUrd0p0Y1FURyt6WXpYZGpvVkxmWVFO?=
 =?utf-8?B?QXl5YVF1ZVhDd3RsQUVWT0FjTThWQkNZejZhTUtWa096b3pZbnNCeFkzcHFn?=
 =?utf-8?B?MStxcldvbFpJSUkydnVsQXpxdXlydGJZQlBsNkJnRi9ndWJDbm1sZlJEeGNk?=
 =?utf-8?B?dDVJYkN3TUI5NmpDNnYvSDE2Z2JFamo5K2FQV0l1eE4yRkVncFdmYU5mVjNU?=
 =?utf-8?B?b1pYNnhnSFpMM0pocUZ1RnQ3dkdud2hDT1JsZTE4bGpUa0xDbURGd09aRzBh?=
 =?utf-8?B?R0tMRHpJR3E3M1BUOU5iRFhXQ0dyN3pvODI0THJ0VnJaYmJTZmhZWkpYTnNH?=
 =?utf-8?B?TFhuTFc3bDJ3NlJCV0szbzdNYk5YSTJDMlUrTHg3VWo3WTVQK2lZUG0wY1Fs?=
 =?utf-8?B?eWdwbTVQdjRoTXVlUlhaN3FPM3R3b2dnTExGWTlMczhvSlAzd1d1NE5qN0kx?=
 =?utf-8?B?SkdTcUNrY3h6Njk3RDJEVm9WY0ZVQXJzVHQ1Z3FLRXhZWDJEdkh6T2VMUXFz?=
 =?utf-8?B?c3IzQ0RoYjlBRDd2Vko3SVBqNnRIOHNpQnU1aUoxc2VGb1BqamVnU2ZaYjJk?=
 =?utf-8?B?RG1CNnFxd3EzMUR2V0pCc2puZWFNenRqRXRBSExaa1BqYmJuaDR0b0Z0Szhy?=
 =?utf-8?B?WTRaSnIzY3NqRnFVam9zK0R2dnhtb3lhdGE5ZWlpblZFQi9FUzRXVkdLcU12?=
 =?utf-8?Q?CnnhQkSSZKmq8mFNcp5lJH4f0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTYwbVNSL2F2V2JXdEE2R1diSTN6VTd3Mm92WFdEd3RFL2xnNFU2Y21zMS9z?=
 =?utf-8?B?c2s5VDQvc2szU254aHdBanM4OHBsZWlIUnRERDBsSFRHaGVvZ1ZxZks4Nkth?=
 =?utf-8?B?WnUrVk5wQVZuWkhJaVozNlBTNmtZeVpqRVY2QnVEbzdDaDQvOGJFR3pPMlFk?=
 =?utf-8?B?QWRPbEZxaGE3bnFrRC9sZUdpbW1SMVIrNGZSWkx5elhYMC80T0RhZVh0VU1j?=
 =?utf-8?B?a25JNGJjNmtkREVyT0txK2l5UDJWSlAxY1krTVFFcEdGc0FOT2dxWHFvNzhT?=
 =?utf-8?B?Rmd2dW9YVnIrdklBQ0ppOEViNEV1WkR3SlN4T3ZVQ3kvMFN6Y3dXOEhibEJ0?=
 =?utf-8?B?ZUhnU1BWK1hsYnhGOUNsYmpTbldnS05MRktWNCtHU3NKR2RmWDYvdEJlRmtT?=
 =?utf-8?B?VjFkdlNsVUo2Z3AzK3F4QVVzdFgwbFgzZ0RFS2FUbHBHVUVzYVduZ1VESW96?=
 =?utf-8?B?YWNybmhLLzhIWDJ3SWN6NUFTOHZiMGhmemgwZG9xYm9WYnIyVEk0cE5hTEpp?=
 =?utf-8?B?SHB6b0VSc095VllrOUFSNGZlZTlaRlF3WCtoRmVPUG5vaW43eXZKZTF5SmUx?=
 =?utf-8?B?aGVNbkQ2Z25seFJ0cGNjWDVjYzFKYWVabjJuL1NHMVBkSlNueE9nQ0J0NEg4?=
 =?utf-8?B?a0JSOXVFUXN0akNPc205b1NoTUJ3bmpraGVrZE4xQUdtbUdGbFB6TjM3WVJt?=
 =?utf-8?B?aWhqdFFWeXBYN3ZGM2EyUWkvZG5tYXIzTXp2Zzk4Q2NmUWh5c0F2RkdSemRH?=
 =?utf-8?B?SmxEdWFhTjNOaUxvUnkzekt1cE1YZUdzYm9EWG1UN3lWMjlnRWd1dTNreUQx?=
 =?utf-8?B?ZldxYThxWFkvbzZURHpKcjVUUjNSemY0VlVDRHRPaThMcGhBdjhPM0RGaldw?=
 =?utf-8?B?WDRVYlNDdmdKTjdWSmFYU0FwTG1oRFZKWWR6M2lMT285R0hjaEpjWTB1M0Z6?=
 =?utf-8?B?ZWxleW4wRGNrRm9CazRKa3NUeCtCU0k4WTJTQjh4WUtpREJNNmVuVDBoWDFF?=
 =?utf-8?B?R0huMjNDWDUreElJVlovSWFkUFNMbXVCK2w0RkNpZUpaMXpjcFZyT1ZBZVNB?=
 =?utf-8?B?cElDZTQycC9qMFZRcHVmdkRMaFUzM3FsZmViT0dGNHFMVlNOYjAyak5qWU8y?=
 =?utf-8?B?RkEvV2luU0l5ckFOcUVJd0E2NWZvcVdFY3hpRGR5WCtvdjBpbDRPNXlyU2tS?=
 =?utf-8?B?VHVZSFYxUUx0NFplUEJLL3o5UStsSjl2QXA3Smc1eDlISjQ2YXdGSTJ2V3py?=
 =?utf-8?B?bW42UXZrZzd5TmFrWkhHeWhWaU1EV0RMV2F5TEFJUmZzdk1qaEw0RjB5M3B3?=
 =?utf-8?B?QytZQzdOUXNnanoycWFmb2ZRbzY2RHNzNDE2NlpUVHJwODFnTkJTQ2RzK0Fs?=
 =?utf-8?B?WkgzNnNsek1xYm9EVUcwbmlLWWNKdTB4cWhOcTVhZWdhcXEyb0tXelpzMFBv?=
 =?utf-8?B?Q0ZTYzkxSzNpSGJDQmNrb0VwdWZuaGgxRmF3UXhvNG8ycER3MGk4RWhER3FW?=
 =?utf-8?B?VmVTRXRvbGQvNm1aNHVOZkZSMG5jZlMvMUxYTEQvQ0tKNy91SjlmR29WZGNr?=
 =?utf-8?B?Sy83QUJyejl6cE1tbFJQd0l3bTNEbUx5bU1ZbjIwL0pzRlhsd3RqRWpLMWpE?=
 =?utf-8?B?YzlES3dCaVpaS0RZdnR1aVZ1bVpLZUxpb014RjhwcDlQemNIVkJCNzBNUW4x?=
 =?utf-8?Q?D0PKSX7AJnk9LDeHWgLN?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b7bb46-c4fe-41e4-e138-08dd4a8ff83f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:33:56.5179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0485
Received-SPF: pass client-ip=2a01:111:f403:2819::823;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
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

> On Tue, Feb 11, 2025 at 7:47=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.co=
m> wrote:
>> I would suggest to keep the "sysbus" prefix in the method name, or in
>> general, keep the class prefix in the method names in XXXClassMethods
>> traits. Otherwise APIs from different parent classes may also
>> conflict. As an example, in the following class hierarchy:
>>
>>   Object -> DeviceState -> PCIDevice -> PCIBridge -> ...
>>
>> For PCIDevice instances there is an API pci_device_reset(), and for
>> PCIBridge ones pci_bridge_reset(). Without class prefixes both will be
>> wrapped (as blanket impl in two traits) as reset() and a dev.reset()
>> call will lead to a "multiple applicable items in scope" build error.
>
> Yes, reset is definitely a problem.
>
> I will wrap qdev_realize() in DeviceMethods to check if you get
> "multiple applicable items" from that as well.
>
> I can also go back and add "sysbus_" in front of init_mmio, init_irq,
> etc.; but on the other hand we have Timer::{modify, delete} and
> DeviceMethods::init_{clock,qdev}_{in,out}, should they be changed as
> well? I'm not sure there is a single solution that always works.
>

The DeviceMethods::init_* wrappers may need a similar prefix for the
same reason, though it seems unlikely to suffer from such name
conflicts. Meanwhile, adding prefixes to timer::* seems redundant.

Essentially we want a naming convention that (1) avoids any potential
name conflicts, and (2) applies consistently to (ideally) all APIs. For
goal (1), we need something at API call sites that can resolve the
potential ambiguity. So instead of dev.realize(), we may write:

  a) dev.sysbus_realize()

  b) SysBusDeviceMethods::realize(&dev); dev.realize() is still ok if
     there is no ambiguity

  c) dev.as_ref::<SysBusDevice>().realize()

  (any more options?)

None looks perfect, unfortunately. Option (a) introduces inconsistent
naming conventions as mentioned earlier; (b) cannot prevent confusions
when a device has both a "reset()" method and "dev.reset()" calls; (c)
deviates from how wrappers are auto-delegated to child classes today and
is the longest to write.

Option (b) + a lint that warns same method names looks a good tradeoff
to me. I tried to find some clippy lints for that purpose, but have not
found any yet. A similar issue exists [1], but has been kept open for >6
years and is not exactly what we want.

[1] https://github.com/rust-lang/rust-clippy/issues/3117

--
Best Regards
Junjie Mao

>> I agree that uses of proc macros should be carefully evaluated to see if
>> they really help or hurt. In this specific case, I'm not sure if using
>> attributes solves the root cause, though.
>
> Yes, it doesn't help if you have multiple similarly-named methods
> across the "superclasses".
>
> Paolo

