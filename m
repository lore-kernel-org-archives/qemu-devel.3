Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHMt-00058I-HP; Mon, 27 Jul 2026 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woHMq-00057q-7Q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woHMo-0000Re-Do
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785143481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8slHnuVoR4TbF36t9Cc0pLXRg84WP2PGSBTAoXEKA2M=;
 b=S2urQTVhA1uhlj/3VAGjxZS7bWkgmkzVX485dHXmKG+mfu3Jr9FdUiBeIY5SJJroO1KepR
 l5jz3KpHJ0pnNYf6JA3jBzujQFEi7ynzslQAFL1IVgesgciBOCbZcU4C18iClrautJOAMN
 EPI80QqbfXxd+0jFAqDpk4jd6rnGJNU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-uIh2qlGrNn-9vwp_EwhZkA-1; Mon, 27 Jul 2026 05:11:19 -0400
X-MC-Unique: uIh2qlGrNn-9vwp_EwhZkA-1
X-Mimecast-MFC-AGG-ID: uIh2qlGrNn-9vwp_EwhZkA_1785143478
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c16711b9473so250366966b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785143478; x=1785748278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8slHnuVoR4TbF36t9Cc0pLXRg84WP2PGSBTAoXEKA2M=;
 b=bRQfSmC2NLiDSNJ0AKfnTTk1lZ/q9mjA7goixU78YVMwC9Zve/Z5Qiox1756i5ngMo
 nuRlAr3Mo/Bg70tXlqOb8mWyBPLoTc4h/2J427bXiA7VRg0LiANp2noSl33/MT09L/dC
 zvRR8v3ID+uHhzo202hWN8NWeL7FQBwAdDqGIUeTMx0OJnP0Vsw/D320HmmbfCsS/qhO
 c3AQ65Ok0y2o8+3RPm+/lbEnFY/CrYk1mRaCbonuqrOZaERcGk3I6k1XyDDqlaZYxBAk
 d/olcps6Tv3xeF+lYFWA855e2DgHrI9+GjxaIOZqOh/ibSBbobHr3aNmQFFhQFK8rnhQ
 xvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785143478; x=1785748278;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8slHnuVoR4TbF36t9Cc0pLXRg84WP2PGSBTAoXEKA2M=;
 b=P946JrnNb649FwDxO1G50ayDJ40+VBAF8o1Fdj9W+iPZF+kW3pCvw2+mZPN/WC6Dcq
 AbpgsQpLWz1adrEtEg46KpyD7nOVGnQtYQuYAad4j0Gl+/yAf5MYAEwwVs/aeC9GPIk5
 hnZwbedHb5rXpVvrjljUUQ1qeGEYHzf+oHyZZ2jSQiudNZDbzDHh6OJBxUcK0qiKFHko
 vLkvoVwcljcA9Fs1q35leDE2rzrgN+NEEhUwXrO0KjJrFKPaD9XZFrhgcJWDwmvoeemX
 MnvLZdLSsDu76ayjhzr64YyMHmuZva6CbxGahHsQbyc5bUGxVy7efGMw7KcZ14mD8Mdk
 so4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3xdybp+JNqLu3wW77prX43tnPv+EOmnxtvByTcSq5s5e3rq40omNBcYj+2xboKRFoTlf9J4EOwVBK@nongnu.org
X-Gm-Message-State: AOJu0YwUH7swXhdnO98ouJjoTeg5i4TkgVJczMI4uiu6WFnHsAX+WVJu
 yFV8mzkUJbPfFQ2GwIwYxZpKiNKp0Zjt+HMhVQSevFa+0NisuxWBQhTYcTtarydMf5RTEYsSWsR
 4MJ8OdcQ6+nc78+c7joQBEBDbpDk+LCVmW/fb52Xb1yt9k2Eq1aY7DZgC
X-Gm-Gg: AR+sD11mmpdQP+2m7wIGykpkd8C/LuLA/XER8JYbQIAYx/lyWZgNFHerynauUssvoCZ
 DxA62eArLx5C8Qli3cM4rsSNXwSnS8fj86sptzYpNsaGO5wuyQycrfweQmp3sI0JAIb8KqVO8/e
 tkwoTyySLJVF7uDqkNP7soeVxoyJn5Na2bVkuOywhLVGqAKQiUT320CeE2t4mjLlP0niOzrcZOS
 NOC+0iQWOn/JwQlevePGGvn8FRH2b5iBG3EiNCxX8tKMBUpDADMjmUYrkE+hv6wEV+04/DnBuMO
 9EPNIgQye6qqUj3adXFscjv7bK6w53XPsErrt2UCQ06XdQwomKvD+ZzJWceqOYvlXl63UaaKpg=
 =
X-Received: by 2002:a17:907:9445:b0:c16:9ef6:b7ec with SMTP id
 a640c23a62f3a-c1f1f43785amr346296966b.55.1785143478323; 
 Mon, 27 Jul 2026 02:11:18 -0700 (PDT)
X-Received: by 2002:a17:907:9445:b0:c16:9ef6:b7ec with SMTP id
 a640c23a62f3a-c1f1f43785amr346295466b.55.1785143477828; 
 Mon, 27 Jul 2026 02:11:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebc3c0sm602963866b.51.2026.07.27.02.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 02:11:15 -0700 (PDT)
Message-ID: <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
Date: Mon, 27 Jul 2026 11:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 27/07/2026 10.12, Philippe Mathieu-Daudé wrote:
> On 24/7/26 18:45, Pierrick Bouvier wrote:
>> On 7/24/2026 6:54 AM, Florian Schmidt wrote:
>>> There are situations in which you might want to build QEMU without
>>> building the full test suite, which in some configurations can take a
>>> considerable amount of time to build. This is especially true when using
>>> LTO with clang. For example:
>>>
>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' 
>>> '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu
>>> [...]
>>> $ time make -j8
>>> [...]
>>> [3078/3078] Linking target tests/qtest/qos-test
>>> real    6m43.250s
>>> user    101m15.967s
>>> sys     4m3.813s
>>>
>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' 
>>> '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64- 
>>> softmmu --disable-tests
>>> [...]
>>> $ time make -j8
>>> [...]
>>> [2024/2024] Linking target qemu-system-x86_64
>>>
>>> real    3m14.277s
>>> user    33m13.174s
>>> sys     1m36.642s
>>>
>>> Add a toggle to optionally disable building tests.
>>>
>>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>>> ---
>>>   meson.build                   | 2 +-
>>>   meson_options.txt             | 2 ++
>>>   scripts/meson-buildoptions.sh | 3 +++
>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 49a5baf5b5..ad728c26ec 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -4605,7 +4605,7 @@ subdir('docs')
>>>   subdir('pyvenv')
>>>   # Tests are disabled on emscripten because they rely on host features 
>>> that aren't
>>>   # supported by emscripten (e.g. fork and unix socket).
>>> -if host_os != 'emscripten'
>>> +if get_option('tests').allowed() and host_os != 'emscripten'
>>>     subdir('tests')
>>>   endif
>>>   if gtk.found()
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index a07cb47d35..68333ca402 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>>>   # on the configure script command line.  After adding an option
>>>   # here make sure to run "make update-buildoptions".
>>> +option('tests', type: 'feature', value: 'auto',
>>> +       description: 'Build the test suite')
>>>   option('docs', type : 'feature', value : 'auto',
>>>          description: 'Documentations build support')
>>>   option('fuzzing', type : 'boolean', value: false,
>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>>> index c003985047..3fec13a336 100644
>>> --- a/scripts/meson-buildoptions.sh
>>> +++ b/scripts/meson-buildoptions.sh
>>> @@ -194,6 +194,7 @@ meson_options_help() {
>>>     printf "%s\n" '  spice-protocol  Spice protocol support'
>>>     printf "%s\n" '  stack-protector compiler-provided stack protection'
>>>     printf "%s\n" '  tcg             TCG support'
>>> +  printf "%s\n" '  tests           build test suite'
>>>     printf "%s\n" '  tools           build support utilities that come 
>>> with QEMU'
>>>     printf "%s\n" '  tpm             TPM support'
>>>     printf "%s\n" '  u2f             U2F emulation support'
>>> @@ -515,6 +516,8 @@ _meson_option_parse() {
>>>       --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>>>       --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
>>>       --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
>>> +    --enable-tests) printf "%s" -Dtests=enabled ;;
>>> +    --disable-tests) printf "%s" -Dtests=disabled ;;
>>>       --enable-tools) printf "%s" -Dtools=enabled ;;
>>>       --disable-tools) printf "%s" -Dtools=disabled ;;
>>>       --enable-tpm) printf "%s" -Dtpm=enabled ;;
>>
>> That's a great addition, including just for speeding up normal builds.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> If we want to overengineer the thing, it could be possible to still
>> declare all tests, but not build them by default. However, it's probably
>> too error prone and much less simple than this patch. So I don't think
>> it's a good idea.
>>
>> Regards,
>> Pierrick
>>
> 
> When is it useful to build without the provided test suite?
I sometimes wished indeed for a --disable-tests switch in the past already 
(was just too lazy to contribute a patch): I'm sometimes building QEMU in a 
separate directory, just for a very special case like testing a patch with 
an --enable-asan build, or for doing a "git bisect". In such cases, I never 
want to run the normal tests since it's simply not necessary. I run the 
tests from my main build directory instead once I have a final patch and 
want to contribute it to upstream. So IMHO this patch is a good idea.

  Thomas


