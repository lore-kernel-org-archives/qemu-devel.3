Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF2F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytoz-00071C-3e; Sat, 07 Mar 2026 10:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytoe-0006sw-R8
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:43:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytod-0002iu-9V
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:43:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso94533485e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898212; x=1773503012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/LPAM6NR38MNq102HuolPgrCH8K0FOPrPnhAAkNhQ8=;
 b=eE50OqjdGahG5E2jwD4mrXbyUIufCzB+dHGwPYfgwliqQ2ISJ26sLjEkvWTm5iPcLe
 50cnlBL46WP3+6TJYlheqkuYqzIZJ21moVk/Jm1HAHfDK1OJDANWMPJXK5IozTLOBHzg
 jX6/UOXsJhPP0MJtyd1ZPKAtrRb5V7DABVWgu7TuynknotY8eepuq1MzAOvQN+6f0p8k
 zCNqYoZAJOPNRtCt7CsXZ4PIUso2IxYU05MEgFGaq0tVHEGmh4yAk5UWUH93doNZ8iZL
 OngbxDELCShuCLFdFhkPuDLgRjpVIVvwIvvUfKH7JiD7Uqr/Bc/7Qq61dgyOOeSWV3iJ
 8LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898212; x=1773503012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/LPAM6NR38MNq102HuolPgrCH8K0FOPrPnhAAkNhQ8=;
 b=RPmYwRYABKW3RcxpuJ51rq9y+fP7e7my5xZQ4QPyyRt+x/bj7iN5OZhIwcX87Q/8Dj
 E+DSdo9OX0W5NgIf0BASBTI58GG5ZMT/Q51qxt38aBb2srJgw7pmt+Wj0z4nflD4n0aI
 nGjp8kjNmDO7KE6X7orXNXHWNCfxd/JCZHpq10KMgXGuW8IMMfBjgVv6TILR7r4gHOBe
 IBje+RvjqFGCchp4Uc5ix9uXC9vubUxlWfbC69Fbncsx55eB7Vkf41GGYgYcs74ffgSa
 iH9BSg6P87GdvJQZLGnmUXE6JTa7KzWKVuHFWU5MLlIhMuPXPimDsjpud5Oma9sllqQu
 I8Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHtqFR84gfruZejAaPwCH1VAGz+t6Aduf/jWbM+gqoLwDIdZWMMcEoip3URV8tYvrM5A1xIlMD1RHb@nongnu.org
X-Gm-Message-State: AOJu0Yy3zDbo2xVIX2WMmZznRxKDkd5MbWu8Q+EsMyjEundWCehpB1L2
 rXtM5314RU3iJ8GlN5dM+wD8kmIo2qKtPKEOJnBudPW7S32V6PGs/9sPwo5mFsWP5E4=
X-Gm-Gg: ATEYQzzpnQBmi0U3kEQ9b2krZn5t1PKV9YYxA2xp3rjfeBmWdPsYZzAuuNOREudWz3h
 yEX43yqATPYMUEK79hTFpN/ATWKNjN2C1wU5f519LKGxwS4ii2MoyBCyNs0fcBTrASXsQfkb5Tg
 CQA6r7xtMO48KGxiFaHATuscSCoYHSpG22f57ilRvo5Vgg3lGBAPwP1fSTnu8LFTp6z+iAho8Xe
 8p+BV0tCzNaR3z6eeOXKrJ+k1GvbfKlLT7Kr1bBcs+i5lH6QKzwzR9/G8pDVmCBQWSgn7ubcjtE
 ouJkZiylqInzyYd2l3Iy7HtptIkNJk8+ZDkK8w3BfV9itQhe14YjIoi61Pgb7K258MdqW3ne8ha
 8qR90IzdPFCQzdVJ0qrA/67MFflj1R1fvz6ftDaXW617zKk/Osk8Jptvs6Yffgf3d5Rms1O5rX1
 bWr3g+mPp3XBrmmCIubvoSwUPJYDfVZcSUVkS6+hPSdS+xqmUZyzsm9d1/BU1SdUs0rg==
X-Received: by 2002:a05:600c:8115:b0:480:52fd:d2e4 with SMTP id
 5b1f17b1804b1-485268bcfb4mr99081715e9.0.1772898212224; 
 Sat, 07 Mar 2026 07:43:32 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276bc6bbsm114588085e9.15.2026.03.07.07.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 07:43:31 -0800 (PST)
Message-ID: <4ddf3218-06ac-44ca-838d-3d17496dd8a2@linaro.org>
Date: Sat, 7 Mar 2026 16:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 10/13] hvf: sync registers used at EL2
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
 <20260307153143.76893-11-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307153143.76893-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/3/26 16:31, Mohamed Mediouni wrote:
> When starting up the VM at EL2, more sysregs are available. Sync the state of those.
> 
> In addition, sync the state of the EL1 physical timer when the vGIC is used, even
> if running at EL1. However, no OS running at EL1 is expected to use those registers.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c        | 61 +++++++++++++++++++++++++++++++++----
>   target/arm/hvf/sysreg.c.inc | 44 ++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

