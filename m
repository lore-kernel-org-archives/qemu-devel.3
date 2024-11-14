Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDEAD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBg0A-0006O4-74; Thu, 14 Nov 2024 14:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBg08-0006N4-Ck
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:59:36 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBg06-00019o-RJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:59:36 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720be27db27so861466b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731614373; x=1732219173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qYw/5xHcyUvaWdcr+DqLAPRs3FLnKC1DNON73mpwic=;
 b=k6+55huU73fCEmRCJABbni2mru2ZPZ5vPDwwKJszNfwaQMO7DEpCtMBiX3h+W3zOfy
 jezBtgxOgjyNItQ98JvaU1OOgVRRd0Pc3RWKM0i+bbhx+wwk1QQLDmQiDdmfu/sTdiZu
 GpHGDIzxvfiCj7WVyPNlBj6zpqSuv6PX3q4V6PdtRYo7ut87Ly11CxTmsHXB79ykjN+P
 T4k1EHRrl/Y4uM2Kmmp8DzGoPEkx2Z4z3AiT/3Fa6/Clh7RUuq/uRXzJcw6jvptqU68q
 GLvs2GtvzAk0kGZOOCUukDIjsRa1xPIRE5h5DZrGTPcw1KwviDOmZHnd+Hhzu/RPk/Rk
 cykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731614373; x=1732219173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qYw/5xHcyUvaWdcr+DqLAPRs3FLnKC1DNON73mpwic=;
 b=q0rivfNn0D9vPpUfz1L8ji8Ic9bVTMmo6kNXmujeFVOSfeRHqawqS+MkvHMxWzOvqd
 0eJLdtuGz4G6CGAOOJartxmnw2KqAqseQfCl15EPnLGoboGRis/bZBt5F1GyVGoXSGN0
 87E8U9OG9vCpbTDyzTjLMJy12MdJUWAIoSL1fID0DGvuxhL71VugyyHVDKdMBnc/eNm6
 B7oPc3fGIO7iV9MwF/6QPb1MbyBJXW4z7QbE5qqw2JE11vZQcbzEYrg9jo9jWo+T2mDs
 BkM5j2ezS+wpkSmxagRcS1sMWFqd4UbYJgelSPVj96bG6ACslnROEIDWjJk4XukRf7DL
 V5Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGqc8jxLyKDBbX9K0jFwzgtfgCyZ3B4j9OXHFimJdM+vtGFKzBv35yQ5K5HCQgpsoo4BFGRFnYKMNc@nongnu.org
X-Gm-Message-State: AOJu0YycnXl2GOCyY4yk6dyKAV0FZvxh5rVsmz2jrSbBsPaBnonBSJAT
 lnLuh4Q2mP+DC7SXxldmDn7RpPidN8trYujYJ/WDj//vuvhL/HQr+9i2gr8Jf/0EyxCEOfCx/Fj
 J
X-Google-Smtp-Source: AGHT+IEYzbBrbb1mIOIOhkjINXYRzGCcstpoZvWUAGnXtLwwV7z16KBMuTJFWDLsUOYRMPaTANfx7A==
X-Received: by 2002:a05:6a00:a18:b0:71e:6bf1:158f with SMTP id
 d2e1a72fcca58-72476d26c8dmr89396b3a.21.1731614373041; 
 Thu, 14 Nov 2024 11:59:33 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e1c7bsm15261b3a.146.2024.11.14.11.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:59:32 -0800 (PST)
Message-ID: <e39d524d-ba9b-46eb-8d2d-739d001ca59e@linaro.org>
Date: Thu, 14 Nov 2024 11:59:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] exec: Declare tlb_vaddr_to_host() in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Move CPU TLB related methods to "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 25 -------------------------
>   include/exec/cputlb.h       | 26 ++++++++++++++++++++++++++
>   target/arm/tcg/helper-a64.c |  1 +
>   target/ppc/mem_helper.c     |  1 +
>   4 files changed, 28 insertions(+), 25 deletions(-)

Hmm.  I'm not sure about using cputlb.h here.

This is general-purpose guest->host translation, with or without a tlb.
It's more similar to user/guest-host.h, but obviously not user specific.

I think cpu_ldst.h itself is ok, because that's guest->host translation combined with a 
memory operation.  But I'm also fine if you want to create a completely new header. 
Perhaps probe-access.h?  This is the oldest of the family of probing functions after all.


r~

