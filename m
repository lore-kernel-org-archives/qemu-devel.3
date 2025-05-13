Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmbv-00057c-Pt; Tue, 13 May 2025 06:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmbb-00050n-HO
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:11:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmbZ-0008I4-Hx
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:11:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so34679505e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747131080; x=1747735880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=uiJg+w5ft1Oaiguv2/XX2J8eTmaWjtfJEwL5gcbufAbzaqw/0GrqIuJ7++TOEAOzHN
 ARNJe84mWrxudqzzGo3JBDY7W2rALmFgYKF6LV6OlYSi9JL+DddOVtQej6D9ujdqg14x
 bq4SsiB0gX0PC7egmbUgluIWpur69LTLaMSTqXsuPYs7r0Sqq9Q47v3KtQbPUvGFL5cz
 FHtAHgCpWPW4egIHpkvKAQHojXO5GD4hWpDk9k8teTawQ//kEs2Au+MiLukeuQLYuMF5
 lsOtTyK3W1j2yFlNn44cNwDbVALcQI7Zli0UzujymgdwsKT7Ghrl5+5ykUOsyYghZOq7
 mx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747131080; x=1747735880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=RBoWzFrSkB19UDGHht1hicpsLOnrc2ADv/XKtb+woaWW2SrA8SnGyGt2DmbqPOEEty
 wzqLJ/sx9FBdUDe33yHIF4sDUDCVyL7wskAcT2AkfoMXJEikpbgR1oy9kuh4BWpJMzfK
 axE+XxfnzyogPnAiS+cSUkTu/CPDPGkfHkfwvhOLCfUR2+xGHG+EIX34zHxqxNKfewyd
 a5kqzyMJ/PVj9c/uYrbIAus6ceNMfeaN5FmKytP656gUdK7lSEKjI0bB5PMn14sxW8X0
 WTL49xU7uvhl6Uwd1UH6IoYyrSmrWnXrgJXlJYUstt6Yfdwoe4LWfFlNXLJKVQEkP9DO
 B6ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPfGyq1SEHLefcLYy9knjDy3zxnfON3yJAz4vLec8UTzeM5RCaLqBfRmjE8UgUZsU/QuIqgJj7NIH@nongnu.org
X-Gm-Message-State: AOJu0YygklWQPrU2+INdywzQYJbegPiksl3VYGU9ik5tdPvEWybOz0px
 xTIQFyx7phtWYNLwP393qm2g0i7r+fuR04UwJazLgOpU+VliyfQjlo0L6qyWqVg=
X-Gm-Gg: ASbGncu9V5Ij38DoVA6RxV7yHNFUG4l5EbN0Sx98bpzcOAWmMHIkKOYE45sIOCv/yUc
 pTPZC2M6nzMv4US1MbtNNxnrzs04FfgReauV+ObVJ6XJ4J2LQcbTOwkKVCpLfwZ25ZJ3nqEBxGK
 ISnHcK9QqprDZrOmHz4tSsUnXWmei0xOa/Rg34MOYJrO4hUQkP+ygcjJ4cXeCQ4j6Ug9lQMP7yz
 X1cQ059+feM9Uwt9iiB50ShXNLNCLWuf1Imv6nvZn5vwpJ9kTicTIU272dLhmAMw4cYEycjk6ir
 ndHj+TQeG95PnnQukKPpnB2Quojwp2VYvw+s12YPI5OYvwIpsSTXu4pMwZrGf44EyeBYhI+UdW1
 Tt6XDmHdLteTlDAUZwWMHopunBj31
X-Google-Smtp-Source: AGHT+IEkcecHn0Htn5ABlcVlMJzuiyYg86vctMAyGuRrsKTB4IoF5CCoz34yObtxnuqTTVpntR6a/w==
X-Received: by 2002:a05:600c:3481:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-442eacba7b1mr26570885e9.7.1747131079771; 
 Tue, 13 May 2025 03:11:19 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67e138asm159084715e9.10.2025.05.13.03.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:11:19 -0700 (PDT)
Message-ID: <70f097b4-3870-46a5-84d2-6aa558ffd152@linaro.org>
Date: Tue, 13 May 2025 11:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 38/48] target/arm/machine: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-39-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-39-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


