Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CD8C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTB8N-0000ET-Lg; Sat, 21 Jun 2025 23:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB8M-0000EL-6M
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:12:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB8K-0004BB-JX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:12:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c33677183so27545985ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561959; x=1751166759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=anbwKe2eJ90BIWlsYa+Yu/LYDHfqTin3eW9lYYMIlmA=;
 b=v/9i3MOjmyVOodwIi889zDleJqPTY+JM03UN6oG+Y63YAr9X7RyKfrmoVG/Ox2mnPL
 of0M3dMVTQBjeblC/IdfDZ9rt853S/9TW8fmVj1IJxbfqCtqZp1eNDY89B0IqJSHkip8
 vrAyCt8GYeHXu8xnCWMj3LPpC4eYOXO70r3zYDydR0lxs9vilvZ+0Ofp4DwQZw9JwbqL
 doVDJ/ncZskwH+TL+nClHx2wk2YKzA4L9G8vAjkub9VpnzG7fDh07T7hgE5s/7XAceF0
 ghP6PX7ISwSlRrRYxJhI1BEmrtiIOz43dVjcwwv6nYbj0ZVpA2PQLekXnMbSVY2OvXdy
 E8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561959; x=1751166759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anbwKe2eJ90BIWlsYa+Yu/LYDHfqTin3eW9lYYMIlmA=;
 b=J1gjCdONcIN/d0eQSVlp1GrswZbdbaZVSpSqE1nip36bJdq+Coy3lAH0FMXPtG3SNp
 Wqtm+37QV7JaNG3C+HsUQUi7RG6Mn++uA8CYubqOeLXeGpsQFoo5Y9WzfKvifB2tkNJh
 qr/+mo45GV7Vf7gkC1mQWzkCERkWm96Ol2g3Ggjc4N08q+3HuvF1q15CmrZNS1gq5iBh
 PRjWOJy311Y6yF2zpkhntNlnjnYXdJYIj44khR5O9OnYBxS+fdTHHIqi47zW1kwYDp0X
 1SCKLVM8xmRQ8pUKNqLwsly+qJYw2+hBVlmdAhSAQPhmOZzzSOKrjejfmF9nWNfzW2t2
 Igrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdeKmHCaRJQKzQw7b270VpcAm6WgkyIvegn4bteasJ1pHfXrZLBJr6dMyTzrOqApeUMOb2GQxHA1E4@nongnu.org
X-Gm-Message-State: AOJu0YwK1nzUsqH9w0g6m0Re9eIn7eiFX3zbvoKqX+OUsVW0wwOfFtHr
 nFMMdsDr+Ydm1cry7bougONKePCQq36IvYr8gW/Vsg3VnOKi6NkSb+LH79MEBrObzyw=
X-Gm-Gg: ASbGncvOnwnAskaT9T5IruHbMAUeU7Aei+34VYFDstC+OIeR1YduMF+qCJo68T1lfCo
 d70LbcnsWVMYW2H//ropIJC2OY/fFMDpKQ+VHLVZDI/XTP/M/q2jcpmPXlxRi9HbLE2N/H0MaOC
 y3l3HLRa3UiMjXTZ9AlmzP1LrzDeQG06QAQN/3c99uY7WNh1VakH66E+adTLdwAVWYf+HANZ5kX
 f34soYQYWRWI35SqFZoyDf7at6MZDkkrsAu2ur2o+Tz0hKQcjsWZJgV97IFnEMRqhLjM8SR+Ztw
 PUSbJRM9Umue4WURUi3K5qeHTgzi57cS66tKkXIYQUpqt/LGz6vIm7K1+i/jujrxWO7Kbmm0Hyy
 I1BDecLyHHqGH9xoVKxRRprePK3zUpqtFEpqpDSY=
X-Google-Smtp-Source: AGHT+IGyZkBMA3wEvOzOg15/P+OPVL00JzHFHM/kil17u15GhaEP/g3WOg+FBf2xwcuK0zEjTTnmJg==
X-Received: by 2002:a17:903:4b07:b0:234:e7bb:963b with SMTP id
 d9443c01a7336-237d97eff8cmr120456385ad.16.1750561959013; 
 Sat, 21 Jun 2025 20:12:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86d77b4sm51509035ad.205.2025.06.21.20.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:12:38 -0700 (PDT)
Message-ID: <fc91e38f-11e8-40e7-b3f3-4b33c401dfa5@linaro.org>
Date: Sat, 21 Jun 2025 20:12:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 27/42] accel/split: Empty get_elapsed_ticks()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-28-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index d19b4641a2e..034b5ebc96c 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -255,11 +255,6 @@ static void split_handle_interrupt(CPUState *cpu, int mask)
>       }
>   }
>   
> -static int64_t split_get_elapsed_ticks(void)
> -{
> -    g_assert_not_reached();
> -}
> -
>   static int split_update_guest_debug(CPUState *cpu)
>   {
>       g_assert_not_reached();
> @@ -307,8 +302,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->handle_interrupt = split_handle_interrupt;
>       ops->get_vcpu_stats = split_get_vcpu_stats;
>   
> -    ops->get_elapsed_ticks = split_get_elapsed_ticks;
> -
>       ops->update_guest_debug = split_update_guest_debug;
>       ops->insert_breakpoint = split_insert_breakpoint;
>       ops->remove_breakpoint = split_remove_breakpoint;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

