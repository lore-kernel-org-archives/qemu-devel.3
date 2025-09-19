Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B210CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcjP-0004GM-R5; Fri, 19 Sep 2025 11:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzcjF-0004EN-Iy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzcjC-0004Bt-Qk
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758294525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o9AG2b3Xk4BUBItKgd2egkLdwBUwgWGN4TIABloEwLk=;
 b=SDkQClxiZpuxYYKknI8o2u/MiBIe4tWq/BMZAHZVaG7yKzo4pfcS6EfwJSGRqvIMl5Sv/V
 AlPb2atG9hq6vIJrB5WxsoLPzeNIIUbh6Usou6yoNegCQkqaPzUJ7nogQYYw0d1NIaYbNs
 XrpX8TopQcIABWMnYLbOs1AFWU5bqW0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-9nHxZ-RGMXGgSa2Eggng6Q-1; Fri, 19 Sep 2025 11:08:42 -0400
X-MC-Unique: 9nHxZ-RGMXGgSa2Eggng6Q-1
X-Mimecast-MFC-AGG-ID: 9nHxZ-RGMXGgSa2Eggng6Q_1758294521
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee13e43dd9so879598f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 08:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294521; x=1758899321;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9AG2b3Xk4BUBItKgd2egkLdwBUwgWGN4TIABloEwLk=;
 b=gMjvgsBS3jjE7L/97WWKRgKlu4sHuvvGIfv1dt0OkKeUwOrB2z9KgO63GW44CubyWi
 JrNDzwM606ewSNuOVPHWjavbWxffzDFdF0hzWFcrqGDH++E3QMBp+2rgUPauiHwPEUG3
 8nN+hK5WMiBhiG+VTpymT52C0hyVIBw+74ATNSaD56x+/FuWjYLrMj3/00SE5bS8l/0J
 p6eLZ0sjD0dsNdjPn3eapF3P9ZTbwkY421v0+Io7RFMFqhYGdSG4cOhc2MI9cqEwHuDx
 fzwFM+YxcFOiZa3ZunqaM/PRHbift1fWyTZZwTbP2Mq0wGpY16A8+Y+1VQ2Er7U0rp+E
 RYaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0nI6W0WHvccp/5iKjACtcbiAZ4nhOGe2rnyrdGoxDjvUIm1AvvzegZz/zM+mrDemtw815asxC/8hF@nongnu.org
X-Gm-Message-State: AOJu0Ywcdtb9ZiS0YFgta6tv10iwpz5wE52QlZFhHnG3kBp7GT6poRsm
 CFiyJdGZJxXBdrdle0gla4IAPY+9QzXaZu/RUESJ6GKbVNf8qv81vvLOcveRZ6xr1Cxf57l3uwl
 o7zQjTR2bX/Ej1KZy0N5RIfP2XYtQGehGvkGxrWvjN0EtciCos1ylaqlo
X-Gm-Gg: ASbGncvp/whY3ICroLtLbff4CpNwFF7lwLIhB2ycqelvy4yQfWuc47dbW+YLjTGNtzM
 cIcGQVAGzJXPl+UlCT9n7XFFyCb5Sror4jYcm9uy0vTlwxaR3IubWfrDMZmDzbpdYo7V48Ck8xl
 5OIf097K3bEWXJmJZ+iMa03Zm0yTDy7f3MbEXE+rlfftjhinaSpZGY0vIoPiGnpT1s2yzNNY9bq
 koI8mqSFMEpD8mZEPgWgY/SmdeO8M412FntrwUhxdIpXAyOwjkVpXZBm4SMF0wua4F+N64sqwZ5
 FalnjAy3KUMAWLj1OJGBbVbgrtrE6+UguPM3uVTKrm9cn0mf7GKPgkd4XXA+M10VcUGaEua/vJx
 wTg3y9ccepUge/LbAEDPGIJsJan6vTf9C6KkQLIoJblI=
X-Received: by 2002:a05:6000:4014:b0:3e2:4a3e:d3cf with SMTP id
 ffacd0b85a97d-3ee7bad10e6mr3489611f8f.5.1758294520822; 
 Fri, 19 Sep 2025 08:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZvdeHGQV1fijiB9XIiaQwzcRJV9g9CcD+bbXC81HHiwynR1dJ7ZAo1fCbMg5Tgup/DTGrcA==
X-Received: by 2002:a05:6000:4014:b0:3e2:4a3e:d3cf with SMTP id
 ffacd0b85a97d-3ee7bad10e6mr3489581f8f.5.1758294520422; 
 Fri, 19 Sep 2025 08:08:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7410sm8231578f8f.35.2025.09.19.08.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 08:08:39 -0700 (PDT)
Message-ID: <8f53361d-3547-4228-a4d5-b1daa117bf2f@redhat.com>
Date: Fri, 19 Sep 2025 17:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] configure: set the bindgen cross target
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250919133320.240145-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/19/25 15:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   configure | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/configure b/configure
> index 66613f3f4c..32eb313941 100755
> --- a/configure
> +++ b/configure
> @@ -1878,6 +1878,12 @@ if test "$skip_meson" = no; then
>         eval "c=\$devices_${a}"
>         echo "${a}-softmmu = '$c'" >> $cross
>     done
> +  if test "$rust" != disabled; then
> +      if test "$cross_compile" = "yes"; then
> +          # it's actually a clang target triple, but they should be same
> +          echo "bindgen_clang_arguments = [$(meson_quote --target="$rust_target_triple")]" >> $cross
> +      fi
> +  fi

Not exactly, see https://github.com/rust-lang/rust-bindgen/blob/main/bindgen/lib.rs#L683.

It should not be hard to rewrite in shell starting from

   clang_arch=$rust_arch
   clang_machine=$rust_machine
   clang_os=$rust_os
   clang_osvariant=$rust_osvariant
   ...
   if test "$android" = yes; then
     # e.g. aarch64-linux-android
     rust_target_triple=$rust_arch-$rust_os-$rust_osvariant
     clang_target_triple=$clang_arch-$clang_os-$clang_osvariant
   else
     rust_target_triple=$rust_arch-$rust_machine-$rust_os${rust_osvariant:+-$rust_osvariant}
     clang_target_triple=$clang_arch-$clang_machine-$clang_os${clang_osvariant:+-$clang_osvariant}
   fi

Paolo


