Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C8EC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue552-0008Ul-BL; Tue, 22 Jul 2025 00:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue54d-00082w-9g
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:57:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue54b-0004ei-C3
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:57:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso4523392b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753160272; x=1753765072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UKj2tCIeq+gTs/4FxwGmf+XyhqbWUhV5SBlBQNmg1o0=;
 b=V9XBnQFKjTY3xLRMZ2VSRASc/62HTGNlyi9irXfU94/QjW1vbKfN++jb9g7ADbobL+
 cVt8rR8Gfr9i/qqUFMs/VrH+9g2NrSm7htnbzpGCSvStMmwENSNBMdJGS2pH6O1G7NOQ
 XEnsUkScE0XconOvIYjXSxgfPam0EYhKNgGvLSfjZMlLIgNkXT2JySNcp5TqyhiTFgn7
 sB3OJcXWZzkY2QI5rz0xtvgM5aWzi4ylghJQXCGcQQJ9nr2IMGVI2yyzf/Ps8XDHsbYX
 9whBKqzybEqRcsRffq4/rLqAl3P+Jkj7C46kCPkCj4KcndHPtKIlWO93/MLtoo4h8r6d
 6b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753160272; x=1753765072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UKj2tCIeq+gTs/4FxwGmf+XyhqbWUhV5SBlBQNmg1o0=;
 b=Iv5LVDCPb1yLgsvHre5GhC2lZKjUBHZRFD+nZ4JUITHTlw2dHaMNYPRKmbAluy6+Bo
 KD3mEOoeAhm7Cl0tnWvAQnSGOdKjPB7DTvdm6ZD50F1KuylziNnlDiaaIB5syXzEY6Ey
 HCXzhb2ZYcnjJaBbI4Bi537UT5Un1EiOjsiwY4q9TwHxaVRwu5LcKAY1NodhYs9Ex/JN
 1Aehh60IyzHpTtawNcSa02sIQQI5lycWk4tmFceoahjw+cT2T43u82BMCueB6UQKl0Tu
 ORUoC4aS9b2JZI/m+GUTjfuvGIsu9Yq16Ve5nJqUAhEgferJbIg5Pm3THR1i1B5ath5O
 Rk6w==
X-Gm-Message-State: AOJu0YxRtaFwssMkGO3s7Sdm3dcPDKIYNtFAsITkOQUjGWhRi0t79VZh
 SFm1E4H2nEp5fhacIuSiyWo5/nrvW3COIDWfxoBqgHKDsMu7ip9V8c7bEoVcVUGOILrCfXqYgGX
 xbvJ1
X-Gm-Gg: ASbGncsWJbA7d/IJs6s1L4VoVaEfd48awWXpuBL5wMVsZ+Xv9fJPTvemBLAC5wTYca9
 EPFiyaA5jLjEgiJwRrIpwqc3dIMfWV0sZTBFm0UTxmg6CincgAiCbkdnXaYwEoOzoeuxk+DlGys
 p/EWIAkU97ul+RLYvRD1xodJCDwDOpauydrr7POmj6Gf4h/L0y3iQ235+J34qsaDHIxx6AaHkO/
 JwvxlZXWlWmlzBXTM+6CejYE8Ocz6s0k6m2srfElDb4UGtmOitoQ5S5XYkJSaeoK4kWtALuguOP
 5PY9lqGEpqj4N9HBVOp1p8zSwXijD4Gsog1YVHu6T2Vh/A/+wsmvacDIcfZJ8bvY4HMox5ljJ9L
 fnlsyNm79pMKTa9C754thGyadwQoIw68HkbXFk6xkV5lTxA==
X-Google-Smtp-Source: AGHT+IFMANRxNFuySeAcZGBjRCwYzOnUFj8Kv5ahYaHZ5bcafWF5fwEQafc8LbCON0VM+Jc5Rglm+Q==
X-Received: by 2002:a05:6a00:3d53:b0:748:3385:a4a with SMTP id
 d2e1a72fcca58-75724e89802mr33597685b3a.23.1753160271723; 
 Mon, 21 Jul 2025 21:57:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb76da69sm6590514b3a.115.2025.07.21.21.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 21:57:51 -0700 (PDT)
Message-ID: <39ffac72-0173-4541-a81d-236ba1ec6d0f@linaro.org>
Date: Mon, 21 Jul 2025 21:57:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] contrib/plugins: uftrace
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/21/25 12:33 PM, Pierrick Bouvier wrote:
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
> Pierrick Bouvier (6):
>    contrib/plugins/uftrace: new uftrace plugin
>    contrib/plugins/uftrace: add trace-sample option
>    contrib/plugins/uftrace: add trace-privilege-level option
>    contrib/plugins/uftrace: add timestamp-based-on-real-time option
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
> 
>   docs/about/emulation.rst           | 207 +++++++
>   contrib/plugins/uftrace.c          | 919 +++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |   3 +-
>   contrib/plugins/uftrace_symbols.py | 152 +++++
>   4 files changed, 1280 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

Sent v3 fixing a missing include (build failed on MacOS only):
https://lore.kernel.org/qemu-devel/20250722045527.1164751-1-pierrick.bouvier@linaro.org/T/

Regards,
Pierrick

