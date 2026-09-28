Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E00ECA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHff-0000Ub-6a; Mon, 28 Sep 2026 16:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBHfb-0000U7-Tu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:09:52 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBHfa-0007wf-19
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:09:51 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3413069aa25so2254694eec.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 13:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790626187; cv=none;
 d=google.com; s=arc-20260327;
 b=Tt2i8+WyC0bDfSAw4flT+z0p4Reb8lIjg0FUjJUynHaJwtFTZMdYOULFrWod5c0jJp
 VgbeDshxIcKRainnA+p+i5BsKIwkRmM+puCgvdAA9KiPi0sVdolyGvH35Q0CvybHjnMd
 zd1W4mIO3AvSNdB5aEaoqdNWuH/Uhf8aL+qj/1lzJUtCiTmFm5d/hXO/6uMy6i1HV7qD
 u4mAB6iKkPWTAN3dgqvMt/XbY8yIATxeiWyw+6yZ3hnrymTAewsnG8LT4R0bOSV2yPhH
 6OE5Epgrtj3PL+iokUX2HzWlufbacvspew3csMNsSMEhsr/gRwQNyGlpxdb2mdwZeLau
 8fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TYUJAuudZlxbhn+/MQ9KE+584hyQsSjCbgZhYA9QhEc=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=kgvj6Vf5pIfrWqFK9Fg68rzq8PdS2F80xXJvzZN8WYt8xte3I9Bn8JS/ARBsD3UTYt
 hzSX2OXOysXL1ImqDN+Ha97BiORANJh5KnMiRAd7vaFrCp23sWZN39Y2L75kEivLvwQC
 abEY5ELnwQ2v/r2w5zWP9awXjSMEvcIN/IVikkF/ZMptQPcCGI5Bj2Ww3SqGRjPNujs2
 81/Itu4iCi2yon9neeV3HiohBFfAk8Ld2pudaOiF13fkGOshvnyCNokbx0egFqLy9YuK
 at7/E4sovRz/+AM2ARiiBifsKU4Z8aGAdxeTb0FPeIbx/LujARCEyZQ/Jw+dSAPeWBD3
 foBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790626187; x=1791230987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TYUJAuudZlxbhn+/MQ9KE+584hyQsSjCbgZhYA9QhEc=;
 b=c8n64P4ChqCRUNzpuo+Ac/YeJYsnHO4/r4vS4OvQrCqaXPhQDPVFxVjCUNmsIR+tvi
 u/SlM4hngxTnNjr2nWSZ0bG7w8iFjDWCwVOxXmzsCQ2u+dIuuP43krm24AHH4HfNS+Gu
 R0ZKDVs47bUN/oqVKLGiBXfqTN3S6w/QfHLeVtG3WONitudXbfh7tdaiLF7AnIDEyZTl
 GKdU1qshexe2SWxK3JuWuD0g5RK/tWVvRztNHUoJkfYsSXFSYZV5dmsjZXvmzpEZfWuF
 GfNWj4dqW2iW9CsgCxLvLYw65VgMMWGVQRWCAndd+BwsqeqBrbamhd2J524pR7piOEa2
 9jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790626187; x=1791230987;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TYUJAuudZlxbhn+/MQ9KE+584hyQsSjCbgZhYA9QhEc=;
 b=hk2TgJbCI+P6TvfTyUEQJmmqvO0X+ptmUUGVDtLc8cbtSBMTsR1ku9Ui9ZwWXJVie4
 dvHU7vnU0cMSkeePC4o4ecPToVVAIlGTeuHiJQOH6vIoqI1AJSHHY+T9r4tGpyj5kihe
 xDHRo15vh89Cfr3u/Q5Tf0Oi7s3e7gPALG0GEhGIG+7dUDY8smDQdCpTYpmXKgCLKPmB
 MIJJXhF8QeaS+RT2pv1OLqCJR/mvqgEoLgXkrrbRUgG5hc2PBh5s7mLJ+2tgS7GFirBi
 CBrbGYusa/hyINNqXGmw+NQuy5gV2JdofbLS6qtYCEJuVcYZX+b/s0yB6KPo7hHRIhg5
 yOdw==
X-Gm-Message-State: AFq9FYI+9hBjoEcP+pruIw18EYCet97ysc6BBoAeCL2MTKcE8+43N/td
 +1+XlEb/pK0bufwJVADYmZwTzScslWu2pax+1gyj9IclZqQbGLTVZ0maUuOJoVlrZOySNuhxUHo
 S2K1ddj17T9AzqEnWqya9Zuklosy8CSw=
X-Gm-Gg: AYBFou2aPxv9yqI/GWHVltt5tuWQVB7b27RcrwCrKB1r3+fRBWfLzbm/qGcizk1C+UN
 4dKFejMDxvF0YTMxi2eR+DU2pamfOfViMFYsE27AYS/zk5j1vjBd+eJvTw3G15IhS8t7U0cyxgx
 yIRkemmWQVf2DPkP82KpB2GIef3BAGCZKGQHW0pOVrpr8jRSnSVADwXsCg3eNZA1NI/Hw/bRuK9
 OxmXFYw51JzPC2WtyM91nljo+B5suJtP4tKi3O+3VqL75F7CSH0scsYxQLSUyVx2q0lRjaJ8O6V
 ALMibLojqiPP6R4uUHolz4hta62RwaQTrZHrsbnsUBQOdPN01JOuAQWwwBK884cpFLsyttlvd5n
 esZARqBXEzO/FQLfMvYHyLg==
X-Received: by 2002:a05:7300:a986:b0:328:7033:9b8c with SMTP id
 5a478bee46e88-342711ac458mr16917380eec.6.1790626187375; Mon, 28 Sep 2026
 13:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260928130904.3921495-1-berrange@redhat.com>
In-Reply-To: <20260928130904.3921495-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Sep 2026 00:09:35 +0400
X-Gm-Features: AclHuK8XG2a6Wuy15TOyhcekcudx8hSIBCiw8-sWi935o7NFi7OO7ar2E7ujQ4o
Message-ID: <CAJ+F1C+CqVB45HLPNaiwJJjbnrmwNAkDu=kGN=Ut8OsBW4VdYA@mail.gmail.com>
Subject: Re: [PATCH] io: prevent unbounded read of websocket data from client
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 28, 2026 at 5:09=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The QIOChannelWebsock class wraps an underlying QIOChannel instance,
> providing a websocket server handshake and packet encoding/decoding.
>
> When a watch is added to QIOChannelWebsock, this in turn creates a watch
> on the underlying QIOChannel that is always monitoring G_IO_IN, as long
> as the 'encinput' buffer has space.
>
> When this watch fires, it reads data off the wire into 'encinput' and
> then decodes as much of 'encinput' as possible into the 'rawinput'
> buffer.
>
> The qio_channel_websock_set_watch method checks to see that 'encinput'
> does not exceed a max limit, but fails to check that 'rawinput' size.
> Since any data read into 'encinput', can usually be immediately decoded
> into 'rawinput', the 'encinput' size check is largely a no-op, and so
> 'rawinput' will grow without bound.
>
> This is readily seen with the chardev socket backend if enabling
> websockets, connecting a client that sends data, while not running any
> guest OS to consume data from the chardev via a virtual serial port.
>
> The qio_channel_websock_read_wire() method will also unconditionally
> read more data into 'encinput' if it has less than 4k present, which
> is then decoded into 'rawinput'.
>
> IOW, if qio_channel_websock_read_wire() is triggered for lots of small
> reads, it will be reading and decoding more data to 'rawinput' than is
> consumed. Skip reading more data if 'rawinput' is already at its max
> size.
>
> Reported-by: Aisle Research
> Fixes: CVE-2026-101291
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

not sure if it's worth to add:
Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")

> ---
>  io/channel-websock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 461abcae487..646cd45be2a 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -970,7 +970,8 @@ static ssize_t qio_channel_websock_read_wire(QIOChann=
elWebsock *ioc,
>  {
>      ssize_t ret;
>
> -    if (ioc->encinput.offset < 4096) {
> +    if (ioc->encinput.offset < 4096 &&
> +        ioc->rawinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
>          size_t want =3D 4096 - ioc->encinput.offset;
>
>          buffer_reserve(&ioc->encinput, want);
> @@ -1091,6 +1092,7 @@ static void qio_channel_websock_set_watch(QIOChanne=
lWebsock *ioc)
>          cond |=3D G_IO_OUT;
>      }
>      if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
> +        ioc->rawinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
>          !ioc->io_eof) {
>          cond |=3D G_IO_IN;
>      }
> --
> 2.55.0
>
>

