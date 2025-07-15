Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4959DC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ13-0002H1-Ld; Tue, 15 Jul 2025 02:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubYz7-0000gs-M4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubYz4-0006jB-U2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752560264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceOromvJJ90nMcwqW2sUYMFaY4IlqDlN3dcUsydUqRc=;
 b=QNKvR3ir/h8R4QLGBcx5RDJiZ+7wtRf8tI3nlWOWhq/ILlRtc+n68wL7UkLlvSfL5gCr0X
 1GRMDksneu2zdGLV4hDwl3StPGwkyr6Q/S/OiUsjOqipSdjLRmHdvBUMwOFY1rNB8uqK1/
 lNGexhgTqb8bxi8vkuF1aHZpmwXxgXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391--e-0tp-cPs-MNVp5kRTUpw-1; Tue, 15 Jul 2025 02:17:43 -0400
X-MC-Unique: -e-0tp-cPs-MNVp5kRTUpw-1
X-Mimecast-MFC-AGG-ID: -e-0tp-cPs-MNVp5kRTUpw_1752560262
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso29450655e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560262; x=1753165062;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ceOromvJJ90nMcwqW2sUYMFaY4IlqDlN3dcUsydUqRc=;
 b=todW3GkYr5MQj8YVUxngjxWd5cKNrvq83XavNzjoX97Ehd3sLfHVrsiLn90aNxYNb7
 G79HWYom/rNDi9Y3oVnlb98jLkpueYdeJtaJccen/5PzS9Q9xuiJSvawWZGvXENuvrpQ
 hnswcazvkzN7tHO2ubrlF2Xp11uEnazyaTDMXwWtdMOGXcmbLOTaFDWhLzk25jf/zVsS
 QEncG9Xi6Wd6/ZsuFH+keLQF0z+iHPsq5ma2J8s4pKPKbVs25MIC2MPXCCIqbwcNnKIu
 L5ezfcIdlf0M9G2A7ZSt/R/n0s2TImeOhl6HP8DzTrnseC0lmWHw4DrKSeCJDVqj9MXx
 TCzw==
X-Gm-Message-State: AOJu0Yyt5ySWeS8VWOTYtGdzEvCmTcXjPYW7Sgv5Ewyl1+Ifn/fUwW9C
 g4+w7V8RYM0t/QhwPUnMZFAWL/6DAyCj995R9HQTGp/r99O4ZkPXf1v17aO5HGAAZ/SLzvh3r4q
 3/SRgT7ehSq5pi3nyyxpB9dHdvUkxg9p46S6Z1eyKl+QnbJaFjHbumKYE
X-Gm-Gg: ASbGncu4YJG3ZmMq+EP8X4bYchU4kdM4Myk7XLsyWshlBQW5Fvo/RxM9FzOVZ2dy0Bt
 boBFyye17TvrmL5sSGJKaP4tAGG+LsYJTcQqxkfA4xiGJIZgenK5AaNsgzhNz64fSvVtrVlZVVA
 aGPAiyuKRPgY0TEm8ZbdXGxSEDdFjC/ipE/QUHPjPzEs25DqWe66aHtPt7Xl+FfQ62GHcBTxESP
 aev8c6/dKyqydqrWFnxenYWuKFmEz0U6BOHxWPlbaA3XkqmJV9PR3Du2de+jxCgfOFV00Cp9k7o
 o3IF462xTun4DAD3TnxfJ5BE3bxsU0+j
X-Received: by 2002:a05:600c:3b11:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-45625e57b96mr21085335e9.7.1752560261630; 
 Mon, 14 Jul 2025 23:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrlYLaJz3zmcZkJrRgyfYIbFQI7MmY6arJUjIjXX/KuoFlMtcxIdMbCArWhQ8OUW6S4eJdFA==
X-Received: by 2002:a05:600c:3b11:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-45625e57b96mr21085015e9.7.1752560261011; 
 Mon, 14 Jul 2025 23:17:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c7b1a9sm7602835e9.0.2025.07.14.23.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 23:17:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:17:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-rust@nongnu.org
Subject: Re: [PULL 28/97] rust: bindings: allow any number of params
Message-ID: <20250715021556-mutt-send-email-mst@kernel.org>
References: <cover.1752534227.git.mst@redhat.com>
 <04130b3dc5af620213a90d300933517b39f43bba.1752534227.git.mst@redhat.com>
 <CAAjaMXb5khPeO5bXGZ_2EALVWRg3i+GPimJygrik83f12JvFjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXb5khPeO5bXGZ_2EALVWRg3i+GPimJygrik83f12JvFjw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 02:30:40AM +0300, Manos Pitsidianakis wrote:
> On Tue, Jul 15, 2025 at 2:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > We are going to be adding more parameters, and this makes
> > rust unhappy:
> >     Functions with lots of parameters are considered bad style and reduce
> >     readability (“what does the 5th parameter mean?”). Consider grouping
> >     some parameters into a new type.
> >
> > Specifically:
> >
> > error: this function has too many arguments (8/7)
> >     --> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/structured/bindings.inc.rs:3840:5
> >      |
> > 3840 | /     pub fn new_bitfield_1(
> > 3841 | |         secure: std::os::raw::c_uint,
> > 3842 | |         space: std::os::raw::c_uint,
> > 3843 | |         user: std::os::raw::c_uint,
> > ...    |
> > 3848 | |         address_type: std::os::raw::c_uint,
> > 3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
> >      | |____________________________________________^
> >      |
> >      = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#too_many_arguments
> >      = note: `-D clippy::too-many-arguments` implied by `-D warnings`
> >      = help: to override `-D warnings` add `#[allow(clippy::too_many_arguments)]`
> >
> > I didn't want to disable this globally, so I just shut it off for this
> > file.
> >
> > Message-Id: <a4c65fb2b735740bda2874c86de31d29a5ae24d2.1752530758.git.mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  rust/qemu-api/src/bindings.rs | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
> > index 057de4b646..b4692f9b4b 100644
> > --- a/rust/qemu-api/src/bindings.rs
> > +++ b/rust/qemu-api/src/bindings.rs
> > @@ -18,11 +18,15 @@
> >
> >  //! `bindgen`-generated declarations.
> >
> > -#[cfg(MESON)]
> > -include!("bindings.inc.rs");
> > +#[allow(clippy::too_many_arguments)]
> > +mod gen {
> > +    #[cfg(MESON)]
> > +    include!("bindings.inc.rs");
> >
> > -#[cfg(not(MESON))]
> > -include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
> > +    #[cfg(not(MESON))]
> > +    include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
> > +}
> > +pub use gen::*;
> >
> >  // SAFETY: these are implemented in C; the bindings need to assert that the
> >  // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
> > --
> > MST
> >
> 
> Hi Michael,
> 
> This patch does not seem to have been reviewed.
> 
> The clippy allows are in the top of the file, not above the
> `include!`. This should be a one line change and the `mod gen` wrap is
> unnecessary.
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

Yea sorry - I really wanted the API changes in and I tried to be
as conservative as possible.

I'll send a revert and the one-liner on top, is that
ok with you?

-- 
MST


