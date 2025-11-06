Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5FBCCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGyA6-0007F5-UO; Thu, 06 Nov 2025 06:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGyA4-0007E1-Cb
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:28:16 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGyA2-0007S8-CA
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:28:16 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b7042e50899so140073166b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762428493; x=1763033293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q9U5GEp3pqm8j5sz/qTL1lCcL4PS6RZ2QKQbKF9zWSI=;
 b=TDnKt/tU/5RwwmTl1hrAv9PqPEfSzE5XKK1SpdtFSsjCpOU9iL2wf+KH/5ZnbDehAM
 dV4RoEauw1iYCKdXS/CVkNfzVKWmgijyvwO6fy0kkArzyWX7SZE8hKPtKk1Qwy0qjlEL
 14PFMlEi8Y4PCKScesJ+ifWjbmJJ6DUF/u8cAZF3hQcfVbv1ZNNS3CjTsq0pJEKd6dIX
 32nx5h+vjeEF7wdO7wdACc3cB9lx4DzqZSR/AgfvL9RdU48oRvmPFmwF0HiyrkTvruop
 EKGF0IIcK4GD4pQ9Zjsq82UWR9biDqqXapU6bw75FSF7oyn1uDGnvOtu1+xCJU5g8aGZ
 HzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762428493; x=1763033293;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9U5GEp3pqm8j5sz/qTL1lCcL4PS6RZ2QKQbKF9zWSI=;
 b=NrcGGWT0ogM6p2K845ZVNI4UlkbJdUkwxdeQlGqB4R9442887OBirphlSgiUXxfCEg
 jqj2FtfeFn8pAO7jWnMUJj1cVtEuObzk/lExgsG/r2TtJuDVzYgnXTo4GzIsC3aHTUAs
 ZsEoNeoHRY7CO+ctaWXHaNTadFrhDiy1778M3pLWiFQtsEzJ0fRtqyqde5swtZHW6O/y
 Hq7W6jAiqVLvlQj0okFjD2mjFMwyJgJqpQ7t9XovJ4ykBLjuORnf4PLGrijxAhSx+iUE
 8legp1d2A/DzSVWBWn0aZITCRnU7fUzxmRL0LsFSK0LQvSHB4apVevUYuQCsZxFcSXIW
 i4Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjYMet6QpPbfFSsQR+I5QBagm9LmuZAcapINT/iFeyYrlMQ4IDWkwj2MWkbokz0pY4a9zD+OsOKoDN@nongnu.org
X-Gm-Message-State: AOJu0YxXcsglWfzjJ7ioFCwhbh5BVIl3FmNpPczwnWocX46+Xbxbj+FT
 2eYddwtaDdj0Hiwnm+3ejw1wL7JBK97zkUlrJq+bqZoaV5ZicGrLS8AVdimoANzuPyQ=
X-Gm-Gg: ASbGncsRt0CmqWDooF2bUnrkz7raILQV1zWI648K8St4gdnMGno5qptD6ZR3sNfGkGI
 UdYwdss+x++XNrolIgtQM3TrLdaqxaUg40D8wVpIsvX9XHT5f11bsE1gCdrRQ8m+lIdfxZ8I6LU
 Q0bUtv762J/D4ySC7lr566USa4OZjy21HIkKugL3Li88Kc2iIdy6MorEgixLX4hptn4VsdnCrpC
 6zSMkHMLNKiRVjqbBbJfk0T9G6jq+LCmfMIL6Fw7+Z9++IoIJMpPeJxvwlcm3t9kRrWxpS6sBPA
 JL+cXo9EQlDlAyX857gRiho1DYpcmDlRpfO6flIIPO30aKhF0y18Aj/CNj1S5EGiouXmBex0nTC
 rpMaHj8HGG73q+OhOviEz0zcwCzXaUO9DcmNFy4eFYTRch/GAQUCWvczXUemxZe8nqWpjma/2r6
 1x6P6xhF3gH3gyGJkwhOY+CaAlEkY=
X-Google-Smtp-Source: AGHT+IH6bpuYIX1kpQ4zGlpQZnhKzhB32H7yplnPINZVZWs2RkBlEjhWE9gmtG5QuIAq1H4Kxt6p+Q==
X-Received: by 2002:a17:907:2d14:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b72655b73eamr656595166b.55.1762428492766; 
 Thu, 06 Nov 2025 03:28:12 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289684873sm192018466b.58.2025.11.06.03.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 03:28:12 -0800 (PST)
Message-ID: <dac450e7-e22e-43ad-a40f-690753e19813@linaro.org>
Date: Thu, 6 Nov 2025 12:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] tests/functional: Mark another MIPS replay test
 as flaky
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251104145955.84091-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104145955.84091-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 11/4/25 15:59, Philippe Mathieu-Daudé wrote:
> When disabling MIPS tests on commit 1c11aa18071
> ("tests/functional: Mark the MIPS replay tests as flaky")
> we missed the 5KEc test.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/mips64el/test_replay.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
> index 05cc585f854..e9318448fa7 100755
> --- a/tests/functional/mips64el/test_replay.py
> +++ b/tests/functional/mips64el/test_replay.py
> @@ -40,6 +40,7 @@ def test_replay_mips64el_malta(self):
>           '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
>   
>       @skipUntrustedTest()
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
>       def test_replay_mips64el_malta_5KEc_cpio(self):
>           self.set_machine('malta')
>           self.cpu = '5KEc'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

