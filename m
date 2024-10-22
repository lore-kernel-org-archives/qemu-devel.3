Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB9D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t355u-0000Lb-S8; Mon, 21 Oct 2024 22:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t355t-0000LI-0d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:58:01 -0400
Received: from mail-me3aus01olkn2080b.outbound.protection.outlook.com
 ([2a01:111:f403:2818::80b]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t355q-0005PN-Ng
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvlyLLWYMezn0iri569xnIjrQmkrgJVF97nhramwbdFk/DKQN8VQ7IFcFWFKwghp6mxEhmtbSpWaeYrqshZN/CuLisdHATEQ+7FVCwV3Ft6Nlsu1swigAPg1H26PyJqMJeQSxJddb9X+XV9qRjbo0mAR4xgSRRymcDt09Iq8r9BpmJAZqLwBLNtpxOef2QlOkHb6R+Qc3Qvtv45KfShv13xSepAewVg1xhMSUS5+N+6FiKA5XDyla48jrEscClq9zO2GmtaYcUgBIlBSPIaLqpnyrSHnwO180PIHeizpIbJ7iC9kH1KixZRXkj0z1P6Dz2QmwNikZqJvzlNCrlKtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPjOJbXCl/V86HaQ+kca1aUSlmTauH4284EZXfJk3II=;
 b=viC/JXMfpt3NUkj67hiOjfCeGIOjphTGEFUxMk5w9KQDOLMD1ea/RRNGnefNWAwLFnsXHGqhqZjTYbAq2hUKtOXKUS3VbtXutn4/XtpuGahJDeH6saCtDCTGa+FkpWo383TOMdsIdDX5U2qG3+TKAfhskgvwS0pRqrypjyGX5uKKoDQUwOEnA9f8MVN9nQtopaYy5RhhT6ODs374QvhiROOjE2/VNMoik+oA9fgICBgXwMDz3IDiFyUY4GMc2x30qGMbFaaKqtXJBJDh/4ODkwoEC2sttK5bn5K7bEpw5uMyvK5JnY8zzZteSlHDSpzwPO7m1KbjrtisI0kUsHY/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPjOJbXCl/V86HaQ+kca1aUSlmTauH4284EZXfJk3II=;
 b=HX5icgZp4va08mOE+T7HWP60pQo4laOf6ckWgMTFX2fn6f9TWcbORwXUfSxGfE80FZ8t2+LhOuqON7A7LRjyjgor4cqHgjJe9Apiai3sZJ9VejHLuIat7L4KZu2pv6F84YE3RWZbn4fJiJMFG8cxGeN+3UEFwR6qOZ4D6vI/p0aEi2D+ljGDCthj9Z1AxO97uRKbbsvLh0oYDnMAj60o/07+3xP80cRSXgns6aDnp84CwSwMi2YkQOSg+6O7uAKvJ8AHIGhxQV5d1QNSfvQuIuyGo7gDQDcKNCaZuDaNPnqsmqIDYlNwZ/XcI4BQZwq0i0U7djvbls7oGI3fbga6fg==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by ME0P300MB1456.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 22 Oct
 2024 02:57:53 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 02:57:53 +0000
References: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <5db62c58-b6e3-4f83-9954-ff2bcb1108bc@redhat.com>
 <SY0P300MB10261816C21DC5FCC6D39F6295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZWHKvGFRhfUHoCVeqB1bH=ui6x3rORYXH8WsE905=eLw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] rust: introduce alternative implementation of offset_of!
Date: Tue, 22 Oct 2024 10:39:26 +0800
In-reply-to: <CABgObfZWHKvGFRhfUHoCVeqB1bH=ui6x3rORYXH8WsE905=eLw@mail.gmail.com>
Message-ID: <ME0P300MB1040E6BDA927461C0CEE255F954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <8734kosv2w.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|ME0P300MB1456:EE_
X-MS-Office365-Filtering-Correlation-Id: c021033f-10c0-4123-271d-08dcf24552b4
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|461199028|8060799006|15080799006|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: Yy2C6wx1cPSBFTFwIFKIxtjbsNZBdB8hi+HQwvCqkLMunodJR8ARNhWAVzoXpz2/R9eAFvAuv37RWVyn8e8mvtKf0z/pCyD6sOXdLYRYlebiqmSxNaSssD85dYs3hLm/PiKqjjElcuXdxekbZ66/szcoWEDUyTVR2ADnfAoSt6PqElCOOH6rHMaCADZnrae2vsSNbxCGtMkqbyJXjHAoJEfAptlks1r6HlA3HF2oV727Tp9Unb5ih36lj06ORhf9/VAcRVx5p6nOR6ERnH2EXMT7i9E6bvtrCH9XBzESCrb2jS8gnbTIuZOkxlPBCrRasPVf1Fl+l0HKzsV0i3buULLyiifAUN0bM93iax3/tzLMGtzBHAi/WXjHM+qzhyWbPrZDNr5lob7todXBUd0miZB66TVGgT50eLCJBWs6xJuxUUWViV7A7rqoLpk5PtxtdSnitRKKTWuWq7ItQ/AyF6HFQSa7Dh67KIs3IYE9lmqogkIW2cnb+uKfIHZSNExpxi/9Ah0HSy2QJ3zaifU0U5YMJLHIPx3kLHYLm59/pYj2dF2xZK68SdOIv2Rz4k6bD+a1kdByoS3lkJ3thJFEErrYRkPt3CCNn7W136wvLzqMrCpoyjONR41qz3lYR0cWo5XuDWuw+ooUSXFGwWLdpBt1PKXik9L0arNYoNfsO2QTLvjgdvVhJ3F5XjSXqYMuRKRY/wnPOXntf42+4FvlB2NfnXWwjLhh+ccV7YAfZ30=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmVY+EC4HP/JK4fWtfSp65evncIivL8nwbRnqF61ZhJEKCYllWYmfBjfeA71?=
 =?us-ascii?Q?6RIoCxshzH4V15C8G0fOFFUA3xBK+mpmnwvY1LNYlvcMfQAq+aNHx7S1stOp?=
 =?us-ascii?Q?vAb623+g6Ji9MKlCjR0MAuntVUpUQqNDLtjzEBzR5zW7QHf/V1n4uj1ms8LS?=
 =?us-ascii?Q?0U8kDRYXeFG8nPNPn5JsIeZkrd+K6MNfLsmUZKPNoSEtpeTG6Xmyl1O8PWbV?=
 =?us-ascii?Q?g8hFlALbVTw1ZzhZOceMY21b/PNLKWDeBI2nfRQ7cL3x67IQcS9Q1FyhuV49?=
 =?us-ascii?Q?9aeYnG5+C2vA2sme4iYPby8p87q0u8AVh2UDb4qY20PZ0UjBvQTUzCJKwEhC?=
 =?us-ascii?Q?FpUsC4c3fMGf2u27FWvmW+hUhihtjS67ZS/JNd0a2Vqsq/PiceqfKS/TSmxb?=
 =?us-ascii?Q?4kBlLPfvmfpUdR4z9+RhTrSmH4ppRhqdA3yttoOj92Lu0YS6UkW8Y/HXZxOC?=
 =?us-ascii?Q?GvLme7rm88l3ITVllgwwTFguk46Zkvf9r018rPuTlwvGgIKnJP02NTaz4trS?=
 =?us-ascii?Q?fFaeaps7begDKSD8RQvgXtKfUunxulxHdxOlI8tPH/IYiIbETN8KkgV57+fN?=
 =?us-ascii?Q?7N+5RLCxVVoQWH/xNXSiC4txKQDN6S3Z0SaH5r2OjnwUAOv0Mj7QOkx1D1Gu?=
 =?us-ascii?Q?RTZb8k2zJpDXWlzogwT2o/AqjiMSoW5LCYL8UbzvYOGqmKER5PTYv3OcEg9W?=
 =?us-ascii?Q?g+xNCpSxNvK8JlAXPu5wcC1+BotQVz7KjlkUta1Lyp/eQUaXJVu7iNVfF1Cz?=
 =?us-ascii?Q?cLwjaoulyszcoigOV0q/LJ4jK/ajBjBfKE02dEaYeJQhELOS3X9kVbJR+YXB?=
 =?us-ascii?Q?SPJsmqFKHmmbEqteP8R0h2QEYq7woF4yI5toH9jLjCMVyklpZKUg+r1Y5j/p?=
 =?us-ascii?Q?Vpvq90BR4/xLhUFrkX2CyHCmSz8ici5IsEz/+MyLg03cw8U9xsnaEikiM0B1?=
 =?us-ascii?Q?GBu114+JbLGpMw6SrbfYIpY1bU4mGKwL6aC5Zq6bpl1acH05QXbWgW5FGbay?=
 =?us-ascii?Q?kVxWQ6xSV+gp9MGHIhvTP6o6gpviApFrKBRSZmQVwV5oCHu0bql0WIFDhp9w?=
 =?us-ascii?Q?DwEYw9lNgQUn+ZBp/FaDIf4kpdcM6nXWgoQZmWE5ox+iq3LPJXEcSjHO2Vh1?=
 =?us-ascii?Q?yMSKD2ARr6VhV4x8LCWVS2J7Jmxcx+3ZaYqtl00BgEsY9mAYla9pqWTXdRIV?=
 =?us-ascii?Q?1mSyg94QkM7T1pIaPhRWflYB1ZZIzT+naqlCK1vTQ4E1SsqVL19kZhnD0fo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c021033f-10c0-4123-271d-08dcf24552b4
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:57:53.5834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1456
Received-SPF: pass client-ip=2a01:111:f403:2818::80b;
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

> Il lun 21 ott 2024, 09:24 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  > Thanks.  I still prefer to keep the procedural macro code minimal, and have the
>  > code generation in a separate macro, but this is a nice start!
>  >
>
>  I'm not sure if I get your point right.
>
>  My understanding is that preferring minimizing proc macros is because
>  they generate a big, arbitrary block of code that is hard to read and
>  debug directly (which requires cargo expand the whole crate). That is
>  thus more error-prone and makes maintenance harder.
>
>  As for having "the code generation in a separate macro", are you
>  referring to `macro_rules!`?
>
> Yes, keeping the generation of the impl block in with_offsets!. Then you can get the best of both worlds in my opinion, for example the #[repr(C)] check is more robust in the procedural macro.

Got it. Will try that approach in v2.

>
>  Sure. Will use quote_spanned! here and make reported errors being a
>  tuple of error msg and span to use.
>
> If it's okay for you let's first get the fixes in, and then I can repost the MSRV series and include your procedural macro and unit tests.

The v2 fixes look good to me overall. Thanks!

--
Best Regards
Junjie Mao

