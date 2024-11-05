Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97BD1267A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Gb2-0003z7-TO; Tue, 05 Nov 2024 05:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Gb1-0003yx-CQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:15:35 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Gaz-0000vJ-0k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:15:34 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso6861715a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730801730; x=1731406530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h89pPetJnIIFS3Ii5DziZHYvgeykJYSaFELvdVSj3A4=;
 b=ZhEdrXHdSDwMgR8qFvKlrTxP1XdqDHEwxvgRCfE5elPZxGGCoasUsZ23GwQ2u4YGfl
 AaHH9HUY5Xrp1WdRSZCy3qzZTDx4r3Uq0maglp4Nlp0Hj3TmLg6rCvJdLERuTjFSCwFh
 4FHKw7Aut5Dn/idGo3kyLeeNyXUVcZOfj77kMzXScBpx5ngF+lcRV5DiiFIS/O9Nb8Bh
 JffPZf+b0e5OOscq1ANkFxcxcXK5ssZklzCKSdHu+HrnvCBIgD1LtV9lWN5rbb0zS69W
 EYFpkuJedvqp+Sc2aUKpATEqC08LyCUj34Z/B0E/uIMPQsImBFy3A/HRW4gB8Sz5ho3B
 VO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730801730; x=1731406530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h89pPetJnIIFS3Ii5DziZHYvgeykJYSaFELvdVSj3A4=;
 b=e+Gf8U1+YHKq6qcVss8jqa3dj53apoz25EnHjqqp8HLDxP8a7fXOCXtmQe0Wpto8dC
 +zFJKNjTnW40sEWJny00uBj12KM52fxCmPkNOU4sLv6skdkQWVmLbr1Hhp5hyG6YhJlv
 GlIOVSN+aC1qxwubk82xsBLZdIm1WFLyM/zv2yC79JIFrSbIe1Z7WTCk3Q+1GGXm9Zx9
 lVnE2TffioLEzt9AQVRy2JHrM8QUi/gEOaA0pugXCDA7PKxpqPMgC5upcpn+2tR+hPaW
 HpYD4pYWkwr+CJ364oR/4iYsk0gkoEGYbVfxmaDTXYxIAUzZEn7E3OmPExm5o9JVPAlB
 kAHQ==
X-Gm-Message-State: AOJu0YxTlRPl9b1QXjeHjpZoCilaQXfpgjNCpM0e3sncFMLpKAUUXust
 UtYVLA45FSQcNCG9T27SqhwwY/ZYIiQrNk2/ZR8YUNUy+H4eYiq7fcsPlHkBw82+0RKQ1w9GCPl
 u/VujKGGkFcYOW9FPFBKoMVangyQgJgALiT21KZINSI/vJ742
X-Google-Smtp-Source: AGHT+IFKEZ80rJ8RWNzaycpUNHEb/V8fEOTTLFQZ6zaR6G1vfJ7rFfMgFAONhfPDntwnI9NgbiYTF1ZBfHwzyWyWk/U=
X-Received: by 2002:a05:6402:35c4:b0:5ce:de11:dc09 with SMTP id
 4fb4d7f45d1cf-5cede11dc1emr3002662a12.10.1730801730419; Tue, 05 Nov 2024
 02:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
 <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
 <4b1efa1b-b53e-4be2-8682-1acf2359ba7a@linaro.org>
In-Reply-To: <4b1efa1b-b53e-4be2-8682-1acf2359ba7a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 10:15:19 +0000
Message-ID: <CAFEAcA-Y_7n+YRGApGAJ_g-k2uTwpaCju=u8MpoQSq1BAS=q_w@mail.gmail.com>
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 4 Nov 2024 at 22:05, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 11/4/24 07:58, Peter Maydell wrote:
> > On Thu, 31 Oct 2024 at 04:07, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> MacOS and Linux are straightforward, but Windows needs a bit more
> >> details.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >
> > We have documentation on the wiki currently about how to
> > build on various platforms:
> >
> > https://wiki.qemu.org/Hosts/Linux
> > https://wiki.qemu.org/Hosts/Mac
> > https://wiki.qemu.org/Hosts/W32
> >
> > I agree that we ought to move this into the main documentation.
> > Some of the information in those wiki pages is probably
> > out of date, but some of it looks like useful extra detail
> > that we could incorporate here.
> >
>
> I noticed that. Is the QEMU wiki considered as "deprecated" (no new
> information there), or more seen as a complement to current manual?

It's in the usual state of all wikis -- it has a lot of information,
some of which is out of date and some of which is still useful,
and none of which is particularly well organized. Some of it
we should definitely move into our main documentation.

> My goal adding this to the documentation was to have a simple (and
> single) "how-to" per platform, instead of trying to cover all the
> possible details and configuration.
>
> Would that be acceptable to add links to the wiki instead of adding all
> information in our documentation?

I think if we want to document the build process in our
"real" documentation (which we should) then we should
remove the wiki pages (or replace their content with
pointers to the docs). Otherwise we just have two
places with the same information. If we decide that
some of the information on the wiki pages is too stale
or too niche to include that's fine.

thanks
-- PMM

