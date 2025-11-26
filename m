Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC49D10386
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAE7-00055b-Es; Wed, 26 Nov 2025 02:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOADK-0003wf-Am
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:45:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOADI-0002ar-QE
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:45:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so39065235e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143117; x=1764747917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//qmpbCwmhGXxuoPPel7safhk5zuiFs2066vifb1x0o=;
 b=iugAPMtcD1sF0WTnHH39OJqmY9nT5Tzku2e4jbROKdaeFX7QFUmwZHgHO45e+s9yox
 y1HajrF4VnSXLEvUq8gqEawKs9IBkGNl5rhrv4LCHmmVGYmOs91V+nz7DPfRHes7UN2q
 kbAAE1Lp2GzHvCBN2wtsJisZt4YF3KD5uAo1K2Wd70wcaKW1/mjLy3N01+NREy6i0FyJ
 K6zYwX8i5hnoaSt/N9uOvLompH/iN9hIWbtedbFUMZS7LmmB2zLoHTMiE4iEnQLo60my
 B1z46v6mXWkWYV/qd8W1wQ/2RZPi6N5KTp7n1GK5A6Wv6dPzoHWW8w7nkBomwqGPBKCD
 GRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143117; x=1764747917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//qmpbCwmhGXxuoPPel7safhk5zuiFs2066vifb1x0o=;
 b=MAwlzyWmFfBaPKeuaZE5UmqRopkhvbfl8HEp9y/4K4W7gdJqotQ92gofcb9nedhkiF
 L6Cf+uLvGdwK2kEqNqPCB2jLhpls3eJvDZgqTvgTu0HmkPeMdZ5PjAyWsk3tX3rS5q7y
 F2Bs1o9mlTtw/tYcZsPczS7ha7rtIRCmae2rGPCo6Ftc9B/o95e9OjdZtUfi4Ts7qcdB
 FiMvyHmJ8u7aWm0VTU0LzNJWNnqYSAzGVxZXTvDjnfiAkcIiY3yN71UcsnB6ZCW7kWf6
 lSlhAkxqxh2KRzUA8wFoB6TVveIKITmmUtcExPts+fz85K7IzCfTjbeUjQ9RiOF5nd51
 gx5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTaazOvk8TkL+qnHB5dvXNOyt83paKXLGwI5TFesl0VQ9d1ZFyK+uecD5i4pbwJwq0QtmrDM4fOyZS@nongnu.org
X-Gm-Message-State: AOJu0YwP6uzflDQfz6GaKrlGQEkIod7U7dY71T3e26Z8o0pcA6GGR7Tm
 0kb3btANIsFAUSWWwcYGO9HgFN7vvsKfJhIXvZFD+WRdJBwLd6mFRFV0uhGW9qOsE6s=
X-Gm-Gg: ASbGncs6X4aPy3V9rHS+dockiRL5XRFnC8m1Ak8KqkKT1P+hXguS5gioL0AOHE9Rrd3
 XqYOsFzwHY/pBJOVssPL/ps+F2AFYuk0GNyWVMfCAGqWP2JkTgPQ62mlA4qwhlCMYj/YYXdVMJa
 vkPN3h0qF+1GCBK/5Pf1dD59eLKbj3cp4kA4dC/vnHDhnNGx72mdCEg0+IYNsxgr341+rvrw40P
 /63HXHTcccof8lqogx5BLw+V8LkWeaMp8YUS2w6KsnGpKq3AaOqhPBxGcJgHq5nQsj+X2fHB06b
 s6IiAx+0Lq83TsncBxUzsZjL7IEKgwlXvgfwEKTrYWj1kMQMNGf/uDa7p9Rs9Y36YXp5ovgIHgE
 LxonOBovFJiupU6kZv2/n/mYj57S5sSeOy/CsOuFY2lNXqrT4OpUdi21o0kbzv9ygeQDth5aUZl
 lgnWnqpiIJ9hmWVkchWxBiykTWaLfjSGmSgRXtnuAkvunndQBkWApaow==
X-Google-Smtp-Source: AGHT+IH3668SsjK5hyhZnbWRMQ50zA8+pNa0W+27bkhCxm7P7+p2P0dUOStEhRsKmHLuaMvudCA8mg==
X-Received: by 2002:a05:600c:468c:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-477c01b491dmr151915615e9.21.1764143117525; 
 Tue, 25 Nov 2025 23:45:17 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ade12cesm33528975e9.9.2025.11.25.23.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 23:45:16 -0800 (PST)
Message-ID: <a50b8ccb-4d13-431b-836e-b08e5add71bd@linaro.org>
Date: Wed, 26 Nov 2025 08:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251112134143.27194-1-philmd@linaro.org>
 <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/11/25 07:56, Michael Tokarev wrote:
> On 11/12/25 16:41, Philippe Mathieu-Daudé wrote:
>> v3:
>> - Addressed Marc-André & Daniel comments
>> - Document qemu_chr_fe_write()
>> - Rename replay arguments


> Hi!
> 
>  From this patchset, 1 change has now found its way to the master
> branch:
> 
>   chardev/char-pty: Do not ignore chr_write() failures
> 
> Besides it, the following 2 changes were marked for-stable:
> 
>   chardev/char: Allow partial writes in qemu_chr_write()
>   chardev/char: Preserve %errno in qemu_chr_write()
> 
> Are other changes (including the above 2) not needed anymore?

They are, I need to reply to Marc-André and respin a v4...

Old bugs so can wait 11.0 :S

