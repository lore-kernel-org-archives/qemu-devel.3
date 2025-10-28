Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8710DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiOu-0000WB-R4; Tue, 28 Oct 2025 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiOr-0000VP-M1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:02:05 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiOg-0000S7-Lz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:02:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b50206773adso985590266b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761652910; x=1762257710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ycLScXY9J/asCOE3L2rjsr+XkAIASPr7CwZbCPXlGvU=;
 b=CjIpAVv48D3yAxoc8EMKYA7G8axPmI5zyNGF6EhN+qZ0fS2/6YFzgO+hgXftXWIkNG
 hl9IJdUIwFDoN+n7zcAXa+XV4S/LfwAOQPQOgRPD2/WlHG9i46iIDp/zaZEY3vWdxJZn
 wqONYE7Puoty1ULJ458I+4IzOqkF2nuuraVXcjte3ZTW7ITL431vuhxsWwW1vj0omZYi
 OU4hIgQV2FvFLQaWterF64xdDKkIajoLeCgq070+d6wdPdq8KlrWILE/al6gytphr3re
 EFzlzArtSVADPymhxYq8Ha6zcWbGnNGDZ6uCwAMAj70fo2E7RdSmfZ720GR2Hx2KEfU/
 CD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761652910; x=1762257710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycLScXY9J/asCOE3L2rjsr+XkAIASPr7CwZbCPXlGvU=;
 b=t5O6rAjKjVWY4r2sin9Ne8/x4lKjejXZTFxUa9vJMCYiB+2q3LKD5+CJ3Qq5NTMS7J
 a7bEgFLi/xNGwlCjhy5S5S+RA5jFj4ar8hGsiZtmcH1r1QOO1l8EGkhRByfuvD2SaN09
 OrvHxvJRETiawouHud0EyKeoktlgd7zZrUfOO+weSUuIaOHDkdmNMOlCfnKrNk8ZmsaN
 xhW3lawG6uRaJzpyF/vhUsIPyLPOOQHU7xGf85ltF2pWc1EUusGO8s00Sh5LZ3TqgvJG
 3AzHVVjIaaDLfQ4Thi59Q/6czBXg299KyDIOjjxusc/BCqWIya1Wa6IuOvwPqrr2Ckv5
 +kSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNS4iTqUtegB5hNhM/WnD5ucuhjYYPr0MBzQatkF0v1TeoQ5jdb1veHey5BUw/7FGctKFaSN5rX8Gl@nongnu.org
X-Gm-Message-State: AOJu0YyFDALGB4OuVctRY5c3IyE0uN1obt0MRFaCHgBgVS2ZjqMUjyWK
 RBqQg1tlaPVMtbBCeKynp1FeB5NYa91Mh20stILTYV52/KNSz43xsYMAXuoLmL/2N9A=
X-Gm-Gg: ASbGncuBO3CYSwAOg7vWoRg558U/ZzpMscClR48EX90xZ2FR2DiCPdNYu4mDDQQxVa+
 OxZFUL7xqvdDpN9REioiOxspOl+u0U0wYpweI9+nfVSg0rY420AVx3ANoQBu+0qpxAac666gv00
 HAyMdLSR8wSOqRdv3FDZiBTxGAmQOekqtmacv12ml+f/aJ6wtkrVM3zxcG9HfUj8yGnqb0yyddz
 VK1Py2FF4JfsTJTpGs/mlK5iPfcXmcyuQ/CdLslXpdENKi1kcC44RJV5N3wAGNNoQ+NEC1+lgmm
 k+JSvaOUIHrEMGHezFeRB36gvZemW+zklscfQr2LTSYYAxlnaDCp8gQINBbq6gomiAQxxRbVHI2
 gNeZF+MZLs/RDLvjOGc78JboVLOowUeAuhaJFe6JsxCjhvNNoMIgEc7yE/2O9K26h0rs8Mddk7P
 KafPSg8TQImuWRZez0
X-Google-Smtp-Source: AGHT+IHLDVweUzBUIAJvRB2B0+N2jjX9/zvKD3CQ8A/zpD84n3oQlgH29mo6qtHekqJY28nrbttJ9w==
X-Received: by 2002:a17:907:3f83:b0:b4d:71e9:1662 with SMTP id
 a640c23a62f3a-b6dbc04da08mr309095366b.30.1761652910151; 
 Tue, 28 Oct 2025 05:01:50 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853696aesm1095895966b.30.2025.10.28.05.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:01:49 -0700 (PDT)
Message-ID: <12196f65-ad1c-4753-ac15-211567c77297@linaro.org>
Date: Tue, 28 Oct 2025 13:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 43/59] accel/hvf: Implement WFI without using pselect()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-44-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-44-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -128,14 +128,15 @@ static int hvf_init_vcpu(CPUState *cpu)
>       cpu->accel = g_new0(AccelCPUState, 1);
>   
>       /* init cpu signals */
> +    sigset_t unblock_ipi_mask;

Why introduce this?  Surely it's unused...

>       struct sigaction sigact;
>   
>       memset(&sigact, 0, sizeof(sigact));
>       sigact.sa_handler = dummy_signal;
>       sigaction(SIG_IPI, &sigact, NULL);
>   
> -    pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
> -    sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
> +    pthread_sigmask(SIG_BLOCK, NULL, &unblock_ipi_mask);
> +    sigdelset(&unblock_ipi_mask, SIG_IPI);

... apart from mere initialization.


r~

