Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F43CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTlq-0005Cj-Jf; Fri, 06 Sep 2024 03:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTln-00054T-7A
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:52:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTlh-0002C8-Pt
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:52:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bb6d3e260so13470355e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725609152; x=1726213952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ClePY4IQ5rPUwpHz7dHr0W3g8ssgg0mpOFw2rTkYyMQ=;
 b=KB2wwCLjxCG3KxC+aIvG53v8PpKPT4bK7ZzgbDc50DFJbqJzPFdFNOSbw6oP4nAFbT
 sCg8txhV5dpnT7q3jWLuQslj3BxuQS1iF+wK9BAeA/W7yQWqskeXVR6Sv5oCBUuVfvdl
 /IvbmrgowjO/Z6iquCOmihawMYzaw0LkUUza801uuPPcd/VBSQqBTxPoyI3UcuDQu0Vs
 blfqITCiHTkuqWNBmgPYmXNYFwubMJmiIWX1JUseo/eD8RZvvVkZ8++WgISDo+DzE3x+
 XPNkqu8zGYL86XXAK4zC+IDTwZvMqVlEe6NXlyayA+1K77aFlBxLrW1Ey/CsjWVbKca2
 DLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609152; x=1726213952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClePY4IQ5rPUwpHz7dHr0W3g8ssgg0mpOFw2rTkYyMQ=;
 b=URLwiWRgCMeZtD6Y8T3M/YCl3QP3sDsASj9RNGiH/Pq9gPpkzfprmJ3ZWI+o5EyYOt
 upMz+1F/ySMaKgAxOWdJoaG4bxU7m3GGUYcQdS+O6LZQmac1ELJqzC7tTOoH8PKiPF+e
 9qq/IGDWQ3I/A6ILGIU3MKwSsoZ5U4BXQKGcTfwSKZU/EIm6hSJPHsMYPdvguCaIX6m9
 KWdqUr27Y+2vjbd4kAXz4R5xq0LoDm2T63rB6JXHnaRi4hm10Cra/RCgqp1LqmS6Xd5n
 tDDF9NWOw3kErtuy668QS7b5Pq0fp2DrCJYpg1w67pm7y5RmssASo9xB5/JCXjqZFyOe
 096A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhKDANngo67BmPA+i/7tWODjCPONetKgpHqvR5FLkLgjoOg4UdG/OBvz2xWG/C5sOIAtTMudUxiZgG@nongnu.org
X-Gm-Message-State: AOJu0YzZwrO1q72SGWnUOOvUa0UGcn9uu5HiCfzp1tmbLUmnuHkUPulW
 /hMD9ZhuGLld/jyjfLJlOxPfk1a6P6h0w7JJYLSbNrs0lb6W7yN8947evq3xXO8=
X-Google-Smtp-Source: AGHT+IF4gXGW9V72fd2O6Nc/wRjuRRV3lmh7xDcz5bAQNNJbWLtWNK47nkJlH7dKVcYR9WRTOG7htg==
X-Received: by 2002:a05:600c:1c13:b0:427:985b:178b with SMTP id
 5b1f17b1804b1-42c9f98a3a3mr11887515e9.16.1725609151941; 
 Fri, 06 Sep 2024 00:52:31 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c0f6f4c4sm15710764f8f.44.2024.09.06.00.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 00:52:31 -0700 (PDT)
Message-ID: <96a96a7a-f3d9-4d0b-9a32-52d13134a74d@linaro.org>
Date: Fri, 6 Sep 2024 09:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] minikconf: print error entirely on stderr
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240906073328.492089-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906073328.492089-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 09:33, Paolo Bonzini wrote:
> While debugging an invalid configuration, I noticed that the clauses debug
> ends up on stderr but the header ("The following clauses were found..."
> ends up on stdout.  This makes the contents of meson-logs/meson-log.txt
> a bit confusing.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/minikconf.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


