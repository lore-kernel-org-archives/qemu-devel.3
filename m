Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46722CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9I-0003u6-3O; Wed, 08 Oct 2025 17:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6c9G-0003tE-HL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6c90-0006cz-9G
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-267f0fe72a1so2081665ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960577; x=1760565377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVxOCYBSERnvDNnscForixI/p5oI5Usra4lNAQl+xMs=;
 b=k7kiDlkOC+mWtkMjeUP3bD/qnrEBXFgMUhgDrklGuoyeIHeqwizkwvqVGMM1hIdV21
 LRs5l8MxEMVAmAVOq/RlS9CrWUBrBaRSrkdWGr0INLcmboymbJyBFWcYi8TnlaG3gTGz
 WmtJyZ21LkEp+OHfoG0KB16qxy30mSX4mf9Egl+2XwCJYBqoeCVVIp7vjNGLDJOc6jzr
 0rw+OzUphKAKBXynECYa+jUEH8RcNbq0hEia94622E+Xt37YleAsJBBGGoY4voYtn2em
 dU/r4hMGbiGr8UAFxOljPSzMVcygs2KL6B1Ff8qaVPEAUZR5IHUn05UpzVlrICVqbxO4
 L71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960577; x=1760565377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KVxOCYBSERnvDNnscForixI/p5oI5Usra4lNAQl+xMs=;
 b=gJo3VDPp2RP8luhEddRa5RGLTt8y1eVwwBrlb/krlW/0J/+w3Ju0FHUPjhH95yIWml
 63uS0iVWAuye+LG6Az53Pl9pbNeXi/fSKWLcPVJjk2OjZ9IevNIsEMj9wrc4Vxf7NKr3
 2yrkhxL+cHXjDZMGJzwQU61+lX7ddOEN5pJA3cSn/WQMoAGtbfTPZKrIs9MnmahjVXeI
 XveeeyYrOObdYRgIVpY6uvbrMensn3YuQ2ZXp3Qdoqam/ZabazSfszFN9t2voUnIBZlP
 JKFiX1olMr9pEhxHgXqXuKG+7IzsoyTvuGfSUPiyqfPA1AaMio74aGWEttH2YoiGeqMM
 HBwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyLgxqHEd1kmZcc5227mOnJQ7ryeJ3oBUMJS8GY5bwbCxQZZYmxm56m4GJnQpQyfs/JL6dywWSid1m@nongnu.org
X-Gm-Message-State: AOJu0YytCQ28ymt7QIAIlc/SV1We/J1RQGiv+Id+WUAPWjdFFPPmPywW
 imnWakfmNXc8YAhF+8I1c2uUWrZ0w6fvbv+FfhBwPY7NzJDFGqM/1d7RIURFcy0OrpE=
X-Gm-Gg: ASbGncut3M96JPncvM942s+u7vcIvDqrw1CabeB+DPS/TgmG2pHPNOog4QWs3pnmQOO
 mtLo+koc4JHPtfc6QaKLx/KtH8jlFLS0t088rKqKV+Yxj7OLGJO9GJvuftho5+Yyt9t/cHMC3KY
 IpuneY2CwnK/iVBjxgIaCP0s1jtNVLCcqttqeaEaB2e5fLBXwWty1qz4OQLbMtHcRKj/b05DsX8
 aUfFxo2w7fxGBgX7kavOX/2mX9nxDpp8lJw2SoVo1SA7/OftEimll8uiReRY8aTjjDh0142UYLK
 p1ImeD27pYMTfc99jQ+pQdTktyn2xLWQ6XnDi0EbejZL0dpW2E2JGRQij0Tb++uDdjEZoNkHr6A
 wi+K2l3LYqVGdPXCklG3LCFm13zIjijA2ckIxWuTHMG0oeLbNAlbnQ4xS+pVeYIKDS2JJdosZbA
 ==
X-Google-Smtp-Source: AGHT+IFNZLorrZhN1IcrDc4gzBFPXQPq/0kgfCK3RgJEtGw+w30A5vLco7Clx0W1ozMwr4M+WFQZ9Q==
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id
 d9443c01a7336-29027290194mr51330675ad.4.1759960577401; 
 Wed, 08 Oct 2025 14:56:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e2062fsm7462605ad.48.2025.10.08.14.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 14:56:16 -0700 (PDT)
Message-ID: <eb6f8f7b-b636-41dc-9612-a204939ff905@linaro.org>
Date: Wed, 8 Oct 2025 14:56:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: add syscall-filter and fork-cpu-loop in
 plugin interfaces
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: alex bennee <alex.bennee@linaro.org>,
 richard henderson <richard.henderson@linaro.org>, trueful <trueful@163.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
References: <625873322.3277896.1759930752814.JavaMail.zimbra@sjtu.edu.cn>
 <386568240.3278044.1759930904927.JavaMail.zimbra@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <386568240.3278044.1759930904927.JavaMail.zimbra@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Ziyang,

On 10/8/25 6:41 AM, Ziyang Zhang wrote:
> This commit introduces a syscall filtering mechanism for user-mode
> emulation, allowing plugins to intercept and handle system calls.
> 
> Key features:
> - New API functions: qemu_plugin_set_syscall_filter() and
>    qemu_plugin_fork_cpu_loop()
> - A new enum qemu_plugin_syscall_filter_ret to represent filter results
> - Integration into the cpu loop for i386 and x86_64
> - A new header file include/user/syscall-filter.h
> 
> The filtering mechanism works by allowing a plugin to register a
> callback that is invoked before each system call. The callback can
> decide whether to pass, skip, or exit the current cpu loop. When
> skipping, the plugin can provide a value to be returned to the guest.
> 
> Additionally, a new function qemu_plugin_fork_cpu_loop() is provided to
> allow plugins to fork a new cpu loop, which is useful for temporarily
> resuming guest emulation (e.g., for executing callbacks) during the
> first system call.
> 
> The implementation inserts the filter checks in the cpu loop for both
> the int $0x80 (i386) and syscall (x86_64) paths.
> 
> At KVM Forum 2025, we presented Lorelei, a system designed to enable
> guest programs executed by the QEMU user-mode emulator to accelerate
> performance by invoking natively compiled host libraries via syscalls.
> We have successfully supported libraries such as SDL, OpenGL, and
> Vulkan, allowing QEMU user-mode to emulate GPU-dependent games.
> 
> Following an invitation from Mr. Bouvier to upstream Lorelei to QEMU, we
> refined its architecture to load the Lorelei module as a TCG plugin.
> 
> Since host libraries may execute guest function pointers (callbacks),
> Lorelei implements a novel nested execution model:
> 
> - During syscall filtering, Lorelei triggers a temporary cpu_loop when a
>    host library begins executing a guest callback
> - This temporarily reverts to full emulation mode to execute the guest
>    callback
> - The guest code then issues a magic syscall to exit the temporary
>    cpu_loop
> - Control returns to the host library's original execution context
> 
> 
> Slides: https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/Slides_DQPMaZE.pdf
> Video: https://www.youtube.com/watch?v=_jioQFm7wyU&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=22
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>   include/qemu/plugin.h         | 28 +++++++++++++++++++
>   include/qemu/qemu-plugin.h    | 44 +++++++++++++++++++++++++++++
>   include/user/syscall-filter.h | 36 ++++++++++++++++++++++++
>   linux-user/i386/cpu_loop.c    | 52 +++++++++++++++++++++++++++++++++--
>   linux-user/main.c             |  1 +
>   linux-user/user-internals.h   |  1 +
>   plugins/api.c                 | 14 ++++++++++
>   plugins/core.c                | 31 +++++++++++++++++++++
>   plugins/plugin.h              |  8 ++++++
>   9 files changed, 213 insertions(+), 2 deletions(-)
>   create mode 100644 include/user/syscall-filter.h
> 

Thanks for sharing this on the mailing list.

To add more context for Alex and Richard, the goal is indeed to support 
Lorelei by enhancing plugin interface.
By having a "magic syscall", control can be sent back to plugin.
This idea could be extended later similarly in system mode, by defining 
an hypercall mechanism.

All Lorelei libraries will be out of QEMU tree, but we need a way to 
connect this to existing QEMU, and that's the goal here.
There is a great potential to accelerate QEMU user mode by leveraging 
native libraries, so it's worth taking a look.

The idea to filter syscalls has been recently brought too by Florian 
[1]. In the end, it has been preferred to provide a set_pc interface 
[2]. While it could work, I think it's not the right direction.

Offering a syscall based interface allows to have something architecture 
independent for this kind of use case, while set_pc approach implies you 
need to find next instruction, and manually read all parameters through 
registers. As well, since syscall filtering seems to fix two different 
use cases, I would really be in favor of having such an interface 
available upstream.

Finally, there are some additional needs for Lorelei, but we can start 
talking about this syscall interface first.

Alex and Richard, what are your thoughts about this?

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
[2] 
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/

Regards,
Pierrick

