Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA14E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiae-0007D7-Mw; Mon, 09 Dec 2024 13:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiaU-0006v4-U4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:34:34 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiaT-0007EF-3C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:34:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216585cbe1eso11167705ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769267; x=1734374067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G2zLiPGgXQEaFadu8MA2+2qctpCy0oHeZcvt2hXgyNA=;
 b=SLvh6F3yZyM9oxyIIsQu8JNcHWnvNXF4kIldFPFy1TPbtv3I0Kj8Q4bUifpwBaEmS2
 sfOaQurWO7YzMUYK7JaG2pbixKC2skh2vRoOlDnHY56ayxh9hdYylg6RXwI+NiEmzKxD
 +UrhKa2g09MuRk83tkqtWd1qhKKDXd/jAxEfvdCyFicduRMAQjqBgkfYsdWd0OzRHSlZ
 io+dTeUuVYAjzjbAdHNW6WP+XzmMS1wx0KV+8BKruQdTH3F+zFdU1gq9JzMCHun6sHJu
 t5MLGbHrxzJlvEexsc9ONDkqhSjtJzqmixznERTXf8ufnh5VEqlHqrY5lW3xG243Jfp3
 Hmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769267; x=1734374067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2zLiPGgXQEaFadu8MA2+2qctpCy0oHeZcvt2hXgyNA=;
 b=dtwgV0mc0zleZ2MWDOOCGZbLaQVRvVjQyz9s/uY1VIQof2Gro0MZVOGctk4uA0aDsO
 6vW6hiGxy2h1XVjTUDw20z4IDZSd2O0vsUcOuniOTH4cd3IdN08us1rV0NKQJ8E2uGp8
 twLeocRyR66g7N7vI0QGsrrjlHgS1H7zIyLLABi3Fgio7+jQtBTwm4RIrkXrkxnkU6VW
 5zXeDrqq/WoEY4nWhtNH7KFh7vUJfCXhciRIYPqZnTVk8jYpyFuW5TCIcSnWysn9vP+N
 GBfrpn+qE3VJWjsmdEPKdTSrWXt/Q/AfJVQxpzSp+Ve2iN31kADhUbjUm1qdwUcBRRFX
 dGhQ==
X-Gm-Message-State: AOJu0YwzweoyCjoTen6hte/7mXE9HI9D5V+KlYbYx2JVTurxi4iIkDKe
 gKjuguiROfND+EeRePT2CSX2rS2B7pHeBWJLj/EVn312sJLnmaKKMl8RVVt32ZY+8rCs+js0pvZ
 +cKc=
X-Gm-Gg: ASbGncuR+rCNM+3aP6wvUMl53GEUuIEqUl3mL2PuxdZBQYrRLvkYbU4aG6asNZwyq7a
 vOY81OAgns5LthHbJ08goFpH1D2WojeWPJIjQzTp+Bl6QfW7CAj3ADL2Mk4QyC0iRSHhiM65diq
 CsDpHKxiYnontp+O70RRHAXG1SSOUf4B1u61FqN8bkgIZ0K1eIvjmgXM6IuIT9A7Rbzi+6RnxOA
 +4xhnHTOiEBQfxbCS1fjV14DL72+CxXErdVptmqoLaA1QW4Wp77RMeqk4jUd9FFagKhVJP0stWE
 aTa5JcT5rfzUMDLWu2HBBGorrg==
X-Google-Smtp-Source: AGHT+IGZnlA9JHYDlml7GcJKweJ6kc4cNOwK2lLtKbBR8JqEc/nyM+EOM3Vd9lJ+4IV1sPk8eaaW0A==
X-Received: by 2002:a17:902:ec83:b0:216:3db4:5ec1 with SMTP id
 d9443c01a7336-2166a06bdcemr19963255ad.56.1733769267246; 
 Mon, 09 Dec 2024 10:34:27 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2162c278668sm43040425ad.81.2024.12.09.10.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:34:26 -0800 (PST)
Message-ID: <aab790d4-8a08-4170-acf9-66dc8d5d9e8f@linaro.org>
Date: Mon, 9 Dec 2024 10:34:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable clang build on Windows
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Hi all,

On 11/28/24 12:15, Pierrick Bouvier wrote:
> For now, it was only possible to build plugins using GCC on Windows. However,
> windows-aarch64 only supports Clang.
> This biggest roadblock was to get rid of gcc_struct attribute, which is not
> supported by Clang. After investigation, we proved it was safe to drop it.
> 
> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
> hosts.
> 
> v1 contained warning fixes and various bits that have been upstreamed already.
> The only bits left in this series are the gcc_struct removal, and fixing the
> plugins build with clang.
> 
> This series is for 10.0, as we decided to not include the gcc_struct removal is
> 9.2 release.
> 
> v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
> 
> v2:
> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
> - add a section about bitfields in documentation
> 
> v3:
> - explain why gcc_struct attribute matters in packed structs in commit message
> - reword the bitfields documentation with suggestions given
> 
> Pierrick Bouvier (3):
>    win32: remove usage of attribute gcc_struct
>    docs/devel/style: add a section about bitfield, and disallow them for
>      packed structures
>    plugins: enable linking with clang/lld
> 
>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>   meson.build                               |  6 +++---
>   include/qemu/compiler.h                   |  7 +------
>   scripts/cocci-macro-file.h                |  6 +-----
>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>   contrib/plugins/meson.build               |  2 +-
>   plugins/meson.build                       | 24 +++++++++++++++++++----
>   tests/tcg/plugins/meson.build             |  3 +--
>   8 files changed, 48 insertions(+), 26 deletions(-)
> 

gentle ping for this series, so it can be integrated when the trunk will 
be reopened after the release.

Patches 2 (has all the changes requested before) and 3 need review.

Thanks,
Pierrick

