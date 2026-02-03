Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3AE83057
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAQ9-0001Ml-KY; Tue, 03 Feb 2026 02:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vnAQ7-0001KP-8Q
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vnAQ3-00034D-9F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770102109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we+XoKKXq93koMBF5XUGKfEWkmhujw43mi50XqeKSp0=;
 b=SxyfBNw4+b16m64RC10aaOOLnGn6loYuPYcOPS3+XD6m75mdL7EMcn1sscDBkaGtz8Y/u/
 w5PNl2pL3RxtURSAx5n3Z0YZN5HKY019PxmmCU6yH31y7QqoOs89akyDBt1cIzO+4TvXrw
 SPSgTKxKZmPeqVK6jb6+750iPD1eDVk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-9sJFNKfVPtyMwFDHC3Pb3g-1; Tue, 03 Feb 2026 02:01:47 -0500
X-MC-Unique: 9sJFNKfVPtyMwFDHC3Pb3g-1
X-Mimecast-MFC-AGG-ID: 9sJFNKfVPtyMwFDHC3Pb3g_1770102107
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3545dbb7ee6so1801131a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:01:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770102107; cv=none;
 d=google.com; s=arc-20240605;
 b=jfDfV/geAu2KQsOkWZO7QqYWqLPH6vyx7RPB3AaS496Kdxt0mm+OoKRg66tIGOx+zZ
 tBG4aIb3XztLotPGeZCBJ85KlMWGkvuQrL9nySfsY67cd67YE7XfL5ZgEeKpGXaAzPsB
 /Ag91HmN/uPity1ygXhP06vZ9p/kk/fIB/NNSdljLRFwoiI1z0SvPGPQqjtjiHNgmino
 /Ko5TF3pJoItmN8GGzSYJykz0YWxBRtc+qsgjfEPUdk7xcv8cL3xk2pXGLDHbhbiQofJ
 4cfSt+loivA8FBYn3ZXZliDzTp68my5syllcBTfZqWe7lf3Dvg/iedDqZ8GubNOvq5mr
 ospg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=we+XoKKXq93koMBF5XUGKfEWkmhujw43mi50XqeKSp0=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=S0rux5vdIHcQxTrt8HNtq/48bWsQl0c885lBfkzVgNVSdZG6iPUmLkSbUyHD2Sci6c
 ZWdHlS31Xx7COmB1Q5vLKuhTqUKsOIz/cziJqSWmP4fXF1L/BUgvcrR+oH1JGNviTfzA
 RuVPoRH6ki9cOI8S2tikjWvWNInoNJarVIWrB4wq3Lc74v8tsmQnD1s7/lustkDkRBXT
 v9Y3PT3aeq/xW4jgXNdTo7bNu17J3Kb5NMv903IHduo+surcuhSm7Vq06HIA4R/1uFMN
 YYIzj2ANZWExcVxdnw0T4n+UPVd1IYw1gapkgbLqfPh5UKycStRtFtScpibHsC27QTIg
 q66g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770102107; x=1770706907; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we+XoKKXq93koMBF5XUGKfEWkmhujw43mi50XqeKSp0=;
 b=Rw29IZTm/mZRa2f8nmOeqz6CaZBQEXkgCdMwnq6xV1hd+7O+IgrKR/3t3XesEMOrK/
 +jXT9Trx4VXoaVpyG6hxqOrc485jsNU/69tl9XDacs9xqeM6WdUg05LGFwWaxVHGqiRH
 BaXFP/HSL+LefR9LpWftKKSRgOZ0QoPy5Jc26TRIx/q2zCfKib4LovS2TXjNcNBsn0b/
 a58Jb0JqJJm/YxbaE8+K7d6dLLdXKQ+1If5kqakh7tw5iCfanDcjcOQlvVs6Mkwv8sdU
 T/ZnFRHO5HpLiWbv/Lm90HyPICB3mLrWF4lebq1fbITkKffv1Nr2EOXAbn52NL9kASdv
 2nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770102107; x=1770706907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=we+XoKKXq93koMBF5XUGKfEWkmhujw43mi50XqeKSp0=;
 b=YaVrWRTJLB+E/3vgMFVyRouR2UNs+CaO94cjoLJ1IPoCGDGqF894yUi+LQ7d//8KvG
 WlLLyp21QMbWdYzhuZb5CpVXIRubDTi+4EkmAPvGJMf1eo2tgUxb7qAKvGQvgVW+xyyU
 KWb+hWWBuxT5eOEDwHaPQvrTRT3eh5k8rYjQl7pyGSReXOCyp7Jw89ddIhmpjo6kQoU6
 zqOEm3amRX0TNi2dOuQd+ksyaEmOvmNMckut8b7WlI2+vmrBDay+lozNzNLLSeH4Nb+t
 8RFvswfKIhhe2DMzc15QqSc4FXuTKmBck5sUs/yRQULA/yZUJ0dssGg2op0nQwPX/HFY
 HXlA==
X-Gm-Message-State: AOJu0YxWYKzhTy4pW3EZ4h9ls7vsF9vzSdF3O0iVXKzoZaPjOKSt/Bh2
 eFPIRfjQU1BMv0X7NgEOjqbChaGBmePTH6+BQ0ngd5HiYozds2ropTdKxd2A3Duj7qHXbcfBcIP
 zOiwyThtXlW5bZsksyMBEXSF1sBlkIJ0f6m9hpy8Ahig+jbzF4Zzpnce2Clnlyj1PWjEKoRSA7+
 5vCZlMAXhLY8Qb5fdiM1Ax5cxgcDGxsiE=
X-Gm-Gg: AZuq6aKZ/esiFSY4lvYLzLsKoMlDVWLF6wqT+7uUgR42aHajgz0YXYtcp4W4EeLGK0Y
 SAZpeImO8ETDzB68RpTy07nK170oq4JGXhAA0cse8RWmPpf9n0Osarzcd7EHECe4W8/mnQKYlXl
 vzwVBuFTMO7Pqi6qphv3s/vFLbzPubqodRL+TqNOHPjaidMqe8QEUx9E1d6ycyvXe/36aaH2krB
 Zh53DUa+omctTtZ2+RTXmhn+w==
X-Received: by 2002:a17:90b:2b8e:b0:34c:c514:ee1f with SMTP id
 98e67ed59e1d1-3543b310da1mr13488477a91.11.1770102106837; 
 Mon, 02 Feb 2026 23:01:46 -0800 (PST)
X-Received: by 2002:a17:90b:2b8e:b0:34c:c514:ee1f with SMTP id
 98e67ed59e1d1-3543b310da1mr13488456a91.11.1770102106444; Mon, 02 Feb 2026
 23:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <1f17199f-fffb-48b5-ab9f-2367b517b04c@nutanix.com>
In-Reply-To: <1f17199f-fffb-48b5-ab9f-2367b517b04c@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 3 Feb 2026 11:01:34 +0400
X-Gm-Features: AZwV_Qh42rYWLyp7qkbnmvyiUKX6aEM643x2MTvFaxsXTtlsM1pmOqZsidAyRs0
Message-ID: <CAMxuvawNazGrj-1C9hKtaW=H7NqwqH49xX_7GwvGJ6B8m1r1Pg@mail.gmail.com>
Subject: Re: [PATCH 00/37] audio: cleanups & add a manual test
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Mark

On Mon, Feb 2, 2026 at 8:10=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > Hi
> >
> > This patch series is part of an ongoing effort to clean up audio/, init=
iated in
> > QEMU 10.2. Some of the patches were previously posted as part of the "[=
RFC
> > 00/24] audio: add GStreamer backend" series.
> >
> > The complete series finalizes the migration to QOM and improves error h=
andling
> > and logging.
> >
> > Marc-Andr=C3=A9 Lureau (37):
> >    audio: remove obsolete/obscure functions
> >    adlib: remove dead code
> >    audio/adlib: drop ts_helper HWVoice field
> >    audio/dbus: make "dbus" the default backend when using -display dbus
> >    qemu-options.hx: clarify default audio backend selection
> >    audio: replace vm_running with runstate_is_running()
> >    audio: list backends as modules
> >    build-sys: create a libaudio
> >    scripts/modinfo: add type annotations
> >    scripts/modinfo: remove trailing ;
> >    scripts/modinfo: use in instead of find()
> >    scripts/modinfo: use f-strings
> >    scripts/modinfo: use argparse
> >    scripts/modinfo: make --devices optional
> >    scripts/modinfo: add --skip-missing-deps
> >    tests: start manual audio backend test
> >    audio: constify audsettings argument
> >    audio: introduce AudioMixengBackend
> >    audio: simplify audio_init()
> >    audio: move object creation to audio_driver_init()
> >    audio: add QOM module-objects for each backend
> >    audio: remove set_dbus_server from audio_driver
> >    audio: lookup "audio-" object types, and realize them
> >    audio: drop audio driver registration
> >    module: remove audio module support
> >    audio: keep a strong reference on the backend
> >    audio: make list type declaration private
> >    audio: make create_pdos() private
> >    replay: remove dependency on audio/
> >    audio: make all the backend-specific APIs take the be
> >    audio: make AudioBackend truly abstract
> >    audio: split AudioBackend
> >    audio: AUD_ -> audio_be_
> >    audio-be: add common pre-conditions
> >    audio-be: add some state trace for debugging
> >    audio: split AudioMixengBackend code in audio-mixeng-be.c
> >    audio: make audio_driver init() & fini() optional
> >
> >   meson.build                                   |   25 +-
> >   audio/audio_int.h                             |   59 +-
> >   audio/audio_template.h                        |   78 +-
> >   include/qemu/audio-capture.h                  |   24 +-
> >   include/qemu/audio.h                          |  132 +-
> >   include/qemu/module.h                         |    3 +-
> >   include/system/replay.h                       |   11 +-
> >   replay/replay-internal.h                      |    2 +
> >   audio/alsaaudio.c                             |   30 +-
> >   audio/audio-be.c                              |  276 ++
> >   audio/audio-mixeng-be.c                       | 1983 +++++++++++++++
> >   audio/audio.c                                 | 2245 ++--------------=
-
> >   audio/dbusaudio.c                             |   46 +-
> >   audio/dsoundaudio.c                           |   27 +-
> >   audio/jackaudio.c                             |   27 +-
> >   audio/noaudio.c                               |   27 +-
> >   audio/ossaudio.c                              |   31 +-
> >   audio/paaudio.c                               |   27 +-
> >   audio/pwaudio.c                               |   27 +-
> >   audio/sdlaudio.c                              |   27 +-
> >   audio/sndioaudio.c                            |   27 +-
> >   audio/spiceaudio.c                            |   27 +-
> >   audio/wavaudio.c                              |   27 +-
> >   audio/wavcapture.c                            |    7 +-
> >   hw/audio/ac97.c                               |   42 +-
> >   hw/audio/adlib.c                              |   31 +-
> >   hw/audio/asc.c                                |   20 +-
> >   hw/audio/cs4231a.c                            |   18 +-
> >   hw/audio/es1370.c                             |   26 +-
> >   hw/audio/gus.c                                |   11 +-
> >   hw/audio/hda-codec.c                          |   36 +-
> >   hw/audio/lm4549.c                             |   20 +-
> >   hw/audio/pcspk.c                              |    8 +-
> >   hw/audio/sb16.c                               |   22 +-
> >   hw/audio/via-ac97.c                           |   20 +-
> >   hw/audio/virtio-snd.c                         |   36 +-
> >   hw/audio/wm8750.c                             |   43 +-
> >   hw/display/xlnx_dp.c                          |   16 +-
> >   hw/usb/dev-audio.c                            |   18 +-
> >   replay/replay-audio.c                         |   51 +-
> >   replay/replay.c                               |    2 +-
> >   replay/stubs-system.c                         |    8 +-
> >   tests/audio/audio-stubs.c                     |   53 +
> >   tests/audio/test-audio.c                      |  582 +++++
> >   ui/dbus.c                                     |   20 +-
> >   ui/vnc.c                                      |    4 +-
> >   audio/coreaudio.m                             |   27 +-
> >   audio/meson.build                             |   10 +-
> >   audio/trace-events                            |    4 +
> >   qemu-options.hx                               |   22 +-
> >   .../codeconverter/test_regexps.py             |    1 -
> >   scripts/modinfo-generate.py                   |  146 +-
> >   tests/audio/meson.build                       |   18 +
> >   tests/meson.build                             |    1 +
> >   54 files changed, 3999 insertions(+), 2512 deletions(-)
> >   create mode 100644 audio/audio-be.c
> >   create mode 100644 audio/audio-mixeng-be.c
> >   create mode 100644 tests/audio/audio-stubs.c
> >   create mode 100644 tests/audio/test-audio.c
> >   create mode 100644 tests/audio/meson.build
>
> Thanks for the work on the series - QOMification of the audio backends
> has been something that has been on my wish-list for some time :)
>
> I wanted to do some local testing, however when I try and apply the
> series I get the following error:
>
> Applying: audio: split AudioMixengBackend code in audio-mixeng-be.c
> error: sha1 information is lacking or useless (audio/audio.c).
> error: could not build fake ancestor
> Patch failed at 0036 audio: split AudioMixengBackend code in
> audio-mixeng-be.c
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Is there a branch somewhere that I can pull from directly?

https://gitlab.com/marcandre.lureau/qemu.git "audio"

thanks for the review!


