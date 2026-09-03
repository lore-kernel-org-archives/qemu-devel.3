Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AADC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22Xo-0002mt-VR; Thu, 03 Sep 2026 04:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x22Xn-0002mh-EJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x22Xl-0008IV-Tk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788423092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4sa1DPu30Y6FFyrMT/RNG/7E7kZbsfjWqqLUE3+rrk=;
 b=Z1sxXNSJAdvYIvItMZhfMczYv9iOGjao0E5UxqFTazBiszrZVp7q3MuqRWY31OfPec1apS
 vwXXdB6xeRu6B3NNZwvbaWCb4DZ/34TXr98KgS/JQR/5Y24ZoEKhys+ZvU5W8FGFGp/G/O
 TbNcDRCsYGn5omjmIrDxCPmRaeRMpnQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-LkLmvW99PRufIgBgSxK2EQ-1; Thu, 03 Sep 2026 04:11:31 -0400
X-MC-Unique: LkLmvW99PRufIgBgSxK2EQ-1
X-Mimecast-MFC-AGG-ID: LkLmvW99PRufIgBgSxK2EQ_1788423090
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49554715277so18277935e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 01:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423090; cv=none;
 d=google.com; s=arc-20260327;
 b=ghxFyKmb+xYN0zsq4a/GEUjgerhYy/+iheflsdcTU0IGPN9m/5/UbAnc1aPZheIeCy
 0621D2UmYRtk6sDMdZq420OPuhhc5aYj8HBB2vxhjpasfz8af5eXn+vCIqDF+SR9LAX5
 YUKiAUdprLDkJGtJyXONWV9HeB4a96f+lL+vDtSvc4pfXQxHilELPy2Q2+GwK+wjd/MM
 rGifBUnzxfFtP/UH7c1+wIsMo6qb5Xg8ACCn8EZATdHTyMAbE6V2pN3lX85SgovNOKux
 uEaHMEk49QPdqUk2OjcEULwW77V/6JraiXRmoxbW14D0NWC8jp56mPoJqhWIavnVGYOP
 TLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i4sa1DPu30Y6FFyrMT/RNG/7E7kZbsfjWqqLUE3+rrk=;
 fh=7imBwxH8dIE4gTX3di8BGIBgGdxySCgZf+n5WaaGOoo=;
 b=HH2fxjXNuntc0Jm5y9nBbSw3SGF3Qb7RhmTH4bjKI9JIz0dU1dT+W9uft+CVujgXt6
 0mRd/bojCheVVa1aLTSoYUwaRofN5vAdXL6e72VI7gyYo3OsGWxKcANcQtdaOUw0M6cJ
 eLdbCAx95+6JYWA4+zNzRGn+ocHgWKTlNmyrCgktb8snpy0h497CavzT2ASyue3uV27t
 Q9JlIyw3uQ8tvfjSOfY9gXjzimn8lLL6hLrpAXw20hQwH9PRtwAgM7h394nhkkGAQUh3
 IbHG14UggDjOvQ+lEraBgZN5Jhx5ClgQWo9C937Sc587iQn0WrozIkdQi62oVNsPycjD
 aDPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788423090; x=1789027890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i4sa1DPu30Y6FFyrMT/RNG/7E7kZbsfjWqqLUE3+rrk=;
 b=l/sBtixpPTSMHoZrlzt5kF2WjnALaYXGMClGoIMAr5Sdl6rS5uEmRZVJOCOLp/YQxb
 5jqhV0j2cPYPxHhSy/4YQZLlDURr4xQLPQITe1PjZPZ7e1mFnRx20u9ylbpFQ12C4DbL
 7vCUNHXh3wvfRLVb2m7D5DkDlsS3uPliXNhT6jmvlTG71a2/eb0ayUR4bQF90Ck3xBFZ
 6R+boy0RjiMG30mcMMrFZF9u5V0DfyaSnip5bI42tqXQ9Yqz6SarEaZ9lMijgVLnkX42
 5O0jTiynHZqSEDNqBaU/ne5bPn6QT0Um9KJ1Iqa1wfsUacO+gZvNMZSWrUa/IC2s/ZS7
 wX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788423090; x=1789027890;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i4sa1DPu30Y6FFyrMT/RNG/7E7kZbsfjWqqLUE3+rrk=;
 b=dLLJmk2gwJ4yKAc7fepoArmpYGNt1MuDiquikIRIYYD7bC6pCTTXzlMUNa0HwR7xPt
 Rw/Zdcgnd+vMSaE0lbQ5Sn+l8uiM4J0l2M4xmiOIDTqkwHPcIVtLFawoRxSRrGupcLY5
 SkIMsjTuc1ilIEH5XyAF2Tfn0Umr9tx4fdeOi+iIgnC/KXbhNPwR4DX9zzKd5e7TLqUr
 nAeE/9gXmwHc8i5XVh0O3ddq59Nc23WlNAHRmnnHDreiYjVEdjV44r/xVoc7fuQOAcgt
 yCjIOdHkOjX/qdE/1/cvbVUeBwi7K5WbxKIEw6+WwYE3lMLKMs0GGt42wUpxlUr1lo80
 yTcw==
X-Gm-Message-State: AFuF++nzdMcD6m6UtrU1xjRnaxWZh128i6jJ7oX+EIke1RLFPzJkapqc
 /Q+EF0LKqpdKPQyDJ90RjO93X0+ur4YvQVxsNw+z8Ni3DoBEWwX7EtFGk+u9NdMDPKKWnWvjd+w
 inN/SfstncSSVBa1LThjf9GOAZg+FSXWVf59X83MPtR2qfA3qA5UthPljlksvIq50DrMz+joQhL
 RBFBj3arzgHqf98RvfE7wb9K1dXRJI3Fc=
X-Gm-Gg: AYBFou2K/ghxGZCvazZxHBz7MTqUKQMMn+Pv+9lc86KphpxJQzn/d0LNPL556Oa5nfe
 eMaa4ljyIn310hEC9GCi8TsbagO64yXcbeS0tpVGnLBm3X42AQ1qqDMn8AsIvnLGy3lCU21XrWe
 /vRytA+zQFGVTnqT9kf8+Reh241Qb7mDtb3cLg6FRPivLiqmwArdBt2sNhaOJ6vW9UuihgJnqKk
 C6lBH6GZJhO9GIf0L0wKr/ujwcfiyG1BPyVoRyEAnOcyuE/niatw6pJQfaC
X-Received: by 2002:a05:600c:3acf:b0:49c:c8de:96a9 with SMTP id
 5b1f17b1804b1-49ce5810906mr196482795e9.2.1788423086094; 
 Thu, 03 Sep 2026 01:11:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3acf:b0:49c:c8de:96a9 with SMTP id
 5b1f17b1804b1-49ce5810906mr196474405e9.2.1788423082564; Thu, 03 Sep 2026
 01:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260903073656.540570-1-pbonzini@redhat.com>
 <apkq9lLdyqXPXWmD@redhat.com>
In-Reply-To: <apkq9lLdyqXPXWmD@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 10:10:59 +0200
X-Gm-Features: AcwNN1XSwgedWq5YuLLf_zPOrjlZu2H5IqN7LdaBX8g_UnoDk1WTa-rv9xl-uAQ
Message-ID: <CABgObfYDqp8ZPKXeh8WnxKooMPFhFP5A1qUbyaqzTjKKHAoehw@mail.gmail.com>
Subject: Re: [PATCH] agents: Add a skill for finding your way around QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 3, 2026 at 10:08=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> On Thu, Sep 03, 2026 at 09:36:56AM +0200, Paolo Bonzini wrote:
> > +## Finding things
> > +
> > +`MAINTAINERS` is the authoritative map from file patterns to subsystem=
s
> > +and maintainers; use it to work out who owns code and which tree a
> > +change goes through.
>
> Does the tree actually matter to agents or contributors sending patches ?
> I would tend to say "use it to work out which maintainers to CC when
> sending patches".  The receiving maintainer(s) will decide which tree
> it will go through.

s/work out/suggest/ - since sending should still be a human act even
with the proposal under discussion.

> > +Every path below that starts with `pyvenv/` is relative to the build
> > +directory: `configure` creates a Python venv there, and `pyvenv/bin/me=
son`
> > +is the meson that must be used.
>
> More generally I think we should point to the "run" script. eg

Sure (for this and everything else).

Paolo


