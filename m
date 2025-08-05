Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFC3C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNwP-00045z-Ac; Tue, 05 Aug 2025 16:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujNwH-00043i-Q6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:07:19 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujNwE-0004Hj-5d
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:07:13 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4dfa2aeec86so4845147137.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754424428; x=1755029228; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+M5UR3LoHP/3zpg8bb1OP9EoCk8splBA+X4lHdFz1L8=;
 b=KBUXP+cH71sB9SkRzC79g5XEECy0g3gtSAS5T/uXR3oSPld3ZLdgc9FiR+qEpfNaPh
 /VfRBDpyqsqhZtDsAUECj220gpxZyYNHWTsUSBeqQ+DvLbZxVOk53TvUfDwe72xw/SPL
 sBKRUFdqAe9tcnO5LJnoDEVmdX/lpwgOYFs16F1TBDqNt9n5DwrroCdmVeh+9Qi+iE6z
 zPmaNLvl5oWlwFf6x1suEhRm94BtMwYefNd05CU0c8k4aSikZTLhPcqpmotCWFPYuTGw
 Igh0ktbs4IDK/I5cQ4iDru6ai8KPmevQXrbMxoUoHD1y/sAD3jT7Uit3RSNf6mUZYEKB
 Fgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754424428; x=1755029228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+M5UR3LoHP/3zpg8bb1OP9EoCk8splBA+X4lHdFz1L8=;
 b=opY/44cECnxG9AW7VQwfEZOvQl15riewogBCUBrK7VgF2npGoqJLWAyT+3QUxSNdWM
 QFxXNTErofBHUNUuDUGDOAgGEaJBT+oo8743GPwIY+b3pGeTfY6oAN3vzBMz0gccrbl8
 85A5fyOyHwyARZgqUni+Ocl/jUX4vPTpSIChpMe0F+zK09cjV9XKtQ/IBZRv6VnJofyQ
 yn2wqKh8srobRrz/VkzXOMrwYqN1wBjb4EJ0U4JYrrni0L8bs9dvppRy27DXu8FEl1bo
 I8kxGxdfL1YEv4pHsfE6B5Ef4pQFbXKNPd5XZAlirpaXe3j/HEr5X4xKURTjy+GXTdrR
 6vDA==
X-Gm-Message-State: AOJu0Yzu8ySQV6EJ/HgllPeYi41W9+8j3NcI96QUekah/WJGmnGyQf6U
 DNJKc+T252kD8V5pifS/n6tlzak29IsJ+Z3/ISwRNgl40mMTpKv7VGh5+jd8Vmxyu9Dlp6HvbTY
 WOZ559VPmvN4MKh/+TePoDo6uMPy9MWtgrdcyGwlsEFu0DWNa/c7KWTfBzA==
X-Gm-Gg: ASbGncuyEQduqbKgHCFBtcNIxPDCjxsY8aVBKHuhbzoIIjnOy18B7GhLoPr7L3ZH3UQ
 XklLqLFRnKlr4bA0u96Np3Zv51pbra3fJdWAHQBbZg6Z42/NWwDppRNEq3qWBJTuZaW5ZD67wXA
 nLDI7QJUqJL63w+fEA2hzEO94YfwJflVfMDub94ESMumnY4Uiwt5q6zDpnwDPWPH1yGBid0jTBl
 35ZC2M3CJ3me0S7n+o=
X-Google-Smtp-Source: AGHT+IHT9asMWiRzrcOQViUD675lp+aQQ3OWkuZuyrP+dKlh8J6MfxQtk3H/2eDtYpCdQhz2yzVG6B4caqgpm1GDwjw=
X-Received: by 2002:a05:6102:c04:b0:4ec:b2cc:de60 with SMTP id
 ada2fe7eead31-50379034525mr47200137.11.1754424428499; Tue, 05 Aug 2025
 13:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
 <aJJFVgkt7R49ZwIF@redhat.com>
In-Reply-To: <aJJFVgkt7R49ZwIF@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 Aug 2025 23:06:41 +0300
X-Gm-Features: Ac12FXzHbByIA96QwbkFshFybyVGOGYyWjYhq_coJYazT85NFeQ2fippHTTtFbU
Message-ID: <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Daniel,


Thanks very much for the write up, I think I understand it a lot better now=
 :)

On Tue, Aug 5, 2025 at 8:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 07:47:39PM +0300, Manos Pitsidianakis wrote:
> > On Tue, Aug 5, 2025 at 7:43=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Tue, Aug 05, 2025 at 07:25:39PM +0300, Manos Pitsidianakis wrote:
> > > > On Tue, Aug 5, 2025 at 7:05=E2=80=AFPM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> > > > >
> > > > > On Mon, Aug 04, 2025 at 04:47:13PM +0300, Manos Pitsidianakis wro=
te:
> > > > > > This RFC series contains some simple patches I've been sitting =
on for
> > > > > > some months to allow tracing in rust devices in a similar matte=
r to C,
> > > > > > only it's done via a proc-macro codegen instead of using tracet=
ool
> > > > > > script or equivalent.
> > > > >
> > > > > IIUC, this series is only emitting the traces events via the
> > > > > qemu_log function, and so feels like it is missing the benefit
> > > > > of tracing, vs the traditional logging framework.
> > > > >
> > > > > In our RHEL & Fedora distro builds we disable the log backend
> > > > > and enable dtrace, so that we have fully dynamic tracing and
> > > > > observability across the kernel, qemu, libvirt and other
> > > > > components with dtrace integration.
> > > >
> > > > Hi Daniel,
> > > >
> > > > Thanks for the insight! Do you have any points where I should look =
at
> > > > the trace implementation for how the different backends are support=
ed?
> > > >
> > > > So I think there's already work in progress to support proper traci=
ng
> > > > for Rust, I only sent this as a temporary fixup to provide some kin=
d
> > > > of parity between C and Rust implementations until a proper, better
> > > > solution is available that can replace it.
> > >
> > > Can the rust code not easily consume the existing functions in the
> > > trace.h files generated for the C code as a short-term solution ?
> > >
> > > It would not benefit from the code inlining in the same way as C
> > > would, but it would at least give feature parity for tracing with
> > > all the trace backends are available.
> > >
> > > Then, we can look at optimizing with a pure rust impl of some
> > > backends at a later date, to regain what we lost from lack of
> > > inlining ?
> >
> > It can, but we'd need to add extra intermediate steps to convert the
> > trace headers into Rust equivalent code, so it's not ideal.
> >
> > I tried to generate code exactly like the generated trace headers
> > though, so I'm not sure what is missing to be honest (hence my
> > previous email question). The generated code generates TraceEvents and
> > registers them with trace_event_register_group. What else is missing
> > to support e.g. dtrace?
>
> 'trace_event_register_group' is essentially irrelevant for the
> fully dynamic trace backends like dtrace - that's only used for
> the backends whose output is controlled by QEMU monitor commands
> / command line arguments.
>
> In the dtrace case the binary gets instructions which are a squence
> of nops normally, and dtrace tool gets the kernel to live patch the
> binary at runtime to put in a jump for any probes that are being
> watched.
>
> Take a look at the generated files <build-dir>/trace/trace-*.h when
> using the different '--enable-trace-backends=3D...' options.
>
> eg taking the trace-crypto.h header, with 'log' backend we see it
> emits
>
>    if (trace_event_get_state(TRACE_QCRYPTO_TLS_SESSION_CHECK_CREDS) && qe=
mu_loglevel_mask(LOG_TRACE)) {
> #line 23 "../crypto/trace-events"
>         qemu_log("qcrypto_tls_session_check_creds " "TLS session check cr=
eds session=3D%p status=3D%s" "\n", session, status);
> #line 372 "trace/trace-crypto.h"
>     }
>
> but with dtrace it emits
>
>     QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS(session, status);
>
> which is a referencing a macro created by the external 'dtrace' binary,
> which in the Linux case ends up looking like
>
>   #if defined STAP_SDT_V1
>   #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS_ENABLED() __builtin_expect=
 (qcrypto_tls_session_check_creds_semaphore, 0)
>   #define qemu_qcrypto_tls_session_check_creds_semaphore qcrypto_tls_sess=
ion_check_creds_semaphore
>   #else
>   #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS_ENABLED() __builtin_expect=
 (qemu_qcrypto_tls_session_check_creds_semaphore, 0)
>   #endif
>   __extension__ extern unsigned short qemu_qcrypto_tls_session_check_cred=
s_semaphore __attribute__ ((unused)) __attribute__ ((section (".probes")));
>   #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS(arg1, arg2) \
>   DTRACE_PROBE2 (qemu, qcrypto_tls_session_check_creds, arg1, arg2)
>
> you can end up enabling multiple trace backends concurrently too.
>
> If you're thinking this is all rather complicated, you'd be right,
> which is why for initial feature parity I figured the simplest is
> likely to just wrap the existing QEMU inline probe function, so
> Rust doesn't need to know about the different backends... yet...

Yes, that indeed makes sense.  Generated C trace headers statically
linked to a standalone trace crate library for each subsystem, that
rust qemu crates can link to in return is the cleanest solution for
this approach IMHO, because doing this kind of codegen via macros
needs interaction with meson to generate the C sources and then run
bindgen all while compiling this one crate which is a single meson lib
target.

It might be possible to generate the equivalent of the C code for each
backend just like this RFC generates only the log backend code, I'll
take a look out of curiosity...

>
> FWIW, the original DTrace authors created a Rust crate with native
> rust integration of dynamic probes.
>
>   https://github.com/oxidecomputer/usdt
>
> I think that (somehow) we probably want to integrate that with QEMU
> and its tracetool.

