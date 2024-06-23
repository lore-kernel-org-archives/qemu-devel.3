Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B02EC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLRPE-0002uo-Gi; Sun, 23 Jun 2024 13:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRPC-0002pY-RE
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:53:34 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRPB-00055W-BW
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:53:34 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25cc2eb593bso1831406fac.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719165212; x=1719770012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bmAbARxXUVzpLUa6S2wj34DQ1l6iGXplQbYTNPhzX2k=;
 b=I+QiptxBgP4lKnUN0ZwdkgerIkgcHvVke/30b1Qpf8N4P+TO8ZMknbIJgyjnvlsykm
 Ie9O3W32c70PFmrWcQv+EIepdHuv82ZTzXOPFffPsNsCswoqvj5AyiWzs0C7n+izveAJ
 P/JEKM8lrODIjt3vxHEdw8KoOIfJxVL2h7zHDom3GdcOifL7Lwv+k2NHf+s1tuD6RMvx
 szkCrH83vfYHhZispQVbPxmwL3xGbCWygyr8B2bai4/756cmQKBV1Rpbimqq1ZWjKfA7
 uAq69FUlcmT3IczJPtALOriEABI/goTdFVuJzLmcbKD8OwfDYSwVLUNqxs1IKJmA6NAK
 3SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165212; x=1719770012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bmAbARxXUVzpLUa6S2wj34DQ1l6iGXplQbYTNPhzX2k=;
 b=j70Yzq8GkD9ielMi0/s9n9WZDzqRRsjHSlB09SnzVF2/7sy8iqwTXrVFvPrl+kz75u
 8V23pBvZ31DqwhsgTOBQdtrNnPrKV8V2G4QmM6E2V4Lqk7NnKggqPYgb4CCFUh6LDjBW
 4H380qVwgF3dlwQkmqbs7NJMnQ2Mi8PcZfsLwqhI9DezvjDRjFmQaDKHdpkOh6O7rhnJ
 5AtmRKfz0ypp6XA6LxJHR323UVyyp5/3vA6rfFTGtHa82ndW2KaAXpHTKxZdtJ+96XLI
 8NitXkE5gXV242h0GK2srd/Td8OCoZCla4U7bN7nwbGLN0L//h2kLwfS4kHlgkGhsKIf
 UijQ==
X-Gm-Message-State: AOJu0YyXHQ9o4npa2w9lau4KI4jVauhRfwI76Y0b3PmFbaCd4hQQw9M7
 uxpifJh7Lvm+XTEH8jrAikzvkiHSzeuiuaU421bzUoeJSeB3dvmOocDkLHmT4f8=
X-Google-Smtp-Source: AGHT+IG48C0PSB2iqbIE2/aU9mzkOr/D6UJyC+5yNplPPgPbpK2K9d7vx9DHizebnQ/fYI+OkDck0A==
X-Received: by 2002:a05:6870:15cb:b0:254:d276:e0e5 with SMTP id
 586e51a60fabf-25d06e58d98mr2868708fac.46.1719165211654; 
 Sun, 23 Jun 2024 10:53:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7067ff77b73sm787272b3a.219.2024.06.23.10.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 10:53:31 -0700 (PDT)
Message-ID: <c8841c2f-3903-42ee-9bf5-2c74185dc007@linaro.org>
Date: Sun, 23 Jun 2024 10:53:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix building on OpenBSD/powerpc
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 6/22/24 19:03, Brad Smith wrote:
> util: fix building on OpenBSD/powerpc
> 
> Signed-off-by: Brad Smith<brad@comstyle.com>
> ---
>   util/cpuinfo-ppc.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

