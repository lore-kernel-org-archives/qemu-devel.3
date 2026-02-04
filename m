Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CBE8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRzu-0003TE-3v; Tue, 03 Feb 2026 20:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRzp-0003Sc-P5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:47:59 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRzo-0004UY-Dv
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:47:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a9296b3926so8553655ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169674; x=1770774474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QzLpS9LwyJ2BDhqKDQGfNT36xnn0is3EjXL3IQ/wNPI=;
 b=Y1dhDywkETdKX6zlv+DKqI0LGZHF+8TyY1rK2mguSLQSFAQZ8h5VeNV/jMot2n3nGJ
 AYc40Q1Bgi0dQnE5TnU8yganJg1FU+RbHvgmttlrRSFJlSfd0VuCkDsRlybc9RVe6EGU
 x7Kj1Vjj9DxCZgIieKnzwY6ljWQWECxL4JZInh2kK/cQ1PcSGx4WZB/NRUS4GgvFzxoF
 uqknW7c9KMul4c/4bpcNOwkyNmujgor0wXeLngi6BXGZ/6JDPLDfH7Cgue/PNnJM5EYc
 k9MiJDPYuLGWqlLLJZ6g2YgtOl2EJLwSZxNirxFYxbOnUW4mYnD6vON+c+di9ODIogMx
 Tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169674; x=1770774474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzLpS9LwyJ2BDhqKDQGfNT36xnn0is3EjXL3IQ/wNPI=;
 b=Cs2iV1U07I9SdBF4UbxxltU7m+lbcIKf2g9IfPB+H5JHG+vHzhPsaW8kRDUAxTrzp7
 gUJMG1oHKBZOxscF1mHCYZC0dLWkoA4cydooW/7UyATjVuNtadb+m6EL5rC1OCXgUr93
 p/soGguP6y3zME84ABp9wW6Qwm4T0l6oLXP8N1opKCaKMvOWPh+sIAyt72jgjeZPNVwf
 +zCYO37Sh30bXnf3iDTXO9d6/19aTKakmJvsBtc8GovJjA+4ElhmtipbTecjMDnRFc+L
 IdnuT431ojfCSo1RchdTO4J+Y1fXk+7bFxsp0pzDCBSWs692+whbjgUKgwp8dH3m2zrm
 1UdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFrsTWtCcdj7BgluFV3t5hg2fGb3GqfaRuX0JZTtooLo+NmxYnTiebhw9BCCtSpcYh6haMX6MGwidC@nongnu.org
X-Gm-Message-State: AOJu0YzZ9K0Yp0b19qLBqnHF0w0cMyPkje7ZxBPeZzHRhxK5xEoiCxZv
 jEcg+xR9CI901AYGuOcp2GF84QC/p7IQfxAdnvw9EedK1ZknrKQbE5D2cgvdEZFj35A=
X-Gm-Gg: AZuq6aJF+2quCJEfyk+PxOnoCFd/J+CEAGILCuMnsoJXf3E4z2auTtg22Xwr8FwLYbj
 lkSY/jpdKF+5lfZ5qaWQ+aevX9DTTxBZpmRsOAEYcB+ZSt+MT0WDuczfRovgi6BbjJGBxVkn18R
 nPo2E2GWAUuVMvqLGHOEfixl7wT71Xx5QANcd29uh6p1iLcwwuUE6TYqeDNzQlWvxcS4d6jcioi
 EJxlrwRW5PJiW2sMWtX6SlRT8MCzcQX7aD69I8cWB/1kK9nSdRybFA2nf7VqnlZUbfl97Xby90D
 SxB49huI2lFwQFpJ9mfqnH9JAlJjVfPcK0IWVLPrkiAnZSOcy+nOltec86EuzrT42KKsJOf/Zww
 YLrzPFPjXCD3bHXXgsA2EnzRZXP9SFH0V4A5pUrGhJoGw79/+B4BDWQeXsq9I+wKDziIwmm6dke
 OfeO+sFbJ+Dc9JnfAGOP96s9oR9dnrmeeoYDkoWugYSWj7lBeNtp+FVIa0JUUuA8UddlI=
X-Received: by 2002:a17:902:dad0:b0:2a3:bf5f:926b with SMTP id
 d9443c01a7336-2a933ff4cc0mr14583955ad.47.1770169674190; 
 Tue, 03 Feb 2026 17:47:54 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9339822d5sm6086205ad.99.2026.02.03.17.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:47:53 -0800 (PST)
Message-ID: <45d7fb96-f2de-4d67-8069-b545e210947b@linaro.org>
Date: Wed, 4 Feb 2026 11:47:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] qemu/int128: Add int128_signextend()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203230054.23667-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
> Add a method to sign-extend a Int128, along with unit tests.

What in the world does this mean?

I can't imagine a real use for this:

> +static inline Int128 int128_signextend(Int128 a)
> +{
> +    return a.hi ? a : int128_exts64(a.lo);
> +}

r~

