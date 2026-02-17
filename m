Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE5AE6815B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsI8g-0006e9-C6; Tue, 17 Feb 2026 05:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsI8a-0006de-Fg
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsI8W-0004o7-FH
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771323414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oV7wNlXhdmHuiJSLDsTo3jUOoro5SpmdVvTDCY5K2Zc=;
 b=KkmOEqqnoV9AxATkMn3BTfHQr2t018FplTsRdqSyjwF+bD/VhAuGZuGANBtHird3JA/AOG
 3xdV/7JO8XT8EgYbWDa0rOT3GoT6JG+FN/smve2QwFh/nTp6PgkS19plrHtk63weNSYAbH
 Zf3rdV/+kp87nkhElJuSCYWtI7ZKE4Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-9dFnSZEiPLSd_j6uXhjE5w-1; Tue, 17 Feb 2026 05:16:52 -0500
X-MC-Unique: 9dFnSZEiPLSd_j6uXhjE5w-1
X-Mimecast-MFC-AGG-ID: 9dFnSZEiPLSd_j6uXhjE5w_1771323411
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso3004707f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 02:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771323411; cv=none;
 d=google.com; s=arc-20240605;
 b=BLokkcmjN3Po6jCTUemZIVm0+nhuw4OXR0Rr7V3anMOBY1KSmEHYiv/r/f0Xrp7cTP
 Afrf0Z6Aj/AdS/MgRSzSa5rk2BB3LiOMbDZb9nCCbC1t3mg/y2jkMAI1AFIlq1vkoGyy
 FTKNl7gtr6t4BZf7MHj0vlCsNrYR5NZ/GHSO4+UGPs71ITlfhBAsdGrSf1iAODT7rRkK
 NXKcR8efPrg9zIbEwnO45dFuclXtoSep2TaeqdKQMTsOIKv7XX1WXrxQoetchGcAvKi8
 lw1ugVfXUXRGEuz0+FzM/IzgzAroh5DHjK7+pkxFI0PbLH2RDg3q7HpSnq42uidaoDUI
 RoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oV7wNlXhdmHuiJSLDsTo3jUOoro5SpmdVvTDCY5K2Zc=;
 fh=zvCMvoI79l4ot+6fleLhFDXT7VZUy9URy13amnIoEPk=;
 b=ZnT28zyg8XXFHV4w0QL1+KLkyXnJmCtj0SknDVuZrUJPLI/XL3qeGdzVE4LaWp4942
 oo15xyVghu4Xw8xVg6OvFsbhard8ax/KhIIC6tg7DZRxV7wNg26DgVoinNA2tUK66PvL
 +MfL6PAlJeoCtcBnNFmmtCPOIe7XJOsscsSFnTWNsePKhlIKnNdH3/d6uU+iH6j2Frx7
 SrnydX1A/lX5r+OlRQ1VNVzxVn+EfSPL63GO3erTg5tNXZ5XLUQVR0tdj12dn/pES8OA
 E55OzGB4MJ2CWUxpX3HBEYoOYYFpn+L1c/XP+0cgm1Tg9c9J6VBDcV7s2+AzvGyFvkxo
 Esmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771323411; x=1771928211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oV7wNlXhdmHuiJSLDsTo3jUOoro5SpmdVvTDCY5K2Zc=;
 b=WaO/8tUxLra6MEbcb9ztuMt1AVECOi47RtS1gK+lScPLMFS6EnOL1c68qRNH+J0rl3
 bcyu7d78xf0qZl9aOtkCCn/jvyg9X6I4lTC/B0GJKw0sAVNQqfBZ7tN6eWCy67XBM+zy
 7snBgZWEAKYsoo30+/SrATw+mlVowcRrMaCy4by4Emdoemea6igTxj2YA2WTTugFvbVt
 9VL7h2WdUCOroW0iY0N6TJe9exY+wIMu24PK9HfnjwsT2wisbBsaQEuJr7Qa5oTq7D1L
 q8vV96N+unU+RMCloyvzmpxX63ItTOlIhEFUTddhLC/UgwQDneKevd/Zu76HD8aJH5U7
 vv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771323411; x=1771928211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oV7wNlXhdmHuiJSLDsTo3jUOoro5SpmdVvTDCY5K2Zc=;
 b=r1JbTbqIqXAkNAihZf4TrOVMgM+AbiH2Hg1fdHq2UCjmcFbULSjgsGaF647+GGpoJt
 i0OlSrjIfo2L7ymEXGCCx9rRIweRbjHhHbrF0WoXIst1LNu8Ok6LGODq4wf7YgrxPG87
 6c3kTz4je02LyDzPAuM1ocHTMLnpkZz05mQh8Tj3tBODh/MtoXFSftrD7y9JtcQYdRKU
 NMN8563xUlwGRnYs3XwzPJtdWYsnmicEmVI5YNnA+mhKqlILhrWmfyA9o35akAdiJl97
 6yGX/fGdL2AM7+Hc05FO3EnRQbRtUn5NQ0iBcgGXgYW7SmrriDMsG4hLj0/nZd+RtP6u
 Sugg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBaQ74YsbzrDJrRI+KyB6uflsxZl1pVqTY/vNzqF78sPKKEqjTYYlaiH7tteQEOp9wrn+K81nU2TqE@nongnu.org
X-Gm-Message-State: AOJu0YyjHV9e02UWXZoE95Mr5rcfOuC+6mnw/TlomVHAULV7ZIUTyDlp
 1LLbolWyPipe4NPNj2yTC5xtiP9rvyRv0nrby+J7TcP0VET3c2gc55dfmaLG5lBtefCkzBgX1kO
 4zroD5cjWBWdvQjU5TEWqs1mI5yo7AEZi7QwxV8FMpYoD6IH/j+cP0rlNwrDSTHtq8fbjIlrcKm
 1Qas+b/BeWDB8DgP/waVOyDvoTy53b5Wo=
X-Gm-Gg: AZuq6aIOa6T6fOpXY/2xyfPOSMiRX2dycchmLIv6dtL/XdPwhPcFLwKQvvwWIXcba4n
 CPwrVnyqE9ZRurAuOcGNZV02pCj1XPIU4c/wPbeHzvFOpqXqIgSudejaLrJ1hcDvJlsBiUyzDgf
 HKBH0cx4HVh1jCMKk8cRvnGwc7qpGD1w5EcQ+jIr4YIyjN895it6P/APcGdVJ8wJ3VA7C6FPHgG
 LBtlBQKk4haadNAY26teukr2WU7Tc4GcsuZJtVcROsZWZqRfUJ2ROw7z8CWGi/5JnvFmaxCsztL
 BOPFTM0=
X-Received: by 2002:a5d:5888:0:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-4379d619f9bmr17384437f8f.25.1771323411172; 
 Tue, 17 Feb 2026 02:16:51 -0800 (PST)
X-Received: by 2002:a5d:5888:0:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-4379d619f9bmr17384392f8f.25.1771323410715; Tue, 17 Feb 2026
 02:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
 <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
 <CAFEAcA_Q78GwXS0Uia1fFdPoDwkofD4Wr080EkG01gGD-d8Pgg@mail.gmail.com>
In-Reply-To: <CAFEAcA_Q78GwXS0Uia1fFdPoDwkofD4Wr080EkG01gGD-d8Pgg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Feb 2026 11:16:38 +0100
X-Gm-Features: AaiRm53RcUP0IiTMkATJEcHXuxJExoMR44BaqUkdBdgPjQJCAHMQcMyi9IhZQU8
Message-ID: <CABgObfadO_=MTyG+MJuC9p7KNxYNDngpTUmyrxR63E4TLpR6wg@mail.gmail.com>
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 17, 2026 at 11:06=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Tue, 17 Feb 2026 at 09:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > The problem is that "-audio none" uses a silent backend but still keeps
> > all the audio/ code around.  If you prefer to keep the Arm boards
> > around, the solution would be to disable the audio code in the
> > individual pl041 devices with "#ifdef CONFIG_AUDIO", so that the
> > "depends on AUDIO" for pl041 can be removed too.
>
> This seems weird, though -- why would we put in a lot of ifdefs
> in every single audio device, when we could instead say "if you
> disable audio at build time what you get is something that presents
> the same API as the existing audio backends but does nothing" ?

Audio is special, it requires real time operation that is non-trivial
to setup and consumes CPU time (and takes the BQL, introducing jitter
in MMIO too). For pcspk for example the callback runs every 0.05
seconds (18 times a second) approximately.

The code to setup this is in audio/audio.c and is independent of the
backend. It is triggered by AUD_set_active_out (which causes
audio_is_timer_needed to return true), meaning that "-audio none" runs
a lot more code than just audio/noaudio.c.

In addition, this real time operation is reflected into the pl041's
interrupts, so you could have guest code that synchronizes itself on
audio interrupts and a hobbled pl041 might not work at all. Unlikely
for Linux guests, but bare metal code might do it.

> Also, I think we should be consistent here, not put ifdefs in
> some devices we think are "important" but skip it in others.

pcspk is indeed "important", but (especially) it has no interrupts so
there's no risk of breaking guests by removing audio output.

Paolo


