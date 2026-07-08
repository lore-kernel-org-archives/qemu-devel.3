Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSJm-0003KA-BB; Wed, 08 Jul 2026 09:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whSJj-0003Js-IE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:28:00 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whSJi-0002pH-43
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:27:59 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso2216336d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 06:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783517277; cv=none;
 d=google.com; s=arc-20260327;
 b=GymZuDCG1mv2VJEDLLozf7J7QIjpszMw+xLupzBJr/818lz4QRKn5/YpJdPP+3N1ty
 LNvXetP+AajDgJY297NXqlqVjlK9Ol/KQbNqmyhgblEwLjMRYnhZb7r5KxSjAU/oVKj4
 a7Wmdwd86y8vZ47z4RJdWxrAixiW5ZluCyFcw53UJ455+rt8agi9Cz0rnkrJ4H/h64vu
 SJZL3Migmn541iB1cpC/OKJ05Yo9SnuNSiM7xG1BXc7PuUCIxxJF35DvWPKUamCnhnsA
 Odd5VSELHkMscymwMXNMWviMRUgjyp06P9Edeeyb+e57Mx/1eFAhHqpzOuzvez0YCY2y
 UATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mfoC7Eqi0+cnyRbLYX/9ZebHu/8PEIWXa9wg0bCXe48=;
 fh=TmtoQULLtkNCzo07wJntCtmzWnGRhiE4qnhoqMv2//E=;
 b=L2kUnh7uMt9otXnnZIt6njp0fhdSnnTzdOJ5LYrjecgqoSKALWXQPVY/bnGdraAGds
 lT2Mad2f5p8eGYgcaxK8tm261ybPb//+WOz20Bl7L8QESMqSa5itsRAj/m9jcsl9zJsy
 Zu7jBVKpZrIFROteNLIq3NsWyiHA9eyVoj5wb1YGcipFFeemiJ+9mn/4wkJkcCKlXGti
 UxvRnksM7EzE9LRJtv2TI1ZQbIzigH4ZwMA7/bps0arI7JPQ1AGpneBkmbJEi0os8SFy
 nQDEcToVmnaYUN5ATNevO+95Fu2Mq3YlE72DZx1MTkoPLHfAaf90ncMmMG+3cr+043ou
 VN/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783517277; x=1784122077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mfoC7Eqi0+cnyRbLYX/9ZebHu/8PEIWXa9wg0bCXe48=;
 b=VaGiNh+QT/RVkpoOiNiPCuUDrL3YaE26GUhn4CZ7nuLLCm69ejBM/MG6JhXpg/iplB
 9Dak5kT6bA0P68LqZR+3E3tTN2cAlYIFYUwjlYsoye0zV/nUTUggAn4fXzUJqtvUkqVZ
 Vdun+2XEWfOyjt/6Dfg0l6nvgEhUhpc/t/xg/D7UQrvpgkpKuZoBpI8XhstE6FVOHDoY
 829NT/pXwa/4J6fEKFpKdGqZAmBPzBHYq3Ft5xz78+9FHACwEyVDvPNet2vwqQZSY303
 M/ENrMb/+dTQ4DuEbgKqZLv+4rLp1M+YdkBW92dIKcK2h0od7r1+9JGOU8VwYTAR19x+
 AlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783517277; x=1784122077;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mfoC7Eqi0+cnyRbLYX/9ZebHu/8PEIWXa9wg0bCXe48=;
 b=q9src7UEA5oQ5XKIG2JKcrKGivS5J747w1tNgDz/rfyMNmyVNjwe/Xkl9tfEYL6pJO
 HMmm4hfuyaVb0ALNmT4KpWIbKyTmMop8NYgnlD/7LpdM6p6kWQT/8qNshURfgZsVpg9D
 9lOhfl36tu3CaZrjxcc90su2bLn2eJyimvWsDWGQ5qRuLv+asLjuwSRBBxAawq1gaDD0
 akiXw1E5VlOZyuN9LLUi6vw+JqjNZZIwGIHASkN1CinpUHdtWcHzF08yuyq7ush2sW/r
 MpfSr9UDJGUx4YwhN2kVBemJEE889GvHELvwQl42lnLwEtjYanKm9AQyJE4EssNsn1wR
 42Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoepzAFPhAM2+DqlBWjbz0gItAzyVDPX8tboNIeyEvGPXjZKwX4qrGd/Y/ztE3XM26xGNEx2RmIsz3x@nongnu.org
X-Gm-Message-State: AOJu0YxMAN+1X0VaRiFtB6b2t5xmhW3u1H9UL+ApP4aBySB/VnpDohrV
 ltiV7GrLGTFQ9XvX+MPY6+2We/X+kRTlt9f3FBcR81b3hQEoBEr84t+XlScomZxhUierw1sqBVT
 DKNEFRgo48NocPXOisN5FNGC7tN5ykoi5Zm544mbW0Q==
X-Gm-Gg: AfdE7cl5H8kVVhuONMXZefPSJOGcvNRrrZ1cnyEIqYaryVIhT/agdFYT9eePOUkR/Dv
 EDK33MvmGVfT9vseLyAMxxcmHNJxihhGxdD/yyD8WmOOVUS0Y4+RHh+oCRkcEMYz2hTB+G/SxSg
 Jc/wZ+CQvnbNik2EhPU0g1HxUvTjJ91iDvdzfi5xtxR5j0z1sjWEMy+kFxwFinanKJwX2csKBdP
 74o/OA5CwykLPcUq20aYVNOvBVL+8j7djfP5KwqEBZqiTG9x2sM5CqCs3Fkq6/m4K6thIFR/R+O
 r4UjzIMxIHIScVRkcwveZDE2lpFcvK8pWpLNqMnqmro1Vu7XdOfewWpH
X-Received: by 2002:a05:690e:1287:b0:667:8b90:2ed0 with SMTP id
 956f58d0204a3-6679e8dfb49mr2096813d50.44.1783517276751; Wed, 08 Jul 2026
 06:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
 <ak4lRc9u5ol0DtCM@redhat.com> <87fr1tk9pu.fsf@pond.sub.org>
 <ak40R8r6q6X0bDyF@redhat.com> <875x2pk5ld.fsf@pond.sub.org>
 <ak5IXipr3F9we3oX@redhat.com> <87v7apiqpl.fsf@pond.sub.org>
In-Reply-To: <87v7apiqpl.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 14:27:44 +0100
X-Gm-Features: AVVi8CfmwnZOSG_qNfRjh-pGQzvmCA0e9-UV7U_lDEU15tos9XepP2QUGIb022E
Message-ID: <CAFEAcA_isBMYU8mEZV-sjbiePHLDqERiczkoPP6xw4i4UYm5pw@mail.gmail.com>
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com, 
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 8 Jul 2026 at 13:57, Markus Armbruster <armbru@redhat.com> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Wed, Jul 08, 2026 at 02:50:54PM +0200, Markus Armbruster wrote:
> >> > Something would need to validate that instantiating a machine type
> >> > for help usage won't trip over any edge cases. Could be done with
> >> > unit tests.
> >>
> >> tests/qtest/device-introspect-test.c covers this for devices.
> >
> > Ah, good, I was misled by its name into thinking it was only devices,
> > not machine types too.
>
> Misunderstanding: it does cover it for devices, and only for devices.

Does Marc-Andr=C3=A9's recent qom-tests test cover the machines? It
does an instantiate/get props/unref cycle for all non-abstract
QOM types, which ought to include the machines.

A while back I had a look at moving Machine to be a subclass
of Device, incidentally -- that would let us have machine
reset not be a weird special case, allow separating machine
init from realize, and make machines be more like SoC objects
(which they resemble a lot in being "creates, configures
and wires up a load of other devices"). I forget where I
got to in that, though.

-- PMM

