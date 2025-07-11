Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66200C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAy1-0004mq-5W; Fri, 11 Jul 2025 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAxx-0004cL-0x
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:26:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAxn-0004G6-BZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:26:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4530921461aso12665715e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229601; x=1752834401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VvlFFIb/42Wv1yNH47hQVpyhSpu6gSzvkgBb639YkLk=;
 b=jGz/L1cBLP8qgQzisMy+VHjZGsTSMfdoQcp9UdFUXKBnbhPcy2I334ZiDT//vfKNAV
 mZN+WlwRPBm1AcUyi730AJU1NpB0AeXDITjdxARArc35YDqStU3CRAgndJpNzfFGr6Fg
 r29UD/R3mBIaqQdMgJqQuXgUnpRtEBoTv418RaRibzP8QDQWAW5cdIz70PqpuG0wvYPA
 TGA1ZxbxCgsKhVSYbvHUR2QnP4aYiqYRF2OsbwRctDUojvkGJQ5+KlNccfwzAhsUbiCa
 vDfCxlFIgoaPGnbvrv5xhZR6X4LSI6sywh4CsmzkT2hwxIewPjTwh7PjYPr0Wc3z1m8I
 96Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229601; x=1752834401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VvlFFIb/42Wv1yNH47hQVpyhSpu6gSzvkgBb639YkLk=;
 b=EX3mnxdk+GiazJlAO4ytBiOLmr6SV9zy9xOiPMtffTIeZcImEUnWP1PMYWa+y+Nijr
 g6J0pmDRv2Lg6poq+wEQ39JdFPVmpZw3GDBU0X4wH42ll3hUXzDtA8XWuxmIuzLdmClA
 TFCIh+uTUsUzr2tp0FQM7r2hoDzCnVQWTQeF5UwzI1363VKD2S221nQKkh8Nl2h2iVd0
 s63NjqvDltAYN2NWkCIHpidi2OvkcaycNbHMrROU+hFGa7+P+qbzxa3vnDU4p0t7+Sg6
 Mj3uyrGnpcG7xUrAM5dooLklMBg+dtbE4A2ozT8D4VRlEjyCEM1khW8D4kraTzGgP/Rn
 bRcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrKhJdtVu2QlEzfka2oYo8nZz+TG+yPZl1k6lgMqjDGvAQG1PBh0ChBveGAbrzPIqJrp0f8tJdCDOQ@nongnu.org
X-Gm-Message-State: AOJu0YzKrO8gKpY9z7O63PijCZPQpRe5KaIvLzgox+CdH4MtGZgTrbjh
 V8dup6E/iC5B43YivTfxPiiAfmeq2k96kJW8gI+g2VE/izjzIlOdBGbYge9YTKjJUZtW3GakxpT
 Sp5RZgcc=
X-Gm-Gg: ASbGncvQlevdQqK9GpByWSLqyXefX2TfNL1yjc98WiR/8rujTWmQn6V+g5BbdXwThpy
 2kOQT6T1jDa5/QaBh2QnDtDG6CiuJ8kuhNxnsNmqp2K+0cV2h9SOqh16cnRbSE7uXB5iAiQs6nP
 tO8SSC+DQ2drpJq1k8wFnLBtCPzlOO7tzAeQPSw9HLOW4AhcgcpmZzNnMIOniOlqU6sgcJYLrH1
 7/L11f1vAfz9UoUTciEcZCLE8zdM9N2bRa7rdAuexyQiJrZoQevNQceFdWpV4P8cXFKOBbEi8eN
 gABWrsrJ1Ts5c5lcDDNk+AGoX4wZVH8vLTUpoQQmdv4MjMHs6dmKplAWIBHM9/CTeML/BX3TmZI
 Kf4Kk8ChYYNg8FgaoSnTUEjlLdZHwWhZBNQKy0gqyM54+xDDQFyzVMOrLhy3aQVs0ZATbyw==
X-Google-Smtp-Source: AGHT+IGwzm0htWK00WVShAuVypzfmE7NLITkWyWxO+GO1+aRQN8rRc5tIzfMotYgtH1Te5QvlR/CAw==
X-Received: by 2002:a05:600c:8b10:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-45565eaffabmr20194285e9.12.1752229601151; 
 Fri, 11 Jul 2025 03:26:41 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5062119sm84459825e9.18.2025.07.11.03.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:26:40 -0700 (PDT)
Message-ID: <0434d08c-b3c6-488f-8ceb-3c36e23770c1@linaro.org>
Date: Fri, 11 Jul 2025 12:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20250617203435.41490-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250617203435.41490-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/6/25 22:34, Bernhard Beschow wrote:
> When compiling QEMU against fuse3-3.17.1 with --enable-werror the build fails
> with:
> 
>    In file included from ../src/block/export/fuse.c:33:
>    /usr/include/fuse3/fuse.h:959:5: error: redundant redeclaration of ‘fuse_main_real_versioned’ [-Werror=redundant-decls]
>      959 | int fuse_main_real_versioned(int argc, char *argv[],
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>    /usr/include/fuse3/fuse.h:885:5: note: previous declaration of ‘fuse_main_real_versioned’ with type ‘int(int,  char **, const struct fuse_operations *, size_t,  struct libfuse_version *, void *)’ {aka ‘int(int,  char **, const struct fuse_operations *, long unsigned int,  struct libfuse_version *, void *)’}
>      885 | int fuse_main_real_versioned(int argc, char *argv[],
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> That is, a fuse header triggers a warning within itself. Since QEMU adds the
> fuse3 include path via `-I`, the compiler thinks that the header is part of the
> QEMU project, and thus raises a warning. The compiler can be told to ignore
> warnings within 3rd party headers by adding these paths via `-isystem`. Fix the
> above build failure by marking fuse as system dependency. While at it mark
> every 3rd-party dependency as system dependency to prevent similar issues in the
> future but skip glib since that results in glib include paths to be omitted from
> bindgen in case of a Rust build.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   meson.build | 160 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 34729c2a3d..694cf95f6f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -826,7 +826,7 @@ endif
>   #####################################
>   
>   libm = cc.find_library('m', required: false)
> -threads = dependency('threads')
> +threads = dependency('threads', include_type: 'system')
>   util = cc.find_library('util', required: false)
>   winmm = []
>   socket = []
> @@ -859,11 +859,11 @@ if host_os == 'windows'
>                                         include_directories: include_directories('.'))
>     host_dsosuf = '.dll'
>   elif host_os == 'darwin'
> -  coref = dependency('appleframeworks', modules: 'CoreFoundation')
> -  iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
> +  coref = dependency('appleframeworks', modules: 'CoreFoundation', include_type: 'system')
> +  iokit = dependency('appleframeworks', modules: 'IOKit', required: false, include_type: 'system')
>     host_dsosuf = '.dylib'
>     pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
> -                   required: get_option('pvg'))
> +                   required: get_option('pvg'), include_type: 'system')
>   elif host_os == 'sunos'
>     socket = [cc.find_library('socket'),
>               cc.find_library('nsl'),
> @@ -899,7 +899,7 @@ endif
>   hvf = not_found
>   if get_option('hvf').allowed()
>     hvf = dependency('appleframeworks', modules: 'Hypervisor',
> -                   required: get_option('hvf'))
> +                   required: get_option('hvf'), include_type: 'system')
>     if hvf.found()
>       accelerators += 'CONFIG_HVF'
>     endif

To the best of my meson knowledge:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


