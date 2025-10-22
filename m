Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F0DCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeDw-0006Bj-NX; Wed, 22 Oct 2025 15:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeDo-0006Aw-Hc
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:10:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeDm-0007eq-KO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:10:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so5901368f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160204; x=1761765004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DB/IQfi2vbMxTfrSwHEtAr4KGOyICMgdRUrHmc8JTgE=;
 b=qhrkSdfOBghYIt+DJ2nenxNMf5pjEGAK/l4oxA6lceqnKi81wJlezSpLd6bCV5oo+v
 1cI14Qg72cF9USwPEaea9q41efqIN8E9AqBx7GfBxA0VCkOSSBwr6tsu1njoY9LYGSkB
 NQnCl7I3Mt2PHuy/Ps/+DRF9LPAfnGqg6HqaO8qzDOW98W+UmxHR3ivFEqaJNfNtsAAy
 qLZ3PLX+Fy8BS7iSJ+wn2XlB9Taj8m0pfaMTotwVNG1qw/yotMObQ5fxXMH2oUzq+gSJ
 wX8p/LMLWSwGTSK86iIy0EGBYmCh1qaYb6QctmzHXlhnPrZ5NWSmspdNkyC7ta+Cm5mr
 cKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160204; x=1761765004;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DB/IQfi2vbMxTfrSwHEtAr4KGOyICMgdRUrHmc8JTgE=;
 b=TKcFryw7OhuuFUL1/J4exKBv0IH6IY0w0AeAjxAe3kYiC96v99D+Aj1PyuxR1FI7wn
 ktenLMWvHFaEj+hJRC1T4kvPpv40j++CnoN4lWRY/LsYSsLfyh8916l1DjVF967lNvbJ
 cuIzS4SmCEhr2IWsahMOdj02xgvKkZlYow2hGXh+G2+PNadiIovybHL52XN+LdLxhpnB
 uXbFxvnvOKf5+GL4RwkgYnfw+ABg05WvP5dhXvP20WK34FrWVPCjtgT5xm7B5tvVToq9
 fIVOeLEO3wR1mQFASQJBvE7vG4ylS74jcmQ1e+8VbNXfowB/zLhLcRy/DM3oxA7e5/OG
 WlaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqbPsaXidkFxv3J8PB9PEGHhX2PSIYI8uHwPwD5j0rAcwDC+4UtuIPL96QbxUzT0ClC9/3dniOt6gZ@nongnu.org
X-Gm-Message-State: AOJu0YzkEsLfdvHQmTE/LmsgTrJW/599fWA73vzx8HMDT+pnuvqa8XFA
 hl3H+4DYCE34CqykNI6i1UhvgUUkG9h+aeLggWaMKq4GGDKlzVyHxTssUCxrJ+vs4e7n1moTKLL
 FHqWcfoE=
X-Gm-Gg: ASbGncvtQgiIVBA8+cp45VTuZH/fQy5XoF+CcEz0k/p6xjzBtK6FF7iSAwpAJaQVk2e
 rELY+lUrihoFO+mYysAUqaBjALpNA5oqkfrwneaR+v0yPbDNhpdBLuDRTUNujDHKFtJ7ph5Iwt1
 FqYDCC7y78a5dBdkGvAZWGtyUA8EPtlNpd29L4oRLns21b5itUvDuhfNrSWktCTBEwDKEpgQCYJ
 bxF0NBSU+OwbXhZgoTixrMxxH4B9F8TQMLEk3qtn9BIsHzk9jpMH1Bmr/MIVREy0x5G/5qLms8N
 3hR/0Vk/e+U8r1SPY6QL26QdgVZ8I/sOmA9YoIY3oBp9lLAeh2NrXNdIAbd59lWtiRnh9rsQnAr
 3k3vILgJIPvcD6Es9kVIGq/e5KJ30czzjwUin7V0NiCdwtQ4ltEcksjU2Z9h2/2lfC/H6sipBdT
 qoaSCVz2ahpfvxIUeJcZa+kPq7xLGOYgdbyhMtxTGUYQ+wDEJWlIXNGQ==
X-Google-Smtp-Source: AGHT+IGE3S0vQgfKTYpePl6U/dHUaxVS3sZgP5cMOOWlTn1/qcM2IQtO29lvXpGrXtmuodL0h3S+Cg==
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id
 ffacd0b85a97d-42709287b06mr12055474f8f.55.1761160204542; 
 Wed, 22 Oct 2025 12:10:04 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428a5bcsm58840155e9.7.2025.10.22.12.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:10:04 -0700 (PDT)
Message-ID: <a3413bbd-e98c-4267-81c7-aa42aeda8a09@linaro.org>
Date: Wed, 22 Oct 2025 21:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/functional: Fix problems in testcase.py
 reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015095454.1575318-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 15/10/25 11:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> - put 3rd party "import pycotap" after the standard imports
> - "help" is a built-in function in Python, don't use it as a variable name
> - put the doc strings in the right locations (after the "def" line)
> - use isinstance() instead of checking via type()
> - use lazy logging strings
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 251 +++++++++++++------------
>   1 file changed, 126 insertions(+), 125 deletions(-)


> -    def run_cmd(self, bin_path, args=[]):
> +    def run_cmd(self, bin_path, args=None):
> +        if args is None:
> +            args = []

For my own education, what is the issue reported here?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


