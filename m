Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7846ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xr7-0006pX-LX; Wed, 01 Oct 2025 10:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3xqs-0006mv-4s
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:30:54 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3xqc-0007r5-F7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:30:38 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d5fe46572so17480157b3.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759329017; x=1759933817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w2kC1qIXV8PcX3s67FCHJWGN1TK852uxs/wgxxlk6bc=;
 b=PE1kV0VRwqUrCSzbYN+GgFOXEW8iJ8/gbfjRqy4Fq9WZFbff3XKyxv6u+RfTznNxap
 YoZuosW13c18kijpiTYqBIdGxVPecGWpAlYSEcxTZ0+V0G3oFCcGN5KeWEaj2sFUekKS
 U0VOI7uy6isNTTHBQXi+GbV3rDzRCN0RbfPOjJYcCutdISf5aSJMZwuWnwakB+o/LqK4
 WXaWXEaLdY06F9HYaL3Np/Ioy8PjhkiHmXCYvpj/eREmF3BgktuwgDjcCc0UmJQ7TgSN
 l00k3yEM2Ko/fXYW6v4Gsk/4SDE1HG1MTTGo9hC7ywfE8SEsVczXuHAdGRd5GMYGya9o
 U/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759329017; x=1759933817;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2kC1qIXV8PcX3s67FCHJWGN1TK852uxs/wgxxlk6bc=;
 b=kig4bMVmL63xNKAuuEjU9+wZaTMRO03H3su93JToM+zNFiub6UtiVtHIjPBbwlBBSB
 VzmgdiPHt0D9vribHUZLcRZqo5aSY5L9hnSJEQFg0KwTp8KO0vidIB/nmc8WHXyv9zia
 zmhSvFgomJ6H4EcIMDM2MY7fa3/jUoawcY7DzfOUxshNWCayz70Nn8vtUC1nqHhOkd3x
 WLN2+Ys3QP2lEWquV+Zo3QQ8kYKHpY4SaB1nF+Vo59de3SMMgPKSD+ZOQyhSpwLmBlc9
 KdY2ZHrpH8xu0qgB5d8jj+BZt+zfluqzhpoNhkXtpHA7+4q0YULTBuKl0BUYu+1iua0N
 fHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUHGdfsowWozBntScrmZCX7sg+EL00N1czHB/Z4deAxKyPIvqqIQxeyppw7iaHFe8NJp+MxrAXJ3W2@nongnu.org
X-Gm-Message-State: AOJu0YzuuB8vj8HmsPRAJwk36rneNLFMuBijPz3hbpfpJa+7ZQT6aQxr
 VPFPn8AkKAYU8z5MY2QFdgkBuKVyvzNPIS1HTa/LL5HMbCebD/jXHjLAzAcZtptVLyM=
X-Gm-Gg: ASbGncv3T4aR28h5vmfUtrWKfUabIIRcDEOXAFVyJJUcNRgPWo6FuqeN4clTA3pguet
 EXbLQdrNc4q9B0RoyGqOI0n2zLu0nehOtWHRtR0kN+tPFZCSHXwqza6Vhj7RZRQVZN7zP67qx0O
 TJ2Yt7hdBSwFeKgmf7dMvjansqaJaHDB0GaoWDtZmluI4pPxVbD15ck7/emryDkY9zH7UYvgtvK
 vMtshSLf7QO1kPFG1SpulbjUhwZVAXpBj0PDLTtAHTVlefYuixjvDpumAGl7hfw6CG+oviMylaX
 wgzJw565NEs+7eGXjNyi7MXUUZoD/HR4OK0vSW6HVwTxGRky7fHe5ut0mGPSb+zhQf+kkcm5FLM
 RZcumFyO9PuHV0ns5XTqyUsSjY4ctuVcTq3iLQRzM6JOxbL3li1HgJH44Zi40kXdWESNRmqFBsL
 t3jwLweUDPd78fMRNZuW2vEvvh6CyKo9c=
X-Google-Smtp-Source: AGHT+IHDa0XAguArI684+RzTO3+tzlWOD68LWa+Dvl+Yya2mi38NLKpWtfsVfiE2ebZvAQoDXnPcdQ==
X-Received: by 2002:a05:690c:95:b0:733:aa00:3860 with SMTP id
 00721157ae682-77e5cbc98d0mr107658017b3.23.1759329016779; 
 Wed, 01 Oct 2025 07:30:16 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-765c7ac62f4sm45765037b3.57.2025.10.01.07.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:30:16 -0700 (PDT)
Message-ID: <8d2ba17c-ce27-4dff-9e6e-2c71d8c72982@linaro.org>
Date: Wed, 1 Oct 2025 07:30:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] system/ram_addr: Remove unnecessary
 'exec/cpu-common.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Nothing in "system/ram_addr.h" requires definitions fromi
> "exec/cpu-common.h", remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

