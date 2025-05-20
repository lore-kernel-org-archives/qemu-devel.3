Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9365C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJjl-0006Va-5F; Tue, 20 May 2025 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHJji-0006VF-Mb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHJjg-0007ks-Rg
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747735090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceUj7NohcwPuRcEJq3YphgLsVLmuYSeM5JaLNINpgUM=;
 b=cly62LqucEtXgd34OM/UeT5cLOSWFuAHwpLCqxGv9yZ2583sEF0X+ferUO8NZDAw51FIp+
 XaEFdmCvu39TCjtw/fSg/fJg6eQV+1jPw1UqbgftgPmRZ79O4kXYBLNwOJAvb4BxswWXdY
 o8I62ZDqkpPqmZQeUnaIXnexXmdZsVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-9tvoagzsOheXqbGJpEfxig-1; Tue, 20 May 2025 05:58:09 -0400
X-MC-Unique: 9tvoagzsOheXqbGJpEfxig-1
X-Mimecast-MFC-AGG-ID: 9tvoagzsOheXqbGJpEfxig_1747735088
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0ce6so1102975f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 02:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747735088; x=1748339888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ceUj7NohcwPuRcEJq3YphgLsVLmuYSeM5JaLNINpgUM=;
 b=t9A37IcdSsuLgV1Td70DmHhouEmU2JVX3SOw/bUnLG7DjauPmTYzh0ocjNXtgc2QeK
 /si8PyRl1mULbC2EhVchQSdkuPlpA56rvUSAQ/aOj3Fr7Lfh8/UhX1NDq+KK47C8J/Vt
 TJ7gLYqR5LmgLccMY9dTGe/4pH5d/GB2Tsg7g7ZYoRm+AKGmGO/ib1+hK8HCzFq6szVx
 TtDS7xCOIHiKVtTqJLccDuw5obDCnX85onOUoDFysuc+3BaqlaZVgvld6Lk09FBxFy7w
 wSGDcJRcDk0IjxtKRyPhWcIfDG4FOI7y954gpn0WfRnw0QQ5YIp2n9q223dOoNgHMDas
 qiYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgqAWfUiKMo4vfPervjjJb5CveTj92vCL51Fj/PoPuiFONHUETmyybfEcOLfJaFZFP9UUqr90r6t9v@nongnu.org
X-Gm-Message-State: AOJu0YxFZR6LSFnjuwHvcTrWX/RT9xH0P+NBB+WT8Fn15uJU4cK9IzN0
 gl7RPs12sefnwZuUVmJDM/csYxJl5GFACpgGq71ZmgwH8pDXOfeoD6Ns3dpnGMehbkWigzH2IOP
 k9gk69nEzThVC4ky045DyJVases1+bo0ZFhD4tUjRLuxHXDc5FbvwohAZ3dMqdiHLpEcvEtpXnd
 PQR67OkB+bGEuMi8rYi28ZZxWMTizYg4k=
X-Gm-Gg: ASbGnct4mFvbtPxeht+PEgw2eXlCQXIuRvr2qX7Fo0+1+SFJKZ5lZhFW1cqSsTNq4uR
 Q4Wf2JpClru2VPA/6YDO4ZCB+gGTHOnCfcqQqwfcrYjm25UN89aqBR3q1vUbX2AkvXag=
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr369905f8f.24.1747735087785; 
 Tue, 20 May 2025 02:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO55mrXXsOfP0kIppOkKfntLa3RW7DgdoF+8rqOhOgpd8IbnIPqTWaU8BLWAF3TJRsFqDye2CHVwLB54j/WpA=
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr369878f8f.24.1747735087341; Tue, 20 May 2025
 02:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
 <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
 <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
 <CABC6E67-C4C7-481F-BB96-BF60957D7A84@gmail.com>
 <CABgObfbD-yHee4TXKqQ2gw7N8dtuB1wKqPLD5jLKXtJ8hx2xSw@mail.gmail.com>
 <CAAjaMXadSaKKAk6Vo-AM8RfkH3kQey9LamjC=nEDkYF0d=v47w@mail.gmail.com>
In-Reply-To: <CAAjaMXadSaKKAk6Vo-AM8RfkH3kQey9LamjC=nEDkYF0d=v47w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 May 2025 11:57:55 +0200
X-Gm-Features: AX0GCFvgEfSNrUc0UMVgSAvjorMVsU5D_ePX2ucQPo6cwhJWHsiWtqYdj00rbEI
Message-ID: <CABgObfbbuPoQZPYxE+ZQYd=WpLX=zkXiWYOqoAN6MFaX1dx7wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust/qemu-api: Add initial logging support based on C
 API
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 19, 2025 at 10:14=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> There's also the `tracing` framework
> https://docs.rs/tracing/latest/tracing/ that is quite nice for
> defining tracing events **and** spans for logs. I find it confusing
> that it still ties tracing events with log level filters though
> (info/warn/error/debug/trace).

I like the overall look of the tracing crate API a lot. One thing that
I don't like is that it's very string-heavy. In general it seems to
have more overhead than tracetool if you use `Interest::Sometimes`; it
uses Strings for event names and targets but not ids (the default
event name is even "event FILE:LINE" which is not really usable except
for development), making matches (especially "enabled()" checks) slow.
Secondarily, built-in support for fmt::Debug/fmt::Display lets you get
away with not thinking of *which* fields you want to record. But it's
powerful, easy to use and it also has very few dependencies, which is
nice.

> Perhaps this is also a good opportunity to restructure QEMU's logging
> in general. [...]
> If we align QEMU's general logging to use log levels, we can convert
> guest error logs to "Error" level logs of type: "guest", and unimp
> logs to "Error" logs of type "unimplemented". Or, "Warn" instead of
> "Error". Then, all trace_* items become straightforwardly Trace level
> log items.

Focusing for a second on guest and unimp items, do you think that
there would be macros like `guest_error!` and `unimp!` (similar to how
`tracing` has shortcuts `error!` or `warn!`)? If so, we could add them
even now, so that any future changes to the implementation would be
transparent.

> Then, all we have to do in the Rust side is implement a `tracing`
> subscriber that consumes these traces and pushes them into QEMU's C
> implementation.

As I said above, I am a bit worried about performance implications of
having Strings for event names and targets but yes, using the tracing
crate is definitely something to think about! As you say, it provides
an opportunity to add structure to QEMU's logging and maybe we can get
the best of both worlds from both `tracing` and tracetool. Do you
think util/log.c could become a wrapper around event!() and
tracing_subscriber::FmtSubscriber (with log levels based on LOG_*
constants, as you mentioned)? Then the `log` backend for tracetool
could generate Rust code that calls trace!() instead of C code that
calls qemu_log().

Or you could do the same thing to the error_vprintf/error_printf
implementations, and then Rust code could use error! and warn! where C
code uses error_report() and warn_report(). It's a common complaint
that error_report() and warn_report() get lost in logs for example,
and `tracing` could add some structure there.

It could also be a very good starting point for thinking about C->Rust
FFI (i.e. implementing in Rust functionality that is used by C code).

In the meanwhile, another thing that could be done is take inspiration
from the `tracing` API, for example adding an #[instrument] macro to
qemu_api_macros:

impl PL011Registers {
    #[instrument(target =3D "hw_char", name =3D "pl011_write",
        fields(offset =3D offset as u32, value))
    pub(self) fn write(...) { }
}

This way, even if tracetool and trace-events file remain part of the
architecture, the API is more familiar to Rust developers. It'd be a
nice addition to Tanish's work (he's my student that's working on Rust
tracepoints.

Paolo


