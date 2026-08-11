Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E98C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtbSl-00018W-9Y; Mon, 10 Aug 2026 21:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtbSh-00017s-MU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:39:28 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtbSf-0000YG-1d
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:39:27 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8eeadbc5e21so16187146d6.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786412356; cv=none;
 d=google.com; s=arc-20260327;
 b=SgsO3uS3VFfXYh246O9CocSeLZsqSLFXNEXmrNc0HIWnT3MYvo5Zl5w3FDwl8Mql8S
 QZs5FkiODHKQk8qK49J/SAnO1iLNeglOrHuY3al3LeddvN4oZr7EicRZ7Q/91h0gyp/Q
 7kzRo4Oy3j+ouwqS7sQ316/kCRuay7Uwd9M44UpY7+/3Mm3dQ3gJ/puKu5hHiYHx6cvu
 EO0YPuVmkcjMTk7TDLj34oLSneQGK+hHYI58ZHAZ6ba4G+BnE05oX8zKUjBM8Gz03XNa
 EvR8pjncl+zMVDnvFBNyycyuXrvKdhVC4CqIhM+tZMJJ8CQUUTpFXyOD8SY3RB5vgeE/
 AuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9NCE/aAr/j2nF8iV3xtU3OsC8CpqBZM5ZBeXyoA4OLA=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=j7ZBZb5dF0C3eVdVB2k+ChhTaNcEZaWm4CKgjKc3HXw/qJB0uKeQAlNJOijrFpzCo9
 wOuiSlaFgUItME6rI14qRnubuNxws9FXmaVREEOVqQPdbPmbD3AWsESKp1sPitZC4uVN
 6CMY4N/f+fK+74FusmzKH96r/hu2Q8b62Ei1J/Hi7RKL4y5Rd2CjS4/S1xfBol9JbcWb
 QmfFBeNaZMdafm7PNXCICYHbxw4bBtlP2/Tp9eQP80q3J0aoSjGF0p0cMqu/t+CjTjDs
 valNHgKZDLhiWw0A8h8mEYm1nd3VBuDN22/hg7y8XcwJF6juJNBrsqwrDP5KOhLFCEXS
 O7rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786412356; x=1787017156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9NCE/aAr/j2nF8iV3xtU3OsC8CpqBZM5ZBeXyoA4OLA=;
 b=F14yZAU0LJ01OxlxRjT+ds3Xl6wvAo+RFUBMjVELQTCzflMKYStEZuN2BLfL+inHGE
 8CyGKpFP0st1xV2uKJH4s559imHFjxYDPVXG7q7pL2VAtSiY+Ukvgm2gFCPZOniYJ/TC
 tPei0eUI20tKiH3GfTHeDgxH/J56kHUDDrsDcBabo5cr96uuwFou7svmvJfUlPFe0fXn
 6uVioahy9AdN51d20eY+ygsgy2Rl4AmlVyFp0kA1ozDRRQNjLdTNz8erTS3QRGdPkJCE
 sBFKTExJiHlp7l/Ca3gpEMwVa44cmiWmVW4kQTWKt03gFa2sxFl48b5pwJvjWNebONjV
 ZxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786412356; x=1787017156;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9NCE/aAr/j2nF8iV3xtU3OsC8CpqBZM5ZBeXyoA4OLA=;
 b=VtJb6p9JNj4UHN40XyvhfIXMuh738xDHcoytBNG86Uod3KlTTG6/zI6otCgcQ8bsdX
 DOUVA/aleUyv+F77uM5vxdtXX60pwO+zVjgNj33qxstZxaEaSN/HFaGT7kbVmBmyAxqI
 CFf3BkkBTkJU+8FaxjiBMiKg+v2VKdiG39HBOft27IKNRea6FwwogNNCekchQ86DcGza
 kmGgHfjZ9dTMQJKkiW3UwGe+KrmMBDztYM4b3XtvmQlrEFZVgLSyypnAX6Hgs0npCnRO
 KZy0VIfTjPJKvzpqYSBdeZ/wn5/h56g7/kBzsRzUISzjXbT61q+WN/GPP1M0PPl6v6aW
 3mSQ==
X-Gm-Message-State: AOJu0Yzjexc3SOBMT+EMp7DKM4C8nEmNq3fthw4Uvv1msfeCPznqwH/3
 7jasKdGaAk/4hK3tZI4fn5ZF3PqRtE7QU/f/eiU70A9i9ymT09zNg0ob7IXY7SDNxOAFdksbpZ2
 dZMh9CBOxQxR5hcXH6+4j8oGIWrWrpD4=
X-Gm-Gg: AR+sD12aDx8/KAhs5k4MsHyAO+C4omucBJGoJk1CRi83a4LJrb+TarCs8qM5a38kTjn
 n2GGsONsvElgYWn1WtHwBX00AQozB1UqspmGZpmrl2kk6LlLzhWsH9LQVBo1baBpCSCDhQ1Zs2A
 LC+srlpvHFUxJipvJCLWk9GaQ1oq/5UnUGS91ME2acLX9/dFAw5EusY8wh04TbErAyuotyMCb5k
 L+yH49W6bacZW3q64Ji9C0FfVpWjovvwQTmCRiNp4NbYFR3c8zIujouvJXX6J3YjJitQ2dnLwr1
 Gn0guHt1d+Wk73TQL1WplDLJCEcanZ/eJQ9jvNFNVqsBK788UfIDF1GU3Z6EUMuGozOPqfdKzWF
 U/9ERUEKkr0dpyw==
X-Received: by 2002:ad4:5ce4:0:b0:8f2:860f:4dec with SMTP id
 6a1803df08f44-908a70877b6mr315196116d6.15.1786412356388; Mon, 10 Aug 2026
 18:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
 <20260728194145.GK371693@fedora>
In-Reply-To: <20260728194145.GK371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 18:39:05 -0700
X-Gm-Features: AUfX_mwk7yXwRwfuX1L7sbLLsvBOJi32lYVTZ-YIqGXA6JKERxD-feww-OPuB2Q
Message-ID: <CA+spn3oU7dtEPO_5-hT6x1-n+4HYxO9a8_aes7Jy3afWDDY_Ag@mail.gmail.com>
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=connorkite@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 28, 2026 at 12:42=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> > +
> > +        if (svq->hdev_kick.initialized =3D=3D false) {
> > +            int r =3D event_notifier_init(&svq->hdev_kick, 0);
>
> Where is event_notifier_cleanup() called?
>

I have added in to the error code paths when calling
vhost_user_set_vring_kick.

I left most cleanup to the end of the patch series, and it was underdevelop=
ed at
the time this went out for RFC, with the intent of getting feedback on
the overall
approach.  In hindsight, it is probably better practice to implement
cleanup at the
same time as the init/start code, per Hanna's comment.

I will pull the svq cleanup code forward to this patch.

> > +            if (r) {
> > +                error_report("Failed to create kick event notifier");
> > +                return r;
> > +            }
> > +        }
> > +
> > +        file->fd =3D event_notifier_get_fd(&svq->hdev_kick);
>
> Modifying the function argument is probably not expected but
> vhost_virtqueue_start() doesn't use it after this call, so there is no
> immediate problem. It would be safer to have a local struct
> vhost_vring_file that can be modified without affecting the caller's
> copy.
>

That makes sense.  Swapped over to a local struct.

...

> > +
> > +        if (svq->hdev_call.initialized =3D=3D false) {
> > +            int r =3D event_notifier_init(&svq->hdev_call, 0);
>
> Where is event_notifier_cleanup() called?
>

Same as when setting the kick.

> > +            if (r) {
> > +                error_report("Failed to create call event notifier");
> > +                return r;
> > +            }
> > +        }
> > +
> > +        file->fd =3D event_notifier_get_fd(&svq->hdev_call);
>
> Same as above.
>

Swapped over to a local struct as above.

Thanks!
Connor

