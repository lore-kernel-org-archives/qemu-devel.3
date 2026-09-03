Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195E3C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25f3-0001TL-Jc; Thu, 03 Sep 2026 07:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25et-0001Je-EZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25er-000812-UY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788435065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEew52QMjNWmNYII3vQI2Rwv4QcM+xiK5rljE4+oG1w=;
 b=E1JB7WIu22h+nPaiSVTOwbLEo5RKq7+XCYlkCTvOYk5DcIjDdGiOxhFVZ7XEmwr6MGNkO2
 krMsa3oCTj2xaCYBsIcc01xUXZIEbQz8gxAr4Msn71UqLXagMz9Zqi5hwIeGuaROjaIsD/
 pkA+TKjxcDZ8IiulOQ10TnROqxJ5IqE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-SgDb95o0PLKsx9pcbFXcRw-1; Thu, 03 Sep 2026 07:31:03 -0400
X-MC-Unique: SgDb95o0PLKsx9pcbFXcRw-1
X-Mimecast-MFC-AGG-ID: SgDb95o0PLKsx9pcbFXcRw_1788435063
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso2628435a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 04:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788435063; cv=none;
 d=google.com; s=arc-20260327;
 b=XlPPxsyh7M3kxR3OYeWZb779kGnqx4CFku8VlqT1sLPQqT4rk61FER1rVD8BBb44YY
 aY+Mqsk4mdXwb4QEDtFyeNEKUKbg83H7YqyZSzcOkG4+HndAIEad1qTfJEmCCiv0VN/5
 vm6R+SHw003y06i1CEXaCb+Lkt2e3aQnQHKnALBXY9DucFZSQoWyUZbUhQUczXxbBwSI
 sV88bgYO+NGxdHWapnJk7ff57JvYx8jgdH/Cj0v+qsRwe8FRbhkNt6J9s+H9vY/GU9fS
 ux1RsfWOFAcNSOixoOmM/60P9SDfaPaizP/pWlig5a5oyfIzm7ixnV+CsVKQaDgO5eSW
 HiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cEew52QMjNWmNYII3vQI2Rwv4QcM+xiK5rljE4+oG1w=;
 fh=cdRJnSWr0hdCEFqMJgY+ok+/4UsQGTzFjKLqSTY9C6M=;
 b=Bj7/3pqoDqbjgykUmjfTz1JM+8ZC2xVYAM1vMK0df/FcpweDi77awn769K4KgOznNU
 yFCNn8um6cmdKj9KYngPdyPQygPo9whC0dELeLgmf8sGptjcFHXO0LSacqdxDW87DlQ5
 xgYQnEu+Xrstm0OnElMW0mYzVYi0AQTDp2pJmz4jvIzIq5D/56GTpw0Z6yilQB4VZcG0
 AXVjkwGYfziI3a++jEz198I568iU9x34+yLB85XB1nNZEQVP2iw1lmyQwtPctfok++r4
 hNYAfY6D3wS18yQGXp/3YzGgmU3oSizwRAMq7MQ00G4xhLPIXNTHNSZreVCRLoRFechu
 Cueg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788435063; x=1789039863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cEew52QMjNWmNYII3vQI2Rwv4QcM+xiK5rljE4+oG1w=;
 b=IJSucimAdfAKca9Axso/Q0KC8eHIYnxDnhuPK6wElu3xz1fzHWsD+ZUOzF3vWHCCBO
 iSuexpkNOTv5PF7HPePbn6yHVmRJOmcdFBEl/ZDfBC+Oi4ZSbQf+9UG5tTCfDTrEuQg0
 J/z+xpD79c5KUjtXXk25OVnQl0grVsOeoGR3xMAPnDgz3zbr8fH5QOZ+cuPJ6bWpN6a1
 Mhl6jHjsL/dxAG+RB2Cy/1QPYd6gjChNZNSmNlm+6RvyS5kCaYEb2cAqVc6pS1Z8Wp+d
 HxYxsvg8Zwc73zyzpk6JEcUFWkQ68MmZG4aToyOfhxOaudPRBsP+FLzkpbGk9TTkWMMo
 eO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435063; x=1789039863;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cEew52QMjNWmNYII3vQI2Rwv4QcM+xiK5rljE4+oG1w=;
 b=HBE+Ay/+YxDCLcHVm92PkTgtFpGNGsGXI5NYWKERXpQmo0N9RhNtcSM8i6HejWKeTU
 AQHw8GbWPbBEL6lOqCfwkVP37XwD7zmDdKBLJc+bYHgns6PU2M9FxIxH/naoIwxC3RyU
 9oZKPEQ4b23qvBxsHd8Ri8mT9AODOjHBcO4giyZWtu7N+jCv1ygHpt83/NB6jzaGshUO
 7e5i9FZfe3Fx9Fc4sUBgFeALowKPlsdrp63yaHAUgUdgmuSUKGcza9ujNP79fpdbjIGA
 RiX787mtX5EhpOGeXdhzVjjZ2a/vggFmneGtkmPEILFymuq89tqpaG/E0jy3evRfW6V8
 MHRg==
X-Gm-Message-State: AFuF++mvJzHfe3UjTPWz+Z6FROK1UQz50icF/Ho0EX6osTTje1wYk31k
 6PyqmIpqz7HGJYb2PK4HBHDZKf/YLyeKOtGIPgb/xUDQ/OEneosVxLCta+rztIz35hHIqNQpb3a
 /yrx71XCZXASshpV2wUFi1WU7ynpsez6i5kM1+gGMmfN0VrLAPFfIESgY0xiSNla4xeNpoETv7P
 URz1GVMsjWuW73X1yXMYIZMvkU+IiSzzs=
X-Gm-Gg: AYBFou04Jnisk1ETOhLWRXqkJX+q8Ynr+rBelrQoWOGNmObRI05ALHceeVhPCu5tN7X
 ujrLZ36PbLtHWF0WqvrngmkVm9ABVic+nLlqpc+52LG4LtsXLQeamKDwvN957DIe7QaH47rh+8a
 p8Oe0se+LSdF9r9SvQOv/DakJUuWwCbtT6YGdYrMXRmN/SPmOnBWYGRqZhsJAsYCeleLJkpmBsN
 Pbxe/dgwVMynDiYF2bSaQcLPrUTWQoVavUgclUnk0i2sIpziuo1wY/tQkHMPTLaT0cSh2EJ3dBZ
 gw==
X-Received: by 2002:a17:90b:3ec5:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-39aee172d61mr17059765a91.14.1788435062576; 
 Thu, 03 Sep 2026 04:31:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec5:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-39aee172d61mr17059683a91.14.1788435062091; Thu, 03 Sep 2026
 04:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260903103548.2142568-1-berrange@redhat.com>
 <20260903103548.2142568-4-berrange@redhat.com>
In-Reply-To: <20260903103548.2142568-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2026 15:30:50 +0400
X-Gm-Features: AcwNN1XTEaTpp_CNpIpChdcHOp2KYm4_AVBc18qxQjesdIGN3o7sgGI-iz-EA-A
Message-ID: <CAMxuvazjmF8QQAH5BwrUkxN8uAYK=2j9fBTm4-g2Ztyg-wDAuQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] meson: bump min upstream CLang to 17.0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
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

On Thu, Sep 3, 2026 at 2:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> Per our supported platform policy, oldest distros we target
> have the following CLang available:
>
>           Fedora 43: 21.1.2
>     CentOS Stream 9: 22.1.8
>           Debian 13: 17.0.6
>        Ubuntu 24.04: 20.1.2
>             OpenBSD: 22.1.8
>             FreeBSD: 23.1.0
>              NetBSD: 21.1.8
>  OpenSUSE Leap 16.0: 19.1.7
>
> Thus Debian is our prime constraint and we can move from 10.0
> to 17.0 as our min version.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 388423e4fd..5315420a41 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -334,15 +334,15 @@ foreach lang : all_languages
>        #  error You need at least XCode Clang v17.0 to compile QEMU
>        # endif
>        #else
> -      # if __clang_major__ < 10
> -      #  error You need at least Clang v10.0 to compile QEMU
> +      # if __clang_major__ < 17
> +      #  error You need at least Clang v17.0 to compile QEMU
>        # endif
>        #endif''')
>      # ok
>    elif compiler.get_id() =3D=3D 'emscripten'
>      # ok
>    else
> -    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v17.=
0) to compile QEMU')
> +    error('You either need GCC v10.4 or Clang v17.0 (or XCode Clang v17.=
0) to compile QEMU')
>    endif
>  endforeach
>
> --
> 2.55.0
>


