Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1E7C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 11:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFtSs-0003HO-JY; Fri, 16 May 2025 07:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtSk-0003FC-8j
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:42:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtSf-0001X9-1V
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:42:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a36463b9cbso33263f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747395760; x=1748000560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHgtgWwRsR5xgsu0fuFKQp4h9kkDSHIsf/e1rlAxcs0=;
 b=o+gBshDk8PoZLOfDa6h1xGEofbJYENJqAcmZsRq3RfEOHYPG1n9cQcgoxxynjEpyuc
 kniK9uBnnV65r5q9J9oeVS9Ox6DCmeXN7hEiX3pQ1yyUvH/j9C4Y7R0KHmQrXMcfnFyp
 KO39NgKf0xo1VlTx/WdutC3qzM1UaNGeYefwhlYAe8zPkH2dJAjXRlBKiiMdcmsTTt6O
 DLrkSjyPD/j1HIeEhLWMhQJvSS2gk20VpIW67vxKlNttQicIqJjpSQciRFHijdY9Sm++
 Pt9VTVV35W6/nA27KnqzO16rm9bGW0MKkNsJC8Bdpk0Hn35gJJqaWOqNW5AVU8PHQ2S6
 iC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747395760; x=1748000560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHgtgWwRsR5xgsu0fuFKQp4h9kkDSHIsf/e1rlAxcs0=;
 b=a+YDjjLG/cy2hFZgyjqK5Zu3WKkpTVxbsyIQNiVbxMBgzT6HNQHALMwcQ32xgV9/7l
 ZWAP0KDXJYJkX/eB+kB2PvopJU0yaLbb8acfkFV4t04g/gnDMxcH/Ml8L2YkaCiM8Ci3
 8RcIh/eSHAkPp+pVWv+m+KuLV1SX87LD0ymU7tlLRyksUr9dbtCCXn7MlwNHj6aJlcbl
 vLi4i4mjlg12Dkk89Gvosc+kfBs/McPxQ9tszPNKJJBY4CL+2TVYIU69XDWWu8oxBlZu
 FHXODF1mLmD7qvl9W8xeuZtRAuqYe9PZDpvfk1EVhAizOxsoBx9R/nz9dSRI5pCzRIZI
 +LRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+a69U6HLNWbjzWoecpXnoK538xzikvtQgOcCvb2v02dyrbJnvTr4CDG6Jt3cMY7cd+dFxi/SZCfE@nongnu.org
X-Gm-Message-State: AOJu0YyfyeDAFXgBsFtgpBVvFbDMr8mNPBdb1+eHhXahjSX2HC+MWig0
 htsxwJ4JI+W/wNg957qmi9zg3G0ydm63LeSrxS8FaXIyENi9zdc6Ii6PzF+IrE1onDE=
X-Gm-Gg: ASbGncvBC3q+l+I2SkC+0jk7M7EZWwW2CQxJjUYQARSU80EYJIAoDe7fLQFs1ygsyBw
 u1jUznbjEugARGd4H3YmCgw04iUnxQfbnUxEVBKB6MGQrKR+IK2xfJhaivNYSKgvQXRgHW349C4
 wwzrxAhHG40NBRrqOYFmfjyr+KEzk5pncDTfyVc695xm+BRhSK0cxNNMUl7cCwGKVoiM5s0bE+N
 ysEgvNkAq4HUZ7kdawngCIUQXQwcxQ4W7NfZi5BK4lDg396tVnL741Itr4e+zgELSNDI7wI0DRE
 NjBOPs/QX40FZP1TPteqNs9WnvoSzZaEr+pxA19MS/wFXqwBs4pghyx7YMirNtUbJ7FCotLUdAw
 vuVANjBrYaN1g
X-Google-Smtp-Source: AGHT+IEx/y+Ws6moW6Tw0zr7OkYfNQAGZAFW4VoGZDhnhUZ//8Wr72A4Igz4LO2TJ9ULhMZPkE1Mzw==
X-Received: by 2002:adf:e80e:0:b0:3a3:5cca:a53b with SMTP id
 ffacd0b85a97d-3a35ccaa776mr2525538f8f.48.1747395759625; 
 Fri, 16 May 2025 04:42:39 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca888fcsm2661900f8f.78.2025.05.16.04.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 04:42:39 -0700 (PDT)
Message-ID: <8e6cdcb9-24f8-4762-831b-ce57f6e81b20@linaro.org>
Date: Fri, 16 May 2025 12:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: build target libraries with common dependencies
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, thuth@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250516052708.930928-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 16/5/25 07:27, Pierrick Bouvier wrote:
> As mentioned in 20250513115637.184940-1-thuth@redhat.com, dependencies

Use LORE link instead?
https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/

> were missing when compiling per target libraries, thus breaking
> compilation on certain host systems.
> 
> We now explicitely add common dependencies to those libraries, so it

"explicitly"?

> solves the problem.
> 

Should we use the following tag?

Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)


