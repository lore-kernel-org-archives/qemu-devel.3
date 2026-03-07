Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2ABF55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 20:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyyZ8-0000hW-QL; Sat, 07 Mar 2026 15:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vyyZ3-0000h6-K6
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 15:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vyyYz-0001fp-Sd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 15:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772916468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8dmSi/2RqiU55DqJbryD7ZofuugcmJ7qI35AmxO86c=;
 b=FG7w+LZzxHypTflH3+enluhgxdobwVbl1J8KbKclnola4NANv/4LU0WBBb5NbRJeYf0dRM
 IEi5o2GfORRGza5icA4CXYNK++tz+k5w3zySu6MPT5uQUls0nZNx8e99qE+JIaCxXgRPMV
 jxM/XnBFqtyAlU94aa5YPKvdy40vrPY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-B49AnnsYO6KK1YfUj_E0gQ-1; Sat, 07 Mar 2026 15:47:46 -0500
X-MC-Unique: B49AnnsYO6KK1YfUj_E0gQ-1
X-Mimecast-MFC-AGG-ID: B49AnnsYO6KK1YfUj_E0gQ_1772916466
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35983ee9f3bso7140825a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 12:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772916466; cv=none;
 d=google.com; s=arc-20240605;
 b=WYsHkk5Ncq7ojBPGdcau7LkrwPhOcyLMzFmd5XFXtmlSHv0hjyh7QxV/WuQhgVWToR
 VRATUAEnz4rhEMf6FybSFzFwJ8JLi0Nu3Z2ZQp8B3SAdXDsahoVpe5aDxATELb927C+X
 v2hMvwtrVbv2saXY0nVC0zktYs5cZxziKepAuvrhZwfN8T7gS39OYpdY9s02a1Bk1Bg7
 yo9D/CpLTqEGA8y/RDQgfm7ow0oq5TtDPUZTW/wU5Ug+8pnqxRdmUsBbZIbtPtZ9iwKF
 /3KAcSaN1WPNIqK+qFyzVD8CNdj1Np/l4wSViuHwqwPH4c1qrbzhTx0jC952WUC4KKfo
 DBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q8dmSi/2RqiU55DqJbryD7ZofuugcmJ7qI35AmxO86c=;
 fh=XgV4NwlJdv5QgomRnRvHEs3kXfQOA9/51zRCfgB3T2U=;
 b=k/0/FFlPFAabfk8oNxr/7Fj22tDmTGiLeMx7LlZSot72Gaf3g4XGnuFa+PzjHLAHtx
 1BG8nf04B6tXV9j6oDkN1RpQ6DvFI6k9hOs4C2DQuqqbrlC3UB8+5R5QtwtPJfZLzNPA
 oQIt7/LPXZezNmcumZyxmA13seUgxkJ1OsFm1zrqvywCkosUHIR0Om50f5upjE1YkLg6
 jjUfORO3r1z2qWUrSf7MtJe73VYPI2ipNKN8YJeQVW8c2Q97rU8p33EQU7LRL2CsUiEp
 Kv0KGq5nSaf42tVHbbiZ5rkURGT+hGGnAj9qPhsM/0W5FlwZHDs6Omchcnt+KTc3j0OA
 ZkWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772916466; x=1773521266; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8dmSi/2RqiU55DqJbryD7ZofuugcmJ7qI35AmxO86c=;
 b=dGpHT8NH8z7g03K9ompLqYPDUbcr4710u1dw64Zr1UulRQ29mbsePEkEaEofy+vUNv
 3hRG+4RAckZPBwFZvVClv3VjbYtFIhbicCROr7GGG6KqQI/cr8IuABP6kzCC5TKT3i3q
 /zctoI0pOrU/kUCgeRdKGq4PgSGfo9A5nlTqWNFlM9jUTvL4TXzd2Ziv6k4LoE4Zwdgd
 NCae6uDo3zJpBJzKsxXwLBiH7OqRiRSaYpnlhTe4DW9SWK0uu/imJO4ZKuAclsHW1Ed8
 j1bA8LTEmjNxUIqXM+FW2ipugCyG6OdzPQsedm9AP2Xz36iO5GYedaYIp1PZK1SfykJF
 s4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772916466; x=1773521266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8dmSi/2RqiU55DqJbryD7ZofuugcmJ7qI35AmxO86c=;
 b=OaPMMtSt7MlFJRelNQAK3P/Z+RjpMOxlmRe5E1yerUlbBcbSDtxaLEFN4TyiPg0rcc
 CMo9++0rUHhj4nLocC/1gP2F3En2afX2Mo4Vgqtg52ZflaDmq//BYrK0a7FVOJLjpOoV
 xX1oeX/EGsBcZpJyu5FTS5G6LBCTSOITm+q70dRrvAgt5IXITWOlXq36ct84FlKm8XgH
 W9aH1ybHk/ajoceLzcUVxGBtZQHL0Z87K6iVvsEiTKaO0qwD3R2qE1nji5gGrq04xbXB
 CJiXjpV54gJSbirrLEfJgJV1B0pHYH0pIWna1fsWaWOQyBeALQ3I4GET4juHEX7XVDj9
 cSWA==
X-Gm-Message-State: AOJu0Yzixa4rzM0+BJRsxGCrBWRtCVOYtU2NbXMx7v5XDc4BCLMi1W1y
 hR7GWeQUW+B5ffS5X7A+UpUExDK7KjJLjwsmyZFlJf7ufRXYzMCEA0S5x4936HTenVDqiMnMrFC
 7i/EBQzOg8cigTWl43h2APna+1YeMGrpucBzNMOQJDqpy0dA5PFbAPW3vP44EfNmjwVgasdNvcE
 +yQQvFkq/pHgJDZoue1Fcc5jyAGAcQLhE=
X-Gm-Gg: ATEYQzzAveaNBYA4EGOr850bKmWQZzrUjX79TLpLDerQyy4tIuma7HdSPvy9IXA44Wx
 A45/8xB8qg9WagKdC5pxHQgQXbhessJTwwz1tGLJWMyXdksggCnh6xBIYlU30voVtdcC0MBJf2t
 nJK88JHgXzIW4GdvY0KAEtaatcoYtuJbNiYok7SpGSzBqfXKOEphkrFxh+7VzUCJzPWgQ/xjA0B
 7SqOygdnYhAbdyn6iBiTzplRIriM3/A+hRbLqMtITqpWpV972lGGIdI3wr1EYGCtfrHSBJ0WlH4
 CHqkPKL3Xfb7EOF88uvIVY0=
X-Received: by 2002:a05:6a21:6f13:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39858fda43amr6286563637.27.1772916465727; 
 Sat, 07 Mar 2026 12:47:45 -0800 (PST)
X-Received: by 2002:a05:6a21:6f13:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39858fda43amr6286556637.27.1772916465305; Sat, 07 Mar 2026
 12:47:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9X5khjbOYcnbQVG9vRNhMRS7WB4eMo-UhSJD+cpWx9Zg@mail.gmail.com>
In-Reply-To: <CAFEAcA9X5khjbOYcnbQVG9vRNhMRS7WB4eMo-UhSJD+cpWx9Zg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 7 Mar 2026 21:47:34 +0100
X-Gm-Features: AaiRm50KI8k2-JD9-teRnQRfuY5c7vePqL38qO366xuccZRRPmzsXreh3sorDmI
Message-ID: <CAMxuvazHaYg8iHgDzwKP-h4O5cExXRW+XfOK=MP7046_+DvsHQ@mail.gmail.com>
Subject: Re: memory leaks in dbus-display-test
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter

On Sat, Mar 7, 2026 at 5:08=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> Hi; the dbus-display-test when built with the clang address sanitizer
> produces a lot of memory leaks. Repro:
>

Please review
https://patchew.org/QEMU/20260122113144.2046899-1-marcandre.lureau@redhat.c=
om/

It's in my UI queue already

> 1) configure with:
> '--cc=3Dclang' '--cxx=3Dclang++' '--enable-ubsan' '--enable-asan'
> '--target-list=3Dx86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux=
-user'
> '--disable-docs' '--enable-debug'
>
> and build.
>
> 2) run the test with:
>
> (cd build/x86-tgt-san-dbg/ && QTEST_QEMU_BINARY=3D./qemu-system-x86_64
> ./tests/qtest/dbus-display-test ) 2>&1|less
>
> The 'console' subtest will cause it to output a lot of leak reports, e.g.
>
> Direct leak of 208 byte(s) in 2 object(s) allocated from:
>     #0 0x64e038cdfadd in calloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/tests/qtest/dbus-display-test+0x2=
58add)
> (BuildId: aa998e9bf2752fab128fa39c22c94bbb5b77ce2d)
>     #1 0x7ef13b191771 in g_malloc0
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x7ef13b2b7f65 in g_type_create_instance
> (/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x40f65) (BuildId:
> 91bcc5d52326f5490fa62acc824cb87c700d0f8a)
>     #3 0x7ef13b29da63
> (/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x26a63) (BuildId:
> 91bcc5d52326f5490fa62acc824cb87c700d0f8a)
>     #4 0x7ef13b29f015 in g_object_new_with_properties
> (/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x28015) (BuildId:
> 91bcc5d52326f5490fa62acc824cb87c700d0f8a)
>     #5 0x7ef13b29ff70 in g_object_new
> (/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x28f70) (BuildId:
> 91bcc5d52326f5490fa62acc824cb87c700d0f8a)
>     #6 0x7ef13b428809
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14e809) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #7 0x7ef13b3e7d96
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x10dd96) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #8 0x7ef13b3e83c2
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x10e3c2) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #9 0x7ef13b3fcad7
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x122ad7) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #10 0x7ef13b38b7ba
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17ba) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #11 0x7ef13b38b7f4
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17f4) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #12 0x7ef13b18b45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #13 0x7ef13b1ea976
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #14 0x7ef13b18bf46 in g_main_loop_run
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #15 0x7ef13b3f4581
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x11a581) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #16 0x7ef13b1b9e61
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8be61) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #17 0x64e038cdd3dc in asan_thread_start(void*) asan_interceptors.cpp.=
o
>
> Indirect leak of 1228800 byte(s) in 1 object(s) allocated from:
>     #0 0x64e038cdf8f3 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/tests/qtest/dbus-display-test+0x2=
588f3)
> (BuildId: aa998e9bf2752fab128fa39c22c94bbb5b77ce2d)
>     #1 0x7ef13b190ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x7ef13b1a6532 in g_memdup2
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x78532) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x7ef13b1d2d81 in g_variant_new_fixed_array
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xa4d81) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #4 0x7ef13b425412
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14b412) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #5 0x7ef13b42520c
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14b20c) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #6 0x7ef13b3f0190 in g_dbus_message_new_from_blob
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x116190) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #7 0x7ef13b3fc6a2
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x1226a2) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #8 0x7ef13b38b7ba  (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17ba)
> (BuildId: ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #9 0x7ef13b38b7f4  (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17f4)
> (BuildId: ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #10 0x7ef13b18b45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #11 0x7ef13b1ea976
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x7ef13b18bf46 in g_main_loop_run
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #13 0x7ef13b3f4581
> (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x11a581) (BuildId:
> ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
>     #14 0x7ef13b1b9e61
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8be61) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #15 0x64e038cdd3dc in asan_thread_start(void*) asan_interceptors.cpp.=
o
>
> and many others, for a total of:
>
> SUMMARY: AddressSanitizer: 1232414 byte(s) leaked in 86 allocation(s).
>
> Nothing in the backtraces is in the test program itself -- it all
> goes straight from libglib to libgio to libglib again. So I'm
> not sure exactly what's going on here, but presumably we're
> failing to dereference something we ought to.
>
> Could you have a look, please?
>
> thanks
> -- PMM
>


