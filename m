Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3693CC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1B5-0006qP-GK; Mon, 04 Aug 2025 15:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1B2-0006kQ-1W
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:48:56 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1B0-0008QQ-Dl
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:48:55 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b3f80661991so4126578a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754336933; x=1754941733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=atE7N6Ir3RX/VJDvWpTN+pnRHD2oCCSx+NHwvPtMv+U=;
 b=ItzKIYkZZ5zoxNChK6XdI8FvgtCkmtl0wnxnW1gS8tgwQD91zL2NLnFm1D06jzDqbx
 +aVixdF2im1VfmlEeGnI5+uRVu9gABgyNZ1054gSCuBPvrIDWrSjDyJpSLQZmIKZG1BC
 9pqHolQXHR1X8EG2cwBZTtKzJ9vJVdnrXrEIHVH/AWE7V1hY/CHbn631FcNkyk+bipfk
 DoOd9cTqZNm5ijW9egs2rkhxypy5JpwmpQwhsioLp2avGSRbcTX5QSASbqsQu/LVHwdB
 1BNQIHGOfturIygmXqWplSAnhawP18S+AAKMlFe0yop6DufrEBY5gafm8sPq8ttLjeB/
 Yjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754336933; x=1754941733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atE7N6Ir3RX/VJDvWpTN+pnRHD2oCCSx+NHwvPtMv+U=;
 b=AgHguUJBA9McEqImfEbKFEdwLYUK73aFUnvNnPJVhiRmT1mFL9XZGCqShDJQvFwJD3
 J1fhuzwGwB/sTdPyaYa3559/ef73TGoScoVUtDCDTukSGfzgryfz6ZOcbwI7Rf4vd6ZM
 4PulhgIEOf2BPoDfeI33nCPcP2jkP3Ds8NFlpJJSWJDd4q7cT6XPiPoMH84qS9mG5/Rx
 6tYNmKdSUHUm7vd64UqlVrYYNSm/5GnWaWxV/qg3yYuWJyIg6PZcOxkDjXwh7QdrwbSt
 zatjmBbXAXZXQECkEjLEh9zVUzyQyxqnvAoUHI6n9G4d2Oe1czdjzld/X4VDrLN0j0L+
 NfZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHf3KON/3JqyqNfQ8+3tED78iJI77eDSTcVNsZwW60eF0VQXoCk29szUKtk5lj45tMxOAmgP5l7d6P@nongnu.org
X-Gm-Message-State: AOJu0YyEuIHr7MD7Ulf2hygqYAM3eJAloilnqeIF0J0RX54ehGdxmP3l
 VGd0vnPuu/Kkc2MdNPTq2QYXDdFhgCVOqFd5+ojPgCZM4YUIzMY38lpnoHDi2p+slx8=
X-Gm-Gg: ASbGncuT6yNNSKYdeMwlIlpjmpIV9OLPJFLoi0PDTKUsG0V8fOa9eaKSOELQ4N5su5m
 e4IcKcUPd4DAGL1zCpfmWfvvVzE1ahDxxkV4Eg24RkPz3yRIQZilVjMVBzPyzeGWNpJjO+0RhDr
 bb8lsHBlZfLkXrCwX8GWDAwSTA0LqBxjxkpxbq2MEB6HuqYHC4XYqRhUyorJSFmXn+z+HCL4NrE
 tx9K4+WjA6T1wR5N1J/9+uix9Xt1HmSbxlQXnn3mNdJdEiaPmEMvdE93uRyEa5ChdEPCeb0A/G1
 bK3E2sgBjtIM0vLSuBgI3jF60wrmP/4je37D80BIGPy66qsrZFPnqNUh0SgV2wwvoJMKA9WrbyA
 pMQpu1+Ut6Y8/HBiSdoGQ+vUrArlZ59GuXFo=
X-Google-Smtp-Source: AGHT+IHse1vyJQYrK0hDW1AWHLgHiZhqs7Uo/tfN6RBtgt39X7Dq8a+/cvxIb/FIOtHXYuOoORCPTg==
X-Received: by 2002:a17:90b:1b11:b0:31e:cdbc:8d4c with SMTP id
 98e67ed59e1d1-3214fbb3a9dmr1034234a91.0.1754336932868; 
 Mon, 04 Aug 2025 12:48:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b7e21adsm9606723a12.26.2025.08.04.12.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:48:52 -0700 (PDT)
Message-ID: <b3a025cd-143c-4a64-bd55-975d2dce44b7@linaro.org>
Date: Mon, 4 Aug 2025 12:48:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/17] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-12-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-12-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Hyper-V supports PSCI 1.3, and that implementation is exposed through
> WHPX.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


