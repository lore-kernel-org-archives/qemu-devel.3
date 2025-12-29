Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB1D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 00:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1Ya-0005Gn-Ex; Sun, 28 Dec 2025 19:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1YY-0005G1-N0
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:56:18 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1YX-0007J5-B8
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:56:18 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c213f7690so6695562a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766969776; x=1767574576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FpWcickHYla3lIQksrsecKWWuNEntX6tf649/NhpU9U=;
 b=IfvWk5dUWATzvUmpZQxbRKqqEcHN5B13b1c98749G0OcfWpD1vd6ZRLVhIwU4ejL5I
 6WqwYJoutfAq/+0m8MOBszMZS0ovwoWSCBD4D/viQh6uFizqJ56LYy6jH50PB/0NkwOt
 XAly8ir7S7C88zJ7tQp/RHsyoMU8vtl+4/KeIAuY9QOhPpXVqoWqyl1oqnc6J3loVNNk
 pB53tSp0tbTaIFH2YkRz89CzjJs0RIrP9oIOaGa41TgdtBGqySfDgsUF7oLmAgRWMkcr
 7JFkNrKQ0J8G5fVQUR/xswXEDpY/ExrhtbFznbyj2dT8WAFuqSsPTGbdQpegxeIc0v1x
 2VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766969776; x=1767574576;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FpWcickHYla3lIQksrsecKWWuNEntX6tf649/NhpU9U=;
 b=Cxqbv1EOyzMY6v20NF/a2MGFlfgRKSsMkDu6QzwtansoabocxZzebUHiQ4AWzSC1lY
 1bJyLG5F1HQhfnH3b/uaSP7SxjT5lTqCeRQrYu3b9Gs+ryjXhc8xN1LHez1GoJ2bOu3R
 6PZ35CNL26xrEXFLw2l/9+ZwIGwuPD650zkqLb/jUFGw5SQ0DXkv5ZAL7SEPMJKkJepx
 NoTkcDNrUXFyK5JkUy28QwbV1kTSnIxTAS+S1cKkv7O+ja9ixEDNjR/lSNBd8LLmRGve
 qYdk9YupeuRz+1CDzwFwpeW1IPTt5xowRewhIG1/2SrxjLG4rcCqW2t4QkjlcsocX8Di
 zTCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrp/4vOZvbS8AtvMtnGDIcmiL0GXYYVOkxKheHNNn7pjw6/OZCiCF8xbocSDt22iGRYPDaZYZJ67fv@nongnu.org
X-Gm-Message-State: AOJu0YyEA7hJ58c6txikRAqkZWb/PTSTKGi4AciERGeLJdk5uYSsovLz
 A+oouu7t+xlnX/4lTUCVnBhYAVoslCh+isxd4aeQLamehHWgmagVzgXApQCjD8O3CqU=
X-Gm-Gg: AY/fxX4fCYiBBKk/P3aZvJ+QWxrLscDuRJ39EfORTlBMkycir9l31QpWY6XimgDrth9
 NLn7+Ar50uh3KFsjUqkM+DhxXNPZ6jSnRvpv3PDaqWK/CDbcoDO/weQocSKIMhIHg5uB/OJjOGV
 bCSLaEwphTAF/B+N0I0zG7O3S87zcHIJHVwhJCKWZfhOtUBq28ITJulL6TnTpQ614kVlpMLGCGI
 8glxMHaxje+giaR952tmbJjF7zKDikYMliUdTLETOvAgSs78AsXUkL5x/5qFn3HukNP1jUqo0xh
 7TPa3dT/Ttl3Ln0blR+9bOja1EZ9dw8kB+rkT8DzOFK1Pz8kiLIkJic8FPgs/5/14TAd4BZ+R0i
 LYPUmvkjE6jpbt5ulQpJZrw0cmNPoQghsFAn6Km+XVAnUtwZ1mVgxrGqFU5mLEK0Zq1hPNZjj60
 OWEwKTAqZ34ExqC7IL/WkHBhK+D5XXn78csS1KaOAQkW2ltBnXisfqoMeFtpIBVDVOs84jDg==
X-Google-Smtp-Source: AGHT+IF/pRcVH7uyDzbdVNdePvcQyfm4R9qvrenll0CRxWoyk3vGH1+zMRibL5pqtRs8xM6ipIxhCg==
X-Received: by 2002:a05:6a20:e290:b0:35f:6e12:184c with SMTP id
 adf61e73a8af0-376a9ace741mr27118485637.60.1766969775561; 
 Sun, 28 Dec 2025 16:56:15 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e922278a4sm26168358a91.11.2025.12.28.16.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 16:56:15 -0800 (PST)
Message-ID: <722e88ae-3675-4403-93a2-3d2290c57734@linaro.org>
Date: Mon, 29 Dec 2025 11:54:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/25] system/memory: Directly call
 address_space_ldst[M]_internal() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/25/25 02:21, Philippe Mathieu-Daudé wrote:
> Inline internal address_space_ld/st[L,D,Q] helpers,
> directly calling address_space_ldst[M]_internal().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc        | 47 ---------------------------------
>   system/memory_ldst_endian.c.inc | 12 ++++-----
>   2 files changed, 6 insertions(+), 53 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

