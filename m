Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E2C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQgU-0004uE-62; Thu, 17 Jul 2025 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucOgx-0003VC-6m
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucOgq-0005H3-Jx
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752759020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJajLBJntV3iJfbalaIKtzCUFJDtUP3+96DN4juhrVA=;
 b=Eau38zzmC9d+5GnOQOqmhVO4RSuU7YKRwtsJ+y3XwSE0WB+K+RRysMDJAeKO9Iy3KCVioa
 sId7NZEx7SacP4+S8wVUnFRdtV20v0EDPfoiqx8MMzg+FC0eqwdjSumx/TpnWoA0VJt/Ms
 kdVwqEoPpIdBLNQQAzKKlFcDuFMtK9M=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-p4OCLeqlNreneml9qYZ03w-1; Thu, 17 Jul 2025 09:30:18 -0400
X-MC-Unique: p4OCLeqlNreneml9qYZ03w-1
X-Mimecast-MFC-AGG-ID: p4OCLeqlNreneml9qYZ03w_1752759018
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e819f79d125so1237768276.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752759018; x=1753363818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJajLBJntV3iJfbalaIKtzCUFJDtUP3+96DN4juhrVA=;
 b=VRhfExWbxFKPksDHQogs2sjnfVERfZAaK2rvB1bykfqlEQ3CPQQLMClO59Vupsesa/
 injtmQHQONOkSuFrWThjXvWe5QLk+6ixOptoYmGfMkym1ky/uwYC0ceY+8qlmIIOGbn2
 EMjhs49CGB8PLykEA/Hcd3RCXbIgdt6kRynGdG84nwivPr/332EujfKl+LDtihmlECs7
 tsbn2Wg64MUM8kz3cYZOcX5G8geap74D+5p/aQ3VPGbWdGQgqECieuO1gBiA4KB466EP
 xSi73cWxMZvDf86YbLU+Ltimi/O75O7ISjZ9WxYuPf70V32Rf/YMKX9AsqL0aJC8XqzS
 v6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYpW7HA4rWZ9pnX7r+wCjyr/e27CQ4QLo1VsEJwKtChMyb9zJ0JQUHi11c/PguqV9TU6ZXlAvwzjr@nongnu.org
X-Gm-Message-State: AOJu0YyCEsYocaA/38fkal4Dc7szTI+MVSIzjZ1HDQvzzTgzwqvM4/mI
 sk4J9/uKcl2BegzqbWj80hrea/osgne/NK81af7tsSWuO79TRMOCBVjuL0WOisG65kFNAeqW4fE
 QGpRSFvqMuQbvrBSkJo1sKcKdUV9F1TEDHpGybf3NBJY9PvCraHZXpOZTDlqIzCR0o8CF1+/0pw
 E5kQhs6ebxeeLsAZyOkZ00Nq1UvY1ISG0=
X-Gm-Gg: ASbGncunGpG8ue9D7apCWlKfdfK0s3g6bAY6/Hv9Z62bwN2mS8WqYrYpsljPG8i2MZA
 ufenWHc4dTqnkn+/E4YS7N3i0ZObXRCeOudsnt3StdGjmpjPJa1IyMABdYtxKF2a8DN4p9fpTwr
 H2wRiM47UQeoGdU3+oxzxx
X-Received: by 2002:a05:6902:844:b0:e8b:5465:fd73 with SMTP id
 3f1490d57ef6-e8bc23e3523mr7574996276.4.1752759017977; 
 Thu, 17 Jul 2025 06:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmJAlOetCTinGIjBMai/4+TnDuXOqsBCT/CYfl4zc8kVTEVcvZwyovZeeMY+UvH568NRwrGB3VgOCP1+tfzIE=
X-Received: by 2002:a05:6902:844:b0:e8b:5465:fd73 with SMTP id
 3f1490d57ef6-e8bc23e3523mr7574927276.4.1752759017180; Thu, 17 Jul 2025
 06:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250714110406.117772-1-pbonzini@redhat.com>
 <20250714110406.117772-18-pbonzini@redhat.com>
 <aHeNnCnN2RGmbxWm@redhat.com>
In-Reply-To: <aHeNnCnN2RGmbxWm@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 15:30:06 +0200
X-Gm-Features: Ac12FXytMwzHXjAc8fackMDPrgSao-rK4ljrlYTJBq58eEZZWKLxFDTygqMraNU
Message-ID: <CAGxU2F5VvrgCTzi1MXWqBA+G0hgi0xLf0mm7+v5==sDAVUKJpA@mail.gmail.com>
Subject: Re: [PULL 17/77] meson: Add optional dependency on IGVM library
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 16 Jul 2025 at 13:31, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jul 14, 2025 at 01:03:06PM +0200, Paolo Bonzini wrote:
> > From: Roy Hopkins <roy.hopkins@randomman.co.uk>
> >
> > The IGVM library allows Independent Guest Virtual Machine files to be
> > parsed and processed. IGVM files are used to configure guest memory
> > layout, initial processor state and other configuration pertaining to
> > secure virtual machines.
> >
> > This adds the --enable-igvm configure option, enabled by default, which
> > attempts to locate and link against the IGVM library via pkgconfig and
> > sets CONFIG_IGVM if found.
> >
> > The library is added to the system_ss target in backends/meson.build
> > where the IGVM parsing will be performed by the ConfidentialGuestSuppor=
t
> > object.
>
> > diff --git a/meson_options.txt b/meson_options.txt
> > index a442be29958..1e429311a2d 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -117,6 +117,8 @@ option('tpm', type : 'feature', value : 'auto',
> >         description: 'TPM support')
> >  option('valgrind', type : 'feature', value: 'auto',
> >         description: 'valgrind debug support for coroutine stacks')
> > +option('igvm', type: 'feature', value: 'auto',
> > +       description: 'Independent Guest Virtual Machine (IGVM) file sup=
port')
>
> This description does not match...
>
> >
> >  # Do not enable it by default even for Mingw32, because it doesn't
> >  # work on Wine.
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions=
.sh
> > index 73e0770f42b..78515404450 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -130,6 +130,7 @@ meson_options_help() {
> >    printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.=
68+ GTree API)'
> >    printf "%s\n" '  hvf             HVF acceleration support'
> >    printf "%s\n" '  iconv           Font glyph conversion support'
> > +  printf "%s\n" '  igvm            IGVM file support'
>
> ... this description here, so when this file is re-generated by any
> other pending patch touching meson options we get a spurious diff
> for IGVM.

I just sent a patch to fix that: 20250717131256.157383-1-sgarzare@redhat.co=
m
(I still don't see it on patchew or lore, so I guess there is some delay)

>
> We really need to get something into 'make check' that runs the
> generator and compares its output to 'meson-buildoptions.sh' as
> we have hit this problem over & over again.

Do we already have something similar for other generated files to be
inspired by?

Thanks,
Stefano


