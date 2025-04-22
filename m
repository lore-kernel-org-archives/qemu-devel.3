Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C79C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FNs-0001Jp-KH; Tue, 22 Apr 2025 11:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FNh-0001Fx-A0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:17:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FNc-0008Ep-Cg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:17:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso34573935e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745335066; x=1745939866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VOy+KhKLLjpZjgIn/EcF9YiBAy/bvmokMHdyOtt41/A=;
 b=LKuKyZqZu1FyCpX6C3KpXODHJitIJB3NnOzj+R2B1iFymDfJbjJbkPKtGKPYq33Mak
 oMwPdUz+VQ7ln6lehmNNKcsJbJTu05GrnhZN16Ty6gvoCgOfu1tnvwF9WCFUyuMlIiKE
 mkqRgnF0ScQA6odlPMYPp2+HgVaRJVu6lEnn5eL24lxgkXKRfRtrHehphjHdF9Mvzbaw
 /NtiR8PPb3E6oILe1CSttA1JH3S9NdUuigwT2yP9XbFT6nyMc9kgVSCgvofK90xbWpfW
 uSqLN0RD5NWtbess6/W8lw4RTjadmPihL/vXpt8U5w36WSdkF+5MWQywSL3G9NPBJBex
 UTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335066; x=1745939866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VOy+KhKLLjpZjgIn/EcF9YiBAy/bvmokMHdyOtt41/A=;
 b=PKkQMN/q0FQJJ+MKK+8NFxu/60hMm5j0TdFayf1+mtbAgH8W7D6c/OnpIpJAszFNxA
 GU6k0TRN2mV78nZor7J3FAjBPDAoQPwVz6tLb6cm2axQGmYnwKVsahUiRnPsW2jpsxSL
 n1m5UbEI7E18R1ybE8mhBN6/UaS0N/gHFzyzIJ2Ljw9QFajyUzBtfbspPyk0lnvLxZgS
 EW4Ek1z3Qcs1C4Ne44YttMaB1ImYpdxR6G7A+RdUEdwzGLlByDxOjeu3OlZiS4eEQPbJ
 7SyTcvPQMjSfsFWI2rHstS+eVWw5X1GV/06dCkPm0wwjwOSQ1hPccSin0DawTT9pDhHQ
 ZSow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEcAnyZEZcGPX5uIJdc2lRDVJWiG5Lear2TIDoRugmBrICl1A7pA/q0iLo2jH0c6T0tNNpkePsf8Ak@nongnu.org
X-Gm-Message-State: AOJu0Yz4Mdibf76YqahnjivYxv/wOn9ZMTXm2be96ff6KZkfRMSUSmLE
 DXvlrCJqYvDNziU0q+4sIERfOOjMzKmKqFu/5rGynZxFMYpVqoRFbOdSwK4p/OU=
X-Gm-Gg: ASbGncuwYMLgjGxND9E7IfjQkvvzJ3eQbNZfOvNI51VRF6Fesh2F0kwVO7XtLXxWFxv
 4AzbM+3XDUOPFTJYyLt8r6gnUobzQ5+1FGEmPERv5F80QI2e4WNukA7CuddGZ1r9/iFZlYzeqTe
 s37qGPYEM037EQsKbduiHb+FA35oKhJBnwsVuuNbiadHQLVPeIKaeyGbmX0ez8gX4pA7ERFJaEw
 27T+mepJs59ojAyUFqx6XJ0z7s/OfXEMX7q9rkwIqr33n0YvUkR9rEUdoeozH3thPFxgdLePz5m
 3lsazhalqfrRTHzOEXtIMqRYWXsbKEVgzUN29HbTk9VpaECHr6sobT8vCjf+snhwiX6cFksGMpg
 OUnCC09HK
X-Google-Smtp-Source: AGHT+IE2uxMJFssBjck7VJcriGI66YqLcmY4CJCqu/1KwChBBVetxfemdiz2VNs/JmEonrzR8jOcdw==
X-Received: by 2002:a05:600c:500d:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-4408a656ee6mr44597465e9.15.1745335066614; 
 Tue, 22 Apr 2025 08:17:46 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd7fsm176701635e9.21.2025.04.22.08.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:17:45 -0700 (PDT)
Message-ID: <b55ded22-4fc0-41e8-afe5-1ddabd8b0374@linaro.org>
Date: Tue, 22 Apr 2025 17:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.5 0/2] tcg: Fix TCGOP_TYPE in liveness_pass_2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20250422143746.261776-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422143746.261776-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 22/4/25 16:37, Richard Henderson wrote:

> Richard Henderson (2):
>    tcg/optimize: Introduce opt_insert_{before,after}
>    tcg: Add TCGType to tcg_op_insert_{after,before}

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


