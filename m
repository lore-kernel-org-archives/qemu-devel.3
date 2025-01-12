Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CF9E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX2AB-0003Pn-SD; Sun, 12 Jan 2025 12:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tX2AA-0003PE-BB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:54:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tX2A8-0002MP-H3
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:54:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so80422025ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736704451; x=1737309251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fzxb0sgdtCfKQ/OD0YQlOf0rYr2aPsdk4YLcccqisHc=;
 b=Agi4dFUKhPOko770hNFpbDqbatqcH4Pq9GZjw+J3BiM2aBPUNlKLibFPhUenxx8LT/
 nPIS4jtnrngoJQgfkByIz3xzeGLhB6csMQjbqe/eCT9aItI1jBv96fwJnubkjg1SGYOW
 iAyTM9QwqkKRlTreXV90qXRBHduxfIizCbtVABV+SwROsEYboc0b8oCNo2rLGbq6Df0p
 Ut0hy5ulx0kPW4FcVGX4RVbuVl4Nv12NMbjyQb17yIdqq7wkIq8QKRnGvqZhy6nwIOGU
 VgMBREdgOkDLO9V0MIgcvZMWO/8ZjtVMKBrdK0RRNEkDmUX4Y+KwI8d6MAF8KQkqNBcb
 rlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736704451; x=1737309251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fzxb0sgdtCfKQ/OD0YQlOf0rYr2aPsdk4YLcccqisHc=;
 b=GC4JhBLCUXeLq0R7SZgMeU7s72blIAyh4OeewgnPQbNRsavWfmSfGkV6K4i4/NNsP/
 xHMDKxQlMRm9IJhGeJ6fa1yZmOscrTQ3XBE77V5RoYh4pUsA/Orfnq7QAokskrayCpFh
 EqBSRX7InngmNHa1U8Uw8D0B3rARX9lzrPN+XKpEDzlPlrrQ1k47nH5XSAZGxqXxgOYu
 7o+dNwFP+wp1CJtf2/L50mUhQaUfMOexqrywnGiUMGjax+4mjot9m03XKeWx9DB9kr2z
 P1cKQUq6A5dUUHuctxNSRWvtzaICUZyR3SD05kEKliGLzeX5BF/PIp/0Y0yMm32Ir4A6
 5q+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTKFlS5GZRLQlT0HyybQIjJbOVrS6uxrZIJbv4viP2Yp5ZLfqbSXBK82Q018i1hyo+ZUZ6xYXzi54q@nongnu.org
X-Gm-Message-State: AOJu0Yz3xgNKIbN8LJSFQmlM1H3Zy8SO6n0fYVs/Ymh/c0Rd9usCvnz6
 f/x5kAU+8xQdAZaL7afOlLYUbRie5yAn70oLN14UpMeUwWZ94jQwDNhjF3WTXFQ=
X-Gm-Gg: ASbGncu3dmikIbKbLNXaSuG2fBbxehvx2BgyJlAEDkb6S1X7YRU5tC1aAFQ3c7IJZH3
 rny6JvPtCvVJrUx/XqaHAueec9lzBXhWFUVjvFG/WLQb7DheYw+ewp5uXKeCzhmHQzUCca715kp
 bVuFquHVsVXV0SgSG1HK9pysf0nZ3z0u/ibJC6wOC8/6GHz9BS5FEjuloUwmkIKTbJ7XYZptOK1
 91B5+m7+RKdW+FW54Dp2hsXKjOm0CyZVyslXNFKH8L475V6GoFNSDXqsdzfU9Rpw/jtyA==
X-Google-Smtp-Source: AGHT+IEPXhDEImLLqXEXMfoET03kFcIJApZA3YZ+ozjO5tw9IhBekdlU3ylINdD9lVx88/wCrmlhZA==
X-Received: by 2002:a05:6a00:66cb:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-72d3021368emr20558424b3a.0.1736704450945; 
 Sun, 12 Jan 2025 09:54:10 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4056a5d2sm4639297b3a.50.2025.01.12.09.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 09:54:10 -0800 (PST)
Message-ID: <626ac26e-840a-4d0b-ab40-aab8499a4287@linaro.org>
Date: Sun, 12 Jan 2025 09:54:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Content-Language: en-US
To: Stefan Weil <stefan.weil@weilnetz.de>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
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

On 1/11/25 14:08, Stefan Weil wrote:
> Am 10.01.25 um 21:33 schrieb Pierrick Bouvier:
>> For now, it was only possible to build plugins using GCC on Windows. However,
>> windows-aarch64 only supports Clang.
>> This biggest roadblock was to get rid of gcc_struct attribute, which is not
>> supported by Clang. After investigation, we proved it was safe to drop it.
>>
>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
>> hosts.
>>
>> v1 contained warning fixes and various bits that have been upstreamed already.
>> The only bits left in this series are the gcc_struct removal, and fixing the
>> plugins build with clang.
>>
>> This series is for 10.0, as we decided to not include the gcc_struct removal is
>> 9.2 release.
>>
>> All patches are now reviewed, so this series can be pulled. I'll report that to
>> MSYS2 too, so we can enable clang environments for QEMU.
>>
>> v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
>>
>> v2:
>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>> - add a section about bitfields in documentation
>>
>> v3:
>> - explain why gcc_struct attribute matters in packed structs in commit message
>> - reword the bitfields documentation with suggestions given
>>
>> v4:
>> - edit for bitfields doc requested by Philippe
>>
>> Pierrick Bouvier (3):
>>     win32: remove usage of attribute gcc_struct
>>     docs/devel/style: add a section about bitfield, and disallow them for
>>       packed structures
>>     plugins: enable linking with clang/lld
>>
>>    docs/devel/style.rst                      | 20 +++++++++++++++++++
>>    meson.build                               |  6 +++---
>>    include/qemu/compiler.h                   |  7 +------
>>    scripts/cocci-macro-file.h                |  6 +-----
>>    subprojects/libvhost-user/libvhost-user.h |  6 +-----
>>    contrib/plugins/meson.build               |  2 +-
>>    plugins/meson.build                       | 24 +++++++++++++++++++----
>>    tests/tcg/plugins/meson.build             |  3 +--
>>    8 files changed, 48 insertions(+), 26 deletions(-)
> 
> This nice series allows building QEMU for Windows with the LLVM cross
> compiler on my ARM64 machine, so you can add
> 
> Tested-by: Stefan Weil <sw@weilnetz.de>
> 
> I only needed a trivial additional fix in scripts/nsis.py for `make
> installer` because the usual GNU objdump and the LLVM objdump (or the
> cross x86_64-w64-mingw32-objdump in my test) produce slightly different
> output (indentation with \t, indentation with four spaces). I'll prepare
> a patch which eliminates the need for objdump, so no intermediate fix is
> needed for this.
> 
> Stefan W.
> 

Thanks for testing it Stefan.

Once merged, I'll share this with MSYS2 folks, so they can backport this 
series to 9.2, and enable clang based environments (including for 
windows-arm64).

Regards,
Pierrick

