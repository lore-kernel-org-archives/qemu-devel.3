Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB13AFD8FE4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfWc-0007ZP-DV; Thu, 26 Feb 2026 12:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfWZ-0007YJ-UQ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:51:44 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfWY-0008Rf-FV
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:51:43 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so890924d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:51:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772128301; cv=none;
 d=google.com; s=arc-20240605;
 b=NoHjTH00t6ulF8PaFKPQvr+dmYrj+iwPkkB5u8Hauo3lviLDSBbgChYqbkzOLtbYgM
 xASwSnAcpQ2bFEB6q6AoFrwVuo5rOzQhWNSgYql6GG/tZ00EL1gKFcJwwLwxLF/9CewJ
 uC2H95mhK7bUWcg7Ur7LB7CAz94VFgQg4f/eL6tx45KVpSpimbBw6f9+quHQLCuuqQqx
 a44ZhWFX1bfHHRuvGF9K+VJ3fDVIoWJB7QVMJm2EC+Z9haKZG40u/614R/vW1tj3hjBR
 juOYj51vavWo0+fRBDg9E9NkDcxv9tbrciYNVdecZIl7JTkEhxbzbUQP+Ud0CNpdRYfs
 biWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MczOQdlV3Z0NIfpzTjI1i3JRBKuufM71zp9/8Wg1KuI=;
 fh=hvReHNk3wGerKahIsfNPsq9Kxhs336W2LUCQiAdCyx0=;
 b=DbBhdsdPhfWN0v1oKqZ67Zl2gYC6olXwe8JpYJ1xzaRYyQAv2Gu55M0NRcLuvf8bh3
 Bq6IzC4+poqtxvAN9h07AJsoqJMmlT3ZQEcth/7wBYZIYHZvcYZ5WspUoaF5KlWAvw1H
 XidJ7qw269xvW3gVc9WwSgGBtc9CdIEluSru53C7NPI+CA1b33U13sa3HlcFAiTumQyq
 emin3aXhZuLN3BcxenTY1PQeGIHVPeXgjDO6iJI+oGL28vzLriZ015mEJxYPEMHQ0Io5
 Ia5RoQB4dJP609YMgGCxZqwdX37GXItOjK153IZ3T4EphPMmfYb6Bugcv5CPjZVzhN9B
 HavA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772128301; x=1772733101; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MczOQdlV3Z0NIfpzTjI1i3JRBKuufM71zp9/8Wg1KuI=;
 b=wrjmmR/IZEBRFp9vjUVmgTlD/qI5tSKPHGDT/Ds1bP62jko8c4zm38uyi8n6gWAwoY
 8LsLgzVM5f4DStAAbEcWqSjAuMaW/GgHWdGjBJhgH3MW1uEs/G0qxIQPbfebTav5U3aQ
 5hrW+oMfGEvw6Voz+YxH/PGCbzj9c+7NIVDeM4NRal6DNC8o62rmJpF1A8XK5meTQZTn
 GJxfOMFzMkset26ge79aV2C7evenwRUfDxMyo3lAdlQu1+Bh94rDK4fJTJaYmYg54z4Z
 Yz1hGga+zrBFMUsi1P/FBlU2OykfNyvDaM+oHWxomDc3MVM3OOfipxuuNeb3sZqlFcta
 3TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772128301; x=1772733101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MczOQdlV3Z0NIfpzTjI1i3JRBKuufM71zp9/8Wg1KuI=;
 b=IxGS9mYzSExfevhU7D7E2VKbKsweRTdfNNjulkYs/gzCHBQN/AoZqYumV/YPdqeR5p
 U6NHabPB0oMkD+qe0LUj8MCStJls1hNoLi4BDIWE1HVBfRu5YOF8O3HhyPIT1MmurnJv
 K248fqf67xe1hZmKwQ9vk+L7au/FAQq2k/Krzn54JJLe6tAjmvGikfCpj9pQ85OwZofk
 BCI8mSdco/On5PhhqBj9SbxlE0mUsNhYZNzmGXQxBKGEB7sc3iGs1w+dIypTavohbFfT
 mlIs7w3jXm8CttqB1KQitM6J1YbSHPqIrgIyBMMlioo4GyRoJCgnCy5uVkKfen64FVJd
 l52Q==
X-Gm-Message-State: AOJu0YxuwxpFyjX5jfg7lDqQ+H8Lp6JLKpsd7IRAnD+/olfNy/NJVbaZ
 iJDl1Rm6K+z+KzA5Nr4FS1fEyS72BhzCnU2K2/xapo/vrmPOFbbrHIzKq3QP3B43R39o+0I1raT
 ix9Z04skdGgeA+K4wAAGY+u7mnxSmPfs0PLr1EhaCCw==
X-Gm-Gg: ATEYQzwSLL9cXfMV7v2uJZtT44LAA9hTFt2yL/gDWKR0WikMD/bjgsSNg1ajnirreAW
 eW+wWgLsJGsJfpikS+ILuYVhGMORKIsqMVESfgrhVuqiyUqUkLCuBuFjYi34LpEV1dxR8Njbhvi
 5Ptv7gMisc76gXRngEM832BP0H2Zbx1aOUtnM1o5+e2ObWTcIDg6XyG9VFrj4okdVsapQmIkoSu
 sQ4Ic8cVG5XN1LjUy3Q2GvWH2FSlmrV6CdSO7IAtNNUptJYMURNmIay4Tp94crmUJqSANqmpX/S
 wDvkMo6LAY0hhAHp6u4hAK5ZTW/d1UGDZtzqtAq4LCSKZ345djFiOQVDvax/UgpB9u0=
X-Received: by 2002:a53:d0d2:0:b0:64c:a471:980b with SMTP id
 956f58d0204a3-64cc23514e6mr73937d50.72.1772128300679; Thu, 26 Feb 2026
 09:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20260226111001.1021810-1-peter.maydell@linaro.org>
 <51c0d1fb-df43-412a-83f8-f01b868595f3@redhat.com>
In-Reply-To: <51c0d1fb-df43-412a-83f8-f01b868595f3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 17:51:29 +0000
X-Gm-Features: AaiRm53OvELh2ixgm33pUQJJBAm9XAL5014ZJddyq29cFcYdtKXAh_UGkuQaiZI
Message-ID: <CAFEAcA9MChu8iEvumR33c1bN++h8ktVi0ZAkQhkiL2hoqU=oMQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/coverity: Drop --enable-libnfs from configure
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 26 Feb 2026 at 11:14, Thomas Huth <thuth@redhat.com> wrote:
>
> On 26/02/2026 12.10, Peter Maydell wrote:
> > The environment we do our coverity build in (amd64-fedora-container)
> > has just upgraded to Fedora 43.  This ships with libnfs version
> > 16.2.0.  We can't currently build against that: in commit
> > e2d98f257138 we added a requirement to meson.build that libnfs be <
> > 6.0.0, because of an upstream API change that we haven't yet updated
> > block/nfs.c to handle.
> >
> > The result is that the coverity CI job currently fails in
> > configure:
> >
> > Dependency libnfs found: NO. Found 16.2.0 but need: '<6.0.0' ;
> > matched: '>=1.9.3'
> > Run-time dependency libnfs found: NO
> > ../meson.build:1150:11: ERROR: Dependency lookup for libnfs with
> > method 'pkgconfig' failed: Invalid version, need 'libnfs' ['<6.0.0']
> > found '16.2.0'.
> >
> > Fix the coverity builds by dropping --enable-libnfs. This means we
> > will no longer have coverage of block/nfs.c until/unless we do
> > that update to handle the new libnfs API.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   scripts/coverity-scan/run-coverity-scan | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
> > index 43cf770f5e..9b89a3303f 100755
> > --- a/scripts/coverity-scan/run-coverity-scan
> > +++ b/scripts/coverity-scan/run-coverity-scan
> > @@ -424,7 +424,7 @@ echo "Configuring..."
> >       --enable-linux-aio --enable-attr \
> >       --enable-cap-ng --enable-trace-backends=log --enable-spice --enable-rbd \
> >       --enable-libusb --enable-usb-redir \
> > -    --enable-libiscsi --enable-libnfs --enable-seccomp \
> > +    --enable-libiscsi --enable-seccomp \
> >       --enable-tpm --enable-libssh --enable-lzo --enable-snappy --enable-bzip2 \
> >       --enable-numa --enable-rdma --enable-smartcard --enable-virglrenderer \
> >       --enable-mpath --enable-glusterfs \
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks; I've applied this to master to fix the coverity job.

-- PMM

