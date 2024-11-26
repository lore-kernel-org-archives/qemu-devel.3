Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96734D3B9B6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFy2C-00024m-0l; Tue, 26 Nov 2024 11:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFy28-00024H-Qt
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:03:24 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFy27-0006zt-9I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:03:24 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29666708da7so3576056fac.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732637001; x=1733241801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e4l6lidd35aek83XSiB+Rgegb1aCI14OBMRMt0aGwns=;
 b=W7rIEKfeSpnxzFWSr25WX47E24TWy+e9NXbsA1m712BPkiZyBf3Rt0N3by0zvLozsu
 MOA7jDkV9p3edV7kw+/odcAat1GchGxbopkYLRT7yXGNiobLoqUR1m56IIbxkDfioD1/
 6AOrAIZ2nTbIdmt3lzs91TFjp0K/CQBLpd0uKEpOh/alXE9GgzIDvA3xb7qhhFoV+JLh
 ZlSTzh/PtEJxn4YT4LZwwLOPoukXa77Fy/wzwlgDyYBzbV3AzQc4RLXHETBDvaUS7gYM
 lHUw0nWiAnoR0E9jHoupuyWKr7U1bGuVIi+q0IKbS/TvCKhnsnHPf0Y2szKQDQlHmBoY
 zN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637001; x=1733241801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4l6lidd35aek83XSiB+Rgegb1aCI14OBMRMt0aGwns=;
 b=jJqArOjglLlO9hjFovvLwNDWIjL6+Cop6VZc6E5LNYUzjn3dImYrLwpLnHKfbhmrcA
 g/WIhJbmQX6oKcHF+lVnKkjfWpsA1jzTID6cTre3Mhd0wvZokkiGWza5BTJ9mIv/646x
 oWvhj7zK0HPthjuaeWHDDd0peuJIl99qUl/VUyl+TyZWJhGbauOAubkR08MFSiOp6MyH
 tXOcaUYmExQ9DQNLty83kmd3d4yLKaLvrgrW5dibZRGh/LZXRFZGiXnZkCuLOC891etp
 SR3w7VtYA5cPP/UgoHsYuDfjY/6iRZw53qkfwL6K9bdS2sWAvj/vJ2lZVcO8oOS79JH8
 mxKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNXuzmje2ObG3DyxbeJ2h0vnp/55TwOFCKyDhWPJ5loU2WqMOVBJ3HO0e6sfaFALlkJg8rBOyzvCFC@nongnu.org
X-Gm-Message-State: AOJu0YyeTqyHU7T+7aYhO7XqfiosEMLBn4tD7BgqniU6H8RJdaTNVuI7
 RV6Z9vKENWvibi9RDU/h1YWxyuILhMxoX4iO2HELGx9ZHPdcDzR7vgTOyOk9/Es=
X-Gm-Gg: ASbGnctkzDtOHuoYQRo6ztMg9NhEpWX3RrrNI8qhoznw+KSXrx7O8Ks5UJG0+K9WuL8
 3POgGp5R4yQHCzQ3wZRkDZi/kqdceiOPCO57zyQw327PDCNOMWN4hnHnp49DDONj10jdNwn+06p
 MVteldAODsMOnU5TJaXvVvdkAp3fYr4byhsMVHCBdifC4FSVNCudhgBYsxO7vPDcYVtLdSQk0Qi
 buIahfgptxBW+2Rb10Xdjlh2E2Q3vTHOKG4fL+0ygLOn2hsJ5Se5uHiqstEnPWGtA==
X-Google-Smtp-Source: AGHT+IHyVmmJF7SiIfgnw2nUmdOnGcgaFLHxR5wAEHN/Ixdty+FS3iyb+jowiuxiZ0fPkgiKh1TjKQ==
X-Received: by 2002:a05:6870:701f:b0:284:ff51:58ad with SMTP id
 586e51a60fabf-29720ddd327mr16498282fac.27.1732637001386; 
 Tue, 26 Nov 2024 08:03:21 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03772e20sm3050849a34.21.2024.11.26.08.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:03:20 -0800 (PST)
Message-ID: <a24a7a4b-8f6d-428a-a148-5a5444628b0e@linaro.org>
Date: Tue, 26 Nov 2024 10:03:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/16] target/mips: Call translator_ld() in
 translate_insn() callees
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/26/24 07:59, Philippe Mathieu-Daudé wrote:
> Historically we were only calling decode_opc() from the MIPS
> translate_insn() handler. Then variable instruction length
> ISAs were added, we kept using the same pattern but call
> yet more translator_ld() in the callees when necessary.
> 
> This is cumbersome and bug prone, so better move all
> translator_ld() calls to the callees where it is more
> logical.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c               |  6 ++----
>   target/mips/tcg/micromips_translate.c.inc |  3 +++
>   target/mips/tcg/mips16e_translate.c.inc   |  5 +++--
>   target/mips/tcg/nanomips_translate.c.inc  | 12 +++++++++---
>   4 files changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

