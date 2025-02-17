Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B62C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvcY-0000Cq-5T; Mon, 17 Feb 2025 02:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvcR-0008R4-Os
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:32:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvcP-0004Yf-PU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:32:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f325dd90eso1140870f8f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739777560; x=1740382360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kjtAISMNYxzaLdiEknMGfdENtUG/L8gSoDLLtPeAyBw=;
 b=pYY0CwXhRyL9NwdPPSJepKoSXuzOC7qO3VjFTbOcAcatFQH32gOm1g8emxk61hJUzo
 /jYaKl80wK2YV2NT7n94R/RMpfISLhsP/c0tQ6VWTy3UtBCU8RPHR+ZsMkfowx5mIjDo
 X57dY/mkgHSYhhs4GL3yKtZdRU7dZLN7GEO2UGYzrKAQ5Fg6sCvA6LSGhYT2w/3Pzjva
 9GgU5BezZ9daqkmNgipTYjmjaR9Uw13v3cemEoeKvGEciGgvfrQjWqqhBU5YlCqBbVUd
 eETHukGBU7Q/Jsrj6ufTJDLkaTyAieLHNbnQFSY7GavLl2atCwJKUDqO7z/n1PQ8ILKT
 PILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739777560; x=1740382360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjtAISMNYxzaLdiEknMGfdENtUG/L8gSoDLLtPeAyBw=;
 b=jWcUQjSNtS7Be0AzzLV5wDFWLLEUx6yy7GW2RYOpQOFjp4YxKXwoQY5+2ENsilL7Ui
 Q789i732yeB2eW7W3KWbfYO2XBWSUNDi/ovU3SsHKFfvHXaaMpwFPWxULj4KhBkZXOyG
 QxFRZc0C0ExXHd2+OgLeKw3tql+t/pUMie4ELJrggsgt6/qEUT3lF+62+s6AYC2p48Hh
 WSM0BHkGkfiVcRVCaN0S/ElrE+7f962bHuHHdTl3xPX/rWmFOP4CGBY5GKEDVGaLLZot
 wg2Td22fRweQx+787f80Vohih8NHfC+TqNQDJxemq5cBxtr9NdtkMvOyla6BPCciqbOE
 2mCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx8sSWyEd2qut0uueeqZqqvKjUNxH1fgS24DuVp+D3LNQFQSub0km6d26cNQ8Qme+z4Gtp3Een6OnT@nongnu.org
X-Gm-Message-State: AOJu0YxMUsJKcUgK43Uj48ITRidl+rM97O6YmEckxhrCV7KccQXrekXV
 rzgzbudDOUq6xXsAVjQa0LlMnogUbEDhdwuC2ihSZHqA3I995gvT8ely/zU+M6L6ph+C8ATD8Y4
 s
X-Gm-Gg: ASbGncvq6+sZ4xKf5pCLO9F+ijkOT4DTv0VNGCXhCmdQqMkRV1QeEZg9Y6rQLi4x5Lz
 swwnDn0eHa1F4ktV4RgfvR7r9cwbptY1UFVb8wInfr0NfHg7Ppw3Fs5NZm9kKiSb67Y9rhyxfJ0
 lQsvWn6rBxwMGKOZh6Y5kyVa4jvUQiBPeknz4mgmNhBsky5w8ggnnbAWKNf3UEOd4dxZSH3qA5m
 DTDg5UI2W9E/FQ+f5JmupEAxpoYwm1qzUvx1smteC5N1uUB3P/ChfCWjdPw65Y71+PF4alpKn1v
 lDcmC0ngjw0WRTyTbKDxNVl6pDGsDFMNvwk=
X-Google-Smtp-Source: AGHT+IEHcjGYbfpcCAuySiM1fGKoXT5UyhSdsY+kX96Ek29kbXtee70zs7RC5L8G8rt3c44M0oAhjw==
X-Received: by 2002:a05:6000:4010:b0:38f:27d3:1b2c with SMTP id
 ffacd0b85a97d-38f33f2f652mr9459881f8f.25.1739777560165; 
 Sun, 16 Feb 2025 23:32:40 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccdesm11464999f8f.26.2025.02.16.23.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:32:39 -0800 (PST)
Message-ID: <90dcf101-5d2b-4f93-956d-20035157a01f@linaro.org>
Date: Mon, 17 Feb 2025 08:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-10-richard.henderson@linaro.org>
 <9759c6f3-18c7-4693-a2db-8a10fea182c8@linaro.org>
 <9231fa0b-f7e8-4e53-9acf-7f89d81f6b60@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9231fa0b-f7e8-4e53-9acf-7f89d81f6b60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/2/25 19:21, Richard Henderson wrote:
> On 2/11/25 23:22, Philippe Mathieu-Daudé wrote:
>> On 5/2/25 05:03, Richard Henderson wrote:
>>> The declarations use vaddr for size.
>>
>> Which seems dubious, since TARGET_PAGE_SIZE is int IIUC.
> 
> This parameter must handle guest huge pages.  Most often this is 2MiB or 
> 1GiB, which do fit in "int", but logically could be any size at all.  So 
> vaddr seems the correct type.

OK, got it.

