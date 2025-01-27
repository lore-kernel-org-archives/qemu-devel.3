Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F6CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWU9-0007Og-Du; Mon, 27 Jan 2025 16:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWTK-0006wC-Ll
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:16:43 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWTI-0001WU-Es
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:16:41 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215770613dbso61439095ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738012599; x=1738617399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtSUBFOJLSoXX4z7f3NYjxcYRzGB+wfIl27/EGyk+uA=;
 b=VkN6zfEftz9JdmTfiXY9YroXPOn0VAYttJNaC4sc86uYpMRUPGuTZH4VkCAGTwUzcl
 wUEsYXDEhwFHc+hQDzwjjfrxM4tVItnvzklvJB+yO8OyOX/4CDxohaWOyC/eOaOXjMyc
 S3sx9Y8CrzcZ6o/hDbaNhUIcBybLSjI4K8UUWmB7J/W8SvkygbOA/RDP2E5o5WdqY0Ke
 XHC+3puRhybvLnwKx9jmVI7Xd6PJj1qK9Rvnk0rj4nMK2EazLcvP4JH2YJe10ok4D/OR
 OAdNX4e0P4X0xUELoAlKYcylOlJi4c+3237CB0hy9kNS1qoYrxNsyNtNX3uI01NbL/KR
 bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738012599; x=1738617399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtSUBFOJLSoXX4z7f3NYjxcYRzGB+wfIl27/EGyk+uA=;
 b=okKa+CsxksvfCFYnvvQ0tfFpBjCuDaKqPSK7qSS7p+eF/Zv89uRG5J7EALP5KxHZs8
 8GSFl21aLspx6BUVPm/4zffnI0WlrKgh0IJkI62eSW2iCvDfJK4RxirMSf2WFMAW/J3m
 /aIFPsNheI6AIZGXmj3eWvn8zxbfNpn60X9ZSwNSYSi5M1fG5OzdqN5WbewRIwTPrGrJ
 faPWxwmb36P9n4HfO+ekJN1QSukyG9ylNSK7TeLWqByrWGhTe0SiaCF6buD0tPqNT3Ip
 xIvkcOWK5R5m+zkFm84cgCwdgxyFAogdgO3lkhxOxenKL08h/EYU5JzMxIelQMO0qLdh
 LPew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUASQoDBNvpDI0tvGWt2B19ZJLQl4weVXMaFNFLb8GiaoPyDRuW/NJIinQNJ5s+8T4JvH21m/0uJSZc@nongnu.org
X-Gm-Message-State: AOJu0Yy+M06WtdpMoQYF2nipPUzlceq85BKi5GWE16giz+Cq+9n8s6D0
 h17DEdipZCcQVcaduRNoqTdXNiLwQ+MlMIUC6IRtyXRmu12S6k1LjbKqLXeeKmQ=
X-Gm-Gg: ASbGncv9v77SOoNDhlNZA475s83WKrAMW8C2kcH+QQrLVBmCnYqONgr/4PThxL26Mhz
 +YaX0s5ddSVzcwN3+SZqKRAjcj7NQkdQEqCM6XJfz6EA9eEqOO9Iv9LJQLopzrqpZsXVxKKC6VV
 iS7OpnrvXiRAgVaq7kV/obSFg/L7z+aEcB8ISYHue8cT83ieytIqBVfQFZ9oqL4xNgEkDNkOx8V
 025IQIXBPvFVF2KCviDgplGbdPF/nIiCRyN6WnlZ5htgiq1QErUaCNx/j6MfA6WjDpLvOmOADm3
 OJVZ/fs5o2b0jRxiVsqaTGohnYGpJ7ac6zqOhwIkvyyZ+sg=
X-Google-Smtp-Source: AGHT+IF/pCSlPiV6knN8qyWsXMk5lApjJTOZj5MEgvdJBBS9R7gD71FF4Oe4rTGAkb5t+XvrF4cTSg==
X-Received: by 2002:a17:902:db07:b0:215:b9a7:5282 with SMTP id
 d9443c01a7336-21c3554b516mr612350665ad.26.1738012597570; 
 Mon, 27 Jan 2025 13:16:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da4141d41sm68618195ad.126.2025.01.27.13.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 13:16:37 -0800 (PST)
Message-ID: <6ddb695a-44eb-4e9c-aa41-067c79ab87cd@linaro.org>
Date: Mon, 27 Jan 2025 13:16:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/loader: Clarify local variable name in
 load_elf_ram_sym()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250127113824.50177-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/27/25 03:38, Philippe Mathieu-Daudé wrote:
>   #if HOST_BIG_ENDIAN
> -    data_order = ELFDATA2MSB;
> +    host_data_order = ELFDATA2MSB;
>   #else
> -    data_order = ELFDATA2LSB;
> +    host_data_order = ELFDATA2LSB;
>   #endif

Worth squashing

   host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;

?


r~

