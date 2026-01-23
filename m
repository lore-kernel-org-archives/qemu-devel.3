Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B2CD72352
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 08:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjCmb-0005ra-CU; Fri, 23 Jan 2026 03:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vjCmZ-0005rA-Nu
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:44:43 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vjCmY-0004sn-28
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:44:43 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-894723da7dfso35162946d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 00:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769157880; cv=none;
 d=google.com; s=arc-20240605;
 b=N25mwiuUWZP5CQ1ZUBU/WbpfoVz9I4H+3VRBn8ehgxjtJwoTjAzMhzIOCmxPdxGejh
 RwLgGmEx59pa2TWK7ideHrbu8Dwo57CEF5SKCoWv46y9/tN5Rbx5iFe5gIaCUZqlI1bV
 ompi6vsi4BffOECcK4qaYj5PEh8IQ+gxsseU4fjS+mFo8M+RDms0imeEB2jMp2l+i5ct
 OSGSc7WpMAgGdcU3NHENYjI1k89HIFRJrVPV9HTSHCElcGQJJSWRZpQc0Tg4ITulgbtX
 ymY8qu2jH2XggslQdKV/gpG6PLM52hm70ZajtT6la4WmaYg9Kg2bL+qRQu9T+nZSrMhu
 27OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q0ix+xmFBGS5x5j4yOBrivR5GZGMnHUrvI1gZx8ZGr4=;
 fh=2ek7+lne5rfb/XZ/rEQsybJjFQjXlCtfB2gP/hpHFw0=;
 b=U+654IhHkb2YSO2t0sNhyY00ze/BZzgMbwnBQBvrw3pc4yNXf2iAV7SB61CN+Y+p+f
 pt9nEDcALEwatPejlRUCo15A2El9TsxeY4S+3+g/kcVs1DIYDt/5rTd7dOZgFKi4x7vi
 TaNXysIUGa0wSUDrKPH5aNBxw2dwp/l6UZo4jjekHlIVwEbncvpgQTXTcwj3gIhb3xgL
 zTvI4rg57Cc/QdF0ht9Vivyfj9YIX0FxY3vHK/FSAWn9uiDRq+E7ZajOK+l24giJ+9S1
 DpO2eVjlVuXGBD072JJACGfX/6PeRPXrPvGpFlq80VkeUmSopG3P5u/59M7zdR3o9NC1
 qaPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769157880; x=1769762680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0ix+xmFBGS5x5j4yOBrivR5GZGMnHUrvI1gZx8ZGr4=;
 b=AMITazmtD4eTcf8ZC29pAKh3+Sll9y+S0iRmB+HidmhkaPmSgyR0EkbF0myFIvBo6v
 FD7LJY3BRjNa1afnhBGCtIGbRB1ikk6aqF2XOTAyFvyC2yvcGntgHRZFKn9U189tFqBB
 MEWt0j3NhgfqERWU0LGSUQN3N6Kw0RnUqWYKJQBrSE1V9rk0omHup4sCJEa+m1DN7ANd
 jXrgze/6IwdVMOS2LI2wR+J43O9Rzlz7lg8GVm1DgMSFQtdv/zfXS0OSVdZjtsxf8pLs
 x6UTyAbUACbpB/3tkH81YxCoIwsSJ6FtMtCfBJfhOMgnOLaUUeMHc3D6MQHzIwjHowj2
 eSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769157880; x=1769762680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q0ix+xmFBGS5x5j4yOBrivR5GZGMnHUrvI1gZx8ZGr4=;
 b=lFXdVK1lXgvwESh7pE33wIS7oKsxwxBAJofYQ4G9v34djjdGfnnZIHazPnPpLjFf/n
 kbhDF2ES2l7vIOaSUXm0si2rYtwSNnoLe94GPOTnQr3wX35m5bZGvoKNWHm09Xu4n0ZU
 HVWqNB9w8FuUjRewfziY7/Q28UvwkcfJ19JXkpeI1ei5whWMvmBFurXwbchWIXLd6gBD
 xEW9eTFxpIv/wlepIYFHBby38MoYhVQbSz4ZpSs34AMWqehu5/ZRNlsGlmFJV1pt97aU
 qUE/HFgAvDONT57hYHiYsAUfO3sBz5wQof2HsVaxBRJYO4CzuxvyYN7S2xxqVkwLAw5M
 FGKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHqZ9Do5TayijCg7cokkf7tx6KqTQep8Q7huiSkr5kV7oghWJZOCFIp6ENM3rqEiZp3H6tCV4M2r3s@nongnu.org
X-Gm-Message-State: AOJu0Yyu2s8Z1Mw81/4RO2GCSXJmMr/3Z8vOy+stjGyQiNq0Z/mkncwM
 iitKvL+dkN64xwe3X2D4eUWFn8yJQJ5nYZEslriSnB050fGIDx2RInj9KyLdaxIlh+SjIpXizX/
 ryqAyMFbrJOY4LHfhoG2tUqxorfamqTQ=
X-Gm-Gg: AZuq6aJbiero49peroxHTsDr8qoyLNRG4TQgDQ4KSYBiThFH26onK/yzgqy1UyLc5J2
 Vuh1LTPuAGkjg/IGjVJlIYfXPCqrv8Fb9FSTEWCKdLml8dCcXSsSQf81rhgd/8RpAQfeVYqygSJ
 Wmtx8X7Fzo/yceLvty3/kWrbaTIRAeVW/FCF5A0F4du+2asPGGULrbmbGBfiQmntCwsgrZViJ5K
 kwBdN+Dw9rDBXPUccIUDiCY7oW1K7cljW7ekpcshRF/Q+X60ACK2/lZi4yleTibU+vYLxRupxiy
 /EGX5jW2J7/89AX5Cbhj+ZGYS88=
X-Received: by 2002:a05:622a:1a93:b0:501:498e:5c29 with SMTP id
 d75a77b69052e-502f77d4a37mr30458991cf.59.1769157880449; Fri, 23 Jan 2026
 00:44:40 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
In-Reply-To: <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Jan 2026 12:44:28 +0400
X-Gm-Features: AZwV_Qi1gRi5xeDyNeB35CIP8lzUToeOVoLKCjAlrhjdcWtWqqH7vcnQjXP73Kc
Message-ID: <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Jan 22, 2026 at 7:46=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 1/22/26 3:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Jan 22, 2026 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >>
> >> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
> >>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >>>> Once we have written some scripts that can build gcc, binutils, linu=
x,
> >>>> busybox we've opened the door to be able to support every machine ty=
pe
> >>>> on every target, provided there has been a gcc/binutils/linux port a=
t
> >>>> some time (which covers practically everything). Adding new machines
> >>>> becomes cheap then - just a matter of identifying the Linux Kconfig
> >>>> settings, and everything else stays the same. Adding new targets mea=
ns
> >>>> adding a new binutils build target, which should again we relatively
> >>>> cheap, and also infrequent. This has potential to be massively more
> >>>> sustainable than a reliance on distros, and should put us on a pathw=
ay
> >>>> that would let us cover almost everything we ship.
> >>>
> >>> Isn't that essentially reimplementing half of buildroot, or the
> >>> system image builder that Rob Landley uses to produce toybox
> >>> test images ?
> >>
> >> If we can use existing tools to achieve this, that's fine.
> >>
> >
> > Imho, both approaches are complementary. Building images from scratch,
> > like toybox, to cover esoteric minimal systems. And more complete and
> > common OSes with mkosi which allows you to have things like python,
> > mesa, networking, systemd, tpm tools, etc for testing.. We don't want
> > to build that from scratch, do we?
> >
>
> I ran into this need recently, and simply used podman (or docker) for
> this purpose.
>
> $ podman build -t rootfs - < Dockerfile
> $ container=3D$(podman create rootfs)
> $ podman export -o /dev/stdout $container |
> /sbin/mke2fs -t ext4 -d - out.ext4 10g
> $ podman rm -f $container
>
> It allows to create image for any distro (used it for alpine and
> debian), as long as they publish a docker container. As well, it gives
> flexibility to have a custom init, skipping a lengthy emulated boot with
> a full system. As a bonus, it's quick to build, and does not require
> recompiling the world to get something.
>
> You can debug things too by running the container on your host machine,
> which is convenient.
>

Very nice! I didn't realize you could export and reuse a container that way=
.

I wonder how this workflow can be extended and compare to mkosi
(beside the limitation to produce tar/fs image)

For qemu VM testing, it would fit better along with our Dockerfile &
lcitool usage.

I wish a tool would help to (cross) create & boot such (reproducible)
images & vm easily.


> I took a look at bootc, but was not really convinced of what it added
> for my use case compared to the 4 commands above.
>

Having a regular VM bootable image could be desirable for some cases
(tpm, secure boot testing for ex).

--
Marc-Andr=C3=A9 Lureau

