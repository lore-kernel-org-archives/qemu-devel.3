Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7E7EE644F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 15:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vayFw-0002mU-AT; Wed, 31 Dec 2025 10:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayFr-0002ln-CE
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:36:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayFp-0006J1-RM
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:36:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so54672905e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767195412; x=1767800212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QsWZLPajI+71x5/SmRBLa5qt/G3lyJj+ip5sBHcW2M0=;
 b=RFodFt0eyWGzrehwC0Rj5kyry6vPXl5OI9648w9OLnGHQwSSIkWbwA6KFeNtaPsL+P
 hpTwkU3BxSNpdniAbx8UDbSDEdMZIWERcrEU5xY3TxOwfq9XNLLug+n4+7eTiRt7JWZ2
 vs/RBrP9blDSgZ0AYS5JyCnbUkeNEDYchAxzxUFcmelHR72/JPlGJxmMYZJO7/w2nLKM
 nsWSfMT14KoaCuWB9v1kIuaoyfq9yezallwYc+CtL55+gAMgSA2B3aO4mq7HfjJ51RCd
 bMHjl7pXkZi1BsndliECDBrVGO8bbfKfBlv8yYwzMRx5k8M9bcFkWvsh3+STld55sLbR
 h7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767195412; x=1767800212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsWZLPajI+71x5/SmRBLa5qt/G3lyJj+ip5sBHcW2M0=;
 b=EqCahkRtHQyFqfenLrBFeN+w+JiAiWZiwaOfdJqQRXaVR1D3GtejUbH5jWFEO92Y5M
 ZAdJAkG3JDvAHjrccTYQM5lF/Lx6wc/Sl0QtPjHESvwT7mJWSFHRIJve87UtW8mRq3W9
 jjzYoP0YU5uYmUCq0KGOboETuOZ+4KfFQeSDkdIXYNVWSnm4YbnIV2acvEj4gW7sCcRO
 P2+gOp7f8uaKjyJvN0rKTTGsZY89Xe+vLTwSoQMn7cqExI3CflUb8ikWt+eNsfTasCGr
 pkAce161p5wx3OgHJxAP4p9lWhYh5CF4sg1rcr2w7aJkVDgaGimTiYEoInY7piiSMDQq
 NtmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5+SVC469qqaxzVIhtzqTywCWSy9uik9TwHUYd9FO1rSXl0+sIWGcXFsm/IDSujHTI4PtMOSaNSMbB@nongnu.org
X-Gm-Message-State: AOJu0YxFy6/9ZQfDUQN5PijtDpqiUXza1Rimg9A1jACO8X8WqQ9yw0IE
 zMizJEQmjMPZfxgwGJROXilLrk+c+9PfnpqM5AqpRBGGMxaZRN1Pg8pE5xJOZ8aeo3A=
X-Gm-Gg: AY/fxX7U0gh+Zp3tBfaDmiz5PaXetua2VxDniQjNSVld65lHeoEBYUZSNhCC/gN8are
 546ugb4Iu1vgCABPWZ4KHsCXBwHmmW9m+8UfJDnnPISOtxuCu4+EnR21e+AmAgZwtbeIqIq5i7p
 4NigCV2gm81ARie8u4/VCnlGn5mLZB9nLhHdmDda/zTMahrjqGm4yA5nqOzmMMRNde7u5JKEVaO
 +jECRsJJVgIj5/gqGTLaj+OASZDgKgtO8cJ0ErGtbSHLM6khONsJyxOsoVecfj2IMdFAEDwncKj
 diYZCklr1mQwF0dYlguPXVV9P2aY9jVFwFtKiyaK3LtuPlJji0ToQnCR4XweqsvwN0T/J7sUnv9
 JhBJITSfcK3AQtIa3GeIJ7u+pknjiDC1NkRG4Rn4uphl62CK3erT5vR6p7z+6U+v6GkWlgEp4II
 KO4lqVTaFdEgprvC4CmMwOZ3dNodfcTGwjqKxUjKvzDQTh5HkuGXp8Xyhc5g==
X-Google-Smtp-Source: AGHT+IFBsIvZvaF5tVxM/mNZt0gRPTQp79dE7bh4BGL9Q5NMS4GZoTYUyqfXIbAj7XAyVzlLdvKMUA==
X-Received: by 2002:a05:600c:4e8f:b0:475:e007:baf1 with SMTP id
 5b1f17b1804b1-47d19591166mr417381125e9.34.1767195412226; 
 Wed, 31 Dec 2025 07:36:52 -0800 (PST)
Received: from [10.33.60.66] (91.red-95-127-39.staticip.rima-tde.net.
 [95.127.39.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm632631705e9.13.2025.12.31.07.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 07:36:51 -0800 (PST)
Message-ID: <0909e0ec-2c13-4d9c-b6b5-e830e8efa63d@linaro.org>
Date: Wed, 31 Dec 2025 16:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] meson: fix supported compiler arguments in other
 languages than C
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-8-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251231073401.2097765-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/12/25 08:33, Pierrick Bouvier wrote:
> qemu_common_flags are only checked for c compiler, even though they
> are applied to c++ and objc. This is a problem when C compiler is gcc,
> and C++ compiler is clang, creating a possible mismatch.
> 
> One concrete example is option -fzero-call-used-regs=used-gpr with
> ubuntu2204 container, which is supported by gcc, but not by clang, thus
> leading to a failure when compiling a C++ TCG plugin.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


