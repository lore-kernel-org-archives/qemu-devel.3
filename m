Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ABED1712C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34jv-0003Yl-Ed; Mon, 21 Oct 2024 22:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34jt-0003Wo-PK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:35:17 -0400
Received: from mail-me3aus01olkn20826.outbound.protection.outlook.com
 ([2a01:111:f403:2818::826]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34jr-0003ZK-LK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btX58B4TArmb3Qqk5LrDROhixllKFNVOKhJvQamAaJyxOjvzOnmMSVuiLmdm/7g2/u8Yk0cxKAHibp6jah9yFQvkRehx61ibBrFxvW8NEIDe7xOoPw6hb+tt9D0Rdd5QaMbiTSsmNgksnZNQ/zQwQ1BNCYfCt3BEa6FCAJXxH/tLW3PEUemIuBHwY0xgs/0Wmg9yUOT4vATFaxmcn0FgChhBShB1V8ngX82BaI/DfW3ns3OPy+OIWKyGaJpsidJzo/V30nIymcm4OdrEXQnPCACZBHdEmdlf+d41FnI7ZiklmRmu9sCX4ZWiHi+E4uv62BnxxS1uqzQo4ABW+/ImVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=923smgUT/IEfUWG+hWsgvsV756q9rLZHIZbiCr2ccM4=;
 b=oYok3ckO8QkwBOP2JX8Nm0mqCKILEcLPNmREmMKJzt8Z45CegaZtu9xIVEi3ujveJeMCX0a0RcOoRBcWOESauglvxt3gPdPWxAeFYvMaaATuAsiR7U9G/vvUt3w9Nue7ni9Pz0qA+BzN4Nqb7Is8Z0TlRZ9rnD2z96P5M3ChoNpJ8ghf71GP0fQP+dI40jwZpXK+hLGRB/cbndFziNKpWZqmF6M28FX0Myck3NiE0zKhoYjE3gzbktlADPaJGV+bQZuknBtox+msXMOTw8qDnDi2kLVfW7mRsQLD2hT7tq5BJhnK1Jl6ICEXBzgaM9TKD12ghVR++8DAuC4ev8yohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=923smgUT/IEfUWG+hWsgvsV756q9rLZHIZbiCr2ccM4=;
 b=j8g12IGQDvorAsLbAjUKyRpMkiWLreEQ/KrzNNORYSqtAQon915BO5d9kmQFmoh3zLDcV0ybLmBot7jHDPjDVabS5gyFf0oczm+d2qfWYugDNpo67qQLJh0SpTGSisP1/+H9QsUrQnWzrjY8J6qku8XSHJkR6CcP+DwL5qxWxUk36fnFY1FPRola9a6l4G2kmvGyWyXaFtFGEqnQoz7ui3R/VAs0WFW4o0iwlsJDftsngnaAup8rTTq6gDUEte8X6qQoZGge/8UZI5CmByt6iqC2uqNYa8dzIjMA62TmMZCFD1U0aydWhd+658zyTjCLAs2R4xHWQucVCs2stLhiQw==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY2PPF1D93025A7.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::389) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 02:35:08 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 02:35:08 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-4-pbonzini@redhat.com> <ZxX1jSkJ3Muk11zC@intel.com>
 <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
Date: Tue, 22 Oct 2024 10:22:51 +0800
In-reply-to: <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
Message-ID: <ME0P300MB10407A693663615D8AD3F507954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87iktksw4t.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY2PPF1D93025A7:EE_
X-MS-Office365-Filtering-Correlation-Id: 80613e7e-2ea0-48a6-b92b-08dcf2422521
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|19110799003|6090799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: jzc+l/2XBzUMoh0vmRIbMpkCcxC/PIK4oedITXuBBmBHtzfUryvsWkP/+7FCV4gnxcsSzo5Yzv3Ru75erT0bB/4ze5WN0Q1EqtLgScgkM7yXGp9XBR96EJaDtPraogXn1m1z/wevgYZCC3iRtv1O8rx8gbW5pM6u8iptdCDok52H4vl2wZ683ZmiIFPsfNDX374NfcENgHHHjEBqhHJKQDoFTL1hE0Le7k2UI5eVhmrEfNlmoQPyE0SlN8VODGXDvhJwHGRnxmj1w/JVgpOIixHLcgQ4Xo8TSuFNOvu1yFZhdxzvsqMO3jLrriUY8b+np9gm2w7UwekS6P2d1vps9tDRvz49/liQeWBDzbp6zb+/mn4Pd+595RvU6biSCt2A5ofpZWDrRBbH/MB7gylCZSmsg2jLO5sxW/eYLpgdk45Jgwa+ZrcUW8XypnGkP/yL1QuW5H73F7l0E0xkmTmo6PaL/MgxmBhmsztzQASW2U4+4CfFC4j4sGABwpD1+tK0X0/I8tNYSX+IiYwUCAElM8dg1ZSd4JyYXie3b2GeZmzyooCQq0PgWtUDQE3KMSU8smt3jO80zdy+S8Ao54OnC+C2h+qDsBaW3Ir0v45A6dtBqdXfYvFmB250QTCKJJ6sm7T2ntuqAvNRyvUfKpSNuG2psjFKhwVrmxIbGHn4rw6RCKcysD2GR1Ueu+WUkIk4mU18jujAyCDxfPPHIWcT0kTGPGY+bnGED2Jo0vcewQ4bxwZqiCLbtlPkBfgQ2Ztau+ph4rCoGNWtoMFL17Q3dA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndTdDg1VS9lTTNZbmdzVWhPSWZkTkdPU2p3ME5SZGU3cHJBM0kvUk9HZnJ6?=
 =?utf-8?B?WmNTMGhzMDB6aXlOUlJTSm93aWh2U2I2Q3dUK2dlUC9UdFZnZFh6Mks0bXFq?=
 =?utf-8?B?Z0tXYVR4Rzlvcjc0bmtrZDZ4eit3YnY4eWtmbFZ2dUw0VEltSDY2aEpUL1hO?=
 =?utf-8?B?SFc0cWhwZ2ZtTlZuZE5KSVo2Z0F3RFEvWDNKUnQ4dkhXMThpMVlJTDFNUEEw?=
 =?utf-8?B?d1podWhUaVNNTDA4bVBuZGtMVkkrbkNlOWNJN2JJdmNzRHl4NHNhVEhBSW95?=
 =?utf-8?B?V2NuTTYrMnBQVmhjb21adGk3SjJQanVSWm9YREFwWWg2Uk1INmk1VlNkRHJX?=
 =?utf-8?B?d0ZJUVRKOG9xTCs5WnNkTEpWZFY3ajhOM05KR2VtRUNRaFRyR1hlY1lGb242?=
 =?utf-8?B?cXNRdzk0V2w1MytwU0pnMElacUlGMWxjTWdXSEtpZGNtZEtIcDhXRXhPNUxY?=
 =?utf-8?B?TnlYTGgvVFdIUy9zQjN2b0lNd0pOSUlZdnA5THAxNURlTTRBZ3dMTmU5RVEx?=
 =?utf-8?B?UFRad2srUFUwTE42K3c3VjYzZ3k2Q0FiMVFkMWtTTkJrQXU1MWtvditNSWMy?=
 =?utf-8?B?Q2U0c1o5aWdCdndEQVdjQXgwdkhQeWZCZzF2VVl3WjZTUFlxSWg1eHl5UXYv?=
 =?utf-8?B?L1ZSMGkybWVPNzFmNnp3dzcvQjhLbTFIeTlvemh2d0dHL3lzVVJwdEsyWksx?=
 =?utf-8?B?UmJKenFnN3YzRDRzcEdCNVZmeTdSeHpnblZ0TVVpUXExcERaT3Npem1MS0Q2?=
 =?utf-8?B?ZDJySjBNMTQ0UEZtSUFTWGZzOHF0N0tRTEhLWFBwZEpTV1hyOHlxdTlpaW51?=
 =?utf-8?B?aWVBQURRRFl2U3pjMEdBYmo5cVRoT3MxL3VLM1VzeHBiaG5NVHVBZVJoYkxy?=
 =?utf-8?B?NlcydGMxblB2c0EvMWN6dWZSVVQxUEVQMXFSV1FtOThjMDJHUzdkWlB2WUM0?=
 =?utf-8?B?TUtybmJ1aFF3SGMvNXRpTHZlY3BTQXA4eUxOMUJ5OWMzeVNwU3FSWHFKc1lR?=
 =?utf-8?B?ZE5ESEtQbmZZL3hscVo4N1VlbEVqVysyaFd4aUxyS3hGYmJXS0hiZXVwa0tQ?=
 =?utf-8?B?dUt5Z0FQbjh5V1A2aXl3U0FUUEVPZFVlc2p4WDl0dXNrSHMyOTk4R29wczJp?=
 =?utf-8?B?RXMwc3AxNzV2cUZUR1ozSlkzUVRkaWY3bytUM0JPT2YySlBCVCt5eDJ3bms5?=
 =?utf-8?B?TVZ6aXkxS3BjWFNGL3UxVW42VUczNmZIaWZqSms4a3R6QXUyZGQvL0tRN2JC?=
 =?utf-8?B?d25MUnE2a3ZMNFV3cGNvaHRsTno2NDdhNkZyWWFKRWQzZW5DeWszazZ0QnFx?=
 =?utf-8?B?ME91dEhzd2ZOVGZ2M2plSi9qU29FSVRmTHdlWnJjRnlkOHkwWFI4TDJ1cU9Y?=
 =?utf-8?B?RDVRK3JSalVJZUt0RVlnQUhkS1RNZmcrSEpWcHFOV0hSbGpIZGtyWTVicmxt?=
 =?utf-8?B?TzV4NmdoTWFwejVlSXRZVnJBMlpaNzN3TG91SENUY1hqWmNzSlFDaEpkaUph?=
 =?utf-8?B?czNZQTNIZnhxZWkyU0VVMStoVnJUZ1RINkZTUUIwT09uRHBRemg3NmxrK1ZK?=
 =?utf-8?B?cHlPZzI4aUlrVmw3MlBQV2Q3SXl3UStxL2c1N1F5QXQ1Mnd6ZlVFNDk5azNN?=
 =?utf-8?Q?8FQfYRF6l+vMqZ47JgS0TCxw7Po9oBkMFtYDtnOxrrw0=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 80613e7e-2ea0-48a6-b92b-08dcf2422521
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:35:08.7588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF1D93025A7
Received-SPF: pass client-ip=2a01:111:f403:2818::826;
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

> On Mon, Oct 21, 2024 at 8:16=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wr=
ote:
>> unsafe_op_in_unsafe_fn is allowed in
>> rust/qemu-api/src/lib.rs. So should we wrap the bindings in a separate
>> lib (similar to the rust/bindings in the Linux kernel)?
>>
>> This way, the special lint settings can be applied only to the binding
>> files, while the default lint checks can cover the other user
>> development code.
>>
>> In addition, another thing that confuses me is why bindgen still
>> generates code that does not follow the unsafe_op_in_unsafe_fn
>> requirement. It seems that bindgen has supported unsafe_op_in_unsafe_fn
>> since v0.62 [1, 2], but binding code we generated still violates
>> unsafe_op_in_unsafe_fn. Is this a bug of bindgen?
>
> The plan is to support older versions of bindgen (0.60.x) as long as
> Debian has them. One possibility to fix this is, as you said, to use a
> completely separate crate. Another is to add #![allow()] to just the
> bindings module, for example by changing bindgen.rs to
>
> #![allow(...)]
> include!("bindgen.rs.inc")
>
> This is related to the fact that we don't have yet a good way to run
> "clippy", because "cargo clippy" needs the bindgen.rs file. So we
> should probably look at these issues at once.
>
> Paolo

Since meson 0.6.0 clippy-driver can be used as a wrapper of rustc. So we
can run clippy by:

   mkdir build.clippy && cd build.clippy
   RUSTC=3Dclippy-driver ../configure --enable-rust ...
   ninja librust_x86_64_softmmu.a

--
Best Regards
Junjie Mao

