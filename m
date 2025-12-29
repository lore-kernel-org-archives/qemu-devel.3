Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45325D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3jp-00039d-KM; Sun, 28 Dec 2025 22:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3jk-00037H-GG
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:16:01 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3je-00039R-Sm
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:16:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so73099545ad.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978153; x=1767582953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKMKqJQYyrUUIkxaP88yYVPDSzJM5zOVLpNDYwDFGvg=;
 b=WHQ8pWwpuHfRwqRRayiHohJro2ZY0bO3P4TPazwRHVmRFsBDi81IH2EKyqCHRZjTgp
 AIzsIa8IZZ94I0yN3Q/oiaDAtJUFV7oSbM4QUVkow2SEBMzw5v+5iGwFm+lDwnNiPiYJ
 fefBLxHcEHh4+1PcA23terCUFFn6zL5a4+qPXIfrCCo4uMewAO2nXHgX8f+o/Nq1oY7e
 24cVp+g0Il7XRIqio2oVQXTANG9nqqZVeo1kJV5uOonIq+B0PTRponvySKkBMSBuKaGt
 pf7c2lABiG7FhyyJCB5xDRS64jWwxtYTFGcOAUCiPXgYGB/S4RaTTplFG2YJGSu7omkf
 eO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978153; x=1767582953;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKMKqJQYyrUUIkxaP88yYVPDSzJM5zOVLpNDYwDFGvg=;
 b=dK75V9kUHNSVGwq+3lbob+m3UsJkfW7cxuPj+YQhI3yq+f6kb/NVZUI11vTxdy1Fxl
 JSzociXOsvKYK0iVOU1mjSrR5XxLvlIephGzt/UfhAskwH41BtjDop8J7+G1Ia56pulG
 JeVgYOpo0PqfBMVYkeNRrR1/nfMIpSy3Coz5wzabG4cMvOWB13YiuAsqNj8eMeBbo6b1
 mFo5Lx2+IjxosHicmtHxx1JEkUezHV0hJS4V04tUaeOUQ4A4oNR9/8vszc/a4+QtJSL5
 4s8EirxR6SAuhGIv6yXI2sCRa3VbfgC5WKTBBwJfWgr9tCsr718iW9rYDgFNFHOUhjUJ
 +RWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrt/IcSqu5DgM4L9QMQ/sfI0EcUTdG2IhhEv03I4F/Mr8an678zeL+96qRBW6NtyipHi7wqkAqthtH@nongnu.org
X-Gm-Message-State: AOJu0YzMAUavq0vD0rJ80Pa319NEpEpGs30/OVk9b3NyK2hn79EaYJ0S
 if2Zym2ykm2m1+M9caA4habfanzAawwoN+Z8rJU+/lbkmhnlGS4NNHyrQLTZm1awzTQ=
X-Gm-Gg: AY/fxX7GIZcfwThoDRj4ou2jTa2qu+nKPrAkF16iTLMq0cOc/RP3OyDZCzww+GkDlRt
 u44za9GR8nekfu22ZA1yZsKmAazzLGpQICAMWzqT/8mZrZAU/ViQY7bkrBlfZnG7ywHjoVNf+AT
 CXh3xXZJxBzDylZnjFFU0XmFL4kQZqTj8wAbYVR2fc3O/z+SUBgbjFhGsTxaUs02u0mutiwOwgW
 YXflrsKz0S5GNAl3nm1KeInyRvwW3bhWvD4woAo8li+r0caLT4QxYf27F76xPqp+XqSu8z8BgyE
 iBUacVYRQhxJ4BLI21wcSfj4E3x7/kiDK7YNGahi2r5UtimQBv6j/T3V5KBK05WtSNMghkR4JBu
 TYUBiP7fUfl45nOM8Nv8JJbTiX+OgFOguHkz6DDHqprSPMwdaNruUEOmwgksXtJq1637fty39tZ
 1eUXqnzQPZH6kmel4W/j1xOJJeO/neBtbrN0Vo9+EknakA/uc2vGNTFWGDmeX5moFkgWH25w==
X-Google-Smtp-Source: AGHT+IGKqA40W1U8Avc1hJyi/urzKlQzVZtX4QxXyTkRXd+E2dKm0efTHzid3bV6/AWSXXJEVfxTrg==
X-Received: by 2002:a17:902:f60c:b0:2a0:8966:7c94 with SMTP id
 d9443c01a7336-2a2f22262e1mr277605885ad.20.1766978152895; 
 Sun, 28 Dec 2025 19:15:52 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82bbesm262338685ad.35.2025.12.28.19.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:15:52 -0800 (PST)
Message-ID: <718842e7-b4f5-4f0a-8fb4-9b7504b40408@linaro.org>
Date: Mon, 29 Dec 2025 14:15:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/alpha: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> The Alpha architecture uses little endianness. Directly
> use the little-endian LD/ST API.
> 
> Mechanical change running:
> 
>    $ for a in uw w l q; do \
>        sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>          $(git grep -wlE '(ld|st)u?[wlq]_p' hw/alpha/);
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/alpha/dp264.c   | 11 +++++------
>   hw/alpha/typhoon.c |  4 ++--
>   2 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

