Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A0C3ABDD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 15:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGJ27-00043J-G1; Sat, 17 May 2025 11:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGJ25-0003zF-D0
 for qemu-devel@nongnu.org; Sat, 17 May 2025 11:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGJ23-0006ly-DV
 for qemu-devel@nongnu.org; Sat, 17 May 2025 11:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747494057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tm5nsCTM2jJiJ1JGx9u4hbTLwXVL01423eHn39jChVc=;
 b=cNk5Zh4raKORxrQimyzQaKtM4tiwm9j/eMKtpcjs2SOybk7QX3s/V248Y36fIYsfkObEhp
 CxX2bDqAl0kdCyW208db8IBMUgib0eSGFcz+z8/9HycJQCnKbS7UCaUhGMEpoIJUz8S297
 fj1w0O3Uegirds1ja9Q3EL32TDtV0Dw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-KlIPHfwsMOmU4aU7I0wSzw-1; Sat, 17 May 2025 11:00:55 -0400
X-MC-Unique: KlIPHfwsMOmU4aU7I0wSzw-1
X-Mimecast-MFC-AGG-ID: KlIPHfwsMOmU4aU7I0wSzw_1747494055
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f8ae3c3d80so46714306d6.2
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 08:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747494055; x=1748098855;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tm5nsCTM2jJiJ1JGx9u4hbTLwXVL01423eHn39jChVc=;
 b=nA7rP4dJrdjFnXzyTD6cFgLCZmwXE+BWg9U9skLPNnfd0XPLZ/o6r5iyvxyYnD5QEO
 GBYvX2bp6mddBgUC2tND8vgZNqZeMmXmAgEN962cHYyGZPYn0NZfCSKqQvI0K07cP+m+
 w6cL+xlnMXGwgdODZVJlVtQJW6ZIf5dGhjpkjdyTLRJhoh9eYukyti0EJl0X4hSkCnjU
 7kRIznyRwnXoLy/NVqK+xdlVfC+f+xZ9ZTU5F6q49G5dfyZruOP48J5sC4dYVqJnkvJ6
 ttlxAzXHOaMKgv/+PE5bHtBDDy0Y5BzG90gwEnRcOE7jAJ+5TkerRBg/DtAGtoh6g3he
 Hhyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHavHRLOeqqAHJjDZ0UXK9pb01lOtiLbX/L7Z6mOtaD+SNTfEDs5SuE1QLhLU3ZHg7YNIUCjVSRFKT@nongnu.org
X-Gm-Message-State: AOJu0YzdDOHmE4D2qXSNjxqqi4ADdYzgAzWNXJaP/8D9oYCx08Hx9aVJ
 Q7kcJKOQ3ypI9XJ6hXkvYHhHTKh6EQPrX1or7UxN1d2yds53mOqZIB3O+jpg+I3VfLP7JHHDyrg
 YULQJqFHkyuaIeqCTJAWZ6LfacpfGovv0liIGjCvXThu9Q095ZpbcSEaw
X-Gm-Gg: ASbGnctp4zSEFkXahjpa1Au61cr8G32AIJhoNt+qN/VwoD0UkSMSeg0e9tNKfc+oa+i
 tOORbXtN3eEwa7CQ2NNrnl1q02I0NvgVMptpeSc1QM5/QqdN9JnMrrYrnJ4d+flOW3oSm23q5FL
 +6SUG6TCuegst0iFTh02jpoySK7/0z4bhvxvhv+VJD7OR8LOC+xPA357Gtm0pySgI+wqHOZYM7P
 eYp6Pv470fXwCUoNb6NcJPZt7jMelbWVioSsvBkmNMZ8XGYjuWDkFeqavkCYAvD0/gueP08iVrF
 eLMfifb9eibwf/HDbA==
X-Received: by 2002:a05:6214:1c09:b0:6f8:a978:d46 with SMTP id
 6a1803df08f44-6f8b080b5c3mr135796596d6.19.1747494052706; 
 Sat, 17 May 2025 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELL2x2MohrysJi9zkGeIvVs/UBz96mYZgNWnuDvg6JvppRGks4tjfqwYFpasjHedMceJJHPg==
X-Received: by 2002:a05:6214:1c09:b0:6f8:a978:d46 with SMTP id
 6a1803df08f44-6f8b080b5c3mr135794046d6.19.1747494049558; 
 Sat, 17 May 2025 08:00:49 -0700 (PDT)
Received: from [192.168.21.214] ([69.164.134.123])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f8b0898f66sm26610826d6.27.2025.05.17.08.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 08:00:48 -0700 (PDT)
Message-ID: <e270f781-b328-4aba-bfe6-b61516f7b286@redhat.com>
Date: Sat, 17 May 2025 17:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: build target libraries with common dependencies
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-2-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250516052708.930928-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/16/25 07:27, Pierrick Bouvier wrote:
> @@ -4131,12 +4137,17 @@ common_all = static_library('common',
>   hw_common_arch_libs = {}
>   target_common_arch_libs = {}
>   target_common_system_arch_libs = {}
> -foreach target : target_dirs
> +foreach target_base_arch, config_base_arch : config_base_arch_mak
>     config_target = config_target_mak[target]
> -  target_base_arch = config_target['TARGET_BASE_ARCH']

Each target_base_arch is now processed only once.  Therefore, all the 
"if target_base_arch not in ..." tests can be removed.

>     target_inc = [include_directories('target' / target_base_arch)]
>     inc = [common_user_inc + target_inc]

>           sources: src.all_sources() + genh,
>           include_directories: inc,
>           c_args: target_system_c_args,
> -        dependencies: src.all_dependencies())
> +        dependencies: src.all_dependencies() + common_deps)
>         hw_common_arch_libs += {target_base_arch: lib}
>       endif
>     endif

...

> @@ -4179,7 +4190,7 @@ foreach target : target_dirs
>           sources: src.all_sources() + genh,
>           include_directories: inc,
>           c_args: target_system_c_args,
> -        dependencies: src.all_dependencies())
> +        dependencies: src.all_dependencies() + common_deps)
>         target_common_system_arch_libs += {target_base_arch: lib}
>       endif
>     endif

There is no need for two separate libraries, since hw_* and 
target_system_* use the same flags.  You can do something like

   system_src = []
   if target_base_arch in hw_common_arch
     system_src += hw_common_arch[target_base_arch].all_sources()
     system_deps += hw_common_arch[target_base_arch].all_dependencies()
   endif
   if target_base_arch in target_common_system_arch
     system_src += target_common_system_arch[target_base_arch].all_sources()
     system_deps += 
target_common_system_arch[target_base_arch].all_dependencies()
   endif
   if system_src.length() > 0
     ...
   endif

to build the two arrays of sources and dependencies.

If you reduce the libraries from 3 to 2, you could call them 'common_' + 
target_base_arch and 'system_' + target_base_arch.  That's more similar 
to the existing libcommon and libsystem.

Paolo


