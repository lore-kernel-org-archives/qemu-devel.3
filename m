Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD40E68156
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHdh-0000Jy-5O; Tue, 17 Feb 2026 04:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHde-0000Jh-Ci
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHdb-0004C0-Lg
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771321498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+7cLgaujvPiDo8FIHcbcwRhuEkpntBOlQ2lysI1gO0=;
 b=KOe8k2KAMV2iXvC9TMkFwPz50k1kowgxhJoVd3MvnyuTG/DoN4xUOVBiohVJzEQryUEbyO
 Avm9jHMSJvTlUgR6H83OqB0JCYYLuLbaJENKq0QC6ERHyDGIqt2y3xWDHLPAguR9XI0XKT
 tHZl6bFtdO4D/jyNX5nY7elmU0AIdAg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-RbEbq79IO36CB7-uJlatTQ-1; Tue, 17 Feb 2026 04:44:57 -0500
X-MC-Unique: RbEbq79IO36CB7-uJlatTQ-1
X-Mimecast-MFC-AGG-ID: RbEbq79IO36CB7-uJlatTQ_1771321496
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48378df3469so25098035e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771321493; x=1771926293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+7cLgaujvPiDo8FIHcbcwRhuEkpntBOlQ2lysI1gO0=;
 b=d3o02IUdmU0W344nLPs04fhGMQeYeGO6fJpPWzA949HJD88ntfTgk+gAJuEr+yzpAl
 uioMD6WAmaGHjqszuUcCXrAWxxxhqPyILgi9OQ5svzVEwu5tMbkCW2sZ0Ww/B6HLC6Lc
 9gfrGgA1u26DWKel6APMyKjwIkuslC5fQkowvXQqpCbxQ1ZC3xsY3jfhEd5oXEE9x+5Y
 Cxw3dG4Bubst1aGZQ9zvHkE4zVApaHbB/d6BFsekyRdaDrd1oMecGAKJuf/8MJjPntxq
 ROg7Qfo75w0/mEhVUb9vV5aamcjEJoylx30FGpVUVkwfCSx2d+9m95ylsxkAVX1R3JYs
 7Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321493; x=1771926293;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+7cLgaujvPiDo8FIHcbcwRhuEkpntBOlQ2lysI1gO0=;
 b=KevAaRhiqEln1e/Iif2ySyntNk9Er43JrOW4wkEZqh56Z3IitdYJjf9HpixF+XLG1C
 jWUeThMYD1DDDBMwwT3G83kak5tSbR3eeWulipNFgfsz2Va06Raj4/aZu/NjUy1aftqm
 pwCnmoJ30c1ntCJBwAnx2ScAsKXugZ7FqkcjzoN+H+NZySgZIuXl11KkShmgzEuBn5e/
 vGgjGc0jcjRaoDqBUFiLvMd/Pgsrx3hS1cN+j0VHEvF13YK2XF3pLXBsX8JZADsp9OHA
 BW7FZD/JzFj/QEm06+0dJzRCzTy7D8Zzk3FW6uF88Pue6kIkFsRWYXooYcp7fgxLgRq+
 ShgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELO5xTdyzjF+Z9q1Yv298CBN9aXLRVYd7173Ac63h5J/Vq5hekro//+TZHFr5lJHNlF9zO96UU1Kb@nongnu.org
X-Gm-Message-State: AOJu0Yz0dbSVAgZiomYZTRBzEDJCX5/PNu+7Aupv/i/62X7IlzVl01YV
 5UhqOWmzgOXUPmGa5GuVy43+xOoaeUkjzJf3mW7EvVPoZBnc79IZU2JJjWGJ5MAH7vEl2HPBJFv
 /ttez/Zo6nhM+rPmyfN9wG6duOdeAqatQigfnhPZDOjdH9OhD7Q4ubtYfL0OSwQ2y
X-Gm-Gg: AZuq6aIxWjbTSOVI2Ynq8ZIHC7n9EIxuB+/k/44ApuYqmfG7DUitx0z9HhpdFA30K8b
 W8a4fU43xZYELXUvtx3HbeDmK1ag8XW/lwrZuVcfSQvxboQv2K8n/+2l67IwJHX8jFtWY+O4LA9
 NdF+aWXFw/fr3flTWoZFXA5X7oykHa715n0xnkG+vnnFTFcs8FMDkT2UlLUvm9M9+8zwQObA9L4
 fWuBzMX8GWup7sp2+zDRpHv7t26dl7JxHKGa9zrS2AsSPw/JIQiXK9odM0qHy3xXqdjnBugdgQq
 jME/zQHwVr54jlqmSn4MCewsvJ0Q2ocWAskd7Id8vQaLwtr/TSEe+n2CC0kw2YGMZ1/KAhOr2Or
 GanSFXKOulFaIIzmR0XcslUkzUgi38xrMWSn7jzUUr/MGDCWFhiFULT7/1ux5RmtxXnQLWPRZ26
 x5WCundhLpuhsbq7H77QQIJZrMLyI=
X-Received: by 2002:a05:600c:4446:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48378d58817mr181921605e9.3.1771321493170; 
 Tue, 17 Feb 2026 01:44:53 -0800 (PST)
X-Received: by 2002:a05:600c:4446:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48378d58817mr181921315e9.3.1771321492708; 
 Tue, 17 Feb 2026 01:44:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48370a41be2sm174929015e9.1.2026.02.17.01.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 01:44:52 -0800 (PST)
Message-ID: <96e57723-25e7-43ae-873d-b081e03ef72a@redhat.com>
Date: Tue, 17 Feb 2026 10:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260217052740.114117-2-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 2/17/26 06:27, Sergei Heifetz wrote:
> This patch adds the `audio` option to meson_options.txt. It is
> propagated into Kconfig as AUDIO. It is enabled by default.
> The corresponding `--disable-audio` and `--enable-audio` options
> for `configure` are also added.
> 
> For now, this option does nothing. In subsequent patches, it will
> gradually disable audio in different places. The final goal is to stop
> building sources from `audio/` and `hw/audio/` and other audio-related
> files (except for some stubs). Note that this intent is different from
> `-audio none`, which mutes audio but still compiles the audio subsystem.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   Kconfig.host      | 3 +++
>   configure         | 4 ++++
>   meson.build       | 3 +++
>   meson_options.txt | 3 +++
>   4 files changed, 13 insertions(+)
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index 933425c74b..ec129aa4fc 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -29,6 +29,9 @@ config IVSHMEM
>   config TPM
>       bool
>   
> +config AUDIO
> +    bool
> +
>   config FDT
>       bool
>   
> diff --git a/configure b/configure
> index 4b61fd3bbf..ff391c79a1 100755
> --- a/configure
> +++ b/configure
> @@ -762,6 +762,10 @@ for opt do
>     ;;
>     --wasm64-32bit-address-limit)
>     ;;
> +  --enable-audio) meson_option_add -Daudio=true
> +  ;;
> +  --disable-audio) meson_option_add -Daudio=false
> +  ;;
>     # everything else has the same name in configure and meson
>     --*) meson_option_parse "$opt" "$optarg"
>     ;;
> diff --git a/meson.build b/meson.build
> index 8c6c0a9a32..69aa7cd189 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -68,6 +68,8 @@ foreach target : target_dirs
>   endforeach
>   have_user = have_linux_user or have_bsd_user
>   
> +audio_enabled = get_option('audio')

You can use

audio_enabled = get_option('audio').disable_auto_if(not have_system)

and then replace all the "if have_system and audio_enabled" with just 
"if audio_enabled".

That said, I'd rename the variable to "have_audio" for consistency with 
other names in meson.build.

Paolo

> +
>   ############
>   # Programs #
>   ############
> @@ -3244,6 +3246,7 @@ disassemblers = {
>   have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
>   host_kconfig = \
>     (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
> +  (audio_enabled ? ['CONFIG_AUDIO=y'] : []) + \
>     (have_tpm ? ['CONFIG_TPM=y'] : []) + \
>     (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
>     (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
> diff --git a/meson_options.txt b/meson_options.txt
> index 2836156257..172ed10ead 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value : 'auto',
>   option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
>          value: 'system', description: 'choose memory allocator to use')
>   
> +option('audio', type: 'boolean', value: true,
> +       description: 'Audio support')
> +
>   option('kvm', type: 'feature', value: 'auto',
>          description: 'KVM acceleration support')
>   option('mshv', type: 'feature', value: 'auto',


