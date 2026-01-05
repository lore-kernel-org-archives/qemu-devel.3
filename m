Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AAFC2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcg9T-0003jD-H5; Mon, 05 Jan 2026 03:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1vcg9S-0003id-9L
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1vcg9Q-0006N2-Gt
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767602478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpBaI83/QXQnH/6r1gOGX/LSjWj4be/cHbKPdrjMLlA=;
 b=erCkl+lmhZXoCJqjlBIU0CiT5qk5YpxcJ34/TL+bMa/gv5aMeb0HOW5uAFw3shGRMlL98P
 rzTAfurMmb1flVFUDykQf209NZtB5H3jeZBO0dqSNhTMO0n2zD8EOxHSUJXuV0TxxlzSkZ
 JSNhgprEkQLLH1hAtckxVY9cSYSbdCk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-vtAVs4ZgOPGLfsgD5dqo7w-1; Mon, 05 Jan 2026 03:40:09 -0500
X-MC-Unique: vtAVs4ZgOPGLfsgD5dqo7w-1
X-Mimecast-MFC-AGG-ID: vtAVs4ZgOPGLfsgD5dqo7w_1767602408
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so120472075e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767602408; x=1768207208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpBaI83/QXQnH/6r1gOGX/LSjWj4be/cHbKPdrjMLlA=;
 b=lRkBhJvx5J851586r6SEtV9+ITw5F1Fw7yQ+y9cRh93CBxv0IXiWvEazBWvOFogTto
 jRhzMwAxF/RslNfaeXwtBGxgBbs6LlRFd3VOZtBL7gCEN3d0BttMDm+ADKIBgj746pn1
 P6/v9SMPTRO56uY32FNTKJVeFDcRe5hARloUbIsR1g95mSslBnGn/BAc67zyRaFyah0F
 wOU0T3rL8q3vctWvDzbJIFXDzw1qncW9/ZKrn4gd+YzmM6rY/007+mBh0w7rgFMQ0JXQ
 +nTqtcrtWTfgprjtK9U8nVOohWdMF6whjOBF04DVQHlHayHozoT0Fw2a3udgJ2T8Bz4g
 goew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767602408; x=1768207208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpBaI83/QXQnH/6r1gOGX/LSjWj4be/cHbKPdrjMLlA=;
 b=VS9jqIL+PLcKvhUV04wPqH+TuY1zWmKpXvZ0KIhN9QixK2+MwS09DtXc754UO9+aSN
 Ivx8bPQ5jEEnmjpii53j2Mipz31zAGnZK0A5jdp/yfXjXg7xtN7WbOxJjnLyfgg/BKjA
 DB3a+/8pMnzZviRIuDAlIJ5hmcGF+/1FhCzxLxEsTTn9fVNJ7nOYijbNLux7U8iPlRXD
 acsnwix6oAM6+2afBgScA0VvUOeG62x4c2mEdZaP7W1l2Vd8+XxuKh1VQVufGLdyjdbF
 fqKbpWxQA0aXFjJKfXT0mMcVlVpqP8dxWq/5TJgVZParoK67Y0WIgATKqlkpfNNozuhs
 p7+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU90dXrJus2aFp7Tp8ek+Dc9/axY1E9yGmjfEWiSdsrZ3imBWke5R4ihUqJWuypdhZ43iGGCOqifuGw@nongnu.org
X-Gm-Message-State: AOJu0Yztt30A7moPl9s6Tl8XvWqJY4cYGlfCo+/Hk2FSuasB2me4I/mL
 dS2mP86AzQJr2EREdnCyErMmgRPVLILBD1yGLHqSr/OK1YZ9i7/5gpf+RwFNBlwU+vE2v8lNP6L
 o4AQk0vhwQ02euAkEEqvRNEnAVFeqoU4YKR4QV8XWjO/oP00n/MDGjxCX
X-Gm-Gg: AY/fxX5usCtWzDvDnGiSYnUNH9G9/18R83ga+fCyzY9n5anfIzq1S87EiB8TOv4ahX5
 MEcbugjF10boYuyHLM6ZAoIoTM1mS7TTxNAWaTjWvLoOB+2Jd3zG8wkqJHSB3aKT6lOyh2TjxEE
 pkI075UsIQznQVjIz83A3hHTUczb952aswrBj/p1KySsQHX0RSFoCuPx8go9feYSaS2jG3mmGBa
 ecetJEsSVg9OQJr6gC8+57p/+5Nd5aMy/nN5cO7TD61WmG9hjipLrDPVaTznM5np5Nz1eW66l3j
 K2kFpiMRlKyulxZTmQ1ZGNyJBxMAE75kTq87Q67aHgOXqtpDqFCgUDDhzXfuvbKZIwkn/YlOkL4
 =
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d1958a755mr656043745e9.21.1767602408353; 
 Mon, 05 Jan 2026 00:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH95a52nPfqxCMH/IFUE4jS5rV/1ExZzhK0HtVLMD5w4RhlZAsgNa8sdh4ikhaQJFKQ59rXlA==
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d1958a755mr656043395e9.21.1767602407976; 
 Mon, 05 Jan 2026 00:40:07 -0800 (PST)
Received: from [10.43.3.236] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm100412053f8f.20.2026.01.05.00.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 00:40:07 -0800 (PST)
Message-ID: <0bf79738-4197-4746-a5fc-3c06722e0937@redhat.com>
Date: Mon, 5 Jan 2026 09:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/interop/firmware: Rename FirmwareFormat to
 FirmwareFlashFormat
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
 <20251228232649.1708400-2-abologna@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <20251228232649.1708400-2-abologna@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/29/25 00:26, Andrea Bolognani wrote:
> We are about to introduce a new set of enums that will be used
> by FirmwareMappingMemory and that don't overlap with the formats
> that are supported for FirmwareMappingFlash, so we need to
> disambiguate things.
> 
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>  docs/interop/firmware.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index da0362a2c0..ef9b976a34 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -233,7 +233,7 @@
>               'verbose-dynamic', 'verbose-static' ] }
>  
>  ##
> -# @FirmwareFormat:
> +# @FirmwareFlashFormat:
>  #
>  # Formats that are supported for firmware images.

Nitpick, ... "supported for flash firmware images" perhaps? Because
after this, the enum is specific to FirmwareFlashFile.

>  #
> @@ -243,7 +243,7 @@
>  #
>  # Since: 3.0
>  ##
> -{ 'enum': 'FirmwareFormat',
> +{ 'enum': 'FirmwareFlashFormat',
>    'data': [ 'raw', 'qcow2' ] }
>  
>  ##
> @@ -265,7 +265,7 @@
>  ##
>  { 'struct' : 'FirmwareFlashFile',
>    'data'   : { 'filename' : 'str',
> -               'format'   : 'FirmwareFormat' } }
> +               'format'   : 'FirmwareFlashFormat' } }
>  
>  
>  ##

Michal


