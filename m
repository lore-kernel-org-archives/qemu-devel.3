Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561A8C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UGE-00088L-5I; Mon, 28 Apr 2025 15:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UGC-00085d-3s
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:35:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UGA-0000x6-2K
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:35:23 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227cf12df27so49899515ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745868920; x=1746473720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3koL5YcaNhfuFyfmgiA4zQ3oQ2TQe2oURd+Ul39PKs=;
 b=EWOrXHqzYgPBq9DWMlOLnWj8MaVOS2CYK6PhTuXN/Ycx93JR7YfMiLLyJcb3wLukK1
 p5S7tr3/4QVE19rAauDlZ+rZaqjK9kT54zuMflUGcSru+NPfx9Pv/Bt449JtcbaxGrnL
 RVqiAjCTfhMVI3wa6PIFSSfQupa7IBFhINhd1U1tbxJsF1zYfh0W0uJ7Jw7ROww6TX3g
 1fnZy+zVQiA2Czzj2Fik8tHjYt7bpJG4KIszIcUQNz3C33BqOtWE6CnQYe5DxuA1nJ0B
 Kvc3WtQJgxsEg2MITFdeLJaKP1tgdaDiOF+kdAqCUYjr7ycDX8fCsqG0qV1ev5OeiMop
 p1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868920; x=1746473720;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3koL5YcaNhfuFyfmgiA4zQ3oQ2TQe2oURd+Ul39PKs=;
 b=gS3VTQBphtOmhUR4w4wXH6g9983LC17XDDDwlVfS8zNauXEySY//GjEkDlJscT2OLF
 gICV2Y6wY82IRFe3LXgFqhhqU9V2OlN9cXq5fORJyRONmYaP15D3HxcfI2jpd/BJMF9z
 YgSLFzs/gSnsj6Dc4883yJ99tJUTIvUjx6X8BmKCHyJXgHEjGp3pk7blZXBX3r/Bgl9Q
 mYxkPRPX1a7liJh3TaPal26WwPFxKGrJd6D6xeoazYLtQp/zr3QcP7IEBEijptVtJa2w
 LcGvbogKU8/wcvXuqTPMI1D2Cix7o4+dIxQDhsKLL/qRmIhpEGn6YbEp0tzZsVNOk9V/
 xf4Q==
X-Gm-Message-State: AOJu0Yy9lLxMb4RjwBq5Ve09EOCHfjFLRvsZ+eEiw5k2BMoXwKNhURGH
 Bb3Lz9iZnv+XoxJgDGZCLr/PTp/bMR1h9hJRAepOaeJ2GuNLtiwUDoESWm+DlA1zvKQuwI2BgLH
 C
X-Gm-Gg: ASbGnctK+4PZ2IoF0n2MUh0pPyl6JpNKBCB9ul5rV7x5T4gycTuL1WYq1i5GBN49wU3
 Kq8/0OWWrHvh2Zv1Rg+KjhUqWDcQzajkvqxix4st8JoVSLArkgUehA5rrPzpMzIUmk3ZfH0h0ec
 dCd6c+NHkthZuX4L8Oy53CebiXagjQwNCfIDHM/AsKj0/qVnYUtzSiLCsDQAYTDYaFw30AIvzla
 fIaosXfZaBSefT80QUlKvAMn4wZjWNIrY+6HlmmlLhx/h+NBcmOjQDQ/nXesoRwDVqXj9N2gpIg
 HaukbDlVVcudeF0cxFwEgx+eVjbDM9ZfOL4sXNwhUXKp9+KpG8tAPw==
X-Google-Smtp-Source: AGHT+IFhvvI72SNKWtKdFoZVMVjbSNn4SyyPJHtJtWoEcbBBiEh/YosjK0z6aNweqRZIBP1loCDwBw==
X-Received: by 2002:a17:902:cf10:b0:224:7a4:b31 with SMTP id
 d9443c01a7336-22de6bfdeb1mr5058875ad.6.1745868920571; 
 Mon, 28 Apr 2025 12:35:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22dc8463eebsm51449825ad.189.2025.04.28.12.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:35:20 -0700 (PDT)
Message-ID: <88d6e264-4793-4095-8bb6-bc45621abeea@linaro.org>
Date: Mon, 28 Apr 2025 12:35:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
 <b28bf347-aa8e-405e-8009-025aaf61a984@linaro.org>
In-Reply-To: <b28bf347-aa8e-405e-8009-025aaf61a984@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/24/25 10:47 AM, Pierrick Bouvier wrote:
> On 3/5/25 13:38, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    docs/devel/build-environment.rst | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
>> index f133ef2e012..661f6ea8504 100644
>> --- a/docs/devel/build-environment.rst
>> +++ b/docs/devel/build-environment.rst
>> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>>    
>>    ::
>>    
>> -    pacman -S wget
>> +    pacman -S wget base-devel git
>>        wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
>>        # Some packages may be missing for your environment, installation will still
>>        # be done though.
>> -    makepkg -s PKGBUILD || true
>> +    makepkg --syncdeps --nobuild PKGBUILD || true
>>    
>>    Build on windows-aarch64
>>    ++++++++++++++++++++++++
> 
> Gentle ping on this trivial change for doc.
>

Another gentle ping on this trivial doc change.

