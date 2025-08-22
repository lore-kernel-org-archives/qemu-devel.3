Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DADCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSp8-0005Cr-3W; Fri, 22 Aug 2025 10:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSom-0004ud-Ky
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:32:38 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSoh-0001Xk-JB
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:32:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e93370ab8so2299184b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755873147; x=1756477947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=czIEl6Q1hMwSZhztmSiFYg4JXrUQeTiTPeUCEoyMxX8=;
 b=TUer9hG48+CpTRWWCXZ/MORXixTOF3MvH7PAC6pYeka7cjOwa0PSF9lrLzG/61gb5E
 zpzZxYRGKO1HmDyGytzUuHpcn7Xwit/C0L6OWvXsIajGOxnWbUlpcd0fz/iylOf9le/u
 0oVjhwyF1QhkcwbhOO+3NX4jRPBztPstWsCScqKdgnu1fmuGF6osjbzhMyzDKxSvGRvz
 WEME7/DfzROzVLBwXk53tfizlUiIid5kUsg51hHWMdsG5wrQ6GxKntGEn8YD3NnHDqaT
 fKF9a+EunW/HvAmqYWWZVv2H20KoiLUeStYDMpIVFyX+N+6d538YZ7uX+5GIw1FufnYS
 m47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873147; x=1756477947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czIEl6Q1hMwSZhztmSiFYg4JXrUQeTiTPeUCEoyMxX8=;
 b=XRWgiE4A5wFb9moyir1gmxoq7eOAHQN4hRBks7H22yQftPu0YuendX+6fEm37RK3os
 /i+1/r0C/eEwTtNatv9Irvnj1vnxQCkx1Pi2eHjDU9x9StL93k4Nu3Upt6xoUqgnHM72
 nN20Zu2GyIDMdJaWCmJer8TgkowCPSEOYcJHONqcmCKk8rfJuKAEKpj2CtUXgr1P2KNd
 M8t4rExUMfIToxTvGH3uBU8Co9Zo071iDR41t9zD1p7L2QtI2flRxhAUJCZxyrsWrnos
 qWmaZ3NQZZRnMTTvKaNfQyvjQDXsIAzIf8BLDkwn8vwqGtTyE6/cGXhWpKtfvKmGcwOI
 vwGQ==
X-Gm-Message-State: AOJu0YziMuxmj3Ze1k8nRznR72cpLa3u92/1aIKuQrhZXJOib15FQRfF
 3Q1QfzzTLKusHZ6DvJzkMeXq6my7nf/xIqKuXqi9uT+F/jZbA/FXzkdw0fHpkiW87GnQXVcRXPi
 YIog6AKgaJg==
X-Gm-Gg: ASbGncut/Q57R0eQx24eyYCfwW5lipsWGkxfumdMp2ipR0AJW0UjdERDHNPBTpioNbp
 TVd5Svy2PvYrSfmAVQVq66raOHPFT6qd5FntJSFbRy7S17jXedblRmysQ8aZUAblU8D/rOyU/8m
 gYtdn3jiAve6y4rPSRR4Pv9SvNXymlTCbuunyR10QEAtEMOxlCOcepKvwAX5VE1zoPkFq+1iQ/F
 9WKgoPi7X/Mw4CJEBvS5goCY4D8qHWLQWz0dBD8Op7OzC6DrG5WwXl/qVAzN/MK4Q4daEjaATzU
 rn3NQzjYPtNR/e5Qq5cZVHXone2pfYFTNnD+JuKbrNdmAgj62GwcfrDP5IH78uu4Y4r9weFDw7i
 DSroAVjGZRcVdMafDSN/iZ8qc4EFlUWmIYEMT
X-Google-Smtp-Source: AGHT+IEU8scoK87WHf0Tx3kCVvkpCemtbnx2/RKLRBE1iPahRbq4xzNwzwnF2R+Z81ScwaljRlr8zg==
X-Received: by 2002:a17:903:4b07:b0:240:6d9b:59ff with SMTP id
 d9443c01a7336-2462ef46b14mr40282005ad.33.1755873146625; 
 Fri, 22 Aug 2025 07:32:26 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24632677489sm25281265ad.98.2025.08.22.07.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:32:26 -0700 (PDT)
Message-ID: <a39236c9-d6e7-4ff3-81a0-bf83b579475d@linaro.org>
Date: Fri, 22 Aug 2025 07:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2025-08-08 13:41, Pierrick Bouvier wrote:
> This plugin generates a binary trace compatible with the excellent uftrace:
> https://github.com/namhyung/uftrace
> 
> In short, it tracks all function calls performed during execution, based on
> frame pointer analysis. A big advantage over "uftrace record" is that it works
> in system mode, allowing to trace a full system execution, which was the
> original goal. It works as well in user mode, but uftrace itself already does
> this. It's implemented for aarch64 and x86_64.
> 
> Let's start with concrete examples of the result.
> 
> First, in system mode, booting a stack using TF-A + U-boot + Linux:
> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> - Stat and open syscalls in kernel
> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
> You can download and open it on https://ui.perfetto.dev/ to explore it.
> 
> Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
> - Loading program and its interpreter
> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> - TB creation
> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz
> 
> If you had curiosity and now you're ready to give some attention, most of the
> details you want to read are included in the documentation patch (final one).
> 
> Overhead is around x5-x15, and long traces can be directly filtered with uftrace
> if needed.
> 
> I hope this plugin can help people trying to understand what happens out of the
> user space, and get a better grasp of how firmwares, bootloader, and kernel
> interact behind the curtain.
> 
> v6
> --
> 
> - fix types and spelling mistakes
> - use _MAX for privilege level enums
> - uftrace info file: use empty strings
> - trace flush: assert we wrote all data
> - doc: added style for keyboard keys
> - added URL to document uftrace entry format
> - updated comment in vcpu_tb_trans to explain why we always instrument the first
>    instruction in tb
> 
> v5
> --
> 
> - addressed Alex comments
> - split plugin implementation in several commits
> - removed instruction based timestamps (only use time based timestamps)
> - removed sampling implementation
> 
> v4
> --
> 
> - add support for x64
> 
> v3
> --
> 
> - fix missing include unistd.h (build failed on MacOS only)
> 
> v2
> --
> 
> - trace active stacks on exit
> - do not erase map generated in system_emulation
> - add documentation to generate restricted visual traces around specific events
>    of execution
> 
> Pierrick Bouvier (9):
>    contrib/plugins/uftrace: skeleton file
>    contrib/plugins/uftrace: define cpu operations and implement aarch64
>    contrib/plugins/uftrace: track callstack
>    contrib/plugins/uftrace: implement tracing
>    contrib/plugins/uftrace: implement privilege level tracing
>    contrib/plugins/uftrace: generate additional files for uftrace
>    contrib/plugins/uftrace: implement x64 support
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
> 
>   docs/about/emulation.rst           | 199 +++++++
>   contrib/plugins/uftrace.c          | 876 +++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |   3 +-
>   contrib/plugins/uftrace_symbols.py | 152 +++++
>   4 files changed, 1229 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

Ping on this series.
Comments from reviewers have been addressed.
Alex, are there other changes you would like before pulling this?

Regards,
Pierrick

