Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43966C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesPv-0007BJ-7J; Fri, 16 Aug 2024 04:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesPt-00077J-Rp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:34:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesPp-0005by-OO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:34:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37186c2278bso973569f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723797272; x=1724402072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rcdVqiOHn2SOCfjcoFBldMGuyRVl6Cw86IDGdXt6peM=;
 b=coDoEJG4Phd4KULnNpnv2jAMLtCuAHZGHomx5Ssx5L7ITVQNxldDFTlwLK0RNb808D
 FIbAeZMpE1PNZKi7WlI33JztlbhFxXsZf/GzSnWY4jXUocOxGMsaLgYKwdanEXnmveiI
 zYTMwrCevqvYgGi3uDFRBdaQjSLEKOJWU1YMRegx8hYk9HANLL/DFEns/ETT7I5ImE1D
 A2fHW6jp+wuniVQwHlVC9Opc420VS6IzkxOJyTKzqGiGxxFwmbGLlzXWV9bCUUYoyEko
 GZnM6uzuQ2eUiJVAsnv/gsPvH2+mcSDWdznTUOQIUwU9SjTNdUS191wzRiyKHziXrIDx
 lDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723797272; x=1724402072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rcdVqiOHn2SOCfjcoFBldMGuyRVl6Cw86IDGdXt6peM=;
 b=XqJZZbzKRu6+6emaRgDqFoENp1LtezIkx/T493HHtxGrxz88h7HwPEBWOxD8hMdtkd
 LrBMflWzWogDVYL2BUCjRpgJVUWDWiE6wGxhJ7tE3xAEkbtvze5pg+Csph2h9cA8mFbm
 ajNumt4Q83Sb6mWPqbJyTShaKDfpdup0U+wDsSWWJlQIoQPdu7DZaBpZStZtim06tj/z
 HR8WGYf5/1JrDSRVngM+nMNg0fazK1MZpoNhi9skhB7TU05wCeuwwCuPFIIgvsW9gen5
 A85UmRICuRi+efMvPeQvuI8R6IM2H3aKBbYxiN/SGjt0q70ftOzrJP2/qzLGxX/f/aZs
 TJeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVymw2u6eydZAHqABfj3DuovojweROUkHF59clg73jZ91Qon/xP86nJCCvnX7xtdNMsNMEScDrFH8Oq96vXD/lteqwt/2w=
X-Gm-Message-State: AOJu0YzU3Imjnbjrck6geOk8QpcVUl3/a/6RcUA9qtJfbeDmqwAo5cUQ
 098xOeMflk11aK312+Y5zlO+M++hWduklUZJFT/PYC7yBMNTPsLTDJA3eQNmMyg=
X-Google-Smtp-Source: AGHT+IFShy4jd5WRvAhSKtqzWxwMatyTL980wx7NZ1fvES5RCsQmd++fHQBzYM9IFJt35z65kOfN3w==
X-Received: by 2002:adf:e6c3:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-37186d740a7mr4078144f8f.21.1723797271841; 
 Fri, 16 Aug 2024 01:34:31 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded71ed8sm70447235e9.31.2024.08.16.01.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:34:31 -0700 (PDT)
Message-ID: <6f009629-fbad-4868-bc12-21a18de379b5@linaro.org>
Date: Fri, 16 Aug 2024 10:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
 <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
 <Zr4ZbOHR9Sc10YSX@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zr4ZbOHR9Sc10YSX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/8/24 17:06, Daniel P. Berrangé wrote:
> On Thu, Aug 15, 2024 at 04:01:17PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Manos,
>>
>> On 15/8/24 13:42, Manos Pitsidianakis wrote:
>>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>>> provides some declaration macros for symbols visible to the rest of
>>> QEMU.
>>>
>>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>>    MAINTAINERS                       |   6 ++
>>>    rust/meson.build                  |   9 +++
>>>    rust/qemu-api/.gitignore          |   2 +
>>>    rust/qemu-api/Cargo.lock          |   7 +++
>>>    rust/qemu-api/Cargo.toml          |  23 +++++++
>>>    rust/qemu-api/README.md           |  17 +++++
>>>    rust/qemu-api/build.rs            |  13 ++++
>>>    rust/qemu-api/meson.build         |  17 +++++
>>>    rust/qemu-api/rustfmt.toml        |   1 +
>>>    rust/qemu-api/src/bindings.rs     |   7 +++
>>>    rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
>>>    rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>>>    rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
>>>    rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
>>>    rust/rustfmt.toml                 |   7 +++
>>>    15 files changed, 493 insertions(+)
> 
>>> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
>>> new file mode 100644
>>> index 0000000000..51260cbe42
>>> --- /dev/null
>>> +++ b/rust/qemu-api/Cargo.toml
>>> @@ -0,0 +1,23 @@
>>> +[package]
>>> +name = "qemu_api"
>>> +version = "0.1.0"
>>> +edition = "2021"
>>
>>> +license = "GPL-2.0 OR GPL-3.0-or-later"
>>
>> in particular explaining the license choice.
> 
> Semantically this is an overly verbose way of saying
> "GPL-2.0-or-later", so just simplify this.

Indeed. Manos, please use GPL-2.0-or-later to keep it simple.

> 
>> Should all rust code use it?
> 
> GPL-2.0-or-later is what we expect all new QEMU contributions to be
> licensed as, regardless of language[1], so this looks desirable.

Agreed.

> 
> With regards,
> Daniel
> 
> [1] unless they're derived from one of the few pieces of code under
>      different terms


