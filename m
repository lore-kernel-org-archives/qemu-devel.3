Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD61CCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pib-0001Zx-63; Thu, 02 Oct 2025 16:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PiX-0001Yc-GH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:57 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PiL-0005g2-UT
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:56 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3305c08d9f6so976575a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436139; x=1760040939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/PtlQh+Stfjrx+MydcidiQyqaNe+egqXHpI6dTwFNvc=;
 b=aTPVMA/xNH8QfRK0c17myVcz+gV15nMKFxeKnkuS7N27T81KxNvLZZQNDh7fHmAfq3
 WABlwyxTVVSJOKylspnn1EMdA2Hl2xP/1JyDfGpAwltP9na9KTFvhWNF4PdM/ekWI8ca
 KHxKM5fbUSOV7Nj1AHb90MPMsKt2t54k6Yc4VkI+A2A50xgP6wap7dDYZ/9Jg9GcwoIX
 FD4xV0L20cwC52XVOc1OQJ/eRsmd24q01AgcQV2xTC/tmwndOPteCxe/C4NFr5P7wON2
 jSFMMIxjqZY9s2Bpup8tHK7ly6YUV6SqzP9aI5g+Wmb9A3YWvI3Xf6rWIcc7krM2raOA
 0MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436139; x=1760040939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/PtlQh+Stfjrx+MydcidiQyqaNe+egqXHpI6dTwFNvc=;
 b=JHOZXK6tvsy93Ywo0WnwJ5bKww5rETD5hKQBE1P0EIg6iAZrha4+CqPlxQKMRTt7sq
 8Ev5LyRkq5oSto7Q3YKQPJlIIAxtyf0wkgo80/TcxVtvDvWyeuPgvj1gUqBt6BoCvv5x
 wlGD5IM5O5+e9DiD3J1S8kp5G0SJe62RYkju8o8tYXG2QwW0SJ8xJ5K+0XMvD7Is/fI3
 lm/8Tb4jMiqDwQh6KZJ0gMmHNGIQ47ntJa0CXVRggoEjkRmhiTAQS/iJAJgIZo0q+qw/
 vA++2HyK1BsTeUkx82+5Mo/klfbJSLfhEK9d3KfzdK896yZhnxGHiZDjEFGXc7DFLmaV
 /+5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAAs1MoKIv01WEDS3EuAceMXNIy7ECnjZmr94jxrPOKiaoJWOvSuTJ4HxCUwczqc00zTR2UV1Fkopm@nongnu.org
X-Gm-Message-State: AOJu0Yx3+WuozIKmP3VjHdT3T5aoFZnw+W9W3yC/n4TUYgyi/MYAATXI
 yOA8FVtAdmm2+Llx82LEkDiXlWniQ5p4cv34vPMKz9AFYvuh9fWOC3vyEhidd1l8ITE=
X-Gm-Gg: ASbGncuxYBaP4zBSIKrU++rxunmcr5X4I6yxSLtcU3KSBUDAVwNjlEysKLBBAmuDaim
 T/qTHy9fFhnk/6JJVJoz2YDPRorxtznUmqP+G9+y07cWGke3YXMbYldwv0pTYpdwShwjvjNixR3
 XEPq0qUmo7hv4yOK17FlywcXQwFAZBcjUiSv5Xkk0bbuHZBYruY0wD352ABY1t94L+Ph6+Pjnh0
 4vbNx4vhg7H7INL3VGfPalkD//pP5ysncfxYLf5BV8FA4Be9rFph4RTroe7u3Bf5JSkk154vuk4
 PAwpvpDkGyN/QBtBsgnKLocO7ZKkHsnujU+q2bALWKbAqE/NzVsrYJVOpNn7DmM+R8Uq7DXxygL
 BRjB3OF4pX5PkhtIp9wFYfNANPpPr3kUMlBb+2FcBzubZnNR0C+qj3hx0e0+3uFM55nyMuzdqoA
 ==
X-Google-Smtp-Source: AGHT+IHE2xLLLppYaKb7lEa/gSg7Jy+fCDKgsCoPhsTkqEtdw4dqlyC2h0lk31cbb2DQt0m/e757wQ==
X-Received: by 2002:a17:90b:3b82:b0:32d:e027:9b26 with SMTP id
 98e67ed59e1d1-339c2226fb6mr793217a91.13.1759436139040; 
 Thu, 02 Oct 2025 13:15:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099d4cfbesm2660489a12.28.2025.10.02.13.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:15:38 -0700 (PDT)
Message-ID: <61286b8a-e34b-4f44-b99d-13a483377273@linaro.org>
Date: Thu, 2 Oct 2025 13:15:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/33] target/riscv: Indent PMUFixedCtrState correctly
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-26-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-26-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


