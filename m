Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C290E6688F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 00:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF0Ne-0002Xw-8T; Sat, 23 Nov 2024 19:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tF0Nd-0002Xm-3Y
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 19:21:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tF0Nb-0005WG-32
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 19:21:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3823eb7ba72so2292904f8f.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 16:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732407691; x=1733012491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVPZZe+Tmjqo2FxTYByx5mTGyGpIQ1JQcGTqyOfsSeM=;
 b=WFehxnO648k4n86Qt+oZIglDoSQ+lwkGQKH+O/jh4HuXoNmrZV/ak88d5NyZn4qYFJ
 re7/ybwr6IlFm8SWbAj9AtjbDIezsA5BNFbHHKbveD5+vkvBc+RTh0IIZwlN8eFJq3FX
 8pK1w4HajY2ZPZumkPfg+pcT8KBKYzobsqoV7TECfd0BhEUtbFuZiSc2HEYHDF/1V9uS
 lAzBp6bqKYUEW4DU9g9uajUHU31zAVDkufB0LBSPag5PlTdgvtyexzatNyOiTb4t26A4
 /LoCsBtWnTNOEoq0PDL/MyDVfSxOVETjKlK99Sj23k8zz0UrFpnkcFnx1uul3BmqtyMB
 xW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732407691; x=1733012491;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OVPZZe+Tmjqo2FxTYByx5mTGyGpIQ1JQcGTqyOfsSeM=;
 b=ihiWSZ2p8HyLqO9e/3QuquInVsMvdPUouW6m2k6xtrax01GZOtzsEKRHCMRBHMLbwk
 G/xPQtbSReXGUruhNBIJI2meVZ+oXpnv2xqFPnfbxqxcP/mK5MkbfRBrI0jTTiw4voYO
 T02vMw+bMMDUaS56f/scauNI/+VovEmXna1i3kSfELdo5swuQCQxET2sSRF4MIlkgv2e
 r1qDHmpfxxVfRvewpSXeHe0f4rXDOGKO1lYJ7+rQK+eRNp0LbGEYAPf7QpXOY1yJrpp7
 3wtYiyoeRvFfvlkpXvJ7Usl4TvHrk92hwcBhyh8x5ZYnS6Md+UUfGzD3Zznnkoc47dnL
 IkOQ==
X-Gm-Message-State: AOJu0YwStiQMtTwQtKN5SLLNYrR1WsKEOK7z2BMXEJuhPAg7vYTX9xgg
 RGfUlH9FqX5MTdr44GVJQ4dZyiwPWcHxIePZx1KNFBXYU4sc97yNizjz2LMV6bjUPnMFtcV6AGx
 ISS4=
X-Gm-Gg: ASbGncsW5dEv2OHC2gvbicB9N1paZTrI+HI4odZoHkeF3d9IqU8eQXmXHv7prcSgaxq
 YFopmQ1q5wQI14/j0SitNFQbYSREe3MfSg8q3jyi7yA9mM4nmVjaLqh42MhN0fL//jSzkcRT7R1
 lrJr5ANPhEM17rHHjRM0TsgO+fs/TKd4DN9/cYGAlbYdMd6suVQpFvAJcEnFoLkREJWoo2SSNn9
 MpsDZ4yd7BKOlEilaMWu/OfwvliudKoov1BoiqNg83P3wRSHnN9y2EtDz26HyWleA==
X-Google-Smtp-Source: AGHT+IGYH0LbCz6mZY49h+lnQiAfYhBmav6EAdiV2u+GjRy85NZO68FTxZcAIzsKYd1abWLCX3YE4Q==
X-Received: by 2002:a5d:588b:0:b0:382:4a9d:28fa with SMTP id
 ffacd0b85a97d-38260b808edmr6155213f8f.30.1732407691089; 
 Sat, 23 Nov 2024 16:21:31 -0800 (PST)
Received: from [10.150.212.240] ([95.173.222.38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm6467648f8f.100.2024.11.23.16.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 16:21:30 -0800 (PST)
Message-ID: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Date: Sat, 23 Nov 2024 16:21:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Supporting clang on windows
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi all,

very recently, I've been working on enabling clang builds on Windows 
[1]. As part of it, the major blocking point is that currently, clang 
does not support gcc_attribute on Windows.
The change proposed [2] was to use the compiler option [3] 
-mno-ms-bitfields, which enables the same behaviour. This option *only* 
has an effect on structs containing bitfields or structs that are 
packed, not on *all* structs.

The question that was left is: Is it was we want?

After thinking about it, a simple, exhaustive and reliable way to find 
this type information is the debug (dwarf) info.
By compiling qemu binaries with --enable-debug, and extracting info 
using llvm-dwarfdump plus a custom filter [4], we can obtain a text 
representation of all structures QEMU uses.

As expected, turning the option globally has an effect. The exact list 
of structures impacted (those having bitfields, and not being packed) 
can be seen for each binary here: [5].
As there is a lot of repetition between all qemu binaries, the reduced 
list of structs concerned is [6]:
+name:ArduinoMachineClass size:0x0198
+name:ARMCacheAttrs size:0x04
+name:ARMVAParameters size:0x04
+name:AspeedMachineClass size:0x01d0
+name:_GIOChannel size:0x70
+name:MachineClass size:0x0188
+name:MicrovmMachineClass size:0x01a0
+name:MPS2MachineClass size:0x01a8
+name:MPS2TZMachineClass size:0x01e8
+name:MPS3RMachineClass size:0x01a0
+name:MuscaMachineClass size:0x01a8
+name:NPCM7xxMachineClass size:0x0190
+name:PCMachineClass size:0x01c0
+name:PnvMachineClass size:0x01b0
+name:PPCE500MachineClass size:0x01e0
+name:RaspiBaseMachineClass size:0x0190
+name:RxGdbSimMachineClass size:0x0198
+name:S390CcwMachineClass size:0x0190
+name:SpaprMachineClass size:0x01d0
+name:Sun4mMachineClass size:0x0190
+name:TriBoardMachineClass size:0x01a0
+name:VexpressMachineClass size:0x0190
+name:VirtMachineClass size:0x01a0
+name:X86MachineClass size:0x0190

The interesting point I discovered is that, *after* this change, the new 
size start to match size when compiling for Linux.
After all, it makes totally sense: gcc by default mimics MSVC behaviour 
for bitfields, which is different from its behaviour on Linux.

As a conclusion, I think that applying gcc_struct selectively is a wrong 
default, and using globally the -mno-ms-bitfields allows to mimic what 
gcc is doing on Linux. We don't need any ABI compatibility with MSVC, so 
it's safe to enable this.

Before pushing the change again in a new series, I would like to get 
feedback from the concerned developers, and hope it can convince you 
this time it's a better approach than what we have.
As a side effect of all this, it will unlock supporting clang on 
windows, and with that, building it officially for windows-arm64, which 
was one of the goal of the original series.

Regards,
Pierrick

[1] 
https://lore.kernel.org/all/20241031040426.772604-1-pierrick.bouvier@linaro.org/
[2] 
https://lore.kernel.org/all/20241031040426.772604-8-pierrick.bouvier@linaro.org/
[3] https://gcc.gnu.org/onlinedocs/gcc/x86-Variable-Attributes.html
[4] 
https://github.com/pbo-linaro/qemu_packed_structs/blob/master/filter_dwarf_dump.sh
[5] 
https://github.com/pbo-linaro/qemu_packed_structs/commit/a47747b5220a933a94dbdc6e7bcd96589ae9abd0
[6] 
https://github.com/pbo-linaro/qemu_packed_structs/commit/9d41b7bd1fbd1d1553ae532e36c9305438549ae4

