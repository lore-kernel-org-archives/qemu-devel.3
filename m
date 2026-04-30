Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A347FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISQZ-00072b-4d; Thu, 30 Apr 2026 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISQX-00071b-C9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:31:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISQV-000116-12
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:31:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4486b5fcf3cso920622f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777559497; x=1778164297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjwbtqbvdJifJ4RbloH15/lqxhauofO9ZILWzb8xiGY=;
 b=QlPEGeSZBIIg+GTd87LwAlvfZukh3aVlm9sWisMwKd0UUYofYeJg7iJcOGXNPoD0HK
 o+NR7/WATukLuQXrgALsW+ZCq76gpXHn5QIZhkPQ2Idyjw8IY/zRDLoLzgTEza9iBtY1
 /14TgUASA9FDIt8psL7KyoSnK54DbEg9SHSIiXPUJH8HzpWldUmIAxV4YgIp33zx/Otp
 +ieN0fpvkAYAjdzogKGaO84VeqpG0lQW8oij/nl8ZiK1LZgWunvVGmmCxYJlUgXx4g+h
 HiDWQljcaKoXqyIOufPNC6rjFml+/jiIKSkQhGQ2DRh3k0tTItzpw1tzRtGv9/pjAbG3
 QQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559497; x=1778164297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjwbtqbvdJifJ4RbloH15/lqxhauofO9ZILWzb8xiGY=;
 b=jhkEkLQzNVki9JFVMujR2ecwFo7GD6YBDzqxm810fcYGgvkP+rmNJZ4ecvF/zvJxOT
 AW3X7ycuYRuYZFZEceErQ5SY7dJNvWwKFTAi8D9VOF1TKPUzdteg49jXzxu0xH+AfT/l
 KmASuH+6m7UpfRU8Hn7rux6sDSLsPg+PcM1PQMyD1aNbw/IGGlMeVV//pxEC5R+YdUrd
 p+UGYkmLL8wjOraUynU8LC2JvL7CH8NK/sNuMmPLPuKsPpYh0+hc7Edwp6fJQGSvRNfE
 2uHeq0s4ZV/BkluO1HoVuC7n7DXmoC+XVaqAqd3aSspq4Q0EGzyT2/9+dRRNgMiozRRN
 CeKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VHCtS1pReUeLj7fjauQLhVKRuu7QBeIxJQx5xqeQDpOYKjOHHxR4/LDWlsMWHKPUl4pRTnyGFbAQo@nongnu.org
X-Gm-Message-State: AOJu0Yw4LPsS0h7qoGYzTVpzRwf9r7xg9/M5JpcscLa7zJ2OMRA7fD1v
 DFbFzC6QlasbYJ+ckOCc2g70wcYmyBTjSKWiRyHXxKANtc3zm99LpEXSYSQNrGR0FkU=
X-Gm-Gg: AeBDieseHrahkNvEBQR3/umux7x2ZpRSckLPh0XLqFg9U8xUbqjjpvdZBUpGYYr2Lqr
 Atz1XMlp7NwxwpdTB47E5BiATH7yKU0+5XGJqocf4OULDvzzESbq5vysUToc81sBf+k42qHUr1p
 QyZmNjrWLmf3Or8yk8pijlJ48FgaiCwsy5tWMK/1/oHgvS+i0Apcy5aMe0KFR/68AVFwfT71TEz
 LxKcqWQGIiuiEq9uiZ5F+vQ+1IS+KCK8yopSo7jvYLIw/2U9sP/7FjqVNhWv8qs0UyN02N70DU5
 X9q6odXNeCifGRnTmS1QSDjlaLphGvMoE4m0GYR/c4Zaatub2Vu0IJm1fG7j94Au5PULxs9iZ7G
 6atziZOyokWy5TgCgayVCs0nDdjBzUtj9TYVspAphAUzGyCUM+Pm3TTRvHo8DMFRhGHdCohZdmp
 Q5N3uMD8aNCVoPD+fJvib797E73jefhiDgbPxzE6prSyIqBp/CxeZrta3HB62Njgahoqba+cdGm
 /dg
X-Received: by 2002:a05:6000:616:b0:43f:e721:76bf with SMTP id
 ffacd0b85a97d-4493ffcd5e7mr5244669f8f.41.1777559496683; 
 Thu, 30 Apr 2026 07:31:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216dedsm14897718f8f.13.2026.04.30.07.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:31:36 -0700 (PDT)
Message-ID: <279bff2a-ada8-4ba3-b65c-08248a11995b@linaro.org>
Date: Thu, 30 Apr 2026 16:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/25] hw/i386/vapic.c: Use cpu_translate_for_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-20-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 11:38, Peter Maydell wrote:
> We would like to remove the cpu_get_phys_addr_debug() function, by
> moving all callers to cpu_translate_for_debug(). Update the callsites
> in vapic.c.
> 
> In the process we can drop the old "OR the page offset back in"
> workaround that we had for when cpu_get_phys_page_addr() returned
> the physaddr of the page base rather than the exact physaddr of
> the input virtual address.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/vapic.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

