Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzuC-0005ju-FR; Mon, 05 May 2025 13:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzu9-0005iz-Vi
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:47:02 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzu3-00009F-8j
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:47:01 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso4860499a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746467214; x=1747072014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkiIBScfndqg7os4hIqHVcBti+HptMS/+YM/TseDweM=;
 b=KoyksapCUY5XXU6uxSJuzYtveImtT9Bn1jxxLwVhSfi8IN0U0EHsuB6oKt6gAtugcQ
 0pHcZsTucbViFu9gbr97IV7ew1I4cRThRyf9R1QlPZTM9RG4AgwsXcdyNIhR2gvJTfGg
 j4CFE9o8VX9k2UFOVFyVO3/z09Oj3UcRG6+pDNPcyMVICrv4YQGjPulLRenWnP3LwzpU
 GVH5eZUgVEwEfupEoYvqkOrMUnusl8sVt4tureUl/w2OE+fCRPOlMEBdkutXO5VTJ3wm
 YdGIUQNNTtvMub4NdX9mEr5XHp6oJuZCKtvgq1EyPD0yXki2guW8wQPgcJFB19Z/cQWV
 15sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746467214; x=1747072014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkiIBScfndqg7os4hIqHVcBti+HptMS/+YM/TseDweM=;
 b=gRgurncDNN60KHaIrhyv4NIPC5IYUZ0PJVuA0aC3+MW2pWd6Gw3vwaVPAbIZ8P2eGu
 FixirvrtO2A7aOT+Kv5PbGFHu6ICKtTdv4xAqIKCyNZK1ZShvHeDghaMTPn/HuciuIIT
 hBtCBJ0r86/7yoFMjSK7derQ0VQKZ7SK6THKczYukoqqkoIdPbNQa4o4b4Fv+/SKVtI+
 H+4uQIbjQh2qMumqwmt+SxXq6ORt8fcfbwd5QZUAODhO7f2xXstTwp+Qkk2Rl/mLF9/m
 BWBDpFLqjl7HMYRk+zQQqK/SZs2AuQEeSd67UR6XTuUPf9LcTUGHrntlqbMSENwO/Eol
 XZdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+OxMgVmRY4hbnWNBCnNs0TdMuDwnLmXQNvgIoQ2wtOnoSeG81TBCP645yweEzo6WKHP4huMZKEANk@nongnu.org
X-Gm-Message-State: AOJu0YwN9mCoqQBJDh+NNp23KGfG7RoAXGqfKC9z6eiUVz5ypQOmQ26Z
 WGr3yPDYZduxuI+C+QQs0mnktAdvPFnAZCPUok1G4FeIF519cSmpI551F9JJcKs=
X-Gm-Gg: ASbGncvv0sWB7m2h54rMTA+7RE+l2zMlz9/1gEpkzunXlMHWE5ka3t+khnq6oZ/TP5o
 se1fS/KnNvhcFJSNGJfWVQSYOhQmf+U+o58svkdJOiowQFg7WtevJ0mTRcCGLZuFJAKie3SMjeK
 m8NojpmLrzXTzxwzzp56Av1x3bgciiABcaMSOpaEB7WuFMNNtsCl3HmO9N0119AnD8SvckXAkOE
 fO6itiV/a9DRZZvaSMUlY3LXnMWACibh9zmE04rsfmDdGXTLbDMluU2hawsB0O/l5vIuMFIWT/z
 oU9YmyauVgYDQ52/JtHc3ug6Nd6+iwMJrevJqTjychIVkDVjH7IIEQ==
X-Google-Smtp-Source: AGHT+IHaZWlfnoO2C1x2ekQ5TyRHDnxf9J5Hkai5LBURFwryLauuaFUDLTxZRvNocWCQfSVoY9IyHw==
X-Received: by 2002:a17:90b:280b:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-30a61a6f845mr10828468a91.31.1746467213723; 
 Mon, 05 May 2025 10:46:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47476814sm9333900a91.17.2025.05.05.10.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 10:46:53 -0700 (PDT)
Message-ID: <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
Date: Mon, 5 May 2025 10:46:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/5/25 3:32 AM, Thomas Huth wrote:
> On 03/05/2025 22.18, Pierrick Bouvier wrote:
>> Allows all tests to be visible by default when using meson test
>> directly.
>>
>> This has no impact on make check-* commands, which use SPEED=quick by
>> default (see scripts/mtest2make.py).
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build | 5 +++--
>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index f8bf6e7bb66..57ff3f722d8 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>    
>>    meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>>    
>> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>>                   env: ['RUST_BACKTRACE=1'])
>>    add_test_setup('slow', exclude_suites: ['thorough'],
>>                   env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>>    add_test_setup('thorough',
>> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
>> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
>> +               is_default: true)
> 
> I'd rather not make it the default: The thorough functional tests download a
> lot of assets from the internet, so if someone just runs "meson test"
> without further parameters, I think we should not trigger these downloads in
> that case.
>

$ cat tests/Makefile.include
...
check-functional:
	@$(NINJA) precache-functional
	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
...

What's the rationale to run check-func with SPEED=thorough and 
QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only 
quick tests by default?
Either we should remove SPEED=thorough, or download all tests by default.

>    Thomas
> 


