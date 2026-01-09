Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009AD16816
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAqg-0003Lk-1S; Fri, 09 Jan 2026 06:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veAqe-0003IL-2h
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veAqc-00044O-EQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QdtT3iLWCNiZEL+sr7lr9EuyG+96Mm3NSFljLQbYzgg=;
 b=Q88RdGEh1aVr0OMQPn2m8Jbxbteol0CQWUEaAMhJlM4C3KduMZ83ZXJQl6LA/8oHKbyyjv
 h+4j+wUl/w9YvJx+vNBjguFajEDq9kRxwrIU6RcCC0VRLk5X+3rY1WZmDawfmON80Jk/91
 JaRV8BvnIFj9OTfDKTJeeA/U0FYEM5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-POgF-c6xNeOTBdxwFMvvtA-1; Fri, 09 Jan 2026 06:40:03 -0500
X-MC-Unique: POgF-c6xNeOTBdxwFMvvtA-1
X-Mimecast-MFC-AGG-ID: POgF-c6xNeOTBdxwFMvvtA_1767958803
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5c7a2f54so21191935e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767958803; x=1768563603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QdtT3iLWCNiZEL+sr7lr9EuyG+96Mm3NSFljLQbYzgg=;
 b=i8AlI5+7L5uDpF5w9w7WtQoHK9MqsYPbiCbQxksbSTKhWjYUbEeMyw6o4gTxPSlQNR
 s4+MZEttWqIa8B85AzwlL+Gb2CAxgKLNDVxTRaBhBuOgQEZ3b1Iu/6BtuygAJD60bPA+
 h7AEOERnuADTvA4NL9tahM7vEyiqs6ur/2zKjRXnqv41SHwju9fzLwjQNComKb44clfy
 zDlMd/DUQ2K7F0THiIfsWpemBP8vNBuTD+DjLPt3ChWIa5qPo6KLliMOkkL/MFVOrHuz
 K0N+HTPkwpj4pPzvVLOF/sJPWWOJarZkIQWSPU2fso+WsFfjCBK/SsYoL0l71zDezIhh
 7I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958803; x=1768563603;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdtT3iLWCNiZEL+sr7lr9EuyG+96Mm3NSFljLQbYzgg=;
 b=YGXpZc3Yqixp6/1c2dhvauFEnX2SxWn2d0rylcW8bM7q4BRinC+u66nRGGs+e1zo1V
 7YO/h7L53zgT4pjsZjp7+baKzjPu0ztgOjH8EDvq4RoshqEMYYarKI0NoV3gXo+8ZzMH
 MbIYjb4K7yeCsPDOSkaE2E1MUYv55pXNeilIGL7rlOt/Eqe4pzDSzlh2rp/Kk2CNy0bE
 XmCsOK6LC/+QXpN4cU5OnI6SYJkzJo5ho56rDIajy2yZDfd/uGMF1umOQjt4RGIqapO8
 8CqPoJ8vi4ucjzFknaHYXhOA3DZwk2MC1AoJs8g2xLAKRRPU2oyUBh1+YAdSiOFnlZT7
 u3sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUtvh3UAMIoBJM2YP/sXlpIgsMCEaiib7ThAex4bs5abx9PugxxwJY6spFOoS6bKXrMbkt5USqKmYP@nongnu.org
X-Gm-Message-State: AOJu0Yy7mzng2FuufN0Ewspqeay4p82kxMTns5BqPFh+PKBfZs9ufWqo
 CwterM0sMFOEtjw8dSdICYwRfuTZu6uTLGSKUCVDAltvSpUEFAnY1OwTvzFkvFx8Ruemy5nPWl1
 YmHtB5ZOQwpWR9933/dVrbviUzlhzqW3mdABdsdbWiBZSl4TG1Ll9eqZp
X-Gm-Gg: AY/fxX42FsXVy/H4EBzUH4cuW5ik9QkXDBQku3LLCQmRtecGi2DZ/O1DNN3NJe1Jxuu
 AodaNzHVQ2bAZnW+ksuvTHtGyfGi0aJ/HY9iOtGHEGpa3rjQ8KD1kJm8MV5yvXB6KjTM4iqseUC
 gOgZSOdS57POUYfdk503VV3cJNggHVzlsbPfTAk+v5QKbZCUYVNhDuv9Xqexurcz93LMkWA6kvs
 WYD1ARuWZ7HdxNI6PbRKOhK35dS0LAgYVYo8gYwe3Vy2vzmiAtgH8KWIEMcNJ59rXV4uzxwkygr
 wceWeg3UkIZe1XGH3OHZw7IrZc6HQAuDlEbeVUcaaMc9D8KGjSQ4H+zXUMezAdRvGlD47EUX1EE
 6S+R5aQ359SfEWZyC/akuy/FiWJ8+yQr3BeTuZYtJsn9xfBYNAAMVh76Jsxi+cMg4JlD6gXmFcD
 EZLO8XxaQ3V2Ke0Q==
X-Received: by 2002:a05:600c:4f54:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d8483cc51mr98956455e9.1.1767958802554; 
 Fri, 09 Jan 2026 03:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHH+2yW5f3T/7EapiKt5UV7eZjV9H0zPiB8mevhX/d0SMGre9ZDMkbeQKQoXKHQhyqODffvg==
X-Received: by 2002:a05:600c:4f54:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d8483cc51mr98956265e9.1.1767958802114; 
 Fri, 09 Jan 2026 03:40:02 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm22635380f8f.17.2026.01.09.03.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:40:01 -0800 (PST)
Message-ID: <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
Date: Fri, 9 Jan 2026 12:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260108170338.2693853-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 1/8/26 18:03, Daniel P. Berrangé wrote:
> Functions marked with __attribute__((__constructor__)) will be
> invoked in linker order. In theory this is well defined, but
> in practice, it is hard to determine what this order will be
> with the layers of indirection through meson, ninja and the
> static libraries QEMU builds.
> 
> Notably, the order currently appears different between Linux
> and Windows (as tested with Wine on Linux). This can cause
> problems when certain QEMU constructors have a dependancy on
> other QEMU constructors.

What dependency are you seeing, or introducing?

In theory QEMU constructors should not have any dependency, as we only 
use them to initialize static data structures (such as the various 
*_init macros).

Not an objection, but I'd like to understand this better.

Paolo

> To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> provides a priority value that will run before other default
> constructors. This is to be used for QEMU constructors that
> are themselves self-contained, but may be relied upon by other
> constructors.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/compiler.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1c2b673c05..4c49f52eb0 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -194,6 +194,14 @@
>   # define QEMU_USED
>   #endif
>   
> +/*
> + * A priority for __attribute__((constructor(...))) that
> + * will run earlier than the default constructors. Must
> + * only be used for functions that have no dependency
> + * on global initialization of other QEMU subsystems.
> + */
> +#define QEMU_CONSTRUCTOR_EARLY 101
> +
>   /*
>    * Disable -ftrivial-auto-var-init on a local variable.
>    *


