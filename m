Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E1AD32D84
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAo3C-0007Xa-PR; Tue, 12 Nov 2024 05:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAo3B-0007X0-4D; Tue, 12 Nov 2024 05:23:09 -0500
Received: from mail-me3aus01olkn20802.outbound.protection.outlook.com
 ([2a01:111:f403:2818::802]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAo36-0000lY-Rv; Tue, 12 Nov 2024 05:23:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut/qFpjP/Qa2aftupF92dJgvsh10FnoXKEPSo/hg98hD55mRLsl5brYPRzetRD9BS5mGsKX9VxD/aNQGvgkMqerKcH18OvsI47zhsHGRy4uHoMviQwSccRyQZxRYXBRrjo/aaGmD2j0c6bm7trZOoqYpcHNmNntQewXMEAiUrdrJlALlCLNwkhk8urk0Bd3ohE/ivCg1yO/5hvi8Oml8vRLg5dsyug74iDdRmtwMK9q3A4Qvpfh1XUYGy/d6goDPgsSCop4tQARq9oyzo0W7roxCPVHe41qQLfzNdvmekb+MWHaE0NYG3gEFwx7+fKQ6V2QV1PUF2EOJlV+DNYvz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYgZcX8h4j/blbkmwVXrEetZdfWwceejxvyWAK7ASj8=;
 b=jw5vDI3/YIIJ5Ndfqx31DRsyM9qbvJiTetg4csNRCyp2vg8HZEVUQG46zDL1mQ5izjzyPj+n4vrYGJGid/p8Vc+0QaQ1bhnxGvao1AENBYyXfQfp3PIJvGMeioYWOUlhhTBRoyNoYnw3ThsBej2T7bBLyco7aNgPdSUW0GpRzVeidJZg/olX+nRI/lJyO1j85pFfaiyrAWOoiT/o+FEfPZsN47WfNT/livtFNW5RCWQd9xiOEBWWmWcuo53KWGyeUy0sY3Jsx0V24Xemr5HU+ASx+e06rbpbdLMVbqderThgns2yeXLXtSiuhhzpcUJZHHlXk7v4bVISCIsg0f0Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYgZcX8h4j/blbkmwVXrEetZdfWwceejxvyWAK7ASj8=;
 b=HdThIat/av9KkDIs3VzKprayMI5m+O0qJONgn/+8XSwa+jk63WpdxVrD6nu1vnRGzb8kKCzoS17G4GqpZ3cbjK1ezaQKSkyDT6KJMew6+pyT42BlthNqvj9QiWvY2qWmt0+GEL4Qm5oRwaFuFtIhIjMPiZ3oDb+KXnyBUWnrxg6T+RZbpFt1baLFBb46dfHI/78+52mOuqq3cSzjnuy088wmd1fwLBjcUp0UUWCeOJ9ZbPLOmBsrxee+y4vaZ8T07IqyS2W6wP18H/zftqJK6EHTKh6t0AyYYjQDokXCKtWSuXiDKS/uJK3yqTIU5z6CM/3h0eHZfByRRE1TVWVF6w==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0626.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 10:22:59 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 10:22:59 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-2-pbonzini@redhat.com>
 <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfb9ujpoRrNUUqyiAefSfTOWSV-SGmo2YrSoMdfxBeAD9A@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>, "Wolf, Kevin" <kwolf@redhat.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
Date: Tue, 12 Nov 2024 18:10:47 +0800
In-reply-to: <CABgObfb9ujpoRrNUUqyiAefSfTOWSV-SGmo2YrSoMdfxBeAD9A@mail.gmail.com>
Message-ID: <SY0P300MB10263A5B33FAAEDCB04CDCD295592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87bjykkayw.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: c7882577-7fc0-4703-903f-08dd0303faf7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|15080799006|8060799006|5072599009|7092599003|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WZDiAGUKkMiidbOAu8zo7EJ/MJ/q2htKzY2F+Zi0UBspWgMN6ggxr+xhpUWU?=
 =?us-ascii?Q?p9AyphCiKKOYjLhsCjsz7PFswBPkQ7cWpT7V95na9FOyqdHlR+0sdicrE717?=
 =?us-ascii?Q?PYuvsXfATyxwtsFbF4nzxgZWvGouKo8B3AzT99cy5PYaBDgc9To0s0MYdCSI?=
 =?us-ascii?Q?jEoW+f34XZhSktojHbG+BMJw+IdnxsbiWQ2M5Gq89NXxfZU2Gws1r6UOsUpV?=
 =?us-ascii?Q?OEWiRxsyIUHhNro51S0nvAo4jcUJj642ZCfPXbdiHCYrH7/EabvKH819zNxK?=
 =?us-ascii?Q?F4QKmMZS5o7CLmnZkgK1wdw0Z3X7E5VAUCTeN6YORcs3Ruwy60dUHYTNlDA5?=
 =?us-ascii?Q?ppZUsdGnEj2iAKke41hv/EBKzakfHduLuW0l2pay1Jb7WHeW8KwIuh8bK89p?=
 =?us-ascii?Q?9WE9YAqz6YgSTlWZpl9Y81i4Wnt/A+I5SQGcr38nomdzHcmLafj6R8t2KHS/?=
 =?us-ascii?Q?omUseUYTmpZAMQUlUyGZOpNsdg7V4mEPA63sdzdO7WcGSsGuUmb30EKH3/Nk?=
 =?us-ascii?Q?Axa2gP0ZJuY0F8UDlqORQsn7ShhCRBlEJfWgB4PaK2mUOmr01PuaLi4wxXVw?=
 =?us-ascii?Q?ULW50ih77OsF2mNSp1VxrK63hzlzuxKYZwqFZuv8nzCtzNhQSwDEbLkwdiub?=
 =?us-ascii?Q?o1Ca9zvCWvbwQajcINmieDHTf5dhBoaHqnQLPcc2kMobt4WmJhdGGtZJL1At?=
 =?us-ascii?Q?G2/VS7YPj4Rkxbldur9WqtzFqvzffm/rGWTTr7MTFkstEdSS28Ead8yUERLP?=
 =?us-ascii?Q?EDBvprtG/ZMNUqx6AzX+QwKwN1zkRZaaQAY8NQB/cTVVhoi129A5Un0RI9qH?=
 =?us-ascii?Q?+WD+SbU6Dp8xHm2ApmdlqrKaKY3c3eQfVkGRVbkXjnFXiUdMsjMDzydrFJiC?=
 =?us-ascii?Q?VM7Bejdoh80mHirpnDkE9mKc75zPX09WfgMFz58K9mIDC0cO1if8wENUzVWN?=
 =?us-ascii?Q?HlT4Fga/VDdWzc/rFu0Xxh92h0KodIo8m6KoK+iXBMTYefhvPbADA6EthNpf?=
 =?us-ascii?Q?6cbdOSgLx2dAVRqoRpDgwzOyHesTrJdVDMjpJNQAOdojBTkUOqDi7w+Svqrs?=
 =?us-ascii?Q?O2xFk7zkfcXxK2ualyiDyjdUK3FmIlkG4jRG8SN8m3Pu7Cp5JdYdO8TeaaUy?=
 =?us-ascii?Q?URqo5jk66Nol4oENUCmb+MLz6nL2K/vhow=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iAWLEURzeMhuxn+3g2al/M6bf6DiCgM40KLY+Or1rdWc/OEDLjuSyahMVfCw?=
 =?us-ascii?Q?Pv7FzFthOGbKoqjh7tzx+Kl758XGFLrc+W1t3DPWoOBqjg20XGOiAZK8Lli4?=
 =?us-ascii?Q?WXNESdxN0nqQ5K5o6NMk1xs3IN2MssZxO+Qt4j+nBGBX/BvMgJI6CwrMngyu?=
 =?us-ascii?Q?ZJi2ouSYDJTtALhkxUEGOgc0QpcB0o/3UeE3BD5J6prkCchFlUphsWU0TS8p?=
 =?us-ascii?Q?AnaJi+AdIMFyFIBktqCtcOEJt+G+gCvnXT26khKpjBlLZjN3UKhHVX0su3De?=
 =?us-ascii?Q?oZUb6LASmvl2yjq4rN9yyNpxttQsyKnqtysLsctARdRUNhUcVCAe8gDXmm1Z?=
 =?us-ascii?Q?xz+eNbZES1W4cYeExV2qeCwiG8oZRIspm85rwsMdLqow1vFFk+/uNcP3mmhW?=
 =?us-ascii?Q?D9pxTupFBuqLfxxkUysB8Krr3EMZj9tbGHRaEjUTIQzPjTveDp5x38fJubbS?=
 =?us-ascii?Q?X8F0Rm7Yp246M7Bj98vcAv4OuVODkRstii3NWVUOwFhsQhBLDzDZfUtl64Ou?=
 =?us-ascii?Q?bB2t35/TVQ4kO6e96hFCL8sWjiQ+IvdzkijiWyrVXdLtJ+SCVOYR9GA/id+M?=
 =?us-ascii?Q?Bwxr6yIFhZ/okQB1R2CGg3o0LLcoiEA5hueVmguXNCPTX75XXjsQSq8ysbhc?=
 =?us-ascii?Q?92OqQaDT41EShycoWN2qiiBBxUU12Tl/nZEUkBGolJF4DfrnaBYexRqGZPwc?=
 =?us-ascii?Q?g0dFKnitO//69E8xD08ZjoepwlivbhUYKOlPRH8TMl5OglPnVGdCcJuLbwu/?=
 =?us-ascii?Q?r/740qYJggG+Jq2wcc19vEC2cmWRgnXW1zD/QR2OyoK0gxT+Lq4qUVdtmQnA?=
 =?us-ascii?Q?dOmsLrn7cAICBaNkPehcTE4QYVtjOtAhTIPsEslfaxjHYaRJOJtIWkaOjKr5?=
 =?us-ascii?Q?y2RBuP+gsjZU7huefN0S/sVjRBAv4v6J+al+dahol6pgo4MihHi9CCmj2+5z?=
 =?us-ascii?Q?aYBHfnwA85gvCFXxQjUIFVrHACXUseSiJVDiymzz5HByTLuolj1QUBck4hxY?=
 =?us-ascii?Q?Nx8X7w0ggBo7P89jXDVnbYFIjW4RSE9fkfyvEeOTrtoyLF/0+yKIyVMo1Zf5?=
 =?us-ascii?Q?Z1rC92R3j6aAtYqW09GC6KVvjQvD26zD7KO2FsI50psHG9GiWkO+4M3MeLXH?=
 =?us-ascii?Q?Tir008lrV8Hm9LMT9UPK2GSRVhiZ59pGDE/a2ycNyorCmBHfUI8ga+r03n0b?=
 =?us-ascii?Q?nd5rhqhewkqJ2KebsNTbGcLrO+q6tKPj7JfhOWoyQfWyg7QZ8ySkdQSF6ro?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c7882577-7fc0-4703-903f-08dd0303faf7
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 10:22:59.0709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0626
Received-SPF: pass client-ip=2a01:111:f403:2818::802;
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

> Il mar 12 nov 2024, 03:47 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  I agree that storing generated stuff in the source directory should not
>  be encouraged.
>
>  Just want to mention that such changes can lead to trouble to
>  rust-analyzer. Today there are two ways to inform rust-analyzer of the
>  project structure:
>
>    1. Use rust/Cargo.toml. In this case we'll hit an issue in
>    rust-analyzer [1] that prevents it from including sources outside the
>    crate directory. Thus, definitions in the bindgen-generated code
>    cannot be found.
>
>    2. Use the meson-generated rust-project.json. Due to the use of
>    structured_sources(), that json file refers to the copied sources of
>    qemu-api in the build directory. Rust-analyzer can find every symbol
>    in the qemu-api crate but will jump to those copied files, making it a
>    bit more annoying when developing the crate.
>
> Would it help to move the bindgen-generated code to a completely separate crate (e.g. qemu-api-sys), and avoid structured_sources for qemu-api? It might even help build times.

I just noticed that rust-analyzer is able to include files under
OUT_DIR. With the following changes, rust-analyzer under meson devenv
works nicely:

  1. Rust-analyzer refers to rust/qemu-api/src/* unless the definition
  is in bindings.inc.rs.

  2. No manual copy / symbolic link required, neither bindings.inc.rs
  nor rust-project.json.

The bindgen-generated file is renamed to bindings.inc.rs only because
rust-analyzer seems to refuse including a file without the .rs suffix.

That's at the cost of another file copy, though.

--- diff starts here ---

diff --git a/meson.build b/meson.build
index 1239f5c48c..8cea09ffe1 100644
--- a/meson.build
+++ b/meson.build
@@ -4,6 +4,7 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
         version: files('VERSION'))

 meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
+meson.add_devenv({ 'CARGO_TARGET_DIR' : meson.project_build_root() / 'cargo' })

 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
 add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
@@ -4083,7 +4084,7 @@ if have_rust
   bindings_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
-    output: 'bindings.rs.inc',
+    output: 'bindings.inc.rs',
     include_directories: include_directories('.', 'include'),
     bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index d7b6d76828..1de86c721b 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -2,17 +2,17 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later

-use std::{env, path::Path};
+use std::{env, fs::copy, io::Result, path::Path};

 use version_check as rustc;

-fn main() {
+fn main() -> Result<()> {
     // Placing bindings.rs.inc in the source directory is supported
     // but not documented or encouraged.
     let path = env::var("MESON_BUILD_ROOT")
         .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));

-    let file = format!("{}/bindings.rs.inc", path);
+    let file = format!("{}/bindings.inc.rs", path);
     if !Path::new(&file).exists() {
         panic!(concat!(
             "\n",
@@ -24,7 +24,9 @@ fn main() {
         ));
     }

-    println!("cargo:rustc-env=BINDINGS_RS_INC={}", file);
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{}/bindings.inc.rs", out_dir);
+    copy(&file, Path::new(&dest_path))?;

     // Check for available rustc features
     if rustc::is_min_version("1.77.0").unwrap_or(false) {
@@ -32,4 +34,6 @@ fn main() {
     }

     println!("cargo:rerun-if-changed=build.rs");
+
+    Ok(())
 }
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 972b1f1ee9..8a9b821bb9 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -16,10 +16,10 @@
 )]

 #[cfg(MESON)]
-include!("bindings.rs.inc");
+include!("bindings.inc.rs");

 #[cfg(not(MESON))]
-include!(env!("BINDINGS_RS_INC"));
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));

 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}

--
Best Regards
Junjie Mao

>
> Paolo
>
>  We can perhaps leave it as a separate topic for another series.
>
>  [1] https://github.com/rust-lang/rust-analyzer/issues/17040
>

