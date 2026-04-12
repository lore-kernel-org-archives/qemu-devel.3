Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F53E937E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBvdj-0004xs-Op; Sun, 12 Apr 2026 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvdh-0004xC-UR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvdf-0007iS-Jy
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776003493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5m8XRONqEE/kTuIqOcbqKP57IAZAVA9uwuhGgzaxXq8=;
 b=eWUs7mOXIfVIYnXdizsHx/pGwGrGdWNsPbyf8ROq17HzVG51oP99E1bZ2Gp3mwshnhHGhL
 nTBdSdCVurE0LA70Vn1mXOC9n5Mo+qWS1s2ENMZZwPbWIJFIBBhq/qA7as7u8BElOQcuAa
 X2/wWVl9J5nPNMO5GR3TJOuvs6RGXhc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-bvBFJSWRMK-jzmRPjEPUPw-1; Sun, 12 Apr 2026 10:18:11 -0400
X-MC-Unique: bvBFJSWRMK-jzmRPjEPUPw-1
X-Mimecast-MFC-AGG-ID: bvBFJSWRMK-jzmRPjEPUPw_1776003491
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35da1c703d1so4037985a91.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 07:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776003491; cv=none;
 d=google.com; s=arc-20240605;
 b=iW2zNTLqjy48KGDHF9ulve6Dwboy5MbCiQIA7OpiSwz1cU5HD4AZBwdgBTaNogUXUe
 jRpPTQ05DdsEr9yhBFxiR2qix0YC9/afH+Fqed9X0mrxu3y0EhgvCjF3CitzVXsdQxbW
 ybdwu8wcTfRZ9x3PvUmpxXjAxel8uskaMaD9A6B8k9b/HUqPYvL5olAcyGdgHKp/EsA6
 gM4YTINVaQEkm8pOEhC6kot6PO9x7/6TssTxUJzRKxdCSKIwmuO818kgTKjB5ecyFLfG
 F+KophzwpQBLjoUvqPiEOH9zoMNU1u5CgCLRv+5cmrC+A4oXf5M8MuTGhuKHqbweZ4K1
 EOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5m8XRONqEE/kTuIqOcbqKP57IAZAVA9uwuhGgzaxXq8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=CGJxBwYINFL2MFsUa8AmkrKXSwvb1hfZXHLkKzlADLkUYtjuq1Eji6kVjbKpWysXuu
 MyS2+ViNmOhEqtTCfQb1EUFBafEeZdEJ0MxXpRJrbVeKAjIfgknv3zTTnU/XP8T91lml
 4YHxNOMPRPyOYl1aI70QltPDAqKn1YiPNpJx9wABBvC7wl1mSpu2vLGqF3NH1sDYT455
 bWJUREcrv2EfS0PZbDMUsL/hzUtgsFkPx9QrGpoQ2sC7vxE+sM1JnklA3UXS92zFSrmd
 u3hC/bhT6RBJMMF7oKDxv924SqpHD/zAeQvUI9tdAnrSGA8L7W8B0Foulr8EZkNCYkjI
 Vsfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776003491; x=1776608291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5m8XRONqEE/kTuIqOcbqKP57IAZAVA9uwuhGgzaxXq8=;
 b=XSHqgAEu27IIZ3W9u4b6MGAK+UJerdap9g9r23fOahEDeAoGBAse2+GSYrgQ745ai4
 bzIJBzhjMFyT+5qIH/4tkH53EpoX5pX/vKYs8bM7iR3noSA8Uw/bdbAIEmd8m0aBMp8Q
 yw76V01aR+vnh1gNX8dcSWnBtagLqAlMu9qeCWfIy8GBEXwrr0aQRBvCuzd8nJCnd53s
 83Xchq69SdTRjW6fkupr/F7InGEMFz3acslZQTnMNTD+UMpGgBTPywbb9VhWQXNMtKFH
 tU+ghArNd2yv0nw3lq8UEeZ3Ux2Wcc7YCltw73idgfv35gSSfuaE7vzCXW7OGin918OQ
 ZNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776003491; x=1776608291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5m8XRONqEE/kTuIqOcbqKP57IAZAVA9uwuhGgzaxXq8=;
 b=fKrl1ZUozEtOgfWZMZh3vmHYK3PdmDlgkAQ5zNt0Yz4dpSEoTMgW4y0uDmC/0l84eK
 jcibRrEG6DfeWCtmeAC6AC26xzgpcsy8iL05G56nBGvkzU2+7QRTlPY9CIMjFGGpNAxN
 ZjpXJOVXgHLFaL+h1egm0S+IVivMKCr8vHqjDZo5hINYH3/8AypZSiIntDmsqEg+XkVQ
 JBBYYdxtW3eAdFTJ2FzsZH9QZ4mRzjhJxOtDLSa0aAzYyOuLJmojEehiriq9yLt7cQ5f
 R55OW91XpULJZXOncVHeS7cvOyVnCBVLBkUS4kNsL5cUhyKDY6hdE3+4tojwFdV0OyLV
 aAnw==
X-Gm-Message-State: AOJu0Yz7VEk6X79hO/Jeq0TuR5TOhm1HndqqTaB0F8zIpIgLg+DmO/cP
 jQ3GkDBerzb3CxozGIVsWr4Qzu1MoqC5PlWXChJfoCU2GHbcyiqbCmGG2fTzWcJwRx3JoT1EsrS
 6lYsy6rXOyzZM1OykO0/9HKGJeXR0QdMHM3LtJJpoW3TcHWwDO4yYb7N8EX1h3dpNO6S0vcH0ld
 /jJncY7IUSr60nYIMg8S2O+vnHecAyh+c=
X-Gm-Gg: AeBDiesGZv7U5H6ZnR/FnHs0CaC5QSxvXx6NoKSPPQmkktlJ9N6XwrusoXl1onAO6oy
 0ROaASp5vinjq2j7tq6CBBYWJtANb04I2EFgw4/i6yy88yHHeSWp/xZ2v3S3MCq89JTRFebVspB
 UjKfo/tzHdoON/CTt4hVPPJ4ArAa5RflEqdotOI3GYV682BeHcRcUk3LkmaspmjqaVIzGMZJ+EG
 kraFQE3mcg1mGmSDjd0vSmhPekvcGI6mIS2VRTgHTg80W5c60Lf9rXPB9p1yxoaw0CGhTel/V9i
 54gqEb17Zeoq9bmOyCljnxNN
X-Received: by 2002:a17:90b:380a:b0:35f:b647:d97e with SMTP id
 98e67ed59e1d1-35fb647dcefmr565912a91.12.1776003490691; 
 Sun, 12 Apr 2026 07:18:10 -0700 (PDT)
X-Received: by 2002:a17:90b:380a:b0:35f:b647:d97e with SMTP id
 98e67ed59e1d1-35fb647dcefmr565895a91.12.1776003490164; Sun, 12 Apr 2026
 07:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
 <4dabec5f-1700-41a4-a36c-526b9f096460@linaro.org>
In-Reply-To: <4dabec5f-1700-41a4-a36c-526b9f096460@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Apr 2026 18:17:58 +0400
X-Gm-Features: AQROBzBuPutrpX26WkWBmH3XGlqo4S1b4pEmpJ1F0DRYi6pz4tOR5Jf5jbwLrcI
Message-ID: <CAMxuvaw9YOsJihsQDpLjhM3ohk+h_JoeHT-6S7KvPuwNCReHSg@mail.gmail.com>
Subject: Re: [PATCH v2 48/67] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Sun, Apr 12, 2026 at 2:31=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/4/26 21:19, Marc-Andr=C3=A9 Lureau wrote:
> > Combine the two-step vnc_display_init()/vnc_display_open() sequence
> > into a single vnc_display_new() function that returns VncDisplay*.
> > This simplifies the API by making vnc_display_open() an
> > internal detail and will allow further code simplification.
> >
> > vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
> > Add vnc_display_free() for consistency, and it will be later used.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h |  2 --
> >   ui/vnc.h             |  3 +++
> >   ui/vnc.c             | 75 ++++++++++++++++++++++---------------------=
---------
> >   3 files changed, 35 insertions(+), 45 deletions(-)
>
>
> > -bool vnc_display_init(const char *id, Error **errp)
> > +VncDisplay *vnc_display_new(const char *id, Error **errp)
> >   {
> >       VncDisplay *vd;
> >
> >       if (vnc_display_find(id) !=3D NULL) {
> > -        return true;
> > +        return NULL;
>
> Can you explain why we don't return the VncDisplay found here?

`vnc_display_new()` is called from `vnc_init_func()`. If we have
duplicate IDs, the function returns NULL, which is treated as an
error.

Duplicate IDs are handled earlier by qemu_opts_create() though. So we
could assert() instead ?

>
> >       }
> >       vd =3D g_malloc0(sizeof(*vd));
> >
> > @@ -3451,7 +3451,7 @@ bool vnc_display_init(const char *id, Error **err=
p)
> >
> >       if (!vd->kbd_layout) {
> >           vnc_display_free(vd);
> > -        return false;
> > +        return NULL;
> >       }
> >
> >       vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> > @@ -3464,8 +3464,13 @@ bool vnc_display_init(const char *id, Error **er=
rp)
> >       vd->vmstate_handler_entry =3D qemu_add_vm_change_state_handler(
> >           &vmstate_change_handler, vd);
> >
> > +    if (!vnc_display_open(vd, errp)) {
> > +        vnc_display_free(vd);
> > +        return NULL;
> > +    }
> > +
> >       QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > -    return true;
> > +    return vd;
> >   }
>


