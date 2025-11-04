Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A21CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKhR-0005xE-ST; Tue, 04 Nov 2025 12:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKhN-0005rp-Mh
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:20:02 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKhM-00008j-2M
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:20:01 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6407e617ad4so90271a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762276798; x=1762881598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIAY4ElKgmvL72m/DosK8VmaaV8hFDN0PPGvt6NgA6g=;
 b=FpNynusd709iyqy7RhYA6K6GK2VwxR/kQmwyyZylCPLgIeZFbgHaWpTw3l1+uHMsHH
 njBce7ExpMxiMV0AmdaC+VwWCpN5mnRiEbttnnIuoA49g28EI7sw7Vz6Y+H58Yuu75qb
 DZBop7xrpFA+vMtDG22cr/Yx+3AGLnRK2caon9/dt8/p5ZPvJdtDZzOUxJds07R3LWWD
 IAnxvnz8sUsCyFJZdpfKAuUlqKaBNflEAjuErLJdn1xz/3cee6GAeQk1mXSS19vqZYMN
 fJMi2I9Ca3qT8DJZhnUHZWtIvbNyyVM2KtFeXjbUO+PkWnUTDIIG4bI5+RsBS7e3y6//
 eWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276798; x=1762881598;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIAY4ElKgmvL72m/DosK8VmaaV8hFDN0PPGvt6NgA6g=;
 b=SGr3qPCAvVDl9Jp9QxEPpbAFWcP3t6OagNA5WK/H4W3k89EJW2v2AQ4H8STGn5BDs8
 F881CsSJCJ4yGFmzR5zt02IyANSlb1vzjscTYjXIHHchZxCyTrHef2LZpIhF4EcVnyiF
 fQQlqS4t97DfGMnLru5elJORBXiMuJy0BOStHp0zw4Xi5lahsXDi8rfZqV9MibkXIUBg
 CJFsFB5pq0zdynzWm8wbum9K4BSMCOXBpA9oZOfX5f41knRrjkvfMztw3AbgEM9RJ9bv
 DKCYhlELUhrpBchJ+BvhcjopDk7DBLwJGRw9TNM3WAsZtNrEX+Zq8nD6yVDtIJFiKDgW
 by4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKaVnetSh6O3wfxX0wB7MJhKIj4R/SBP0fCAG8uf+l/tQ80o5oMLdHVjtExPoF2QafjxSeEW0dIN7z@nongnu.org
X-Gm-Message-State: AOJu0Yy1s24WrthBG2XimALbZKHQtIvFxx2RcH9EY2AsNapuTKeR11UL
 DQVtS6kdxU0VoipPC+bx4PFhYWInL7hO+WSfpLQ4R0r+HqC3V5AAJpearqItn1D/+rA=
X-Gm-Gg: ASbGncvViH1GV/0GWUSfsp3QcC0LHsIroawTkjpI3CZZSrocmQEIzKOsp1gHyVX/Pws
 BhhKLMYeWkH93Z5y0RmxciklBMCBZE26WQ8F9YSfp2+ZkMsGVWz7G59SsuQZWuHxFKhrRg85a8J
 k6iPUYejVFAFR7+YPpQmihWMFctRJI3NqSrnWcvjXoOW9FuWd5YXcWVAw5APCdSkHXpEEeIbvq5
 n0ZqIkI0ajwLRDOKnBCMI7/aG7gGkvERPeQL0JfUnuOzVILdgqgGsv7vs5d6rBZuBoj8p+wS6bm
 shzIlUD6bdmrW/BObJKxdm8e1mh6Hn+ULTPLp5c5rc/PowRDEQ/oQUWTdWAtgW7QYsGOzl+C+ZL
 c0WOa5F8YhYsln9hEO2MCIXIVAmUpyZ5Gca5ZbOe6a8o5GMRjmyXkE0bMu+/TU4pASiq1dz4Lxy
 UUw2jTNFBoM2NmA+K/EZs=
X-Google-Smtp-Source: AGHT+IFHvXfvfkhjwpRvJLaGp330RHmc6oKVYHccMpksxGQpec8HZVDPiLWvuOKf0lOE0L00IhdCHg==
X-Received: by 2002:a50:ee06:0:b0:640:9611:99d3 with SMTP id
 4fb4d7f45d1cf-640e5a044bbmr2912540a12.18.1762276798472; 
 Tue, 04 Nov 2025 09:19:58 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e68057e8sm2908749a12.13.2025.11.04.09.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 09:19:57 -0800 (PST)
Message-ID: <92164cea-f80f-4235-9946-1ca0621919e7@linaro.org>
Date: Tue, 4 Nov 2025 18:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio: Remove dead code from ac97_realize
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com
References: <20251102231903.65409-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251102231903.65409-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 3/11/25 00:19, Osama Abdelkader wrote:
> Remove unnecessary PCI configuration register initialization that was
> marked with TODO comments indicating it's redundant:
> - PCI_COMMAND register is already 0x00 by default, no need to override
> - PCI_BASE_ADDRESS_0 registers are automatically set by pci_register_bar()
> 
> This aligns the code with the pattern used by other PCI audio devices
> in QEMU (via-ac97, intel-hda, es1370) and removes 15 lines of dead code.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/audio/ac97.c | 19 -------------------
>   1 file changed, 19 deletions(-)

Queued, thanks!

