Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE1EE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCBO-0004ej-BC; Mon, 16 Dec 2024 09:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNCBM-0004dr-Oy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNCBK-0002gK-2X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734359684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rJ0kR8ZbP1U6oTmfbjCP2qS2FAC/drfdwjJDFWcO3A=;
 b=Zu8ftPHVf1RrLsZ7kWPXnr2j+fz41jq1mqkzEMpVkSh3f/z1eYcCGovegJtruLWA5CLCGI
 dtWzxvb62AFgCSQ/U/8Zi0ZeV6kL+Gb6fjdH0Po5lRcfBnxZQgfttOnHOBDT/et1RgXAI2
 ATn1z/TG+uEM926jQMavs95gItIjmn8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-byYvQD3aOmKKKW1uXt_qZg-1; Mon, 16 Dec 2024 09:34:41 -0500
X-MC-Unique: byYvQD3aOmKKKW1uXt_qZg-1
X-Mimecast-MFC-AGG-ID: byYvQD3aOmKKKW1uXt_qZg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so2117150f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734359680; x=1734964480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rJ0kR8ZbP1U6oTmfbjCP2qS2FAC/drfdwjJDFWcO3A=;
 b=wwdvfdJbhlbH+bTeYBJxgDbX35YuLD+wTAFFlpM4twlM0mr4FoG6npNoQnE9oYnrd5
 NNvUCV9SRJpzi9lV2sD9hqqi3P1BJebWVIk2TDjz/uDvTwOdDXL3VQKP6BOQEwL9e4pH
 tmHjGceGheBLcM1axWDKt8dFHBcjtk5plfpIC475DlzPYfTQqRPXlE2Ng7AspdGaQ1Wb
 LlNrJ5xl0gtYNyzBY/B13spW362VUbRTat3TVQ5iqeRQy2kLyebL7DuhtdTorrb4EjsX
 wBuVrIEEeRi0TbpfZI5TGIzxaKtD0ENijjReptCRpV3WvrOFNPaE6sDjLvU7aEFwc4bw
 cSkg==
X-Gm-Message-State: AOJu0Yz3IK2WkkoCobt6OSSgbo//LOPnR7ilK5tqDkI/tpuWICYlxLWX
 /qc4kDZdNJxF2DSd4dzeLTdxjvZGp2x/ka3He+zS9qXJiPy+O6rNuRSDRjazpSmspdF3hIGEugH
 IO8IBD7IvRPk46GKn/or2NXh3GWLUUptPwBUfjksEJ7zxEFH5RdS751YQPsQEZFMf4aSumVR23W
 0WA0+4N28Fpg71maWHlKHe/j3XSMI=
X-Gm-Gg: ASbGncuJIT6/LA8pdWy70u1A5GCqyv6kQbd6FCZb0W490XRVPFaUxBCC8dXRov1c2Wg
 htXK60xjxLy8XI6K5Q/fvinq/AIcEkP8tWT15kA==
X-Received: by 2002:a05:6000:1acf:b0:385:faec:d945 with SMTP id
 ffacd0b85a97d-388c365199bmr10696292f8f.9.1734359680490; 
 Mon, 16 Dec 2024 06:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtmCDgvlJYKHR43kPc8ChMxjGS/kfBsbPnHE5+7+foAzEnZ4LAKuhPTodf475p1+UVWgma9Uxe6FXlY+q7X1I=
X-Received: by 2002:a05:6000:1acf:b0:385:faec:d945 with SMTP id
 ffacd0b85a97d-388c365199bmr10696279f8f.9.1734359680191; Mon, 16 Dec 2024
 06:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
 <20241216035109.3486070-18-richard.henderson@linaro.org>
In-Reply-To: <20241216035109.3486070-18-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Dec 2024 15:34:28 +0100
Message-ID: <CABgObfYZkBmjR-z9rmMo46iJ59aJKMYhJjWmO+1+eEdU2-6coQ@mail.gmail.com>
Subject: Re: [PATCH 17/24] rust/qemu-api: Use device_class_set_props_n
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Dec 16, 2024 at 4:54=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> This means we can update declare_properties to drop the
> zero terminator at the end of the array as well.
>
> Cc: qemu-rust@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  rust/qemu-api/src/device_class.rs | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device=
_class.rs
> index 03d03feee8..cca51fe1a9 100644
> --- a/rust/qemu-api/src/device_class.rs
> +++ b/rust/qemu-api/src/device_class.rs
> @@ -7,7 +7,6 @@
>  use crate::{
>      bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Prope=
rty, VMStateDescription},
>      prelude::*,
> -    zeroable::Zeroable,
>  };
>
>  /// Trait providing the contents of [`DeviceClass`].
> @@ -31,7 +30,7 @@ pub trait DeviceImpl {
>      /// device.  Not a `const` because referencing statics in constants
>      /// is unstable until Rust 1.83.0.
>      fn properties() -> &'static [Property] {
> -        &[Zeroable::ZERO; 1]
> +        &[]
>      }
>
>      /// A `VMStateDescription` providing the migration format for the de=
vice
> @@ -87,7 +86,10 @@ fn vmsd() -> Option<&'static VMStateDescription> {
>          if let Some(vmsd) =3D <T as DeviceImpl>::vmsd() {
>              dc.vmsd =3D vmsd;
>          }
> -        bindings::device_class_set_props(dc, <T as DeviceImpl>::properti=
es().as_ptr());
> +        let prop =3D <T as DeviceImpl>::properties();
> +        if prop.len() !=3D 0 {
> +            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.l=
en());
> +        }
>      }
>  }
>
> @@ -134,7 +136,7 @@ macro_rules! define_property {
>  macro_rules! declare_properties {
>      ($ident:ident, $($prop:expr),*$(,)*) =3D> {
>          pub static $ident: [$crate::bindings::Property; {
> -            let mut len =3D 1;
> +            let mut len =3D 0;
>              $({
>                  _ =3D stringify!($prop);
>                  len +=3D 1;
> @@ -142,7 +144,6 @@ macro_rules! declare_properties {
>              len
>          }] =3D [
>              $($prop),*,
> -            $crate::zeroable::Zeroable::ZERO,
>          ];
>      };
>  }
> --
> 2.43.0
>
>


