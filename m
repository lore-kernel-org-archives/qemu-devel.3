Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FE9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYT-0000Nc-Qq; Tue, 13 May 2025 06:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmYM-0000I9-2p
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmYJ-0007uN-Ex
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso54161525e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130878; x=1747735678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=ZFnEXPCjVPUD5cCedfvBVxFJvEvwoUiJt7+UXmi+t3ntXd9uPWvJyc3WEshCj108y/
 zU+i7GlX4oOXSHeZTJczc1dLS2gku/WeQ0qgWwXtkgruEiz9/EXcOcX94KTb775QOUR0
 cGfOh0adC0qrdGxEuYhMGfwYYVEjyBatasSkhqiNADpC3kGubV2D7emPpNjIays9G3T6
 EUSc9yNSLdIeahfCbGZJvFIREtvjERt9UKKPZuI8DUq47QlH53eamq9Q0r1yNZCSqOFS
 lyrlMPh3HmCoCL/+0DTWfoIp/c6564/uOdjCPHlQGiecGpA7mwEEpm0lYYCbwLVo6wgX
 VKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130878; x=1747735678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=EbfDkbJNud9uka7EnyC+QTQLVLlAxT3eWYv0kLQOVkGIO6qqxCBvAsHjmHKpAN6oen
 mA+Lg5nTe558qxI0+4DpfTjAAFW9BGBYuQciBZjQZRt4ItBIDiRaYWvN5un+cHg4mjK6
 EUGrDcVmwg2OeSXU9HrBDLRjeL7e3uIn4M2JRM0G6gp2ZFnqU1c1Si0tZBUABI/eCP+E
 1L3pLFbdRnIgfWJiWOFqTBcgbWTAReUy6yZKlCptQd0vSJ+Kl8YYMpmfbuSxdv0vxvMy
 NxHWmuuKHQzhWciNmZgf/lsnISaVRU/7nD6txeyUNtou6jv+QXMI7fxl6zNOIYbVjyOh
 gY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwODaSOxZWMq7aUj+IwzejQmSwcDbC2V9uzQMDOfjS1oCA3pS50CP5k8pJrNFJgoC7d05IQAXmTTQP@nongnu.org
X-Gm-Message-State: AOJu0YwgIoV0Tfg9yR5DfU1piqAyHOW/uvasojlUNeZaXw5K2ioSxuNb
 eDTmMkcjhD2qIRhvYnD5BR94CAQ7wBshjUhuawf3cK6zU9Xn+TDNaXxRVLrFGCY=
X-Gm-Gg: ASbGncsAvgXpaWMaKCdHsQuTBJafjZOQpGbMTwgakL+4EZygQvbXdqKqgA+UuJGk3DQ
 yVkovsI7aAJnjwOpz9a7bi5Q7u1Gn+plQJWaoeDSz7Fbw1XK4BWFTDkQUYbqUROgbspop1nl2jc
 V0j+rOaCgbsFgtiKIXYjK5gQ8ul9f0QbXArJzml69Xd0rJ13a321nsLJV3bocmWJ4VxQoEDqBVo
 cz6VeWtBWDDxTCgCq7p+kM4g1Z2nTnlUkJxvWwfXVAM0ZbwlZKhqa/3rpBeKDjaXp0OGnDJ6KqU
 MIcFQzTw/FozZl4hbQF1EgyxGOqrZnlRy60y3hTJ3xsEVXXsktDMHhXZ5JJXZINHSJk8HxNuTkP
 eIYgqYJ+LiLVpBzTsFf3y70oiXnmj
X-Google-Smtp-Source: AGHT+IGVl3rC7KK+BwwSzbsyoT3gT98jHfPfE5lBvTNtcTCODedbnoCbc3sTwSrgs84c28D80Z+Seg==
X-Received: by 2002:a05:600c:608b:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-442d6d6ab7cmr158700585e9.16.1747130877943; 
 Tue, 13 May 2025 03:07:57 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd328455sm209323035e9.2.2025.05.13.03.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:07:57 -0700 (PDT)
Message-ID: <09194fbf-a2a3-4166-8f28-9a43f02b0df8@linaro.org>
Date: Tue, 13 May 2025 11:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 27/48] target/arm/arm-powerctl: compile file once
 (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-28-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-28-pierrick.bouvier@linaro.org>
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


