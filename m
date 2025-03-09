Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABE4C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLlS-0006yG-PU; Sun, 09 Mar 2025 14:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLlR-0006xp-BF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:52:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLlP-0002lC-9i
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:52:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so2688025f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741546357; x=1742151157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYr/SvqZEdUOMqOgX0098OzvfED2AvZPVLedou7WRAw=;
 b=DU/j0Ixsq+w2HU1F6dzbGods3FRjyAVsciDSlMnwyLW4+TnqFngjs3aIgAT9wHPllw
 8NsRbNLJptzBzu332kobbSSjGe6yOGnj9WnKbtPNdr6PR1GpugLKGj8KZx9ngsAzmyJ8
 EnpqcRCjX4BqJoY/1jIqxVPxTHZ+IbajO1j+HUnceQR+DCL39CihG327QYPdpUtRzvXD
 RwJouD/R6HqdeOTlS8/fzSHdqSABTMWUymDu87cXOp+hPv8liDSxpGH9qWYV/yyDOJVy
 EzF5Lfd5cKBejBJvZ7aYDKeqKb+r4ybSIPO/NIMwjiFUv0QZLqvw5oCKbTGmGRklZgDL
 tqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741546357; x=1742151157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PYr/SvqZEdUOMqOgX0098OzvfED2AvZPVLedou7WRAw=;
 b=PQqqycFApTqHIlL4ZgGogZ7lpHHJBgAu0hwClzG2O5Jp2PpgWbX/eiha5baNzB7i29
 mqwbzdwZwR16Ph0zqpJt47TiHoCR8TYiBf1BZ++FuclL5qIWQFm97H9dHpzyIBOVjqIk
 dGKrSUYwHuF+6UzcCQhq9mz52L8CFgNHGk3amK2YJG2Uq+qTeSEwIQTqRULEfwCpgf1f
 9bFb0IMI5zETiyxBgwIKb5D/9i/3MY3n6SwJBUbcjm9sfMviNeH4hs6Adkw+cpfDbBh5
 E8OmfjYv3bNVxcYWKe5CzeIyv/TwuPOMEuyhJ79XLU42Kjzq1OG+FhWxxGIb7eRYEUrT
 mdrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ybi3izK9RWcYGzZ0p5SY3lQgfbZQ9S+90C8mmAWLo0g0k2ZB/qMyfodaxqV/8ydnTgP557AP516p@nongnu.org
X-Gm-Message-State: AOJu0YzxzXnQW7GecmRmekb4Gbja3086b8tGca2TlhMHlEClln0hxZGz
 QjpVJDtdw5Lzx4NYlVUTrZSpoVrINTCD4NhnTuuLjUZcDgYYDREF+sP4q8SulOVQDQaruV/UNpI
 ONFE=
X-Gm-Gg: ASbGncusdd2AezCuzBwaIo8Vv86+klYsqzmvUTMzJ+P/92APGB3zS1OUJMJJjq6uQYb
 jWfAnv9Uv1G+n5SoHwp/1biJTA/JXt5mlibq9G6kZ3vamNnV7V7J68yob10myD2vqb7JNJAA09o
 kBbINha2Lcz8Y6ovet4iy+Vn4GKr6/ygOiRmM6kjerOEXVkSsNVRM8xee2+ugMSawvX4mcIFG8s
 kYcoEJwIZ0qY0eL+/EXrjLrf6KV2qR06uYXtGIdkwv/XxvVlrRryo0HaM0i8VYmeau3TN0oYA/+
 USsZzXvsBsLW0qqt6iv5Yn0drzQ5s54z3dynDqIvHrYhRFTjCTJquxxWGTtdivhsLGI7nWVujtN
 HcBMsqUAI45qoqSWyMX4dDsA=
X-Google-Smtp-Source: AGHT+IFrsEfmDP3W/67vxhgeh8GzDvU5TTjNiIk7+gAkFlUa6n7fo9XAGx/6azLyNSLjDtNr8F917A==
X-Received: by 2002:a5d:59a8:0:b0:391:328d:65a2 with SMTP id
 ffacd0b85a97d-39132da24ddmr8685921f8f.38.1741546357385; 
 Sun, 09 Mar 2025 11:52:37 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103808sm12736990f8f.97.2025.03.09.11.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 11:52:36 -0700 (PDT)
Message-ID: <a80f3d0f-2f74-41a3-96e3-c3fb9c0b7440@linaro.org>
Date: Sun, 9 Mar 2025 19:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/net/smc91c111: Sanitize packet numbers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <20250228174802.1945417-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228174802.1945417-2-peter.maydell@linaro.org>
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

On 28/2/25 18:47, Peter Maydell wrote:
> The smc91c111 uses packet numbers as an index into its internal
> s->data[][] array. Valid packet numbers are between 0 and 3, but
> the code does not generally check this, and there are various
> places where the guest can hand us an arbitrary packet number
> and cause an out-of-bounds access to the data array.
> 
> Add validation of packet numbers. The datasheet is not very
> helpful about how guest errors like this should be handled:
> it says nothing on the subject, and none of the documented
> error conditions are relevant. We choose to log the situation
> with LOG_GUEST_ERROR and silently ignore the attempted operation.
> 
> In the places where we are about to access the data[][] array
> using a packet number and we know the number is valid because
> we got it from somewhere that has already validated, we add
> an assert() to document that belief.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


