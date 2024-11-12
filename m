Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C32D41D55
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 05:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAjqA-0000av-Vv; Tue, 12 Nov 2024 00:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAjq8-0000aR-P7; Tue, 12 Nov 2024 00:53:24 -0500
Received: from mail-me3aus01olkn20804.outbound.protection.outlook.com
 ([2a01:111:f403:2818::804]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAjq7-0006m3-5g; Tue, 12 Nov 2024 00:53:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzvej4zAsVq7605krPUzgJq8ARFjcrI7FjyPNyk6NkGWwwaXOgDyqRo+lt3yge7M1/HQebJ3c3YPuV/nYTkdz8xiuPr6RlETlmB+t3JWYAyrV5HJwbGrMsIXc7FUXUmFp1C9U9fSVyeBaDU9EAv/4UFGDjh0ZgWVJdclpEAR9gK1Y2/g3zekH050AmeOyEgcI7lgurQnirw137UWJZ4cVF657L1jPZG8wc2Isohte+JQBx4rky1D2w2UdhQ+thbK++DbdGnLy2Zm+1yG1ieAz0WwRFHEyqB74zY1srKIGvcl3f3Mum88xo0ytHZ9UuzId/vW8QEbsci04qy/IiAZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVzPCJgY/aI2wdVA/ID+X+j94mdD0YA8euGG+sKKwak=;
 b=HFG4XI/ZALE/H29IdL+UpbLiwsXgszpeo2jlgb7LJOx9BBJrLnxmumCXckOikH7gee/HrmQpoV0S43GAKAvHRXw+rjSbcr91kv1dwtJ6K807j8pn9SCEeoE5LDcSmfBOV4HXh3JAMkBPI7zqWTZySNwDPkn9YXv0vhW3IRwOK5vi6C6OIDtgfNFP4K91ihh8a1jBqv1fCtn5cKZTbv7hVU7/haFl/CdPOWicMTSw7XVhOvfTUGJGYgE6fjkqxYTldig3GR4D+lLEJBf3Iz3jT3Q0mIzH21z2UTeoouAW90zxnhN9oa1dVJ2XfXZUyfENIyA4nF26AHgqz6PTDU7E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVzPCJgY/aI2wdVA/ID+X+j94mdD0YA8euGG+sKKwak=;
 b=koXoaOJF741vuSxTFh/dl6iB0k+RJjJiZj5cAznfbs0jNE3+IriWeMO9Xtp6n7+OOEthtscQMQ/07qkSRFo5KwnzqKipIAaK6XWNOsZKaAzkpsmMO+6y2TVsmMlYbuFEECST93TktDCJpdEEVJOY+gqE4clZspZ+THYdshS5Lh5D1LHfDmCe/3Q1wdMctWIl/MH8OYmWemKpL9/NM3KBrvY2mkIijAJauOEyhdHvmoh5X4hL+NkOxPbFxIW0xKJQui6VhakVodtTA+jz5lBw0mHHcQblc4yx+PDSd+0SmdgE9+g2QT1OjDtPLJV8K82J+b5ZuQlb0wRyWp6mw2WVdg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0369.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 05:53:16 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 05:53:16 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-6-pbonzini@redhat.com>
 <SY0P300MB1026324D1571BBD2E001536695592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZUURf_QpdtqzmGF567Uk8obxdQ1P_WeVN1Ag=uG+J46A@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>, "Wolf, Kevin" <kwolf@redhat.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 05/11] rust: cargo: store desired warning levels in
 workspace Cargo.toml
Date: Tue, 12 Nov 2024 13:40:40 +0800
In-reply-to: <CABgObfZUURf_QpdtqzmGF567Uk8obxdQ1P_WeVN1Ag=uG+J46A@mail.gmail.com>
Message-ID: <SY0P300MB10268C2412B6F11B1876B1A495592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <875xothubk.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0369:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c2876a-2fdd-472b-0487-08dd02de4d2a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|8060799006|461199028|19110799003|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?taQla5LYX9ChPltFpCQCbqP3Q1CBS7YBRf8yLXDkNjPYrA4eS0mZ0nUK1A7m?=
 =?us-ascii?Q?RIVFr7spXGc83UosX4SjX1LTKfiXNcAgksmxjfaTzebXBReHRwtnbZXFcV54?=
 =?us-ascii?Q?RCjhU/iaIpZrJiK26ZYNW6Ij/vFh/HAeAQ2RKGzTUKuIYFMYxZVEsMUnf4Jc?=
 =?us-ascii?Q?KuszZc5cDQmaviXOligwWLiIesk2Im8PiNkqRE3MCxlSyZhMhc5b5YO4dGEJ?=
 =?us-ascii?Q?XsWyKI2e1hhC6znbI3iE+fuPS0LidxOLq2iMPrf4hg7Xj4PAq5cTcpAV5Jww?=
 =?us-ascii?Q?BUOD5eUjBl6JHR7j+9a7nCdeLo4mULJMfFm2yR3ZNOx6XVT44DubIsF8Oiky?=
 =?us-ascii?Q?DlZxe0XzUmlW4qElM5PEP9XcQj7UdDRWX+7OeO5Bf7351N72T+2JME2uHa7Y?=
 =?us-ascii?Q?b/ydHBRr1KE9EjUfymjuNU+SROAzicP8Qq8255SYdUtu5iYcjssWhh0ChXm4?=
 =?us-ascii?Q?3BsrGih3NvTded9hzRkfFHRZEyrkue6ipqiPERqC94/4ia35ehkUuGR56Ir7?=
 =?us-ascii?Q?OY3tUmH+BuFe+0gkU8dtnxBCIMlXxeAxk5y9BPJ/aQPIN39GNmdJXdnLA7WZ?=
 =?us-ascii?Q?QiMNvGeOSIEwhqQ++8UILx9qzMDcLQNZft+fk75DmkEo5eoyjkyq0Lh8mcex?=
 =?us-ascii?Q?6seaWB5F+outqoVo9xcaNMFBA60mbAOKP/+Kg4yZu+cvx1WdQWZ7dtRGBLck?=
 =?us-ascii?Q?vHMYmED5j9Vstu7CzaZdTV1Pud+KDXumK/GOn04XhTUwezeLLtI7ImEg84Z2?=
 =?us-ascii?Q?xvNfuHv+V4fXzvAZ4/xntCRJNyIHoOqVL4MR37FyH2st5NxmlwX6AqRNbKdW?=
 =?us-ascii?Q?JJEukhaRkxBamCwZ+1gZKp6yedzSoEx8Mq+/KRqEEx4TdmJtqGRq2lVLqu1L?=
 =?us-ascii?Q?qgUsk/6QDi7xODFIsZxrIOWtUYx+JsXLM6U/NcxVzsit2kLlPl3rKYDFUnjQ?=
 =?us-ascii?Q?XzKs0cyqPT+s/rdhryy91ca06mBB/io3gciKCf8noiwv2hEx/uxF6HiydHjz?=
 =?us-ascii?Q?AOajhy1e0m68Do4gQPOioSXTzpgS0ujeyD2BDq30mJxCVOU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cybcyeX9SXGqaH6OIveM3NJhJBbxTf7NgAyU7q9NKDj11PjVbe1UUDJmhT14?=
 =?us-ascii?Q?O2ab4xca0xC9XWpThAyFyMVb7tpab60k0+PJQayCuLfXPMeS8+fTz3WcaMLI?=
 =?us-ascii?Q?k+xemuxG4tfys/qhlbjpbJV7xgWG/ltqLaEdpN7IxTzZ84GhQBIKYjXLY4mY?=
 =?us-ascii?Q?WJTo6+zxaZp03Vk9kHd/S+UB50+WggCUJqxCUs/xcsi4bca5Gj8rDSIVrhZ+?=
 =?us-ascii?Q?gMiieZS9XxCuIyBKmmfG66FOvNenn8KfjKf45v2YAmBOUAilOo9M+AQh+Foj?=
 =?us-ascii?Q?njZdjUV9IH00wIPYbUoBRjxsEfEE2cecPBY4W0vP3tQNrtIOu0CTYq6/S1lj?=
 =?us-ascii?Q?HcXV8uBlih2Rbe+Fy1W405UBS33kumi3iQLZfeKgdNcspKkz2LWmuMKA5Y63?=
 =?us-ascii?Q?S7rQetQqdeK2v/Dzlq+nhELbmGY+JTk6XOCR6MTmWdYPnSeCyJ2ErSh3SvLh?=
 =?us-ascii?Q?i0InBLCatyb+cZMp31ZP6Ir3fdk7JUAEiNrvJlBSI/RRwiWIAnOc2jo4QPC9?=
 =?us-ascii?Q?8g+RgMAsRwYFU6q8yTC66TrA1OT4Jn0Q5zxNON+7GHNnpW2NGVXaHc4BlgJn?=
 =?us-ascii?Q?Ofpgk49UD9Zr2SIT1D0i6bvBkYjqQtCfvJyS/CM/k+wpTbfidYHGxhWinIkF?=
 =?us-ascii?Q?b/TYpF66S4vI3Z8i+xpdyH+bRQ9f7uuGRgUbZdmwav6vt29UpjreCGjvHV9p?=
 =?us-ascii?Q?rp7WxEec19eSg6cpOSUrbX2Bas2V9iBalBeQNJY1iAMKbnxplWckfZMQsjnN?=
 =?us-ascii?Q?koxM6oqmWjh9qJyTffneMG8R4D0NA5iMYPshw2wxjzfdnwEDH44HMLI6ypis?=
 =?us-ascii?Q?aZ1GTmaTj7oMM4kVmB9zZNFDLcSTV+VbIGa4Nvd60+/s8wg+KZo3PzxSLPKZ?=
 =?us-ascii?Q?TyiMW1dNBWXsV3UbGfIvVYt2cyTVmtAgbscqthHSTia5U4tFiaKuRSd9YEly?=
 =?us-ascii?Q?6+BltLv0bMojcCFP4tQHIAJ9AMc8aNvAfY9ZEdBs1Vasm6AL+AlGodwVWazU?=
 =?us-ascii?Q?TTW73XE5VA8gFApHtKevmDJBZJR5zNf/euIAieAWDFQBWq407f3wYVnS05vZ?=
 =?us-ascii?Q?HyfiaB3b+wq2krlVx/tgQXYijfwBaLuD2dcIfxNZCJhmWZ68RcrEtLAmaL6e?=
 =?us-ascii?Q?QP7N0ZKDq3GCGdOnDdKtsiUjOjN9PGtAk8DEtgOfBgLd5nZS0+VX8io0RoM2?=
 =?us-ascii?Q?yiCAUgsJw89QAHrTaOAJCQ13szsJvdJUH6Xpsh7B40nIWa4MW3zxlCoXPwQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c2876a-2fdd-472b-0487-08dd02de4d2a
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:53:15.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0369
Received-SPF: pass client-ip=2a01:111:f403:2818::804;
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

> Il mar 12 nov 2024, 04:17 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  Making a universal unexpected_cfgs apply to the whole workspace may lead
>  to a lengthy cfg list when more devices in Rust are added. As cargo does
>  not allow overriding workspace-defined lints once inherited, I think it
>  better to keep unexpected_cfgs crate-specific.
>
> Is it possible? I thought you cannot override at a finer granularity once you have a "workspace = true" line.

No, such overriding is not supported by cargo today. I'm thinking about
removing the workspace.lints.rust section, but ...

>
> Based on the experience with C we shouldn't have many cfgs, but if it's possible I would definitely make unexpected_cfgs specific to qemu-api.

... a quick grep finds 33 different CONFIG_* being used in C under
hw/. In that case one universal list of expected cfgs does not look like
a problem. Thanks for pointing this out.

--
Best Regards
Junjie Mao

>
> Paolo
>

