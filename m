Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD40D609A8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 07:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGCHl-0006IE-Fc; Wed, 27 Nov 2024 02:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tGCHg-0006Fz-62; Wed, 27 Nov 2024 02:16:25 -0500
Received: from mail-sy4aus01olkn2080e.outbound.protection.outlook.com
 ([2a01:111:f403:2819::80e]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tGCHd-0003Fz-UX; Wed, 27 Nov 2024 02:16:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/V32YBLXmQ/5oTrigHvd22kEveNtO0bw+RTYUJTpsJ3KnWBNLCEPY04mViaphSX1DdkJYuogHQYcURhV5C3oIr4Cp3CpIVmXV5+cbK0lxF8VkDhvIQ+c1LjjtnWOMnPVnPHn84h2z6VjSdC+lAQ1OvhsxyEFcF9oq3HVMmuoGzsH0f5x/z7U4i76HZASTicxqiicynmql14vzKkk4DYtexr3eHmfgj4cNIeyyKD3peOPaCnAg/mjTf1sDj5Q6KtDdJMcGPSGxJgTsOcYky0sAhWTKEKtHee3hoHhZwDpNP0W2l1HxBsQ2gCw18FKSZdzPQs633cxxYf9Bd2OROeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhu0BQuml5C4B3TxY/IDfFdvwW5fYfGtxJrjokz9x2I=;
 b=eBxxZk4Hk34ZKgrYUeBLY/d2521rHEobaBKTYuwzMZTmAJgV3NnbmB6xM+oxJZlGGonL+IG6F0iz4Fqu3q+gbbfkeuPbIQmA58TE/+cZbTW9ETVyfU2MrAL7qQbbu8gJF05qLrwpxhtYzhSxFy6rsr+7sxtkPWCqMKQUbmXrmOgaQ1j+TxwBVo+0DVaSAjqQek62tai2PXaVEISVGBFpOJf5sfHPJYEbippKl6S331nQbXrx2YbVkprOCi/XEdXl3z7Trq1zzUanV/aoNkMp45L3MD/dGCveFJ0pTXm4awKD7WikA/0hBYI0X1+jVJyMFMETDZFBc3L/Gpe+fiqZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhu0BQuml5C4B3TxY/IDfFdvwW5fYfGtxJrjokz9x2I=;
 b=FbSf+CEa2npBnjI6zxbaAMPm2lJBWzlM8xT2fedpO67x3OiEB+SCGhRe8mkHEniR8kAlNzQ+IhU82WxDW+r5Te5yu4ryz66rZf0fu2FQT7UJD9RaZwkBsXCCntgecQ2Uu2OyfgRKvkdIsIrWId4G7e9HfjdhTJysq2lxmNbIMI3GRKo6nMfENyvvF3AnhR09t6cHCrDfN+DlFvHPMVq0cCjSZ5GkKCBoMcbkrUt01eCVlNv836iv8r4u4/6AU0qvBnj2qM6wopXMdLBqRpXprs2ef0Kktng8Qs2OQvui3UMlYIGpnXR2uXv9AtAtRzlozaW7loKFUxJg7UUWInmsGw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0778.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 07:16:12 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 07:16:12 +0000
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-2-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/2] rust: add BQL-enforcing Cell variant
Date: Wed, 27 Nov 2024 14:54:43 +0800
In-reply-to: <20241122074756.282142-2-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026B446FA07C695DDE3617E95282@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87v7w9rvtd.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0778:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e6dfe6-4520-4b02-2c2e-08dd0eb35f2b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|8060799006|461199028|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qt77ci9bUoyM4I79HsXEDNfejl0qomUqmsglRa7tgtC1So8yCH8ezCKOQyDK?=
 =?us-ascii?Q?CtHmzxZBNk7eYsrwplJbFIFwqH47dob4zuRfriBbAvE97gPhE0hGNTgqvwH8?=
 =?us-ascii?Q?TWLLN6GZt78DlF1B5lTh9eizIr4n/OXGhc1aVYkVYMkEhlvJZucVAYuoJoLj?=
 =?us-ascii?Q?S0yKn7FZ/znjIpsBioKQmJ+kHHd3MGzH6SA7oOj4HgYOBpVmONoY9cj0nYtZ?=
 =?us-ascii?Q?Kf2uYb52ytWZVT+YelpPPKRn03/09xiu5UIgpYHHyJgsncnr2iE7rLmRU2AU?=
 =?us-ascii?Q?k+PsUXXveV7MaOQGj84+vXpIH8EXdWLyIW7B3E8ssEzGKlu8JXpO3kKWcr48?=
 =?us-ascii?Q?mH3BCjUWKjlpt166KaguWAmTyngzxghnUAIP3TnMkjTmiSnhFc/mGAAAtPoy?=
 =?us-ascii?Q?wfdT8WWroqhSgKUUddclmdbD0kAosS/ZY7joEu6e1jRtDJIw/Cb4Q9UcDbpE?=
 =?us-ascii?Q?+Y3+rO2LgLCXhOdZfZVzPaiQxg6TvAbON6LbVLRWY4Xbcqkck6SNuvWc8+Wb?=
 =?us-ascii?Q?HrkGmhEr+dKOXTC/y1SYRK1tCUKWCXkeq5LcKbDI5UXCeytJTIs2cfJbctSo?=
 =?us-ascii?Q?foiW/ok4XU76DLif5Y+RBJvkNFdn00wKuVLeXWNdQOu7DL8Vgs6t3asY5sO8?=
 =?us-ascii?Q?HZTU1tyc7TFK/jN4LhA66hcBGSTiLNBkwMdsYtJ71FHHcxiPssVxgvZKo0i1?=
 =?us-ascii?Q?Sv5G08ztFPAM1fqAwnVDwDrid3IeM1sxYknXBv5A+YS6aT4nFxCXn/nfP0p+?=
 =?us-ascii?Q?wXqynxmwSbYT03BQNul0xahebbAgahEyP8Ia57r2H45Na3vUmlHJHWP7yS7e?=
 =?us-ascii?Q?Ocpzw9cWZk9TdppQK9HiHvKKDMLAL25Q06JpJ8QQdVCqGzYoVe6WLO/oZQVE?=
 =?us-ascii?Q?v2T2ifsWD1zYWR/6CfV9togqMaNmBy5S0IMQLxa+xG4oQSfYkQHon8ni167O?=
 =?us-ascii?Q?aXrnPIHNX+Bx4tEo13ZFNCpyBbOAihkCO1ymsArh3nFXRYZU3mpcFmO7ItZ/?=
 =?us-ascii?Q?Kcw6YTC0FxNxJMQW8vtwSR/nOD7sjKgdZ2Rx8c9r/Vq7p6I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgulm6/iZ6BCWpoy4/G53SaSpsA0PaYLOhyClswIgIIwNaqcoA9nyqlSFhWc?=
 =?us-ascii?Q?bnLoLgbdoAnEjlkWmuC7JkQ2j4p7oFJvTKBuCJG8ATSGpJSuE1bWqOwUElPt?=
 =?us-ascii?Q?API6006zwP7JVw1hZvZL6UVQ8YoutuMTd6PQGlg6EwaMerl+4212a8LTr6XT?=
 =?us-ascii?Q?kfi6PwkqEUTfhQ7yWLhJmS71zoehcsMIq7uGyrPs4lVnG4Lgyv7Wzg2CbpU5?=
 =?us-ascii?Q?zr2IIKadze76MbG7utxjRuj/kJp6FbFepcMeWuEgedvLrSHckD0WiFBAp+9x?=
 =?us-ascii?Q?7PfW8Wxjcpv2aqf8VFbtu6uzv3tQyTy3YGLCJqBjtoQaxnFhgqNM8zEfvM/6?=
 =?us-ascii?Q?ACAw8qBAAQImpfAHNj/SE15RgHVV7h8ccyjnqwi9FBHW7gQZfg64vLB1tnww?=
 =?us-ascii?Q?WvC2wjpNno7/3cfaKOE+Dnc8EvWyQngmw/36wFwp6js/Uhb6TJX5Kzwa119V?=
 =?us-ascii?Q?XHjGRcR0RqcZnyKmy/g+L7QqTPTMFRcBqm/79k35TXpBVnZqsZx+4VgN9P6D?=
 =?us-ascii?Q?c6P+IkJVStr4k1E3kaeHA0oD3HTgui1i35eb0b9RE0wXE9iiiGV0MqLD9AEa?=
 =?us-ascii?Q?p3LCuBHPdfmiROqmzN8WOy8VNCgLHX0k4XT12r00WMy8V2Ek2+ylElWcjYVk?=
 =?us-ascii?Q?n+Mhz21RZGEe01lw/nBJcebt6p9ndDYy48DatyntuHCrZw2mVSvqGStfItrg?=
 =?us-ascii?Q?2pV425cE3rrN/A3ILHgZ4QA7K1uf7My1x2b06rW7ArDuZb4ON/D8kVUEch5H?=
 =?us-ascii?Q?g9BeM5qFmNE+LPHg+i8uKRP8A8n1pmGf8+qQOP0qnzz5xw1vz18CkYYYx+41?=
 =?us-ascii?Q?yIr3/3ImZfgUxhgEEh3NN9D27dxuzItypaMxHLGg/eRoJsEYuVn7rZyogCpS?=
 =?us-ascii?Q?a9YZ25q+EQ1MfMyWC1zehVya/Xfj8AmFKeK5N8kEnJnUk0b96IDa9pRqGHKW?=
 =?us-ascii?Q?VItk4r5oSZuKnQCj5eKHIkzkmcQS4/8Y/wKbX97n5yIYUZNZFKBObIPfHy1R?=
 =?us-ascii?Q?LkRa5MZcH/z/WawijNt+oQ+zYUhxheYYAG9DO7cnWPWh8y343oYRhLocks8P?=
 =?us-ascii?Q?/24hOHYlpLV/S/eQegxX2/gNi/LBCqhm/YNpRMpVdv6VS9AIzXEHlUuwhZqb?=
 =?us-ascii?Q?SP2Vsp5v+DzXJ+9JDOgDRkjvTglhVmZ6yF+0okApGUt+hB72F5tuCHZjvj0G?=
 =?us-ascii?Q?zurLXmXEBr0aHOyC/gJX60krDacr+AdyTm/xbu1XSCMqEA0dPiW77nsJz0E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e6dfe6-4520-4b02-2c2e-08dd0eb35f2b
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 07:16:11.9154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0778
Received-SPF: pass client-ip=2a01:111:f403:2819::80e;
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

> QEMU objects usually have their pointer shared with the "outside
> world" very early in their lifetime, for example when they create their
> MemoryRegions.  Because at this point it is not valid anymore to
> create a &mut reference to the device, individual parts of the
> device struct must be made mutable in a controlled manner.
>
> QEMU's Big Lock (BQL) effectively turns multi-threaded code into
> single-threaded code while device code runs, as long as the BQL is not
> released while the device is borrowed (because C code could sneak in and
> mutate the device).  We can then introduce custom interior mutability primitives
> that are semantically similar to the standard library's (single-threaded)
> Cell and RefCell, but account for QEMU's threading model.  Accessing
> the "BqlCell" or borrowing the "BqlRefCell" requires proving that the
> BQL is held, and attempting to access without the BQL is a runtime panic,
> similar to RefCell's already-borrowed panic.

I like the idea!

>
> With respect to naming I also considered omitting the "Bql" prefix or
> moving it to the module, e.g.  qemu_api::bql::{Cell, RefCell}.  However,
> this could easily lead to mistakes and confusion; for example rustc could
> suggest the wrong import, leading to subtle bugs.
>
> As a start introduce the an equivalent of Cell.
> Almost all of the code was taken from Rust's standard library, while
> removing unstable features and probably-unnecessary functionality that
> amounts to 60% of the original code.  A lot of what's left is documentation,
> as well as unit tests in the form of doctests.  These are not yet integrated
> in "make check" but can be run with "cargo test --doc".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build |   1 +
>  rust/qemu-api/src/cell.rs | 294 ++++++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs  |   1 +
>  3 files changed, 296 insertions(+)
>  create mode 100644 rust/qemu-api/src/cell.rs
[snip]
> diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
> new file mode 100644
> index 00000000000..8842d43228b
> --- /dev/null
> +++ b/rust/qemu-api/src/cell.rs
> @@ -0,0 +1,294 @@
[snip]
> +//! BQL-protected mutable containers.
> +//!
> +//! Rust memory safety is based on this rule: Given an object `T`, it is only
> +//! possible to have one of the following:
> +//!
> +//! - Having several immutable references (`&T`) to the object (also known as
> +//!   **aliasing**).
> +//! - Having one mutable reference (`&mut T`) to the object (also known as
> +//!   **mutability**).
> +//!
> +//! This is enforced by the Rust compiler. However, there are situations where
> +//! this rule is not flexible enough. Sometimes it is required to have multiple
> +//! references to an object and yet mutate it. In particular, QEMU objects
> +//! usually have their pointer shared with the "outside world very early in
> +//! their lifetime", for example when they create their
> +//! [`MemoryRegion`s](crate::bindings::MemoryRegion).  Therefore, individual
> +//! parts of a  device must be made mutable in a controlled manner through the
> +//! use of cell types.
> +//!
> +//! This module provides a way to do so via the Big QEMU Lock.  While
> +//! [`BQLCell<T>`] is essentially the same single-threaded primitive that is
> +//! available in `std::cell`, the BQL allows it to be used from a multi-threaded
> +//! context and to share references across threads, while maintaining Rust's
> +//! safety guarantees.  For this reason, unlike its `std::cell` counterpart,
> +//! `BqlCell` implements the `Sync` trait.
> +//!
> +//! BQL checks are performed in debug builds but can be optimized away in
> +//! release builds, providing runtime safety during development with no overhead
> +//! in production.

BQL checks are essential for data race prevention. Skipping them in
release builds would require thorough testing for the same level of
confidence. That does not look to me an idiomatic approach in
Rust. Today we have "-C debug-assertions" which makes debug_assert!
effectively equivalent to assert!, but that may change in the future
when someone wants the rust build system to respect meson buildtype.

[snip]

> +    /// Replaces the contained value with `val`, and returns the old contained
> +    /// value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use qemu_api::cell::BqlCell;
> +    ///
> +    /// let cell = BqlCell::new(5);
> +    /// assert_eq!(cell.get(), 5);
> +    /// assert_eq!(cell.replace(10), 5);
> +    /// assert_eq!(cell.get(), 10);
> +    /// ```
> +    #[inline]
> +    pub fn replace(&self, val: T) -> T {
> +        debug_assert!(bql_locked());
> +        // SAFETY: This can cause data races if called from a separate thread,
> +        // but `BqlCell` is `!Sync` so this won't happen.

This comment looks out-of-date. BqlCell<T> can be Sync but data race
won't happen because of the preceding BQL check.

--
Best Regards
Junjie Mao

