Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDDCFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSm5-000241-Og; Mon, 27 Apr 2026 16:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSlx-0001vc-Sj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:41:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSlt-0004qM-Si
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:41:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891f625344so96550515e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777322494; x=1777927294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REanicuq2dKImBx/Bu/a09lwhy+WZUiQ+xOmbwRpLsc=;
 b=JSwRgaNadHOzgwOxOyMk1eXGduvmdHnr6gKHWDONGaWfDw/Oz1JSW9C0jtBpS7lcwv
 dUTJ002md5kw9UlkTuabqhhuJGjtw66+k/6TQ6cnpvgLLmNBFyXxff1zvYtndTjvyenO
 /b2oBlCwaKfg1oO+aFFsu+QkM0PjXDOV9dS80Y8BaO8q0Av2xF02a38CqSAlHFsThKFq
 OZCfyJLVnVHAMuIlgr2wcsKLkxP2v91Ht6FVuFPD95v7kJ0HK4zVW0ReHt+O6Emp0iNZ
 EBtHa8Hpv7k+dbw6Y1/AosIqoaRq6zrlvndGBdMz2QfYJT0jAf4vsW2QAnnMuwbbtTBI
 jDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322494; x=1777927294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REanicuq2dKImBx/Bu/a09lwhy+WZUiQ+xOmbwRpLsc=;
 b=dxDDfJKp9KhPrS6l62hqN9tK/8tA0jdB/Mo2pQzEPOWjyxiWZbwyybV8L1YE0WB5zq
 WMnhFWB4a06gsJVI0ddwdyOXEQ6e1yUB2lS9ClXaJXRvn0w7woWqMZkoSsIAS/VH4nKS
 lG/zh2KKnaF7pJ2fR42ruENlDDfU/uYOQmowZDkFuih5yATun1t9BMRpK+JooEI3NR7N
 m4z1TIDRSbW1usAaaGScVeZYVuJWXCsaxqSWwLjqXTL6c9rFDcllKMAAkQhCmWfBmOi5
 dIjUL/of+z5A++3VIU6+VY+S1PwTeegyKvDeqwqfotdsTSlkS1oqj0PRcTGakMcqk+Al
 RUVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OxZ/ttR+sOVpZ3TJgqcijmjcHCn9Q69p69/EbPK0MWDskBK9rmf9nhdIjtTkWcEe/sKiP1oNrM/Pt@nongnu.org
X-Gm-Message-State: AOJu0YxPGcUXFuD6aLo/LL+rK6rlcgCAtCai2PYx/kTK941niTbEsVZS
 1VcD4opgALkIFdcxhRZWad3JDqOZ76/ZEFBwsulteIEOgZJw+WVlS9xw1Zh4TNcIlxU=
X-Gm-Gg: AeBDieuh9MMqQgATXI5eGFX0jyV448SmnkSGeuNEDpkZ3s2zVyeguIEBNDHFsleB6xK
 9XjuSOBhWri/+rxhXT5OsIEk7OydAZtl/FeNfvwdqnWKueaH7sP+oKSGWY7UzoOFFcYkLvsoV/a
 QyUeearCbbQ9IHbTLu95SI2A1+jeqmiaDfyBKo34QvQ1mka217w2PTikhgCSF0QVI80IoGk5mXT
 uNxAEhu9mF1OhkD9qUSnoPYoaxHA8nfKaGuOJU9s+MN7s25eQbZ7vEm64NuzZrxuiacOC+C53AC
 E1c+b7DsoJIQUjwVlMS+UWoeveaFtQq6rRVnhzvC1PejfUHyxvQgciBcx98W8pbepKkP8/TC6D+
 lx/Z3IGH7/6ycQose+vP4beFjGcn9Mp4CAFMnY5oR9iL03YsLBRP4e9ab2RwBFri4tB1EkFzs2E
 1X06mDhUB37AgUveGWMf2KLAajmfMoWO8LN0ppxRSMUgpTcwMMT8inhqsoWVoW3alOEHsp4jdtv
 NCx
X-Received: by 2002:a05:600d:8451:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48a77e4243dmr2565265e9.5.1777322494489; 
 Mon, 27 Apr 2026 13:41:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77b29487sm3919015e9.13.2026.04.27.13.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:41:33 -0700 (PDT)
Message-ID: <c487e70e-e1d5-424c-9626-2c3f5fa4ac7b@linaro.org>
Date: Mon, 27 Apr 2026 22:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/41] hw/i386/x86: free oem_id and oem_table_id on
 finalization
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-15-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-15-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/4/26 21:42, Marc-André Lureau wrote:
> x86_machine_initfn allocates oem_id and oem_table_id via g_strndup,
> but no instance_finalize existed for x86_machine_info, so these
> strings were never freed when the object was destroyed.
> 
> Add x86_machine_finalize to release both fields.
> 
> Fixes: d07b22863b8e ("acpi: Move setters/getters of oem fields to X86MachineState")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/i386/x86.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

