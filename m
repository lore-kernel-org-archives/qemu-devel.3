Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B20FD2F033
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkju3-0001Xq-C2; Tue, 27 Jan 2026 09:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjtv-0001Sk-DM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:18:41 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjtt-00020x-N1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:18:39 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8871718b05so678745566b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523516; cv=none;
 d=google.com; s=arc-20240605;
 b=ZURhTB4HP7EMBBHuYa07+OeruoYxJuA7/HQIuJ0sTf3s94mSPHkkvs1TnXkvSiMuIZ
 HVvWr8z3Vn0ea+cBGDFB+iMZDBKmfKSowC1ZmYFhfrtVQKv59shqOkMaJdqFqjV9DtFP
 fBSvX2TqewYSFnICdDLjJ7HeI3nLAw7g1z0s0ie6uwe33uAoxDxa+SlBiMSeQu9vGSgY
 fAl/rpPOF26P2S0sWUUERYpQ+I+yaNg7Y2oRHO5PeX+m7b3F4JsWZVcGxLOUo36FNyBt
 JRrX0q1lVlHCOviYelCKkUk3omAllg3s9iukfMpge3bLjbNdpMahfCEn1UWJ3laVZEup
 0oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=astb0ATKWa3zkLPDwlzFITzGjQ+BZMNm3q5zFXcYK3A=;
 fh=TlX13MN7QzZ4YLPnAeLblW9F9wv6NcsH/fw/Oct2prA=;
 b=CoYmbC9F409b6G8Q5iDfZb7bx7c4XamIo729z1ltcYIwZjnMelKvMybIjVxf8hKT8e
 JwLN2OkoJ2otN1qb5AYLEnQ94rqWWNvQ4id7B2LItrjbUnRF4gOHq9/2MRjSaOdIdpV2
 d4S+CJuowC2S564FWg1R0vWqrBJOBlpryscGO7BMgKfxpkVA+DvqT07l08nJKW6rmM6R
 V29JRfHpl69eVmyr0jPazylVr0Ml2RI9P//zuKh8kXR1K827tBbC2bzOqGEGLOW6ungs
 NRK8Nz+OR/87B7OfvY4O0DViKurAF0DUjPScTMBYScpK/ppNdWHzslLYqbnWPy9FHUrx
 vRsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769523516; x=1770128316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=astb0ATKWa3zkLPDwlzFITzGjQ+BZMNm3q5zFXcYK3A=;
 b=Lc7FlVNVE5xP+RU3k/RxOTFLAf4nDgrkZ1/Uxp66+lnfMh+b0mRwKaBx3+TejeJtil
 eJsTmMPsQauIGkbpy6wmfTYHYPKag/CtZd2f6PHK89ueyDO0RLn399UO2TDhfJiTxGm7
 0r/U4+9rkmIIxt9/lUtq1Kk72XZVChGZPHiwUmQSqqrt2OU+qRcoD4lroi0Tyox6Wtr/
 Zew2H3tzqaAUufLEcgaHXYb6l2+JrRpxYFJpQ/2DVixdz7rYzgEZUYEmwNkvT862899z
 EAvNbV33IQtT/+lysmEbkpAGB9peBUeVjnqG5+NleCVOS9aDuSUy1bym7RdwskdeLyi5
 PfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769523516; x=1770128316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=astb0ATKWa3zkLPDwlzFITzGjQ+BZMNm3q5zFXcYK3A=;
 b=OXznthuP4/C+yZy7ABSFucROfycz2R1qTXh3enwnuGL1OnDJUoObTiTUGm7FOnjwRY
 yJpgCSk/Cm7caE/CsYjSWzmkc2G5tRLz6nXRGv4eGFvY2jxFuyRj9cF+XLqFTrASDHBf
 A9EUsZcx8Ev/d4JdWoBe53pSkq8A2Kr2GU7OxcNY/Yj5LSaLZdoFxEl36Fc087Rzpp0G
 KRFaQWolAbXdoPUi4/MroS/GjLwCnZP4qztyhIRqhQOOeYm3cljx4uc+xNq6lS9VaCOo
 sxSMRC/9z+YVZJw6s1FVXYAECo4SU0V4ic4YXNGEIZ91//4DJgQacqmk5sjTuq+++Ctr
 QPKw==
X-Gm-Message-State: AOJu0Yzm8bs+t0qGCgks5qJv8fyJ2ySbzA/PKbDsYIF/wh21bAKGVoba
 bZ8sJkngpiNGvqchxsxPrkPu1pYlC2CKkz9K9P2nJ3FwyZf4W+JmXFl1716ZMYn8hK0eoDjwi42
 OHhr6YY66NM1NpKAcw23Fwngmof+OW9E=
X-Gm-Gg: AZuq6aLXYhyU3KI98jVGZtu8XstvF1agTiJb/FyVDwv1rv/gxy4/mziBlicyx3SOO2b
 FMqy9+QEjNV2M535CuA7o3NAbrXSGiKq2TAdXahuGXROYGSEO5HLvKzQYivVmN70AkPwr5issxe
 8WohD82sZtqU3efCwYs4QX+h7BQy5JNkTVYyLGvqkYLTvB1tQf6KyJc0btKqZmjWbJgEUin2IZ4
 4uE/wQ7pnEuMGfebH84i7sP4JJ4YOqdzJONjDpcVzB1U14pV/6oKbnAgpZH35HGNyGzgQboS0Js
 ich+
X-Received: by 2002:a17:907:97c7:b0:b80:3447:e0c0 with SMTP id
 a640c23a62f3a-b8dab4b7655mr149413566b.62.1769523515370; Tue, 27 Jan 2026
 06:18:35 -0800 (PST)
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
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
In-Reply-To: <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Jan 2026 09:18:23 -0500
X-Gm-Features: AZwV_QhpnIi52kW_E35ueiCFTD4Rtu9ioi1LBttKxHqun3onNigvzEdd4YENgi8
Message-ID: <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x633.google.com
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

On Tue, Jan 27, 2026 at 3:06=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 1/26/26 23:29, Stefan Hajnoczi wrote:
> > On Fri, Jan 23, 2026 at 3:44=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> >>
> >> Hi
> >>
> >> On Thu, Jan 22, 2026 at 7:46=E2=80=AFPM Pierrick Bouvier
> >> <pierrick.bouvier@linaro.org> wrote:
> >>>
> >>> On 1/22/26 3:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> >>>> Hi
> >>>>
> >>>> On Thu, Jan 22, 2026 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> >>>>>
> >>>>> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
> >>>>>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> >>>>>>> Once we have written some scripts that can build gcc, binutils, l=
inux,
> >>>>>>> busybox we've opened the door to be able to support every machine=
 type
> >>>>>>> on every target, provided there has been a gcc/binutils/linux por=
t at
> >>>>>>> some time (which covers practically everything). Adding new machi=
nes
> >>>>>>> becomes cheap then - just a matter of identifying the Linux Kconf=
ig
> >>>>>>> settings, and everything else stays the same. Adding new targets =
means
> >>>>>>> adding a new binutils build target, which should again we relativ=
ely
> >>>>>>> cheap, and also infrequent. This has potential to be massively mo=
re
> >>>>>>> sustainable than a reliance on distros, and should put us on a pa=
thway
> >>>>>>> that would let us cover almost everything we ship.
> >>>>>>
> >>>>>> Isn't that essentially reimplementing half of buildroot, or the
> >>>>>> system image builder that Rob Landley uses to produce toybox
> >>>>>> test images ?
> >>>>>
> >>>>> If we can use existing tools to achieve this, that's fine.
> >>>>>
> >>>>
> >>>> Imho, both approaches are complementary. Building images from scratc=
h,
> >>>> like toybox, to cover esoteric minimal systems. And more complete an=
d
> >>>> common OSes with mkosi which allows you to have things like python,
> >>>> mesa, networking, systemd, tpm tools, etc for testing.. We don't wan=
t
> >>>> to build that from scratch, do we?
> >>>>
> >>>
> >>> I ran into this need recently, and simply used podman (or docker) for
> >>> this purpose.
> >>>
> >>> $ podman build -t rootfs - < Dockerfile
> >>> $ container=3D$(podman create rootfs)
> >>> $ podman export -o /dev/stdout $container |
> >>> /sbin/mke2fs -t ext4 -d - out.ext4 10g
> >>> $ podman rm -f $container
> >>>
> >>> It allows to create image for any distro (used it for alpine and
> >>> debian), as long as they publish a docker container. As well, it give=
s
> >>> flexibility to have a custom init, skipping a lengthy emulated boot w=
ith
> >>> a full system. As a bonus, it's quick to build, and does not require
> >>> recompiling the world to get something.
> >>>
> >>> You can debug things too by running the container on your host machin=
e,
> >>> which is convenient.
> >>>
> >>
> >> Very nice! I didn't realize you could export and reuse a container tha=
t way.
> >>
> >> I wonder how this workflow can be extended and compare to mkosi
> >> (beside the limitation to produce tar/fs image)
> >>
> >> For qemu VM testing, it would fit better along with our Dockerfile &
> >> lcitool usage.
> >>
> >> I wish a tool would help to (cross) create & boot such (reproducible)
> >> images & vm easily.
> >
> > Hi Marc-Andr=C3=A9,
> > I would like to submit QEMU's GSoC application in the next day or two.
> > A minimum of 4 project ideas is mentioned in the latest guidelines
> > from Google and we're currently at 3 ideas.
> Stefan, I can provide another project, if needed.
> I was struggling if I should make it a GSOC project, or just do it myself=
 when
> I find time somewhen. My main concern why I did not yet brought it up yet=
, is
> that I think it's so specific that it will be hard to find a good candida=
te.
> It's about adding a new machine type to the hppa/parisc
> architecture to allow running the historic "MPE" operating system [1].
> I have prepared some wording for the project already, but am still waitin=
g
> for some feedback from some contacts I have.
> So, if you need another project, I can provide one... :-)

Thanks for sharing! We have reached 4 project ideas now with the
addition of the virtio-rtc project.

You are welcome to add the MPE project idea if you want to mentor it
this summer. It's okay if you are still waiting on responses from
people you are in touch with. Now that QEMU has at least 4 project
ideas I can go ahead and submit the GSoC org application and you can
still add your idea later.

Stefan

