Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38943EFCBD2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2230-0006Iz-SB; Mon, 16 Mar 2026 03:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w222v-0006Iq-BU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w222r-0007OR-5D
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773644835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OtybMyFGIYixpZeQU07B9I2C107D4J5PeYDYzHR+HU=;
 b=TWTwy1CQQu6dUiwCN/UiRuXzjdOtutuFXnkgib3mHnBnnCV/MiHnayL2scYdDXlSq+HMj7
 YsG11U5KwTUwfbedLmCMVbi4eU3sWxgUadASuzRkANHla2/NXkz0ZsG0RJrYw0qvQrwYEL
 mGBUr8h6NsYm5s38YGyiNkEHy4yc/+8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-juhUTYSGNjus3I1GnNKSvQ-1; Mon, 16 Mar 2026 03:07:13 -0400
X-MC-Unique: juhUTYSGNjus3I1GnNKSvQ-1
X-Mimecast-MFC-AGG-ID: juhUTYSGNjus3I1GnNKSvQ_1773644832
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-829fd367abfso2002633b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773644831; cv=none;
 d=google.com; s=arc-20240605;
 b=ZnNNnOflBDwTdR1IFiCff+gRoat3Caw0//hVcfuoeprAq1IhpyiXAVCoX69vu3ghoX
 XFoPI1wX1i2yUuVM9EiOzcM8MwcMtIvucKFXOcWMNtA5+XCsCl4CfpVArP6iChtziDqW
 5yBJO03xXGFy5c5akQBUsY7iqLQInnwrRkmXTaDC2aP/GhaA1MKOQ3g8MTY+tP6vtXxj
 GKrLG4bR0ptWrLbunElYHCiKVnjpzCNaHlgJ5YVLxeQbDca5YfH+g45tmoW3ovJcnDRW
 if4+MtW8DDYtBeRRQ1ka8rF2I/QxGRDWbfKdNzyhia10tUnQ/hVcUvoMRGczMxrVCA7h
 UWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9OtybMyFGIYixpZeQU07B9I2C107D4J5PeYDYzHR+HU=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=JfbNaurLUwqihvOs0x1AMfNU3AZZnf2dbEKLtC2p4OYm7NWNWjtAdMPnM/4A1gtZrM
 UWSwSAd4TCsKQKmDBH28p2Scp89zgiJxYn/mbfDbGthzZxT+tUhWqMgWsRctERpwNXZx
 JilIyBJIzaX2RQECXTHBPz9k4J45uxhxlHqlhBHoRzP0RYFHxfg338gBISg4wmKpoZc7
 eFWFKh2CKqH1ldsR6Otl9smEY6fLxjNXRZ1Frf7DLspqpKeAHzKoB6NtNVDOXC0zaDHT
 UTeAIxKqoIOZnad3xldWLbSv7nwabefIR/05vq48WFgtlHc74rko0e6+8bRYglopeDvl
 IFwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773644831; x=1774249631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OtybMyFGIYixpZeQU07B9I2C107D4J5PeYDYzHR+HU=;
 b=o5yK1M7PvK6qfkAfpMJuf4sBARDxxyiMnl6w4c7mWUIPOGHk1XnrX5hutab5t6XhV3
 yWC7ikf6TegAGaNmVxSSCB1/L4gnXcPVwOfh0SOdbD/g4pVwyRo7Q7kHO88PYs9PUXDN
 ReQnI4SPMM76wRslVTeTDiFVFOIoJJA4e5aWEv3rbb7QffmlDNd04wW1U0VAR++OV+f5
 QV8OEtZaUCkI8NGEk5+xBiQfDwo+twh9lXl9T85HcidMPvxEj0sg+vQWWZq7nm7P67Vk
 /7cOfgaIFrV/9uIhCsAZIS3P7fMMZ9moaV19qL+esw7prRByt2aPiTZiYBXgpabsbngC
 nbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773644831; x=1774249631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OtybMyFGIYixpZeQU07B9I2C107D4J5PeYDYzHR+HU=;
 b=kMbxJpY/PufVAV6YrKfyXe3wyyBRgLKUV9G5Zailgvdz5SlTImqq5fnaAD0WO5JB+g
 Kk3Bv6NxljX0R2qHB03mW6koaFscfonM2NSvS7zgqGvzPowIzgNrfn4vYP7gnujLQTPR
 frhOxuNo06VkATptb7qFL5e79woHh8C5pBymX9ySleWRQ9Hz57Pb3l+ACDSHtQoSW/v1
 TId50RsEBVcNAFQOzc1nd7xGN83wPoOHXyE2YTtaIV34lQAOVXMfNbON6VeLGTM2Jnel
 D+Sz8o33QQiJoijU4Rwi2sM6vRp4i54rzw7HqB9z5VY6hjfOi9slPUZ7ar4/1DFPb+DB
 einA==
X-Gm-Message-State: AOJu0Yy1RlYmW0lKLPqADIAwYplMDkN64HNcTjk3phxpCQ+EhrZvZOBq
 C+ixHHHlSnJCx4ot+rhN0FGBal0CeNYgcR2FYQJoaAK4mp3lY0eZZ/iz3nNDT/DEn/KpkLtS/xZ
 qdlF/D6m0GLoqpo+hrUg8BCH3+B6KLELZv51PZIr+gu3iYcn2Ikit1ov6svroj2jPMmA0L8tXtm
 YGDbXHi2lywSTsW+bP+yzpuMCVEcykjSyFTkGeaQpS4Q==
X-Gm-Gg: ATEYQzwXmC6d30FSq1obWFKZ4lWHm0jwlE9PVhRtCbr8a3DsRPxE1rq2xZpxp8Xw53y
 lERQllB8Fl3JpB+EhDeJ+Cn2NSNcenio1gD73fKMKmvgRMQ4AnC/UoGux1J2l9I2IFTSAIu8Qwe
 LzCypQ/J0BHjlocugFzmdMMkwfSxD6L8iCcJy81RPT4p6wQuOuJnP/SgmvP0nnaE/ROQXZo4WcR
 kjlPh8f+OrrS+DNjkLVy1AFZocM7ArkVAWFioKpaXR2QhRM64ROCOMKrtyXMLhokpFmWdpRZMuU
 fnKLFVZ/AUTFuHtV9XWRrxg=
X-Received: by 2002:a05:6a00:2986:b0:827:4343:4c1 with SMTP id
 d2e1a72fcca58-82a19875917mr10937927b3a.29.1773644831257; 
 Mon, 16 Mar 2026 00:07:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2986:b0:827:4343:4c1 with SMTP id
 d2e1a72fcca58-82a19875917mr10937895b3a.29.1773644830798; Mon, 16 Mar 2026
 00:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260314075500.215628-1-pbonzini@redhat.com>
In-Reply-To: <20260314075500.215628-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Mar 2026 11:06:59 +0400
X-Gm-Features: AaiRm50yrVj7l-W7HqQfWJhZB8i8Wtvk142yKSeikuU84SPE1z-lm23LrnWknw8
Message-ID: <CAMxuvaxa3Gc7hePpo9k62gUqcCTSUtx-6kDZm-B3FRAMbzzU8A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: fix build when --disable-rust and meson < 1.9
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Mar 14, 2026 at 11:55=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Commit e65030ed50ee moved rust_std and build.rust_std from per-target
> override_options into the project's default_options, in order to avoid
> repetition.  However, default_options are validated unconditionally at
> project initialization, even when Rust is disabled.  This breaks builds
> with meson < 1.9.0 which does not know about "build.rust_std":
>
>   meson.build:1:0: ERROR: Unknown option: "build.rust_std".
>
> Make the options conditional on the meson version, since Rust only
> supports new versions of Meson anyway.
>
> Fixes: e65030ed50ee ("rust: remove unnecessary repetitive options")
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 11139f540b0..00f482d3fa6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1,7 +1,11 @@
>  project('qemu', ['c'], meson_version: '>=3D1.5.0',
>          default_options: ['warning_level=3D1', 'c_std=3Dgnu11', 'cpp_std=
=3Dgnu++23', 'b_colorout=3Dauto',
> -                          'b_staticpic=3Dfalse', 'stdsplit=3Dfalse', 'op=
timization=3D2', 'b_pie=3Dtrue',
> -                          'rust_std=3D2021', 'build.rust_std=3D2021'],
> +                          'b_staticpic=3Dfalse', 'stdsplit=3Dfalse', 'op=
timization=3D2', 'b_pie=3Dtrue'] +
> +
> +                          # build.rust_std breaks with older meson, but =
Rust does not
> +                          # support old meson anyway
> +                          (meson.version().version_compare('>=3D 1.9') ?=
 ['rust_std=3D2021', 'build.rust_std=3D2021'] : ''),

Fix the falsy expression to be [], then

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> +
>          version: files('VERSION'))
>
>  add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default=
: true,
> --
> 2.53.0
>


