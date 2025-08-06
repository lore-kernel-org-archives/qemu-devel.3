Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B55C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 06:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujXt0-0002SG-7u; Wed, 06 Aug 2025 02:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXst-0002Ol-KV
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:44:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXsr-000438-In
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:44:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so31612205e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754462660; x=1755067460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRqXKOzAaD2ikEMgvxnsM3LVwXwTBLxF41K5tQuR+aY=;
 b=iYV+c4O+oZzwyT45jmkq+XSK/tSisfkdhSpWwBL24Aq7V3l4m8uLhTy4fg9xkrvMJF
 b/8VeVbAD3PSsVP3CuXRCfuKG9Z+CJ10dsDX8GTUbU6OKIy2wFp6OezdEDJ/1ofVEi+r
 UR80p2SL5Q4T7Dyzbo3jIAElFRkcG2qy6a+OBjLy3jNJ18qAP4lv/mDpaJ9Vsl+deh7v
 vsQkoMbtKVWbKd/nf8CdMGA8u5C0acTqHUEaiDmAQB5KU6HBGa7Iz88k1+k7ItteY8if
 tC6uJe6PtXUVjOMWIz+hMkrfC+AUf+o0Oybthabmu/A/GepWPJi1fjqlJzTtfej1qQ4p
 3gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754462660; x=1755067460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRqXKOzAaD2ikEMgvxnsM3LVwXwTBLxF41K5tQuR+aY=;
 b=P8+TJGPCy6L61xZgW5MhWWrgxgarbL4kg4JZjlsBOAImEYulWzBlehYO/0cyKSsEF/
 p4dDCBQS8FdZcbAc60NCqmi5QJQ8ZMzo9Wcx8W+wS3nJ/KOBFoL1jZli+WCmcYqHEXJG
 DxQM2zVyD2YK9KWf4B/EK1TSG4COsD0/tSyQUmyQhV0T07c7bMcZxgrXWLFeko+cpLru
 DUuj8GzUhnWBH/rD4HFYyzYkqhrAqM5XlcIwQKoPNOW76PlJSlGM/og3dbcZXfsLd986
 xcQIZAZ/IKlGUQ7MgdjcpQDjFFD3NEN/2aza5j3aFlpTINprD+dENCIqKf2Yt1Jq7lGj
 K1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOU1dsx+Jkwudsd2YugAsrKBRVur7ciACVLNgFPWhLIxwUkunSj6sDiE8GONGi1IFeST+bDJuVVYS6@nongnu.org
X-Gm-Message-State: AOJu0Yw8j8Uw1AFq0BCFQm8Uxk2G+oZO6jUaTW82IQpp+620ii9AvfjG
 sUlOidcyURbTOFqT3ioJTOWfPpc9ZdiSg+D2dIR/75uegUqcnP59KVBa5ems3j5q8R0=
X-Gm-Gg: ASbGncsLuwEn6lirVE6hAEGSo/Z9b2cgq5sElvMIuEM4gCDdmyzUjJakIIuLOxx3ROU
 7OHgSlHdp4hZRmz/olzJ+XCHVJBuDzd7Z7BT8F/xb8VYG6JZ1VLE12UP8L7zIvlLVJn0zPhWYju
 UyTqDNy2s4VFzyCmx5KWbAFwX3BovWTKc0BOTQ8/7jV1+xyirP1KxO9SP1bQuakasICtdHmYQoZ
 U24nQ1mE9IWhSHYtivwUmtAAj1HD+sWhcX+T0wgKIHPpsDzk4fZbkUudPoZAn2mmiqBtvPlEAb8
 xza4II0Gp/iJS8ZoBr55uWJ5CNb8s2lJPd4orpZUV9bt0p4AdIzWamxJ6xS30upi65T6hnsLKKE
 sH5p1ZRZEjTp3GfNvhlDlsHAW9LgU8QnQ/xdHQf6aYzKWHacpahJt0ei2EhSLsMqQVeIYNUZShP
 9R
X-Google-Smtp-Source: AGHT+IHa5dpbwvkwrLyTXn/4lzuANR1QRrW/KYmlobh43kXb27EibsTFyaHOEzYp+wQLKEXkXcx1gQ==
X-Received: by 2002:a05:600c:5254:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-459e74bc7a7mr12487495e9.30.1754462659753; 
 Tue, 05 Aug 2025 23:44:19 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5862fd9sm35827355e9.16.2025.08.05.23.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 23:44:19 -0700 (PDT)
Message-ID: <8f6b3367-5be6-40ed-b514-ed0ccc5d2c12@linaro.org>
Date: Wed, 6 Aug 2025 08:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tracetool: include SPDX-License-Identifier in
 generated files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250805200334.629493-1-berrange@redhat.com>
 <20250805200334.629493-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250805200334.629493-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/8/25 22:03, Daniel P. Berrangé wrote:
> While these files are auto-generated, a later commit will add
> reference output to git, so having SPDX-License-Identifier is
> desirable.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/tracetool/format/c.py                | 1 +
>   scripts/tracetool/format/d.py                | 3 ++-
>   scripts/tracetool/format/h.py                | 1 +
>   scripts/tracetool/format/log_stap.py         | 1 +
>   scripts/tracetool/format/simpletrace_stap.py | 1 +
>   scripts/tracetool/format/stap.py             | 1 +
>   scripts/tracetool/format/ust_events_c.py     | 1 +
>   scripts/tracetool/format/ust_events_h.py     | 1 +
>   8 files changed, 9 insertions(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


