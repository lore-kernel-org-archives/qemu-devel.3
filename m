Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC1FC6194
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 05:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spLY9-0004LQ-3S; Sat, 14 Sep 2024 01:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spLY2-0004Jz-BP; Sat, 14 Sep 2024 01:42:18 -0400
Received: from mail-me3aus01olkn2082f.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82f]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spLY0-0006YT-91; Sat, 14 Sep 2024 01:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN3v10rksByaGiY+RxycG0OSzLnAxqn9h8A7IixnbDd91lnOJlwOhjVTBKOqVs5QU+k9fK0gqFVQaQylPNhVCxr2lg2wFtPyYb3ERP7jblJm4oZh6TKoNqn/lF3yJxSlS3R6ltfKn8bzEylyK+4tdyg8VOpTaJWUckrd7hLWh/cQaLcnmazBbQgi3JFRgGEZmIFwhgRrc0kfB6XTm0Qm6U18rcZf4GrNHU2HaVv2TyJ8Y1wX+jjzYkX9oVo3FLef2qeNpyHckE0XyfZdN3UbNq92D00d/2WPoNZLL9HnYu87FNyhA/FLVHaJ1B0KyCfpLuaP4/8rGF5WWMV0i4Idhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrlhA2NYPKDNxxpJDq+PmbQPLDkna++VhF1AuAnw2M8=;
 b=hUEw3bdnRXv+0PnkSRk0S7BWjcRwEzygmi/dxI3Mh32JDUE26IsKjeEots8q9pvsv6bfsP42H3CavfGAmdPFQOizjWpVba5TMNwOCBUmslGhf2CU8jZCr30mzWBjE5H5uxlAQeud4k+K3apc7jxoJzdS7ynCqWRrCuiY7MTipA0Bk+Zpu6U/xR4bisU7RkSsab74/n3F+HBm+2Y/BrpxV7TCtQNDUap267fHEmBr5zrN2vJPkXBaqmAVA5NHwg0KCR3+qC6nXS2Ydn8iHEOD71GzBNp/tMm+fywYJuSlqnF9DchhgkImGDwTpIXhVUcDN2hqn6pgwStCLF9oKxIIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrlhA2NYPKDNxxpJDq+PmbQPLDkna++VhF1AuAnw2M8=;
 b=tpkdG9aUlXPtEW4iQUZUbXrEZ9JH3/CNWEiaesuTlYr4sG3PLbb72vjZ4Uv3+c79ypjtbwbGM5TZQhEBUnzH9PPBL+4ScN4QM8AbQK7B/UCinsyyZGARaEMfD0Vdzbm4PWgtBIsI5IJg6ib62lNB+qK594hLBlm+tX5DQjMNg9PqgtuVlE1X4Mg8eAa3ZUvXmpFi9a/xOefuFRAHqqgbIIXV4Ct3BWyBhMIMn845JGuYId0BddfInZ+ktf/1N1UHyRdS6zWRoJ56B91hKLiemO/uIIz4LOt9fYC0VARkoFuFB17xDZ6V0dpcIriDyHmFpcowQD/NQrEcTEacRISL2A==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0241.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 05:42:04 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 05:42:04 +0000
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  John
 Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v10 7/9] rust: add crate to expose bindings and interfaces
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
 <20240910-rust-pl011-v10-7-85a89ee33c40@linaro.org>
Date: Sat, 14 Sep 2024 13:41:54 +0800
In-Reply-To: <20240910-rust-pl011-v10-7-85a89ee33c40@linaro.org> (Manos
 Pitsidianakis's message of "Tue, 10 Sep 2024 15:35:13 +0300")
Message-ID: <SY0P300MB10267592970B0FCEA04059BA95662@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: PS2PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::21) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <871q1mkd0d.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0241:EE_
X-MS-Office365-Filtering-Correlation-Id: a95b4102-87b8-4962-c218-08dcd47ff68e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|461199028|19110799003|5072599009|15080799006|7092599003|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info: x2vzjMnObisTnPzPUADsInq3lMp5GoUgFdPJeQJqmGOWrw+jX2+1fpGOEX2KzzK++gbdyIXDqe2nUTFL9PW9ETOaJVGv086QqBhtIX9yZxNiq+/HSXzasS2ro88GF4tqRTi1/bBvwDYeGheQfZ5+zFnn6rzZisubUrv9c3k9BdY0KSIc/DA7glB/AMkNKNGGlY75v3GRTJ2Xhof3yExsYCMjMX7uGW7Pp2RLIE/g0za7uIdhQWMmMAGAlvx0jHZ8OcVlrm0fRrvuSQsolZJxHDabU40duQylzuLLWM33i2QbgCJRHkRNS7PPhmq58c8e/owJFAqPyqIj7hSx7F4Z6ybGPOklEdTN5ovTRmJx2/o3I3nTINqNFx6blPb4ScrM1LpZx+xdUVyF2TlY8WToUiHVTGIN4PeQlxD36wbwLlCyKsbNpRI17/PxdmrAnd/NtSn7rRPCNZMgAssnQx6393/LYElbsnysEdvrIEjwH8NmBgswUuXyVJHrvnVuzdVyrXo4sF7xwcjYFq0Vq+CIykRIK1Ha+xgDx1GAV45+mobQ2N139QQMVSV9gxmI249ivvI3V+9KY95GOwuV6xLkYIjo8abF7SDnFgM5+9qpQtMbpA8iZVeZd8jIOC35wzAp+oTOrU8QGf8YnPKhj2ihZLZgWqdA6NLtNVT63e2Jy9OkCP1QZam6glc7lManMZCMK8ygUo1a0PBhZLSTCt5qe6hczRYd1TA2PcOaAf09HOsY6F4fHO7GQZM8EP5sqizMm8C4Pw8+5Dkw+rDzkuUSf2cPU2zcYQqrbQwjbtoKXuVOk418UdBRV0SsrBtqWi+7UaHDWtoL9w/Nlh/KtiV0tC+96qN2aVUIX0SWY3Qtf5JJsnKNAMS2GYLPuLGdeZDy8/slYOjs/fRgSFkXY9wvJQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0A9O+5TcDgpZfFxlzVSizL0pbeJdXfO25Swkw+GPQ71k8mIWfZXnXff27+2N?=
 =?us-ascii?Q?0JyrJrNQwD+vN5v5Vb6k6hc7GLfxirwkW3HouXPjnb9XaZLqQlIuYR7Vf2cu?=
 =?us-ascii?Q?Ub2qsmW8d4FaU2RfbOSS9biQDx5NOGJ27WULdO5m3bkSSY72CydYheWLPqjR?=
 =?us-ascii?Q?Swv7ASSSwqm+kakXCpFLIF3JjKd7XpABBt5dNDlPTDmamoH3OeWpnWTqe+YK?=
 =?us-ascii?Q?JDyuEDW8uJhXGQiacr0RTuxHBblp+0wpqBZIGH5PoBo3d0Z4Zstp3Ghto1oj?=
 =?us-ascii?Q?MGolFG4cpBpcYCyoqilr20LqCKA3+VVWmqvCVB4UBHLhKJmQ+SqTrlTLxZKw?=
 =?us-ascii?Q?4E2k7YSGm5R1ajiGq0wbVCN2n/PRgdqIKwFoJ5veKPollOfJ4HxJDCj1Enqu?=
 =?us-ascii?Q?oGzEQuc2PkX6QiwO+DP4vX4oQMjSyAeumXilJ6jK86XEpDjzflFH4nfXNL1L?=
 =?us-ascii?Q?S1aAFxLXwYFuoo32XxT/B/BTQr/4lTOyOnof3KhLk+VoW28Sjark3UWmbhTU?=
 =?us-ascii?Q?36DWRdKXztN5ehue3XuK1mNnPEhrzWjmvrkxN96zbkX3gZooROSorH9TLtOO?=
 =?us-ascii?Q?Hr9hwYlQnESp0KcZ0eelekJp/DipRAxViGsV2ZLHfZI7sUPHcmmLN/RgFLz4?=
 =?us-ascii?Q?nd1POVA4CxElUKOj9ceTopPI8zHFg2NHOAOPgpelBNpemr2pxdgz/lOq9PJx?=
 =?us-ascii?Q?bGeAg10uhyBuwhrhM6XeopXLWBg3ekGhGjVXLq+OCJP8W4k3I8bpxaiRx/bN?=
 =?us-ascii?Q?E/tPWbIrdziG5surharkkF7VgIsoqKY3gf2WBJUY0WaWpQo5e8S2fO/KQdcT?=
 =?us-ascii?Q?G8RmyTvfnqYHR2Q+8sQKaXwTjaD4du57a0VSVkM1Hm8jFgmMorNnq9oKwvZw?=
 =?us-ascii?Q?yVKVeHiyF7QPC/sciP6W3Q41FmwMPNki2C3WMQ0dQfLXxcpxTMNSOoYVBKND?=
 =?us-ascii?Q?VwxwnMJWRmJ+iRSU1QD4lS9jZW4qKf0KE0fD7YubH7odN/H51j+TUDPpEPb3?=
 =?us-ascii?Q?RUpVoOWShD65rPAZAKYwya/7iqIykc0v6BMS0v83m0wz0OB9RFDf4ey+KP6G?=
 =?us-ascii?Q?82eZD4oz9VgOjeMGPg8Cd+GkgeoU07P+8R3N9cZgNhHltLVhHbXDWUNMvQyw?=
 =?us-ascii?Q?W5Om8D4kKUMDKrtEmVbCHhqYlED4ZJ0pCAEP1x+tVwsGX5KfWHxEQp8FfXnL?=
 =?us-ascii?Q?n++Etxbo0UylSDvBqpg9069GkyBghBqlP9arYfcaaD8bAhGRtyu/IO+5R0w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a95b4102-87b8-4962-c218-08dcd47ff68e
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 05:42:04.4738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0241
Received-SPF: pass client-ip=2a01:111:f403:2818::82f;
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
>
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
[snip]
> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..69ee912c333c3dce8bc127a286acaadd57ca20b3
> --- /dev/null
> +++ b/rust/qemu-api/src/device_class.rs
> @@ -0,0 +1,128 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use std::sync::OnceLock;
> +
> +use crate::bindings::Property;
> +
> +#[macro_export]
> +macro_rules! device_class_init {
> +    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, reset_fn => $reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
> +        #[no_mangle]
> +        pub unsafe extern "C" fn $func(
> +            klass: *mut $crate::bindings::ObjectClass,
> +            _: *mut ::core::ffi::c_void,
> +        ) {
> +            let mut dc =
> +                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
> +            dc.as_mut().realize = $realize_fn;
> +            dc.as_mut().reset = $reset_fn;

A recent change to qdev-core.h [1] renames reset to legacy_reset. You
may want to rebase the series and update this to
dc.as_mut().legacy_reset accordingly.

[1] https://lore.kernel.org/qemu-devel/20240913151411.2167922-9-peter.maydell@linaro.org/

-- 
Best Regards
Junjie Mao

