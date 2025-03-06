Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E7CC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBvw-0004iZ-H7; Thu, 06 Mar 2025 09:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBvp-0004hw-1U
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:10:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBvm-000182-Gw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:10:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so6028275e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741270233; x=1741875033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3N3jOAswvf2wl+FuY9ZEt4T95D9HJXsmhLo50SWJcs=;
 b=cQbkJWuBZdkEduIsr4SncdBxtOAfVFeXF1UNRuyRSKENSZ5+Qgu4BP3I0j9dvSKZzf
 qjx309SuUD+kePkZwFU3QOERqZAzF3Bfcm06GJ+SBhO+SyxFZ30x4Cti03VOQ/znc1rj
 R44IErGcxwyLTnt/P5EyC47afJ6Mzo/9kIrUe1fSSo2IC35D0U0Ou9jVoMIjlBonVfdq
 rpC+pz6IaDfttK1UAHbe+VgkswUS+TkQDGhZEmI+32Y7UP3RDLxRIN+CWBELV5juKwxF
 6VAek4loQbTpJesHDumScYQfRqwopunWZUL7XJDUTiKQhjzY2oISKz6Ty+IrMr53U4Md
 ntIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741270233; x=1741875033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3N3jOAswvf2wl+FuY9ZEt4T95D9HJXsmhLo50SWJcs=;
 b=vtYlScaM02e+Zh+oas1tgGyunuKrw0l03HDgWWj/MGSEcmw2D0hN4BuCGOxMddB0Ij
 c1xhzCkfhXOYd7ViuCXyA56BAYJz1gWMJV6w/h1dy/5L4Vc99hQY0qvP9Mt76v41jsQm
 zCLdfMTUoFTsEpnEp1Q0PeKpLRdCDHyrl5Xt5RazwL1ImdiQO4h+N99d24ZlPrdQkNCo
 o5pRFlQifEEcIBWAfcJDqukRZcfd7kw/jPJ/bBsK8aVO92oTNMWSRPKs4WwBLXjq+JbN
 FB0GCFmfMN4e6tOitYqFFl0Yar49n1AOh4rO/fzcjDrT4A347OsDlagnLXQdPg784F6m
 B0hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7r4D5HDYPN+1zIhJMyboXnnqjr+e7zHPa9v2/Tw+/IywXZ+ugMrt+FGIewXntcQmJtEhpU3u3tguc@nongnu.org
X-Gm-Message-State: AOJu0YzS9uVWKwqLbMJ6llhCvbKD/62NFvvPO8s+BQjrxSdNfzCHXIVk
 LVOIXt973t06T5ouaVP+lP2Wk3AQPQ4xazToAwvXLu5il/UChywxHbek3edO+ek=
X-Gm-Gg: ASbGncvNg+O/R+7z/AMhpJa1LmSHajxZkY0qhIQf77otzGGU7EHPYuQGU8B/24G/QWs
 CypBkbxR1mfO7QvthHHfipa6nYgAmJoInH1I/0Q6uZ4AtWHFroP9m9yE3rh2o32EAZR5ElgoKjz
 c/x3aFrf5fSBMhrB0cpagx9CtZHrVIURz6XBxGwZtvtzpv8g0/jRvUI1WU6PksT5DX33Gvr/bBz
 08+ivLW0qyZgWokjPHCpSmszhYqAHEDD8L4wirIWsKOyQ+75H6p7Nx+1lTZqHEXCCvGFCXMZMT+
 tHmA2ZaG2afkWvuJKvJSVwoBMEPwaoNau7+DTlAUE2jVBBh/hS/gQx2U0KmrL9mgaOZoVbKaymu
 gvrrxKjtqdiwl
X-Google-Smtp-Source: AGHT+IE769Tu9MfMLa81qmq5z48H2VFeqp7n/cQAgRUX7L0Fo0aAOKDnob1EWdhtV6iiv0d+EscGsw==
X-Received: by 2002:a05:600c:190f:b0:43b:cbe2:ec03 with SMTP id
 5b1f17b1804b1-43bd2aeaa86mr57556155e9.27.1741270232828; 
 Thu, 06 Mar 2025 06:10:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd948cd0sm20476385e9.38.2025.03.06.06.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:10:32 -0800 (PST)
Message-ID: <03dd0e4b-069e-47ed-b5dc-259c3ff0ceb7@linaro.org>
Date: Thu, 6 Mar 2025 15:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] qemu: Introduce legacy_binary_is_big_endian()
 helper
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-11-philmd@linaro.org>
 <195b3558-3cb7-4a14-b9ee-5ba11ad0d333@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <195b3558-3cb7-4a14-b9ee-5ba11ad0d333@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/3/25 08:28, Thomas Huth wrote:
> On 05/03/2025 16.39, Philippe Mathieu-Daudé wrote:
>> Introduce legacy_binary_endianness() to return the endianness
>> of a legacy binary, and legacy_binary_is_big_endian() being
>> equivalent of compile time TARGET_BIG_ENDIAN definition.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/legacy_binary_info.h |  8 ++++++
>>   legacy_binary_info.c              | 43 +++++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
> 
> We already have target_words_bigendian() ... why do we need yet another 
> function?

target_words_bigendian() depends on a compile time constant that we want
to get rid of: TARGET_BIG_ENDIAN.

Also, since vCPUs can be configured in different endianness, both the
method and definition are misleading, what they mean is "the *binary*
uses BIG endianness by default".
For example we can now build a TARGET_BIG_ENDIAN microblaze binary
with all vCPU core instantiated in little endianness.

Since unified binary won't have particular endianness knowledge
(still, machines will), I suggest:

target_words_bigendian() -> qemu_legacy_binary_is_bigendian()

