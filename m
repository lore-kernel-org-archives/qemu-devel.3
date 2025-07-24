Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF5AC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2s6-0003Zj-SW; Thu, 24 Jul 2025 16:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2s1-0003MX-5O
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:48:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2rx-0007g1-UM
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:48:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23f8d27eeeaso13567095ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753390128; x=1753994928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q694hihzQ0w7fKZLFUTLM7ixZWv38IOMX+mSQR/FV5E=;
 b=asCvmRxDNMSlbzPF7BhPzgmpBeCG7dfZR+bXmB3CSs5OoNydbCx5+YZwe0Txw/DeNX
 oO0jTaJ9atHhlKS+/cdFYpxbmXnoXLUKb7JkOgQT1EbjRWWidCiwcLc2vRd+rYirZazC
 4Q1a226om8Ky4Ty7G1K7C13ukYOIJmKcAxuOOgOapxXRaDvHT6U3n2NQSrZqOsiGYi2J
 RJFHlo20o4C0hatnB7P/YYvuN+YpTkbUZr8JAvAGTIEkp6URUUf2wgAJSYh2oYM7YuGQ
 t6ilr/3YQNYfQSlJCDTjMgdEp1RDXFhwAfu/Gtb6pp0Ote4uCqoAac5QgEeXPldfUbjJ
 AZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753390128; x=1753994928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q694hihzQ0w7fKZLFUTLM7ixZWv38IOMX+mSQR/FV5E=;
 b=WhG2MXX+OXSGnWIIRChoVV9utu9TQbDRMz5pPBUdlEJxyhgUzLNzIXGJLF0cUy6muk
 ByBOnsWfjdxXjrVj0gDc16/HfxkSDJBL22g4D1Fh5yYd4GxCWV2qcHVYk4Wu/7180w2w
 dR8Dma+MzYfba5cjlKd+BIvpz4K8lsoiM0HgfRs7uHoEqm7iRQ3IX6LUEwIZtwy4E9M4
 913/nIZxTwlY82CqIky6YMN9xN9+25ux4NzNDe2YOxEemSPxTOw9x4SokoXCNU72t78n
 gIXe1o+GgoRYbzDcaYt4NGOq3gPcwJI0ias5NFcbCEnCE9Ert9iM34GlFnQZRRbDPLqi
 m9Zw==
X-Gm-Message-State: AOJu0YzSeQjqYgcb4VC7liTpdefYcQr8qHdkRYMuuwzbQ9ZAALpxqImB
 S+wirQ6CBdlzlYURkl2BlaT/aCSFVr97ZVKsmcaDMY5ZCzZk6mnkThr81wLL5tKp420AUXmrWUD
 9CCZl
X-Gm-Gg: ASbGnctIFP6DirAzKbwTKdtu417690MZlr778jjKjB2mKlOejq1nXpIP4F3us+wmZFV
 JWo9wJZXvDynNw8T/7pZ5MzA6tte7kGSD7UpFqJGKOzTEGd+JtiD4JvZfkZqB0jM2UswDICXqlF
 JghlzEVpX8FPWpcLh8JZAKmkDNjEd54RL84aiL/ZuMGwvTYGvCwTNGpAP3N++aHIeNIHVnfNct0
 eUDnJrnfrSXDItZWWz5p3gsSj8Kf95PRSpqHhYbQA4gJXxa1p38qWPHmqlYn54AzopA2g9QFzvu
 i/WEj6iAvJsSENQ5Oh84Zw1lTnVBA3GQpdYBocpDPiLWx2gjcgn74QkL9q/ycrWWV2xEI4Ev0Gp
 VN6lVuWYonpdbSFfUNBkMwcfgxTTA4Fcs76cfgGaS5hWTPA==
X-Google-Smtp-Source: AGHT+IELOUTYgIv09rfxCI4tWfBlh1NzjXZ/zF4iitJARmZaKnfAId8z4iumHjxDqST80Oo0OyprQQ==
X-Received: by 2002:a17:902:fc4b:b0:234:8ec1:4aea with SMTP id
 d9443c01a7336-23f981d382dmr114523435ad.52.1753390128305; 
 Thu, 24 Jul 2025 13:48:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa475fc12sm22294635ad.5.2025.07.24.13.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 13:48:47 -0700 (PDT)
Message-ID: <ce221253-85a8-4a30-b4fa-74f067f7f4b2@linaro.org>
Date: Thu, 24 Jul 2025 13:48:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/21/25 9:55 PM, Pierrick Bouvier wrote:
> This plugin generates a binary trace compatible with the excellent uftrace:
> https://github.com/namhyung/uftrace
> 
> In short, it tracks all function calls performed during execution, based on
> frame pointer analysis. A big advantage over "uftrace record" is that it works
> in system mode, allowing to trace a full system execution, which was the
> original goal. It works as well in user mode, but uftrace itself already does
> this. It's implemented for aarch64 only (with the intent to add x86_64 later).
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
> Overhead is around x2 (sampling only) to x10-x15 (precise), and long traces can
> be directly filtered with uftrace if needed.
> 
> The series is splitted in:
> - implementing the plugin
> - adding useful options (especially sampling and privilege level tracing)
> - add a companion script to symbolize traces generated
> - add documentation with examples
> 
> I hope this plugin can help people trying to understand what happens out of the
> user space, and get a better grasp of how firmwares, bootloader, and kernel
> interact behind the curtain.
> 
> v2
> --
> 
> - trace active stacks on exit
> - do not erase map generated in system_emulation
> - add documentation to generate restricted visual traces around specific events
>    of execution
> 
> v3
> --
> 
> - fix missing include unistd.h (build failed on MacOS only)
> 
> Pierrick Bouvier (6):
>    contrib/plugins/uftrace: new uftrace plugin
>    contrib/plugins/uftrace: add trace-sample option
>    contrib/plugins/uftrace: add trace-privilege-level option
>    contrib/plugins/uftrace: add timestamp-based-on-real-time option
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
> 
>   docs/about/emulation.rst           | 207 +++++++
>   contrib/plugins/uftrace.c          | 920 +++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |   3 +-
>   contrib/plugins/uftrace_symbols.py | 152 +++++
>   4 files changed, 1281 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

Sent v4:
https://lore.kernel.org/qemu-devel/20250724204527.3175839-1-pierrick.bouvier@linaro.org/T/#t

