Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3FBC35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXW3-0008Jl-Et; Tue, 17 Sep 2024 08:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXVz-0008Ih-96
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:41:07 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXVv-0002XB-8m
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:41:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c42bd0386cso4620747a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576861; x=1727181661; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoWNgzRNzvsVgNlZHKuj08Z40X/Ok4jgEHeAr7pYfdg=;
 b=orf2uMGTfLXEWoM+QR/MXHx9bUtP6Kf5wXxbUHqcX1PgCHLRot3UWm6NoTRtV8C5yV
 eolA0mz8Sq1ZkYV/LUIZ/HPQ3F2ee9PtEZ2CzzcLe8XB35972Oc3qjProbF1Ivf1PMD2
 xsEkByHkQD4IhFPIE/TLMhL8HHQVJUnVKMR82ic0bgGcc8TJZ8UFAY2lmotBjE/iJcF+
 IowOEFt47fH5ye/5H/2Alj/yu3HlYuU+GUVmUBtUcScyyMaZCeD95tQRnG/VWeErdUAf
 OZkPavTmzYo04Z5qm0blUkZ8OZKLKc5b3b0+lSqqTSpEt0jv87rQHmelXgobukEMuACX
 YHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576861; x=1727181661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VoWNgzRNzvsVgNlZHKuj08Z40X/Ok4jgEHeAr7pYfdg=;
 b=DqXrW09R2cnqFJztsAJ4k4sDN3VNOsB/djrMBMrV0kYlI3N1TJTKd3OGO7LauBcEfC
 YGpAgxpV++K+mWePU11RRk7cd2cpuvw/P6iSpxEkiA3jXHHKR5d9mZ7GbI1XPeLf2x2B
 YvzgOVzCUggedmqccn94yCD8dpL8rJZmbrgK85oOzcnKQC4XMfKxR1cCv+ZdZeSXkyOI
 0tkLHHl7lfuUylD5OeXT8S5uPdf1cB6K9y6QlWByUPUC7fC0CcflIxrNIIJvgC1xnd4M
 +IBx8N/nbeos6YoqLjo32agMEY8FhBym963TcltH/5Lyv030CGxqFJfmISBf+PMIWSXd
 J5uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUreAHoDCwNZxfxXaE/sip4dJ1mKnV4q41fV6VR5uFNBncT3zm3Pf7Re719rNWha67Yyk+SruTxd0IJ@nongnu.org
X-Gm-Message-State: AOJu0YyASgW9mqP/p84se/nP8sy3XKX4SH/eFTjLinI5Za2ddZmmkwyI
 vCE271oX5/PisO8Xd844sb0K9+i/e71dTTGoSRPaZWIrADaYPVNLXNGVLue/5goWhs94XH2h1KK
 KR0nhIn/qoLv89IC5CTYxX7xBbDmMDMkrhhDksA==
X-Google-Smtp-Source: AGHT+IFddQGZPh7ufuTrxqAFojepcwLGWOdXnososvk+dWlheg63IYTwcV4CD9ChUJbzD7tz2vePxAmLFe488NmuP7g=
X-Received: by 2002:aa7:d91a:0:b0:5c2:634a:fc1e with SMTP id
 4fb4d7f45d1cf-5c413e4bcc1mr17317840a12.23.1726576860947; Tue, 17 Sep 2024
 05:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
 <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
In-Reply-To: <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 13:40:49 +0100
Message-ID: <CAFEAcA96LM9fe5bTOVVAz3PuNfAt_aGr_6gq3BP9wfFq0Y3OwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Roman Penyaev <r.peniaev@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Sept 2024 at 13:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Roman
>
> On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
> > This patch implements multiplexing capability of several backend
> > devices, which opens up an opportunity to use a single frontend
> > device on the guest, which can be manipulated from several
> > backend devices.
> >
> > The idea of the change is trivial: keep list of backend devices
> > (up to 4), init them on demand and forward data buffer back and
> > forth.
> >
> > The following is QEMU command line example:
> >
> >   -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
> >   -chardev vc,id=3Dvc0 \
> >   -chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \
> >   -device virtconsole,chardev=3Dmux0 \
> >   -vnc 0.0.0.0:0
> >
> > Which creates 2 backend devices: text virtual console (`vc0`)
> > and a socket (`sock0`) connected to the single virtio hvc
> > console with the multiplexer (`mux0`) help. `vc0` renders
> > text to an image, which can be shared over the VNC protocol.
> > `sock0` is a socket backend which provides biderectional
> > communication to the virtio hvc console.
>
> I think I would rather implement a new mux for this purpose, like
> "mux-be" perhaps?
>
> "mux" has been a bit hidden (behind mux=3Don) for various reasons, and
> is probably not at production quality level.

You get a mux by default (for serial vs HMP monitor), so
I think it's pretty heavily used and tested in that sense...

-- PMM

