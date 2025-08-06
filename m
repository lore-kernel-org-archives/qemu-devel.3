Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0EDC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 18:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujiRA-0007fv-Hz; Wed, 06 Aug 2025 14:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujiR7-0007fR-JE
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 14:00:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujiR5-0003w1-Rl
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 14:00:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76bde897110so216330b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754503222; x=1755108022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7A5YXZ4nRQ/Q2Upkjgp6Y8j4O8rizDbl91Jo5OXHnLI=;
 b=tKtk8AsEcroD86L5DG05BYvBUcYaHMthS98FjhrZ3tUpreuw/25jRbKxPHyHXt25/c
 Z0K5Szdg9hxbmIqnuH9Xr66krYjfALTJFBFlBVio4IGh+VEivpKYeWh4+ZSsnb/RMNkj
 u85MpVDtlJfBAiE/QDeihAoZx+BdffNgAKdsLAWOJbM0vd+FCqb+A8eYitDo8QCje/xC
 eb8VlDutExokFx6bdeREzIRq2nz7zoh9aM2O0P1FYnhUbynbapC96XefKtEFy/EKWGZF
 qEvjkhzPgqEGpJFL5oVdABEn8tILfUApDHHh7GLhLkgbYpsb/VikjuekrwhlRHPWD6HH
 o4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754503222; x=1755108022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7A5YXZ4nRQ/Q2Upkjgp6Y8j4O8rizDbl91Jo5OXHnLI=;
 b=KLW8U0n9rMaYzDsCR1igdFBXgi2uZKmk1Iay24sgNjrBTd5cGPVawnXO6OTl/AlkGh
 q8qzgUIYSWGp0/HEpNDCim89hFksUL5w/OOLC5pRtEvoenDYP9WKp1IEhzuU2AJSHR4d
 M257CkTrlNqMKWFsan+SKl9qLJ4AcBQry8Rxel+UsX+0baHvaUEw1BRw8zbOht6FGleD
 qEim+zAGf1B0WwS3zTtvciAU3rTv6lNgy7z9sTZihNSm+/8S2wsxkqJ5mhY+fNs3uODr
 lBAYaGjoBcvmfC8FcmF7Ibr9x5zKPKDvsK5j5pOmW/zsdvJX5Ctlvubed7uKQZohe/8N
 jeyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpl6FUiqfeOwnR/yC6YpgjFGNqVx90VUexRNVI0KdUT7XKEyNfBGCbHMtUxNZwxNSW5Lt+Zz0sBSQ0@nongnu.org
X-Gm-Message-State: AOJu0Yy4yrHwPvMLHelraU2NUzsPdhayfya+gE9XMk8B57CDX1E+0kxX
 l1CF58I+yil/FZJMmwznZzzx6tLHX2Eso9P0VN/7Mdt+ZFiYbGLg01C0OMfrQkcVTJE=
X-Gm-Gg: ASbGncs56yztS/tDzBO3bpY6vKsMDnE24sxDu/SGEGfpEoXrSpE4HfI5QqHkKeT8t1D
 84inB4Jw3YA7S23/Ie9za3QIPMXFDCFk1LO8dlMIYvZ5NH5FjXt4p+5q6c+tZC8yQgjuQDaR2db
 NgT8nLKARyDexNeAONpmC3RYCMxSZTakLyZXU4fP1kdKIbAIPMqCocBoR8ZWh8Vm4my1ZJyB1A4
 0oNNFYQUcqyO3aOCjVOtoAnLSOEdNLFKfERm0nNtLJmdNDSZ9uPBCN1U1MgN/uuX5imSHROKwF/
 /cG3ZMK7cWIW2dI8NZG/CtUZBBzCTNw9+2OaaGoWJtNE7uC4uOePPWDgbF7NYXfm9u6pMdpi7N0
 2Cdm7DwTNrEbQE6/BVL9GptGT/P83QGWPVWBBHWS0QUmkWQ==
X-Google-Smtp-Source: AGHT+IFw+t8vbHRLs84AoI+z/x+v8SYg4xK/hjAKAC8asgu0XTrhj6hkdh7T0W0yTxX7n4uYcU1iFA==
X-Received: by 2002:aa7:8891:0:b0:748:9d26:bb0a with SMTP id
 d2e1a72fcca58-76c2b0788b5mr5465679b3a.18.1754503221152; 
 Wed, 06 Aug 2025 11:00:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm16078402b3a.33.2025.08.06.11.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 11:00:20 -0700 (PDT)
Message-ID: <386a93db-ec95-447e-abfc-673c1b417f62@linaro.org>
Date: Wed, 6 Aug 2025 11:00:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
 <112b6882f9bd370deffb8637116fc44e043c250f.1754494089.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <112b6882f9bd370deffb8637116fc44e043c250f.1754494089.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/6/25 8:49 AM, Kohei Tokunaga wrote:
> Currently there are some engines that don't support wasm64 (e.g. unsupported
> on Safari[1]). To mitigate this issue, the configure script allows the user
> to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].
> 
> Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
> this flag lowers the output binary into wasm32, with limiting the maximum
> memory size to 4GB. So QEMU can run on wasm32 engines.
> 
> [1] https://webassembly.org/features/
> [2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configure | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> V2:
> - Changed --wasm64-memory64 flag to --wasm64-32bit-address-limit to avoid
>    exposing the -sMEMORY64 value directly to the users. This can be
>    considered as a significant change from the previous version of this patch
>    so the Reviewed-by tag has been removed.
> - Added a link to the Emscripten documentation about -sMEMORY64 in the
>    configure script.
>

Thanks for the update,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


