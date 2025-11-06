Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF37CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxcd-0004Vo-Nk; Thu, 06 Nov 2025 05:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGxcb-0004T7-Qk
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:53:41 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGxca-0003aG-Ce
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:53:41 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so1398187a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762426418; x=1763031218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eyURELlwRwzcUSYbKuGtX0DFL8sd2gq4u0DGvH/VbXM=;
 b=PxIgIfdurUD07xjum8X0P2pow4CHxZ0yytJkFKihqx+cz/ooYd0Q43m2mAhb2iQtvY
 ZUeNKtmppqYitVfJvqCOs5jNJP6/ynFggV4PzBtWNORaq7jCK4yKvo0l8XgiXyMQkJbw
 l4zTRbHkmAr+p/UajAqYu5m0AnuAmiUNVtouVqiqXCY1L19+uzdh9oAIWhJ9NqGlzsul
 4anmM9q1l3coMwv9SzJixOkN/Na8n/MQu+W3iox/tHNp+i23Qmu1QFZaBzgWYxWORSBj
 LgiVE0MapDZYPeWB33VO0zmOBQgIMkN+VBp38EDeNT7oqaIpDnVbfQaFTNf1bryP6ie2
 8DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762426418; x=1763031218;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eyURELlwRwzcUSYbKuGtX0DFL8sd2gq4u0DGvH/VbXM=;
 b=Vl5mYL0hhucQNACWKz4HLMG6wWEqlkELvUdt8nZKAVdyQHnjpkjGSpM7aXTjF+BEw0
 u6wuO6lqYeC6WZ7xIha6ulUwsLGybK/ua91U/LSCKnyLvGLDCMlam8SSD2vK+KRcNI7V
 7xmBPinNl/WGkMALjmlMlGQrCesDn51ha1ULJ2xQdFQ+gGfKaf8v6uC/5EGmj+4a/Nxj
 r+6r5eOvqgyZAi/v/gA+a53UTvqLkRyqXPHtdcBBAOiCpaQj1NZSL/bpTsNdsz7eEEvN
 TzyWBKz54EEDwDbelc5uPaBuhK2VzhoL9wDCC90tlE+YLK9guaSgLrSGMAQq6VLVEhqc
 vC/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8KHAILewPNkIcd0PHz67u+MYe5bOumcWzsLAR2yNi+pg0L6LTakbHrNCjLj8E9O1PHXpypo/NRMit@nongnu.org
X-Gm-Message-State: AOJu0YyYh9xCF11hjZPHNwxDEHF5q07x6+KL9GbN6tWwPY+VG0QCJVCc
 gCE3tymFDvrnE6A+/bfB80Kr+FIxUYpqqPAOIsjY5wjCdCnx2jQtcO72dC3YuSXY0qU=
X-Gm-Gg: ASbGnctBV6ZLvYMU4Co5YlBicO+VDb735krC3L+tOjjA03AdS32q2wEx9aNslSTEI3S
 RnK3Olp663kjDk/09/c0+R638mw3lQlOPt4vGIelVjC8fA+D4aHRmvf+HrDk+wud8JG5wROl7iP
 p5GMFviJ5lhkHCs0GCWHqppnuF22IHoy4GoaMk80THZNyJ1jTN0TsUxp6/umfbGfKWQjCtgNxGk
 cFzMcMeROAysWT4V1ClA/72IZ+gQU/jYY4z3CXm9/Fi4EA5irEs+zOajA3QgmgTUPCRDej9Vxpr
 eHTymTEE0pUyH1VWZaLIAPM6ePc3MyvtEYIzqmvDs7APThwBkk8bf1Kl9DvPFM9jFN3uTAAO/IX
 aqKURktDGB3aNNJwqNEhbbnOmsbhRAMSM+JwE+Ytba66GqBw0HyM6YDYKRMwU9U8kJSTJsTIIaw
 /hHLhgS0Y9fcZN8PuyL9TnOxCiz4+rz1H5dI5LIA==
X-Google-Smtp-Source: AGHT+IFCq2qBl22N7SWY73+LubaoKLtRcCN2Lr1H11cwVxKMoTpLaULm8vNTn46D9dfsETYI4B/CwA==
X-Received: by 2002:a05:6402:3489:b0:640:9cdc:aba7 with SMTP id
 4fb4d7f45d1cf-64105a5b16amr6154552a12.26.1762426418665; 
 Thu, 06 Nov 2025 02:53:38 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f8578d4sm1523440a12.18.2025.11.06.02.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 02:53:38 -0800 (PST)
Message-ID: <caed003d-1adb-4df7-8642-edbd1610a2f0@linaro.org>
Date: Thu, 6 Nov 2025 11:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] osdep: Cache getpagesize() call in
 qemu_real_host_page_size()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251103105111.68294-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103105111.68294-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
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

On 11/3/25 11:51, Philippe Mathieu-Daudé wrote:
> Cache getpagesize() call once, so we don't have to worry
> how often we can call qemu_real_host_page_size() and
> qemu_real_host_page_mask().
> 
> Philippe Mathieu-Daudé (2):
>    osdep: Un-inline qemu_real_host_page_size()
>    osdep: Cache getpagesize() call in qemu_real_host_page_size()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

That's a step up, certainly.  I had been thinking of making it a faux const variable, akin 
to how we manage page-vary-common.c, and a high priority constructor.

With less efford you could mark the function __attribute__((const)), so that the compiler 
will CSE calls.


r~

