Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CEFCEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 03:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su1Rj-0006GL-Rq; Thu, 26 Sep 2024 23:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1su1Rh-0006Fq-2R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:15:05 -0400
Received: from mail-sy4aus01olkn2030.outbound.protection.outlook.com
 ([40.92.62.30] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1su1Rf-0000RP-8N
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0siRYAS44VxJsquMWCCGr0mAgOya65Q9L9pYYdl+613IJgSRcCkFnAQrRjC9cR4QXuwm4Nb9aZg8g6K6PxYCHvdpX0ELOrrupoyqGwIrRYv84TrhTg5+KNGmQwWt6J0liApyzmqJEgr/XHm87sflkPUC25jWYyh6PXQdSFSE8stomj74zYnXMRMLdGYWJ+gFMqy1M+kpQ/+vz3LLV2jVaUCla0RKV5uHd4sMI/GUkEW9ooK0LtY8zEninsJ6jVfGsKY1kIilG3LligWiSpUMngDujx1fgM/xgoTqLZbdgpW5yG9k7NPWbzsW3Ej48/LfhNyhsCmnZ8+YFssQPINWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwJnsc1jebWdZDRmsjvv0JQ4LL6OJsr8jh55gFHzXVg=;
 b=tKr0ZB5gFoCfBHZ+36CmDZzotlQg8B/hZTlQqr/hfyM/7+LJkYWsQz51SFFDWMkSmKSW0TyayWu9ri5X9ekLmmk5XN41LePSvSJSxjh1Zv1dXWRqdYeaQiE1yhz4zeLqqQibXl/23GO/Ge+7biLTrV0rBzNsVlbwVcFThpOumv09KHUuDBg1AFBM190f+U8Kd/327Stl9/0koHHyZNotf4ailshuvOs90v0qr/BP27fIBrsU23a0KmRrGhiiJUI65D8OuCC86TJOAe6VuiH5cP8/k3etV5HBW35A5brVjG+or1M1Lqm2yMX9TRqmEeaCZDfmVsiDv62pdDRu19Ezww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwJnsc1jebWdZDRmsjvv0JQ4LL6OJsr8jh55gFHzXVg=;
 b=bOnyj9GBgQ+9LFNRmccRL0vMae8sHcfhFuPdePQ/P/Wa7eldEwxIZTog6IIXbZYcyUoweabcW67gRZ99HY06jRwWRqAVa1h80/NOJj2v00eaTywW476uAx5/ROQR0zsxilCGAhLsumsNW+O973ToM7qB1StK6+1+hVIq2qkaK6mh0fT9ar5c52s0GjC9VaRMAE06wQD+xvOWN0t3RfiJVt9YjVQBp7hJdBqtsvct4C7fOeunqCt4gtGkOFRMrq149onyUrSKe6Xash1TwGS7/wFP8WUfoY5We5id1wf1gpR0QbgwXP0tfLvBPViF3W8zISE+pZo0EMyG29szmppkKg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0338.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:284::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 03:09:48 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 03:09:48 +0000
References: <871q16fq9c.fsf@draig.linaro.org>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Hanna Reitz
 <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, Michael Tokarev <mjt@tls.msk.ru>,
 ncopa@alpinelinux.org, bofh@freebsd.org, emulation@freebsd.org,
 virtualization@gentoo.org, dilfridge@gentoo.org, hi@alyssa.is,
 edolstra+nixpkgs@gmail.com, brad@comstyle.com, =?utf-8?Q?Daniel_P_=2E_Ber?=
 =?utf-8?Q?rang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
Date: Fri, 27 Sep 2024 10:06:12 +0800
In-reply-to: <871q16fq9c.fsf@draig.linaro.org>
Message-ID: <SY0P300MB102643DC7E0298E93085BC6F956B2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ikuheqs2.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0338:EE_
X-MS-Office365-Filtering-Correlation-Id: 58112fbf-f98b-4740-2f9a-08dcdea1d847
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|7092599003|19110799003|15080799006|8060799006|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: YfWXWfZAM/ypHln1bxe/YXIS5DnA7Tk+pnbnC5qF75pkVAXb1JjEDdleCznSymJRZqzhW6nu7zpWLlhKSHQg9KTHatvfi6q5di/6BaDV3yb8RK6dw2OizxVnKyu65iUHD6qMV5l+k5H22FpeO3JMN5TqX9ewTkxY/1TxH24DstgbujvNXoXEoxzwnz25ohPsmHVj39n1WbPUsqPM11A1EmSSAiKdOKD9bpRG8zdwiPLfiRMYDVvs5J8IOuokG2XmV9ZIch5Rz0rFsra5pnLoHBTiSVSfmfPGrXkgKpUex4q+ECYCfh41MmoMH9xEsWW0aL8jJylOTKNv5fPeUMUp2QT5xk59+ax+nB1kUiggxOK9LT71JHTth4XlWwQnne8txqXFijnIsRIVUPnntTa3FD7/UBKffPhnWJhEyEOx0qmC784Qz6cPAzdAwpTyIYFj4BURctSKTbhcDa2Az/Qz/UYf/w2fi795PLdeVCqQvR14sWZHeR3D62GohtmIRv4BKxxFZb/5442cblLb8Rsz8bFDEUXuWkIP3aDsDIUSzyBi0bq91pWyANHRaDiE0iL4RE+v8rQ/Hs7L0vPkfFdU8DbIxc4AxBGyNCwtnflGKAPgrFL+AFYpodfEj8UXUBuWjWx7XL3iHUuI3RG4TJ705QmQfRlIzxfnfVzXnoh48Zafi0/Idp0/OXVE3g2+6W5T1xGgu3CEBvpmMaWK1emLNlWfyiLhCwI3TBsclSb2CKvmHYmfSskIS0IGxEEZ4Y4f7Fz5gm/DXvw5JgzTKfDMoA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTd4MFVlMDRIUkNxRUFkRDJ3eTFkdk1HWVZnSjJTUDJmQ0VyZGxGR2pLNHpF?=
 =?utf-8?B?Q1Q4aWJMcjI5RW5seHVFQW5hamsrNEorNmFoTUs0RFkxR0R5Wi9QeXBpbWRz?=
 =?utf-8?B?TFFUejc1elgxa0VzMFlGT2ZENmZMdWp6WjA5Y2VYeG1vZHhNZEU1UUwyWExX?=
 =?utf-8?B?cnVZOXZyTXZySGRmeFg4bzJ3Nmg1Tm0xZEtpM3JDQlJZRHhLSFhhUjh4ZFlr?=
 =?utf-8?B?MlBka1k3c0JOeE9vSEliZUJNQkhQbFI5RVoxTnlBeUF6VHNXT3pVeWpIM25z?=
 =?utf-8?B?VWRwVEpicWJyeEJRVTY2ZE12TXpudUlaRm9GUE1LVFY4a2ozUjJiN0dORmwv?=
 =?utf-8?B?QmtkRzhFdldPcjgwTWhhZGdPNExoQkdqMXpzS3BwczNBSjg4cThySE16SjBs?=
 =?utf-8?B?a2ZxYjJYRk8zdXlyckVQOFlOSW5EN3lUR2VPS2svNnhxZHdvYUl4TU9MWjMr?=
 =?utf-8?B?bGM1M29aT1hGVHlqNVpKKzZ0TXFodnhMZmw1QTVuNFhZNlRoVnlqZ3hLQmJk?=
 =?utf-8?B?SW1RU1hMbXR2Ynlhejh6L3RRb1BxUkMxaTZaeHdQWnZiMXZxSXh1dVAyS0tW?=
 =?utf-8?B?Tjh4QTZ2ZUxjYUY0YnlIMG9IbDVjN01VRFVLaW5OMjIzckVwOHNESVBQcUhF?=
 =?utf-8?B?bkVleXFHdFBhYjZ6eVJldzVDcVpsVUdrK3ZqRlYrd2NFcmpVKytYclR5WkJ3?=
 =?utf-8?B?M3c1S1JPRU5MeUJFNWZOdVB1ZWF5cVRHRStteDVSdUg1cWRvR1NCTUxJMThD?=
 =?utf-8?B?QUhIMlk4WEZKM2hJWWNhcm52dWRHN29lZ3g2Y0V0ZUZTZGJPVUNHOUIyZ0sr?=
 =?utf-8?B?QXNVZDEydFp3NzVOQS9PeEUveXJ1akF4M2ZONUZLSmRvTWppdEFmZWlHbnhP?=
 =?utf-8?B?OVl2dGRWK2RZc3A2OEF4dVpBb0RSNWIwbkppSDAyRUp2dkt4Z2hUSDFwSVhz?=
 =?utf-8?B?UDAxTTZQQVdtMUlneGdZK3NEb0QrMmpPcDhlMTBEUzUyZFMzM0NLQnFrZ0Ro?=
 =?utf-8?B?YkkzN2Qvb1JjQmU3Y2dzc1NQKzJuMmZ3cjFJYStTUmZNSC96VVJlcnZkVFBk?=
 =?utf-8?B?MEd0Y2pkSXMrR3dzb3Y3SzE5enoxVDlNSmJYaStVSmRZNC9nV0t2VVBlZTJz?=
 =?utf-8?B?cWtlVHkxeGZaNTl5TFJJVVNmM08yU2V4eGRQOSszZ3BtS0J4dlFaYk55Uisy?=
 =?utf-8?B?Z2FMYlBtOW9Fd0tCMGtGTlU3aGtBTEk2ZDBoL0VmMzcvM0hES2s1dTMwaDBX?=
 =?utf-8?B?U3NreitxSkxzemtRUDdWM1NLTXB3YjV2S3cybW1lUEIxYkJ1K3NEREdSaEt3?=
 =?utf-8?B?NXVFcFBFaTkvei9oMERFZDRlNjV4Rlp6SmUxWnFySGdxVitRWkdRV29EZjlG?=
 =?utf-8?B?ZDdHOU12ZXhiOXNNZXZlSFMyVTZISExFUnJ4amdyeUt5U2ljakl4TTlyMDlD?=
 =?utf-8?B?WStKYzQ2Si9zWWsxaDh6bzgrSitNSDhFWFIzMEFoSW9nUDNVdGh6dWNSd2RJ?=
 =?utf-8?B?RHdIWktMY1ZFRTNpaUFNSE9ZaGVuSEQ5aEUxV0dOOTRBUnJTSThIMUFuT3d4?=
 =?utf-8?B?c3BkQVdCdkh4dld1N3FOa2dJcGhISFRJL1Y2dTZkd3FKc0xXaisycloyRzlK?=
 =?utf-8?Q?zxNo+T4rU8f18xcC07JVyHL12GxdNu+aGMX9HcslI4aI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 58112fbf-f98b-4740-2f9a-08dcdea1d847
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 03:09:48.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0338
Received-SPF: pass client-ip=40.92.62.30; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

[snip]

>
> Another potential area for conversion was the VirtIO device and
> vhost-user code which could expect to re-use a lot of the crates from
> the rust-vmm project. However this did bring up the point of maintainer
> buy in. Stefan brought up the example of the simpletrace rewrite which
> while it may have brought some advantages he felt he was unable to take
> as a maintainer as he was not familiar with Rust at that point.

I'm especially interested in how QEMU can leverage the rust-vmm project,
though to what extent that is beneficial for QEMU is yet to be discussed:

a. An increasing number of virtio device types are being developed in
the vhost-device crate which is expected to be reused by monolithic
VMMs. However, QEMU can already talk to those backends via the
vhost-user protocol. I'm not sure if it is necessary to go one step
further by integrating those backends into the QEMU binary. One benefit
in my mind is to keep VGA compatibility (which virito-gpu via vhost-user
does not provide), but that may not seem to be that significant.

b. Concerning the virtio basic facilities (virtqueues, config space,
etc.) and the vhost-user protocol, QEMU already has an implementation
that has been tested for years. As Daneil has pointed out, replacing
them with rust-vmm components puts risks QEMU's short/mid-term quality.

Comments on this from the community, esp. the maintainers, are extremely
valuable and highly appreciated.

>
> Developer Expertise and Language policies
> -----------------------------------------
>
[snip]
>
> How will this affect QEMU's declared security boundaries? Do we need to
> develop a policy on the use of unsafe{} sections in the code and how we
> interact with the wider C code?

+1 for a policy on unsafe code in Rust because inapproriate use of
unsafe code can put Rust's safety guarantees in vain.

Especially for unsafe functions or traits, their extra safety conditions
shall be stated in the code so that their users are aware of them and
can check if such conditions are met in their context. That also makes
any change to those safety conditions explicit.

>
> One of the promises of Rust is its support for inline unit test
> integration although there was a little confusion about how this works
> in practice. Are separate test binaries created with just the code under
> test or is there a unit testable build of QEMU itself? Does this still
> work with mixed C and Rust code?

My experience with Rust unit testing is that cargo generate a separate
executable that links the crate under test, dependencies of that crate
and a test driver. In that sense, I don't think mixed C/Rust code can be
unit-tested in the current draft of Rust enabling where the C and Rust
code are separately built into libraries and finally linked together.

--
Best Regards
Junjie Mao

