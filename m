Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9550C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GxJ-0001K2-Rf; Fri, 25 Apr 2025 07:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GxH-0001JB-PW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:10:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GxF-0003gp-UQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:10:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so15384505e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745579447; x=1746184247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Czb1fB+t7BDXhuauxEc7uGKN7eHSq5cxbtZ3MG9H3uI=;
 b=LbRcZWG667LJ77YvIRORuMeg0++DJLVU3cTYiFVVQ1KybpNo5b8Urh6rZIxSNsnM/f
 TrCz5hj/yAKCVdvItI7W6Nv4ITtYI/vdegVdtBtNS+wZQUi7n44NNzIutaC4/hb1UFwz
 4R1T9phJcV1jqU5oR86hUWP3nuWU30mbUTyNKwWKu+Sy26fsRjQrFaoJ+fOlYuIsT8wn
 vy0HYaAKrEJ0U0WiYsx5cm1EPuzNdT4gXh/JmQ20kHz1q2passP6JUmRbVKk2eVbT2iH
 m827E3oHOZD7QIMlT+pYT3zu/HZtEa7JqxNSI3R0tmvmr1U9lFo1XHu514fVOvy47my2
 jlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745579447; x=1746184247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Czb1fB+t7BDXhuauxEc7uGKN7eHSq5cxbtZ3MG9H3uI=;
 b=TPMcLxUvVUJUkeF00fc2JCTpQDxqWmXPADnzgMjUTBxZ2WhmhikgamCsOMP8V/Kb/m
 Biy1bTMmJ+uFKZbnRYdXB/k5jP3sLftq+3khBrHp3xfUW8tgTvYcRnq0Ydk85bgW6UNr
 Nny2YDmXogWCaEOFaAs1JD0UBXqUiNZOrSusJiVeZkuhRHEUIB6/ibuLLv4NgPZASAp6
 mFet2Uixranc1I6NpU3PNUq3WsMUJ9OPdSoB0KGdbl87w6uyvSAhJ5FUFhJ9G7PPOlRY
 nrHIb52AadQC09HTmtvDzwMiSTYF1A35JH6SPgDtJTl0E2iO4VZELjZBnx7Q+u3DrDsK
 9isQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF4UIEaepDvmyX7XT13IjEvWkOkO583pAuhhLAjiGd9Ue1H6rjJ3WlAtrAwmc9S//6KVtxchQeluku@nongnu.org
X-Gm-Message-State: AOJu0YxjeI3OFYIUgy02V2ZMEpZCrJTh99+xd5/33Sm4H0qMj05lV59a
 j7YpyeCkqereI1Nma9OgU7fUrWEAy7IL3/TuT9uVIpRQUbwskGZumthDr9lkzjI=
X-Gm-Gg: ASbGncvzqHRG1W1kceaJ3bB3TJonei0d7H5J7Q3Qb25p8QnXW61dR8oYfH3EHUe+Lur
 tOpZChqwK+Ji0FsNXW9eK47ALsWc9eqZMcVUpMqo/72uNZpkz7WXRCv/GdYIBrP33xI0Fw6e9CB
 VQCqAmyf5Fh95WXNOI/eLMqOdGR4I4jwUwuEnkxEcY9un0aaqx6FGnUj4kvAtC1+bFA8HLIhnHg
 nAU9hs24Rn7hdWHEVb8m2NsLYh5F5KTTVgPlV/p/fFlFCGm8PqVZoEzE0dPsUI3AD61OO/T+9gH
 D9l/dXuech44SxRg/+H4CHkWxUXCR1iUOUCJc2E1q5mqLXiZmLExA7PCxe9aM7wSHUnWkj3xf4u
 D8ETVkSgAjIeqppB990E=
X-Google-Smtp-Source: AGHT+IGPLCdantGvN2kLmQ4oiLR7ub0/ZDCsIBZwSSx18FUmBnRE+wzPAUpKZNnWVG4NUAZut3f1ZA==
X-Received: by 2002:a05:600c:5252:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-440a65b6f77mr13819495e9.6.1745579447214; 
 Fri, 25 Apr 2025 04:10:47 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c68esm1990779f8f.82.2025.04.25.04.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 04:10:46 -0700 (PDT)
Message-ID: <876e517f-acea-4fca-8735-ba8c732bab98@linaro.org>
Date: Fri, 25 Apr 2025 13:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] include/system: make functions accessible from
 common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
 <20250424232829.141163-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424232829.141163-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 25/4/25 01:28, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/system/kvm.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


