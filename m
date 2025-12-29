Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DE1D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3kD-0003iX-TT; Sun, 28 Dec 2025 22:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3k9-0003du-PU
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:16:26 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3k7-0003Ig-KE
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:16:25 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so75694315ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978182; x=1767582982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=galDo/gzv0kuNOspiFplB5ycKN8s6PK4+l/f+cMfKMk=;
 b=ppqI+jpWZfc98vocsHUTfxV9mGJIuuODjBY46gk9YyhiTQM7w2NZTUx+9CdnBPFyjs
 15u3bv7ZBYXIGzSK74hhPs0sH9CvVbsf+tkmrWxofyfxZo/HAqjDPeKUD/uY5k8tLppX
 ocz1l1ntTFeHSGs20mlcvoKcNTbu4wXrwwMwmxMJrT6ekGLmec5J+DPaRqO53PyelTP5
 JzMgfrgZAAPFcTE/RQB6q7mCyoo+zEiYwCQ9OUQN+CFKgZFrVFZI1+Wl9Oviu3Kgyw+2
 Yx4G9CAZt2HL2HUmJumz0SKYHcJMalqSbbFClWMhXBqXpmTQY+dKYWNeg5XaKRi144Di
 9CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978182; x=1767582982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=galDo/gzv0kuNOspiFplB5ycKN8s6PK4+l/f+cMfKMk=;
 b=iaRFsDsu/FlZOTVT1OQEd4l6rHk4HTJpYMgCZxsmCnJDbJuNx6VquGi0alqdxj9s5T
 c7AYpFIv9e0PHXBDekEItAYw2IVDF3xxqVse+/bFzLnFsFYLKhio+HQgdz2cFXRxh/1f
 xc0ju89uXMtBHFm7hNt6nt1GGaewXTxfjr1wQU3J/ZUEQCU9CItDOrhQpoCgqmXTU6Nm
 UfzePt4W55Ti5QKt5WVHX1Rh3/InTzvW/0wz0EDWfRTAU5RqQCHXjmoRcrjJ66M01tal
 wmbi62EMR7UfbpJ1QY1vBiMEW9GUhcYeO2KMBEvcI0+z5u7lx7TmKXExM+SuW65qvcXL
 aZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0/hsJfZpwWfRHvdlupQsTj4oDnpA+e7hI6K9LJLtF6+dK9/LbHV8OF6AqEjREgHXEr65KLLZlm8as@nongnu.org
X-Gm-Message-State: AOJu0YzDMc2qff00fvymTDVWHrpYomcM+TPQT2RGor7jP9xiN3UCbKfw
 feQfAUdNTmgL5ayhiDyoBEbvnnzfdJGJoNmF7Ip7nwKzxu7BorEEcfb53kPRXOd8TjIz2DhS/Wv
 mUo3P06A=
X-Gm-Gg: AY/fxX4Fbz6jkUmhWNDWTn2O76CBrtVV06sKuLJ1qKcf0D49oH5uzww2ucEnGLdbQ5X
 bK19lL5MXVpukFIcoqVuuoXs1RcK7FxXsv1DBWjFC6dz9DJqPAm7T1dHmr6QB9MpaLG+Z3j5EtO
 LDncFcHtDLe1qkbgca98E0i7SepxUBC4Syl3DT5VqPvvsk9+HWNIz8K9ygfCWaMxRmkU12ESOSC
 68Pn+OvfKyMRbXHRADcTSi9gjigZQVRirlQiv3XyDwt8fZKMkJFoNQAhhhDlqe/f/aWJLIDCKlZ
 xv3noQK8kOoUYaeBq6oFGE+786CxoppS0kNQN0yzieQRnKyXvGKZa8lC9woKVLtiwCFz09Bldni
 MT29TFgqzqs9o17C08NVA9oBApc73/BiMpQGi678tRhkgwPrOFqR+7ftUUmfB37RDpPhFDMQ//V
 BKkgxfJg9RymkuKC7kgXetWFM5HdHGO4u1RCV0gBHI5XJtDqYfjySkXAOUPRweplkJfu3WCw==
X-Google-Smtp-Source: AGHT+IEsctTtzaJT+7aIeHmTmech4RgOCf5Ff7BKkJcRNRU/u4kykdfVRiOcNzKORKNO8jGixVXFVw==
X-Received: by 2002:a17:902:ef4c:b0:2a0:92a6:955 with SMTP id
 d9443c01a7336-2a2f2231751mr287053635ad.23.1766978181979; 
 Sun, 28 Dec 2025 19:16:21 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d86esm256777615ad.74.2025.12.28.19.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:16:21 -0800 (PST)
Message-ID: <b18f48f8-2216-4b39-b864-91761dcbd835@linaro.org>
Date: Mon, 29 Dec 2025 14:16:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/alpha: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> The Alpha architecture uses little endianness. Directly
> use the little-endian LD/ST API.
> 
> Mechanical change running:
> 
>    $ for a in uw w l q; do \
>        sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>          $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/helper.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

