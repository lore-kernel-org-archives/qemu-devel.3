Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE033EB2714
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpubd-0000in-Is; Tue, 10 Feb 2026 15:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpubc-0000ic-BP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:45:08 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpuba-0005hR-D5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:45:08 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso2917345b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770756304; x=1771361104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J3DA9TlpBUHYt1VbylJqk13ZlvweQpsII6b9er2CXF8=;
 b=jOWMLjE1NEmXJ4hNXtoaTPzrB8SR7Z1/rqKeYNGnLRrt1h1IXMpKyllEHRayf8UebP
 /wYssS3UaxrPGbiIW5j74r3bxEezYZKDuyTBL18pNRjMarqGEfw3NxGTAqRv54OAXhZc
 rNRmeT7j1Xx3Hfv9nxWT2jgNbPgxvIxBWDIf9G7fbMVXgZx45tR6qc9ixavlh7ZIGZ2E
 Ng61Dh3rauGjl2+Ig8fygumTZBKp4Edxk7ueWr7XDvTTWEJRa4zbQrloBOhSlH5g54vl
 vDQSYxakV/QdHAhdEVS8u25rtMekCNj40J6wRStS49sv/VHRZcdCqSYj8T6ayJz+PYsY
 OPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770756304; x=1771361104;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3DA9TlpBUHYt1VbylJqk13ZlvweQpsII6b9er2CXF8=;
 b=xVbchD009UVPpSGUQeuGLjeeVV0dlhbxIqF+f3CSXR/gKE6QM2raqCCXj9XyiYuLJI
 r7C3fBVmyNtzkdG8hmv059gt1MvKc44zpbQJTU55maZJ8VH4vJUZzWqDq6jsO7zPVFKm
 DMCggWOz/TGyU+uptpRiccJ3PHblOIK229BNuRKGkJHnioyU/OwgPszAQcxwRJAVJEWe
 3zOjI8MiuF4PAE7p5jQHSq9nBNu7jMOSedim5mrycFOWrCLaVZs0TAm2RH81t22Rd+nV
 9sOG9Yn93Hh1pd3+TKruA1xPpVvTJMvENwsPDNdRNrP5kJTOeQ0lyalalirmhoqCqrPC
 58yw==
X-Gm-Message-State: AOJu0YxzMavIQxqbp3OFg/No5Qunn6lV6YqGlkdbTwF1vIjGuikj05Rm
 NLZAU+nJ3AOudOXnhYyG28otbEMwW9jqJ4k3ORysPoZxY9vAF3HT7rxR4RmygElZhD4=
X-Gm-Gg: AZuq6aKbm4cYvYAqFnWcpRaMbRhCZkM62QuCNFwJBJLosPIrHvCXtSoaIxfESSRy3lH
 GrCNYKglVlBhgpQOz7YpfiiCi2v3G+dmKvBGqrHKLTe1mT7FVzGkdV0dSbIJJ3R7kQkKCaCJxS7
 x5aKkifaBs31kXCpw1tVLUYGFCuoPopMjQpOGyFwyF/nf3Y7BhXmfE/QCzc81XrrCYEP0hxjD4J
 ZRZsIG09Puv8w/8cLoXLeI2r+dbN5wF7BwGetbEP0HFOYB++JTI4PUIg+plozoGcs/w9RWtYq/h
 bCfX9f+jOZTAujBx/04Z9ZYDiROb+ht60dG5+2whzRqAVdeZwH37SZmKtIwOzXYy3wWGP8D3kwc
 Z2h4zs20455+G9aW6Ic8GSvEwweruUiy6/LO5pKLUnClSlaCGYpsk20AJ+m7aRxHnhAbs0lIUCO
 74PbcxFCCCTCqlDXxNfxVOv2rGwzMQM1q65BreUzEbqIX7qwMHyK0Z40TUpD3IY41J21DU
X-Received: by 2002:a05:6a00:71c5:b0:81e:a228:f0d8 with SMTP id
 d2e1a72fcca58-8249b0d850dmr299620b3a.34.1770756304094; 
 Tue, 10 Feb 2026 12:45:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441677569sm14041285b3a.4.2026.02.10.12.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:45:03 -0800 (PST)
Message-ID: <08268821-626a-4a61-b2d0-7b4c6e973ba3@linaro.org>
Date: Tue, 10 Feb 2026 12:45:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows
 targets
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260210040722.11375-1-mohamed@unpredictable.fr>
 <508e49cd-a37e-4388-827f-9e692c5f9905@linaro.org>
 <C933BE09-BFA4-4F13-87FA-2FD2994CCEE7@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <C933BE09-BFA4-4F13-87FA-2FD2994CCEE7@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/10/26 12:04 AM, Mohamed Mediouni wrote:
> 
> 
>> On 10. Feb 2026, at 07:39, Pierrick Bouvier 
>> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 2/9/26 8:07 PM, Mohamed Mediouni wrote:
>>> llvm-dlltool assumes that it's by default targeting the host architecture
>>> it's running on. That assumption doesn't hold true when cross-compiling.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>  plugins/meson.build | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>> diff --git a/plugins/meson.build b/plugins/meson.build
>>> index 34643e2cea..9899f166ee 100644
>>> --- a/plugins/meson.build
>>> +++ b/plugins/meson.build
>>> @@ -41,9 +41,16 @@ if host_os == 'windows'
>>>    # to find missing symbols in current program.
>>>    win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
>>>    if meson.get_compiler('c').get_id() == 'clang'
>>> +    if host_machine.cpu() == 'x86_64'
>>> +      dlltool_target = 'i386:x86-64'
>>> +    elif host_machine.cpu() == 'aarch64'
>>> +      dlltool_target = 'arm64'
>>> +    else
>>> +      error('Unknown machine')
>>> +    endif
>>>      # With LLVM/lld, delaylib is specified at link time (-delayload)
>>>      dlltool = find_program('llvm-dlltool', required: true)
>>> -    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 
>>> 'qemu.exe']
>>> +    dlltool_cmd = [dlltool, '-m', dlltool_target,'-d', '@INPUT@', '- 
>>> l', '@OUTPUT@', '-D', 'qemu.exe']
>>>      win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
>>>    else
>>>      # With gcc/ld, delay lib is built with a specific delay parameter.
>>
>> Interesting, on which setup did you find this?
>>
>> Regards,
>> Pierrick
> Hello,
> 
> Was found on my macOS arm64 laptop w/ using llvm-mingw and an MXE fork 
> to build all the libs QEMU needed.
> Cross-compiled for arm64 Windows initially from there, and came across 
> this when targeting x86_64 from that setup.
> 
> 

Ok thanks.
When I cross compiled windows-arm64 -> windows-x86_64, I don't remember 
having to set it. That said, it does not hurt anyway, and everything 
still builds fine natively with it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,
Pierrick

