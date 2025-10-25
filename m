Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C15FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCiX9-0003Sr-FD; Sat, 25 Oct 2025 13:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCiX7-0003SI-1C
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:58:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCiX5-0008VQ-0b
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:58:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so667554066b.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761415104; x=1762019904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QFIs2Aa0aI2/4xr0LydnbBXWZBqgexMa2+DBnxdrxyg=;
 b=wcv2fplwycv27d/gRdGWI1VyILX6OCFTWfzKOyJUlPV+PLZtJb/apsquJZ+4MGhiwI
 QaS0s64dqI4TvFKKk/dX9LlSSkv8ugH7FdX/grk3WBl5MBnsjARpgVG4PSDiIfs5n06a
 XHiYUgEflPA/c/IfkOaTfyPyDAwVPFT98clasp2a/YxFLBKcumnfnifD/55x8ViF6EHA
 CAKcoH8ROUk0cDT69pJXfqap4mXbUEvci+dLO0GQOmKBtMB3+vOOmCIzib0j7BixVuu8
 Hny+TNDjsTEYt1FrS5+2xwvFwX+Th9xRNhv3od+QZOpn1oiUnXqPEGyl5X7I4Q/bfP0e
 yMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761415104; x=1762019904;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QFIs2Aa0aI2/4xr0LydnbBXWZBqgexMa2+DBnxdrxyg=;
 b=pmrCm797xw5N/E4qx1lVJ6mH7+fWHpw2x1tFJVRw+gsWvGHXV9nIlwEX8UqlNEWb6L
 mN0sJg8kZd3WlC3zCE3yrCh3sYcjC5uI0XU8C1rch33+17eESF+QzXO4q0U8a5Hthblv
 CSOK3VC0H/yybeLxKLkXY3XS5h3Gy8W0fEkRwLvsTxm4esga3N5pYGqwlHHJ46/c6iuq
 Lvmsc8J4xrdyVqIgO9YhOGV+Z3I5ppqs5CQ6weJq0IiIZWCbI3inVRT1WbqtoCMNr7o1
 jaxrFjhZNHuk+O+1Q3La3CGqkvktVfGeucTZ7+s7PTSV12TPoQFqsQd89N22shN2IZko
 fyFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9cE3t1CL7QzWarSGG5PYymAcgDo4XFe0+HKbjw7tp60j91uKKCliDTcz+p3bWqmJlio4LBpdXHMrt@nongnu.org
X-Gm-Message-State: AOJu0YwVD4/TmJNxKrdOh7GEhVcDCn898m32PoyUA695cB//RFD6DBk1
 JX6Crpt/X0D5wGujTNLouBylDYmy4PNpdB54sZ0R8aGcWhxq0KefSYGcmLBIsvWoHGs=
X-Gm-Gg: ASbGncv4KANojWWNxvKREYoXclNC7A7+Fen51bPh+la1KtOSgE3dhPGBBmCrhD+5HLf
 NV7q+aJL79qm3RLlRLSj5O/1JTZnLCQQFE8ZOVwbEgj0wc0e2fWeXIGtW/QDVAGCDNbLJX0SSPq
 FPGXfBJWlIYXNvZZgRaTypDRJs2JlCZJtcFXPddi3SU5PLnCXq7t+1MKauXR8vEtC2S8y8DchNy
 1iOn61o9snBaFMvBbkF5ZPrJJA9wsEg0xuhjGlETmi3sUeCwK5+l0zyK55ysB6EIj1DZRMFNqmJ
 C+0z7vEX2sHSFdf/tK+xeJLkeJX577loyHXkzAOuXdruoipUOo6AIBjHrnm67w0i8jsymzI+rL5
 G56R604W9rAI5eWeRq88yhjPh9xmfBQPcqFCxpwkT2Gg5y0fcOUiM2/CZEZE/bLnaNuZdP61BDr
 NGomSk/X/tdJtWli6m4t3Hq7REQjIKDYGpyNIMFrAhuE0vgtk+Xf74enNqnu6K+NI=
X-Google-Smtp-Source: AGHT+IEqh8jL4doXcjbQNxwVOnoAjxtsInT/xpdy/Evgs+4e4UT87trcvOYQ1VACfrEnVZAuwdK/Dg==
X-Received: by 2002:a17:907:9690:b0:b46:8bad:6970 with SMTP id
 a640c23a62f3a-b6d51c05e68mr1097295866b.36.1761415104122; 
 Sat, 25 Oct 2025 10:58:24 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8544bb38sm251243766b.67.2025.10.25.10.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 10:58:23 -0700 (PDT)
Message-ID: <3e2412ee-57c2-4222-9188-33706cc6ec95@linaro.org>
Date: Sat, 25 Oct 2025 19:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 58/58] target/arm: Only allow disabling NEON when using
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023123142.8062-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023123142.8062-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/23/25 14:31, Philippe Mathieu-Daudé wrote:
> Only allow disabling NEON when using TCG.
> 
> This avoids confusing user experience:
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

