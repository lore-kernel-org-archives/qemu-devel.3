Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36921C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmW9Y-0001lS-O9; Mon, 24 Feb 2025 05:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmW9W-0001lG-Up
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmW9U-0005Vy-MG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740394650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yt0rAU+VRxsfGDQpK3/ewN3EZgFtWLbvooT8/UPYhRQ=;
 b=gsdHYOEGlBeIP5/udDqkS2gn3SWJndo/lvlwmeXQA7WbWw2B8tEGMXS1tFDjzxZN+Qg/bd
 3KwXy4RMgJLv6x7NCbQ5X9LbeBKr5xkNk7Cn80SJZaO2UfLUN4QL9nL9py4GxVnPj1BrQq
 iY3XQuD6DRVHhqwHyzxuwz+DWRX4PO0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-zuAUPKvCObGYxwJ5BBgvKw-1; Mon, 24 Feb 2025 05:57:28 -0500
X-MC-Unique: zuAUPKvCObGYxwJ5BBgvKw-1
X-Mimecast-MFC-AGG-ID: zuAUPKvCObGYxwJ5BBgvKw_1740394648
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb9b2831b7so497201566b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 02:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740394648; x=1740999448;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yt0rAU+VRxsfGDQpK3/ewN3EZgFtWLbvooT8/UPYhRQ=;
 b=Ezp2i8Pqljh+NppG7ePGSb+QGVulonzbX7nbqieGFFWE6UpcdWpKkvHU8zEaPRZMpI
 7lHMLIhWECRKtNL1n3aebp+LlyRFUYbqRcX/GR/JMUfj/SyJSj/kSfcq+kKVC9ADNqOs
 2dwIjit+bJTRH4KkC946rsJtR77fX1x1LrEzV/68MGon8poH+0Tcp5yYyIGy81Th9Vjq
 WqwVd4mMeOmxGapkNqqo3uukVTZCwqiPcZq23NOtijV6Sm7lelDo+PvGK3KYAZ9cl/CV
 Z+uLtDXG93VUGbBbBLrHCiCgHjEUFEkvoO4wWNF5k/5JYsFSeaRKNEgvxsrbHE2EuBqW
 wlFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/P+MbigO8dY33DbjztY7agl0nF91QfZscQcqaw25vjDH+MtaCDgVVm1Y9pUYWzjXJXe3QpsopQEfa@nongnu.org
X-Gm-Message-State: AOJu0Yy00OeayF1Dp6PloX9ZbAZgztKkwIUdHyw2ZFyZNkDRdIugHUZU
 h3iZUZYqZVgaxbvRB+taeJj4sw6U5OBBKk1UMpGVNjBJ88mcHM3/QyabW5luAb/fCcij5eDF/qL
 8JkxKntECueaTfTyNui+AHDak6voOf+0XanGwisP9IBROvCqleue6
X-Gm-Gg: ASbGnctwBQFu7+DWJGZTjuDWHLyOkzhZWlvYWu5NzXRTQBIqC/84N+ZKpUwJBB1qeD6
 KN0FGvP1pI0fnA1ys8rs6d4IPC6ttuc1PuFcjclz0XGb9/DMiJgX/QUh5aXHasKgIcV/aJP1LQZ
 a9QJKTOdAQduyjjOkfoif94kkuCVi7hF4RcCnYIpCE839GwDYeuTJxAPHRTaf25V65hBuCK2X9G
 sdN9i92tBTgNc0MHmhgM4VkJGBMQ7Jy1MrMi4ukuh1ItsPFvpiL3hcL32FF0KcRiKRPdlHQXIYd
 ypdTPVzrvs5cNol6fY+c
X-Received: by 2002:a05:6402:2683:b0:5d9:a5b:d84c with SMTP id
 4fb4d7f45d1cf-5e0b62df50dmr13018471a12.3.1740394647511; 
 Mon, 24 Feb 2025 02:57:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/TBcZGLt76QwOKNoea3D4Hl/MM8AFnIJS236Dbl5cTtsrQAbtjSIcsQ0JQDHORP4TgbPewQ==
X-Received: by 2002:a05:6402:2683:b0:5d9:a5b:d84c with SMTP id
 4fb4d7f45d1cf-5e0b62df50dmr13018446a12.3.1740394647086; 
 Mon, 24 Feb 2025 02:57:27 -0800 (PST)
Received: from [192.168.10.48] ([151.62.111.182])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5ded69e7c33sm17230937a12.61.2025.02.24.02.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 02:57:26 -0800 (PST)
Message-ID: <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
Date: Mon, 24 Feb 2025 11:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Replace meson introspection argument with a
 builddir
To: Joel Granados <joel.granados@kernel.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 2/4/25 21:10, Joel Granados wrote:
> Replace the meson introspect argument with the build directory instead
> of the meson.build file. The introspect command accepts an optional
> build directory not a file.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> For some reason this causes an error when I "remote" compile qemu.
> In any case, the introspect only accepts directories, so having it point
> the to the meson.build file is a mistake.

Unfortunately, the help for "meson introspect" doesn't tell the whole 
story...  Instead, https://mesonbuild.com/IDE-integration.html under 
"Build options" says:

    Since Meson 0.50.0 it is also possible to get the default
    buildoptions without a build directory by providing the root
    meson.build instead of a build directory to meson introspect
    --buildoptions.

    Running --buildoptions without a build directory produces the same
    output as running it with a freshly configured build directory.

The idea here is to make it possible to update the meson-buildoptions.sh 
script even in case the build directory if somehow hosed.  So I'd rather 
avoid this patch if possible.

What's the error that you have and do you have a reproducer?

Paolo

> Comments are greatly appreciated
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index b65b0bd41a..da88d9bb31 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -129,7 +129,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
>   .PHONY: update-buildoptions
>   all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
>   $(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
> -	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
> +	$(MESON) introspect --buildoptions $(BUILD_DIR) | $(PYTHON) \
>   	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
>   endif
>   
> 
> ---
> base-commit: d922088eb4ba6bc31a99f17b32cf75e59dd306cd
> change-id: 20250204-jag-fix_meson-43db4d290315
> 
> Best regards,


