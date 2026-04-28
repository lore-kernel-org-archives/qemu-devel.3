Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995A0FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHm68-000381-CK; Tue, 28 Apr 2026 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wHm66-00037g-Mq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:19:46 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wHm64-0002J2-JD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:19:46 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12c8d0945b3so3878c88.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777396783; cv=none;
 d=google.com; s=arc-20240605;
 b=CyBP1JlL4gf79M1fOxMjpkQk5ft9VjHlGc9YM4TscZE7dilwRrXRUz9ugexnD2eFPB
 RpanPAaV/OdyxgQTEHMG0nZT5rLi+dvSqgjBXMB5YRSy+QqCitVlD7AEwx2NS4X5BShZ
 z3xHJTcgA5N6TKQuhN/ZDGDjpsaCgVZVaExF+FUrJoVyIgD1wUeF8soJ1QwHgBX/V+zi
 UTmIjDlgLvyWgXEahFwsTUSuUBpmrAlyYjl2Nk35zfyQO9NN3rbH3bbtNBvAhtnRFKRd
 BK7oeKvNX5UhvBGj4S1jucAjUDWs3YUa1i5BSI+v6vqyrN/BjXNoBpQw4koYH20I3sNB
 g1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w3xtb7inktEpchZMqasoGx6BBiQFtAPspkUYaDfroIk=;
 fh=Mjbhbq3fHnmzitORK9hYofXg+/0dq4g3IrXfrnq4ZdE=;
 b=ks1dfy2+otfjHTOEe5AKpQzEs+/emky6NjVARj+mtiqOy70oTUSYexctU17RWGsFOm
 jwhPrKH5nI5zaYAIA9FcfQOOVbAIyjyAzJQlka/ClzC4nS4j7H7vFbtl3f+VoO93mlgG
 edJy+japZsYa+xTkJ0X/7N/j7ZaMVSnctZudDE51bDKyipQLSpDaqte0j7Nbe1RfmTv+
 +Ys9tdCZCRAUTEcfVB2xsnC4UPU/DkGiJeZYHMMJQE8p7dyVcATvG0iAW/Lb3e6/5Umw
 Y0q/YKr1fbrcidv67TApU8Bx91YDzl/retF1aF9L1fIEnW3vIwIdcUBXnJgHbgPf31nZ
 53TQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777396783; x=1778001583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3xtb7inktEpchZMqasoGx6BBiQFtAPspkUYaDfroIk=;
 b=TIVqzaIQdfwj3v7U/12NdxRwxBfRTjsErCs8VQSE8gGHyB5tcyCuWDAXQ6UucRkYJ9
 PypQ35Iq+C0No4uHOs9x+fm3H2LDlgmAMXDP3yoHpd5MhnvEQtEuIKIbUHFOYHmkylFh
 3tvXZfGfowB9PG7gSfAjt6Z/aDxS9tMEy9X5yJ674nOE0JI25AyZTCaqRhkgCGbBJxXa
 IEshzII/hTLKQWGrcBDsmKr+YaEZsqbU6WPdxnxyp0fnD47dpyOkW695aRcV43oe6YKd
 MrZjcqFgsxyOXhVfN/JP495xHjIblyC6SpB+ZvxldTZgvx4EwLkRC3THTQ661bDbzq9k
 twrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777396783; x=1778001583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3xtb7inktEpchZMqasoGx6BBiQFtAPspkUYaDfroIk=;
 b=Jixp9keaHbPZl+mPvhEjaKk1EfQ4g0Fnqxci/S/opppswh0NvDGo7EmXemFl7P/2VZ
 0FrdUwFYUgPc5UkMLyxBjYoQqlVaRBRomH0FIyP9DPw9bjdQueNyKGcltJ/wHE2Bb2fV
 bopXngPa3LUVZPk3THKCVvK1OG8iAVw48gvzvt0ng/HURWFG/eJOTmEDeI00LW8i/cSq
 gfWUZpESv719zFtHlNLu/T03dlDCv4yaSM9l11KpYlXjos+XvTDistM/KFeoapLHW1v1
 HVWCS/yKohxBReu/234vskH9EkoFZl7T2QHe9MzmJarNagz+fCweT7i4y2VuATGOK73Z
 i+pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pHZovU+oP07D5Snf7IKREOeBsncx1QMrnHhnfzetxsML51YW2praFqsQp9S3JwT2aASAoAYtDkFs/@nongnu.org
X-Gm-Message-State: AOJu0YxT90E11Kbg6dLI9i+mzWcF0rG21rkY1iKBIviYGSkIQ+4CTlhp
 t95iZHY7sChkRv/a52+0btwWlgbGj3UGFW0UcX2T2x4QoHAYNvm/PijwbKOcFzaWx5IR8ehv6aw
 4JQFFi+qxkftaOGmxo90mtC6sK93uZEm3BEcW9qRo
X-Gm-Gg: AeBDievXBCQRJR9mDYmHWhbfkXB6fIp0fvyAd4pZWy31myPQz7/r5k0sC7s+paw3mNl
 1YjJXVFUcJvX+DecmBIQOnUYk67PFK1xL4c/oSDfrvdLZI1/mPOVt4IJ1M4cm9S9HyRv/WGzcV+
 ny3cHeoIIHapEqtUWTVMW8PLZNrtYk7kVpljfd+ynanzeAts8wgodM/0ar+AqkDJY9allVDUQj7
 EK/YtL/9evm7aVvzc4FWzTd0GXCFc8y25oe2jSlTGlSYWCHmCYhkfq3n6a5Is18qqZno2V5KUvr
 iXtO+dprS9EHG40MmKKTotuGzkUqjX/EStl3BJerDCYHlkaPOsAKkZSMqpZaSX5w4ntJmD4uPTX
 u5NCsvS8qNNNwUAdwjpgKEQfWSLyYtPpC/0hW
X-Received: by 2002:a05:7022:1e03:b0:12a:b39a:31da with SMTP id
 a92af1059eb24-12de2b76eddmr6147c88.16.1777396782147; Tue, 28 Apr 2026
 10:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
 <afDClLiylMgvPiUn@sgarzare-redhat>
In-Reply-To: <afDClLiylMgvPiUn@sgarzare-redhat>
From: Jorge Moreira <jemoreira@google.com>
Date: Tue, 28 Apr 2026 10:19:30 -0700
X-Gm-Features: AVHnY4LoyrJt8btmtiZDpTLutslW-GYuQY7FKLvr7JjbpWs0uYQ-PWPQ9qBspps
Message-ID: <CAJi--PMNCY26wqJiRw1xnAZVvOQUajcz534ocVhQx_Ox4u8GHg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=jemoreira@google.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 7:33=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Apr 27, 2026 at 03:48:44PM -0700, Jorge Moreira wrote:
> >On Mon, Apr 27, 2026 at 3:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >>
> >> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> >> > On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzare=
@redhat.com> wrote:
> >> > >
> >> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com>=
 wrote:
> >> > > >
> >> > > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanh=
a@redhat.com> wrote:
> >> > > > >
> >> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> >> > > > > > While starting the vrings on SET_VRING_KICK could solve the =
state
> >> > > > > > machine issue, it still won't notify the back-end that buffe=
rs are
> >> > > > > > ready (the driver won't do this). Non-polling back-ends depe=
nd on this
> >> > > > > > kick, especially for queues where data flows only from the d=
river to
> >> > > > > > the back-end. Most implementations likely attempt to read fr=
om the
> >> > > > > > queue only after receiving the kick.
> >> > > > >
> >> > > > > This is an interesting question to clarify in the spec.
> >> > >
> >> > > Yep, which is in part related to what I wrote in the other reply:
> >> > > "I think the main issue to clarify is what the device should do
> >> > > when the vrings are configured, but the driver has already been
> >> > > initialized (which is usually the case after migration)."
> >> > >
> >> > > > >
> >> > > > > Stefan
> >> > > >
> >> > > > This is the question that interests me most, to be honest. I'd r=
ather
> >> > > > have the discussion about when to activate the vrings in a diffe=
rent
> >> > > > thread and keep this one focused on whether the front-end should=
 send
> >> > > > the kick or if the back-end is expected to check if there are "n=
ew"
> >> > > > buffers in the vring after restore.
> >> > > >
> >> > >
> >> > > IMO we don't need anything from the VMM. When the device receives
> >> > > SET_VRING_KICK, it can check if the vring already contains buffers
> >> > > (and this is the part we might need to clarify) and wake-up the ot=
her
> >> > > threads (or always wake-ups them, as crosvm does IIUC, and let the=
m
> >> > > perform this check).
> >> > > After sending the SET_VRING_KICK message to the device, the VMM ha=
s
> >> > > the exact same knowledge of the vring state as the device, therefo=
re,
> >> > > it's still unclear to me why we need to inject that kick.
> >> > >
> >> > > Stefano
> >> > >
> >> >
> >> > Is it possible to activate a vring after it has been deactivated wit=
h
> >> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send t=
he
> >> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> >> > reactivate it?
> >>
> >> Hi Jorge and Stefano,
> >> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs whe=
n
> >> a VM is paused and then resumed.
> >>
> >> You can stress test this by driving I/O using iperf (virtio-net) or fi=
o
> >> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> >> QEMU's monitor.
> >>
> >> Here is QEMU's code for starting (including re-starting) rings:
> >> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?r=
ef_type=3Dheads#L1341
> >>
> >> QEMU does not inject a kick. The back-end must check the rings itself.
> >>
> >> I'm not sure that all vhost-user back-ends actually check the rings. I
> >> think back-ends should do it, but we should also update the spec with =
an
> >> front-end implementation note recommending injecting a kick after
> >> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
>
> Okay, but since, as we've seen, no frontend currently implements this,
> we need to make it clear that a backend shouldn't necessarily expect the
> kick injected from every frontend, but should support it in some way
> since some of them can inject it.
>
> IMHO especially new backend implementations shouldn't rely on the kick
> injection.
>
> So, to summarize:
> - the frontend should also send a kick to restart the queues
> - the backend should restart the queues after VHOST_USER_SET_VRING_KICK,
>    but it might also receive a kick
>
> >> with implementations that follow the current spec wording. And at the
> >> same time I think the spec should also be changed to say that
> >> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check t=
he
> >> vring upon processing the message.
>
> Yep, I think we are aligned.
>
> >>
> >> That seems like it would clean up the issues without introducing
> >> compatibility issues or making existing implementations non-compliant
> >> with the updated spec.
> >>
> >> What do you think?
>
> LGTM!
>
> >
> >Sounds good to me
> >
>
> @Jorge do you want to propose this change?

You have a much better idea of where and how this should be written,
it will save us a few rounds of review if one of you makes that
change.

>
> Thanks,
> Stefano
>

